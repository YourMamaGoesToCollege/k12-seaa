# Admin Portal Operations (30+ features)

The **Admin Portal Operations domain** is one of the six core capability areas of the K-12 SEAA modernization project, defined as the **operational core for SEAA staff**. It delivers the complete administrative toolset necessary to manage the K-12 scholarship programs.

## Overview

The Admin Portal Operations domain encompasses **30+ features** that implement the necessary operational and decision-making workflows across the entire scholarship lifecycle. These features are crucial because they represent the mechanism for executing the core business logic and compliance checks of the entire system. This domain is a primary focus of **Phase 3: Advanced Workflows & Admin Features (Weeks 13-16)** in the implementation roadmap,,.

The features fall into critical areas including Verification Management, Application Processing, Award Management, and Reporting/Case Management,,,.

## Categorized Breakdown of Workflows

The 30+ features are categorized into four core administrative workflow areas:

### Verification Management

* **Domicile Verification:** Staff tools designed to review and manage domicile status, including electronic verification results received via the seven state agency integrations (DMV, DPI, Department of Revenue, DHHS, Department of Commerce, and State Board of Elections),. It includes document evidence review (e.g., utility bills, bank statements) and manual override capabilities,,.
* **Income Verification (OS):** Functions supporting the mandated **4% random sample selection** and identification of error-prone applications,,. This includes workflows for **IRS transcript validation** and handling of non-compliance, which can result in award revocation,.
* **Application Verification Sampling:** Administrative workflows necessary for random selection, case creation, documentation request management, and processing non-cooperation,.

### Application Processing and Review

* **Application Intake & Queue Management:** Tools for managing the queue of submitted applications, checking completeness, and handling data validation,.
* **Eligibility Determination:** Functionality for staff to evaluate eligibility criteria, perform income calculations, review disability documentation (for ESA+), and record the final eligibility decision,.
* **Exception Handling:** Workflows dedicated to managing and resolving exceptions, handling appeals, and assigning applications to specific reviewers.

### Award Management

* **Lottery Administration:** Tools for creating lottery batches, processing random selections, managing priority period preferences, and maintaining a complete **audit trail**,.
* **Award Calculation:** System features that manage the complex logic for **ESA+ award amount determination** ($9,000 vs. $17,000),, **OS tiered award calculation** (income-based), **dual award ordering logic** (OS before ESA+), and integration of the annual **Per Pupil Allocation** data from DPI,,.
* **Award Lifecycle:** Management of award offers, tracking acceptance deadlines, and processing mid-year adjustments, suspension, termination, and renewal processing,.

### Reporting, Analytics, and Case Management

* **Operational Dashboards:** Provide staff with metrics on the application pipeline status, processing time, verification completion rates, and payment disbursement status,,.
* **Compliance Reports:** Tools for generating **statutory reporting** and audit trail exports, financial reconciliation data, and state agency coordination reports,,.
* **Document Management:** Features for processing document uploads, review workflows, securing storage, and managing the **PandaDocs integration for e-signatures**,.
* **Case Management:** Includes tools for running **bulk communication campaigns**, automating deadline reminders, and managing the exception queue,,.
* **System Administration:** Tools for **Role-Based Access Control (RBAC)**, user account management, and Microsoft Entra ID integration,,.

## Thorough Description

The Admin Portal is fundamental to the SEAA's mandate to ensure **100% regulatory compliance** and manage high-volume application processes.

### Application Processing and Eligibility Review

The portal manages the high volume of incoming applications, requiring staff functionality to check completeness and handle exceptions. Eligibility determination involves evaluating criteria, reviewing disability documentation (for ESA+), and recording the final decision,,. A key outcome of application processing is generating award offers,.

### Verification Management

The Admin Portal features directly implement the statutory requirements of the Verification & Compliance domain.

* **Domicile Verification:** Staff rely on electronic results from **seven state agency integrations** (DMV, DPI, Revenue, DHHS, Commerce, Elections, and State Board of Elections) to confirm North Carolina residency,,. The tools support reviewing manually submitted documents and executing manual overrides when necessary,.
* **Application Verification Sampling:** The administrative workflows support the mandatory requirement to verify **4% of scholarship applications annually**,,. This includes setting up verification cases, tracking documentation requests, and managing cases where households fail to cooperate, which leads to **award revocation**,.
* **Income Verification (OS):** For sampled applications, staff tools manage the **IRS transcript validation** and income calculation review necessary to confirm the household's income tier,,.

### Award Management and Calculation

The Admin Portal houses the complex logic governing scholarship issuance.

* **Lottery and Waitlist:** Staff manage lottery batches, random selections, and the waitlist when funding is limited,,.
* **Award Calculation:** The system must accurately determine:
  * **ESA+ amounts** ($9,000 or the higher $17,000 award based on disability category),,.
  * **OS tiered amounts** based on income,.
  * The **dual award ordering logic** (Opportunity Scholarship funds applied before ESA+ funds for tuition/fees),.
  * The integration of the **annual State Per Pupil Allocation** data provided by DPI,,.

### Operational Management and Auditing

The portal utilizes cross-cutting platform services for administrative tasks. This includes robust tools for document management, interfacing with the **PandaDocs e-signature integration** for Parent Agreements and LEA Releases,, and leveraging the Communication Center for bulk campaigns and automated deadline reminders,,. Operational Dashboards and Compliance Reports ensure transparency, allowing staff to monitor processing status, payment disbursements, and generate statutory reporting exports,,,.

## Dependencies

The functionality of the Admin Portal relies extensively on external governmental integrations and critical internal cross-cutting services, many of which are delivered concurrently in Phase 2 and Phase 3,.

### Cross-Cutting Service Dependencies

* **Identity & Security (Microsoft Entra ID):** Essential for **Role-Based Access Control (RBAC)**,,, ensuring only authorized SEAA staff can access specific administrative functions (e.g., verifying income or managing awards),.
* **Rules Engine:** Critical for centralizing and executing complex logic used during verification, eligibility determination, and award calculation,,. This is slated for integration in Phase 2 (Weeks 11-12).
* **Document Service & PandaDocs:** The service handles secure document **upload and storage**,, and the **e-signature integration** (PandaDocs) is crucial for managing legally binding documents like the Parent Agreement and LEA Release,,.
* **Communication Center/Messaging Center:** Required for **To-Do task orchestration** (e.g., notifying households selected for verification) and sending bulk and scheduled notifications,,,.

### External Integration Dependencies

* **State Agency Integration Framework:** This **HIGH-RISK** dependency is mandatory for the **Domicile and Income Verification** features in the Admin Portal,,. The framework, initiated in Phase 3,, coordinates electronic data exchange with the **seven state agencies** (DMV, DPI, Department of Revenue, DHHS, Department of Commerce, and State Board of Elections),,.
* **DPI Integration:** Specifically required for providing the annual **Per Pupil Allocation** data, which feeds into the Award Calculation engine by the mandated **December 1 deadline**,,.

### Domain Dependencies

* **Verification & Compliance Domain:** The Admin Portal is the front-end interface for executing the policy and rule sets defined by the V&C domain (e.g., Application Verification Sampling, Income Verification),.
* **Payment & Financial Systems Domain:** Relies on the financial systems in Phase 4 for executing payments triggered by administrative actions (e.g., direct school payments, refunds, rollbacks),.

## Critical Success and Risk Factors

The success of the Admin Portal Operations domain hinges on successfully pivoting away from a problematic development path and ensuring external dependencies do not halt core operational workflows.

### Critical Factors for Success

* **Reactive Forms Pivot:** The decision to implement the 30+ features using **Angular reactive forms** (Option B) was critical for meeting the **May 1, 2026 hard deadline**,. This approach ensures that mission-critical operational workflows are delivered on time, avoiding the **6+ month delay** that continuing the dynamic Enrollment Builder (Option A) would have caused,.
* **Timely Cross-Cutting Services Delivery:** Phase 2 services (Rules Engine, Communications, Security) must be delivered on schedule (December 2025 – January 2026) to provide the necessary logic, orchestration, and security for the Admin Portal workflows to function in Phase 3,.
* **Integration Progress:** State agency integrations must progress as planned in Phase 3 to support legally mandated **domicile and income verification** workflows (G.S. 115C-562.3),.

### Critical Risks

* **State Agency Delays (HIGH RISK):** Delays in coordinating or integrating with the seven required state agencies (Phase 3) pose a high risk to the schedule, particularly impacting the Domicile and Income Verification features within the Admin Portal,,,.
  * **Mitigation:** The plan includes **manual fallback workflows** for each agency, allowing SEAA staff to temporarily proceed with manual verification if electronic integration is delayed,.
* **Incomplete Core Workflows:** If the deployment of core administrative functions is delayed, staff will be unable to process applications, execute lotteries, or manage awards, leading to operational failure regardless of the external-facing applications,.
* **Performance at Scale:** While the Admin Portal is primarily used by staff, the underlying infrastructure must support the high transaction volume generated by parallel processes such as automated verification sampling and award calculation during peak periods,.
