# Payment & Financial Systems (18+ features)

The **Payment & Financial Systems domain** handles the reliable and compliant disbursement and tracking of scholarship funds, comprising **18+ features**. This domain is critical for ensuring schools, service providers, and families receive funds accurately and in accordance with state rules.

## Overview

The Payment & Financial Systems domain manages the mechanisms for transmitting scholarship awards and enforcing financial compliance rules, such as ESA+ spending requirements and tax reporting. This work is scheduled for **Phase 4: Financial & Payment Systems (Weeks 17-18)**, beginning in February 2026.

Key components of this domain include:

1. **Direct payment processing** to schools for both ESA+ and Opportunity Scholarship (OS) funds.
2. The implementation and management of the **ESA+ digital wallet and purchasing workflows**, which relies heavily on **ClassWallet integration**.
3. Financial compliance features such as **tax reporting (1099-G)**, **rollover management**, and **minimum spending enforcement**.

## Categorized Breakdown of Workflows

The Payment & Financial Systems domain supports workflows related to institutional payments, ESA+ consumer spending, and financial reporting:

### Direct Payment and Disbursement Workflows

* **Payment Schedule Management:** Planning and executing payments to Direct Payment Schools, typically occurring twice per year (Fall and Spring).
* **Parent Endorsement Validation:** The system confirms the parent has electronically confirmed the student's enrollment and authorized disbursement of funds each semester.
* **Tuition and Fee Calculation:** Determining the precise payment amount owed to the school, considering the school's confirmed costs (Certification).
* **Dual Award Allocation:** Applying complex logic to allocate dual awards, prioritizing **Opportunity Scholarship funds before ESA+ funds** for tuition and fees.
* **ACH Payment File Generation:** Creating and transmitting files to the bank integration (Payment Rails) for direct deposits to schools.
* **Payment Confirmation and Tracking:** Logging payment disbursements, handling failed payments, and supporting payment reconciliation.

### ESA+ Wallet and Purchasing Workflows

* **ClassWallet Account Provisioning:** Setting up and activating the student's digital wallet account.
* **Fund Allocation After Tuition:** Allocating remaining ESA+ funds (if school tuition is less than the total award) to the ClassWallet account each semester.
* **ESA+ Purchase Request Workflows:** Processing requests for purchases, including on-marketplace orders and off-marketplace invoice submissions.
* **Expense Approval Rules Engine:** Enforcing complex constraints, such as allowable expense categories, prohibited expense detection, accessory purchase timing (30-day window), and frequency limits (once every 3 years).

### Financial Compliance and Lifecycle Workflows

* **Minimum Spending Enforcement:** Calculating annual spending and enforcing the **$1,000 threshold** required for renewal eligibility.
* **Rollover Calculation and Processing:** Determining and executing the rollover of unused funds (up to $4,500 annually, total cap $30,000) for **higher award ESA+ students only**.
* **Tax Reporting (1099-G):** Accumulating and reporting ESA+ funds spent on **non-tuition allowable expenses** to the IRS based on the calendar year.
* **Payment Reconciliation:** Matching payment files and transactions between the SEAA system, the bank, schools, and ClassWallet.

## Thorough Description

The Payment & Financial Systems domain ensures the proper flow of state funds, supporting both direct transactions and the ESA+ digital wallet mechanism.

### Direct Payment and Endorsement Process

* **Payment Cycles:** Direct payments to schools typically occur in the fall (August/September) and spring (January/February).
* **Endorsement Requirement:** Payment disbursement is contingent upon the **Parent Endorsement**, an electronic MyPortal task where the parent confirms enrollment and authorizes the funds to be sent.
* **Dual Award Logic:** When a student receives both Opportunity Scholarship and ESA+ awards, the system must apply OS funds before ESA+ funds to cover tuition and required fees.

### ESA+ Wallet and Compliance

* **ClassWallet as Digital Wallet:** ESA+ funds are primarily accessed via **ClassWallet**, a contracted third-party platform that hosts the electronic account.
* **Fund Flow:** If a student attends a Direct Payment school and the school's reported costs are less than the total ESA+ award, the remaining funds move each semester to ClassWallet for use on other allowable expenses. For Home School students, the full ESA+ award is deposited to ClassWallet.
* **Minimum Spending Rule:** The parent must agree to spend at least **$1,000 per year per student** on allowable expenses. If this threshold is **not met** by the end of the school year, the student will be **ineligible for renewal**.
* **Purchase Rules:** The Rules Engine must validate purchase requests against complex policy constraints, such as requiring technology accessories (e.g., cases) to be purchased within **30 days of the main device order** and restricting replacement frequency.

### Tax Reporting and Auditing

* **1099-G Requirement:** The state agency is required to report to the IRS all ESA+ funds spent for anything other than tuition and required fees. The system must generate **1099-G forms** annually based on the prior **calendar year** (Jan 1 - Dec 31).

## Dependencies

The Payment & Financial Systems domain is highly dependent on external integrations and internal policy services delivered in earlier phases. This domain is developed in Phase 4.

### External Integration Dependencies

* **ClassWallet Integration:** This is a **HIGH-RISK** vendor dependency. It is essential for all ESA+ families using the digital wallet for purchases, service provider payments, and expense tracking. This integration must be operational for the ESA+ Purchase Request workflows in Phase 4.
* **Payment Rails:** Necessary infrastructure for **ACH disbursement to schools**, scheduled for Phase 4 implementation.
* **State Agency Integration Framework:** While the core framework is initiated in Phase 3, the system relies on the **DPI integration** to provide the annual **Per Pupil Allocation** data, which is necessary for the Award Calculation Engine.

### Cross-Cutting Service Dependencies

* **Rules Engine:** Critical for centralizing and enforcing complex logic, including the **$1,000 minimum spend rule**, **award calculation logic**, and **purchase approval rules**. This integration is slated for **Phase 2**.
* **Identity & Security (Microsoft Entra ID):** Required for **Role-Based Access Control (RBAC)** to ensure only authorized SEAA Finance staff can manage payments and reconciliations. This is integrated in **Phase 2**.
* **Communication Center/Messaging Center:** Needed to send **Payment Disbursement Confirmations** and notifications regarding minimum spending compliance and rollover amounts. This is integrated in **Phase 2**.

### Domain Dependencies

* **Household & Student Management:** Provides the input for **Parent Endorsement** (Semester Endorsement), which validates the payment trigger.
* **Admin Portal Operations:** Staff tools in the Admin Portal are used for **Award Calculation** and **Payment Reconciliation**.

## Critical Success and Risk Factors

The financial integrity of the K-12 SEAA system depends on the accurate implementation of Phase 4 payment systems and strict management of high-risk external integrations.

### Critical Factors for Success

* **Accurate Compliance Automation:** The Rules Engine must accurately automate compliance checks tied to financial behavior, such as enforcing the **$1,000 minimum spend** requirement and accurately managing rollover calculations, which are prerequisites for annual renewal.
* **Timely ClassWallet Integration:** The **ClassWallet integration** must be delivered on schedule in **Phase 4** to ensure ESA+ families can utilize their funds for purchases and services.
* **Robust Reconciliation:** The system must implement comprehensive **Payment Reconciliation** workflows, including a complete audit trail, to manage the complexity of dual award allocation and transaction integrity with ClassWallet and ACH providers.

### Critical Risks

* **ClassWallet Integration (HIGH RISK):** This vendor dependency is critical and poses a high risk due to the complexity of ESA+ purchasing workflows and the need to ensure transaction integrity and webhook reliability. **Mitigation** includes rigorous sandbox testing and the use of **idempotency keys** for all transactions.
* **Payment Processing Accuracy (HIGH RISK):** Processing financial transactions carries inherent risks related to ACH accuracy, compliance, and the complex **dual award ordering logic** (OS before ESA+). **Mitigation** requires comprehensive testing and strict financial controls.
* **Incomplete Rules Engine:** If the Phase 2 **Rules Engine** is delayed, the Phase 4 financial systems will lack the necessary logic to enforce minimum spending, accessory timing rules, and purchase approvals, leading to potential misuse of funds and non-compliance.
