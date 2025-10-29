# DDD Rules Engine Analysis for K12

This Domain-Driven Design (DDD) analysis outlines the necessary components, contexts, and implementation strategy for the modernization of the North Carolina K12 Scholarship system, focusing heavily on financial management, compliance, and monetary transactions, particularly involving the General Ledger (GL) function and the ClassWallet platform.

## 1. Architectural Approach and DDD Strategy

The recommended approach, aligning with principles like **CLEAN Architecture** or a **Modular Monolith**, separates core business logic (the Domain Layer) from external services and user interfaces. This structure ensures that critical financial rules and policies, which are excellent candidates for a Rule Engine, are consistent, testable, and isolated from fluctuating external systems like the ClassWallet API or state agency integrations.

**Key Architectural Principle:** **Policy Externalization**. Business rules governing award calculation, minimum spending, allowable expenses, and technology frequency limits should be managed by a dedicated **Rule Engine Service** or Policy Module layer to enhance testability and consistency.

## 2. Bounded Contexts (Domains)

The modernization effort encompasses several distinct bounded contexts, managing specific areas of the K12 scholarship domain:

| Context                                   | Core Aggregate(s)                                   | Domain Focus                                                                                                                                    |
| :---------------------------------------- | :-------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------- |
| **A. ESA+ Wallet, Purchasing & Expenses** | `ScholarshipAccount`, `PurchaseRequest`             | The central financial hub managing funds, debits, credits, compliance spending, and integration with ClassWallet. **(High Monetary Focus)**     |
| **B. Awarding & Funding**                 | `AwardOffer`, `ScholarshipAward`, `PaymentSchedule` | Managing eligibility confirmation, lottery outcomes, award tiers, deadlines, and the active status of scholarships.                             |
| **C. Compliance & Agreements**            | `ParentAgreement`, `ComplianceRecord`, `LEARelease` | Enforcing legal obligations, tracking misuse, suspensions, terminations, and securing annual parent contracts.                                  |
| **D. Reporting & Tax**                    | `TaxReport1099G`, `Program Analytics`               | Managing financial reporting obligations, specifically accumulating non-tuition spend for IRS compliance (1099-G). **(High Monetary/GL Focus)** |
| **E. Application & Eligibility**          | `Application`, `OS IncomeVerification`              | Handling initial intake, document submission (EDD), income calculation, and verification sampling.                                              |
| **F. Domicile Verification**              | `DomicileDetermination`, `VerificationCase`         | Statutory validation of NC residency using inter-agency cooperation (DMV, DPI, Revenue, DHHS, etc.).                                            |
| **G. School Choice & Enrollment**         | `SchoolChoice`, `EnrollmentRecord`, `School`        | Tracking student placement (Direct Payment, Home School, Reimbursement), transfers, and school registration status.                             |
| **H. Provider Enrollment**                | `ProviderEnrollment`, `Provider`                    | Vetting and registering third-party service providers (tutors, therapists) who accept ESA+ funds.                                               |
| **I. Renewal & Eligibility Lifecycle**    | `Renewal`, `DisabilityReevaluation`                 | Managing annual re-qualification, minimum spend verification, and the 3-year disability re-evaluation cycle.                                    |

## 3. Operations, Workflows, and Monetary/GL Focus

Monetary transactions underpin the entire system. Funds flow in two primary ways: Direct Disbursement (SEAA to School) and Wallet Spending (SEAA/ClassWallet to Providers/Vendors). The system must operate with eventual consistency, especially where the SEAA `ScholarshipAccount` interacts with the external ClassWallet ledger.

### Core Financial Aggregates and ClassWallet Integration

| Aggregate / System                   | Domain Role & Workflow                                                                                                                                                             | Monetary/GL Significance                                                                                                                                                                                                  |
| :----------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **`ScholarshipAccount`**             | The digital wallet tracking the available `balance`, `initialAwardAmount`, `totalSpent`, and eligibility for `rollover`. Debits occur when a `PurchaseRequest` is approved.        | **Core Ledger:** Holds the authoritative balance and enforces key invariants like balance $\leq$ cumulative cap (\$30,000) and balance cannot go negative.                                                                |
| **`PurchaseRequest`**                | Represents any attempt to spend ESA+ funds (marketplace order, invoice, payment request). It moves through states: submitted, underReview, approved, rejected, paid, rolledBack.   | **Transaction Enforcement:** Triggers the debit operation on the `ScholarshipAccount` and requires rigorous rules validation before payment execution.                                                                    |
| **ClassWallet**                      | The third-party platform contracted by SEAA that hosts the electronic account, manages the marketplace, facilitates vendor payments, and captures invoices/receipts digitally.     | **External Payment Rail:** Handles the actual fund transfer (`pay()` operation) to Vendors and Providers. SEAA must integrate via APIs/webhooks to sync the ClassWallet ledger back to the internal `ScholarshipAccount`. |
| **Direct Payment**                   | Workflow for paying tuition/fees directly to participating Direct Payment Schools (OS and ESA+). Requires annual school **Certification** and per-semester **Parent Endorsement**. | **Disbursement GL:** Funds flow from SEAA's internal GL system to the school's bank account (ACH). Dual Award logic (OS funds applied first, then ESA+ residual moves to ClassWallet) is critical.                        |
| **Tax Reporting (`TaxReport1099G`)** | Accumulates ESA+ funds spent on non-tuition allowable expenses throughout the *calendar year* (Jan 1 - Dec 31) for IRS Form 1099-G generation.                                     | **Compliance GL:** Tracks reportable income. Funds spent on tuition/required fees are specifically excluded from 1099-G reporting.                                                                                        |

### Operations and Workflows (Monetary & Rules-Driven)

| Workflow/Operation                  | Key Tasks/Contexts Involved                                                                                                                                                | Rule Engine Use Case                                                                                                                                                                                                                                   |
| :---------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ESA+ Allowable Expense Purchase** | Parent submits `PurchaseRequest` (Marketplace/Pay Vendor); SEAA/System staff validates against allowable categories, frequency rules, and documentation requirements.      | **Mandatory Rule Engine:** Must enforce **Allowable/Prohibited Expense** lists; validate **Accessory Timing/Frequency** (e.g., 30 days/3 years); validate **Provider Enrollment Status**; ensure **Curriculum** supports core academic subjects.       |
| **OS Award Tier Calculation**       | Parent reports household income and size for the previous calendar year (2024 income for 2025-26). System determines the specific scholarship amount (Tier 1, 2, 3, or 4). | **Mandatory Rule Engine:** Must apply complex **Income Calculation Rules** (gross wages, net self-employment income, exclusions like foster payments/Combat Pay); determine **Award Tier** based on household size and income limits.                  |
| **Endorsement & Disbursement**      | School certifies enrollment/cost (August). Parent performs `ParentEndorsement` via MyPortal each semester (Fall/Spring) to authorize payment to the Direct Payment School. | **Strong Rule Engine Candidate:** Enforces the **case-sensitive validation** of the parent's name to authorize funds; verifies that the school is an Active Direct Payment School.                                                                     |
| **Year-End Renewal Check**          | At the end of the school year, the system evaluates the student’s spending and rollover eligibility before offering renewal.                                               | **Mandatory Rule Engine:** Enforces the **Minimum Spend Requirement** ($\geq$ $1,000$ on allowable expenses); calculates **Rollover eligibility and caps** ($\leq$ $4,500$ rollover, $\leq$ $30,000$ cumulative balance, only for higher award level). |
| **Transaction Fees/Limits**         | When a parent pays a provider or vendor, the system must validate the associated transaction fee.                                                                          | **Strong Rule Engine Candidate:** Must enforce the **Transaction Fee Limit** (fee cannot exceed 2.5% of the item/service cost).                                                                                                                        |

## 4. Rule Engine Implementation

Implementing a Rule Engine (RE) within the Domain Layer (or Application Layer, separate from the UI and Persistence) is crucial for enforcing the complex and compliance-heavy invariants of the K12 system.

### Architectural Placement

Following a layered or CLEAN approach, the Rule Engine acts as a **Policy Service** or **Domain Service**.

* When a `PurchaseRequest` command is received, the `ScholarshipAccount` Aggregate Root calls the **Policy Service** to validate the request against current program rules (e.g., allowable category, accessory constraints, sufficient balance).
* The Policy Service reads the externalized rules (e.g., configuration, policy definitions) and returns a list of validation results or rejection codes.

### Key Rule Engine Candidates (Monetary/Compliance Focus)

The rules below are highly complex, statutory, or subject to policy changes, making them ideal for a Rule Engine:

1. **Monetary/Financial Rules (ESA+ `ScholarshipAccount` Invariants):**
    * **Rollover Eligibility:** If `awardLevel` is "base," rollover is prohibited; if "higher," funds up to $4,500 can roll over, provided the resulting `cumulativeBalance` does not exceed $30,000.
    * **Minimum Spending:** `totalSpent` must be $\geq$ $1,000$ annually to maintain renewal eligibility.

2. **Purchase/Transaction Validation Rules (`PurchaseRequest` Invariants):**
    * **Prohibited Items/Allowable Categories:** Enforcing the comprehensive list of non-allowable expenses (e.g., household items, consumable supplies, entertainment).
    * **Educational Technology Constraints:** If `accessoryFlag == true`, must validate that the purchase timestamp is within 30 days of the `relatedMainDeviceOrderId` purchase date AND that the 3-year frequency limit for major devices/accessories is met.
    * **Service Provider Compliance:** If a service (tutoring, therapy) is requested, the associated `providerId` must have an `enrollmentStatus == enrolled`.
    * **Transportation Documentation:** If `category` is "transportation," the first invoice must include the `signed contract`.

3. **OS Income/Eligibility Calculation Rules:**
    * **Income Calculation Model:** Standardized calculation method based on Federal Free and Reduced-Price Lunch guidelines. The RE must process inputs (gross wages, net self-employment, specific exclusions like Combat Pay or foster care payments) to determine the final household income for the 2024 calendar year.
    * **Award Tier Determination:** Mapping the final income and household size to the correct Award Tier (1, 2, 3, or 4) to determine the scholarship amount.

By externalizing these rules, the system gains **consistency** (all purchasing paths run the same validation rules), **testability** (rules can be unit-tested without external dependencies), and **architectural implementation** in a dedicated layer, decoupling the complexity from the core business entities.

## 5. Summary of High-Focus Monetary Workflows

The system's modernization must ensure compliance and accuracy across these key monetary workflows:

1. **Fund Allocation/Activation:** Creating the `ScholarshipAccount` aggregate with the correct `initialAwardAmount` (Base \$9,000 or Higher \$17,000 for ESA+, or Tier 1-4 for OS) once the `AwardOffer` is accepted and the `ParentAgreement` is signed.
2. **Direct Disbursement (SEAA GL):** Executing ACH payments to schools following the twice-per-year schedule (Fall: Aug/Sep; Spring: Jan/Feb) only after both school Certification and Parent Endorsement are complete.
3. **Wallet Management (ClassWallet GL/Sub-Ledger):** Managing the fund transfer event (`FundsMovedToWallet`) when residual ESA+ funds remain after tuition payments or for Home School students. This requires reliable integration with ClassWallet.
4. **Transaction Processing:** Handling the full lifecycle of a `PurchaseRequest`, which validates rules against the Policy Service, reserves/debits funds from the `ScholarshipAccount`, and triggers the payment via ClassWallet.
5. **Tax Compliance (1099-G):** Aggregating and finalizing non-tuition spending totals (`nonTuitionSpendingAmount`) at the close of the calendar year (Dec 31) to fulfill the 1099-G reporting requirement to the IRS and parents by the following January 31 deadline.
6. **Recoupment/Refunds:** Implementing the `rollback()` method on the `ScholarshipAccount` and `PurchaseRequest` when misuse is detected, requiring the parent to return misused funds. This links the financial aggregates directly to the `ComplianceRecord`.
