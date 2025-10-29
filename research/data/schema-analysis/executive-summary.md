# Executive Summary

Of course. Here is a thorough and concise review of the previous analyses, incorporating a comprehensive set of recommendations and a strategic plan for migrating data from the legacy system.

### **Executive Summary: A Strategic Review and Path Forward**

A comprehensive analysis of the K12 scholarship application's database schema across multiple domains—including Awards, Households, Enrollment, Providers, Schools, and Communications—has revealed a consistent and critical pattern of architectural deficiencies. The current schema is a product of a data-centric design that has resulted in a monolithic, tightly coupled "Big Ball of Mud".[1] This design fails to model the complex, distinct business realities of the Opportunity Scholarship (OS) and ESA+ programs, leading to significant risks in data integrity, security, and maintainability.

The root cause of these issues is a fundamental misalignment with the principles of Domain-Driven Design (DDD), which prioritizes a deep understanding of the business domain to guide software architecture.[2, 3] The schema lacks clearly defined boundaries (Bounded Contexts), fails to represent key business concepts (Aggregates and Value Objects), and does not enforce relational integrity, placing the entire burden of consistency on the application layer.[2, 1]

This report consolidates the findings from all previous analyses and presents a unified set of strategic recommendations to refactor the database into a robust, secure, and domain-aligned architecture. Furthermore, it outlines a detailed, phased strategy for migrating historical data from the legacy system, a critical requirement for the successful launch of the new application. Adopting these recommendations is essential to mitigate current risks, improve development velocity, and build a sustainable platform capable of evolving with the needs of the NCSEAA.

---

### **Section 1: Consolidated Schema Analysis**

The critiques from each domain-specific analysis converge on four primary categories of architectural failure.

**1.1. Monolithic Design and Absence of Bounded Contexts**
The most severe architectural flaw is the conflation of distinct business domains into single, generic tables.

* **"God Tables":** Across the system, concepts like `Awards`, `Enrollments`, and `Providers` are forced into monolithic tables. This results in wide, confusing structures with numerous nullable columns, as OS-specific attributes (e.g., `HouseholdIncome`) are mixed with ESA+-specific attributes (e.g., `DisabilityVerificationID`).
* **High Coupling:** This design creates extreme coupling between unrelated business functions. A change to an OS award rule risks breaking ESA+ enrollment logic, making the system brittle and difficult to evolve.[1]

**1.2. Critical Data Integrity and Relational Failures**
The schema abdicates its fundamental responsibility to guarantee data integrity.

* **Missing Foreign Key Constraints:** A universal finding is the widespread absence of enforced `FOREIGN KEY` constraints. This allows for the creation of orphaned records (e.g., an award for a non-existent student, an enrollment in a deleted school), leading to data corruption and making a reliable data migration nearly impossible.[4, 5, 6]
* **Improper Use of Data Types and Calculated Values:** The schema frequently uses inappropriate data types (e.g., `VARCHAR(MAX)` for fixed-length codes) and stores the results of calculations (e.g., a final `AwardAmount`) instead of the inputs. This leads to data becoming stale and incorrect if underlying factors change, posing a direct financial risk.[6]

**1.3. Inaccurate Domain Modeling**
The schema fails to represent the core concepts and workflows of the scholarship programs.

* **Lack of Aggregates:** Key business transactions, such as a student's `AnnualEnrollment`, are not modeled as cohesive Aggregates. This lack of a transactional boundary allows for inconsistent data states (e.g., an award is accepted, but the school certification is missing).[3]
* **Failure to Model Value Objects:** Complex concepts like `HouseholdIncome` are reduced to single decimal columns, discarding the rich component data and calculation rules mandated by program policy. This makes the system unauditable.[7, 3]
* **No Workflow State Management:** Critical, multi-step financial workflows, like the semesterly certification and endorsement process, are managed via a single, inadequate `Status` field, providing no auditable history of the payment lifecycle.

**1.4. Pervasive Security Vulnerabilities**
The schema demonstrates a concerning lack of attention to the protection of sensitive data.

* **Cleartext Storage of PII:** Highly sensitive Personally Identifiable Information (PII) and Protected Health Information (PHI)—including Social Security Numbers, income details, and disability classifications—are stored in cleartext, creating a critical vulnerability.[8, 9, 10]
* **No Data Segregation:** Sensitive PII is not segregated from non-sensitive data, violating the Principle of Least Privilege (PoLP) and unnecessarily increasing the attack surface.[8, 11]

---

### **Section 2: Strategic Architectural Recommendations**

To remedy these deficiencies, a complete refactoring of the database is required, guided by the principles of Domain-Driven Design.

**2.1. Adopt a Domain-Driven, Bounded Context-Oriented Schema**
The monolithic schema must be decomposed into physically separate schemas that align with the natural boundaries of the business domain.[2, 1, 3] This is the most critical step toward reducing complexity and enabling parallel development. The target architecture should include, at a minimum, the following Bounded Contexts:

* **Shared Kernel:** Manages core entities like `Students`, `Parents`, and `Schools`.
* **Opportunity Scholarship Context:** Manages the entire OS lifecycle, including `OS_AnnualEnrollments`, `OS_Households`, and `OS_Awards`.
* **ESA+ Context:** Manages the ESA+ lifecycle, including `ESA_AnnualEnrollments`, `ESA_DisabilityVerifications`, and `ESA_AllowableExpenses`.
* **Notification Context:** Manages all communication logic, including `Notifications`, `Templates`, and `MessageEvents`, decoupled from the SparkPost implementation.

**2.2. Enforce Foundational Database Integrity and Best Practices**
Data integrity must be enforced at the database level, not left to the application.

* **Implement Full Referential Integrity:** Every relationship must be enforced with `FOREIGN KEY` constraints. This is a non-negotiable prerequisite for a reliable system.[4, 5, 6]
* **Establish Strict Conventions:** Enforce consistent naming conventions, use appropriate and specific data types, and apply `NOT NULL` constraints where required.
* **Model Workflows Explicitly:** Replace single `Status` fields with dedicated workflow state tables that provide an immutable, auditable log of state transitions over time.

**2.3. Engineer for Security and Privacy by Design**
The handling of PII must be a primary design concern.

* **Encrypt All Sensitive Data at Rest:** All columns containing PII/PHI must be encrypted using platform-level features like Transparent Data Encryption (TDE) or column-level encryption.[8, 11, 9]
* **Segregate PII:** Isolate the most sensitive data into separate, dedicated tables with highly restrictive access controls.[8, 12]
* **Implement Data Masking:** Cease the use of mock tables. Instead, implement a secure process for creating sanitized, masked, or tokenized copies of production data for use in non-production environments.[12, 13]

---

### **Section 3: Legacy Data Migration Strategy**

Migrating historical data into the new, refactored schema is a high-risk endeavor that requires a deliberate and carefully planned strategy. The current schema's lack of integrity makes a "Big Bang" migration exceptionally dangerous.[14, 15, 16] Therefore, a **Phased Migration** is strongly recommended to reduce risk, allow for iterative validation, and minimize business disruption.[17, 18, 14, 19]

**3.1. Recommended Approach: Phased Migration by Bounded Context**
This strategy involves migrating the system in logical stages that align with the new domain-driven architecture.

| Strategy         | Description                                                                                          | Advantages for this Project                                                                                                                                                | Disadvantages                                                                                                         | Recommendation           |
| :--------------- | :--------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------- | :----------------------- |
| **Big Bang**     | All data is moved in a single, high-downtime event. The old system is shut down immediately.[17, 16] | Shorter transition period; avoids complexity of running two systems.[14, 16]                                                                                               | Extremely high risk of catastrophic failure due to the volume of data and current lack of data integrity.[14, 15, 16] | **Not Recommended**      |
| **Parallel Run** | Old and new systems run simultaneously for a period, with data entered into both.[17, 18]            | Lowest risk, as the old system serves as a constant fallback.[18]                                                                                                          | Extremely high cost and resource drain; high potential for user error and data inconsistency.[18, 16]                 | **Not Recommended**      |
| **Phased**       | The system is migrated in stages based on modules or business contexts.[17, 18, 19]                  | Significantly reduces risk by allowing for focused testing and validation of each component. Allows the team to learn and improve the process with each phase.[18, 14, 19] | Longer total migration timeline; may require temporary interfaces between migrated and non-migrated components.[19]   | **Strongly Recommended** |

**3.2. Phased Migration Plan Outline**

**Phase 0: Prerequisite - Schema Remediation and Environment Preparation**

1. **Build Target Schema:** Fully implement the new, refactored, and context-aligned database schema as recommended in Section 2. This includes all tables, constraints, and security configurations.
2. **Prepare Environments:** Set up and secure the new production and testing environments. This includes establishing access controls, monitoring, and backup procedures before any data is moved.[20, 21]
3. **Form Migration Team:** Assemble a dedicated team with specialists familiar with both the legacy application and the new target system.[22]

**Phase 1: Foundational Data (Shared Kernel)**

1. **Data Discovery & Mapping:** Analyze and map the legacy `Student`, `Parent`, and `School` data to the new, normalized tables in the Shared Kernel.
2. **Develop & Test Scripts:** Create and rigorously test ETL (Extract, Transform, Load) scripts to clean, transform, and load this foundational data.
3. **Execute & Validate:** Migrate all historical data for these core entities. Perform thorough validation to ensure all records are present and relationships are intact.

**Phase 2: Opportunity Scholarship Context**

1. **Data Mapping:** Map legacy OS application, award, and household data to the new `OS_AnnualEnrollments`, `OS_Awards`, and `OS_Households` tables.
2. **Develop & Test Scripts:** Create scripts to migrate this transactional data, ensuring all foreign key relationships to the already-migrated Shared Kernel data are correctly established.
3. **Execute & Validate:** Migrate all historical OS data and validate its integrity and consistency.

**Phase 3: ESA+ Context**

1. **Data Mapping:** Map legacy ESA+ application, award, and provider data to the new `ESA_AnnualEnrollments`, `ESA_Awards`, and `ServiceProviders` tables.
2. **Develop & Test Scripts:** Create and test migration scripts for all ESA+ historical data. This phase must include a strategy for handling any available historical data related to `ClassWallet` transactions.
3. **Execute & Validate:** Migrate and validate all historical ESA+ data.

**Phase 4: Final Cutover and Decommissioning**

1. **Plan Cutover:** After all historical data is migrated and validated, plan a final cutover event for live operational data. This will be a smaller, more manageable "Big Bang" for only the most recent transactional data.[19]
2. **Execute Cutover:** During a planned maintenance window, perform the final data sync and switch all users and system integrations to the new application.
3. **Post-Migration Audit:** Conduct a post-migration audit to verify that all data was transferred correctly and that the new system is meeting performance and security KPIs.[21]
4. **Decommission Legacy System:** Once the new system is confirmed to be stable and correct, formally retire and decommission the old application and its database.[21]
