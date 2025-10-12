# Enhanced Aggregate and Entity Descriptions for ESA+ and Opportunity Scholarship Programs

This document provides detailed contextual information for each aggregate and entity in the K12 scholarship domain model, including how they're used, their relationships, dependencies, and their role within bounded contexts.

## Purpose

This enhancement addresses the need for more comprehensive documentation of domain aggregates and entities. Each aggregate below includes:
- **Domain Role & Usage**: What the aggregate does in the business context
- **Attributes**: Complete list of data fields with descriptions
- **Relationships & Dependencies**: How this aggregate connects to other domain objects
- **How It's Used in Workflows**: Concrete examples of aggregate usage in business processes
- **Methods/Operations**: Key behaviors and operations
- **Invariants**: Business rules that must always hold true
- **Sources**: References to authoritative documentation

---

## Core ESA+ Aggregates

### 1. **ScholarshipAccount / ESAAccount** *(Core Financial Aggregate)*

**Domain Role & Usage:**
The ScholarshipAccount is the central financial aggregate for ESA+ program participants. It acts as a digital wallet that holds the student's scholarship funds and tracks all financial activity throughout the school year. This aggregate is the financial "heart" of the ESA+ program, ensuring that funds are properly allocated, spent within rules, and rolled over (when allowed) between years.

**Attributes:**
- `studentId` — Links to the Student entity (foreign key relationship)
- `awardLevel` — Enum: base ($9,000) or higher ($17,000); determines rollover eligibility
- `initialAwardAmount` — The starting balance for the current fiscal year
- `balance` — Current available balance after transactions
- `rolloverAllowed` — Boolean derived from awardLevel (true only for higher award)
- `rolloverCap` — Maximum rollover amount ($4,500 for higher award students)
- `cumulativeBalanceCap` — Maximum total balance allowed ($30,000)
- `minimumSpendRequirement` — $1,000 annual spending requirement
- `totalSpent` — Running total of approved/paid transactions
- `fiscalYear` — The year this account is active for

**Relationships & Dependencies:**
- **Has Many** `PurchaseRequests` / `Transactions` — All spending activity flows through this account
- **Belongs To** `Student` — One account per student per year
- **Referenced By** `ParentAgreement` — Agreement must be signed before account activation
- **Depends On** `SchoolChoice` — School enrollment type affects how funds flow (direct payment vs wallet vs reimbursement)
- **Feeds Into** `TaxReportEntry` — Non-tuition spending triggers 1099-G reporting

**How It's Used in Workflows:**
1. **Award Activation**: When a student's ESA+ award is accepted, a ScholarshipAccount is created with the appropriate award level
2. **Purchase Validation**: Every purchase request checks this account's balance before approval
3. **Year-End Rollover**: At fiscal year close (June), the system calculates unused balance, applies rollover rules based on award level, and either carries forward eligible funds or returns them to SEAA
4. **Renewal Eligibility**: The account's `totalSpent` is checked against the $1,000 minimum; failure results in non-renewal
5. **Compliance Monitoring**: Audit/Compliance context monitors spending patterns for misuse detection

**Methods/Operations:**
- `activate()` — Initialize account with award amount for new fiscal year
- `debit(amount)` — Reduce balance when purchase approved
- `credit(amount)` — Add funds (rollover, refund)
- `calculateRollover()` — Determine eligible rollover amount based on award level and cap
- `checkMinimumSpending()` — Validate if $1,000 threshold met
- `freeze()` — Lock account during shutdown period or compliance suspension
- `unfreeze()` — Restore account access after resolution

**Invariants:**
1. If `awardLevel == base`, unused funds must be returned (no rollover allowed)
2. If `awardLevel == higher`, rollover amount ≤ $4,500 AND `balance` ≤ $30,000
3. Annual spending (`totalSpent`) must be ≥ $1,000 to maintain eligibility
4. Balance can never go negative
5. During ClassWallet shutdown period (mid-June), no transactions allowed

**Sources:** 
- [Program Rules](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/)
- [Rollover Policy](https://k12.ncseaa.edu/media/rnnowt2w/plan-for-summer-expenses-final_for-rollover-notificiationsfin.pdf)

---

### 2. **PurchaseRequest / Order / Invoice** *(Transaction Aggregate)*

**Domain Role & Usage:**
PurchaseRequest represents any attempt by a parent to spend ESA+ funds. It encapsulates the entire lifecycle of a purchase—from initial submission through review, approval/rejection, payment, and potential rollback. This aggregate enforces complex business rules around allowable expenses, timing constraints (especially for accessories), and vendor validation.

**Attributes:**
- `requestId` — Unique identifier for this purchase
- `parentId` — The account holder initiating the request
- `studentId` — Beneficiary student
- `esaAccountId` — Links to the ScholarshipAccount being debited
- `vendorId` — Marketplace vendor or off-market vendor identifier
- `providerId` — If service-based (therapy, tutoring, transport), links to Provider
- `category` — Expense category (tuition, curriculum, therapy, technology, transport, etc.)
- `amount` — Purchase amount in USD
- `status` — Enum: submitted, underReview, approved, rejected, paid, rolledBack
- `rejectionCode` — Structured code explaining why request was denied
- `timestamp` — When request was submitted
- `accessoryFlag` — Boolean indicating if this is an accessory purchase
- `relatedMainDeviceOrderId` — For accessories, references the main device order
- `mainDeviceOrderDate` — Used to validate 30-day accessory window
- `lastAccessoryPurchaseDate` — Tracks 3-year accessory frequency rule
- `supportingDocuments` — Array of invoice/receipt/contract attachments

**Relationships & Dependencies:**
- **Belongs To** `ScholarshipAccount` — Debits from this account on approval
- **May Reference** `Provider` — For service-based expenses (therapy, tutoring, transport)
- **May Reference** `Vendor` — For product purchases (marketplace or off-market)
- **May Reference** Another `PurchaseRequest` (for accessory timing validation)
- **Triggers** `ComplianceRecord` — If rejected or flagged for misuse
- **Updates** `TaxReportEntry` — Non-tuition purchases accumulate for 1099-G reporting

**How It's Used in Workflows:**
1. **Marketplace Purchase**: Parent selects item in ClassWallet → Creates PurchaseRequest → Auto-approved if rules pass → Payment executed → Balance updated
2. **Off-Market Vendor**: Parent uploads invoice → Creates PurchaseRequest with attachments → SEAA staff reviews → Approve/Reject → If approved, payment via "Pay Vendor" flow
3. **Service Provider Payment**: Provider submits invoice (tutoring, therapy) → PurchaseRequest created → Validates provider enrollment → Amount moved to provider
4. **Transportation Contract**: First transport invoice must include signed contract → PurchaseRequest validates contract attachment → Subsequent invoices reference original contract
5. **Accessory Validation**: When accessory flagged, system checks `relatedMainDeviceOrderId` exists and `mainDeviceOrderDate` is within 30 days; also validates no similar accessory in past 3 years

**Methods/Operations:**
- `submit()` — Create new purchase request; validates basic data and sufficient balance
- `approve()` — Marks approved; reserves/debits funds; triggers payment workflow
- `reject(code)` — Marks rejected with specific reason code; may trigger parent notification
- `pay()` — Executes actual fund transfer to vendor/provider; updates ScholarshipAccount balance
- `rollback()` — Reverses payment if misuse detected or refund required; returns funds to account
- `validateAccessoryRules()` — Checks timing and frequency constraints for accessory purchases
- `validateAllowableCategory()` — Ensures category is permitted per program rules
- `attachContract()` — For transport, associates required contract document

**Invariants:**
1. If `accessoryFlag == true`, must validate timing (within 30 days of main device) and frequency (once per 3 years)
2. `amount` must be ≤ remaining balance in associated ScholarshipAccount
3. For service categories, referenced `providerId` must have `enrollmentStatus == enrolled`
4. For off-market vendors, `supportingDocuments` must include invoice/receipt
5. For first transport invoice, `supportingDocuments` must include signed contract
6. `category` must be in allowable expense list (not prohibited)
7. Curriculum must support core academic subjects (math, science, English, social studies, foreign language)
8. Cannot submit during ClassWallet shutdown period (mid-June)

**Sources:** 
- [Parent Guide to Allowable Expenses](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf)
- [Educational Technology Rules](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/educational-technology/)

---

### 3. **Provider / ServiceProvider** *(Enrollment & Service Aggregate)*

**Domain Role & Usage:**
Provider represents any individual or organization offering services (tutoring, educational therapy, transportation) that can be paid with ESA+ funds. This aggregate manages the enrollment/credentialing lifecycle and ensures that only qualified, enrolled providers can receive ESA+ payments. It acts as a gatekeeper for service-based spending.

**Attributes:**
- `providerId` — Unique identifier
- `organizationName` — Business/individual name
- `contactInfo` — Email, phone, address
- `types` — Array of service types: tutoring, therapy, transportation, other services
- `credentials` — Array of certifications, licenses, qualifications
- `enrollmentStatus` — Enum: pending, enrolled, suspended, terminated
- `enrollmentDate` — When provider was approved
- `contractTerms` — Terms of service agreement with SEAA
- `servicesOffered` — Detailed list of specific services provided
- `serviceArea` — Geographic regions served (for transportation)
- `complianceHistory` — Record of any issues or violations

**Relationships & Dependencies:**
- **Referenced By Many** `PurchaseRequests` — Services paid through purchase requests
- **May Be** a `School` entity — Schools can also enroll as providers for supplemental services
- **Monitored By** `ComplianceRecord` — Provider misuse or fraud tracking
- **Listed In** Provider Search/Directory — Public-facing searchable list

**How It's Used in Workflows:**
1. **Provider Enrollment**: Provider applies via Provider Portal → Submits credentials → SEAA validates → Status set to enrolled → Appears in searchable directory
2. **Service Selection**: Parent searches Provider Directory → Selects qualified provider → Engages service
3. **Invoice Submission**: Provider submits service invoice → PurchaseRequest created → System validates provider enrollment status → If enrolled, processes payment
4. **Compliance Monitoring**: If provider quality issues or fraud detected → Status changed to suspended → No new invoices accepted
5. **Annual Recertification**: Provider must renew credentials periodically → System validates → Enrollment maintained or terminated

**Methods:**
- `register()` — Submit application to become enrolled provider
- `validateCredentials()` — Verify licenses, certifications, background checks
- `acceptInvoice()` — Submit invoice for services rendered to student
- `updateServices()` — Modify offered services or service area
- `suspend()` — Temporarily block from receiving payments
- `terminate()` — Permanently remove from program

**Invariants:**
1. Only providers with `enrollmentStatus == enrolled` can receive ESA+ payments
2. Provider must maintain current credentials (not expired) to stay enrolled
3. Provider must appear in SEAA's approved provider directory/list
4. For therapy services, provider must have appropriate licenses/certifications
5. For transportation, provider must maintain required insurance and vehicle safety standards

**Sources:** 
- [Service Provider Enrollment](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/service-providers/enrollment/)
- [Provider Search](https://www2.ncseaa.edu/approvedprovidersk12/default.aspx)

---

### 4. **Vendor (Product Vendor)** *(Product Sales Entity)*

**Domain Role & Usage:**
Vendor represents businesses or sellers that provide physical or digital products (curriculum, technology, educational materials) purchasable with ESA+ funds. Vendors come in two flavors: marketplace vendors (integrated into ClassWallet) and off-market vendors (require invoice upload). This entity manages vendor relationships and payment workflows.

**Attributes:**
- `vendorId` — Unique identifier
- `name` — Business name
- `isMarketplaceVendor` — Boolean: true if integrated into ClassWallet marketplace
- `contractAgreement` — Vendor agreement with SEAA/ClassWallet
- `productCatalog` — List of products offered (for marketplace vendors)
- `paymentMethod` — How vendor receives payment (direct ACH, check, etc.)
- `taxInfo` — W-9 and tax identification
- `complianceStatus` — Good standing, suspended, terminated

**Relationships & Dependencies:**
- **Referenced By** `PurchaseRequests` — Product purchases reference vendor
- **If Marketplace**: Integrated with ClassWallet platform for real-time purchasing
- **If Off-Market**: Requires invoice upload and staff review workflow
- **May Sell** prohibited items (flagged during purchase validation)

**How It's Used in Workflows:**
1. **Marketplace Purchase**: Parent browses ClassWallet marketplace → Selects vendor's product → PurchaseRequest auto-created → Vendor receives payment from ClassWallet
2. **Off-Market Purchase**: Parent purchases from non-marketplace vendor → Parent uploads invoice/receipt → PurchaseRequest created with manual review → SEAA approves → Payment sent via "Pay Vendor" feature
3. **Vendor Onboarding**: Vendor applies to join marketplace → Signs agreement → Products added to catalog → Available for purchase
4. **Compliance Check**: If vendor sells prohibited items or engages in fraud → Vendor suspended from marketplace

**Invariants:**
1. If `isMarketplaceVendor == false`, PurchaseRequests must include uploaded invoice/receipt
2. Marketplace vendors must maintain current W-9 and tax info
3. Products must be categorized as allowable expenses
4. Vendors cannot sell prohibited items (weapons, entertainment-only products, non-educational games)

**Sources:** 
- [ClassWallet Approval Process](https://www.ncseaa.edu/wp-content/uploads/sites/1171/2021/08/ESA_ClassWallet-Approval-Process.pdf)
- [Curriculum Vendors](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/curriculum/)

---

### 5. **ParentAgreement / Affidavit** *(Legal Compliance Aggregate)*

**Domain Role & Usage:**
ParentAgreement is the legal contract between the parent and NCSEAA outlining responsibilities, obligations, and rules for ESA+ participation. It's a critical compliance artifact that must be signed before funds can be accessed. This aggregate encapsulates parental consent, understanding of rules, and key policy acknowledgments like the LEA Release.

**Attributes:**
- `agreementId` — Unique identifier
- `parentId` — Parent/guardian who signs
- `studentId` — Student beneficiary
- `signedDate` — When agreement was executed
- `agreementYear` — Fiscal year this agreement covers
- `understandsRules` — Boolean: parent acknowledges understanding of program rules
- `LEAReleaseSigned` — Boolean: parent has signed Local Education Agency release (required for full-time nonpublic/home school)
- `minimumSpendAcknowledged` — Boolean: parent acknowledges $1,000 minimum spending requirement
- `rolloverRulesAcknowledged` — Boolean: parent understands rollover rules based on award level
- `allowableExpensesAcknowledged` — Boolean: parent understands what can/cannot be purchased
- `complianceConsequencesAcknowledged` — Boolean: parent understands termination/suspension consequences
- `signatureData` — Digital signature or uploaded signed document
- `W9Submitted` — Boolean: parent has submitted W-9 for tax purposes

**Relationships & Dependencies:**
- **Belongs To** `Student` — One agreement per student per year
- **Blocks** `ScholarshipAccount` activation — Cannot disburse funds until signed
- **References** LEA Release document — Separate legal artifact for special education waiver
- **Required By** `PurchaseRequest` workflow — First purchase triggers agreement check
- **Feeds** `ComplianceRecord` — Violations recorded against this agreement

**How It's Used in Workflows:**
1. **Award Acceptance**: Student receives award offer → Parent accepts in MyPortal → System generates ParentAgreement task → Parent must sign before funds released
2. **LEA Release Requirement**: If student chooses full-time nonpublic or home school → System requires LEA Release signature → Parent signs waiving public special ed services → Agreement marked complete
3. **Annual Renewal**: Each year, parent must sign new agreement → Old agreement archived → New agreement created for new fiscal year
4. **Compliance Enforcement**: If parent violates rules (prohibited purchase, minimum spend failure) → System references signed agreement → Determines sanctions → May terminate based on agreement terms
5. **W-9 Collection**: Agreement process includes W-9 submission for tax reporting → Parent uploads W-9 → Agreement fully executed

**Methods:**
- `sign()` — Execute digital signature on agreement
- `validateSignatures()` — Ensure all required signatures/acknowledgments present
- `requireLEARelease()` — Determine if LEA Release needed based on school choice
- `checkCompleteness()` — Verify all required components signed before activation
- `archive()` — Store completed agreement for compliance records

**Invariants:**
1. For full-time nonpublic or home school ESA+, `LEAReleaseSigned` must be true before funds disbursed
2. `signedDate` must be within current fiscal year
3. Cannot activate ScholarshipAccount if agreement not fully signed
4. Must be renewed annually (cannot use prior year's agreement for current year)
5. W-9 must be submitted before any funds can be moved

**Sources:** 
- [Program Rules and Requirements](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/)
- [LEA Release Form](https://k12.ncseaa.edu/media/m44elcjw/esa-lea-release.pdf)

---

### 6. **SchoolChoice / EnrollmentOption** *(School Enrollment Entity)*

**Domain Role & Usage:**
SchoolChoice captures the student's educational placement decision and enrollment type. This entity is critical because ESA+ supports multiple schooling models (private school, home school, co-enrollment), and each model has different fund flow rules. SchoolChoice acts as a routing mechanism that determines how scholarship funds are distributed and managed.

**Attributes:**
- `studentId` — Student making school choice
- `schoolType` — Enum: DirectPayment, Reimbursement, HomeSchool, CoEnrollment
- `chosenSchoolId` — If enrolled in a school, references School entity
- `enrollmentDate` — When student enrolled
- `enrollmentStatus` — Active, withdrawn, transferred
- `coEnrollmentRules` — If co-enrolled, details of split enrollment (part-time public + part-time ESA+ option)
- `tuitionAmount` — If applicable, annual tuition cost
- `transferHistory` — Array of previous schools/transfers
- `directPaymentEligible` — Boolean: is this school eligible for direct payments from SEAA

**Relationships & Dependencies:**
- **Belongs To** `Student` — Student can change school choice (with constraints)
- **May Reference** `School` entity — Links to registered school
- **Determines** fund flow in `ScholarshipAccount` — Direct payment vs ClassWallet vs reimbursement
- **Required By** `ParentAgreement` — LEA Release requirement varies by school type
- **Affects** `PurchaseRequest` rules — Home school students have full wallet access; direct payment students get tuition paid first

**How It's Used in Workflows:**
1. **Initial School Selection**: After award acceptance → Parent selects school option in MyPortal → SchoolChoice entity created → Determines fund flow model for the year
2. **Direct Payment School**: Parent selects registered direct payment school → Tuition/fees paid directly to school → Remaining ESA+ balance (if any) moves to ClassWallet for allowable expenses
3. **Reimbursement School**: Parent selects non-direct-payment school → Parent pays tuition out-of-pocket → After semester, uploads receipts → Receives reimbursement to ClassWallet → Can spend on allowable expenses
4. **Home School**: Parent selects home school option → Full ESA+ award deposited to ClassWallet → Parent purchases all educational materials/services through wallet
5. **Co-Enrollment**: Student attends public school part-time + ESA+ option part-time → Complex rules govern what ESA+ can pay for → Must sign LEA Release for any special ed services waived
6. **School Transfer**: Student wants to change schools mid-year → Parent submits transfer request in MyPortal → System validates eligibility → If approved, updates SchoolChoice → May affect remaining fund availability

**Methods:**
- `selectSchool(schoolId, type)` — Record initial school selection
- `transferSchool(newSchoolId)` — Handle mid-year school transfer
- `validateTransferEligibility()` — Check if transfer allowed and timing constraints
- `determineFundFlow()` — Based on school type, return payment routing logic
- `requiresLEARelease()` — Determine if LEA Release needed for this choice

**Invariants:**
1. Depending on `schoolType`, different fund disbursement rules apply:
   - DirectPayment: Tuition paid to school first, remainder to wallet
   - Reimbursement: All funds to wallet after reimbursement approval
   - HomeSchool: All funds to wallet immediately
   - CoEnrollment: Complex split based on services waived
2. School must be registered/eligible if `schoolType == DirectPayment`
3. Mid-year transfers allowed but must follow notification and enrollment confirmation process
4. Cannot change school type mid-year without SEAA approval
5. For Opportunity Scholarship (OS), only DirectPayment schools allowed (not ESA+ reimbursement/home school)

**Sources:** 
- [ESA+ School Options](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/school-transfers/esaplus-school-options/)
- [School Transfers](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/school-transfers/)
- [School Transfer Form](https://k12.ncseaa.edu/media/n0gjhckv/how-to-transfer-schools-or-cancel-your-scholarship.pdf)

---

### 7. **Renewal / ContinuingEligibility** *(Eligibility Lifecycle Aggregate)*

**Domain Role & Usage:**
Renewal represents the annual re-qualification process for ESA+ students. Unlike initial applications, renewals focus on verifying continued disability status and compliance with program requirements. This aggregate manages the 3-year disability re-evaluation cycle and ensures students maintain eligibility year-over-year.

**Attributes:**
- `renewalId` — Unique identifier
- `studentId` — Student seeking renewal
- `renewalYear` — Fiscal year being renewed for
- `submittedDate` — When renewal application submitted
- `status` — Enum: pending, approved, rejected, incomplete
- `reevalDocumentation` — New eligibility determination document (required every 3 years)
- `lastDisabilityDocDate` — Date of most recent eligibility determination
- `yearsInProgram` — Counter of years student has participated
- `minimumSpendingMet` — Boolean: did student spend ≥ $1,000 last year
- `complianceIssues` — Any violations or warnings from previous year
- `parentAgreementSigned` — New agreement for renewal year

**Relationships & Dependencies:**
- **Belongs To** `Student` — One renewal per student per year
- **Depends On** `ScholarshipAccount` — Previous year's account checked for minimum spending
- **Requires** `EligibilityDetermination` document — Every 3 years, fresh documentation needed
- **Blocks** new `ScholarshipAccount` creation — Renewal must be approved before next year's account activated
- **References** `ComplianceRecord` — Prior year violations may affect renewal approval

**How It's Used in Workflows:**
1. **Annual Renewal Offer**: SEAA sends renewal offer in late January → Parent accesses offer in MyPortal → Deadline typically April 15
2. **Standard Renewal (Years 1-2)**: Parent accepts renewal → Signs new ParentAgreement → System checks minimum spending from previous year → If met, renewal approved → New ScholarshipAccount created
3. **3-Year Re-evaluation**: On year 3, 6, 9, etc. → System flags need for new eligibility determination → Parent must obtain fresh IEP/eligibility doc from school → Upload within 7 days → SEAA validates → If valid, renewal approved
4. **Failed Minimum Spending**: If previous year's spending < $1,000 → Renewal automatically rejected → Student loses eligibility
5. **Compliance Violations**: If previous year had misuse or policy violations → Renewal may be denied or conditional → Parent may need to address issues before renewal granted

**Methods:**
- `submitRenewal()` — Parent accepts renewal offer and completes tasks
- `evaluateContinuingEligibility()` — System checks all renewal criteria (spending, compliance, documentation)
- `requiresFreshDocumentation()` — Determines if 3-year re-eval cycle triggered
- `checkMinimumSpending()` — Validates previous year's ScholarshipAccount spending
- `approveRenewal()` — Marks renewal approved and triggers new year setup
- `rejectRenewal(reason)` — Denies renewal with specific reason code

**Invariants:**
1. Every 3 years, `reevalDocumentation` must be submitted with current eligibility determination
2. Previous year's `minimumSpendingMet` must be true to renew
3. Must submit renewal by deadline (typically April 15) or lose award
4. New `ParentAgreement` must be signed each renewal year
5. If previous year had compliance termination, renewal blocked until resolved
6. Renewal cannot be processed during ClassWallet shutdown period

**Sources:** 
- [ESA+ Continuing Eligibility](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/how-to-renew/continuing-eligibility/)
- [ESA+ Renewal Process](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/how-to-renew/)
- [Opportunity Scholarship Renewal](https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/how-to-renew/)

---

### 8. **Audit / ComplianceRecord** *(Compliance Monitoring Aggregate)*

**Domain Role & Usage:**
ComplianceRecord tracks all compliance monitoring, investigations, violations, and enforcement actions. This aggregate is the enforcement mechanism for program rules, ensuring that misuse of funds, policy violations, and fraudulent activity are documented and addressed. It serves both as a historical record and as a trigger for sanctions.

**Attributes:**
- `complianceId` — Unique identifier
- `studentId` — Student whose account is being reviewed
- `parentId` — Parent responsible for compliance
- `complianceDate` — When issue detected or review conducted
- `finding` — Description of violation or audit result
- `violationType` — Enum: misuse, prohibited expense, fraud, minimum spend failure, missed deadline, etc.
- `action` — Enum: warning, refund required, suspension, termination, legal referral
- `misuseFlag` — Boolean: indicates misuse of state funds
- `refundAmount` — If funds must be returned, amount owed
- `resolutionStatus` — Pending, resolved, escalated
- `investigatorNotes` — Staff notes from investigation
- `relatedPurchaseRequests` — Links to problematic transactions

**Relationships & Dependencies:**
- **References** `Student` and `ParentAgreement` — Violations tied to specific student/parent
- **May Reference** specific `PurchaseRequests` — Links to transactions that triggered investigation
- **May Trigger** `ScholarshipAccount` suspension — Account frozen until resolved
- **May Block** `Renewal` — Unresolved violations prevent renewal
- **Feeds** institutional knowledge base — Patterns of misuse inform policy updates

**How It's Used in Workflows:**
1. **Prohibited Purchase Detection**: PurchaseRequest submitted for prohibited item → System auto-rejects → ComplianceRecord created with warning → Parent notified
2. **Misuse Investigation**: SEAA staff notices pattern of questionable purchases → Creates ComplianceRecord for investigation → Reviews transaction history → Determines if misuse occurred → Issues finding (warning, refund, termination)
3. **Minimum Spend Failure**: At year-end, system checks all accounts → Student spent only $800 → ComplianceRecord created → Renewal blocked → Parent notified of termination
4. **Fraud Detection**: Vendor submits fake invoice → SEAA investigates → Confirms fraud → ComplianceRecord created → Vendor terminated, funds clawed back, potential legal referral
5. **Compliance Audit**: Random or targeted audit of ScholarshipAccount → Staff reviews all transactions → If issues found, ComplianceRecord created → Sanctions applied
6. **Resolution Process**: Parent contests finding → Appeals process initiated → Resolution determined → ComplianceRecord updated with outcome

**Methods:**
- `triggerComplianceCheck()` — Initiate investigation of potential violation
- `recordFinding(type, description)` — Document compliance issue
- `applyPenalty(action)` — Execute sanction (warning, refund, suspension, termination)
- `suspendAccount()` — Freeze ScholarshipAccount until resolved
- `requireRefund(amount)` — Calculate and demand return of misused funds
- `escalateToLegal()` — Refer serious fraud cases for legal action
- `resolveViolation()` — Mark issue as resolved and remove blocks

**Invariants:**
1. If `violationType == misuse` and funds used improperly, `refundAmount` must be calculated and recorded
2. `action == termination` blocks all future renewals for this student
3. `action == suspension` freezes ScholarshipAccount (no purchases allowed) until resolved
4. Unresolved ComplianceRecords prevent renewal approval
5. Serious violations (fraud, intentional misuse) may trigger legal referral
6. All enforcement actions must reference the ParentAgreement that was violated

**Sources:** 
- [Misuse of State Funds Policy](https://k12.ncseaa.edu/the-education-student-accounts/resources/)
- [Program Rules](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/)

---

### 9. **TaxReportEntry** *(Tax Reporting Value Object)*

**Domain Role & Usage:**
TaxReportEntry accumulates non-tuition ESA+ spending for IRS Form 1099-G reporting. Since ESA+ funds used for qualified expenses other than tuition may be taxable income, this entity tracks reportable amounts per student per calendar year. It's a compliance artifact required by federal tax law.

**Attributes:**
- `reportId` — Unique identifier
- `studentId` — Beneficiary student
- `parentId` — Parent/taxpayer receiving 1099-G
- `calendarYear` — Tax year (calendar year, not fiscal year)
- `nonTuitionSpendingAmount` — Total ESA+ funds spent on non-tuition allowable expenses
- `tuitionSpendingAmount` — Total spent on tuition/required fees (not reportable)
- `reportGeneratedDate` — When 1099-G was generated
- `sentToIRS` — Boolean: report filed with IRS
- `parentCopySent` — Boolean: parent notified and provided copy

**Relationships & Dependencies:**
- **Belongs To** `Student` — One entry per student per calendar year
- **Aggregates** data from `PurchaseRequests` — Sums non-tuition approved transactions
- **Used By** tax reporting workflow — Generates 1099-G forms
- **Referenced In** `ParentAgreement` — Parent acknowledges tax implications

**How It's Used in Workflows:**
1. **Transaction Tracking**: Throughout year, as PurchaseRequests are approved → System categorizes spending (tuition vs non-tuition) → Accumulates in TaxReportEntry
2. **Year-End Calculation**: At calendar year-end (December 31) → System totals all non-tuition spending → Finalizes TaxReportEntry amounts
3. **1099-G Generation**: By January 31 → SEAA generates 1099-G forms → Reports non-tuition amounts to IRS → Sends copy to parents
4. **Parent Tax Filing**: Parent receives 1099-G → Includes in federal tax return → May claim NC state deduction if included in federal income
5. **Audit Support**: If IRS or state audits taxpayer → TaxReportEntry provides detailed breakdown of what was reported and why

**Methods:**
- `generateReport()` — Create 1099-G form for this student/year
- `accumulateNonTuitionSpending(amount)` — Add to running total as transactions approved
- `finalizeYearEndTotals()` — Lock amounts at calendar year-end
- `submitToIRS()` — File 1099-G with IRS
- `notifyParent()` — Send copy to parent for tax filing

**Invariants:**
1. Only non-tuition spending is reportable (tuition/required fees excluded)
2. Must be reported by January 31 of following year
3. Amounts are based on calendar year (Jan 1 - Dec 31), not fiscal year (July 1 - June 30)
4. Parent must receive copy of 1099-G for their records
5. NC state deduction only allowed if amount was included in federal adjusted gross income

**Sources:** 
- [Tax Reporting](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/)
- [Program Rules](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/)

---

## Aggregate Relationship Diagram (Textual)

```
Student
  └── ScholarshipAccount (1:1 per fiscal year)
      ├── Has Many → PurchaseRequests
      ├── Feeds Into → TaxReportEntry
      └── Checked By → Renewal (for minimum spending)
  
  └── ParentAgreement (1:1 per fiscal year)
      ├── Blocks → ScholarshipAccount activation
      └── Referenced By → ComplianceRecord

  └── SchoolChoice (1:1 current enrollment)
      ├── Determines → ScholarshipAccount fund flow
      └── Affects → ParentAgreement (LEA Release requirement)

  └── Renewal (1:1 per year)
      ├── Depends On → ScholarshipAccount (previous year)
      ├── Requires → EligibilityDetermination (every 3 years)
      └── May Be Blocked By → ComplianceRecord

PurchaseRequest
  ├── Belongs To → ScholarshipAccount
  ├── May Reference → Provider (for services)
  ├── May Reference → Vendor (for products)
  ├── May Reference → Another PurchaseRequest (accessories)
  ├── May Trigger → ComplianceRecord
  └── Updates → TaxReportEntry

Provider
  ├── Referenced By → Many PurchaseRequests
  ├── Monitored By → ComplianceRecord
  └── May Also Be → School

Vendor
  └── Referenced By → Many PurchaseRequests

ComplianceRecord
  ├── References → Student, ParentAgreement
  ├── May Reference → PurchaseRequests
  ├── May Trigger → ScholarshipAccount suspension
  └── May Block → Renewal
```

---

## Context Integration Points

### How Aggregates Flow Between Bounded Contexts

**Application & Eligibility Context → Awarding & Funding Context:**
- Approved Application triggers creation of ScholarshipAccount
- Student eligibility data flows to account setup

**Awarding & Funding Context → ESA+ Wallet Context:**
- ScholarshipAccount created with award amount
- Fund flow determined by SchoolChoice
- PurchaseRequests debit from ScholarshipAccount

**ESA+ Wallet Context → Compliance Context:**
- PurchaseRequests may trigger ComplianceRecords
- ComplianceRecords can suspend ScholarshipAccount

**Compliance Context → Renewal Context:**
- ComplianceRecords checked during Renewal evaluation
- Violations may block renewal approval

**Renewal Context → Awarding & Funding Context:**
- Approved Renewal triggers new ScholarshipAccount for next year
- Rollover amounts transferred from old to new account

**ESA+ Wallet Context → Tax Reporting Context:**
- PurchaseRequests accumulate in TaxReportEntry
- TaxReportEntry generates 1099-G forms

---

## Implementation Recommendations

1. **Aggregate Root Enforcement**: Ensure ScholarshipAccount, ParentAgreement, Renewal, and ComplianceRecord are always accessed through their root entities. Never allow direct manipulation of internal collections.

2. **Event Sourcing Candidates**: Consider event sourcing for ScholarshipAccount and ComplianceRecord to maintain complete audit trail.

3. **Command/Query Separation**: PurchaseRequests should use commands for state changes (submit, approve, reject, pay) and separate queries for reporting.

4. **Consistency Boundaries**: Each aggregate should maintain its own consistency. Cross-aggregate operations should use eventual consistency via domain events.

5. **Domain Events**: Key events to publish:
   - `AwardActivated`, `FundsDebited`, `PurchaseApproved`, `PurchaseRejected`
   - `ComplianceViolationDetected`, `AccountSuspended`, `AccountTerminated`
   - `RenewalApproved`, `RenewalRejected`, `RolloverCalculated`

6. **Validation Layers**:
   - Syntactic validation at entity creation
   - Business rule validation in aggregate methods
   - Cross-aggregate validation via application services
   - Policy validation via separate policy modules

---

## Future Considerations

1. **Multi-Year ScholarshipAccount**: Currently designed for single fiscal year; consider lifecycle patterns for multi-year tracking.

2. **Provider Rating System**: May need to add Provider quality ratings and parent feedback.

3. **Predictive Compliance**: Use ComplianceRecord patterns to predict and prevent future violations.

4. **Dynamic Allowable Expense Rules**: Current rules are static; future versions may need rule engines for dynamic category management.

5. **Cross-Student Family Aggregates**: For families with multiple ESA+ students, may need family-level aggregates for shared resources.
