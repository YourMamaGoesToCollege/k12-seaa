# Implementation Patterns for K-12 SEAA Workflows

**Document Purpose:** Concrete implementation patterns and code examples for workflow orchestration

**Last Updated:** October 22, 2025

---

## Table of Contents

1. [Application Workflow Patterns](#application-workflow-patterns)
2. [Registration and Enrollment Workflows](#registration-and-enrollment-workflows)
3. [Certification and Verification Workflows](#certification-and-verification-workflows)
4. [Payment and Disbursement Workflows](#payment-and-disbursement-workflows)
5. [Communication Workflows](#communication-workflows)
6. [Error Handling and Compensation](#error-handling-and-compensation)
7. [Testing Workflows](#testing-workflows)

---

## Application Workflow Patterns

### ESA+ Application Processing

**Workflow Characteristics:**
- Long-running (days to weeks)
- Multiple external integrations (RDS, email)
- Human-in-the-loop (document review, approval)
- Multiple decision points
- Compensation required on failure

**Implementation with Durable Functions:**

```csharp
[FunctionName("ESAPlusApplicationOrchestrator")]
public static async Task<ApplicationResult> RunOrchestrator(
    [OrchestrationTrigger] IDurableOrchestrationContext context,
    ILogger log)
{
    var application = context.GetInput<ESAPlusApplication>();
    var result = new ApplicationResult { ApplicationId = application.Id };
    
    try
    {
        // Step 1: Initial validation (synchronous)
        await context.CallActivityAsync("ValidateApplicationData", application);
        await context.CallActivityAsync("UpdateApplicationStatus", 
            new { application.Id, Status = "Validating" });
        
        // Step 2: Parallel verification tasks
        var verificationTasks = new List<Task<VerificationResult>>
        {
            context.CallActivityAsync<VerificationResult>(
                "VerifyResidency", application.StudentId),
            context.CallActivityAsync<VerificationResult>(
                "ValidateDisabilityDocumentation", application),
            context.CallActivityAsync<VerificationResult>(
                "VerifyLEARelease", application)
        };
        
        var verificationResults = await Task.WhenAll(verificationTasks);
        
        // Check if any verification failed
        if (verificationResults.Any(r => !r.IsValid))
        {
            await context.CallActivityAsync("SendVerificationFailureNotification", 
                new { application, Results = verificationResults });
            result.Status = ApplicationStatus.Rejected;
            result.RejectionReason = "Failed verification checks";
            return result;
        }
        
        // Step 3: Request additional documents if needed
        var documentsNeeded = await context.CallActivityAsync<List<string>>(
            "DetermineRequiredDocuments", application);
        
        if (documentsNeeded.Any())
        {
            await context.CallActivityAsync("SendDocumentRequestNotification", 
                new { application, Documents = documentsNeeded });
            await context.CallActivityAsync("UpdateApplicationStatus", 
                new { application.Id, Status = "AwaitingDocuments" });
            
            // Wait for documents to be uploaded (max 30 days)
            var documentUploadEvent = context.WaitForExternalEvent<DocumentUploadedEvent>(
                "DocumentsUploaded");
            var reminderTimer = context.CreateTimer(
                context.CurrentUtcDateTime.AddDays(14), CancellationToken.None);
            var timeoutTimer = context.CreateTimer(
                context.CurrentUtcDateTime.AddDays(30), CancellationToken.None);
            
            var completedTask = await Task.WhenAny(
                documentUploadEvent, reminderTimer, timeoutTimer);
            
            if (completedTask == reminderTimer)
            {
                // Send reminder and keep waiting
                await context.CallActivityAsync("SendDocumentReminder", application);
                await Task.WhenAny(documentUploadEvent, timeoutTimer);
            }
            
            if (completedTask == timeoutTimer || !context.IsReplaying)
            {
                // Timeout - mark as incomplete
                result.Status = ApplicationStatus.IncompleteTimeout;
                await context.CallActivityAsync("UpdateApplicationStatus", 
                    new { application.Id, Status = "IncompleteTimeout" });
                return result;
            }
        }
        
        // Step 4: Admin review
        await context.CallActivityAsync("UpdateApplicationStatus", 
            new { application.Id, Status = "UnderReview" });
        await context.CallActivityAsync("AssignToReviewer", application);
        await context.CallActivityAsync("SendReviewerNotification", application);
        
        // Wait for admin decision
        var reviewDecision = await context.WaitForExternalEvent<ReviewDecision>(
            "AdminReviewCompleted",
            timeout: TimeSpan.FromDays(7));
        
        if (reviewDecision.Approved)
        {
            // Step 5: Create award
            var award = await context.CallActivityAsync<Award>(
                "CreateAward", application);
            
            result.AwardId = award.Id;
            result.Status = ApplicationStatus.Approved;
            
            // Step 6: Send approval notification
            await context.CallActivityAsync("SendApprovalNotification", 
                new { application, award });
            
            // Step 7: Wait for award acceptance
            await context.CallActivityAsync("UpdateApplicationStatus", 
                new { application.Id, Status = "AwaitingAcceptance" });
            
            var acceptanceEvent = await context.WaitForExternalEvent<AwardAcceptanceEvent>(
                "AwardAccepted",
                timeout: TimeSpan.FromDays(30));
            
            if (acceptanceEvent.Accepted)
            {
                result.Status = ApplicationStatus.AwardAccepted;
            }
            else
            {
                result.Status = ApplicationStatus.AwardDeclined;
            }
        }
        else
        {
            // Rejected
            result.Status = ApplicationStatus.Rejected;
            result.RejectionReason = reviewDecision.Reason;
            
            await context.CallActivityAsync("SendRejectionNotification", 
                new { application, Reason = reviewDecision.Reason });
        }
        
        return result;
    }
    catch (Exception ex)
    {
        log.LogError(ex, "Error processing application {ApplicationId}", application.Id);
        
        // Compensation: mark application as failed
        await context.CallActivityAsync("UpdateApplicationStatus", 
            new { application.Id, Status = "Failed", Error = ex.Message });
        
        result.Status = ApplicationStatus.Failed;
        result.Error = ex.Message;
        return result;
    }
}

// Activity Functions
[FunctionName("VerifyResidency")]
public static async Task<VerificationResult> VerifyResidency(
    [ActivityTrigger] Guid studentId,
    [Inject] IRdsClient rdsClient,
    ILogger log)
{
    log.LogInformation("Verifying residency for student {StudentId}", studentId);
    
    try
    {
        var result = await rdsClient.VerifyResidencyAsync(studentId);
        return new VerificationResult
        {
            IsValid = result.IsResident,
            VerificationType = "Residency",
            Details = result.Details
        };
    }
    catch (Exception ex)
    {
        log.LogError(ex, "Failed to verify residency for student {StudentId}", studentId);
        return new VerificationResult
        {
            IsValid = false,
            VerificationType = "Residency",
            Error = ex.Message
        };
    }
}

[FunctionName("CreateAward")]
public static async Task<Award> CreateAward(
    [ActivityTrigger] ESAPlusApplication application,
    [Inject] IAwardService awardService,
    [Inject] IEventPublisher eventPublisher,
    ILogger log)
{
    log.LogInformation("Creating award for application {ApplicationId}", application.Id);
    
    var award = await awardService.CreateAwardAsync(new CreateAwardRequest
    {
        ApplicationId = application.Id,
        StudentId = application.StudentId,
        ProgramType = "ESA+",
        Amount = application.RequestedAmount,
        AcademicYear = application.AcademicYear
    });
    
    // Publish domain event
    await eventPublisher.PublishAsync(new AwardCreatedEvent
    {
        AwardId = award.Id,
        ApplicationId = application.Id,
        StudentId = application.StudentId,
        Amount = award.Amount,
        ProgramType = "ESA+",
        CreatedAt = DateTime.UtcNow
    });
    
    log.LogInformation("Award {AwardId} created for application {ApplicationId}", 
        award.Id, application.Id);
    
    return award;
}
```

### Opportunity Scholarship Application Processing

**Key Differences from ESA+:**
- Income verification instead of disability documentation
- Lottery/priority system for awards
- Different document requirements

```csharp
[FunctionName("OpportunityScholarshipOrchestrator")]
public static async Task<ApplicationResult> RunOrchestrator(
    [OrchestrationTrigger] IDurableOrchestrationContext context,
    ILogger log)
{
    var application = context.GetInput<OpportunityScholarshipApplication>();
    
    // Step 1: Validate application
    await context.CallActivityAsync("ValidateApplicationData", application);
    
    // Step 2: Verify income documentation
    var incomeVerified = await context.CallActivityAsync<bool>(
        "VerifyIncomeDocumentation", application);
    
    if (!incomeVerified)
    {
        await context.CallActivityAsync("SendIncomeVerificationFailure", application);
        return new ApplicationResult 
        { 
            ApplicationId = application.Id,
            Status = ApplicationStatus.Rejected,
            RejectionReason = "Income verification failed"
        };
    }
    
    // Step 3: Verify residency
    var residencyResult = await context.CallActivityAsync<VerificationResult>(
        "VerifyResidency", application.StudentId);
    
    if (!residencyResult.IsValid)
    {
        await context.CallActivityAsync("SendResidencyVerificationFailure", application);
        return new ApplicationResult 
        { 
            ApplicationId = application.Id,
            Status = ApplicationStatus.Rejected,
            RejectionReason = "Residency verification failed"
        };
    }
    
    // Step 4: Check age/grade eligibility
    var ageEligible = await context.CallActivityAsync<bool>(
        "CheckAgeEligibility", application);
    
    if (!ageEligible)
    {
        await context.CallActivityAsync("SendAgeIneligibilityNotification", application);
        return new ApplicationResult 
        { 
            ApplicationId = application.Id,
            Status = ApplicationStatus.Rejected,
            RejectionReason = "Age/grade not eligible"
        };
    }
    
    // Step 5: Mark application as eligible for lottery
    await context.CallActivityAsync("MarkEligibleForLottery", application);
    
    // Step 6: Wait for lottery results (event-driven)
    var lotteryResult = await context.WaitForExternalEvent<LotteryResult>(
        "LotteryCompleted");
    
    if (lotteryResult.Awarded)
    {
        // Create award
        var award = await context.CallActivityAsync<Award>(
            "CreateAward", application);
        
        await context.CallActivityAsync("SendAwardNotification", 
            new { application, award });
        
        return new ApplicationResult
        {
            ApplicationId = application.Id,
            AwardId = award.Id,
            Status = ApplicationStatus.Approved
        };
    }
    else
    {
        // Waitlisted or not selected
        await context.CallActivityAsync("SendWaitlistNotification", application);
        
        return new ApplicationResult
        {
            ApplicationId = application.Id,
            Status = ApplicationStatus.Waitlisted
        };
    }
}
```

---

## Registration and Enrollment Workflows

### Provider Enrollment with Elsa Workflows

**Workflow Definition:**

```csharp
public class ProviderEnrollmentWorkflow : WorkflowBase
{
    protected override void Build(IWorkflowBuilder builder)
    {
        builder
            .WithId("provider-enrollment")
            .WithVersion(1)
            .WithDescription("Provider enrollment and certification workflow")
            
            // Step 1: Receive application
            .StartWith<ReceiveProviderApplicationActivity>()
                .WithName("ReceiveApplication")
                .Output(x => x.SetVariable("ProviderApplication", x.GetInput<ProviderApplication>()))
            
            // Step 2: Validate credentials
            .Then<ValidateProviderCredentialsActivity>()
                .WithName("ValidateCredentials")
                .Input(x => x.GetVariable<ProviderApplication>("ProviderApplication"))
                .Output(x => x.SetVariable("CredentialsValid", x.GetOutput<bool>()))
            
            // Decision: Credentials valid?
            .If(x => x.GetVariable<bool>("CredentialsValid"))
                .Then(valid => valid
                    // Step 3: Request background check
                    .StartWith<RequestBackgroundCheckActivity>()
                        .WithName("RequestBackgroundCheck")
                        .Input(x => x.GetVariable<ProviderApplication>("ProviderApplication"))
                    
                    // Step 4: Wait for background check (async)
                    .Then<WaitForBackgroundCheckActivity>()
                        .WithName("WaitForBackgroundCheck")
                        .Input(x => x.GetVariable<ProviderApplication>("ProviderApplication"))
                        .Output(x => x.SetVariable("BackgroundCheckResult", 
                            x.GetOutput<BackgroundCheckResult>()))
                    
                    // Decision: Background check passed?
                    .If(x => x.GetVariable<BackgroundCheckResult>("BackgroundCheckResult").Passed)
                        .Then(passed => passed
                            // Step 5: Schedule interview
                            .StartWith<ScheduleInterviewActivity>()
                                .WithName("ScheduleInterview")
                                .Input(x => x.GetVariable<ProviderApplication>("ProviderApplication"))
                            
                            // Step 6: Wait for interview completion
                            .Then<WaitForInterviewCompletionActivity>()
                                .WithName("WaitForInterviewCompletion")
                                .Output(x => x.SetVariable("InterviewScore", 
                                    x.GetOutput<int>()))
                            
                            // Decision: Interview passed?
                            .If(x => x.GetVariable<int>("InterviewScore") >= 70)
                                .Then(approved => approved
                                    // Approve provider
                                    .StartWith<ApproveProviderActivity>()
                                        .WithName("ApproveProvider")
                                        .Input(x => x.GetVariable<ProviderApplication>("ProviderApplication"))
                                    
                                    // Add to directory
                                    .Then<AddToProviderDirectoryActivity>()
                                        .WithName("AddToDirectory")
                                        .Input(x => x.GetVariable<ProviderApplication>("ProviderApplication"))
                                    
                                    // Send approval email
                                    .Then<SendEmailActivity>()
                                        .WithName("SendApprovalEmail")
                                        .Input(x => new EmailRequest
                                        {
                                            To = x.GetVariable<ProviderApplication>("ProviderApplication").Email,
                                            Template = "ProviderApproved",
                                            Data = x.GetVariable<ProviderApplication>("ProviderApplication")
                                        })
                                    
                                    // Schedule annual renewal
                                    .Then<ScheduleRenewalActivity>()
                                        .WithName("ScheduleRenewal")
                                        .Input(x => x.GetVariable<ProviderApplication>("ProviderApplication"))
                                )
                                .Else(rejected => rejected
                                    // Reject: Interview failed
                                    .StartWith<RejectProviderActivity>()
                                        .WithName("RejectProvider_Interview")
                                        .Input(x => new RejectionRequest
                                        {
                                            Application = x.GetVariable<ProviderApplication>("ProviderApplication"),
                                            Reason = "Interview score below threshold"
                                        })
                                    
                                    .Then<SendEmailActivity>()
                                        .WithName("SendInterviewRejectionEmail")
                                )
                        )
                        .Else(failed => failed
                            // Reject: Background check failed
                            .StartWith<RejectProviderActivity>()
                                .WithName("RejectProvider_BackgroundCheck")
                                .Input(x => new RejectionRequest
                                {
                                    Application = x.GetVariable<ProviderApplication>("ProviderApplication"),
                                    Reason = "Background check did not pass"
                                })
                            
                            .Then<SendEmailActivity>()
                                .WithName("SendBackgroundCheckRejectionEmail")
                        )
                )
                .Else(invalid => invalid
                    // Reject: Invalid credentials
                    .StartWith<RejectProviderActivity>()
                        .WithName("RejectProvider_Credentials")
                        .Input(x => new RejectionRequest
                        {
                            Application = x.GetVariable<ProviderApplication>("ProviderApplication"),
                            Reason = "Credentials validation failed"
                        })
                    
                    .Then<SendEmailActivity>()
                        .WithName("SendCredentialRejectionEmail")
                )
            
            // Final step: Complete workflow
            .Then<CompleteWorkflowActivity>()
                .WithName("CompleteWorkflow");
    }
}

// Custom Activities
public class WaitForBackgroundCheckActivity : Activity
{
    private readonly IBackgroundCheckService _backgroundCheckService;
    
    public WaitForBackgroundCheckActivity(IBackgroundCheckService backgroundCheckService)
    {
        _backgroundCheckService = backgroundCheckService;
    }
    
    protected override async ValueTask<IActivityExecutionResult> 
        OnExecuteAsync(ActivityExecutionContext context)
    {
        var application = context.GetInput<ProviderApplication>();
        
        // Check if background check already completed
        var existingResult = await _backgroundCheckService
            .GetBackgroundCheckResultAsync(application.ProviderId);
        
        if (existingResult != null)
        {
            context.SetOutput(existingResult);
            return Done();
        }
        
        // Suspend workflow until background check completes
        // (External system will trigger event when complete)
        return Suspend();
    }
}

public class ScheduleRenewalActivity : Activity
{
    private readonly IRenewalScheduler _renewalScheduler;
    
    protected override async ValueTask<IActivityExecutionResult> 
        OnExecuteAsync(ActivityExecutionContext context)
    {
        var application = context.GetInput<ProviderApplication>();
        
        // Schedule renewal for 1 year from now
        var renewalDate = DateTime.UtcNow.AddYears(1);
        
        await _renewalScheduler.ScheduleRenewalAsync(
            providerId: application.ProviderId,
            renewalDate: renewalDate,
            reminderDates: new[]
            {
                renewalDate.AddDays(-30), // 30 days before
                renewalDate.AddDays(-14), // 14 days before
                renewalDate.AddDays(-7)   // 7 days before
            });
        
        return Done();
    }
}

// Starting the workflow
public class ProviderEnrollmentService
{
    private readonly IWorkflowInvoker _workflowInvoker;
    
    public async Task<string> EnrollProviderAsync(ProviderApplication application)
    {
        var workflowInstance = await _workflowInvoker.StartWorkflowAsync(
            workflowId: "provider-enrollment",
            version: 1,
            input: application);
        
        return workflowInstance.Id;
    }
    
    public async Task ResumeBackgroundCheckAsync(Guid providerId, BackgroundCheckResult result)
    {
        // Resume suspended workflow when background check completes
        await _workflowInvoker.TriggerSignalAsync(
            workflowInstanceId: $"provider_{providerId}",
            signalName: "BackgroundCheckCompleted",
            input: result);
    }
}
```

---

## Certification and Verification Workflows

### Annual School Certification

```csharp
[FunctionName("SchoolCertificationOrchestrator")]
public static async Task RunOrchestrator(
    [OrchestrationTrigger] IDurableOrchestrationContext context,
    ILogger log)
{
    var certificationRequest = context.GetInput<SchoolCertificationRequest>();
    
    // Step 1: Send certification request to school
    await context.CallActivityAsync("SendCertificationRequest", certificationRequest);
    
    // Step 2: Wait for school to submit certification (max 30 days)
    var reminderSchedule = new[] { 14, 21, 28 }; // Days when reminders sent
    var currentDay = 0;
    var certificationSubmitted = false;
    SchoolCertificationSubmission submission = null;
    
    while (currentDay < 30 && !certificationSubmitted)
    {
        var waitDays = reminderSchedule
            .Where(d => d > currentDay)
            .DefaultIfEmpty(30)
            .First() - currentDay;
        
        var submissionTask = context.WaitForExternalEvent<SchoolCertificationSubmission>(
            "CertificationSubmitted");
        var timerTask = context.CreateTimer(
            context.CurrentUtcDateTime.AddDays(waitDays),
            CancellationToken.None);
        
        var completedTask = await Task.WhenAny(submissionTask, timerTask);
        
        if (completedTask == submissionTask)
        {
            submission = await submissionTask;
            certificationSubmitted = true;
        }
        else
        {
            currentDay += waitDays;
            
            if (currentDay < 30)
            {
                // Send reminder
                await context.CallActivityAsync("SendCertificationReminder", 
                    new { certificationRequest, DaysRemaining = 30 - currentDay });
            }
        }
    }
    
    if (!certificationSubmitted)
    {
        // Deadline passed without submission
        await context.CallActivityAsync("MarkSchoolNonCompliant", certificationRequest);
        await context.CallActivityAsync("SendNonComplianceNotification", certificationRequest);
        return;
    }
    
    // Step 3: Validate certification data
    var validationResult = await context.CallActivityAsync<ValidationResult>(
        "ValidateCertificationData", submission);
    
    if (!validationResult.IsValid)
    {
        // Request clarification
        await context.CallActivityAsync("RequestCertificationClarification", 
            new { submission, validationResult });
        
        // Wait for resubmission
        var resubmission = await context.WaitForExternalEvent<SchoolCertificationSubmission>(
            "CertificationResubmitted",
            timeout: TimeSpan.FromDays(7));
        
        if (resubmission == null)
        {
            // No resubmission within deadline
            await context.CallActivityAsync("RejectCertification", 
                new { certificationRequest, Reason = "Failed to resubmit after clarification request" });
            return;
        }
        
        submission = resubmission;
    }
    
    // Step 4: Approve certification
    await context.CallActivityAsync("ApproveCertification", submission);
    await context.CallActivityAsync("SendCertificationApprovalNotification", submission);
    
    // Step 5: Mark school as compliant for the year
    await context.CallActivityAsync("MarkSchoolCompliant", certificationRequest);
    
    log.LogInformation("School certification completed for school {SchoolId}", 
        certificationRequest.SchoolId);
}
```

---

## Payment and Disbursement Workflows

### School Payment Processing

```csharp
[FunctionName("SchoolPaymentOrchestrator")]
public static async Task<PaymentResult> RunOrchestrator(
    [OrchestrationTrigger] IDurableOrchestrationContext context,
    ILogger log)
{
    var paymentRequest = context.GetInput<SchoolPaymentRequest>();
    var result = new PaymentResult { PaymentId = paymentRequest.PaymentId };
    
    try
    {
        // Step 1: Validate payment request
        var validationResult = await context.CallActivityAsync<ValidationResult>(
            "ValidatePaymentRequest", paymentRequest);
        
        if (!validationResult.IsValid)
        {
            result.Status = PaymentStatus.ValidationFailed;
            result.Error = validationResult.Error;
            return result;
        }
        
        // Step 2: Check parent endorsement
        var endorsementValid = await context.CallActivityAsync<bool>(
            "CheckParentEndorsement", paymentRequest);
        
        if (!endorsementValid)
        {
            // Wait for endorsement (max 14 days)
            await context.CallActivityAsync("RequestParentEndorsement", paymentRequest);
            
            var endorsementReceived = await context.WaitForExternalEvent<bool>(
                "EndorsementReceived",
                timeout: TimeSpan.FromDays(14));
            
            if (!endorsementReceived)
            {
                result.Status = PaymentStatus.MissingEndorsement;
                result.Error = "Parent endorsement not received within deadline";
                return result;
            }
        }
        
        // Step 3: Verify school certification
        var schoolCertified = await context.CallActivityAsync<bool>(
            "VerifySchoolCertification", paymentRequest.SchoolId);
        
        if (!schoolCertified)
        {
            result.Status = PaymentStatus.SchoolNotCertified;
            result.Error = "School certification is not current";
            return result;
        }
        
        // Step 4: Calculate payment amount
        var paymentAmount = await context.CallActivityAsync<PaymentCalculation>(
            "CalculatePaymentAmount", paymentRequest);
        
        // Step 5: Reserve funds from award
        var fundsReserved = await context.CallActivityAsync<bool>(
            "ReserveFunds", new { paymentRequest.AwardId, paymentAmount.Amount });
        
        if (!fundsReserved)
        {
            result.Status = PaymentStatus.InsufficientFunds;
            result.Error = "Insufficient funds in award";
            return result;
        }
        
        try
        {
            // Step 6: Process payment to school
            var paymentProcessed = await context.CallActivityAsync<PaymentProcessingResult>(
                "ProcessPaymentToSchool", new
                {
                    paymentRequest.PaymentId,
                    paymentRequest.SchoolId,
                    paymentAmount.Amount,
                    paymentRequest.AwardId
                });
            
            if (!paymentProcessed.Success)
            {
                // Compensation: Unreserve funds
                await context.CallActivityAsync("UnreserveFunds", 
                    new { paymentRequest.AwardId, paymentAmount.Amount });
                
                result.Status = PaymentStatus.ProcessingFailed;
                result.Error = paymentProcessed.Error;
                return result;
            }
            
            // Step 7: Record transaction
            await context.CallActivityAsync("RecordTransaction", new
            {
                paymentRequest.PaymentId,
                paymentRequest.AwardId,
                paymentAmount.Amount,
                paymentRequest.SchoolId,
                TransactionType = "SchoolPayment",
                TransactionDate = context.CurrentUtcDateTime
            });
            
            // Step 8: Send notifications
            await context.CallActivityAsync("SendPaymentConfirmationToParent", paymentRequest);
            await context.CallActivityAsync("SendPaymentConfirmationToSchool", paymentRequest);
            
            // Step 9: Publish domain event
            await context.CallActivityAsync("PublishPaymentCompletedEvent", new
            {
                paymentRequest.PaymentId,
                paymentRequest.AwardId,
                paymentAmount.Amount,
                CompletedAt = context.CurrentUtcDateTime
            });
            
            result.Status = PaymentStatus.Completed;
            result.Amount = paymentAmount.Amount;
            result.TransactionId = paymentProcessed.TransactionId;
            
            log.LogInformation("Payment {PaymentId} completed successfully", 
                paymentRequest.PaymentId);
            
            return result;
        }
        catch (Exception ex)
        {
            log.LogError(ex, "Error processing payment {PaymentId}", paymentRequest.PaymentId);
            
            // Compensation: Unreserve funds
            await context.CallActivityAsync("UnreserveFunds", 
                new { paymentRequest.AwardId, paymentAmount.Amount });
            
            throw;
        }
    }
    catch (Exception ex)
    {
        log.LogError(ex, "Payment orchestration failed for {PaymentId}", 
            paymentRequest.PaymentId);
        
        result.Status = PaymentStatus.Failed;
        result.Error = ex.Message;
        return result;
    }
}
```

### ClassWallet Disbursement (ESA+)

**Using MassTransit Saga for distributed transaction:**

```csharp
public class ClassWalletDisbursementSaga : MassTransitStateMachine<ClassWalletDisbursementState>
{
    public ClassWalletDisbursementSaga()
    {
        InstanceState(x => x.CurrentState);
        
        Event(() => DisbursementInitiated, x => 
            x.CorrelateById(context => context.Message.DisbursementId));
        Event(() => FundsReserved, x => 
            x.CorrelateById(context => context.Message.DisbursementId));
        Event(() => ClassWalletTransferCompleted, x => 
            x.CorrelateById(context => context.Message.DisbursementId));
        Event(() => ClassWalletTransferFailed, x => 
            x.CorrelateById(context => context.Message.DisbursementId));
        
        // Initial state: Disburse funds initiated
        Initially(
            When(DisbursementInitiated)
                .Then(context =>
                {
                    context.Instance.AwardId = context.Data.AwardId;
                    context.Instance.Amount = context.Data.Amount;
                    context.Instance.InitiatedAt = DateTime.UtcNow;
                })
                .TransitionTo(ReservingFunds)
                .Publish(context => new ReserveFundsCommand
                {
                    DisbursementId = context.Instance.CorrelationId,
                    AwardId = context.Data.AwardId,
                    Amount = context.Data.Amount
                })
        );
        
        // Reserving funds state
        During(ReservingFunds,
            When(FundsReserved)
                .TransitionTo(TransferringToClassWallet)
                .Publish(context => new TransferToClassWalletCommand
                {
                    DisbursementId = context.Instance.CorrelationId,
                    AwardId = context.Instance.AwardId,
                    Amount = context.Instance.Amount,
                    StudentId = context.Data.StudentId
                }),
            When(FundsReservationFailed)
                .TransitionTo(Failed)
                .Publish(context => new DisbursementFailedEvent
                {
                    DisbursementId = context.Instance.CorrelationId,
                    Reason = "Insufficient funds in award"
                })
        );
        
        // Transferring to ClassWallet state
        During(TransferringToClassWallet,
            When(ClassWalletTransferCompleted)
                .Then(context =>
                {
                    context.Instance.ClassWalletTransactionId = context.Data.TransactionId;
                    context.Instance.CompletedAt = DateTime.UtcNow;
                })
                .TransitionTo(Completed)
                .Publish(context => new DisbursementCompletedEvent
                {
                    DisbursementId = context.Instance.CorrelationId,
                    AwardId = context.Instance.AwardId,
                    Amount = context.Instance.Amount,
                    ClassWalletTransactionId = context.Instance.ClassWalletTransactionId
                })
                .Finalize(),
            
            When(ClassWalletTransferFailed)
                .TransitionTo(CompensatingFundReservation)
                // Compensation: Unreserve funds
                .Publish(context => new UnreserveFundsCommand
                {
                    DisbursementId = context.Instance.CorrelationId,
                    AwardId = context.Instance.AwardId,
                    Amount = context.Instance.Amount
                })
        );
        
        // Compensating fund reservation
        During(CompensatingFundReservation,
            When(FundsUnreserved)
                .TransitionTo(Failed)
                .Publish(context => new DisbursementFailedEvent
                {
                    DisbursementId = context.Instance.CorrelationId,
                    Reason = "ClassWallet transfer failed"
                })
        );
        
        SetCompletedWhenFinalized();
    }
    
    public State ReservingFunds { get; private set; }
    public State TransferringToClassWallet { get; private set; }
    public State CompensatingFundReservation { get; private set; }
    public State Failed { get; private set; }
    public State Completed { get; private set; }
    
    public Event<DisbursementInitiatedEvent> DisbursementInitiated { get; private set; }
    public Event<FundsReservedEvent> FundsReserved { get; private set; }
    public Event<FundsReservationFailedEvent> FundsReservationFailed { get; private set; }
    public Event<ClassWalletTransferCompletedEvent> ClassWalletTransferCompleted { get; private set; }
    public Event<ClassWalletTransferFailedEvent> ClassWalletTransferFailed { get; private set; }
    public Event<FundsUnreservedEvent> FundsUnreserved { get; private set; }
}

public class ClassWalletDisbursementState : SagaStateMachineInstance
{
    public Guid CorrelationId { get; set; }
    public string CurrentState { get; set; }
    public Guid AwardId { get; set; }
    public decimal Amount { get; set; }
    public string ClassWalletTransactionId { get; set; }
    public DateTime InitiatedAt { get; set; }
    public DateTime? CompletedAt { get; set; }
}
```

---

## Communication Workflows

### Email Notification Workflow

```csharp
[FunctionName("SendEmailNotification")]
public static async Task SendEmailNotification(
    [ActivityTrigger] EmailNotificationRequest request,
    [Inject] IEmailService emailService,
    [Inject] ITemplateService templateService,
    ILogger log)
{
    log.LogInformation("Sending email notification: {NotificationType}", 
        request.NotificationType);
    
    try
    {
        // Get email template
        var template = await templateService.GetTemplateAsync(request.TemplateName);
        
        // Render template with data
        var renderedContent = await templateService.RenderAsync(template, request.Data);
        
        // Send email
        var result = await emailService.SendEmailAsync(new EmailRequest
        {
            To = request.RecipientEmail,
            Subject = request.Subject,
            HtmlContent = renderedContent,
            TrackingEnabled = true
        });
        
        log.LogInformation("Email sent successfully. MessageId: {MessageId}", result.MessageId);
    }
    catch (Exception ex)
    {
        log.LogError(ex, "Failed to send email notification: {NotificationType}", 
            request.NotificationType);
        throw;
    }
}

// Bulk notification campaign
[FunctionName("NotificationCampaignOrchestrator")]
public static async Task RunOrchestrator(
    [OrchestrationTrigger] IDurableOrchestrationContext context,
    ILogger log)
{
    var campaign = context.GetInput<NotificationCampaign>();
    
    // Step 1: Get recipient list
    var recipients = await context.CallActivityAsync<List<Recipient>>(
        "GetCampaignRecipients", campaign);
    
    log.LogInformation("Sending campaign {CampaignId} to {RecipientCount} recipients",
        campaign.Id, recipients.Count);
    
    // Step 2: Send emails in batches (fan-out/fan-in pattern)
    var batchSize = 100;
    var batches = recipients
        .Select((r, i) => new { Recipient = r, Index = i })
        .GroupBy(x => x.Index / batchSize)
        .Select(g => g.Select(x => x.Recipient).ToList())
        .ToList();
    
    var sendTasks = new List<Task>();
    
    foreach (var batch in batches)
    {
        var batchTasks = batch.Select(recipient => 
            context.CallActivityAsync("SendEmailNotification", new EmailNotificationRequest
            {
                RecipientEmail = recipient.Email,
                TemplateName = campaign.TemplateName,
                Subject = campaign.Subject,
                Data = new
                {
                    RecipientName = recipient.Name,
                    CampaignData = campaign.Data
                },
                NotificationType = campaign.Type
            }));
        
        sendTasks.AddRange(batchTasks);
        
        // Rate limiting: Wait between batches
        if (batches.IndexOf(batch) < batches.Count - 1)
        {
            await context.CreateTimer(
                context.CurrentUtcDateTime.AddSeconds(2),
                CancellationToken.None);
        }
    }
    
    // Wait for all emails to be sent
    await Task.WhenAll(sendTasks);
    
    // Step 3: Record campaign completion
    await context.CallActivityAsync("RecordCampaignCompletion", new
    {
        campaign.Id,
        RecipientCount = recipients.Count,
        CompletedAt = context.CurrentUtcDateTime
    });
    
    log.LogInformation("Campaign {CampaignId} completed", campaign.Id);
}
```

---

## Error Handling and Compensation

### Retry Policies

```csharp
public class WorkflowRetryPolicies
{
    public static RetryOptions GetDefaultRetryPolicy()
    {
        return new RetryOptions(
            firstRetryInterval: TimeSpan.FromSeconds(5),
            maxNumberOfAttempts: 3)
        {
            BackoffCoefficient = 2.0,
            MaxRetryInterval = TimeSpan.FromMinutes(5),
            RetryTimeout = TimeSpan.FromHours(1)
        };
    }
    
    public static RetryOptions GetExternalServiceRetryPolicy()
    {
        return new RetryOptions(
            firstRetryInterval: TimeSpan.FromSeconds(10),
            maxNumberOfAttempts: 5)
        {
            BackoffCoefficient = 2.0,
            MaxRetryInterval = TimeSpan.FromMinutes(10),
            RetryTimeout = TimeSpan.FromHours(2),
            Handle = ex => ex is HttpRequestException || ex is TimeoutException
        };
    }
}

// Using retry policy
[FunctionName("ApplicationProcessingOrchestrator")]
public static async Task RunOrchestrator(
    [OrchestrationTrigger] IDurableOrchestrationContext context)
{
    var application = context.GetInput<Application>();
    
    // Call activity with retry policy
    var residencyResult = await context.CallActivityWithRetryAsync<VerificationResult>(
        "VerifyResidency",
        WorkflowRetryPolicies.GetExternalServiceRetryPolicy(),
        application.StudentId);
}
```

### Compensation Pattern

```csharp
[FunctionName("PaymentOrchestratorWithCompensation")]
public static async Task<PaymentResult> RunOrchestrator(
    [OrchestrationTrigger] IDurableOrchestrationContext context,
    ILogger log)
{
    var paymentRequest = context.GetInput<PaymentRequest>();
    var compensationActions = new Stack<Func<Task>>();
    
    try
    {
        // Step 1: Reserve funds
        await context.CallActivityAsync("ReserveFunds", paymentRequest);
        compensationActions.Push(async () => 
            await context.CallActivityAsync("UnreserveFunds", paymentRequest));
        
        // Step 2: Create transaction record
        var transactionId = await context.CallActivityAsync<Guid>(
            "CreateTransactionRecord", paymentRequest);
        compensationActions.Push(async () => 
            await context.CallActivityAsync("DeleteTransactionRecord", transactionId));
        
        // Step 3: Process payment
        await context.CallActivityAsync("ProcessPayment", paymentRequest);
        compensationActions.Push(async () => 
            await context.CallActivityAsync("RefundPayment", paymentRequest));
        
        // Step 4: Send notification
        await context.CallActivityAsync("SendPaymentNotification", paymentRequest);
        
        // Success - no compensation needed
        return new PaymentResult
        {
            Success = true,
            TransactionId = transactionId
        };
    }
    catch (Exception ex)
    {
        log.LogError(ex, "Payment failed, executing compensation actions");
        
        // Execute compensation in reverse order
        while (compensationActions.Count > 0)
        {
            var compensationAction = compensationActions.Pop();
            try
            {
                await compensationAction();
            }
            catch (Exception compEx)
            {
                log.LogError(compEx, "Compensation action failed");
            }
        }
        
        return new PaymentResult
        {
            Success = false,
            Error = ex.Message
        };
    }
}
```

---

## Testing Workflows

### Unit Testing Durable Functions

```csharp
public class ApplicationOrchestratorTests
{
    [Fact]
    public async Task ApplicationOrchestrator_ValidApplication_CreatesAward()
    {
        // Arrange
        var context = new Mock<IDurableOrchestrationContext>();
        var application = new ESAPlusApplication
        {
            Id = Guid.NewGuid(),
            StudentId = Guid.NewGuid()
        };
        
        context.Setup(x => x.GetInput<ESAPlusApplication>()).Returns(application);
        
        // Mock activity calls
        context.Setup(x => x.CallActivityAsync("ValidateApplicationData", application))
            .Returns(Task.CompletedTask);
        
        context.Setup(x => x.CallActivityAsync<VerificationResult>(
            "VerifyResidency", application.StudentId))
            .ReturnsAsync(new VerificationResult { IsValid = true });
        
        context.Setup(x => x.WaitForExternalEvent<ReviewDecision>(
            "AdminReviewCompleted", It.IsAny<TimeSpan>()))
            .ReturnsAsync(new ReviewDecision { Approved = true });
        
        var award = new Award { Id = Guid.NewGuid() };
        context.Setup(x => x.CallActivityAsync<Award>("CreateAward", application))
            .ReturnsAsync(award);
        
        // Act
        var result = await ESAPlusApplicationOrchestrator.RunOrchestrator(
            context.Object, Mock.Of<ILogger>());
        
        // Assert
        Assert.Equal(ApplicationStatus.Approved, result.Status);
        Assert.Equal(award.Id, result.AwardId);
        
        // Verify activities were called
        context.Verify(x => x.CallActivityAsync("CreateAward", application), Times.Once);
        context.Verify(x => x.CallActivityAsync("SendApprovalNotification", 
            It.IsAny<object>()), Times.Once);
    }
}
```

### Integration Testing Elsa Workflows

```csharp
public class ProviderEnrollmentWorkflowTests : IAsyncLifetime
{
    private IServiceProvider _serviceProvider;
    private IWorkflowInvoker _workflowInvoker;
    
    public async Task InitializeAsync()
    {
        var services = new ServiceCollection();
        
        // Register Elsa services
        services.AddElsa(elsa => elsa
            .UseEntityFrameworkPersistence(ef => 
                ef.UseInMemoryDatabase())
            .AddConsoleActivities()
            .AddWorkflow<ProviderEnrollmentWorkflow>());
        
        // Register mocks
        services.AddSingleton(Mock.Of<IBackgroundCheckService>());
        
        _serviceProvider = services.BuildServiceProvider();
        _workflowInvoker = _serviceProvider.GetRequiredService<IWorkflowInvoker>();
    }
    
    [Fact]
    public async Task ProviderEnrollmentWorkflow_ValidProvider_Approves()
    {
        // Arrange
        var application = new ProviderApplication
        {
            ProviderId = Guid.NewGuid(),
            Name = "Test Provider",
            Credentials = "Valid credentials"
        };
        
        // Act
        var workflowInstance = await _workflowInvoker.StartWorkflowAsync(
            "provider-enrollment",
            input: application);
        
        // Simulate background check completion
        await Task.Delay(100); // Give workflow time to suspend
        
        await _workflowInvoker.TriggerSignalAsync(
            workflowInstance.Id,
            "BackgroundCheckCompleted",
            new BackgroundCheckResult { Passed = true });
        
        // Simulate interview completion
        await Task.Delay(100);
        
        await _workflowInvoker.TriggerSignalAsync(
            workflowInstance.Id,
            "InterviewCompleted",
            new InterviewResult { Score = 85 });
        
        // Allow workflow to complete
        await Task.Delay(500);
        
        // Assert
        var completedInstance = await _workflowInvoker.GetWorkflowInstanceAsync(
            workflowInstance.Id);
        
        Assert.Equal(WorkflowStatus.Finished, completedInstance.WorkflowStatus);
        
        // Verify provider was approved
        var providerService = _serviceProvider.GetRequiredService<IProviderService>();
        var provider = await providerService.GetProviderAsync(application.ProviderId);
        
        Assert.NotNull(provider);
        Assert.Equal(ProviderStatus.Approved, provider.Status);
    }
    
    public async Task DisposeAsync()
    {
        if (_serviceProvider is IDisposable disposable)
        {
            disposable.Dispose();
        }
    }
}
```

---

## Conclusion

This document provides comprehensive implementation patterns for K-12 SEAA workflows covering:

✅ **Application Processing** - Long-running, multi-step approval workflows  
✅ **Provider Enrollment** - Complex business workflows with multiple decision points  
✅ **Payment Processing** - Distributed transactions with compensation  
✅ **Communication** - Bulk notifications and campaigns  
✅ **Error Handling** - Retry policies and compensation patterns  
✅ **Testing** - Unit and integration testing approaches  

These patterns provide concrete, production-ready code examples that can be adapted and extended for the specific needs of the K-12 SEAA system.

---

**Document Version:** 1.0  
**Last Updated:** October 22, 2025  
**Next Review:** December 2025
