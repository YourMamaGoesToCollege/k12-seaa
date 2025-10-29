# Awards Schema

Of course. Based on the provided materials, here is a detailed analysis focusing specifically on the database schema's implementation of the `Awards` and `Awarding` processes for the K12 scholarship programs.

### **Analysis of the K12 Scholarship Awarding Schema**

This analysis evaluates the database schema's capacity to model and support the complex and distinct awarding, calculation, and disbursement processes for the North Carolina Opportunity Scholarship (OS) and ESA+ programs. The evaluation reveals significant architectural and structural deficiencies that directly impede the correct implementation of critical business rules and create substantial risks to data integrity and financial accountability.

#### **Section 1: Analysis of the Opportunity Scholarship (OS) Awarding Model**

The Opportunity Scholarship awarding process is fundamentally income-based, multi-tiered, and dependent on a sequential workflow for disbursement. The current schema fails to adequately model these core domain concepts.

**Critique of Award Tier and Income Modeling**
A review of the schema indicates that the calculation and representation of the OS award are critically flawed. The schema appears to store a final, calculated `AwardAmount` directly in a generalized table. This approach overlooks the nuanced, multi-step logic required by the program.

* **Incorrect Income Modeling:** The schema seems to use a single, generic column for `HouseholdIncome`. This is a severe oversimplification. Program regulations mandate a complex calculation based on the Federal Free and Reduced-Price Lunch guidelines, which includes gross income from all sources for all household members and explicitly excludes using the Adjusted Gross Income (AGI) from tax forms.[1, 2] A single field cannot capture the components of this calculation, making the process unauditable and prone to error.
* **Failure to Model `AwardTier`:** The central concept of an `AwardTier`—the primary determinant of the maximum scholarship amount based on household size and income—is absent from the schema.[1, 3] For the 2025-2026 school year, these tiers determine maximum awards ranging from $3,458 to $7,686.[3] By storing a final amount instead of the determined `AwardTier`, the schema engages in the poor practice of storing a calculated value.[4] This is particularly problematic because the final disbursement amount is the lesser of the award tier's maximum value and the school's actual tuition and fees.[5, 6] If a school updates its tuition schedule, any statically stored award amount becomes incorrect, leading to potential over- or under-payment.

**Critique of Disbursement Workflow Modeling**
The disbursement of OS funds is not a single event but a stateful workflow that must be executed each semester. The schema lacks the structure to manage this process.

* **Missing Workflow States:** The process requires a specific sequence of actions in the MyPortal system before funds are released: the school must certify enrollment and costs, and then for each semester, both the school and the parent must endorse the final award amount.[7, 8, 9] The schema fails to model these distinct states (e.g., `PendingSchoolCertification`, `PendingParentEndorsement`, `FallPaymentDisbursed`). A single, generic `Status` column is insufficient to manage or audit this critical financial workflow, forcing complex state management into the application layer where it is harder to maintain and verify.

#### **Section 2: Analysis of the ESA+ Awarding and Financial Management Model**

The ESA+ program operates on a completely different model from the OS program, with fixed award amounts based on disability, not income, and a unique financial disbursement mechanism through a third-party platform. The schema fails to capture any of these fundamental distinctions.

**Critique of Award Level Modeling**
The schema conflates the OS and ESA+ awards into a single, monolithic structure, demonstrating a critical misunderstanding of the domain.

* **Generic and Incorrect Award Representation:** The use of a generic `AwardAmount` field for ESA+ is incorrect. ESA+ awards are fixed amounts: a base level of $9,000 and a higher level of $17,000 for students with specific, designated disabilities (e.g., autism, hearing impairment).[10, 11] The schema does not store the `AwardLevel` ('Base' or 'Higher') nor does it link the award to the underlying disability verification that justifies it. This generic model completely obscures the actual business rules of the ESA+ program.

**Critique of `ClassWallet` and Expense Management**
A defining feature of the ESA+ program is its use of the `ClassWallet` platform for financial management, which is entirely unrepresented in the database schema.[12, 13]

* **No `ClassWallet` Integration Model:** There are no tables or structures to model the transfer of funds to `ClassWallet`, track the available balance, or reconcile expenditures. This is a massive architectural omission, as the core financial transactions of the ESA+ program occur outside the system with no corresponding data model inside it.
* **No `AllowableExpense` Tracking:** The schema lacks any tables to define or track `AllowableExpenses`—a primary function of the ESA+ program that allows parents to pay for services like tutoring and therapy, or products like curricula and educational technology.[14]
* **Unsupported Business Rules:** Complex financial rules, such as the policy allowing the rollover of up to $4,500 in unspent funds for the higher award tier, are impossible to implement or enforce with the current schema.[15]

This absence of financial modeling means the system cannot perform its core function of accounting for the use of ESA+ funds, representing a complete failure to meet business requirements and a significant financial control risk.

#### **Section 3: Overarching Architectural Flaws in the Awarding Model**

The specific issues in the OS and ESA+ models are symptoms of deeper architectural flaws rooted in a failure to apply fundamental design principles.

**Violation of Bounded Contexts**
The most severe architectural flaw is the monolithic design that forces the entirely distinct OS and ESA+ awarding models into a single set of tables. In Domain-Driven Design (DDD), these are two separate Bounded Contexts, each with its own unique language, rules, and data.[16, 17]

* **Impact of Monolithic Design:** This violation results in a "God Table" anti-pattern, characterized by numerous nullable columns (e.g., `HouseholdIncome` is null for ESA+, `DisabilityType` is null for OS). This structure inevitably leads to convoluted, brittle application code filled with conditional logic, and creates high coupling between unrelated parts of the system, making maintenance and future development exceedingly difficult and slow.[18]

**Absence of an `Award` Aggregate and Relational Integrity**
The schema treats an `Award` as a simple, disconnected row of data rather than as part of a cohesive business transaction.

* **Lack of Aggregates:** An `Award` should be part of an `AnnualEnrollment` Aggregate—a cluster of objects (Student, School Year, Application, Award) that are treated as a single unit to ensure consistency.[17]
* **Missing Foreign Keys:** The schema is devoid of enforced `FOREIGN KEY` constraints between the `Awards` table and the `Students`, `Applications`, and `Schools` tables. This means the database itself cannot prevent the creation of an award for a non-existent student or the deletion of a student that leaves an orphaned award record.[19, 4] This lack of referential integrity represents a critical risk to data consistency.

#### **Section 4: Strategic Recommendations for the Awarding Schema**

To rectify these deficiencies, a fundamental redesign of the awarding-related schema is required. The following recommendations provide a clear path toward a robust, maintainable, and domain-aligned database structure.

**Recommendation 1: Decompose the `Award` Model by Bounded Context**
Abandon the monolithic `Awards` table and create physically separate structures that align with the business domains.

* **Create `OS_Awards` Table:** This table should store `AnnualEnrollmentID`, `HouseholdSize`, `CalculatedHouseholdIncome`, and a foreign key to an `OS_AwardTiers` table. It must not store a static, final award amount.
* **Create `ESA_Awards` Table:** This table should store `AnnualEnrollmentID`, an `AwardLevel` field ('Base' or 'Higher'), and a foreign key to the `DisabilityVerifications` table.

**Recommendation 2: Explicitly Model Workflows and Financials**
Introduce tables that directly model the flow of money and the state of the disbursement process.

* **Create `Disbursements` Table:** This table should be linked to both `OS_Awards` and `ESA_Awards`. It should contain columns for `Semester` (Fall/Spring), `Amount`, `SchoolCertificationDate`, `ParentEndorsementDate`, `PaymentTransactionID`, and `Status`. This makes the entire payment lifecycle auditable.
* **Create `ESA_AllowableExpenses` and `ESA_Transactions` Tables:** For the ESA+ context, model the `ClassWallet` ecosystem. An `ESA_Transactions` table should track the movement of funds to `ClassWallet`. An `ESA_AllowableExpenses` table should record every approved purchase or payment, linking it to the `ESA_Award` and a `ServiceProviders` table.

**Recommendation 3: Enforce Relational Integrity**
This is a non-negotiable foundational step.

* **Implement Foreign Keys:** Every relationship must be enforced with a `FOREIGN KEY` constraint. The new award tables must have enforced links to `AnnualEnrollments`, which in turn links to `Students` and `Schools`. This is the only way to guarantee data integrity at the database level.[20, 21]
