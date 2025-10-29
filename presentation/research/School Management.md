# School Management (20+ features)

The **School Management domain** is one of the six core capability areas of the K-12 SEAA system. It focuses on institutional requirements and compliance for schools participating in the ESA+ and Opportunity Scholarship (OS) programs, encompassing **20+ features**. The features in this domain are crucial for ensuring institutional eligibility, tracking student enrollment, and managing financial disbursements, and they are primarily scheduled for delivery in **Phase 5: School & Provider Portals (Weeks 19-20)**.

## Overview

The School Management domain provides the dedicated **School Portal** interface and the backend logic required for school administrators and financial staff to interact with the K12 system. These interactions are heavily compliance-driven, ensuring schools meet statutory requirements such as standardized testing, financial reviews, and background checks.

Key workflows include:

1. **School Registration and Profile Management**.
2. **Annual Certification** of tuition/fees and enrollment.
3. **Semester Parent Endorsement** coordination, which is time-sensitive and critical for payment disbursement.
4. **Ongoing compliance monitoring** and reporting.

## Categorized Breakdown of Workflows

The 20+ features are categorized across institutional setup, student management, payment readiness, and ongoing compliance:

### Institutional Setup and Profile Management

* **School Registration Workflow:** The initial process for a private school to apply to participate in the scholarship programs.
* **DNPE Registration Verification:** Verifying the school's registration status with the Division of Non-Public Education (DNPE).
* **School Type Classification:** Defining whether the school is a **Direct Payment School** (accepts direct funds), a **Reimbursement School** (for ESA+ only), or another eligible type.
* **School Administrator Accounts and Roles:** Setting up user accounts and **Role-Based Access Control (RBAC)** for school staff.
* **Banking Information for ACH Payments:** Securely managing the school's bank information required for receiving direct scholarship payments.

### Student Enrollment and Financial Workflows

* **Student Roster Management:** Tools for schools to view and manage their list of enrolled scholarship students.
* **Enrollment Confirmation Workflows:** The process for the school to confirm that an awarded student is enrolled and attending.
* **Annual School Certification:** The annual workflow (typically starting in **August**) where the school confirms student enrollment and **provides the cost of tuition and fees** to SEAA.
* **Semester Parent Endorsement Request Generation:** Generating the time-sensitive electronic task in MyPortal that requires the parent to approve the disbursement of funds to the school (Fall and Spring).
* **Payment Disbursement Tracking:** Features allowing the school to track expected payments, ACH deposit confirmations, and view payment history.
* **Student Withdrawal Processing:** Workflow to notify SEAA when a scholarship student withdraws, potentially triggering refund processing.
* **Dual Award Allocation Tracking:** Viewing how dual awards (OS + ESA+) are allocated to cover tuition.

### Compliance and Reporting Workflows

* **Testing Requirements Tracking:** Monitoring compliance with the requirement that standardized tests be administered to scholarship students in grades **3-12**.
* **Test Results Submission:** Providing test results to NCSEAA, typically by the **July 15 deadline**.
* **Financial Review Requirements (70+ Students):** Tracking schools that cross the threshold of **70 or more scholarship students**, triggering the requirement for a **CPA financial review**.
* **School Leadership Background Check Tracking:** Ensuring that required criminal **background checks for school leadership** are current.
* **Compliance Reporting:** Generating statutory reports and audit-ready exports related to enrollment and testing compliance.
* **School Portal Dashboard:** Providing key metrics on student scholarship status, enrollment, and payment schedules to administrators.

## Thorough Description

The School Management domain enables compliance with **G.S. 115C-562.5** and ensures that funds are properly disbursed to schools.

### Registration and Financial Obligations

* **School Registration:** Schools must register with SEAA and undergo **DNPE registration verification**. They must also submit their **tuition and fee schedule annually**.
* **Direct Payment Schools:** These are NC private schools that accept direct tuition payments from SEAA and accept both ESA+ and Opportunity Scholarship funds. For SEAA to send funds, the awarded student must be enrolled and attending, and the school must be selected as the active school choice in MyPortal.
* **ESA+ Reimbursement Schools:** These are schools registered with DNPE that do not accept Direct Payment. Parents must pay tuition up front and then submit for reimbursement via the ClassWallet/MyPortal flow.
* **Certification:** This is a **school responsibility** completed **once a year, in August**. The school confirms student enrollment and provides the cost of tuition and required fees.

### Parent Endorsement and Payment

* **Parent Endorsement:** This is a crucial, time-sensitive electronic MyPortal task required in the **Fall** (August/September) and **Spring** (January/February) semesters. The parent must verify the student is attending, confirm the school choice is correct, and approve the funds to be sent to the school.
* **Payment Disbursement:** Funds are processed to schools via **ACH payment file generation** in **Phase 4**. The payment is dependent on the completion of the school's Annual Certification and the parent's Semester Endorsement.
* **Dual Award Allocation:** The system must track the **dual award ordering logic**, applying **Opportunity Scholarship funds before ESA+ funds** for tuition and fees.

### Statutory Compliance Requirements

* **Testing:** Nonpublic schools accepting scholarship students must administer nationally standardized tests to students in grades 3-12 and submit results by **July 15**.
* **Financial Review:** Schools enrolling **70 or more scholarship students** must contract with a CPA for an **annual financial review**.
* **Background Checks:** Schools must conduct criminal **background checks** on their decision-making authority.

## Dependencies

The School Management domain relies heavily on foundational services built in earlier phases and essential external integrations. School portal features are developed in **Phase 5**.

### Cross-Cutting Service Dependencies

* **Identity & Security (Microsoft Entra ID):** Required for **Role-Based Access Control (RBAC)** to ensure only authorized school administrators can access and update student rosters, certification data, and financial information. This is integrated in **Phase 2**.
* **Communication Center/Messaging Center:** Essential for delivering **Parent Endorsement requests** and reminders to parents, as well as sending escalating deadline notifications to school administrators regarding certification and compliance (e.g., testing deadline). This is integrated in **Phase 2**.
* **Document Service (PandaDocs):** Needed for managing required document uploads and potentially for obtaining e-signatures on contracts or compliance affidavits. This is integrated in **Phase 2**.

### External Integration Dependencies

* **DNPE Integration:** The system relies on the **Division of Non-Public Education (DNPE)** as the authoritative registry for private and home school status.
* **Payment Rails:** The underlying infrastructure required for **ACH disbursement to schools** in **Phase 4**.
* **DPI Integration:** The integration with the Department of Public Instruction (DPI) provides the **annual State per pupil allocation** by the **December 1 deadline**, which is essential data for the Award Calculation engine (Phase 3).

### Domain Dependencies

* **Payment & Financial Systems Domain (Phase 4):** The School Management portal relies on the payment infrastructure from this domain to display payment tracking, reconciliation, and ACH deposit confirmations.
* **Admin Portal Operations Domain (Phase 3):** Relies on the Admin Portal's **Award Management** workflows for Award Calculation, which dictates the amounts schools expect to receive.
* **Household & Student Management Domain (Phase 1):** Relies on this domain for the **Parent Endorsement** functionality that triggers payment.

## Critical Success and Risk Factors

Success depends on pivoting away from the Enrollment Builder path and accurately automating time-sensitive financial and compliance workflows.

### Critical Factors for Success

* **Reactive Forms Implementation:** The School Registration and core profile features must be implemented using **Angular reactive forms** to ensure timely delivery in **Phase 1 (Weeks 5-8)**. This avoids the **6+ month delay** associated with the Enrollment Builder (Option A).
* **Timely Cross-Cutting Services Delivery:** The foundational Phase 2 services (Identity, Messaging, Rules Engine) must be delivered on schedule (December 2025) to support the security and orchestration required for the **Certification and Parent Endorsement** workflows in Phase 3/5.
* **Compliance Automation:** The system must accurately track and enforce compliance requirements, such as the **July 15 test results deadline** and the **70+ student financial review threshold**, flagging schools for non-compliance automatically.

### Critical Risks

* **Non-compliance Handling (HIGH RISK):** Failure to enforce school obligations (G.S. 115C-562.5), particularly regarding **background checks** or **financial reviews** (for schools with 70+ students), poses a regulatory risk.
* **Payment Processing Failure (HIGH RISK):** Any failure in the Phase 4 **Payment Rails integration** or the complex **dual award allocation** logic would severely impact schools' ability to receive funds, risking immediate operational failure.
* **Delayed Portal Features:** If the dedicated portal development in **Phase 5** (Weeks 19-20) is delayed, schools will lack the necessary self-service tools for roster management and payment tracking during peak operational periods leading into the Fall enrollment cycle.
* **School Endorsement Failure:** If the **case-sensitive signature validation** for the Parent Endorsement process is poorly implemented (a known user experience concern), it could block payments to schools, creating significant support demand and payment delays.
