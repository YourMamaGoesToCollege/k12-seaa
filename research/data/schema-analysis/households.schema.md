# Households Schema Analysis

## Overview

Here is a detailed analysis focusing on the database schema's implementation of the `Households` concept, a critical component of the Opportunity Scholarship program.

### **Analysis of the K12 Scholarship `Household` Schema**

The concept of a "Household" is the cornerstone of the Opportunity Scholarship (OS) program's eligibility and award calculation process. It is a complex and nuanced domain entity with specific legal and financial definitions. An analysis of the schema's likely approach to modeling this concept, based on previously identified anti-patterns, reveals a critical failure to capture this complexity. The resulting design is not only technically unsound but also introduces significant risks to financial accuracy, program auditability, and data privacy.

#### **Section 1: The `Household` Domain Model**

The `Household` is a concept exclusively relevant to the Opportunity Scholarship Bounded Context. Its sole purpose is to determine the `HouseholdSize` and `HouseholdIncome`, which are the two inputs used to calculate a student's award tier.[1] A precise understanding of this domain is a prerequisite for a correct schema design.

* **Definition of a Household:** Program regulations define a household not by familial relation, but as a group of individuals who live together and share income and expenses.[2] This is a crucial distinction that a data model must be able to represent, as it can include non-relatives.
* **The `HouseholdIncome` Value Object:** `HouseholdIncome` is not a simple number; it is a complex, calculated Value Object. State law mandates that this calculation follow Federal Free and Reduced-Price Lunch regulations.[2]
  * **Inclusions:** The calculation must be based on the *gross* income (before taxes and deductions) from the prior calendar year for *all* members of the household.[3] This includes a wide range of sources such as wages, tips, unemployment benefits, alimony, child support, and net income from self-employment.[2]
  * **Exclusions:** The Adjusted Gross Income (AGI) from tax forms is explicitly *not* the correct basis for this calculation.[3, 2]
* **Temporal Nature:** A household's composition and income are not static. They are a snapshot in time, relevant only to a student's application for a single school year. The schema must model this relationship to a specific `AnnualEnrollment`.

#### **Section 2: Critical Analysis of the (Inferred) `Household` Schema**

Given the established pattern of creating monolithic, denormalized tables, it is highly probable that the `Household` concept is not modeled as a distinct entity. Instead, it is likely implemented as a collection of disparate columns on a larger `Applications` or `Students` table.

**Structural and Normalization Flaws**
This inferred design violates fundamental principles of database normalization and data integrity.

* **Violation of First Normal Form (1NF):** To capture the members of a household, the schema likely resorts to anti-patterns such as a `HouseholdMembers` column storing a comma-separated list of names. This makes it impossible to perform any meaningful queries or analysis on household composition and violates the principle of atomicity.[4]
* **Storing Calculated Data:** The schema almost certainly contains a single `TotalHouseholdIncome` column. This is a critical design flaw. Storing the result of a calculation rather than its components makes the system a "black box."[4] It is impossible to audit or verify that the stored amount was calculated correctly according to the complex program rules. If a mistake is made during data entry, the incorrect value is stored with no way to trace the error.
* **Lack of Granularity and Auditability:** Without separate, structured storage for each household member and their various income sources, the system cannot support its own business rules. An auditor could not verify compliance, and a support agent could not help a parent understand how their award tier was determined. This lack of detail renders the system untrustworthy for its core financial function.

**Personally Identifiable Information (PII) and Security Risks**
The `Household` concept inherently deals with highly sensitive PII, including the financial details of multiple individuals. The inferred schema design exacerbates the security risks.

* **Improper Handling of Sensitive Data:** By flattening income data into a single, unstructured table, the schema fails to segregate this sensitive information. Best practices for PII demand that sensitive data be isolated to allow for stricter access controls and encryption.[5, 6] The current design likely stores income data in cleartext, co-mingled with non-sensitive application data, creating a significant security vulnerability.[7, 8, 9]

#### **Section 3: Domain-Driven Design (DDD) Misalignment**

The schema's treatment of the `Household` concept demonstrates a profound disconnect from the principles of Domain-Driven Design, leading to a model that is an inaccurate and inadequate representation of the business reality.

* **Absence of a `Household` Aggregate:** In a domain-aligned model, the `Household` and its members would be modeled as a distinct Aggregate—a cluster of objects treated as a single unit for consistency.[10, 11] This aggregate would be a child of the `OS_AnnualEnrollment` Aggregate Root. The current schema, by contrast, has no concept of this boundary, scattering household-related attributes across a generic table and losing the conceptual cohesion of the domain.
* **Reduction of a Value Object to a Primitive:** The most significant DDD failure is the treatment of `HouseholdIncome`. This is a classic Value Object, defined by its constituent attributes (the various income sources and amounts).[10, 11] Its validity and value are derived from these components. By storing only the final sum, the schema discards the object's intrinsic logic and reduces it to a simple, meaningless decimal, forcing the complex calculation logic to be scattered and likely duplicated throughout the application code.

#### **Section 4: Strategic Recommendations for the `Household` Schema**

To address these critical flaws, the `Household` model must be refactored into a dedicated, well-structured schema within the Opportunity Scholarship Bounded Context. This will ensure accuracy, auditability, and alignment with the business domain.

**Recommendation 1: Create a Dedicated `Household` Schema**
The `Household` concept must be extracted from the monolithic application table and given its own set of related tables.

| Table Name               | Key Columns                                                                             | Purpose                                                                                                           |
| :----------------------- | :-------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| `OS_Households`          | `HouseholdID` (PK), `OS_AnnualEnrollmentID` (FK), `ReportedHouseholdSize`               | The root entity for a household associated with a single, specific OS application for one year.                   |
| `HouseholdMembers`       | `HouseholdMemberID` (PK), `HouseholdID` (FK), `MemberName`, `RelationshipToStudent`     | Stores each individual member of the household, ensuring atomicity (1NF compliance).                              |
| `HouseholdMemberIncomes` | `IncomeID` (PK), `HouseholdMemberID` (FK), `IncomeSourceType`, `CalendarYear`, `Amount` | Explicitly stores each component of the income calculation. This makes the total income verifiable and auditable. |

**Recommendation 2: Model `HouseholdIncome` as a True Value Object**
The application logic should treat the collection of `HouseholdMemberIncomes` records as a Value Object. The total income should *not* be stored in the database. It should be calculated on-demand by the application or through a database view that sums the components. This ensures that the "single source of truth" is the raw data provided by the parent, not a derived and potentially incorrect calculation.

**Recommendation 3: Enforce Integrity and Security**

* **Foreign Keys:** Implement `FOREIGN KEY` constraints to enforce the relationships between `OS_AnnualEnrollments`, `OS_Households`, and `HouseholdMembers`.[12, 4]
* **PII Segregation:** The `HouseholdMemberIncomes` table contains highly sensitive PII. It should be subject to stricter database permissions and column-level encryption to protect this data, adhering to the Principle of Least Privilege.[5, 6, 13]

By implementing these recommendations, the schema will transform from a fragile and unauditable structure into a robust and accurate reflection of the complex business rules that govern the Opportunity Scholarship program.
