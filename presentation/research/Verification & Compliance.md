# Verification & Compliance (15+ features)

The **Verification & Compliance (V&C) domain** is one of the six core capability areas of the K-12 SEAA modernization project, comprising **15+ features**.

## Overview

The primary function of the Verification & Compliance domain is to ensure regulatory adherence and eligibility across both the ESA+ and Opportunity Scholarship (OS) programs. This domain is critical for enforcing statutory mandates, particularly those related to eligibility determination and application auditing.

The core work within this domain is concentrated in **Phase 3** (Advanced Workflows & Admin Features) and **Phase 6** (Compliance & Reporting) of the implementation roadmap.

### Key Functional Components

The V&C domain implements several legally mandated workflows and monitoring systems, including:

1. **Eligibility Verification Workflows** for domicile determination, income verification (for OS), and disability verification (for ESA+).
2. **Ongoing Compliance Monitoring** such as tracking the annual DPI per pupil allocation update, school testing compliance, school financial reviews (for schools with 70+ students), and provider credential renewals.
3. **Audit and Compliance Reporting** features.

### Mandatory Verification Sampling (4% Rule)

A critical component of this domain is the mandatory process of **application verification sampling**, dictated by state statute (G.S. 115C-562.3). The Authority must verify **4% of scholarship applications annually**. This 4% sample must include both randomly selected applications and those identified as **error-prone**. If a household fails to cooperate by providing the required documentation by the set deadline, the Authority must **revoke the award**.

## Categorized Breakdown of Workflows

The Verification & Compliance domain supports workflows across application intake, ongoing program participation, and mandated auditing:

### Eligibility Verification Workflows

* **Domicile Determination and Verification:** Workflows establishing North Carolina residency, relying primarily on electronic verification through multiple state agencies.
* **Income Verification (OS):** The workflow for capturing household composition and income data to determine the income-based award tier and scholarship amount. This includes IRS transcript validation for sampled applications.
* **Disability Verification (ESA+):** The review and validation process for the **Eligibility Determination Document (EDD)** and confirmation of prior public school enrollment, which is required for initial eligibility.

### Mandatory Compliance Workflows

* **Application Verification Sampling:** The service required for **random selection** and the identification of error-prone applications for the **4% mandatory sample**.
* **Non-cooperation Handling:** The administrative and automated workflows necessary to manage cases where households fail to provide requested verification documents, leading to the **revocation of the award**.
* **Rules Enforcement and Audit Trail:** Implementing and enforcing complex policy rules via the Rules Engine for checks like allowable expenses, accessory timing, and enrollment status.

### Ongoing Annual Monitoring Workflows

* **ESA+ Continuing Eligibility Re-evaluation:** The required task flow to submit fresh documentation of a student's disability (IEP/Eligibility Determination) every **three years** to maintain eligibility.
* **Minimum Spending Verification Check:** The end-of-year process that checks if the ESA+ student met the required annual spending threshold of **$1,000** on allowable expenses, the failure of which results in non-renewal.
* **Per Pupil Allocation Update:** The system task to track and integrate the annual average State per pupil allocation from DPI by the **December 1 deadline**.
* **School Compliance Monitoring:** Tracking school adherence to testing compliance (due July 15) and financial review requirements (for schools with 70+ scholarship students).

## Thorough Description

The V&C domain is founded on the requirement for **100% regulatory compliance**.

##### Domicile Determination

Both ESA+ and OS applications require proof of domicile (residency in North Carolina). Verification relies on electronic data exchange with multiple state agencies. Acceptable evidence includes verified State Driver's License (via DMV), verified State Voter Registration (via State Board of Elections), verified tax filing (via Department of Revenue), or documents uploaded by the parent like a utility bill or bank statement.

##### Income Verification (OS)

Income calculation determines the award tier and scholarship amount, though all NC students are eligible for the Opportunity Scholarship regardless of income. Income must be calculated based on the **2024 calendar year** from all sources **before deductions**. The verification process for selected households (4% mandatory sample, plus error-prone applications) involves **IRS transcript validation** and must follow federal verification requirements, referencing guidance used for free and reduced-price lunch applications.

##### ESA+ Continuing Eligibility Re-evaluation

To remain eligible, updated documentation of a student's disability must be provided at least **every 3 years** from the date of the eligibility determination currently on file. Failure to meet this re-evaluation requirement by **January 1** can result in funds being forfeited and the student becoming ineligible for the next renewal.

##### Compliance Audit Trail and Reporting

The domain maintains the complete audit trail and includes features for generating statutory reports and tracking policy adherence. This includes systems for generating the ESA+ **1099-G tax reporting** for non-tuition spending.

## Dependencies

The V&C domain is heavily dependent on specific internal cross-cutting services and the successful deployment of high-risk external integrations.

### External Integration Dependencies

* **State Agency Integration Framework:** This framework, mandated by statute (G.S. 115C-562.3), is mandatory for **domicile and income verification**. It involves the electronic exchange of data with **seven state agencies**. The framework is scheduled to be initiated in **Phase 3** (Weeks 13-16, starting in January 2026).
* **Department of Public Instruction (DPI):** Required specifically for verifying public school enrollment (for domicile) and providing the **annual average State per pupil allocation by December 1**.

### Cross-Cutting Concern Dependencies

* **Rules Engine:** Essential for calculating OS income tiers, enforcing the ESA+ **$1,000 minimum spending** requirement, applying accessory purchase constraints, and validating compliance rules. This is integrated in **Phase 2**.
* **Document Service (Azure Blob/PandaDocs):** Required for the secure **upload and storage** of critical documents (like the EDD and IRS transcripts) needed during the verification processes.
* **Communication Center/Messaging Center:** Necessary to orchestrate **To-Do tasks** for households selected for verification sampling and to issue deadline approaching warnings for annual compliance requirements (e.g., EDD re-evaluation, school testing deadlines).
* **Admin Portal Operations Domain:** The Verification & Compliance rules are executed and managed via staff tools located within the Admin Portal (Phase 3 focus), which includes dedicated features for Domicile Verification, Income Verification, and Application Verification Sampling.

## Critical Success and Risk Factors

The V&C domain holds primary schedule risk due to its dependency on external governmental agencies.

### Critical Factors for Success

* **Completion of State Agency Integrations:** The successful, timely coordination and integration with the seven required state agencies in **Phase 3** is mandatory to support legally mandated verification workflows (G.S. 115C-562.3).
* **Compliance Automation:** The system must accurately automate compliance checks tied to parental behavior, such as enforcing the **$1,000 minimum spend** requirement and accurately managing the ESA+ three-year re-evaluation cycle.
* **Rules Engine Integration:** The **Rules Engine** must be fully operational in Phase 2 to ensure verification logic and award tier determinations are centralized, auditable, and accurate across all applications.

### Critical Risks

* **State Agency Delays (HIGH RISK):** Delays in coordinating or integrating with the seven required state agencies (Phase 3) pose a **high risk** to the overall project schedule and compliance readiness.
  * **Mitigation:** The project incorporates **manual fallback workflows** for each agency, which allows the project to proceed temporarily with manual verification if electronic integration is delayed.
* **Incomplete Cross-Cutting Services:** If Phase 2 services (Rules Engine, Communications, Document Service) are delayed, verification workflows and compliance monitoring will lack the necessary logic, document management, and communication tools required for auditability and enforcement.
* **Non-Compliance Handling:** Failure to manage non-cooperating households in the 4% sampling process, or failure to manage the EDD 7-day or 3-year submission deadlines, could lead to regulatory exposure or extensive administrative backlog.
