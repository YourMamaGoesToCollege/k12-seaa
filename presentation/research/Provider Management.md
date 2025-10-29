# Provider Management (12+ features)

The **Provider Management domain** is one of the six core capability areas of the K-12 SEAA system. It focuses on managing service providers (tutors, therapists, transportation) who accept ESA+ funds. This domain encompasses **12+ features** and is primarily scheduled for delivery in **Phase 5: School & Provider Portals (Weeks 19-20)**.

## Overview

The Provider Management domain ensures that only **qualified, enrolled providers** can receive ESA+ payments. It provides the dedicated **Provider Portal** interface and backend logic necessary for service providers to apply for enrollment, maintain their credentials, submit invoices, and track payments. This domain acts as a **gatekeeper for service-based spending** within the ESA+ program.

## Categorized Breakdown of Workflows

The Provider Management domain organizes features across enrollment, public visibility, payment, and compliance:

### Provider Registration & Enrollment

* **Provider Application Submission:** The workflow for individuals or organizations to apply to offer services (tutoring, therapy, transportation) that can be paid with ESA+ funds.
* **Business Information and Credentials:** Submission and review of necessary business information, credentials, licenses, and certifications.
* **Service Category Selection:** Identifying and selecting the specific types of services offered (e.g., tutoring, therapy, transportation).
* **Background Check Processing:** Workflow for conducting required background checks on providers.
* **Provider Agreement Signature:** Requiring providers to electronically sign the service agreement with SEAA.
* **Approval Workflow and Review:** The administrative process for validating credentials and setting the provider's enrollment status to 'enrolled'.

### Public Directory

* **Public Provider Search Functionality:** The searchable list (Provider Search/Directory) that allows parents to find enrolled and qualified service providers.
* **Category and Service Area Filters:** Functionality allowing parents to browse and filter providers based on service type and geographic region.

### Invoice & Payment Processing

* **Invoice Submission Workflow:** The process where the provider submits an invoice for services rendered to a student.
* **Purchase Request Matching and Validation:** The system workflow that matches the submitted invoice to a parent's PurchaseRequest and validates the provider's enrollment status and service category.
* **Payment Processing via ClassWallet:** Executing the fund transfer to the provider via the ClassWallet integration.
* **Payment Tracking and Reporting:** Features allowing providers to view payment confirmations, history, and reconciliation data.

### Compliance & Quality

* **Provider Credential Maintenance:** Tracking and management of annual renewal requirements for credentials and licenses.
* **Provider Suspension/Termination Workflows:** Administrative actions to temporarily or permanently block a provider from receiving payments due to compliance issues or fraud.

## Thorough Description

The Provider Management domain is essential because it ensures that ESA+ funds are spent ethically and effectively on qualifying services.

### Enrollment Requirements

* A **Provider** is an individual or organization offering services (tutoring, therapy, transportation) that can be paid with ESA+ funds.
* Providers must apply via the **Provider Portal**.
* The law requires that service providers have **appropriate credentials**. SEAA asks providers to submit a credential and sign a **Provider Agreement**.
* **Tutors** generally need a teaching certificate (from NC or another state) or a bachelor's degree.
* **Therapists** must individually hold a license or accreditation recognized by a State, regional, or national organization governing their field.
* If quality issues or fraud are detected, the provider's status can be changed to **suspended or terminated**, blocking new invoices.

### Payment Workflows (ESA+ Only)

* Services offered by enrolled providers are paid through the **ESA+ Purchase Request** process, initiated by the parent in **ClassWallet**.
* The provider submits the service invoice, which creates a PurchaseRequest.
* The system validates the **provider enrollment status** and ensures the category is allowable (e.g., tutoring in core subjects: math, science, English/language arts, social studies, or foreign languages).
* Upon approval, the payment is executed, updating the **ScholarshipAccount** balance.
* For transportation services, the first invoice must include a **signed contract** between the parent and the provider, which the PurchaseRequest workflow must validate.

### Directory and Search

* SEAA maintains a **public list of approved providers** who have already documented their credentials. Parents use the **“Search for a Provider”** tool on the ESA+ website.
* Only providers with an `enrollmentStatus` of **'enrolled'** can receive ESA+ payments, which is enforced via the PurchaseRequest validation rules.

## Dependencies

The successful delivery of the Provider Management domain relies on services delivered in Phase 2 and the core financial systems delivered in Phase 4.

### Cross-Cutting Service Dependencies

* **Identity & Security (Microsoft Entra ID):** Required for **Role-Based Access Control (RBAC)** to secure the Provider Portal, ensuring only authorized provider staff can access and manage their account and invoices. This is integrated in **Phase 2**.
* **Rules Engine:** Essential for enforcing service category allowability, validating credentials, and applying compliance checks before payment approval. This is slated for integration in **Phase 2**.
* **Document Service & PandaDocs:** Necessary for the secure **upload and storage** of provider credentials, licenses, and the electronic capture of the **Provider Agreement signature**. This is integrated in **Phase 2**.

### External Integration Dependencies

* **ClassWallet Integration:** This is a **HIGH-RISK** vendor dependency. It is critical because all **invoice submission and payment processing** for providers occur through the ClassWallet platform. This integration must be operational in **Phase 4** (February 2026).
* **Payment Rails:** The infrastructure used for **ACH disbursements** may be utilized for provider payments, depending on the ClassWallet integration model.

### Domain Dependencies

* **Household & Student Management:** Parents initiate the ESA+ Purchase Request (Marketplace/Service Provider Payment) via the Household Portal, which generates the demand for the Provider's service payment.
* **Payment & Financial Systems (Phase 4):** The Provider Portal relies entirely on the infrastructure from this domain for payment execution, reconciliation, and tracking.

## Critical Success and Risk Factors

The Provider Management domain faces risks tied to the external ClassWallet integration and the strict enforcement of credentials and compliance rules.

### Critical Factors for Success

* **Reactive Forms Implementation:** The **Provider registration workflow** must be developed using **Angular reactive forms** (Option B) to ensure timely delivery and avoid the significant schedule delay associated with the Enrollment Builder.
* **ClassWallet Integration:** The timely and reliable integration with **ClassWallet in Phase 4** is paramount, as it is the sole platform used for provider invoicing and payment processing for ESA+ services.
* **Credential Validation Automation:** The system must efficiently validate and track licenses and certifications using the Rules Engine to ensure only currently qualified providers receive state funds, thereby maintaining compliance.

### Critical Risks

* **ClassWallet Integration (HIGH RISK):** Delays or issues with this vendor integration (Phase 4) will block the Provider Portal's core function: submitting and tracking invoices for payment.
* **Fraud and Misuse:** The Provider domain is susceptible to fraud, requiring robust **Rules Engine enforcement** and comprehensive **compliance history tracking** (ComplianceRecord) to prevent non-compliant entities from receiving funds.
* **Credential Lapse:** If the system fails to track **credential renewal deadlines**, payments could be mistakenly sent to unqualified or unlicensed providers, resulting in regulatory exposure.
* **Delayed Portal Features:** If Phase 5 (Weeks 19-20) development is delayed, providers will lack the necessary self-service tools for enrollment and invoice management during critical operational periods.
