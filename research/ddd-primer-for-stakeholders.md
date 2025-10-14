# Domain-Driven Design Primer for IT Stakeholders

## Introduction

This document serves as an introduction to Domain-Driven Design (DDD) for IT stakeholders, managers, and team members who may not be familiar with the approach. We'll explain the key concepts using real examples from our K-12 scholarship programs (ESA+ and Opportunity Scholarship) to make these ideas concrete and relatable.

**Why Domain-Driven Design?**

Domain-Driven Design helps us build software that truly reflects how our business works. Instead of thinking about databases and web pages first, we think about the real-world "things" and "actions" in our business domain. This leads to:
- Software that matches how the business actually operates
- Code that business experts can understand and validate
- Systems that are easier to change when business rules change
- Clear boundaries between different parts of the system

## Core DDD Concepts Explained

### 1. Domain

**What it is:** The domain is simply the subject area or problem space your software addresses. It's the real-world business territory you're operating in.

**In our context:** Our domain is K-12 scholarship administration in North Carolina, specifically:
- Awarding scholarships (ESA+ and Opportunity Scholarship programs)
- Managing student and family applications
- Tracking scholarship funds
- Processing payments to schools, providers, and vendors
- Ensuring compliance with program rules

**Think of it as:** Everything related to managing educational scholarships from application through payment and compliance.

---

### 2. Entity

**What it is:** An entity is a "thing" in your domain that has:
- A unique identity (like an ID number)
- A lifecycle (it's created, changes over time, possibly ends)
- Attributes that can change, but it remains the same "thing"

**Key characteristic:** Two entities with the same attribute values are still different if they have different identities.

**Examples from our domain:**

**Student**
- Identity: `studentId` (e.g., "S-2024-12345")
- Lifecycle: Enrolls in program → Receives awards → Graduates or exits program
- Attributes: Name, date of birth, disability status, grade level
- Why it's an entity: Each student is unique. Two students named "John Smith" are different people with different `studentId` values.

**ScholarshipAccount**
- Identity: `accountId` (e.g., "ESA-2024-12345")
- Lifecycle: Created when award accepted → Active with transactions → Closed at year end
- Attributes: Balance ($9,000 or $17,000), transactions, fiscal year, status
- Why it's an entity: Each account has its own balance and transaction history, even if two students have the same award amount.

**Provider (Tutor, Therapist, Transportation)**
- Identity: `providerId` (e.g., "PROV-2024-789")
- Lifecycle: Applies → Enrolled → Provides services → May be suspended → Terminated
- Attributes: Name, credentials, service types, enrollment status
- Why it's an entity: Each provider is distinct, maintains their own enrollment status and credentials.

---

### 3. Value Object

**What it is:** A value object describes or measures something but has no unique identity. Two value objects with the same attributes are considered identical and interchangeable.

**Key characteristic:** Value objects are immutable—if you need to change one, you create a new one.

**Examples from our domain:**

**Money/Amount**
- Attributes: Amount ($9,000), currency (USD)
- Why it's a value object: $9,000 is $9,000. One instance of "$9,000" is the same as any other "$9,000"
- Usage: Award amounts, purchase amounts, balances

**Address**
- Attributes: Street, city, state, zip code
- Why it's a value object: "123 Main St, Raleigh, NC 27601" is the same address no matter how many times you write it
- Usage: Student address, provider address, school address

**Date Range**
- Attributes: Start date, end date
- Why it's a value object: "July 1, 2024 to June 30, 2025" describes a fiscal year period
- Usage: Award periods, enrollment periods, compliance review periods

**Expense Category**
- Attributes: Category name (e.g., "Tuition", "Curriculum", "Therapy", "Technology")
- Why it's a value object: The category "Tuition" is the same concept everywhere it's used
- Usage: Classifying purchase requests and tracking spending

---

### 4. Aggregate

**What it is:** An aggregate is a cluster of related entities and value objects that are treated as a single unit. Think of it as a "boundary" around related things that need to be consistent with each other.

**Key characteristics:**
- Has one "root" entity that controls access to everything inside
- Enforces business rules (invariants) that must always be true
- External code can only access the aggregate through the root
- Changes to the aggregate happen as a single transaction

**Why aggregates matter:** They prevent your data from getting into an invalid state by controlling how things are changed.

**Major aggregates in our domain:**

#### **Aggregate 1: ScholarshipAccount** (Root: ScholarshipAccount entity)

**What's inside:**
- ScholarshipAccount entity (the root)
- List of PurchaseRequest entities
- Rollover rules
- Current balance
- Spending requirements

**What it protects (invariants):**
- Balance can never go negative
- Annual spending must be ≥ $1,000 to maintain eligibility
- Rollover amount ≤ $4,500 for higher award students
- Total balance never exceeds $30,000
- No transactions during ClassWallet shutdown period

**How it's used:**
```
Parent wants to purchase $500 curriculum:
1. Create purchase request
2. ScholarshipAccount checks: balance >= $500? ✓
3. ScholarshipAccount checks: category allowed? ✓
4. ScholarshipAccount approves request
5. Balance reduced by $500 as single transaction
6. If any check fails, entire purchase is rejected
```

**Why it's an aggregate:** All these pieces need to stay consistent. You can't have a purchase that exceeds the balance, or rollover rules that violate caps. The ScholarshipAccount root enforces these rules.

#### **Aggregate 2: Application** (Root: Application entity)

**What's inside:**
- Application entity (the root)
- Student information (reference)
- Family information (reference)
- Eligibility documents
- Application status
- Lottery ranking (if applicable)

**What it protects (invariants):**
- Application can only move through valid status transitions:
  - Submitted → Under Review → Awarded/Waitlisted/Declined
- Required documents must be complete before moving to "Awarded"
- Eligibility determination document required for ESA+
- Only one active application per student per program per year

**How it's used:**
```
Family submits ESA+ application:
1. Application created in "Submitted" status
2. Staff reviews → status changes to "Under Review"
3. Eligibility document verified
4. If approved → status changes to "Awarded"
5. If funding limited → status changes to "Waitlisted"
6. Each status change validated by Application rules
```

**Why it's an aggregate:** The application's status, documents, and eligibility must all be consistent. You can't award an application without proper documents.

#### **Aggregate 3: PurchaseRequest** (Root: PurchaseRequest entity)

**What's inside:**
- PurchaseRequest entity (the root)
- Purchase amount and category
- Vendor or provider reference
- Supporting documents (invoices, contracts)
- Status (submitted, approved, rejected, paid)
- Rejection codes if denied

**What it protects (invariants):**
- Amount ≤ available balance in ScholarshipAccount
- Category must be allowable (not prohibited)
- Accessories must be within 30 days of main device purchase
- No duplicate accessories within 3 years
- Service providers must be enrolled
- Transportation first invoice must include contract
- Curriculum must support core academic subjects

**How it's used:**
```
Parent purchases educational technology accessory:
1. PurchaseRequest created with accessory flag
2. Check: Main device purchased within last 30 days? 
3. Check: No similar accessory in past 3 years?
4. Check: Sufficient balance?
5. If all pass → Approved
6. If any fail → Rejected with specific reason code
7. Parent notified of outcome
```

**Why it's an aggregate:** All these validation rules must be checked together. A partially validated purchase request is meaningless.

#### **Aggregate 4: Provider** (Root: Provider entity)

**What's inside:**
- Provider entity (the root)
- Credentials and licenses
- Service types offered
- Enrollment status
- Compliance history
- Contract terms

**What it protects (invariants):**
- Only enrolled providers can receive payments
- Credentials must be current (not expired)
- Suspended providers cannot accept new service requests
- Provider must maintain required insurance
- Service types must match credentials

**How it's used:**
```
Provider submits invoice for tutoring services:
1. Check: Provider enrollment status = "Enrolled"? ✓
2. Check: Credentials current? ✓
3. Check: Service type "Tutoring" in offered services? ✓
4. Create PurchaseRequest for payment
5. If any check fails → Reject invoice
```

**Why it's an aggregate:** Provider enrollment, credentials, and service offerings must be consistent. You can't pay a suspended provider or one with expired credentials.

---

### 5. Domain Events

**What it is:** A domain event is something significant that happened in your domain. It's a fact about the past that other parts of the system might care about.

**Key characteristics:**
- Named in past tense (something already happened)
- Immutable (you can't change history)
- Contains the essential data about what happened
- Can trigger actions in other parts of the system

**Why events matter:** They help different parts of your system coordinate without being tightly coupled. One part announces "this happened" and other parts can react.

**Examples from our domain:**

**AwardActivated**
- What happened: A student's scholarship award was activated
- Data included: studentId, awardAmount, awardLevel, fiscalYear
- Who cares:
  - ScholarshipAccount context → Create new account with balance
  - Notification context → Send welcome email to parent
  - Compliance context → Start monitoring for minimum spending

**PurchaseApproved**
- What happened: A purchase request was approved
- Data included: requestId, studentId, amount, category, vendorId
- Who cares:
  - Payment context → Execute payment to vendor/provider
  - ScholarshipAccount context → Deduct amount from balance
  - Tax Reporting context → Add to non-tuition spending total

**ComplianceViolationDetected**
- What happened: System detected misuse of funds
- Data included: studentId, violationType, amount, description
- Who cares:
  - ScholarshipAccount context → Suspend account
  - Notification context → Alert SEAA staff
  - Compliance context → Create investigation record

**RenewalRejected**
- What happened: Student failed to renew for next year
- Data included: studentId, rejectionReason (e.g., "insufficient spending")
- Who cares:
  - ScholarshipAccount context → Close account, return unused funds
  - Notification context → Send rejection letter to parent
  - Application context → Archive application

**FundsRolledOver**
- What happened: Unused funds carried forward to next year
- Data included: studentId, previousBalance, rolloverAmount, newBalance
- Who cares:
  - ScholarshipAccount context → Credit new year's balance
  - Tax Reporting context → Update cumulative spending records
  - Notification context → Inform parent of rollover

---

### 6. Bounded Context

**What it is:** A bounded context is a clear boundary within which a particular domain model applies. It's like departments in a company—each has its own way of talking about things and its own responsibilities.

**Key characteristics:**
- Each context has its own ubiquitous language (terminology)
- Same word can mean different things in different contexts
- Contexts integrate through well-defined interfaces
- Teams can work on different contexts independently

**Why it matters:** Large systems are too complex to have one unified model. Bounded contexts let you break the problem into manageable pieces.

**Bounded contexts in our system:**

#### **K-12 Scholarship Administration Context**

**Responsibility:** Managing student applications, awards, and school enrollment for K-12 programs

**Key aggregates:**
- Application
- Award
- SchoolChoice
- Endorsement (for Opportunity Scholarship)

**Ubiquitous language:**
- "Award" = scholarship granted to student
- "Endorsement" = parent's term-by-term acceptance of award
- "Direct Payment School" = school receiving funds directly
- "Lottery" = selection process when demand exceeds funding

**Integrates with:**
- ESA+ Services context (award activation triggers account creation)
- Identity & Residency context (validates student eligibility)
- Payments context (disbursements to schools)

#### **ESA+ Services Context**

**Responsibility:** Managing ESA+ scholarship accounts, purchases, providers, and fund spending

**Key aggregates:**
- ScholarshipAccount
- PurchaseRequest
- Provider
- Vendor

**Ubiquitous language:**
- "Account" = digital wallet with ESA+ funds
- "Purchase Request" = any spending from account
- "Provider" = service provider (tutor, therapist, transportation)
- "Vendor" = product seller (curriculum, technology)
- "Allowable Expense" = category permitted by program rules

**Integrates with:**
- K-12 Scholarship Administration (receives award activation events)
- Payments context (processes purchase payments)
- Compliance context (monitors spending patterns)

#### **Compliance & Audit Context**

**Responsibility:** Monitoring program rules, detecting violations, managing suspensions/terminations

**Key aggregates:**
- ComplianceRecord
- Renewal
- ParentAgreement

**Ubiquitous language:**
- "Violation" = breach of program rules
- "Suspension" = temporary block on account
- "Termination" = permanent removal from program
- "Minimum Spending Requirement" = $1,000 annual threshold
- "LEA Release" = document releasing student from public school services

**Integrates with:**
- ESA+ Services (monitors ScholarshipAccount activity)
- K-12 Scholarship Administration (validates renewals)
- Notifications (alerts about violations)

#### **Identity & Residency Context**

**Responsibility:** Managing user accounts, authentication, NC residency verification

**Key aggregates:**
- Family/ParentAccount
- Student
- ResidencyVerification

**Ubiquitous language:**
- "MyPortal Account" = parent's login account
- "Resident" = NC resident eligible for programs
- "Household" = family unit for income verification

**Integrates with:**
- K-12 Scholarship Administration (provides student identity)
- Higher-Ed Grants (shares residency status)

---

### 7. Ubiquitous Language

**What it is:** A common vocabulary shared between developers, business experts, and domain documents. The same terms used in conversations appear in the code.

**Why it matters:** Eliminates translation errors. When a business expert says "rollover," that word appears in the code as `calculateRollover()`, not `transferBalance()` or `carryForward()`.

**Examples from our domain:**

| Business Term | What It Means | Where It Appears |
|--------------|---------------|------------------|
| ESA+ | Education Student Account Plus program | Code: `EsaPlusProgram`, Documents: "ESA+" |
| Award Level | Base ($9,000) or Higher ($17,000) | Code: `awardLevel`, Documents: "award level" |
| Rollover | Carrying unused funds to next year | Code: `calculateRollover()`, Documents: "rollover" |
| Allowable Expense | Purchase category permitted by rules | Code: `AllowableExpenseCategory`, Documents: "allowable expense" |
| Direct Payment School | School receiving scholarship funds directly | Code: `DirectPaymentSchool`, Documents: "direct payment school" |
| Provider Enrollment | Process for providers to qualify for ESA+ payments | Code: `ProviderEnrollment`, Documents: "provider enrollment" |
| Endorsement | Parent's term acceptance of Opportunity Scholarship | Code: `Endorsement`, Documents: "endorsement" |
| Lottery | Selection when applications exceed funding | Code: `LotteryRanking`, Documents: "lottery" |
| ClassWallet | Digital platform managing ESA+ funds | Code: `ClassWalletAccount`, Documents: "ClassWallet" |
| LEA Release | Release from Local Education Agency services | Code: `LEAReleaseSigned`, Documents: "LEA Release" |

---

## How Domain Objects Work Together: Real Workflows

Let's see how these concepts combine to handle real business scenarios.

### Workflow 1: ESA+ Purchase from Marketplace Vendor

**The Story:**
A parent wants to buy $450 of curriculum materials from a marketplace vendor in ClassWallet.

**The Domain Objects Involved:**

1. **ScholarshipAccount** (Aggregate)
   - Current balance: $8,200
   - Award level: Base ($9,000)
   - Status: Active

2. **PurchaseRequest** (Aggregate)
   - Amount: $450
   - Category: Curriculum
   - Vendor: Curriculum Express (marketplace vendor)
   - Status: Will be set by process

3. **Vendor** (Entity within Vendor aggregate)
   - Name: Curriculum Express
   - Type: Marketplace Vendor
   - Status: Good Standing

**The Workflow Step by Step:**

```
1. Parent Action
   → Parent selects curriculum items in ClassWallet marketplace
   → Total: $450
   → Clicks "Purchase"

2. System Creates PurchaseRequest
   → PurchaseRequest.amount = $450
   → PurchaseRequest.category = "Curriculum"
   → PurchaseRequest.vendorId = "VENDOR-123"
   → PurchaseRequest.status = "Submitted"

3. ScholarshipAccount Validates Request
   → Check: balance ($8,200) >= amount ($450)? ✓ PASS
   → Check: category "Curriculum" is allowable? ✓ PASS
   → Check: not during ClassWallet shutdown? ✓ PASS
   → Check: curriculum supports core subjects? ✓ PASS

4. PurchaseRequest Approved
   → PurchaseRequest.status = "Approved"
   → PurchaseRequest.approve() method called

5. Domain Event Published
   → Event: PurchaseApproved
   → Data: {requestId, studentId, amount: $450, category: "Curriculum"}

6. Payment Context Receives Event
   → Initiates payment to Curriculum Express
   → Payment executes through ClassWallet

7. ScholarshipAccount Updated
   → ScholarshipAccount.debit($450)
   → New balance: $7,750
   → Total spent: $250 → $700

8. Tax Reporting Context Receives Event
   → Adds $450 to non-tuition spending total
   → Will generate 1099-G at year end if needed

9. Parent Notified
   → Notification: "Your purchase of $450 has been approved"
   → Updated balance: $7,750 shown in MyPortal
```

**Key Insights:**
- The **ScholarshipAccount aggregate** enforced all the business rules in one place
- **Domain events** let different contexts react without tight coupling
- The **ubiquitous language** (rollover, allowable expense) is clear throughout
- **Bounded contexts** (ESA+ Services, Payments, Tax Reporting) each handled their part

---

### Workflow 2: Service Provider Invoice Submission

**The Story:**
A tutoring provider submits an invoice for $600 of educational therapy services provided to a student.

**The Domain Objects Involved:**

1. **Provider** (Aggregate)
   - ProviderId: PROV-2024-456
   - Name: ABC Tutoring Services
   - Service Types: [Educational Therapy, Academic Tutoring]
   - Enrollment Status: Enrolled
   - Credentials: Valid teaching license, therapy certification

2. **ScholarshipAccount** (Aggregate)
   - Current balance: $7,750
   - Student: S-2024-789
   - Status: Active

3. **PurchaseRequest** (Aggregate)
   - Amount: $600
   - Category: Educational Therapy
   - ProviderId: PROV-2024-456

**The Workflow Step by Step:**

```
1. Provider Action
   → Provider logs into Provider Portal
   → Submits invoice for services rendered
   → Invoice: $600 for 12 hours of educational therapy
   → Uploads signed invoice document

2. System Creates PurchaseRequest
   → PurchaseRequest.amount = $600
   → PurchaseRequest.category = "Educational Therapy"
   → PurchaseRequest.providerId = "PROV-2024-456"
   → PurchaseRequest.supportingDocuments = [invoice.pdf]
   → PurchaseRequest.status = "Submitted"

3. Provider Aggregate Validates Enrollment
   → Provider.enrollmentStatus == "Enrolled"? ✓ PASS
   → Provider.credentials current? ✓ PASS
   → Provider.serviceTypes includes "Educational Therapy"? ✓ PASS

4. ScholarshipAccount Validates Request
   → Check: balance ($7,750) >= amount ($600)? ✓ PASS
   → Check: category "Educational Therapy" allowable? ✓ PASS
   → Check: provider enrolled? ✓ PASS (already validated)
   → Check: invoice document attached? ✓ PASS

5. PurchaseRequest Approved
   → PurchaseRequest.status = "Approved"
   → PurchaseRequest.approve() method called

6. Domain Event Published
   → Event: PurchaseApproved
   → Data: {requestId, studentId, amount: $600, 
            category: "Educational Therapy", providerId: "PROV-2024-456"}

7. Payment Context Receives Event
   → Initiates ACH payment to ABC Tutoring Services
   → Payment processed within 5-7 business days

8. ScholarshipAccount Updated
   → ScholarshipAccount.debit($600)
   → New balance: $7,150
   → Total spent: $700 → $1,300 (now exceeds minimum!)

9. Compliance Context Receives Event
   → Records spending in "Educational Therapy" category
   → Validates spending patterns (no anomalies)

10. Notifications Sent
    → Provider: "Payment of $600 approved, will arrive in 5-7 days"
    → Parent: "Educational therapy payment processed: $600"
    → Updated balance: $7,150 shown in MyPortal
```

**Key Insights:**
- The **Provider aggregate** enforced credential and enrollment rules
- Multiple validations across aggregates worked together smoothly
- **Domain events** coordinated Payment, Compliance, and Notification contexts
- Supporting documents (invoices) are part of the **PurchaseRequest aggregate**

---

### Workflow 3: Year-End Rollover for Higher Award Student

**The Story:**
Fiscal year ends June 30. A student with a higher award ($17,000) has $2,000 unused. System calculates rollover for next year.

**The Domain Objects Involved:**

1. **ScholarshipAccount** (Aggregate)
   - Award Level: Higher ($17,000)
   - Initial Award: $17,000
   - Total Spent: $15,000
   - Current Balance: $2,000
   - Fiscal Year: 2024

2. **Renewal** (Aggregate)
   - Student: S-2024-789
   - Status: Approved (student eligible for next year)
   - Minimum Spending Met: Yes ($15,000 > $1,000)

**The Workflow Step by Step:**

```
1. Year-End Trigger
   → System scheduled job runs on June 30
   → Identifies all active ScholarshipAccounts
   → For each account, initiates year-end processing

2. ScholarshipAccount for Student S-2024-789
   → Account found: Award Level = "Higher"
   → Current balance: $2,000
   → Total spent: $15,000

3. Renewal Aggregate Validates Eligibility
   → Check: totalSpent ($15,000) >= minimumSpendRequirement ($1,000)? ✓ PASS
   → Check: student still has disability determination? ✓ PASS
   → Check: parent signed new agreement for next year? ✓ PASS
   → Renewal.status = "Approved"

4. ScholarshipAccount Calculates Rollover
   → Method: ScholarshipAccount.calculateRollover()
   → Check: awardLevel == "Higher"? ✓ YES (rollover allowed)
   → Unused balance: $2,000
   → Rollover cap: $4,500
   → Cumulative balance cap: $30,000
   
   Calculation:
   → Eligible rollover = min($2,000, $4,500) = $2,000
   → Next year initial award: $17,000
   → Next year starting balance: $17,000 + $2,000 = $19,000
   → Check: $19,000 <= $30,000? ✓ PASS

5. Domain Event Published
   → Event: FundsRolledOver
   → Data: {studentId: "S-2024-789", 
            previousBalance: $2,000, 
            rolloverAmount: $2,000, 
            nextYearBalance: $19,000,
            fiscalYear: 2025}

6. New ScholarshipAccount Created
   → New account for fiscal year 2025
   → Balance: $19,000 ($17,000 award + $2,000 rollover)
   → Award level: Higher
   → Status: Active
   → Minimum spend requirement: $1,000

7. Old ScholarshipAccount Closed
   → FY 2024 account status = "Closed"
   → Final balance: $0
   → Archiving transaction history for audit

8. Tax Reporting Context Receives Event
   → Records rollover for IRS reporting
   → Updates cumulative spending records

9. Parent Notified
   → Notification: "Your unused funds of $2,000 have been 
      rolled over to next year"
   → Email: "Your new balance for 2025-2026: $19,000"
   → MyPortal updated with new account

Contrast: Base Award Student
→ If award level = "Base", rollover NOT allowed
→ Unused $2,000 would be returned to SEAA
→ Next year balance: $9,000 only (no rollover)
```

**Key Insights:**
- **Business rules** embedded in ScholarshipAccount aggregate (rollover logic)
- **Different behaviors** based on award level (higher vs. base)
- **Renewal aggregate** validates eligibility before rollover
- **Year boundaries** handled cleanly with new account creation
- **Domain events** trigger tax reporting and notifications

---

### Workflow 4: Accessory Purchase Validation

**The Story:**
A parent purchased a laptop (main device) on September 15 for $800. On October 5, they want to buy a laptop case (accessory) for $50.

**The Domain Objects Involved:**

1. **PurchaseRequest** (Main Device - Already Completed)
   - RequestId: REQ-2024-1001
   - Category: Educational Technology
   - Amount: $800
   - Item: Laptop
   - Date: September 15, 2024
   - Status: Paid

2. **PurchaseRequest** (Accessory - New Request)
   - Category: Educational Technology
   - Amount: $50
   - Item: Laptop case
   - Accessory Flag: true
   - Related Main Device: REQ-2024-1001
   - Date: October 5, 2024

3. **ScholarshipAccount**
   - Balance: $6,150
   - Recent technology purchases tracked

**The Workflow Step by Step:**

```
1. Parent Action
   → Parent browses ClassWallet marketplace
   → Selects laptop case ($50)
   → System detects this is an accessory (related to laptop)
   → Parent proceeds to purchase

2. System Creates PurchaseRequest
   → PurchaseRequest.amount = $50
   → PurchaseRequest.category = "Educational Technology"
   → PurchaseRequest.accessoryFlag = true
   → PurchaseRequest.status = "Submitted"

3. PurchaseRequest Validates Accessory Rules
   → Method: PurchaseRequest.validateAccessoryRules()
   
   Step 3a: Find Main Device Purchase
   → Search: Recent "Educational Technology" purchases
   → Found: REQ-2024-1001 (laptop, $800, Sept 15)
   → PurchaseRequest.relatedMainDeviceOrderId = "REQ-2024-1001"
   → PurchaseRequest.mainDeviceOrderDate = Sept 15, 2024

   Step 3b: Validate 30-Day Window
   → Current date: October 5, 2024
   → Main device date: September 15, 2024
   → Days elapsed: 20 days
   → Check: 20 <= 30? ✓ PASS

   Step 3c: Validate 3-Year Frequency
   → Search: Previous laptop case purchases for this student
   → Last laptop case purchase: None found
   → Check: No duplicate in past 3 years? ✓ PASS

4. ScholarshipAccount Validates Balance
   → Check: balance ($6,150) >= amount ($50)? ✓ PASS
   → Check: category allowable? ✓ PASS

5. PurchaseRequest Approved
   → PurchaseRequest.status = "Approved"
   → All validation rules passed

6. Domain Event Published
   → Event: PurchaseApproved
   → Data: {requestId, studentId, amount: $50, 
            category: "Educational Technology",
            isAccessory: true, relatedDevice: "REQ-2024-1001"}

7. Payment Processed
   → Payment to vendor
   → ScholarshipAccount.debit($50)
   → New balance: $6,100

8. Parent Notified
   → Notification: "Accessory purchase approved: $50"

Contrast: Violation Scenarios

Scenario A: Purchase Too Late
→ Parent tries to buy case on October 20 (35 days after laptop)
→ validateAccessoryRules() checks: 35 <= 30? ✗ FAIL
→ PurchaseRequest.reject("ACCESSORY_WINDOW_EXPIRED")
→ Parent notified: "Accessories must be purchased within 
   30 days of main device"

Scenario B: Duplicate Accessory
→ Parent tries to buy another laptop case 6 months later
→ validateAccessoryRules() finds previous case purchase
→ Check: Last purchase < 3 years ago? ✗ FAIL
→ PurchaseRequest.reject("DUPLICATE_ACCESSORY")
→ Parent notified: "Similar accessory already purchased. 
   One per 3 years allowed."
```

**Key Insights:**
- **Complex business rules** encapsulated in PurchaseRequest aggregate
- **Historical data** (previous purchases) used in validation
- **Clear rejection codes** help parents understand why denied
- **Time-based rules** (30-day window) enforced consistently
- Multiple validations work together to prevent misuse

---

### Workflow 5: Compliance Violation and Account Suspension

**The Story:**
System detects a parent used ESA+ funds to purchase prohibited items (non-educational games). Compliance review leads to account suspension.

**The Domain Objects Involved:**

1. **PurchaseRequest** (Problematic Purchase)
   - Amount: $120
   - Category: Educational Technology (claimed)
   - Actual Items: Video games (prohibited)
   - Status: Paid (already processed)

2. **ScholarshipAccount**
   - Balance: $6,100
   - Status: Active (will change)

3. **ComplianceRecord** (Aggregate - New)
   - ViolationType: Prohibited Purchase
   - Severity: High
   - Status: Under Investigation

**The Workflow Step by Step:**

```
1. Detection Trigger
   → Automated system flags suspicious purchase patterns
   OR
   → School/vendor reports misuse
   OR
   → Random audit selects account for review

2. Compliance Context Creates ComplianceRecord
   → ComplianceRecord.violationType = "Prohibited Purchase"
   → ComplianceRecord.studentId = "S-2024-789"
   → ComplianceRecord.amount = $120
   → ComplianceRecord.description = "Video games purchased 
      with ESA+ funds (non-educational)"
   → ComplianceRecord.status = "Under Investigation"
   → ComplianceRecord.severity = "High"

3. Domain Event Published
   → Event: ComplianceViolationDetected
   → Data: {studentId, violationType, amount, severity}

4. ScholarshipAccount Receives Event
   → Method: ScholarshipAccount.freeze()
   → ScholarshipAccount.status = "Suspended"
   → No new purchases can be approved while suspended
   → Existing approved purchases may still process

5. Notification Context Receives Event
   → Alert sent to SEAA compliance staff
   → Email to parent: "Your account has been temporarily 
      suspended pending review"
   → Details: Reason, next steps, contact info

6. Manual Compliance Review
   → Staff investigates purchase
   → Reviews supporting documents
   → Confirms prohibited item (video games)
   → Determines policy violation occurred

7. ComplianceRecord Updated
   → ComplianceRecord.status = "Confirmed Violation"
   → ComplianceRecord.resolution = "Account Termination"
   → ComplianceRecord.refundRequired = true
   → ComplianceRecord.refundAmount = $120

8. Domain Event Published
   → Event: AccountTerminated
   → Data: {studentId, reason: "Prohibited Purchase", 
            refundRequired: $120}

9. ScholarshipAccount Receives Termination Event
   → Method: ScholarshipAccount.terminate()
   → ScholarshipAccount.status = "Terminated"
   → Calculate total refund due: $120 (misused) + $6,100 (balance)
   → Total refund: $6,220

10. Payment Context Receives Event
    → Initiates refund process
    → Parent must return $6,220 to SEAA
    → Payment method: Check or ACH transfer

11. ParentAgreement Updated
    → ParentAgreement.terminated = true
    → ParentAgreement.terminationReason = "Prohibited Purchase"
    → Student ineligible for future ESA+ participation

12. Final Notifications
    → Parent: "Your ESA+ participation has been terminated 
       due to prohibited purchase. You must refund $6,220."
    → Legal: Termination letter with appeal rights
    → Future Applications: Student blocked from reapplying

Contrast: Minor Violation (Warning Only)

If violation was minor (e.g., late invoice submission):
→ ComplianceRecord.severity = "Low"
→ ComplianceRecord.resolution = "Warning Issued"
→ ScholarshipAccount.unfreeze() after warning
→ Account remains active with note on file
→ No refund required
```

**Key Insights:**
- **ComplianceRecord aggregate** tracks violations and resolutions
- **Account suspension** prevents further spending during investigation
- **Domain events** coordinate multiple contexts (Compliance, Account, Notifications, Payments)
- **Severity levels** determine different outcomes (warning vs. termination)
- **Refund process** integrated with termination workflow
- **Parent agreement** tracks termination status for future eligibility

---

## The Parts and Pieces: A Complete Picture

### Domain "Nouns" (What Things)

These are the **entities**, **value objects**, and **aggregates** that make up our domain:

| Noun | Type | What It Represents | Why It Matters |
|------|------|-------------------|----------------|
| Student | Entity | A child enrolled in a K-12 program | Core identity; everything else connects to students |
| Family/Parent | Entity | Guardian applying and managing scholarships | Primary user; makes decisions about funds |
| Application | Aggregate | Request for scholarship funding | Entry point to program; tracks eligibility |
| Award | Entity | Granted scholarship amount | Financial commitment to student |
| ScholarshipAccount | Aggregate | ESA+ fund wallet | Controls all spending; enforces rules |
| PurchaseRequest | Aggregate | Spending transaction | Every dollar spent goes through this |
| Provider | Aggregate | Service provider (tutor, therapist, transport) | Ensures only qualified providers get paid |
| Vendor | Entity | Product seller | Controls what products can be purchased |
| School | Entity | Educational institution | Receives funds (Opportunity Scholarship) |
| Expense Category | Value Object | Type of spending (tuition, curriculum, etc.) | Determines if purchase is allowed |
| Amount/Money | Value Object | Dollar amount and currency | All financial values |
| ComplianceRecord | Aggregate | Violation tracking and resolution | Enforces program integrity |
| Renewal | Aggregate | Annual re-enrollment | Determines continued eligibility |
| ParentAgreement | Aggregate | Legal contract with parent | Required before funds disbursed |

### Domain "Verbs" (What Actions)

These are the **operations**, **workflows**, and **processes** that act on domain objects:

| Verb/Action | What It Does | Which Aggregates Involved | Business Purpose |
|------------|--------------|---------------------------|------------------|
| **Apply** | Submit scholarship application | Application, Student, Family | Initiate participation |
| **Award** | Grant scholarship to student | Application → Award | Commit funding |
| **Activate** | Enable scholarship account | Award → ScholarshipAccount | Make funds available |
| **Purchase** | Spend ESA+ funds | ScholarshipAccount, PurchaseRequest | Pay for education services/products |
| **Approve** | Validate and authorize purchase | PurchaseRequest, ScholarshipAccount | Enforce spending rules |
| **Reject** | Deny purchase request | PurchaseRequest | Prevent prohibited spending |
| **Disburse** | Send payment to vendor/provider | PurchaseRequest → Payment | Complete transaction |
| **Enroll** (Provider) | Qualify provider for ESA+ payments | Provider | Control service quality |
| **Validate** | Check credentials/eligibility | Provider, Student, Application | Ensure compliance |
| **Suspend** | Temporarily block account | ScholarshipAccount, ComplianceRecord | Stop spending during investigation |
| **Terminate** | Permanently end participation | ScholarshipAccount, ParentAgreement | Remove from program |
| **Rollover** | Carry funds to next year | ScholarshipAccount | Preserve unused funds (higher award) |
| **Renew** | Continue for next school year | Renewal, ScholarshipAccount | Ongoing participation |
| **Refund** | Return misused or unused funds | ScholarshipAccount, Payment | Recover funds |
| **Audit** | Review spending compliance | ComplianceRecord, ScholarshipAccount | Ensure proper use |
| **Endorse** | Parent accepts award term | Award, Endorsement | Confirm semester participation (OS) |

---

## Relationships and Dependencies

Understanding how domain objects relate to each other is crucial. Here's a map of key relationships:

### Application → Award → ScholarshipAccount Flow

```
Family/Parent
    |
    | creates
    ↓
Application (aggregate)
    |
    | contains Student (entity)
    | contains Eligibility Documents
    | has Status (submitted → under review → awarded)
    |
    | when approved
    ↓
Award (entity)
    |
    | specifies Award Level (base $9K or higher $17K)
    | specifies Program Type (ESA+ or OS)
    |
    | when accepted by parent
    ↓
ScholarshipAccount (aggregate) — ESA+ only
    |
    | manages Balance
    | enforces Spending Rules
    | tracks PurchaseRequests
```

### Purchase Flow

```
Parent
    |
    | initiates purchase
    ↓
PurchaseRequest (aggregate)
    |
    | validates against
    ↓
ScholarshipAccount (aggregate)
    | 
    | checks Balance ≥ Amount?
    | checks Category allowed?
    | checks Account not Suspended?
    |
    | if service-based, validates
    ↓
Provider (aggregate)
    |
    | checks Enrollment Status = "Enrolled"?
    | checks Credentials current?
    |
    | if approved
    ↓
Payment Context
    |
    | executes payment
    ↓
Vendor or Provider receives funds
```

### Compliance Monitoring Flow

```
ScholarshipAccount
    |
    | spending activity monitored by
    ↓
Compliance Context
    |
    | detects potential violation
    ↓
ComplianceRecord (aggregate)
    |
    | investigates
    | determines resolution
    |
    | may trigger
    ↓
Account Suspension or Termination
    |
    | blocks further spending
    | requires refund
```

### Year-End Renewal Flow

```
ScholarshipAccount
    |
    | at fiscal year end (June 30)
    ↓
Renewal (aggregate)
    |
    | checks Minimum Spending Met ($1,000)?
    | checks Disability Determination still valid?
    | checks New ParentAgreement signed?
    |
    | if approved AND award level = "Higher"
    ↓
Rollover Calculation
    |
    | unused balance ≤ $4,500 → carry forward
    | new balance ≤ $30,000 cumulative cap
    |
    | creates
    ↓
New ScholarshipAccount (next fiscal year)
```

---

## How Aggregates Form a Cohesive Unit: The Purchase Example

Let's zoom in on a single business capability—**processing a purchase**—to see how multiple aggregates work together as a cohesive unit.

### The Participating Aggregates

1. **ScholarshipAccount** - Controls the money
2. **PurchaseRequest** - Represents the transaction
3. **Provider** (if service) or **Vendor** (if product) - Source of goods/services
4. **ComplianceRecord** - Monitors for violations

### The Interaction

```
┌─────────────────────────────────────────────────────────────┐
│                    PURCHASE WORKFLOW                         │
└─────────────────────────────────────────────────────────────┘

Step 1: Parent Initiates
  Parent → "I want to purchase $500 curriculum"

Step 2: PurchaseRequest Created
  ┌────────────────────────┐
  │   PurchaseRequest      │
  │  - amount: $500        │
  │  - category: Curriculum│
  │  - status: Submitted   │
  └────────────────────────┘

Step 3: ScholarshipAccount Validates
  ┌────────────────────────┐
  │  ScholarshipAccount    │
  │  - balance: $6,100     │
  │  - status: Active      │
  │                        │
  │  Checks:               │
  │  ✓ $6,100 >= $500     │
  │  ✓ Curriculum allowed  │
  │  ✓ Account not frozen  │
  └────────────────────────┘

Step 4: Vendor Validates
  ┌────────────────────────┐
  │       Vendor           │
  │  - type: Marketplace   │
  │  - status: Good        │
  │                        │
  │  ✓ Vendor active       │
  └────────────────────────┘

Step 5: PurchaseRequest Approved
  ┌────────────────────────┐
  │   PurchaseRequest      │
  │  - status: Approved → │
  │    PublishEvent:       │
  │    "PurchaseApproved"  │
  └────────────────────────┘

Step 6: ScholarshipAccount Debits
  ┌────────────────────────┐
  │  ScholarshipAccount    │
  │  - balance: $6,100     │
  │    - $500              │
  │  → balance: $5,600     │
  └────────────────────────┘

Step 7: Payment Executes
  Payment Context → Vendor receives $500

Step 8: ComplianceRecord Monitors
  ┌────────────────────────┐
  │   ComplianceRecord     │
  │  Records:              │
  │  - $500 curriculum     │
  │  - Pattern: Normal     │
  │  - No flags            │
  └────────────────────────┘
```

### What Makes This Cohesive?

1. **Single Transaction Boundary**: All validations and balance updates happen together—you can't have a purchase approved without the balance being debited.

2. **Clear Responsibilities**: 
   - PurchaseRequest manages the transaction lifecycle
   - ScholarshipAccount protects the money
   - Vendor confirms they can fulfill
   - ComplianceRecord watches for problems

3. **Domain Events Coordinate**: The PurchaseApproved event lets other contexts react without the aggregates being tightly coupled.

4. **Business Rules Enforced**: Every rule (balance check, category validation, spending limits) is enforced consistently.

5. **Invariants Protected**: No aggregate can get into an invalid state (negative balance, invalid status transition, etc.).

---

## Common Questions from Stakeholders

### Q: Why not just use a database with tables?

**A:** Databases are important, but they're just for *storage*. Domain-Driven Design is about modeling the *behavior* and *rules* of your business. 

- A database row for "ScholarshipAccount" with a balance column doesn't know it can't go negative
- A database table doesn't enforce that accessories must be purchased within 30 days
- Database foreign keys don't capture the rich relationships like "Provider must be enrolled to receive payments"

DDD models these rules in the domain objects, then *persists* them to a database. The domain model is the brain; the database is the memory.

### Q: Isn't this overcomplicating things?

**A:** For simple CRUD (Create, Read, Update, Delete) applications, DDD might be overkill. But when you have:
- Complex business rules (like rollover calculations with caps)
- Multiple workflows that interact (purchase → payment → tax reporting)
- Compliance requirements (audit trails, fraud detection)
- Rules that change frequently

...then DDD provides the structure to manage that complexity without creating a tangled mess.

### Q: Do we need to use all these concepts?

**A:** Not necessarily! Use what makes sense for your context:
- Small, simple domains might only need Entities and Value Objects
- Medium complexity might add Aggregates
- Large, complex systems benefit from Bounded Contexts and Domain Events

Start simple and add structure as complexity grows.

### Q: How does this relate to our APIs and user interfaces?

**A:** The domain model is the *core* of your system. APIs and UIs are built *around* it:

```
User Interface (Web, Mobile)
        ↓
    API Layer
        ↓
  Application Services (orchestrate workflows)
        ↓
   Domain Model (business logic and rules)
        ↓
  Infrastructure (database, external systems)
```

The UI presents choices to users (e.g., "Select curriculum to purchase").
The API receives the request (e.g., POST /purchase-requests).
Application services coordinate (e.g., "Create purchase, validate with account, process payment").
The Domain Model enforces rules (e.g., "Balance must be sufficient").
Infrastructure persists the results (e.g., save to database).

### Q: What happens when requirements change?

**A:** That's where DDD shines! Because business rules are explicit in the domain model (not scattered in SQL queries and UI code), you can change them in one place.

Example: "Rollover cap changes from $4,500 to $5,000"
- Change: ScholarshipAccount.rolloverCap = $5,000
- All rollover calculations automatically use new cap
- Tests update with new expected values
- Done!

### Q: How do we test this?

**A:** Domain objects are highly testable because they're independent of databases and UIs:

```
Test: "ScholarshipAccount prevents overspending"

1. Create ScholarshipAccount with balance = $100
2. Create PurchaseRequest for $150
3. ScholarshipAccount.validatePurchase(request)
4. Assert: Validation fails with "INSUFFICIENT_BALANCE"
```

No database needed. No web server needed. Just pure business logic testing.

---

## Benefits of DDD for Our K-12 System

### 1. **Alignment with Business**
- Software matches how SEAA staff think about the domain
- Terms like "rollover," "allowable expense," "provider enrollment" are used consistently
- Business experts can read and validate the model

### 2. **Flexibility for Change**
- Program rules change (e.g., new spending categories)
- Domain model adapts without massive rewrites
- Changes are localized to specific aggregates

### 3. **Clear Boundaries**
- ESA+ Services context vs. Opportunity Scholarship context
- Teams can work independently on different contexts
- Integration points are explicit

### 4. **Audit and Compliance**
- Domain events create audit trail
- ComplianceRecord aggregate tracks violations
- Rules enforced consistently every time

### 5. **Scaling**
- Each bounded context can scale independently
- Payment context under high load? Scale it separately
- Notification context slow? Optimize it without touching others

---

## Next Steps for Your Team

### 1. **Learn the Ubiquitous Language**
- Familiarize yourself with terms in this document
- Use the same terminology in conversations and code
- Challenge inconsistencies: "Is that a Provider or a Vendor?"

### 2. **Identify Domain Objects in Your Area**
- If working on payments: understand PurchaseRequest, ScholarshipAccount
- If working on compliance: understand ComplianceRecord, Renewal
- If working on applications: understand Application, Award

### 3. **Understand the Workflows**
- Walk through the workflows in this document
- See how your area fits into the bigger picture
- Identify dependencies with other contexts

### 4. **Review Existing Code**
- Map existing code to domain concepts
- Identify where domain logic might be scattered
- Look for opportunities to consolidate rules into aggregates

### 5. **Collaborate Across Contexts**
- Understand which domain events your context publishes
- Know which events your context subscribes to
- Ensure clean integration points between contexts

---

## Glossary of DDD Terms

| Term | Simple Definition | Example from Our Domain |
|------|------------------|------------------------|
| **Domain** | The subject area your software addresses | K-12 scholarship administration |
| **Entity** | A thing with unique identity that changes over time | Student, ScholarshipAccount, Provider |
| **Value Object** | A thing with no identity; interchangeable if same values | Money ($500), Address, ExpenseCategory |
| **Aggregate** | A cluster of objects treated as a unit with one root | ScholarshipAccount (root) contains PurchaseRequests |
| **Aggregate Root** | The entry point entity that controls an aggregate | ScholarshipAccount controls all transactions within it |
| **Domain Event** | Something significant that happened in the past | PurchaseApproved, AccountSuspended |
| **Bounded Context** | A boundary within which a domain model applies | ESA+ Services context, Compliance context |
| **Ubiquitous Language** | Common vocabulary used by everyone | "Rollover," "allowable expense," "endorsement" |
| **Invariant** | A rule that must always be true | "Balance can never be negative" |
| **Repository** | Mechanism for retrieving and storing aggregates | ScholarshipAccountRepository |
| **Application Service** | Coordinates workflow across multiple aggregates | PurchaseProcessingService |
| **Domain Service** | Business logic that doesn't fit in one aggregate | RolloverCalculationService |

---

## Visual Summary: The Big Picture

```
┌─────────────────────────────────────────────────────────────────────┐
│                    K-12 SCHOLARSHIP DOMAIN MODEL                     │
└─────────────────────────────────────────────────────────────────────┘

BOUNDED CONTEXTS:
┌───────────────────────┐  ┌────────────────────┐  ┌──────────────────┐
│  K-12 Scholarship     │  │  ESA+ Services     │  │  Compliance &    │
│  Administration       │  │                    │  │  Audit           │
│                       │  │                    │  │                  │
│  • Application        │  │  • ScholarshipAcct │  │  • Compliance    │
│  • Award              │  │  • PurchaseRequest │  │    Record        │
│  • SchoolChoice       │  │  • Provider        │  │  • Renewal       │
│  • Endorsement (OS)   │  │  • Vendor          │  │  • ParentAgreemt │
└───────────────────────┘  └────────────────────┘  └──────────────────┘
         │                          │                        │
         └──────────────┬───────────┴────────────┬───────────┘
                        │                        │
                    DOMAIN EVENTS              DOMAIN EVENTS
                (AwardActivated,           (ComplianceViolation,
                 PurchaseApproved,         AccountSuspended,
                 FundsRolledOver)          RenewalRejected)
                        │                        │
         ┌──────────────┴────────────────────────┴──────────────┐
         │                                                       │
┌───────────────────┐  ┌──────────────────┐  ┌─────────────────────┐
│  Identity &       │  │  Payments        │  │  Notifications      │
│  Residency        │  │                  │  │                     │
│                   │  │  • Disbursement  │  │  • Email            │
│  • Family/Parent  │  │  • Refund        │  │  • SMS              │
│  • Student        │  │  • ACH Transfer  │  │  • Portal Message   │
│  • Residency      │  │                  │  │                     │
└───────────────────┘  └──────────────────┘  └─────────────────────┘

KEY AGGREGATES:
• Application → manages application lifecycle
• ScholarshipAccount → controls money and spending
• PurchaseRequest → represents transactions
• Provider → manages service provider enrollment
• ComplianceRecord → tracks violations and resolutions
• Renewal → handles year-to-year continuation

KEY WORKFLOWS:
1. Apply → Award → Activate Account → Purchase → Pay
2. Service Provider → Enroll → Submit Invoice → Get Paid
3. Year End → Check Spending → Calculate Rollover → Renew
4. Detect Violation → Investigate → Suspend → Resolve
5. Purchase Accessory → Validate Timing → Approve/Reject
```

---

## Conclusion

Domain-Driven Design provides a structured way to think about complex business systems. By focusing on:
- **Domain objects** (entities, value objects, aggregates) that model real things
- **Ubiquitous language** that everyone uses consistently
- **Bounded contexts** that organize complexity
- **Domain events** that coordinate behavior
- **Business rules** embedded in the model

...we create software that truly serves the business needs of North Carolina's K-12 scholarship programs.

The key is not to get overwhelmed by the terminology. Start with understanding the "things" (Student, Account, Purchase) and "actions" (Apply, Approve, Disburse), then gradually layer in the more sophisticated patterns (aggregates, events, contexts) as needed.

This approach ensures our system can grow and adapt as program requirements evolve, while maintaining integrity, compliance, and clarity.

---

## Additional Resources

For deeper exploration of these concepts:

- **Existing Research Documents in This Repository:**
  - `ddd-1.md` - Comprehensive domain analysis across all NCSEAA programs
  - `ddd-2.md` - Focused ESA+ and Opportunity Scholarship domain details
  - `aggregate-details-enhancement.md` - Detailed aggregate specifications with workflows

- **Official DDD Resources:**
  - "Domain-Driven Design" by Eric Evans (the original book)
  - "Implementing Domain-Driven Design" by Vaughn Vernon
  - Online communities: DDD Community, Explore DDD conference

- **Questions?**
  - Review the workflow examples in this document
  - Discuss with your team lead
  - Collaborate with domain experts (SEAA staff) to clarify business rules
