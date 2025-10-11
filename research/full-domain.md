# NC K12 Scholarships (ESA+ and Opportunity Scholarship) — Full Domain-Driven Design Analysis

This document synthesizes authoritative public sources into a comprehensive, text-only DDD analysis for North Carolina’s K12 scholarship programs: Education Student Accounts (ESA+) and Opportunity Scholarship (OS). It is intended to ground a modern software implementation plan.

Sources used (representative, not exhaustive):

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
- MyPortal System (task orchestration, document intake, notifications)
- ClassWallet Platform (ESA+ wallet, marketplace, pay vendor/invoice submission)
- DNPE (Division of Non-Public Education — external registry for private and home schools)
- IRS (receives 1099-G reporting; parent interacts for transcript retrieval for OS income verification)
- CFNC (College Foundation of North Carolina) — partner brand/resources; limited direct operational role in K12 ESA+/OS based on public site

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
  - AwardOffer — links to Application; includes AwardLevel (ESA+: base/higher; OS: income-based amount), OfferDate, AcceptanceDeadline
  - ScholarshipAward — the active award for a school year; Status (pending/active/suspended/terminated/expired)
  - PaymentSchedule — semester payments (fall/spring) per program and school type
- Key Invariants
  - Awards must be accepted in MyPortal by deadline to activate.
  - Direct Payment school payments occur twice per year; parent must complete Parent Endorsement Task each semester. (Source: How Scholarship Funds Work)
  - Dual Award ordering: OS before ESA+ for tuition/fees; ESA+ remainder to ClassWallet. (Source: How Scholarship Funds Work)
- Domain Events
  - AwardActivated, ParentEndorsementCompleted, SchoolPaid, FundsMovedToWallet, AwardSuspended, AwardTerminated

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
- Invariants
  - To-Do tasks must be completed by deadlines to avoid forfeiture or delays.

### H) Reporting & Tax Context

- Entities
  - TaxReport1099G — records ESA+ non-tuition spend per calendar year
  - Program Analytics — award counts, fund utilization, compliance metrics
- Invariants
  - Only amounts actually spent by parents on non-tuition allowable expenses are reported (in January for prior calendar year). (Program Rules)

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
- Value objects: AcademicSubject, ExpenseCategory, AwardLevel, SchoolTerm (Fall/Spring), HouseholdSize, HouseholdIncome, RejectionCode

## 5) Principal Workflows (Happy-path and key branches)

### 5.1 ESA+ New Application to Award

1) Parent creates/uses MyPortal account; selects ESA+; submits application.
2) Within 7 days, parent uploads Eligibility Determination via MyPortal To-Do.
3) SEAA verifies eligibility; if eligible and within window, student enters lottery.
4) Lottery in April; awards offered until funds exhausted.
5) Parent accepts award in MyPortal by deadline. (Video guidance linked on site.)
6) Next steps: choose school option (Direct Payment / Reimbursement / Home School), sign Parent Agreement (+ LEA Release if required), submit W-9/affidavit.
7) Funding flows per school option begin (see 5.3–5.5). (Sources: Awarding Process; Program Rules; How Scholarship Funds Work)

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

- Products: Must be purchased via ClassWallet marketplace. Not all marketplace items are allowable.
- Services: Tutors/therapists/transport providers must be enrolled with SEAA. Find via Provider Search; submit invoices; transportation requires signed contract with first invoice.
- Off-market vendors: Use Pay Vendor; upload invoice/cart screenshot; staff review; rejection codes if non-compliant.
- Timing rules: accessory window (30 days) and frequency (e.g., once per 3 years) enforced.
(Sources: Allowable Expenses pages and Parent Guide; ClassWallet resources)

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

## 8) Third-Party Systems & Integrations

- MyPortal (NCSEAA) — primary workflow/task/document portal for parents and schools. Integration patterns: SSO/IDP, task APIs, document intake, notifications.
- ClassWallet — ESA+ wallet, marketplace, pay-vendor, invoices; supports approvals and ledger; requires secure API integration and webhook/event ingestion for status changes.
- Provider Search (NCSEAA web app) — authoritative directory of enrolled service providers; nightly sync or on-demand lookup.
- DNPE — authoritative registry for private/home school status; eligibility checks and periodic sync recommended.
- IRS — OS income verification relies on IRS Return Transcript; system should store attestation and metadata of transcript receipt (not necessarily automate IRS integration).
- Payment Rails — bank ACH to schools/vendors/providers; could be via ClassWallet for ESA+ non-school payments; direct ACH for OS/ESA+ school disbursements.
- Communications — Email and in-portal messaging; Wistia video links for training (non-transactional).
- CFNC — partner brand/resources; no direct operational integration surfaced for K12 ESA+/OS on public site; keep as external content reference only.

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

## 11) Implementation Plan (Phased)

A modern implementation can be a modular monolith or microservice suite. Below is a service-oriented plan; adapt to team scale and ops maturity.

- Phase 0 — Discovery & DDD Baseline
  - Formalize ubiquitous language; confirm aggregates and events.
  - Capture statutory references; parameterize program-year policy values (award amounts, dates).

- Phase 1 — Identity, MyPortal Gateway, and Application Service
  - Identity & RBAC (Parent, School, Provider, SEAA roles). SSO with MyPortal if applicable.
  - Application Service: application intake, document To-Do orchestration, status machine.
  - ESA+ Eligibility Determination intake and validation pipeline.
  - OS Income Verification workflow: worksheet capture, transcript document handling, exception/extension requests.
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

- Phase 6 — Admin Console, Analytics, and CX
  - SEAA ops dashboards; exception queues; bulk comms.
  - Metrics: utilization, approval latency, rejection heatmap, provider coverage.
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

## 13) Open Questions / Implementation Notes

- OS direct details for rolling award windows and monthly awards: confirm final 2025–26 processes.
- Exact rejection code taxonomy and descriptions: maintain centrally and expose to UIs.
- Detailed accessory frequency rules per item (e.g., protective cases, chargers) — align with latest Parent Guide.
- Provider enrollment vetting (background checks, licenses) — confirm data fields and external validations.
- MyPortal integration contract: APIs vs. SSO + deep links; event/webhook availability.
- ClassWallet API availability: sandbox environments, webhook reliability, idempotency keys.

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

## Configuration Settings

- [  ] application, feature-level
- [  ] CONST items?

## Questions 

1. Will there be any time zone considerations? Some of the events or action items have deadline dates and times. What if the person completing the form or task is in a different time zone?

— End —
