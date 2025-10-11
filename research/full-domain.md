# NC K12 Scholarships (ESA+ and Opportunity Scholarship) — Full Domain-Driven Design Analysis

This document synthesizes authoritative public sources into a comprehensive, text-only DDD analysis for North Carolina’s K12 scholarship programs: Education Student Accounts (ESA+) and Opportunity Scholarship (OS). It is intended to ground a modern software implementation plan.

Sources used (representative, not exhaustive):

Web Resources:
- [NCSEAA K12 home](https://k12.ncseaa.edu/)
- [ESA+ Resources hub](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/resources/)
- [ESA+ Program Rules & Requirements](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/)
- [ESA+ Awarding Process](https://k12.ncseaa.edu/the-education-student-accounts/awarding-process/)
- [ESA+ Allowable Expenses overview](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/)
- [OS Program landing](https://k12.ncseaa.edu/opportunity-scholarship/)
- [OS Payment Process (How Scholarship Funds Work for OS and ESA+)](https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/payment-process/)
- [OS Income Verification](https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/income-verification/)
- [Provider Search (enrolled service providers)](https://www2.ncseaa.edu/approvedprovidersk12/default.aspx)
- [MyPortal (family/school tasks and documents)](https://myportal.ncseaa.edu/NC/login.aspx)
- [DNPE (private/home school registration)](https://www.doa.nc.gov/divisions/non-public-education)
- [ClassWallet (platform referenced by ESA+)](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/classwallet/)
- [IRS Transcript info referenced by OS Income Verification](http://www.irs.gov/individuals/get-transcript)
- [CFNC portal (contextual partner)](https://www.cfnc.org/)
- [Testing and Reporting Requirements](https://k12.ncseaa.edu/school-admins/annual-requirements/testing-and-reporting/)
- [NC Residency Determination Service](https://www.ncresidency.org/)
- [DNPE Private School Standardized Testing](https://www.doa.nc.gov/divisions/non-public-education/private-schools/standardized-testing)
- [Rules Governing Opportunity Scholarship Program](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2020/10/Rules_OPS.pdf)
- [ESA+ Program Rules](https://www.ncseaa.edu/wp-content/uploads/sites/1429/2022/01/ESA-Plus-Program-Rules-FINAL.pdf)
- [Parent Guide to Allowable Expenses](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf)
- [LEA Release Form](https://k12.ncseaa.edu/media/m44elcjw/esa-lea-release.pdf)
- [OS Renewal Process](https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/how-to-renew/)
- [ESA+ Continuing Eligibility](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/how-to-renew/continuing-eligibility/)
- [ClassWallet Approval Process](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2021/08/ESA_ClassWallet-Approval-Process.pdf)
- [NC DPI Eligibility Determination](https://www.dpi.nc.gov/eligibility-determination/download?attachment)
- [Documentation of Disability](https://k12.ncseaa.edu/the-education-student-accounts/documentation-of-a-disability/)
- [School Administrator Resources](https://k12.ncseaa.edu/school-admins/resources/)
- [School Admins Portal](https://k12.ncseaa.edu/school-admins/)
- [MyPortal Guide for Parents](https://k12.ncseaa.edu/media/pjqhsiz4/myportal-guide-for-parents.pdf)
- [How to Upload Documents in MyPortal](https://k12.ncseaa.edu/media/2w2p4xp0/how-to-upload-docs-myportal.pdf)
- [ESA+ School Transfers](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/school-transfers/)
- [School Transfer Form Guide](https://k12.ncseaa.edu/media/n0gjhckv/how-to-transfer-schools-or-cancel-your-scholarship.pdf)
- [ESA+ School Options](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/school-transfers/esaplus-school-options/)
- [OS Choosing a School](https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/school-transfers/choosing-a-school/)
- [K12 Program Certification Deadlines](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2022/08/K12-Program-NPS-Certification-Deadlines.pdf)
- [Annual Requirements](https://k12.ncseaa.edu/school-admins/annual-requirements/)
- [Certification and Endorsement](https://k12.ncseaa.edu/school-admins/managing-funds/certification-and-endorsement/)
- [Educational Technology](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/educational-technology/)
- [ESA+ Educational Technology Info](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2020/10/EducationalTechnology.pdf)
- [ESA+ Excluded Educational Technology](https://k12.ncseaa.edu/media/pnyownzr/esa-excluded-ed-tech.pdf)
- [DNPE Home School Requirements](https://www.doa.nc.gov/divisions/non-public-education/home-schools/requirements-recommendations)
- [DNPE Home Schools](https://www.doa.nc.gov/divisions/non-public-education/home-schools)
- [DNPE Private Schools](https://www.doa.nc.gov/divisions/non-public-education/private-schools)
- [Private School Requirements](https://www.doa.nc.gov/divisions/non-public-education/private-schools/requirements)
- [OS Awarding Process](https://k12prod.ncseaa.edu/opportunity-scholarship/awarding-process/)
- [OS FAQ](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2024/11/FAQ-for-website_NOV2024_expanded-from-notification.pdf)
- [Priority Period Announcement](https://www.ncseaa.edu/2025/02/k12-program-announcement/)
- [CFNC Financial Aid](https://www.cfnc.org/pay-for-college/apply-for-financial-aid/)
- [Approved Provider List](https://www2.ncseaa.edu/approvedprovidersk12/Documents/K12ApprovedProviders.pdf)
- [Provider Portal Enrollment](https://www2.ncseaa.edu/k12_provider_portal/CreateAccount.aspx)

North Carolina General Statutes (Authoritative Legal Sources):
- [G.S. 115C-562.1 - ESA+ Eligibility and Definitions](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.1.html)
- [G.S. 115C-562.2 - Scholarship Grant Awards; Maximum Amounts](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.2.html)
- [G.S. 115C-562.3 - Verification of Eligibility; Information from Other State Agencies](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html)
- [G.S. 115C-562.5 - Obligations of Nonpublic Schools Accepting Scholarship Grant Recipients](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.5.html)
- [G.S. 115C-366 - Assignment of Students Based on Domicile](https://www.ncleg.gov/EnactedLegislation/Statutes/PDF/BySection/Chapter_115C/GS_115C-366.pdf)
- [Chapter 115C - Complete Statutes](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/ByChapter/Chapter_115C.html)

Federal Guidance:
- [USDA Verification Toolkit for School Meals](https://www.fns.usda.gov/cn/verification-toolkit)
- [Eligibility Manual for School Meals](https://fns-prod.azureedge.us/sites/default/files/cn/SP36_CACFP15_SFSP11-2017a1.pdf)

Local reference documents (workspace requirements/ directory):

- k12-eligibility-requirements2526.pdf
- esaplus-101_january-2025.pdf; esa-enrollment-options_august-2024-final-1.pdf; esaplus-home-schools_january-2025.pdf; esa-at-direct-payment-schools_aug-2024_final-1.pdf
- esaplus-continuing-eligibility-7252025.pdf
- esa-parent-agreement.pdf
- 2025-2026-opportunity-scholarship-program-income-faq125.pdf; ops-calculate-income.pdf; myportal-guide-for-parents.pdf

Note: Statutes and program rules ultimately govern; web pages can change. Implementation should treat rules/content as externalized policy where feasible.

## 1) Scope and Programs

- Opportunity Scholarship (OS)
  - Who: NC students entering K–12; private school enrollees.
  - Award: ~ $3,000–$7,000 based on household income. (Source: OS program page)
  - Usage: Tuition and required fees at registered private schools (Direct Payment schools only).
  - Processes: Application, possible income verification, award offer/accept, parent endorsement each semester, payments to schools twice per year. (Sources: OS landing; OS payment process)

- Education Student Accounts (ESA+)
  - Who: NC students with disabilities, entering K–12.
  - Award: Base $9,000; Higher $17,000. (Source: Awarding Process FAQ, Program Rules)
  - Usage: Depends on school option:
    - Direct Payment school: tuition/fees paid first; leftover ESA+ funds may move to ClassWallet for allowable expenses.
    - ESA+ Reimbursement school: family pays tuition/fees out-of-pocket; reimbursed after semester via ClassWallet workflows.
    - Home school: funds deposited to ClassWallet for allowable expenses (no tuition to a school). (Source: How Scholarship Funds Work)
  - Notable constraints: Minimum spending requirement, rollover rules, LEA Release, allowable/prohibited expenses, provider enrollment. (Source: Program Rules; Allowable Expenses; Resources)

- Dual Award (OS + ESA+)
  - Only at Direct Payment schools.
  - Ordering: OS funds applied first to tuition/fees, then ESA+. Remaining ESA+ funds may go to ClassWallet. (Source: How Scholarship Funds Work)

## 2) Actors / Users

- Parent/Guardian (Account Holder in MyPortal and ClassWallet)
- Student (beneficiary)
- School Administrator (Direct Payment School) — handles tasks in MyPortal
- School Business Officer / Finance Contact (Direct Payment School)
- ESA+ Reimbursement School Staff (providing receipts/documentation)
- Home School Parent/Administrator (ESA+)
- Service Provider (Tutor, Therapist, Transportation) — must enroll with SEAA to accept ESA+ funds
- Provider Organization Admin (manages credentials/enrollment)
- SEAA Program Staff (ESA+ and OS operations, awarding, compliance)
- SEAA Finance/Disbursements Staff (payment cycles, refunds)
- SEAA Compliance/Audit Staff (reviews, misuse handling, termination)
- SEAA Verification Staff (verification sampling, case management, inter-agency coordination)
- MyPortal System (task orchestration, document intake, notifications)
- ClassWallet Platform (ESA+ wallet, marketplace, pay vendor/invoice submission)
- DNPE (Division of Non-Public Education — external registry for private and home schools)
- IRS (receives 1099-G reporting; parent interacts for transcript retrieval for OS income verification)
- CFNC (College Foundation of North Carolina) — partner brand/resources; limited direct operational role in K12 ESA+/OS based on public site
- State Agency Representatives (for verification cooperation):
  - DMV Staff (driver's license/ID verification)
  - DPI Staff (school enrollment verification, per pupil allocation reporting)
  - Department of Revenue Staff (tax filing verification)
  - DHHS Staff (public benefits verification)
  - Department of Commerce Staff (public benefits verification)
  - State Board of Elections Staff (voter registration verification)
  - State CIO Office (electronic verification infrastructure)

## 3) Bounded Contexts and Aggregates

The domains below can be deployed as services or modules within a modular monolith. Aggregates encapsulate invariants.

### A) Application & Eligibility Context

- Aggregates
  - Application (root) — ProgramType (OS or ESA+), Student, Household, SubmissionWindow, Status (draft/submitted/eligible/ineligible/waitlisted/awarded/declined)
  - ESA+ EligibilityDetermination — submission of disability determination within 7 days of application; verified/accepted/rejected. (Source: Awarding Process)
  - OS IncomeVerification — selection-based; requires Income Verification Worksheet, IRS Return Transcript 2024, other docs via MyPortal To-Do. (Source: OS Income Verification)
  - LotteryBatch (ESA+/OS when applicable) — random selection for eligible applications within window; outcomes recorded; ties to award capacity.
- Key Invariants
  - ESA+: Eligibility Determination document must be submitted within 7 days of applying (MyPortal To-Do). Late/missing leads to ineligibility.
  - Lottery executed for eligible apps in the specified date window; awards until funding exhausted.
  - OS income verification: follow MyPortal To-Do; only IRS Return Transcript is acceptable for tax proof unless exceptions granted.
- Domain Events (examples)
  - ApplicationSubmitted, EDDocumentSubmitted, EligibilityVerified, LotteryConducted, AwardOfferMade, AwardAccepted, AwardDeclined, IncomeVerificationRequested, IncomeVerified, ApplicationClosed

### B) Awarding & Funding Context

- Aggregates
  - AwardOffer — links to Application; includes AwardLevel (ESA+: base/higher; OS: income-based amount), OfferDate, AcceptanceDeadline, AwardTier
  - ScholarshipAward — the active award for a school year; Status (pending/active/suspended/terminated/expired)
  - PaymentSchedule — semester payments (fall/spring) per program and school type
  - AwardTier (OS) — income-based prioritization level for lottery; lower income brackets receive priority
  - Waitlist — students eligible but not awarded due to funding exhaustion; may receive awards if additional funding becomes available
- Key Invariants
  - Awards must be accepted in MyPortal by deadline to activate.
  - Direct Payment school payments occur twice per year; parent must complete Parent Endorsement Task each semester. (Source: How Scholarship Funds Work)
  - Dual Award ordering: OS before ESA+ for tuition/fees; ESA+ remainder to ClassWallet. (Source: How Scholarship Funds Work)
  - OS lottery conducted in March for applications submitted Feb 1 - March 1; awards placed in tiers based on household income with lower income receiving priority.
  - Award decisions made in April; families must accept/decline via MyPortal by specified deadline.
  - Additional funding periods may be announced (e.g., early December) to distribute remaining resources to waitlist students.
- Domain Events
  - AwardActivated, ParentEndorsementCompleted, SchoolPaid, FundsMovedToWallet, AwardSuspended, AwardTerminated, StudentAddedToWaitlist, AdditionalFundingAnnounced, WaitlistStudentAwarded
- Sources
  - [OS Awarding Process](https://k12prod.ncseaa.edu/opportunity-scholarship/awarding-process/)
  - [OS FAQ](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2024/11/FAQ-for-website_NOV2024_expanded-from-notification.pdf)
  - [Priority Period Announcement](https://www.ncseaa.edu/2025/02/k12-program-announcement/)

### C) School Choice & Enrollment Context

- Entities/Aggregates
  - School (registered in MyPortal; type categorization)
  - SchoolOption (ESA+): Direct Payment | Reimbursement | Home School; Co-enrollment rules
  - EnrollmentRecord — student’s selected school per term; history of changes/transfers
  - LEARelease (ESA+ full-time in nonpublic or home school) — required signature artifact (in Compliance context but referenced here)
- Invariants
  - School must be eligible/registered for direct payments to occur.
  - For ESA+ nonpublic/home full-time, LEA Release must be signed.
  - Transfers have deadlines and may impact disbursements and wallet availability.
  - ESA+ funding is portable; students can transfer to another eligible nonpublic school mid-year.
  - Parent must notify current school and complete enrollment at new school for transfer.
- Domain Events
  - SchoolSelected, SchoolTransferRequested, CurrentSchoolNotified, NewSchoolEnrollmentConfirmed, SchoolTransferCompleted, SchoolCanceled
- Sources
  - [ESA+ School Transfers](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/school-transfers/)
  - [School Transfer Form Guide](https://k12.ncseaa.edu/media/n0gjhckv/how-to-transfer-schools-or-cancel-your-scholarship.pdf)
  - [ESA+ School Options](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/school-transfers/esaplus-school-options/)
  - [OS Choosing a School](https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/school-transfers/choosing-a-school/)

### D) ESA+ Wallet, Purchasing & Expenses Context (ESA+ only)

- Aggregates
  - ESAAccount (root) — AwardLevel, Balance, RolloverEligible, RolloverCap, CumulativeCap, MinSpendRequirement
  - PurchaseRequest — type: Marketplace Order, Pay Vendor (off-market), Service Invoice; fields: Category, Amount, Status (submitted/review/approved/rejected), RejectionCode, Evidence (invoice/cart screenshot), RelatedMainDeviceOrderId (for accessories), ProviderId
  - Provider (service entity) — EnrollmentStatus, Types (tutoring/therapy/transport), Credentials
  - Vendor (product seller) — Marketplace vs Off-Market
- Invariants & Rules (partial)
  - Allowable expenses categories only; prohibited categories enforced by rules engine.
  - Accessory timing: if not bundled, must be within 30 calendar days of main device order; accessory frequency limits (e.g., once every 3 years) apply. (Source: Educational Technology page)
  - Transportation requires signed contract between parent and provider; first invoice must include contract. (Parent Guide)
  - Minimum Spending Requirement: parent must spend ≥ $1,000 per school year on allowable core-subject expenses; failure renders student ineligible for renewal. (Program Rules)
  - Rollover: only for higher award ($17,000); up to $4,500; cumulative balance must not exceed $30,000; base award cannot roll over. (Program Rules)
  - Summer shutdown: ClassWallet purchasing disabled mid-June for fiscal close; plan ahead. (Plan for Summer Expenses)
  - 1099-G: ESA+ funds spent on non-tuition/required fees are reported by SEAA to IRS; parents may claim NC deduction only if included in federal AGI. (Program Rules – Tax Implications)
- Domain Events
  - PurchaseSubmitted, PurchaseApproved, PurchaseRejected(code), VendorPaid, ProviderPaid, RolloverCalculated, 1099GPrepared

### E) Provider Enrollment Context (ESA+)

- Aggregates
  - ProviderEnrollment — Application, Documents, Credential Checks, ApprovalDate, Status
  - Provider — Directory listing; allowable service mappings
- Invariants
  - Only enrolled providers can be paid.
  - Not all services offered by an enrolled provider are allowable; category validation applies per invoice.

### F) Compliance & Agreements Context

- Aggregates/Entities
  - ParentAgreement — signed annually; encapsulates: compliance with program requirements, enrollment in eligible school, LEA Release, enrollment changes, minimum spend, allowable/prohibited expenses, testing requirement, access to records, non-compliance, termination. (Program Rules)
  - LEARelease — applies to full-time nonpublic/home school ESA+ students.
  - ComplianceRecord — audits, warnings, misuse findings, refunds/recoupments, suspensions/terminations
- Invariants
  - ParentAgreement must be signed to use funds (plus W-9 as required by operations).
  - LEARelease signature is prerequisite for specific ESA+ enrollment paths.
  - Misuse policy enforcement may lead to termination or refund obligations.

### G) Communications, Tasks & Documents Context

- Entities
  - ToDoItem (MyPortal) — DocumentRequest, AffidavitSignature, Parent Endorsement, Income Verification Worksheet, EDD submission
  - Notice/Message — Award offers, reminders, deadline notices
  - Document — uploaded via MyPortal (PDFs, images) with type and validation status
  - Webinar/Training — recorded sessions with slides for parents and school administrators
  - Resource/Guide — step-by-step instructions, FAQ documents, best practices
  - Newsletter — periodic updates on key program information and deadlines
- Invariants
  - To-Do tasks must be completed by deadlines to avoid forfeiture or delays.
  - Parents must regularly check MyPortal To-Do list for pending tasks.
- Sources
  - [School Administrator Resources](https://k12.ncseaa.edu/school-admins/resources/)
  - [MyPortal Guide for Parents](https://k12.ncseaa.edu/media/pjqhsiz4/myportal-guide-for-parents.pdf)
  - [How to Upload Documents in MyPortal](https://k12.ncseaa.edu/media/2w2p4xp0/how-to-upload-docs-myportal.pdf)

### H) Reporting & Tax Context

- Entities
  - TaxReport1099G — records ESA+ non-tuition spend per calendar year
  - Program Analytics — award counts, fund utilization, compliance metrics
  - AnnualCertification — school verifies student enrollment and costs once per year (starts August)
  - TuitionFeeSchedule — annual submission required regardless of scholarship recipients enrolled
  - GraduationDataReport — required for all high school seniors who received K12 program funds
- Invariants
  - Only amounts actually spent by parents on non-tuition allowable expenses are reported (in January for prior calendar year). (Program Rules)
  - Certification completed once per year; school administrators verify enrollment and provide cost information.
  - Tuition and fee schedules must be submitted annually.
  - Graduation data required for all high school seniors with K12 funds.
- Sources
  - [K12 Program Certification Deadlines](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2022/08/K12-Program-NPS-Certification-Deadlines.pdf)
  - [Annual Requirements](https://k12.ncseaa.edu/school-admins/annual-requirements/)
  - [Certification and Endorsement](https://k12.ncseaa.edu/school-admins/managing-funds/certification-and-endorsement/)

### I) Domicile Verification & Inter-Agency Cooperation Context

This context implements the requirements of G.S. 115C-562.3 for verifying domicile and eligibility through cooperation with multiple state agencies.

- Aggregates/Entities
  - DomicileDetermination (root) — VerificationMethod, Evidence[], VerificationStatus, StateAgencyVerifications[], SubmittedAt, VerifiedAt
  - StateAgencyVerificationRequest — Agency, RequestType, RequestedAt, ResponseStatus, VerificationResult
  - EligibilityVerificationCase — ApplicationId, VerificationSampleType (random/error-prone), VerificationDocuments[], CooperationStatus, DeadlineDate, RevocationReason?
  - StatePerPupilAllocation — FiscalYear, Amount, EffectiveDate, Source (from DPI annual report)
  
- Key Invariants (from G.S. 115C-562.3)
  - Authority must verify 4% of scholarship applications annually, including those with apparent errors. (Source: [G.S. 115C-562.3(a1)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
  - Verification process must follow federal verification requirements for free and reduced-price lunch applications as guidance. (Source: [G.S. 115C-562.3(a1)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
  - If household fails to cooperate with verification, award must be revoked. (Source: [G.S. 115C-562.3(a1)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
  - State agencies must cooperate expeditiously via electronic or similarly effective means. (Source: [G.S. 115C-562.3(a)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
  - Department of Public Instruction must provide average State per pupil allocation by December 1 each year for next fiscal year awards. (Source: [G.S. 115C-562.3(c)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
  
- Acceptable Evidence of Domicile (G.S. 115C-562.3(a))
  1. Verified State driver's license or State identification card (via DMV)
  2. Verified State voter registration (via State Board of Elections)
  3. Verified receipt of public benefits from State agency (via DHHS, Commerce, etc.)
  4. Verified filing of State income taxes for year prior to application (via Department of Revenue)
  5. Verified enrollment in North Carolina public school at time of application (via Department of Public Instruction)
  6. Electronically submitted copy of current documents showing parent name and NC address:
     - Utility bill
     - Bank statement
     - Government check
     - Paycheck
     - Any other government document
  
- State Agency Integrations Required
  - Division of Motor Vehicles (DOT) — verify driver's license/ID card
  - Department of Public Instruction — verify public school enrollment; provide annual per pupil allocation
  - Department of Commerce — verify public benefits
  - Department of Health and Human Services — verify public benefits (e.g., Medicaid, TANF, food assistance)
  - Department of Revenue — verify state income tax filing
  - State Board of Elections — verify voter registration
  - State Chief Information Officer — facilitate electronic verification infrastructure
  (Source: [G.S. 115C-562.3(a)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
  
- Authorization & Access Requirements
  - Household members must authorize Authority to access verification information from state agencies including Revenue, DHHS, and DPI. (Source: [G.S. 115C-562.3(b)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
  
- Domain Events
  - DomicileVerificationInitiated, StateAgencyVerificationRequested, StateAgencyResponseReceived, DomicileVerified, DomicileDenied, VerificationSampleSelected, HouseholdAuthorizationReceived, CooperationDeadlinePassed, AwardRevokedForNonCooperation, PerPupilAllocationUpdated

## 4) Canonical Entities and Value Objects (selected)

- Student { studentId, name, DOB, disabilityStatus (ESA+), residency }
- Parent { parentId, contact info, SSN/EIN (for W-9), MyPortalUserId }
- Application { applicationId, programType, submittedAt, status, windowId }
- AwardOffer { offerId, programType, amount, acceptanceDeadline }
- ScholarshipAward { awardId, programType, year, amount, status, schoolId? }
- School { schoolId, name, type: DirectPayment|Reimbursement|HomeSchool, DNPEId?, eligibility }
- Provider { providerId, orgName, types[], enrollmentStatus, approvalDate }
- ESAAccount { accountId, awardLevel, openingBalance, currentBalance, minSpendRequired, rolloverEligible, caps }
- PurchaseRequest { requestId, type, category, amount, vendorId?, providerId?, invoiceRef, status, rejectionCode, submittedAt }
- ParentAgreement { agreementId, signedAt, clauses[], leaReleaseRequired, affidavitDate }
- LEARelease { releaseId, signedAt, scope }
- Payment { paymentId, programType, term, schoolId|vendorId|providerId, amount, status, endorsedByParentAt }
- ToDoItem { todoId, kind, assignedTo, dueDate, status }
- Documents (EligibilityDetermination, IRS Return Transcript, Income Worksheet, W-9)
- DomicileDetermination { determinationId, verificationMethod, evidenceType[], verifiedBy (state agency), verifiedAt, status }
- StateAgencyVerification { verificationId, agency (DMV|DPI|Revenue|DHHS|Commerce|Elections), requestType, requestedAt, responseAt, verificationResult }
- VerificationCase { caseId, applicationId, sampleType (random|error-prone|all), selectedAt, documentsRequired[], householdCooperation, deadlineDate, outcome }
- StatePerPupilAllocation { fiscalYear, amount, reportedByDPI, reportDate }
- RenewalOffer { offerId, studentId, programType, fiscalYear, sentAt, responseDeadline, status (pending|accepted|declined|expired) }
- DisabilityReevaluation { reevaluationId, studentId, dueDate, submittedAt, documentType (IEP|professionalAssessment), status }
- ParentEndorsement { endorsementId, awardId, term, parentName, nameEntered, validationResult, endorsedAt, deadline }
- LEARelease { releaseId, studentId, enrollmentType, signedAt, effectivePeriod }
- SchoolTransfer { transferId, studentId, fromSchoolId, toSchoolId, requestedAt, currentSchoolNotifiedAt, newSchoolEnrollmentConfirmedAt, completedAt, status }
- AwardTier { tierId, programType, householdIncomeRange, priorityLevel, description }
- Waitlist { waitlistId, studentId, applicationId, addedAt, tier, status, awardedFromWaitlistAt? }
- AnnualCertification { certificationId, schoolId, fiscalYear, submittedAt, studentsCount, verificationStatus }
- TuitionFeeSchedule { scheduleId, schoolId, fiscalYear, submittedAt, tuitionAmounts[], requiredFees[] }
- TestResult { resultId, studentId, schoolId, grade, testType, testDate, scores (standard/scaled, percentile, stanine?, NCE?, gradeEquivalent?), submittedAt }
- GraduationDataReport { reportId, schoolId, fiscalYear, seniorCount, graduationData[], submittedAt }
- Webinar { webinarId, title, topic, recordingUrl, slidesUrl, scheduledAt, targetAudience (parents|schools|administrators) }
- Resource { resourceId, title, type (guide|FAQ|bestPractice), url, targetAudience, lastUpdated }
- Newsletter { newsletterId, issueDate, title, content, recipientType }
- Value objects: AcademicSubject, ExpenseCategory, AwardLevel, SchoolTerm (Fall/Spring), HouseholdSize, HouseholdIncome, RejectionCode, DomicileEvidenceType, VerificationMethod, StateAgency, TestType, AudienceType

## 5) Principal Workflows (Happy-path and key branches)

### 5.1 ESA+ New Application to Award

1) Parent creates/uses MyPortal account; selects ESA+; submits application.
2) Within 7 days, parent uploads Eligibility Determination via MyPortal To-Do.
   - Must be from NC public school or Department of Defense school in NC.
   - Legal document identifying student as having disability and eligible for special education services.
   - Typically part of Individualized Education Program (IEP).
   - Full individualized evaluation must have been conducted by team including parents and qualified professionals.
   - Evaluation must be current (conducted within last 3 years).
3) SEAA verifies eligibility determination document and other requirements (residency, age, not in full-time postsecondary).
4) If eligible and within application window, student enters lottery.
5) Lottery in April; awards offered until funds exhausted.
6) Parent accepts award in MyPortal by deadline. (Video guidance linked on site.)
7) Next steps: choose school option (Direct Payment / Reimbursement / Home School), sign Parent Agreement (+ LEA Release if required), submit W-9/affidavit.
8) Funding flows per school option begin (see 5.3–5.5). 
(Sources: [Awarding Process](https://k12.ncseaa.edu/the-education-student-accounts/awarding-process/); [Documentation of Disability](https://k12.ncseaa.edu/the-education-student-accounts/documentation-of-a-disability/); [Program Rules](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/); [How Scholarship Funds Work](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/how-scholarship-funds-work/); [NC DPI Eligibility Determination](https://www.dpi.nc.gov/eligibility-determination/download?attachment))

### 5.2 OS New Application & Income Verification

1) Parent applies for OS (application window and rolling notices per program page).
2) If selected for income verification, To-Do appears in MyPortal.
3) Parent uses Interactive Income Calculator (optional guide) and completes Income Verification Worksheet.
4) Parent obtains IRS Return Transcript (online) and uploads; additional docs upon request.
5) SEAA reviews; if verified and funds available, award offer issued; parent accepts by deadline.
6) Parent/school complete Parent Endorsement and tasks per term.
(Sources: OS Income Verification; OS landing; How to Apply; How Scholarship Funds Work)

### 5.3 Direct Payment Schools (OS and ESA+)

- Payments twice per year (Fall and Spring). All tasks completed in MyPortal by school and parent, including Parent Endorsement each term.
- Tips: verify award amounts before endorsement; contact SEAA if discrepancy.
- ESA+ only: any ESA+ residual after tuition/fees moves to ClassWallet for allowable expenses.
(Sources: How Scholarship Funds Work)

### 5.4 ESA+ Reimbursement Schools

- Family pays tuition/fees out-of-pocket.
- Submit receipts/documentation at semester end via ClassWallet/MyPortal flow (as directed).
- Unspent fall funds remain for spring in ClassWallet.
(Sources: How Scholarship Funds Work)

### 5.5 ESA+ Home Schools

- SEAA deposits ESA+ funds to ClassWallet twice per year.
- Family purchases allowable products via marketplace and allowable services via enrolled providers; off-market “Pay Vendor” path requires invoice/cart screenshot.
(Sources: Allowable Expenses; How Scholarship Funds Work)

### 5.6 ESA+ Allowable Expense Purchasing

**Marketplace Product Purchase:**
- Parent signs into ClassWallet account.
- Browses marketplace and selects items from authorized vendors.
- Adds items to cart and submits order for SEAA review.
- SEAA reviews purchase against allowable expense categories and rules.
- Upon approval, funds deducted from ESA+ account and products shipped to parent address.
- If rejected, parent receives notification with rejection code and remediation guidance.

**Service Provider Payment:**
- Parent obtains invoice from enrolled service provider at time of service.
- Signs into ClassWallet account.
- Finds provider from list of enrolled providers.
- Uploads invoice, enters required details (amount, service description, dates).
- Submits for SEAA review.
- SEAA verifies provider enrollment status, service category allowability, and invoice details.
- Upon approval, funds transferred directly to service provider.
- If rejected, parent receives notification with rejection code.

**Off-Market Vendor (Pay Vendor):**
- Parent identifies vendor/product not in ClassWallet marketplace.
- Obtains invoice or cart screenshot showing item details, price, vendor info.
- Signs into ClassWallet, selects "Pay Vendor" option.
- Uploads invoice/screenshot and enters vendor details.
- Submits for SEAA staff manual review.
- Staff validates: allowable category, reasonable pricing, vendor legitimacy, documentation completeness.
- Approval or rejection with specific code and guidance.

**Special Rules:**
- Transportation requires signed contract between parent and provider included with first invoice. (Parent Guide)
- Accessories must be purchased within 30 days of main device order; frequency limits enforced (e.g., once per 3 years).
- All purchases must support core academic subjects (math, science, English/language arts, social studies, foreign language).
- Prohibited: computer hardware not defined as educational technology, consumable supplies (paper, pens, markers), non-enrolled service providers.

(Sources: [ClassWallet](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/classwallet/); [Allowable Expenses](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/); [Parent Guide to Allowable Expenses](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf); [ClassWallet Approval Process](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2021/08/ESA_ClassWallet-Approval-Process.pdf))

### 5.7 Renewal & Continuing Eligibility (ESA+)

- Annual renewal process via MyPortal.
- Disability re-evaluation every 3 years.
- Minimum Spend check ≥ $1,000 on allowable core-subject items per school year; noncompliance causes loss of renewal eligibility.
- Rollover computation (only for higher award) with caps.
(Sources: Program Rules and Continuing Eligibility webinar)

### 5.8 Transfers & Co-enrollment

- Families may transfer schools; must adhere to deadlines and update MyPortal.
- Co-enrollment policies defined for ESA+. Direct payment vs reimbursement impacts.
(Sources: ESA+ School Transfers pages)

### 5.9 Domicile Verification Process (G.S. 115C-562.3)

- Parent submits application with domicile information (address, claimed residency).
- System validates domicile using established domicile determination system per G.S. 115C-366.
- Parent provides one or more acceptable forms of evidence:
  - Electronically verified: State driver's license/ID (DMV), voter registration (Elections), public benefits receipt (DHHS/Commerce), state tax filing (Revenue), or public school enrollment (DPI)
  - Electronic document upload: utility bill, bank statement, government check, paycheck, or other government document showing parent name and NC address
- Authority initiates electronic verification requests to appropriate state agencies.
- State agencies respond expeditiously with verification results.
- If domicile established, application proceeds; if not, application marked ineligible.
(Sources: [G.S. 115C-562.3](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html); [G.S. 115C-366](https://www.ncleg.gov/EnactedLegislation/Statutes/PDF/BySection/Chapter_115C/GS_115C-366.pdf))

### 5.10 Application Verification Sampling Process (G.S. 115C-562.3)

- Authority selects 4% of awarded applications annually for verification (including those with apparent errors on face of application).
- Selected households receive verification notice via MyPortal To-Do.
- Household members authorize Authority to access state agency information (Revenue, DHHS, DPI).
- Household provides documentation per verification requirements (following federal verification process for free and reduced-price lunch as guidance).
- Authority reviews documentation and verifies against original application.
- Verification process follows USDA guidance: selection criteria, notification, documentation collection, review, and follow-up.
- If household cooperates and verification successful, award continues.
- If household fails to cooperate by deadline, Authority revokes award.
(Sources: [G.S. 115C-562.3](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html); [USDA Verification Toolkit](https://www.fns.usda.gov/cn/verification-toolkit))

### 5.11 Annual Per Pupil Allocation Update (G.S. 115C-562.3)

- By December 1 each year, Department of Public Instruction provides Authority with average State per pupil allocation for current fiscal year.
- This amount determines maximum scholarship awards for eligible students in following fiscal year per G.S. 115C-562.2(b2).
- Award amounts calculated based on: 90% of average per pupil allocation or 90% of tuition/fees (whichever is less) for income-qualified students.
- System updates award calculation parameters annually based on DPI-provided allocation.
(Sources: [G.S. 115C-562.3(c)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html); [G.S. 115C-562.2](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.2.html))

### 5.12 OS Renewal Process

- Starting late January, SEAA sends renewal offers to students who received OS funding in prior fall semester.
- Renewal students prioritized for funding before new applicants.
- Parent accesses MyPortal, completes renewal application, addresses all To-Do items.
- Deadline: April 15 to respond and complete all tasks.
- Students who received spring-only funding receive renewal offers later in spring semester.
- System validates continued income eligibility and residency.
- If requirements met and funds available, renewal award issued.
(Sources: [OS Renewal](https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/how-to-renew/); [Rules Governing Opportunity Scholarship](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2020/10/Rules_OPS.pdf))

### 5.13 ESA+ Renewal & Continuing Eligibility

- Annual renewal process via MyPortal.
- Student must continue to meet all initial eligibility requirements.
- Every 3 years: Disability re-evaluation required; parent submits updated IEP or professional assessment documentation via MyPortal To-Do.
- Minimum Spend verification: System checks that ≥ $1,000 spent on allowable core-subject expenses during school year; if not met, student ineligible for renewal.
- Rollover computation for higher award students (base award not eligible for rollover).
- Renewal offer issued if all requirements satisfied; parent accepts by deadline.
(Sources: [ESA+ Continuing Eligibility](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/how-to-renew/continuing-eligibility/); Program Rules)

### 5.14 Parent Endorsement Process (Each Semester for Direct Payment)

- MyPortal notifies parent of Parent Endorsement To-Do task for current semester.
- Parent logs in to MyPortal, reviews award amount and school information.
- Parent types their name exactly as it appears in MyPortal account (case-sensitive validation).
- Endorsement submitted; if name mismatch, system rejects and displays error with exact match requirement.
- Upon successful endorsement, Authority processes payment to school per G.S. 115C-562.6.
- If parent fails to endorse by deadline, award forfeited and funds reallocated to other students.
(Sources: [How Scholarship Funds Work](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/how-scholarship-funds-work/); [G.S. 115C-562.6](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.6.html))

### 5.15 School Transfer Process (Mid-Year Transfer)

- Parent decides to transfer student to different eligible nonpublic school.
- Parent logs into MyPortal and fills out Student Transfer Form.
- Parent notifies current school of intent to transfer.
- Parent completes enrollment process at new school.
- New school confirms enrollment in MyPortal.
- SEAA updates funding records; ESA+ funds remain portable and transfer with student.
- Timing of transfer may affect disbursement timing and available wallet funds.
(Sources: [ESA+ School Transfers](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/school-transfers/); [School Transfer Form Guide](https://k12.ncseaa.edu/media/n0gjhckv/how-to-transfer-schools-or-cancel-your-scholarship.pdf))

### 5.16 School Annual Certification Process

- August: School certification period begins.
- School administrator logs into MyPortal.
- For each scholarship student: verify enrollment status and provide cost information (tuition, required fees).
- Submit certification for each student.
- SEAA reviews and processes certifications.
- Certifications link to payment calculations for upcoming semester.
(Sources: [K12 Program Certification Deadlines](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2022/08/K12-Program-NPS-Certification-Deadlines.pdf); [Certification and Endorsement](https://k12.ncseaa.edu/school-admins/managing-funds/certification-and-endorsement/))

### 5.17 School Testing and Reporting Submission

- Throughout school year: administer nationally standardized tests to scholarship students in grades 3-12.
- Tests must measure achievement in required subjects (English, grammar, reading, spelling, mathematics for grades 3-8; same or verbal/quantitative competencies for grades 9, 10, 12; ACT for grade 11).
- Acceptable tests: Stanford Achievement Test, Iowa Tests of Basic Skills, TerraNova, ACT.
- By July 15: submit test results to NCSEAA electronically in PDF format.
- Results must include: Standard/Scaled Score, National Percentile Rank, and if available National Stanine, NCE, or Grade Equivalent.
- SEAA reviews submissions for compliance.
(Sources: [Testing and Reporting](https://k12.ncseaa.edu/school-admins/annual-requirements/testing-and-reporting/); [DNPE Testing Requirements](https://www.doa.nc.gov/divisions/non-public-education/private-schools/standardized-testing))

## 6) Policies, Rules, and Invariants (selected with citations)

- ESA+ Minimum Spending Requirement: Spend at least $1,000 on tuition and/or allowable expenses in core subjects (ELA, math, social studies, science) by end of school year; else ineligible for renewal. (Program Rules)
- ESA+ Rollover: Only higher award ($17,000) can roll over up to $4,500; cumulative balance ≤ $30,000; base award ($9,000) cannot roll over. (Program Rules)
- LEA Release: ESA+ full-time nonpublic or home school students must sign LEA Release relinquishing public school special education services during participation. (Program Rules)
- 1099-G: SEAA reports ESA+ non-tuition/required-fee spending to IRS for prior calendar year; NC deduction allowed only if included in federal AGI. (Program Rules – Tax Implications)
- ClassWallet Marketplace: Only channel for products with ESA+ funds; Pay Vendor for off-market with invoice; services require enrolled providers. (Allowable Expenses)
- Accessory Rules: If not bundled, allowed only within 30 days from main device order; frequency limits (e.g., once every 3 years). (Educational Technology page)
- Transportation: Requires signed contract (parent-provider) included with first invoice; student identification required. (Parent Guide)
- Summer Purchasing Pause: ClassWallet suspended mid-June; plan ahead. (Plan for Summer Expenses)
- Lottery: ESA+ lottery in April for eligible applications submitted in defined window; awards until funds exhausted. (Awarding Process)
- Parent Endorsement: Required each semester for direct payment flows; name entry is case-sensitive in MyPortal. (How Scholarship Funds Work)
- OS Income Verification: Use MyPortal To-Do; IRS Return Transcript required for 2024 unless exception; deadlines and extensions managed by SEAA. (Income Verification page)

- Domicile Verification Requirements (G.S. 115C-562.3): State residency per G.S. 115C-366 must be established before scholarship eligibility; Authority maintains domicile determination system; multiple verification methods accepted including electronic verification through state agencies. (Source: [G.S. 115C-562.3(a)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))

- Application Verification Sampling: Authority must verify 4% of applications annually including error-prone applications; verification follows federal free/reduced lunch verification guidance; household cooperation required or award revoked. (Source: [G.S. 115C-562.3(a1)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))

- Inter-Agency Data Sharing: State agencies (DMV, DPI, Commerce, DHHS, Revenue, Elections, State CIO) must expeditiously cooperate with Authority via electronic or similarly effective means for domicile/eligibility verification. (Source: [G.S. 115C-562.3(a)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))

- Household Authorization for Verification: Applicant household members must authorize Authority to access information from Revenue, DHHS, and DPI for verification purposes. (Source: [G.S. 115C-562.3(b)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))

- Per Pupil Allocation Reporting: DPI must provide average State per pupil allocation by December 1 annually to determine maximum scholarship amounts for following fiscal year. (Source: [G.S. 115C-562.3(c)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))

- Award Calculation (G.S. 115C-562.2): Maximum scholarship amounts based on household income relative to federal free/reduced lunch eligibility; up to 90% of average State per pupil allocation or 90% of tuition/fees for full-time students; 45% for part-time students. (Source: [G.S. 115C-562.2](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.2.html))

- School Obligations (G.S. 115C-562.5): Nonpublic schools accepting scholarship students must: provide tuition documentation to Authority and DNPE; conduct criminal background check on decision-making authority; provide annual progress reports with standardized test scores; submit test results by July 15; report graduation rates; schools with 70+ scholarship students must contract CPA for financial review; maintain in-state facility for in-person instruction. (Source: [G.S. 115C-562.5](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.5.html))

- Standardized Testing Requirements: Students in grades 3-12 must take nationally standardized tests annually; grades 3-8: achievement tests in English, grammar, reading, spelling, math; grades 9, 10, 12: same or competencies in verbal/quantitative areas; grade 11: ACT required; acceptable tests include Stanford Achievement Test, Iowa Tests of Basic Skills, TerraNova; results must include Standard/Scaled Score, National Percentile Rank, and if available National Stanine, NCE, or Grade Equivalent. (Sources: [Testing and Reporting](https://k12.ncseaa.edu/school-admins/annual-requirements/testing-and-reporting/); [DNPE Testing Requirements](https://www.doa.nc.gov/divisions/non-public-education/private-schools/standardized-testing))

- ESA+ Disability Eligibility (G.S. 115C-562.1): Student must have documented disability per public school Eligibility Determination confirming need for special education or related services; determination must be submitted within 7 days of application. (Sources: [G.S. 115C-562.1](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.1.html); ESA+ Awarding Process)

- ESA+ Eligibility Determination Requirements: Must be from NC public school or Department of Defense school in NC; legal document identifying student with disability and eligible for special education services; typically part of IEP; full individualized evaluation required by team including parents and qualified professionals; evaluation must be current (within 3 years); student must also meet residency, age, and enrollment requirements. (Sources: [Documentation of Disability](https://k12.ncseaa.edu/the-education-student-accounts/documentation-of-a-disability/); [NC DPI Eligibility Determination](https://www.dpi.nc.gov/eligibility-determination/download?attachment))

- Scholarship Endorsement (G.S. 115C-562.6): Authority must remit scholarship funds to nonpublic schools at least twice per year; funds must be endorsed by at least one parent/guardian; failure to endorse results in forfeiture and reallocation to other students. (Source: [G.S. 115C-562.6](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.6.html))

- Parent Endorsement Case Sensitivity: Parent must type name exactly as appears in MyPortal account; system is case-sensitive; variation in capitalization causes endorsement failure. (Source: [How Scholarship Funds Work](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/how-scholarship-funds-work/))

- OS Renewal Process: Renewal offers sent starting late January to prior-year recipients; families must respond by April 15 via MyPortal; all tasks must be completed by deadlines; renewal students prioritized before new applicants; spring-only recipients receive renewal offers later in semester. (Sources: [OS Renewal](https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/how-to-renew/); [Rules Governing Opportunity Scholarship](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2020/10/Rules_OPS.pdf))

- OS Eligibility Requirements: Available to students K-12 who attended public school minimum 10 days in fall semester before applying; also available to new K/1st grade students meeting household income criteria; students must maintain income eligibility annually. (Source: [OS Program](https://k12.ncseaa.edu/opportunity-scholarship/))

- ESA+ Continuing Eligibility: Students must re-evaluate disability every 3 years by submitting updated IEP or professional assessments; must continue to meet all initial eligibility requirements annually. (Source: [ESA+ Continuing Eligibility](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/how-to-renew/continuing-eligibility/))

- LEA Release Requirement: ESA+ students attending full-time nonpublic or home school must sign LEA Release waiving child's right to receive public school special education services during period of ESA+ participation; required because scholarships for settings where public school services unavailable. (Sources: [LEA Release Form](https://k12.ncseaa.edu/media/m44elcjw/esa-lea-release.pdf); [Program Rules](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/))

- Allowable Expenses Categories (ESA+): Curriculum, educational technology, testing materials/textbooks, tutoring, educational therapy, transportation (with signed contract). (Sources: [Allowable Expenses](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/); [Parent Guide to Allowable Expenses](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf))

- Prohibited Expenses (ESA+): Computer hardware/technological devices not defined as educational technology, consumable supplies (paper, pens, markers), services from providers not enrolled with SEAA. (Source: [ESA+ Program Rules](https://www.ncseaa.edu/wp-content/uploads/sites/1429/2022/01/ESA-Plus-Program-Rules-FINAL.pdf))

- Educational Technology Allowable (ESA+): Desktops, laptops, tablets (e.g., iPads); wireless keyboards/mice, printers, cables, carrying cases, external speakers; educational software and apps designed to aid learning and disabilities. Accessories must be purchased within 30 days of device order if not bundled; can be replaced once every 3 years. (Sources: [Educational Technology](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/educational-technology/); [ESA+ Educational Technology Info](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2020/10/EducationalTechnology.pdf); [Parent Guide](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf))

- Educational Technology Non-Allowable (ESA+): Printer ink, household items, memberships, out-of-state providers. (Source: [ESA+ Excluded Educational Technology](https://k12.ncseaa.edu/media/pnyownzr/esa-excluded-ed-tech.pdf))

- DNPE Home School Requirements: Parent/guardian must hold at least high school diploma or equivalent; submit Notice of Intent to Operate including school name and address; maintain attendance records and nationally standardized test results. (Sources: [DNPE Home School Requirements](https://www.doa.nc.gov/divisions/non-public-education/home-schools/requirements-recommendations); [DNPE Home Schools](https://www.doa.nc.gov/divisions/non-public-education/home-schools))

- DNPE Private School Requirements: File Notice of Intent form to register; ensure fire and sanitation inspections are current; for multiple locations, follow guidance on administering and registering each location correctly. (Sources: [DNPE Private Schools](https://www.doa.nc.gov/divisions/non-public-education/private-schools); [Private School Requirements](https://www.doa.nc.gov/divisions/non-public-education/private-schools/requirements))

- OS Priority Application Period: Applications submitted Feb 1 - March 1 receive priority; must be complete by deadline; lottery conducted in March; students placed in Award Tiers based on household income with lower income receiving priority; awards distributed until funds exhausted. (Sources: [OS Awarding Process](https://k12prod.ncseaa.edu/opportunity-scholarship/awarding-process/); [Priority Period Announcement](https://www.ncseaa.edu/2025/02/k12-program-announcement/))

- Additional Funding Allocations: SEAA may announce additional funding periods (e.g., early December) to distribute remaining resources to students on waitlist who were not previously awarded. (Source: [OS FAQ](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2024/11/FAQ-for-website_NOV2024_expanded-from-notification.pdf))

## 7) Domain Events (suggested event vocabulary)

- ApplicationSubmitted(programType)
- EligibilityDeterminationSubmitted(studentId)
- IncomeVerificationRequested(applicationId)
- IncomeVerified(applicationId)
- LotteryConducted(batchId)
- AwardOfferMade(offerId)
- AwardAccepted(awardId)
- AwardDeclined(offerId)
- ParentAgreementSigned(studentId, year)
- LEAReleaseSigned(studentId, year)
- ParentEndorsementCompleted(studentId, term)
- SchoolPaid(paymentId)
- FundsMovedToWallet(accountId, amount)
- PurchaseSubmitted(requestId)
- PurchaseApproved(requestId)
- PurchaseRejected(requestId, code)
- ProviderEnrolled(providerId)
- MinimumSpendAchieved(studentId, year)
- MinimumSpendFailed(studentId, year)
- RolloverComputed(accountId)
- Tax1099GPrepared(parentId, year)
- AwardTerminated(awardId, reason)
- DomicileVerificationInitiated(applicationId)
- DomicileEvidenceSubmitted(applicationId, evidenceType)
- StateAgencyVerificationRequested(verificationId, agency)
- StateAgencyVerificationReceived(verificationId, result)
- DomicileVerified(applicationId)
- DomicileDenied(applicationId, reason)
- VerificationSampleSelected(applicationId[], fiscalYear, samplePercentage)
- VerificationDocumentationRequested(applicationId)
- HouseholdAuthorizationReceived(applicationId)
- VerificationDocumentsSubmitted(applicationId)
- VerificationCompleted(applicationId, outcome)
- VerificationCooperationDeadlinePassed(applicationId)
- AwardRevokedForNonCooperation(awardId)
- PerPupilAllocationUpdated(fiscalYear, amount)
- SchoolTestResultsSubmitted(schoolId, fiscalYear, studentCount)
- SchoolFinancialReviewCompleted(schoolId, fiscalYear)
- SchoolBackgroundCheckSubmitted(schoolId, authorityPersonId)
- RenewalOfferSent(studentId, programType, fiscalYear)
- RenewalApplicationCompleted(studentId)
- RenewalDeadlinePassed(studentId, outcome)
- DisabilityReevaluationRequired(studentId)
- DisabilityReevaluationSubmitted(studentId, documentType)
- ParentEndorsementInitiated(awardId, term)
- ParentEndorsementSubmitted(awardId, nameEntered, validated)
- ParentEndorsementRejected(awardId, reason)
- EndorsementDeadlinePassed(awardId)
- AwardForfeitedForNonEndorsement(awardId)
- LEAReleaseRequired(studentId, enrollmentType)
- LEAReleaseSubmitted(studentId)
- SchoolTransferRequested(transferId, studentId, fromSchoolId, toSchoolId)
- CurrentSchoolNotified(transferId)
- NewSchoolEnrollmentConfirmed(transferId, schoolId)
- SchoolTransferCompleted(transferId)
- SchoolTransferCanceled(transferId, reason)
- SchoolCertificationStarted(schoolId, fiscalYear)
- StudentEnrollmentVerified(studentId, schoolId, fiscalYear)
- SchoolCertificationSubmitted(schoolId, fiscalYear, studentCount)
- TuitionFeeScheduleSubmitted(schoolId, fiscalYear)
- TestResultsReceived(schoolId, grade, testType, studentCount)
- TestResultsValidated(schoolId, fiscalYear)
- GraduationDataSubmitted(schoolId, fiscalYear, seniorCount)
- WebinarScheduled(webinarId, topic, scheduledAt)
- ResourcePublished(resourceId, type, targetAudience)
- NewsletterSent(newsletterId, recipientType, sentAt)
- StudentPlacedOnWaitlist(studentId, applicationId, tier)
- WaitlistStudentOffered(studentId, offerId)
- AdditionalFundingAllocated(programType, amount, announcedAt)
- EducationalTechnologyPurchased(requestId, deviceType, accessory)
- AccessoryPurchaseValidated(requestId, withinTimeWindow, frequencyCheckPassed)
- DNPENoticeOfIntentFiled(schoolId, schoolType, filedAt)
- FireInspectionUpdated(schoolId, inspectionDate, status)
- SanitationInspectionUpdated(schoolId, inspectionDate, status)

## 8) Third-Party Systems & Integrations

- MyPortal (NCSEAA) — primary workflow/task/document portal for parents and schools. Integration patterns: SSO/IDP, task APIs, document intake, notifications.
- ClassWallet — ESA+ wallet, marketplace, pay-vendor, invoices; supports approvals and ledger; requires secure API integration and webhook/event ingestion for status changes.
- Provider Search (NCSEAA web app) — authoritative directory of enrolled service providers; nightly sync or on-demand lookup.
- DNPE — authoritative registry for private/home school status; eligibility checks and periodic sync recommended.
- IRS — OS income verification relies on IRS Return Transcript; system should store attestation and metadata of transcript receipt (not necessarily automate IRS integration).
- Payment Rails — bank ACH to schools/vendors/providers; could be via ClassWallet for ESA+ non-school payments; direct ACH for OS/ESA+ school disbursements.
- Communications — Email and in-portal messaging; Wistia video links for training (non-transactional).
- CFNC (College Foundation of North Carolina) — partner organization providing education planning, NC 529 savings plan, and financial aid resources (FAFSA assistance, grants, scholarships, loans); contextual relationship but no direct operational integration for K12 ESA+/OS; provides planning tools and resources for families transitioning from K12 to higher education. (Source: [CFNC Financial Aid](https://www.cfnc.org/pay-for-college/apply-for-financial-aid/))
- Division of Motor Vehicles (NC DOT) — domicile verification via driver's license/state ID validation; electronic verification interface required. (Source: [G.S. 115C-562.3](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
- Department of Public Instruction — verify public school enrollment for domicile; provide average State per pupil allocation by December 1 annually; receive standardized test results from schools; coordinate special education eligibility determinations. (Source: [G.S. 115C-562.3](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
- Department of Commerce — verify receipt of public benefits for domicile verification. (Source: [G.S. 115C-562.3](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
- Department of Health and Human Services — verify public benefits (Medicaid, TANF, food assistance via ePASS) for domicile and income verification; provide verification data to Authority. (Source: [G.S. 115C-562.3](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
- Department of Revenue — verify state income tax filing for prior year for domicile verification; support income verification process with authorized household access. (Source: [G.S. 115C-562.3](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
- State Board of Elections — verify voter registration for domicile determination. (Source: [G.S. 115C-562.3](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
- State Chief Information Officer — facilitate and coordinate electronic verification infrastructure across state agencies. (Source: [G.S. 115C-562.3](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html))
- NC Residency Determination Service (RDS) — authoritative residency determination system; reusable residency classification for state aid programs. (Source: [NC RDS](https://www.ncresidency.org/))
- Division of Non-Public Education (DNPE) — receive tuition documentation from schools; maintain private/home school registry; enforce standardized testing requirements; verify fire and sanitation inspections for private schools; manage Notice of Intent forms for private and home school registration. Home schools must have parent/guardian with at least high school diploma; maintain attendance records and nationally standardized test results. Private schools must file Notice of Intent and ensure current fire/sanitation inspections. (Sources: [G.S. 115C-562.5](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.5.html); [DNPE Home Schools Requirements](https://www.doa.nc.gov/divisions/non-public-education/home-schools/requirements-recommendations); [DNPE Private Schools](https://www.doa.nc.gov/divisions/non-public-education/private-schools); [Private School Requirements](https://www.doa.nc.gov/divisions/non-public-education/private-schools/requirements))

## 9) Non-Functional Requirements (NFRs)

- Compliance & Auditability: Full ledger of approvals, endorsements, payments, and policy evaluations; immutable event log; export to auditors.
- Security & Privacy: PII/financial data; encrypt at rest and in transit; least-privilege RBAC; rigorous document access controls.
- Availability & Resilience: Payment windows (Aug/Sep and Jan/Feb) and application/award cycles (Feb–Apr) are peak; design for load; graceful degradation for ClassWallet downtime.
- Accessibility: ADA-compliant web UIs; EN/ES content; case-sensitive fields like Parent Endorsement require clear UI guidance.
- Observability: Metrics for award utilization, minimum spend compliance, approval latency, rejection code distribution.
- Policy Externalization: Rules engine or policy service for allowable expense logic, accessory timing, minimum spending, rollover, and eligibility to reduce code churn.

## 10) Edge Cases & Exceptions (selected)

- ESA+ Minimum Spend not met — automatic non-renewal; appeal/exception handling workflow may be needed.
- Off-market purchase lacking sufficient documentation — rejection with code; resubmission allowed within window.
- Accessory purchase submitted outside 30-day window or exceeding frequency — auto-reject.
- IRS transcript unavailable by deadline — documented extension process via SEAA (per OS income verification FAQ).
- Name mismatch on Parent Endorsement (case sensitivity) — prevent submission and provide exact-match hint.
- Dual Award but school is not Direct Payment — ineligible for dual-use; notify and require school change or separate usage.
- Rollover exceeding caps — auto-adjust to $4,500 and/or $30,000 ceiling; remainder returned to SEAA.
- Summer purchasing pause — queue purchases for post-pause processing (inform user of restrictions).

- Domicile verification failure — multiple evidence types attempted but none verified; application marked ineligible with appeal process available.
- State agency verification timeout — agency fails to respond within reasonable time; fallback to manual verification or document upload path.
- Conflicting domicile evidence — parent provides multiple forms of evidence with different addresses; requires clarification and primary residence determination.
- Verification sample selection edge cases — application both randomly selected and flagged for errors; single verification process handles both criteria.
- Household refuses authorization for state agency access — cannot complete verification; award must be revoked per statute.
- Mid-year domicile change — student/family moves out of state during school year; impact on award continuation and pro-rating.
- Per pupil allocation late delivery — DPI misses December 1 deadline; award calculations delayed or use prior year amount pending update.
- School testing non-compliance — school fails to submit test results by July 15; potential impact on school eligibility for future awards.
- School financial review threshold — school enrolls exactly 70 scholarship students; CPA review requirement triggers.
- Background check reveals disqualifying offense — school leadership has criminal history; school may be ineligible to accept scholarship students.

## 11) Implementation Plan (Phased)

A modern implementation can be a modular monolith or microservice suite. Below is a service-oriented plan; adapt to team scale and ops maturity.

- Phase 0 — Discovery & DDD Baseline
  - Formalize ubiquitous language; confirm aggregates and events.
  - Capture statutory references; parameterize program-year policy values (award amounts, dates).

- Phase 1 — Identity, MyPortal Gateway, and Application Service
  - Identity & RBAC (Parent, School, Provider, SEAA roles). SSO with MyPortal if applicable.
  - Application Service: application intake, document To-Do orchestration, status machine.
  - Domicile Verification Service: domicile determination system per G.S. 115C-366 and 115C-562.3; electronic verification integration framework.
  - State Agency Integration Layer: DMV (driver's license/ID), DPI (school enrollment), Revenue (tax filing), DHHS (public benefits), Commerce (public benefits), Elections (voter registration), State CIO (infrastructure coordination).
  - Document upload for domicile evidence: utility bills, bank statements, government documents.
  - ESA+ Eligibility Determination intake and validation pipeline.
  - OS Income Verification workflow: worksheet capture, transcript document handling, exception/extension requests.
  - Verification Sampling Service: 4% random selection, error-prone identification, verification case management.
  - Household Authorization workflow for state agency data access.
  - Document Store: secure, typed, lifecycle-managed.

- Phase 2 — Awarding & Lottery Service
  - Lottery batching, results, and audit trail.
  - Award Offer & Acceptance; deadlines; notifications.
  - School registry & school-type logic; Parent Agreement and LEA Release e-sign capture.

- Phase 3 — Disbursements & Parent Endorsement
  - Payment Schedule for direct payment schools; Parent Endorsement task UX (case-sensitive validation cues).
  - Dual Award ordering logic (OS→ESA+); remainder-to-wallet event.
  - ACH payout engine, reconciliation, refunds.

- Phase 4 — ESA+ Wallet & Purchasing
  - ClassWallet integration (API/webhook); account provisioning; ledger sync.
  - Allowable Expenses rules engine; rejection codes; documentation requirements per category.
  - Pay Vendor (off-market) flow; invoice validator; transport contract attachment and validation.
  - Provider Enrollment service and provider directory sync.

- Phase 5 — Compliance, Rollover, and Tax Reporting
  - Minimum spend computation; renewal gate.
  - Rollover computation per award level; cap enforcement; return of excess to SEAA.
  - 1099-G reporting pipeline for non-tuition spend; parent statements.
  - Verification completion tracking; non-cooperation detection and award revocation.
  - School compliance monitoring: test results tracking (July 15 deadline), financial review requirements (70+ students), background check management.

- Phase 6 — Admin Console, Analytics, School Compliance & CX
  - SEAA ops dashboards; exception queues; bulk comms.
  - State agency integration monitoring and health checks.
  - Verification case management interface for SEAA staff.
  - Per Pupil Allocation annual update workflow (DPI integration; December 1 deadline tracking).
  - School compliance dashboard: testing submission status, financial review status, background check status.
  - Metrics: utilization, approval latency, rejection heatmap, provider coverage, verification completion rates, state agency response times, domicile verification success rates.
  - Content surfaces: webinars, guides, seasonal reminders (summer pause notice).

- Shared Platform
  - Event bus; outbox pattern for reliable integration.
  - Scheduling (cron) for windows (lottery, disbursement cycles, rollover, tax).
  - Feature flags and policy registry by program year.
  - Test harness with scenario packs (happy path + policy edge cases).

## 12) Acceptance Criteria (samples)

- Application & Eligibility
  - Given parent submits ESA+ application, when EDD not uploaded within 7 days, then status → ineligible and parent notified.
  - Given OS application selected for verification, when IRS transcript uploaded and verified, then award offer eligibility is updated within N business days.

- Awarding & Disbursement
  - Given active award and Direct Payment school, when Parent Endorsement completed, then ACH payment initiated within X days and visible in school portal.
  - Given Dual Award, when tuition < OS award, then residual OS policy applies (communication), and ESA+ remainder rules executed → balance to ClassWallet.

- Wallet & Purchasing (ESA+)
  - Given off-market invoice, when category is disallowed, then request is rejected with a specific rejection code and remediation instructions.
  - Given accessory request outside 30 days, then auto-reject with code and reference to policy.

- Compliance & Reporting
  - Given school year ends, when min-spend < $1,000, then renewal eligibility flag = false and parent notified with appeal info.
  - Given calendar year close, when non-tuition spend exists, then 1099-G prepared and parent notified by January deadline.

- Domicile Verification & Inter-Agency Cooperation
  - Given parent submits application, when domicile evidence is State driver's license, then system requests electronic verification from DMV and receives result within N days.
  - Given parent provides utility bill as domicile evidence, when document uploaded, then manual review triggered and domicile determination completed within N business days.
  - Given 4% verification sampling, when sample selected, then households notified via MyPortal To-Do and deadline set per federal guidance.
  - Given verification case opened, when household fails to provide documentation by deadline, then award automatically revoked and parent notified.
  - Given December 1 annually, when DPI provides per pupil allocation, then system updates award calculation parameters for next fiscal year within 2 business days.
  - Given application with apparent errors, when detected, then automatically included in verification sample regardless of random selection.

- School Compliance
  - Given school has 70+ scholarship students, when fiscal year ends, then CPA financial review requirement triggered and school notified with deadline.
  - Given school has scholarship students in grades 3-12, when July 15 approaches and test results not submitted, then escalating reminders sent to school starting June 1.
  - Given school leadership change, when new decision-making authority appointed, then background check requirement triggered within 30 days.

## 13) Open Questions / Implementation Notes

- OS direct details for rolling award windows and monthly awards: confirm final 2025–26 processes.
- Exact rejection code taxonomy and descriptions: maintain centrally and expose to UIs.
- Detailed accessory frequency rules per item (e.g., protective cases, chargers) — align with latest Parent Guide.
- Provider enrollment vetting (background checks, licenses) — confirm data fields and external validations.
- MyPortal integration contract: APIs vs. SSO + deep links; event/webhook availability.
- ClassWallet API availability: sandbox environments, webhook reliability, idempotency keys.
- State agency integration technical specifications: API contracts, authentication methods, response time SLAs, data formats for each agency (DMV, DPI, Revenue, DHHS, Commerce, Elections).
- Domicile determination rules engine: specific logic for G.S. 115C-366 implementation; edge cases for temporary absence, military families, divorced parents with joint custody.
- Verification sampling algorithm: exact criteria for "error-prone" applications; random selection methodology; audit trail requirements.
- Federal verification guidance adoption: which specific USDA free/reduced lunch verification procedures apply; documentation requirements mapping.
- Per pupil allocation communication protocol: DPI data format; automated ingestion vs manual entry; historical tracking requirements.
- Background check vendor: which service(s) used for school leadership checks; disqualifying offenses criteria; appeal process.
- School financial review: CPA firm selection process; review scope and deliverables; remediation requirements for findings.
- Multi-year domicile verification: frequency of re-verification for continuing students; triggers for re-verification during school year.
- State agency data privacy agreements: MOUs, data use restrictions, retention policies, breach notification procedures.

## 14) Glossary (Ubiquitous Language)

- Direct Payment School: Registered school that receives OS/ESA+ funds directly; requires Parent Endorsement each term.
- ESA+ Reimbursement School: School that declines direct payment; families pay and are reimbursed via ESA+ after semester.
- Home School (ESA+): Parent-directed education registered with DNPE; ESA+ funds for allowable expenses via ClassWallet.
- Allowable Expense: Product/service permitted under ESA+ policy; category constraints apply.
- Prohibited Expense: Explicitly disallowed purchase categories.
- Parent Agreement: Annual ESA+ contract enumerating obligations and rules.
- LEA Release: Agreement releasing public-school special education services while in ESA+ (full-time nonpublic/home only).
- Parent Endorsement: Required parent action each term that authorizes school payment amount; case-sensitive signature field in MyPortal.
- Lottery: Random selection process for awards when demand exceeds supply.
- Rollover: Carry-forward of unused ESA+ funds (higher award only; cap-limited).
- 1099-G: IRS form issued for ESA+ non-tuition spend.
- Domicile: Legal residence of student/parent for scholarship eligibility purposes; established per G.S. 115C-366.
- Domicile Determination System: Authority's system for verifying NC residency through multiple evidence types and state agency cooperation.
- Verification Sample: 4% of scholarship applications selected annually for additional documentation and verification per G.S. 115C-562.3.
- Error-Prone Application: Application with apparent errors on face that must be included in verification sample.
- State Agency Verification: Electronic verification of domicile evidence through cooperation with DMV, DPI, Revenue, DHHS, Commerce, Elections, and State CIO.
- Per Pupil Allocation: Average State funding per student in public schools; reported by DPI annually by December 1; determines maximum scholarship amounts.
- Household Authorization: Required consent from household members for Authority to access verification information from state agencies.
- Verification Cooperation: Household's timely response to verification requests; non-cooperation results in award revocation.
- Nonpublic School Obligations: Requirements per G.S. 115C-562.5 including tuition documentation, background checks, progress reports, standardized testing, graduation rates, and financial reviews (for schools with 70+ scholarship students).

## 15) Quick Links (for further research)

- [K12 Home](https://k12.ncseaa.edu/)
- [ESA+ Resources](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/resources/)
- [ESA+ Rules](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/)
- [ESA+ Awarding](https://k12.ncseaa.edu/the-education-student-accounts/awarding-process/)
- [ESA+ Allowable Expenses](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/)
- [OS Program](https://k12.ncseaa.edu/opportunity-scholarship/)
- [OS Payment Process](https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/payment-process/)
- [OS Income Verification](https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/income-verification/)
- [Provider Search](https://www2.ncseaa.edu/approvedprovidersk12/default.aspx)
- [MyPortal](https://myportal.ncseaa.edu/NC/login.aspx)
- [DNPE](https://www.doa.nc.gov/divisions/non-public-education)
- [ClassWallet](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/classwallet/)
- [CFNC](https://www.cfnc.org/)
- [NC General Statutes Chapter 115C](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/ByChapter/Chapter_115C.html)
- [G.S. 115C-562.1 (ESA+ Eligibility)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.1.html)
- [G.S. 115C-562.2 (Award Amounts)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.2.html)
- [G.S. 115C-562.3 (Verification & Inter-Agency Cooperation)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html)
- [G.S. 115C-562.5 (School Obligations)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.5.html)
- [G.S. 115C-562.6 (Scholarship Endorsement)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.6.html)
- [G.S. 115C-366 (Domicile Requirements)](https://www.ncleg.gov/EnactedLegislation/Statutes/PDF/BySection/Chapter_115C/GS_115C-366.pdf)
- [Testing and Reporting](https://k12.ncseaa.edu/school-admins/annual-requirements/testing-and-reporting/)
- [NC Residency Determination Service](https://www.ncresidency.org/)
- [USDA Verification Toolkit](https://www.fns.usda.gov/cn/verification-toolkit)

## 16) Discrepancies, Gaps & Items Requiring Further Investigation

This section identifies areas where statutory requirements, regulatory guidance, or operational details require clarification or where potential conflicts exist between sources.

### 16.1 Domicile Verification & Inter-Agency Coordination

**Statutory Requirement vs. Current Understanding:**
- G.S. 115C-562.3 mandates electronic verification through multiple state agencies (DMV, DPI, Commerce, DHHS, Revenue, Elections, State CIO), but current documentation focuses primarily on IRS transcripts for income verification and public school enrollment verification.
- **Gap**: Detailed integration specifications, API contracts, and data exchange protocols with each state agency are not documented in public-facing materials.
- **Investigation Needed**: 
  - Technical implementation details for each state agency integration
  - Existing MOUs or data sharing agreements between NCSEAA and state agencies
  - Response time SLAs for electronic verification requests
  - Fallback procedures when electronic verification unavailable
  - Data privacy and security protocols for inter-agency data sharing

**Source**: [G.S. 115C-562.3(a)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html)

### 16.2 Verification Sampling Process

**Statutory Requirement vs. Current Understanding:**
- G.S. 115C-562.3(a1) requires 4% verification rate following federal free/reduced lunch verification guidance, but current documentation does not detail the verification process for K12 scholarships.
- **Gap**: Specific procedures for implementing USDA verification guidance in scholarship context; criteria for identifying "error-prone" applications; documentation requirements; timeline for verification process.
- **Investigation Needed**:
  - Exact mapping from USDA free/reduced lunch verification procedures to scholarship verification
  - Definition and detection criteria for "error-prone" applications
  - Timeline from sample selection to completion deadline
  - Appeal process for households who dispute verification findings
  - Acceptable documentation types per verification category

**Sources**: [G.S. 115C-562.3(a1)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html); [USDA Verification Toolkit](https://www.fns.usda.gov/cn/verification-toolkit)

### 16.3 Award Amount Calculation Details

**Statutory Requirement vs. Current Understanding:**
- G.S. 115C-562.2(b2) specifies complex award calculation based on household income tiers relative to federal free/reduced lunch eligibility (up to 90% of per pupil allocation or tuition, whichever less), but current documentation provides simplified award amounts ($3,000-$7,000 for OS; $9,000/$17,000 for ESA+).
- **Gap**: Exact income thresholds for OS tiers; calculation methodology when tuition < award cap; part-time student pro-rating rules.
- **Investigation Needed**:
  - Precise household income thresholds for each OS award tier (2025-26)
  - Current average State per pupil allocation amount (latest from DPI)
  - Calculation examples for edge cases (tuition variations, part-time enrollment)
  - Rounding rules and minimum award amounts

**Sources**: [G.S. 115C-562.2](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.2.html); OS program pages

### 16.4 School Compliance Requirements

**Statutory Requirement vs. Current Understanding:**
- G.S. 115C-562.5 imposes multiple obligations on schools (criminal background checks, annual progress reports, standardized testing, graduation rates, financial reviews for 70+ students, in-state facilities), but operational documentation focuses primarily on testing and enrollment tasks.
- **Gap**: Enforcement mechanisms; consequences for non-compliance; background check vendor/process; financial review scope and standards; graduation rate reporting methodology.
- **Investigation Needed**:
  - Background check disqualifying offenses list and appeal process
  - Financial review scope, standards, and deliverables for 70+ student threshold
  - Graduation rate calculation methodology and reporting format
  - Consequences for schools that fail compliance requirements
  - Timeline for background check completion upon leadership changes

**Source**: [G.S. 115C-562.5](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.5.html)

### 16.5 Domicile vs. Residency Determination Service (RDS)

**Potential Conflict:**
- G.S. 115C-562.3 requires Authority to "establish a domicile determination system" specific to K12 scholarships, while NC Residency Determination Service (RDS) provides centralized residency determination for higher education.
- **Question**: Is K12 scholarship domicile determination separate from RDS, or should it leverage RDS as the common service?
- **Investigation Needed**:
  - Relationship between K12 domicile determination and RDS
  - Whether RDS can/should be used for K12 program or if parallel system required
  - Differences in domicile requirements between K12 (G.S. 115C-366) and higher education

**Sources**: [G.S. 115C-562.3](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html); [NC RDS](https://www.ncresidency.org/)

### 16.6 Testing Requirements Alignment

**Potential Gap:**
- G.S. 115C-562.5 requires standardized testing with results submitted by July 15, and DNPE has separate testing requirements for private schools, but alignment between these requirements is not explicitly documented.
- **Investigation Needed**:
  - Confirmation that same test results satisfy both NCSEAA and DNPE requirements
  - Coordination process between NCSEAA and DNPE for test result sharing
  - Handling of schools that meet DNPE but not NCSEAA requirements or vice versa

**Sources**: [G.S. 115C-562.5](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.5.html); [Testing and Reporting](https://k12.ncseaa.edu/school-admins/annual-requirements/testing-and-reporting/); [DNPE Testing](https://www.doa.nc.gov/divisions/non-public-education/private-schools/standardized-testing)

### 16.7 Household Member Definition for Authorization

**Statutory Ambiguity:**
- G.S. 115C-562.3(b) requires "household members" to authorize state agency data access, but statute does not define which household members must provide authorization.
- **Investigation Needed**:
  - Definition of "household members" for authorization purposes
  - Whether all adults in household must authorize or only parent/guardian of student
  - Handling split households, divorced parents, legal guardians
  - Form and process for obtaining and documenting authorization

**Source**: [G.S. 115C-562.3(b)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html)

### 16.8 Per Pupil Allocation Update Timing

**Operational Question:**
- G.S. 115C-562.3(c) requires DPI to provide per pupil allocation by December 1 "for that fiscal year to determine the maximum scholarship amount for eligible students to be awarded in the following fiscal year."
- **Clarification Needed**:
  - Whether "that fiscal year" means the current fiscal year (July 1 - June 30) or the school year
  - Exact formula for calculating maximum scholarship from per pupil allocation (90% cap confirmed, but other factors?)
  - Process if DPI misses December 1 deadline
  - Historical per pupil allocation amounts for trend analysis

**Source**: [G.S. 115C-562.3(c)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html)

### 16.9 State CIO Role in Electronic Verification

**Unclear Scope:**
- G.S. 115C-562.3(a) names State Chief Information Officer as required to cooperate with verification efforts, but specific role/responsibilities not defined.
- **Investigation Needed**:
  - Whether State CIO provides technical infrastructure, security oversight, or data governance
  - Existing state enterprise services that could support verification (e.g., NC Identity Management, state data exchange platforms)
  - Procurement or development decisions for verification infrastructure

**Source**: [G.S. 115C-562.3(a)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html)

### 16.10 Verification of Electronic Documents

**Process Gap:**
- G.S. 115C-562.3(a)(6) allows "electronically submitted copy" of documents (utility bill, bank statement, etc.) showing name and address, but verification methodology not specified.
- **Investigation Needed**:
  - Manual review vs. automated document verification technology
  - Acceptable file formats and image quality standards
  - Document age limits (how recent must utility bill be?)
  - Fraud detection measures for submitted documents
  - Third-party verification services if any

**Source**: [G.S. 115C-562.3(a)(6)](https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html)

### 16.11 Anti-Discrimination Requirements and Religious Exemptions

**Policy Gap:**
- Statutes establish requirements for schools accepting scholarship students (G.S. 115C-562.5), but do not explicitly address anti-discrimination requirements or religious exemptions for private schools.
- Public sources indicate nonpublic schools accepting scholarships are not bound by same anti-discrimination requirements as public schools and can implement admission/enrollment policies based on religious beliefs.
- **Investigation Needed**:
  - Statutory or regulatory anti-discrimination requirements (if any) for schools accepting scholarship students
  - Religious exemptions scope and application
  - Disclosure requirements to parents about school policies
  - Impact on ESA+ students with disabilities when private schools not required to follow IDEA
  - Recourse for families if student denied admission or expelled based on protected characteristics
  - Whether Authority has oversight or enforcement role regarding school admission/enrollment policies

**Note**: This is a policy-sensitive area requiring legal review to understand current statutory requirements vs. school autonomy. Implementation should document actual legal requirements and any disclosure/transparency obligations.

**Sources**: General research on NC private school scholarship programs; requires authoritative legal interpretation.

### 16.12 OS Public School Attendance Requirement

**Clarification Needed:**
- OS eligibility requires students K-12 to have attended public school minimum 10 days in fall semester before applying, OR be new K/1st grade students.
- **Questions**:
  - Exact definition of "public school" (does charter school count? virtual public school?)
  - How 10-day attendance verified (school district records? parent attestation? state database?)
  - Exception handling for students who cannot meet 10-day requirement (e.g., move to NC mid-semester)
  - Relationship to domicile verification timing
  - Renewal students: do they need to re-verify public school attendance or is initial verification sufficient?

**Source**: [OS Program](https://k12.ncseaa.edu/opportunity-scholarship/)

### 16.13 Case-Sensitive Parent Endorsement Implementation

**User Experience Concern:**
- MyPortal requires exact case-sensitive name match for parent endorsement; mismatch causes rejection.
- **Investigation Needed**:
  - Rationale for case-sensitive requirement (security? identity verification?)
  - User guidance to prevent errors (e.g., display expected name format before entry)
  - Error message clarity and remediation guidance
  - Accessibility considerations (screen readers, assistive technology)
  - Alternative verification methods for users with name variations or special characters
  - Appeal process if parent unable to complete endorsement due to name mismatch issues

**Source**: [How Scholarship Funds Work](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/how-scholarship-funds-work/)

## Configuration Settings

- [  ] application, feature-level
- [  ] CONST items?

## Questions 

1. Will there be any time zone considerations? Some of the events or action items have deadline dates and times. What if the person completing the form or task is in a different time zone?
2. Audit log and timestamp timezone, default timezine (EST)?
3. Requirements for multi-language support (US English, Spanish)?

## Tool Selection 

1. Rules Engine for both frontend and backend.
2. Internationalization Tools (i18n).

— End —
