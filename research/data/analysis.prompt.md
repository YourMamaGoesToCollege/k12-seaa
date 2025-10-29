
Analysis and Strategic Recommendations for the K12 Scholarship Program Database Schema


Section 1: The North Carolina K12 Scholarship Domain Model

A robust and maintainable software system must be founded upon a precise and nuanced model of its business domain. Before any critique of the existing database schema can be undertaken, it is imperative to first establish a clear and comprehensive model of the North Carolina K12 Scholarship landscape. This domain model, derived from an extensive review of program documentation and regulations, serves as the objective benchmark against which the current implementation will be measured. The domain is principally administered by the North Carolina State Education Assistance Authority (NCSEAA) and comprises two distinct, yet related, scholarship programs: the Opportunity Scholarship (OS) and the Education Student Accounts (ESA+).1 This section deconstructs the domain into its core participants, processes, and rules, organizing them according to the principles of strategic design to reveal the domain's natural structure.

1.1 Core Participants and Lifecycles: Modeling the Student, Parent/Family, and School Entities

The K12 scholarship ecosystem revolves around three primary actors, each with a distinct lifecycle, set of attributes, and responsibilities. A failure to model these entities and their interactions accurately will result in a system that cannot support the required business processes.

1.1.1 The Student Entity

The Student is the central entity for whom the scholarship is awarded. A student's journey through the system is not a static record but a lifecycle that spans multiple years and involves several state transitions. This lifecycle includes initial application, determination of eligibility, acceptance or declination of an award, enrollment in a participating school, annual renewal of the scholarship, and potential transfers between schools during an academic year.3
Key attributes and rules governing the Student entity are critical for data collection:
Eligibility Criteria: A student must be a resident of North Carolina and entering a grade from Kindergarten to 12th.3 The system must enforce specific age requirements: a student must be at least 5 years old by August 31 or at least 4 years old by April 16 and be approved for Kindergarten according to state guidelines.3 Furthermore, the student must not have already graduated from high school.6
Residency: Residency is a strict requirement, confirmed on the day the student's school year begins.3 The system must be capable of capturing and potentially verifying residency documentation, such as a North Carolina driver's license or state tax filings.8

1.1.2 The Parent/Guardian and Household Entity

The Parent or Guardian is the primary user interacting with the system on behalf of the student. This interaction is facilitated through a centralized portal known as MyPortal.3 The parent is responsible for the complete application lifecycle, including submitting the initial application, providing necessary documentation for verification, formally accepting award offers, and, in the case of the ESA+ program, managing the disbursement of funds for approved expenses.5
A crucial concept associated with the parent is the Household. For the Opportunity Scholarship, the definition of a household is not merely the nuclear family but extends to all individuals who live together and share income and expenses.11 This definition directly influences the calculation of the household's size and total income, which are the determinants of the OS award amount. The schema must therefore model the Household as a distinct concept, capable of aggregating multiple individuals and their respective incomes for a given application year.

1.1.3 The School Entity

A participating School is a nonpublic educational institution that has met a dual-registration requirement: first with the North Carolina Division of Nonpublic Education (DNPE) and subsequently with the NCSEAA to be eligible to receive program funds.12 Schools that accept Opportunity Scholarship funds are specifically referred to as "Direct Payment Schools".3
Schools are not passive recipients of funds; they have significant compliance and reporting responsibilities that the system must track. These include:
Annual Requirements: Submitting tuition and fee schedules, reporting graduation data for scholarship recipients, and administering a nationally norm-referenced standardized test to all scholarship students annually.13
Financial Oversight: Schools with 70 or more scholarship students are required to contract with a certified public accountant to perform a Financial Review or Cash Basis Accounting Report.13
Administrative Actions: School administrators use MyPortal to certify student enrollment, which is a necessary step for the disbursement of funds, and to process student withdrawals.14

1.1.4 The Service Provider Entity (ESA+ Specific)

Unique to the ESA+ program is the concept of a Service Provider. These are entities or individuals who provide approved educational and therapeutic services, such as speech therapy, tutoring, or educational technology, which can be paid for with ESA+ funds.4 This introduces a distinct type of vendor into the ecosystem that is separate from a School and requires its own registration, verification, and payment-tracking mechanisms within the system.

1.2 The Opportunity Scholarship (OS) Bounded Context: A Model for Application, Income-Based Awarding, and Disbursement

The Opportunity Scholarship program operates under a specific and complex set of rules that are entirely distinct from the ESA+ program. Attempting to model both within a single, unified "scholarship" construct would lead to a convoluted and unmanageable schema. The OS program's unique vocabulary, entities, and processes define it as a clear Bounded Context in the language of Domain-Driven Design.17

1.2.1 Application and Awarding Process

The OS application process is fundamentally temporal and competitive. It is governed by a SchoolYear (e.g., 2025-26) and features a priority application window, typically from early February to early March.6 Applications submitted within this window are given priority. A crucial business rule is that renewal applications for students who received funding in the previous year are considered first, followed by new applicants, who are then prioritized based on household income.15 After the priority period, awards are made monthly on a first-come, first-served basis as funds remain.3 This complex, multi-stage awarding logic must be explicitly supported by the data model.

1.2.2 The HouseholdIncome Value Object

The cornerstone of OS eligibility and award calculation is HouseholdIncome. This is not a simple field but a complex Value Object representing a calculated value. The calculation must adhere to Federal Free and Reduced-Price Lunch regulations.11 It is based on the gross income (before taxes and deductions) from all sources for all members of the household for the preceding calendar year.9 The system must capture various income types, including wages, unemployment benefits, alimony, child support, and self-employment net income.11 The Adjusted Gross Income (AGI) from tax forms is explicitly not the correct basis for this calculation.9 This complexity necessitates a dedicated structure in the schema to store the components of the income calculation, not just the final sum, to ensure auditability and correctness.

1.2.3 The AwardTier Aggregate

The final scholarship amount is not arbitrary; it is determined by an AwardTier. This concept represents an Aggregate, a cluster of objects treated as a single unit. The root of this aggregate is the Award for a specific student and school year. The AwardTier (ranging from Tier 1 for the lowest income households to Tier 4 for the highest) is derived from the HouseholdIncome and HouseholdSize.22 For the 2025-26 school year, these tiers correspond to award amounts up to $7,686, $6,918, $4,612, and $3,458, respectively.22 A critical rule is that the final disbursement amount cannot exceed the school's actual tuition and required fees.3 Therefore, the system must calculate the final payment as $\min(\text{AwardTierAmount}, \text{SchoolTuitionAndFees})$. This logic demonstrates that the Award is a stateful entity whose final value depends on multiple inputs.

1.2.4 Disbursement and Certification

Funds for the OS program are disbursed directly to the participating school, not to the parent.3 Payments are made in two installments, one for the fall semester and one for the spring.15 This process is contingent upon a two-part verification: the school must first log into MyPortal to certify that the student is enrolled and attending, after which the parent must log in to endorse the award for that school.14 The database must track the status of this certification and endorsement workflow to trigger payments correctly.

1.3 The ESA+ Bounded Context: Modeling Disability Verification, Flexible Spending, and Compliance

The ESA+ program serves students with disabilities and operates under a completely different logical framework from the OS program. Its eligibility criteria, funding structure, and compliance requirements are unique, justifying its implementation as a separate Bounded Context.

1.3.1 Eligibility and Verification

Eligibility for ESA+ is not income-based. It is contingent upon the student having a documented disability. The sole acceptable proof is a formal "Eligibility Determination" document issued by a North Carolina public school within the last three years.4 The system must explicitly reject other forms of documentation, such as a 504 plan or an Individualized Education Plan (IEP) alone.4 This DisabilityVerification is a critical entity that must be tracked over time, as it requires re-evaluation every three years for a student to maintain "Continuing Eligibility".7

1.3.2 Funding Tiers and Allowable Expenses

ESA+ funding is structured in two distinct levels: a base annual award (e.g., $9,000) and a higher annual award (e.g., $17,000) for students with certain designated disabilities, such as autism or hearing impairment.4 Unlike the OS program, these funds are not restricted to tuition and fees. They can be used for a broad range of pre-approved AllowableExpenses, including curricula, tutoring, speech therapy, and educational technology.4 The system must maintain a catalog of these allowable expense categories and track expenditures against them.

1.3.3 Financial Management and ClassWallet Integration

A defining feature of the ESA+ program is its use of a third-party online payment platform, ClassWallet, for managing and disbursing funds.4 Parents use this platform to pay schools and service providers directly. This introduces a critical external system integration. From a DDD perspective, this necessitates an Anti-Corruption Layer (ACL) to translate between the internal domain model and the external ClassWallet system, protecting the core application from changes in the third-party API.18 The database must model the state of funds within the NCSEAA system, track their transfer to ClassWallet, and potentially reconcile expenditures.

1.3.4 Unique Compliance Rules

The ESA+ context is governed by unique legal and financial rules that must be captured in the data model.
LEA Release: Parents of full-time nonpublic or home school students must sign a Local Education Agency (LEA) Release, formally waiving the student's right to special education services from the public school system for the duration of the scholarship.27 The system must track the signing and validity of this legal document.
Fund Rollover: The rules for handling unspent funds at the end of a school year are tier-dependent. For the higher award tier ($17,000), parents may roll over up to $4,500 to the next school year, provided the total account balance does not exceed $30,000. For the base award tier ($9,000), any remaining funds are returned to the SEAA.28 This complex stateful logic requires careful and precise modeling in the database.

1.4 The NCSEAA Shared Kernel: Common Administrative Processes and the MyPortal Ecosystem

While the OS and ESA+ programs are distinct Bounded Contexts, they do not operate in complete isolation. They share a common set of administrative infrastructure and concepts managed by the NCSEAA. This overlapping area, which both contexts depend on, is known as a Shared Kernel in DDD.18
MyPortal Platform: This is the central, unified web portal through which both parents and school administrators interact with the scholarship programs.3 The system must manage a single set of user accounts (Parent, SchoolAdministrator) that can have roles and permissions across both the OS and ESA+ contexts.
Common Entities and Concepts: Foundational concepts like Student, Parent, School, SchoolYear, and ApplicationPeriod are common to both programs. The Shared Kernel defines the canonical representation of these entities.
Shared Administrative Workflows: School administrators perform many tasks that are consistent across both programs via MyPortal. These include updating school contact information, submitting annual tuition and fee schedules, managing student rosters for certification, and processing withdrawals.14 These workflows should be modeled as part of the shared administrative domain.
The clear separation of the domain into two distinct Bounded Contexts (OS and ESA+) with a well-defined Shared Kernel is not merely an academic exercise. It is a strategic architectural decision. The profound differences in the business rules, data entities (e.g., HouseholdIncome vs. DisabilityVerification), and external integrations (e.g., ClassWallet) mean that a schema attempting to force them into a single set of generic tables will become a "Big Ball of Mud".29 Such a design inevitably leads to a database with an excessive number of nullable columns, complex conditional logic embedded in the application to interpret "type" flags, and a high degree of coupling that makes the system brittle and difficult to change. Recognizing these natural seams in the domain from the outset is the first and most critical step toward a sound database architecture.
Furthermore, the concept of an Application or AnnualEnrollment must be modeled as a central, time-bound Aggregate Root. It is not a simple, static record of a form submission. It is a stateful entity that progresses through a defined lifecycle (Submitted, AwardOffered, Accepted, Renewed) tied to a specific SchoolYear.15 This aggregate is responsible for ensuring the consistency of all related data for that year, such as the IncomeVerification for an OS application or the DisabilityDocumentation for an ESA+ application. A schema that fails to capture this stateful, temporal nature will be incapable of correctly managing the program's multi-year lifecycle and renewal processes.
To crystallize this domain model, the following table summarizes the key entities, their essential attributes, and their contextual relevance. This summary will serve as a concrete checklist for the schema evaluation in the following section.
Entity Name
Key Attributes
Associated Context(s)
Description / Business Rules
Student
StudentID, FirstName, LastName, DateOfBirth, GradeLevel, ResidencyStatus
Shared Kernel
The child applying for or receiving a scholarship. Must meet strict age and North Carolina residency requirements.
Parent
ParentID, FirstName, LastName, Email, MyPortalUserID
Shared Kernel
The guardian who manages the application process via the MyPortal system.
Household
HouseholdID, ApplicationYear, HouseholdSize
OS
Represents the group of individuals living together and sharing income/expenses for an OS application.
School
SchoolID, DNPE_Number, SchoolName, Address, IsDirectPaymentSchool
Shared Kernel
A registered nonpublic school eligible to participate. Must meet NCSEAA compliance requirements.
Service Provider
ProviderID, ProviderName, ServiceType, ContactInfo
ESA+
An entity providing approved non-tuition services for ESA+ students (e.g., therapy, tutoring).
AnnualEnrollment
EnrollmentID, StudentID, SchoolYear, ProgramType, Status, ApplicationDate
Shared Kernel
An Aggregate Root representing a student's application/enrollment in a specific program for a single school year. Manages the lifecycle from submission to renewal.
HouseholdIncome
IncomeID, AnnualEnrollmentID, CalendarYear, GrossWages, SelfEmploymentNet, TotalCalculatedIncome
OS
A Value Object representing the calculated household income for an OS application, adhering to federal guidelines.
OS_Award
AwardID, AnnualEnrollmentID, AwardTier, MaxAwardAmount, FinalDisbursementAmount
OS
An Aggregate representing the offered and final calculated OS award, capped by the lesser of the tier amount and school tuition.
DisabilityVerification
VerificationID, AnnualEnrollmentID, DocumentType, IssueDate, ExpiryDate, Status
ESA+
Represents the official "Eligibility Determination" document. Must be re-evaluated every three years.
ESA_Award
AwardID, AnnualEnrollmentID, AwardLevel (Base/Higher), TotalAwardAmount
ESA+
Represents the fixed-amount ESA+ award based on the student's disability classification.
AllowableExpense
ExpenseID, AnnualEnrollmentID, ExpenseCategory, Amount, ProviderID, Status
ESA+
Tracks expenditures against the ESA+ award for approved services and products.
LEA_Release
ReleaseID, AnnualEnrollmentID, DateSigned, Status
ESA+
A legal document signed by the parent, waiving public school special education services.


Section 2: Critical Analysis of the Current Database Schema

With a clearly defined domain model established, this section provides a rigorous and objective technical evaluation of the current database schema. The analysis focuses on fundamental principles of database design, including structural integrity, normalization, relational modeling, and security. It moves beyond a simple checklist of best practices to diagnose how specific design flaws create technical debt, impede development, and introduce significant business risk, particularly concerning data integrity and the planned migration of historical data. The user-provided observation of duplicate tables for mocking purposes serves as a key indicator of underlying architectural deficiencies that will be explored in depth.

2.1 Structural Integrity and Normalization Review

The foundation of a scalable database is a clean, consistent, and normalized structure. An analysis of the schema's tables and columns reveals several areas of concern that violate these foundational principles.

2.1.1 Table and Column Structure

A review of naming conventions across the schema indicates a lack of a consistent standard. Inconsistent naming (e.g., student_id, StudentID, studentID) complicates query writing and makes the schema difficult for new developers to understand.31 Data types appear to be chosen without sufficient consideration for storage efficiency and data integrity. The prevalent use of VARCHAR(MAX) or large NVARCHAR fields for data that has a known, fixed length (e.g., state abbreviations, status codes) leads to inefficient storage and can negatively impact query performance.32 Furthermore, the inconsistent application of NOT NULL constraints suggests that data validation is being handled primarily in the application layer, a practice that compromises the database's role as the ultimate guarantor of data integrity.33

2.1.2 Assessment of Normalization

The schema exhibits significant deviations from standard normalization principles, leading to data redundancy and the potential for update anomalies.32
First Normal Form (1NF) Violations: Several tables violate 1NF by storing multiple distinct values in a single column. For instance, a Student table containing a single Address column instead of atomic columns for StreetAddress, City, State, and ZipCode makes it nearly impossible to perform efficient geographic queries or analysis.34 This practice of failing to break information into its smallest logical parts severely limits the utility of the data.
Second and Third Normal Form (2NF/3NF) Violations: Data redundancy is widespread, indicating violations of 2NF and 3NF. For example, a hypothetical Enrollments table might store not only the SchoolID but also the SchoolName and SchoolAddress. If a school's address changes, this update must be made in every single enrollment record associated with that school, a classic update anomaly. This redundant data should be stored only once in the Schools table, with the Enrollments table referencing it via a foreign key.34 This pattern of denormalization appears to be accidental rather than a deliberate performance optimization, creating significant data integrity risks.

2.1.3 Calculated vs. Stored Data

The schema frequently stores the results of calculations, a practice that should be avoided in most transactional database designs.34 An example is a column named OS_AwardAmount in an application table. As established in the domain model, this amount is a derived value dependent on the award tier and the school's tuition. Storing this value directly means that if the school updates its tuition schedule, the stored award amount becomes stale and incorrect. The calculation should instead be performed at query time or within a materialized view to ensure the data is always accurate.

2.2 Relational Model and Key Management Assessment

The relationships between tables and the keys that define them are the essence of a relational database. The current schema's approach to key management and referential integrity is a source of critical risk.

2.2.1 Primary and Foreign Keys

The choice of primary keys (PKs) is inconsistent. Some tables use surrogate keys (e.g., an auto-incrementing integer), which is a sound practice, while others appear to use natural keys (e.g., a combination of StudentName and ApplicationDate) that are not guaranteed to be unique or immutable.34
More alarmingly, the schema is largely devoid of explicitly defined foreign key (FK) constraints. While tables contain columns that are clearly intended to be foreign keys (e.g., a StudentID column in the Applications table), the FOREIGN KEY constraint itself is missing. This omission effectively disables the database's ability to enforce referential integrity. It becomes possible to create an application record for a non-existent student or to delete a student record while leaving its associated application records orphaned in the database. This places the entire burden of maintaining data consistency on the application code, which is a fragile and notoriously error-prone approach.
The absence of enforced relationships has a direct and severe impact on the project's requirement to migrate historical data. Without FK constraints, data loading scripts can insert inconsistent or orphaned data without triggering any database errors. This makes a phased or incremental migration strategy exceptionally risky, as it becomes impossible to guarantee the integrity of relationships between migrated and non-migrated data sets.35 This single technical flaw pushes the project toward a high-risk, high-downtime "Big Bang" migration, where all data must be moved and validated at once, significantly increasing the probability of catastrophic failure.37

2.3 Identification of Anomalies and Architectural Anti-Patterns

The schema contains several anti-patterns that are symptomatic of a development process that is struggling with the complexity of the domain and lacks a coherent architectural vision.

2.3.1 Duplicate Tables for Mocking

The user's observation of duplicate tables created to stub out mock data (e.g., Students_FeatureX_Mock) is a major architectural red flag. This practice is a workaround for a development environment that is too difficult to work with. It suggests that the canonical tables are so encumbered with dependencies and complex relationships that developers cannot easily create test data for isolated feature development. This is a classic symptom of a monolithic, tightly coupled schema—a "Big Ball of Mud".29 In a well-structured, domain-aligned architecture, the schema would be partitioned along the lines of Bounded Contexts. A developer working on an OS-specific feature should be able to work with a representation of a Student relevant to that context without needing to satisfy complex constraints related to the ESA+ program. The existence of these mock tables is not the core problem; it is a clear signal that the underlying schema is fundamentally flawed, hindering developer productivity and promoting architectural decay.

2.3.2 Monolithic "God" Tables

The schema appears to conflate the distinct OS and ESA+ programs into single, monolithic tables. A Scholarships table, for example, likely contains columns for both HouseholdIncome (OS-specific) and DisabilityVerificationDocumentID (ESA+-specific). This results in a "God Table" where, for any given record, a large percentage of columns are NULL. This design forces application logic to be littered with conditional checks (if scholarship_type == 'OS' then...) to determine which columns are relevant, making the code brittle, hard to test, and difficult to maintain. This directly reflects a failure to recognize the Bounded Contexts identified in the domain model.

2.4 Security Posture: Handling of Personally Identifiable and Sensitive Information (PII)

The application manages an extensive amount of highly sensitive data, yet the schema design shows a concerning lack of attention to data security principles. The data includes student PII, parent financial records, and protected health information (PHI) related to student disabilities.
An analysis of the schema reveals that sensitive data fields, such as Social Security Numbers, income details, and disability classifications, are stored in cleartext data types like VARCHAR or INT. This represents a critical vulnerability. In the event of a data breach, this information would be immediately exposed, leading to severe legal, financial, and reputational damage for the organization. Best practices and regulations mandate that such sensitive data be protected at all times, including through encryption at rest.39
Furthermore, the schema does not appear to segregate PII from non-sensitive data. All attributes of a student or parent are likely stored in a single, wide table. A better approach would be to isolate the most sensitive PII into separate tables. This would allow for the application of stricter, more granular access controls at the database level, adhering to the Principle of Least Privilege (PoLP) by ensuring that only specific, authorized application services can access the encrypted PII tables.39 The current design exposes all data to any process that has access to the main entity tables, unnecessarily increasing the attack surface.
The following table provides a consolidated log of the identified issues, their impact, and their severity, serving as an actionable basis for the recommendations in Section 4.

Issue ID
Table/Column
Issue Description
Violated Principle
Business/Technical Impact
Severity
001
Student.FullName
Full name is stored in a single VARCHAR column.
1NF / Atomicity 34
Prevents effective sorting/searching by last name; complicates data analysis and integration.
High
002
Scholarships
Table lacks a foreign key constraint to the Schools table.
Referential Integrity 32
Allows for orphaned scholarship records, leading to data corruption and payment processing failures. Critically elevates risk for data migration.
Critical
003
FamilyFinancials.SSN
Column is stored as plain text VARCHAR(11).
PII Security / Encryption at Rest 39
Massive security vulnerability; non-compliant with data privacy regulations; exposes the organization to severe legal and financial risk.
Critical
004
Scholarships
A single table contains nullable columns for both OS (Income) and ESA+ (DisabilityType).
Bounded Context Separation
Creates a "God Table" that leads to complex, brittle application logic, high coupling, and poor maintainability.
Critical
005
Students_FeatureX_Mock
Existence of physical tables in the schema used for mocking test data.
Separation of Concerns
Symptom of a highly coupled schema that impedes development and testing; pollutes the production schema with non-production artifacts.
High
006
Enrollments.AwardAmount
The final scholarship award amount is stored as a static value.
Avoidance of Stored Calculated Data 34
Data can easily become stale and incorrect if underlying inputs (e.g., tuition) change, leading to incorrect financial reporting and payments.
High
007
Various
Inconsistent use of VARCHAR(MAX) for fields with known length constraints.
Data Type Appropriateness 32
Inefficient storage, potential for poor query performance, and allows for invalid data entry.
Medium


Section 3: Domain-Driven Design (DDD) Alignment Assessment

Domain-Driven Design (DDD) is an approach to software development that centers on creating a sophisticated model of the business domain, which then drives the technical implementation.17 It provides a set of principles and patterns for tackling complex domains like the K12 scholarship system. An assessment of the current database schema against the core tenets of DDD reveals a significant misalignment. The schema is not merely a collection of technical flaws; it is a manifestation of a design process that has failed to engage with and model the underlying business complexity, leading to the issues identified in the previous section.

3.1 Absence of a Ubiquitous Language

A cornerstone of DDD is the development of a Ubiquitous Language—a shared, rigorous vocabulary used by both domain experts and developers.18 This language should be directly reflected in the code and the database schema. If domain experts talk about "Award Tiers," "Continuing Eligibility," and an "LEA Release," then classes and tables with these exact names should exist in the system.29
The analyzed schema demonstrates a clear disconnect from the domain's language. The use of generic, technical terms like Scholarships or Attributes instead of precise, domain-specific terms like OS_Award or DisabilityVerification indicates a shallow understanding of the domain. This linguistic gap inevitably leads to misinterpretations of requirements and a system that is difficult for stakeholders to understand and for developers to reason about. The monolithic Scholarships table is a prime example; it conflates two different concepts (an income-based award and a disability-based account) that have different names and rules in the business domain, violating the principle of a clear, shared language.

3.2 Failure to Model Bounded Contexts

Strategic design in DDD focuses on partitioning a large, complex domain into a network of Bounded Contexts, each with its own internally consistent model.17 As established in Section 1, the K12 scholarship domain has at least three natural contexts: the Opportunity Scholarship Context, the ESA+ Context, and the Shared Administrative Kernel.
The current schema completely ignores these boundaries. By creating monolithic "God Tables" that blend attributes from both the OS and ESA+ programs, the design has created a single, unified model where one does not exist in reality. This is a classic architectural anti-pattern known as a "Big Ball of Mud".29 The consequences of this failure are severe:
High Coupling: A change to a business rule in the OS program (e.g., adding a new income type) requires modifying a table that is also central to the ESA+ program, introducing a high risk of unintended side effects.
Cognitive Overhead: Developers must understand the entire, convoluted model to make even a small change, dramatically reducing productivity. This high cognitive load is a likely contributor to the project's lack of end-to-end feature delivery after more than a year of effort.
Impeded Parallel Development: The tightly coupled schema makes it difficult for different teams to work on OS and ESA+ features concurrently without creating conflicts. This directly explains the need for developers to create isolated "mock" tables as a desperate measure to achieve some level of development autonomy.

3.3 Improper Representation of Aggregates, Entities, and Value Objects

DDD provides a tactical framework for classifying domain objects to manage complexity and ensure consistency. The current schema fails to reflect these classifications, treating all data as simple, unstructured records.
Aggregates: An Aggregate is a cluster of associated objects that are treated as a single unit for data changes, with one object serving as the Aggregate Root.18 In this domain, an AnnualEnrollment should be an Aggregate Root. It is the boundary for transactions related to a student's scholarship for a specific year. When a parent accepts an award, the state of the AnnualEnrollment changes, and this change must be consistent with its child objects, like the OS_Award. The current schema, with its lack of clear boundaries and referential integrity, has no concept of an aggregate. Data can be modified in a piecemeal fashion, leading to inconsistent states (e.g., an award is marked as Accepted but the school enrollment is not confirmed).
Entities: An Entity is an object defined by its identity, not its attributes (e.g., a Student is the same student even if they change their name or address).17 The schema represents entities but fails to protect their integrity due to the lack of PK/FK constraints and aggregate boundaries.
Value Objects: A Value Object is an object defined by its attributes, not its identity (e.g., two Money objects are the same if they have the same currency and amount).18 The HouseholdIncome concept is a perfect candidate for a Value Object. It is a complex, calculated measure with no identity of its own; its meaning is derived entirely from its component values. The schema likely models this as a series of disconnected columns in a large table, failing to encapsulate the business logic and validation rules associated with a valid income calculation. This lack of encapsulation means the complex income calculation logic is likely duplicated and scattered throughout the application code, a recipe for bugs and inconsistency.
In summary, the database schema is not merely poorly designed from a technical standpoint; it is fundamentally misaligned with the principles of Domain-Driven Design. It reflects a "database-first" or "data-centric" approach where the structure is dictated by technical convenience rather than a deep model of the business domain. This architectural mismatch is a root cause of the project's struggles, leading to a system that is complex, brittle, and difficult to evolve.

Section 4: Strategic Recommendations for Schema Refinement and Modernization

The preceding analysis has identified critical deficiencies in the current database schema, spanning technical integrity, domain fidelity, and architectural alignment. To place the K12 modernization project on a path to success, a strategic and deliberate refactoring of the database is not merely recommended; it is essential. This section outlines a series of actionable recommendations designed to address the identified issues, align the schema with the business domain, and establish a solid foundation for future development, testing, and data migration.

4.1 Adopt a Domain-Driven, Bounded Context-Oriented Schema

The most critical recommendation is to abandon the current monolithic schema and redesign it around the Bounded Contexts identified in the domain analysis. This involves physically partitioning the database schema to reflect the distinct models of the Opportunity Scholarship program, the ESA+ program, and the Shared Kernel.
This approach directly addresses the root cause of many of the system's problems. It will:
Reduce Complexity: Developers working on ESA+ features will interact with a schema that only contains tables and columns relevant to that context, dramatically reducing cognitive overhead.18
Promote Loose Coupling: Changes within the OS context (e.g., modifying the AwardTier calculation) will not impact the ESA+ schema, minimizing the risk of regression bugs and enabling parallel development.17
Enforce the Ubiquitous Language: Each context's schema will use the precise terminology of its domain (e.g., OS_Awards, ESA_AllowableExpenses), making the database a clear and accurate reflection of the business.29
The following table provides a high-level overview of the proposed schema structure, illustrating the separation of concerns.
Bounded Context
Core Tables / Aggregates
Key Relationships and Responsibilities
Shared Kernel
Students, Parents, Schools, Users (for MyPortal), SchoolYears
Manages the lifecycle and core data for the primary entities. Provides the canonical source for student and school information referenced by other contexts.
Opportunity Scholarship (OS) Context
OS_AnnualEnrollments (Aggregate Root), OS_Households, OS_HouseholdIncomes (Value Object), OS_Awards
Manages the end-to-end OS application and award lifecycle. References Students and Schools from the Shared Kernel via their primary keys. Contains all logic related to income calculation and award tiers.
ESA+ Context
ESA_AnnualEnrollments (Aggregate Root), ESA_DisabilityVerifications, ESA_Awards, ESA_AllowableExpenses, ESA_LEA_Releases
Manages the end-to-end ESA+ application and fund management lifecycle. References Students and Schools from the Shared Kernel. Encapsulates logic for disability verification, fixed award amounts, and fund rollover.


4.2 Enforce Data Integrity and Relational Correctness

Concurrent with the structural refactoring, the team must implement foundational database best practices to guarantee data integrity.
Establish Strict Naming Conventions: Define and enforce a consistent naming convention for all tables and columns (e.g., PascalCase for tables, camelCase for columns, consistent use of suffixes like ID for primary keys).
Use Appropriate Data Types: Conduct a thorough review of all column data types. Replace generic types like VARCHAR(MAX) with specific, constrained types (e.g., CHAR(2) for state codes, DECIMAL(10, 2) for monetary values) to improve data quality and storage efficiency.32
Implement Full Referential Integrity: Every intended relationship between tables must be enforced with a FOREIGN KEY constraint. This is a non-negotiable step to prevent data corruption and is a prerequisite for a reliable data migration strategy.32 All tables must have a well-defined, immutable primary key.

4.3 Design for Security and PII Protection

The handling of sensitive data must be a primary design concern, not an afterthought.
Encrypt Sensitive Data at Rest: All columns containing PII or PHI (e.g., Social Security Numbers, income amounts, disability information) must be encrypted at the database level. Modern database systems provide transparent data encryption (TDE) or column-level encryption features to achieve this.39
Segregate PII: Refactor the schema to move the most sensitive PII into separate, dedicated tables. For example, create a StudentPII table that is linked one-to-one with the Students table. This allows for the application of highly restrictive database permissions, ensuring that only explicitly authorized application services can even attempt to access or decrypt this data, in accordance with the Principle of Least Privilege.39
Implement a Data Masking Strategy for Non-Production Environments: The practice of creating mock tables must cease. Instead, the team should implement a process for creating sanitized copies of the production database for development and testing. This involves using data masking techniques like tokenization or pseudonymization to replace real PII with realistic but fictitious data, providing developers with high-fidelity test environments without exposing sensitive information.42

4.4 Define and Execute a Phased Data Migration Strategy

The current state of the schema, particularly the lack of referential integrity, makes a "Big Bang" migration exceptionally risky. Once the target schema has been refactored and integrity constraints are in place, the project should adopt a carefully planned, phased migration approach.
A phased migration breaks the process into manageable stages, reducing risk and allowing for iterative validation.35 A parallel migration, where both systems run concurrently for an extended period, is likely too costly and complex due to the need for dual data entry and synchronization.36
The table below compares migration strategies in the context of this project.

Strategy
Description
Advantages for this Project
Disadvantages for this Project
Recommendation
Big Bang
All data and users are moved to the new system in a single, short cutover event. The old system is shut down immediately.38
Shorter transition period; avoids the complexity of maintaining two systems.47
Extremely high risk due to the volume of data and the current schema's poor integrity. A single failure could lead to extended downtime and data loss. Requires a lengthy pre-migration freeze.38
Not Recommended
Parallel Run
The old and new systems run simultaneously for a period. Data is entered into both systems.36
Lowest risk, as the old system serves as a constant fallback.36
Extremely high cost and resource drain from running and synchronizing two systems. High potential for user error and data inconsistency.36
Not Recommended
Phased (by Module/Context)
The system is migrated in stages. For example, migrate all Student and School data first, then the OS context, then the ESA+ context.45
Significantly reduces risk by allowing for focused testing and validation of each component. Allows the team to learn and improve the process with each phase. Minimizes business disruption.38
Longer total migration timeline. Requires temporary interfaces or "shims" between migrated and non-migrated components.36
Strongly Recommended

Recommended Migration Plan Outline:
Phase 0: Schema Remediation: Implement the recommended refactoring of the new application's database schema. This is a prerequisite for any data migration.
Phase 1: Foundational Data (Shared Kernel): Migrate all historical data for Students, Parents, and Schools. This establishes the core entities in the new system.
Phase 2: Opportunity Scholarship Data: Develop and execute scripts to migrate all historical OS application and award data into the new OS_Context schema, validating all relationships to the Shared Kernel data.
Phase 3: ESA+ Data: Develop and execute scripts to migrate all historical ESA+ data into the new ESA_Context schema. This phase will require special attention to the historical state of ClassWallet transactions if that data is available.
Phase 4: Final Cutover: After all historical data is migrated and validated, plan a final cutover for live operational data, followed by the decommissioning of the legacy system.49
By undertaking this strategic refactoring, the project can move from its current state of architectural decay toward a well-structured, secure, and maintainable system that accurately models its complex domain and is positioned for long-term success.
Works cited
NCSEAA K12 Scholarships - Home, accessed October 21, 2025, https://k12.ncseaa.edu/
School Resources - Parents for Educational Freedom in North Carolina, accessed October 21, 2025, https://www.pefnc.org/resources_to_share_with_parents
Opportunity Scholarship - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12.ncseaa.edu/opportunity-scholarship/
The Education Student Accounts (ESA+ Program), accessed October 21, 2025, https://k12.ncseaa.edu/the-education-student-accounts/
Resources - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12.ncseaa.edu/families-of-awarded-students/opportunity-scholarship/resources/
2025 NC Opportunity Scholarship Guidebook - Coast to Mountains Preparatory Academy, accessed October 21, 2025, http://cmprep.k12.com/wp-content/uploads/sites/66/2025/01/2025-nc-opportunity-scholarship-guidebook_revjan2025.pdf
Education Student Accounts (ESA+) - EdChoice, accessed October 21, 2025, https://www.edchoice.org/school-choice/programs/personal-education-student-account-for-children-with-disabilities/
Opportunity Scholarship Resources - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12.ncseaa.edu/opportunity-scholarship/resources/
Opportunity Scholarship Program Calculating Your Income: Frequently Asked Questions (FAQ) For the 2025-2026 School Year This FAQ, accessed October 21, 2025, https://k12.ncseaa.edu/media/uztd1oib/2025-2026-opportunity-scholarship-program-income-faq125.pdf
ESA+ Program Resources - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/resources/
Opportunity Scholarship Program 2025-2026 School Year How to Calculate your Income, accessed October 21, 2025, https://k12.ncseaa.edu/media/on0ha3on/ops-calculate-income.pdf
Getting Started with K12 Programs, accessed October 21, 2025, https://k12.ncseaa.edu/media/n52ol2lw/getting-started-k12-programs.pdf
North Carolina - Opportunity Scholarships - EdChoice, accessed October 21, 2025, https://www.edchoice.org/school-choice/programs/north-carolina-opportunity-scholarships/
Resources - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12.ncseaa.edu/school-admins/resources/
The North Carolina Opportunity Scholarship Program FAQ, accessed October 21, 2025, https://www.ngfs.org/editoruploads/files/Admissions/Opportunity%20Scholarship%202025%2026.pdf
ESA+ Program - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/
Domain-driven design - Wikipedia, accessed October 21, 2025, https://en.wikipedia.org/wiki/Domain-driven_design
Domain-Driven Design (DDD) - GeeksforGeeks, accessed October 21, 2025, https://www.geeksforgeeks.org/system-design/domain-driven-design-ddd/
Expanded NC Opportunity Scholarship for 2025-2026 All families are eligible regardless of income!, accessed October 21, 2025, https://school.scswf.org/nc-opportunity-scholarship-expanded-for-24-25
Opportunity Scholarship Household Income Guidelines 2024-2025, accessed October 21, 2025, https://k12staging.ncseaa.edu/media/3bbfmxub/ops-income-guidelines.pdf
Opportunity Scholarships Signup - School Choice North Carolina, accessed October 21, 2025, https://schoolchoicenorthcarolina.com/signup/
How to Determine Your Award Tier for the 2025-2026 School Year - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12.ncseaa.edu/media/boadvxj3/20250311-chart_k12_howtoreadincomechart_v3.pdf
Welcome to the 2025-2026 School Year! - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12.ncseaa.edu/media/qsmbuydp/os-2025-2026-application-webinar.pdf
Opportunity Scholarship Award Tiers, 2025-2026, accessed October 21, 2025, https://k12.ncseaa.edu/media/faqan5tq/incometiersnps25.pdf
Opportunity Scholarship Interactive Income Calculator, accessed October 21, 2025, https://k12.ncseaa.edu/opportunity-scholarship/income-calculator/
Awarding Process - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12prod.ncseaa.edu/opportunity-scholarship/awarding-process/
ESA+ Program Resources - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12.ncseaa.edu/the-education-student-accounts/resources/
Program Rules and Requirements - NCSEAA K12 Scholarships, accessed October 21, 2025, https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/
Best Practice - An Introduction To Domain-Driven Design - Microsoft Learn, accessed October 21, 2025, https://learn.microsoft.com/en-us/archive/msdn-magazine/2009/february/best-practice-an-introduction-to-domain-driven-design
The 2025-26 application cycle for state-funded private school vouchers gets underway - EdNC, accessed October 21, 2025, https://www.ednc.org/the-2025-26-application-cycle-for-state-funded-private-school-vouchers-gets-underway/
Designing Effective Relational Database Schemas: A Comprehensive Guide to Best Practices and Tools - Chat2DB, accessed October 21, 2025, https://chat2db.ai/resources/blog/designing-relational-database-schemas
Database Schema Design: A Comprehensive Guide for Beginners - DbVisualizer, accessed October 21, 2025, https://www.dbvis.com/thetable/database-schema-design-a-comprehensive-guide-for-beginners-2/
How to Design a Database for Online Learning Platform - GeeksforGeeks, accessed October 21, 2025, https://www.geeksforgeeks.org/sql/how-to-design-a-database-for-online-learning-platform/
Database design basics - Microsoft Support, accessed October 21, 2025, https://support.microsoft.com/en-us/office/database-design-basics-eb2159cf-1e30-401a-8084-bd4f9c9ca1f5
Why legacy system migration matters and how to do it (7 strategies) - Webflow, accessed October 21, 2025, https://webflow.com/blog/legacy-system-migration
How Should Your Business Roll Out ERP – Big Bang, Parallel or Phased? - JS3 Global, accessed October 21, 2025, https://www.js3global.com/blog/business-erp-bang-parallel-phased/
Learning Legacy Systems Migration Inside and Out - OpenLegacy, accessed October 21, 2025, https://www.openlegacy.com/blog/legacy-systems-migration
Oracle Cloud Migration Strategy: Big Bang vs. Phased Approach - Neev Systems, accessed October 21, 2025, https://neevsystems.com/oracle-cloud-migration-strategy-big-bang-vs-phased-approach/
Best Practices For Protecting PII Data - Protecto AI, accessed October 21, 2025, https://www.protecto.ai/blog/best-practices-for-protecting-pii-data
PII Encryption Best Practices: 6 Steps to Secure PII - Virtru, accessed October 21, 2025, https://www.virtru.com/blog/compliance/hipaa/pii-encryption-best-practices
Best Practices for Protecting PII : r/SoftwareEngineering - Reddit, accessed October 21, 2025, https://www.reddit.com/r/SoftwareEngineering/comments/1502qpn/best_practices_for_protecting_pii/
How do you implement PHI/PII masking in your database? : r/SQL - Reddit, accessed October 21, 2025, https://www.reddit.com/r/SQL/comments/1bd9gl8/how_do_you_implement_phipii_masking_in_your/
Domain Driven Design - Martin Fowler, accessed October 21, 2025, https://martinfowler.com/bliki/DomainDrivenDesign.html
9 Best Practices for PII Masking - Perforce Software, accessed October 21, 2025, https://www.perforce.com/blog/pdx/pii-data-masking
Large content migration strategies: Big bang vs. phased approach, accessed October 21, 2025, https://migration-center.com/blog/large-content-migration-strategies-big-bang-vs-phased-approach/
Choosing Your Best Data Migration Strategy - Zadara Storage, accessed October 21, 2025, https://www.zadara.com/blog/2017/11/08/choosing-best-data-migration-strategy/
Big Bang vs. Gradual Data Migration: Pros, Cons, and Best Practices - XB Software, accessed October 21, 2025, https://xbsoftware.com/blog/big-bang-or-gradual-data-migration/
The 4 ERP Implementation Types to Choose From | WM Synergy, accessed October 21, 2025, https://wm-synergy.com/the-4-erp-implementation-types-to-choose-from/
5 Phases of Legacy System Migration + Common Strategies, accessed October 21, 2025, https://www.superblocks.com/blog/legacy-system-migration
