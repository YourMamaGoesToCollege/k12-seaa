# Household & Student Management (15+ features)

The **Household & Student Management (HSM) domain** is the foundational entry point for all end-users of the K12/SEAA system and comprises more than 15 features.

## Overview

The Household & Student Management domain includes workflows that guide parents and students through the entire scholarship lifecycle, beginning with the initial application and continuing through fund spending, compliance monitoring, and annual renewal. This domain covers the core entry points for end-users, including **ESA+ and Opportunity Scholarship (OS) application workflows**, **renewal processes**, and student profile and account management.

This domain is a key focus of **Phase 1: Foundation & Core Applications (Weeks 1-8)**, dedicated to delivering the core application forms using **Angular reactive forms** to meet the May 1, 2026 hard deadline.

## Categorized Breakdown of Workflows

The Household & Student Management domain organizes critical user interactions into three main workflow categories:

### Application and Onboarding Workflows

* **ESA+ New Application Submission:** The workflow for submitting an ESA+ application, which includes inputting student eligibility information, uploading the Eligibility Determination Document (EDD), verifying domicile, and confirming prior public school enrollment.
* **Opportunity Scholarship New Application Submission:** The process that captures student demographics, household composition, income data for tier calculation, and domicile information, leading to lottery participation.
* **Application Status Tracking and Notifications:** The feature that allows the household user to monitor the current state of their application (e.g., draft, submitted, eligible, waitlisted).
* **Award Offer Acceptance/Decline:** The workflow through which parents acknowledge receipt of an award offer and formally accept or decline the scholarship by the specified deadline.
* **Parent Agreement and LEA Release Signature:** The crucial process requiring parents to electronically sign the annual Parent Agreement and the Local Education Agency (LEA) Release (if attending a full-time nonpublic or home school) before funds are activated.

##### Lifecycle, Renewal, and Compliance Workflows

* **Annual Renewal Application Submission:** The simplified workflow used by existing recipients of both OS and ESA+ to re-qualify for the subsequent program year, which includes confirming household and enrollment status.
* **ESA+ Continuing Eligibility Re-evaluation:** The specific task flow required every three years to submit fresh documentation of a student's disability (IEP/Eligibility Determination) to maintain eligibility.
* **Minimum Spending Verification Check:** The end-of-year process that checks if the ESA+ student has met the required annual spending threshold of **$1,000** on allowable expenses; failure results in non-renewal.
* **Parent/Household Profile Management:** Allowing users to update contact information, household member details, communication preferences, and account security settings (like MFA).
* **School Selection and Transfers:** The feature enabling parents to search for eligible schools, select a school option (Direct Payment, Reimbursement, Home School), and submit mid-year transfer requests.
* **Parent Endorsement (Semesterly):** The workflow where the parent is required to electronically confirm the student’s enrollment and authorize the disbursement of funds to a Direct Payment School each semester (Fall and Spring).

##### ESA+ Purchasing and Fund Management Workflows

* **ESA+ Purchase Request (Marketplace/Service Provider Payment):** The process initiated in ClassWallet to purchase products from vendors or pay enrolled service providers, subject to allowable expense categories and rules engine validation.
* **ESA+ Off-Market Expense Submission:** The workflow for purchasing products from non-marketplace vendors, requiring parents to upload an invoice or screenshot for manual review and approval by SEAA staff.
* **Communication and To-Do Task Orchestration:** The system that delivers email and in-app notifications regarding deadlines, application status, payment confirmations, and organizes mandatory tasks (like document uploads or signatures) into a central To-Do list.
* **Award History and Payment Tracking:** The ability for parents to view past and current award amounts, track payment disbursements to schools, and review the transaction history of their ESA+ wallet.

## Thorough Description

The HSM domain manages the core user experience and ensures ongoing compliance across both ESA+ and OS programs.

### Application Workflows (ESA+ and OS)

* **Parent Identity and Access:** The parent who creates the MyPortal account should be the person with whom the student resides, potentially 50% or more of the time in cases of shared custody. Only **one parent** can be listed as the parent of record. Parents must manage account security, including passwords and Multi-Factor Authentication (MFA).
* **ESA+ Application:** Requires the parent to submit the student's eligibility information and disability documentation. The mandatory document is the **Eligibility Determination Document (EDD)**, which must be uploaded within **7 days** of application submission via a MyPortal To-Do list item. The EDD must be a legal document from an NC public school (or Department of Defense school in NC) identifying the student as having a disability and being eligible for special education services.
* **Opportunity Scholarship (OS) Application:** This requires detailed input on **household composition and income data** to determine the award tier and scholarship amount. Total household income must be calculated based on the **2024 calendar year** from all sources **before deductions** (not Adjusted Gross Income). Foster children are automatically placed in Award Tier 1 (the highest scholarship amount) and their status is verified via the NC Department of Health and Human Services (DHHS).
* **Domicile Verification:** Both applications require proof of domicile (residency in North Carolina). Acceptable evidence includes verified State Driver's License (via DMV), verified State Voter Registration (via State Board of Elections), verified public benefits (via DHHS or Commerce), verified tax filing (via Department of Revenue), verified public school enrollment (via DPI), or documents uploaded by the parent like a utility bill or bank statement.

##### Lifecycle Management and Compliance

* **Renewal:** Students must renew annually using a simplified workflow in MyPortal.
* **ESA+ Continuing Eligibility:** The EDD must be updated at least **every 3 years** from the date of the eligibility determination currently on file. Failure to meet this requirement by January 1 can result in funds being forfeited and the student becoming ineligible for the next renewal.
* **ESA+ Minimum Spending:** The parent agrees to spend at least **$1,000 per year per student** on allowable expenses. If this threshold is not met by the end of the school year, the student will not be eligible for renewal.
* **Legal Agreements:** The Parent must electronically sign the annual **Parent Agreement**. For ESA+ students attending nonpublic or home schools full-time, the **LEA Release** must also be signed, which waives the child's right to receive public school special education services during program participation.
* **School Selection and Transfers:** Awards are **portable**. Parents must select the enrollment option (Direct Payment, Reimbursement, Home School) in MyPortal. Transfers are easiest between semesters. If a mid-semester transfer occurs, the first school may be entitled to keep 100% of that semester's funding if the student attended for more than 7 weeks, potentially leaving no ESA+ funds for the second school that semester.

## Dependencies

The timely and compliant execution of Household & Student Management workflows is critically dependent on several internal cross-cutting services and external agency integrations.

### Internal Cross-Cutting Services

* **Identity & Security (Microsoft Entra ID):** The entire domain depends on **Role-Based Access Control (RBAC)** and Multi-Factor Authentication (MFA) to ensure only the authorized parent can access the student's data and funds.
* **Document Service (PandaDocs/Azure Blob):** This service handles the secure **upload and storage** of critical documents like the Eligibility Determination Document (EDD) and IRS transcripts. It also coordinates **e-signatures** for the Parent Agreement and LEA Release forms (PandaDocs integration).
* **Rules Engine:** Critical for enforcing compliance rules, calculating OS income tiers, and enforcing ESA+ minimum spending and accessory purchase timing constraints. The Rules Engine integration is slated for Phase 2 (Weeks 11-12, starting late December 2025).
* **Communication Center/Messaging Center:** Required to deliver **To-Do task orchestration** (e.g., upload EDD, sign LEA Release), send application status notifications, and issue deadline approaching warnings. This is implemented early in Phase 2.

##### External Integrations

* **State Agency Integration Framework:** This framework, initiated in Phase 3 (Weeks 13-16, starting January 2026), is mandatory for **domicile and income verification**. It exchanges data with the **DMV, DPI, Department of Revenue, DHHS, Department of Commerce, and State Board of Elections**.
* **ClassWallet Integration:** This Phase 4 dependency is essential for all ESA+ families who receive remaining funds after tuition is paid, or who are home school families. It manages the digital wallet, purchase requests, and transaction logging. This integration is scheduled for Phase 4 (Weeks 17-18, starting February 2026).

## Critical Success and Risk Factors

The success of the Household & Student Management domain depends on completing core application features early and mitigating high-risk external dependencies.

### Critical Factors for Success

* **Reactive Forms Pivot:** The core application forms (ESA+ and OS) must be completed in **Phase 1 (Weeks 1-8)** using **Angular reactive forms**. This approach (Option B) was selected because continuing development of the dynamic Enrollment Builder (Option A) would have resulted in an unacceptable schedule failure, missing the May 1, 2026 deadline by **6+ months**.
* **Early Integration Commitment:** State agency integrations must progress as planned in Phase 3 (January 2026) to support legally mandated verification workflows (G.S. 115C-562.3).
* **Compliance Automation:** The system must accurately automate compliance checks tied to parental behavior, such as enforcing the **$1,000 minimum spend** requirement before allowing renewal.

### Critical Risks

* **State Agency Delays (HIGH RISK):** Delays in coordinating or integrating with the seven required state agencies (Phase 3) pose a high risk to the schedule. The mitigation plan includes **manual fallback workflows** for each agency, allowing the project to proceed temporarily with manual verification if electronic integration is delayed.
* **Incomplete Cross-Cutting Services:** If Phase 2 services (Rules Engine, Communications, Security) are delayed, all application and renewal workflows will lack the necessary logic, task orchestration, and security required for auditability and compliance.
* **Document Submission Failure:** Failure to validate critical documents, particularly the **7-day deadline** for the ESA+ Eligibility Determination Document upload, could lead to a backlog of ineligible applications or require extensive manual review.
* **Performance at Scale:** Household Management, especially application and renewal submissions, occurs during peak load periods. The platform must be validated via **load testing** (Phase 7) to ensure it can support **80,000+ concurrent users** without crashing, as the legacy system did.
