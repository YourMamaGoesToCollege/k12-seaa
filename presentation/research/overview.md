# Technical Roadmap Overview

The K-12 SEAA Modernization project has a **critical constraint** requiring that **all core functionality must be complete by the hard deadline of May 1, 2026**. Meeting this deadline necessitates the successful implementation of 110+ features across six core functional domains and the timely integration of several critical external systems.

The functional domains and system integrations critical for meeting this hard deadline are detailed below, aligned with the implementation roadmap's critical path (Phases 1 through 6).

## Critical Functional Domains (Six Core Capability Areas)

The entire project scope is defined by these six areas, encompassing all necessary features for the two scholarship programs (ESA+ and Opportunity Scholarship):

1. **Household & Student Management (15+ features):** This domain covers the core entry points for end-users. Critical features include the **ESA+ and OS application workflows**, **renewal processes**, and student profile and account management. Phase 1 (Weeks 1-8) is dedicated to delivering the foundation and core application forms using Angular reactive forms.
2. **Verification & Compliance (15+ features):** This domain is critical for regulatory adherence and includes eligibility verification workflows, ongoing compliance monitoring, and **integrations with 7 state agencies**. The mandatory process of **verification sampling** (4% of applications) and handling non-cooperation falls here. This work is concentrated in Phase 3 (Advanced Workflows & Admin Features) and Phase 6 (Compliance & Reporting).
3. **Admin Portal Operations (30+ features):** This is the operational core for SEAA staff, enabling **application processing and review**, **verification management** (domicile, income, sampling), **award management** (lottery, calculation, lifecycle), and necessary **reporting and analytics**. These features are a primary focus of Phase 3.
4. **Payment & Financial Systems (18+ features):** This domain handles the disbursement of scholarship funds. Critical requirements include **direct payment school processing**, **ESA+ wallet and purchasing** (which relies heavily on ClassWallet integration), **tax reporting (1099-G)**, **rollover management**, and **minimum spending enforcement** ($1,000 threshold for ESA+).
5. **School Management (20+ features):** This focuses on institutional requirements, including **school registration and profiles**, **annual certification workflows**, and the crucial, time-sensitive **semester parent endorsement** process. School portal features are slated for delivery in Phase 5 (Weeks 19-20).
6. **Provider Management (12+ features):** This involves managing service providers (tutors, therapists) who accept ESA+ funds. Key features include **provider registration and enrollment**, the public **provider directory**, and **invoice submission and processing**. Provider features are completed by Phase 5.

## Critical System Integrations and Cross-Cutting Services

To support the core functional domains, specific integration points and foundational services must be delivered early in the roadmap (Phase 2 through 4).

### High-Risk External Integrations

The following external dependencies are considered **high-risk** and exist on the critical path, requiring dedicated Integration Team resources:

* **State Agency Integrations (7 Agencies):** This is a **HIGH-RISK** area due to complexity and external coordination required. These integrations are essential for **domicile and income verification**. The agencies involved include the DMV, DPI, Department of Revenue, DHHS, Department of Commerce, and State Board of Elections. The framework for these integrations is scheduled for Phase 3 (January 2026).
* **ClassWallet Integration:** This is a **HIGH-RISK** vendor dependency critical for all **ESA+ wallet, purchasing, and expense management workflows**. It must be operational for the ESA+ Purchase Request workflows included in Phase 4 (February 2026).
* **Payment Rails:** Necessary infrastructure for **ACH disbursement to schools** in Phase 4 (February 2026).
* **PandaDocs Integration:** Needed for **e-signatures** required for documents such as the Parent Agreement and Affidavit. It is implemented early in Phase 2 (December 2025).

### Essential Cross-Cutting Services

These internal services provide the infrastructure for security, communication, and decision-making across all portals and applications:

* **Identity & Security (Microsoft Entra ID):** Required for **Role-Based Access Control (RBAC)**, Multi-Factor Authentication (MFA), and user account management across the four portals. This is integrated in Phase 2.
* **Rules Engine:** Critical for centralizing complex policy logic such as **eligibility calculation rules**, **award calculation logic**, **lottery selection rules**, and **purchase approval rules**. This integration is slated for Phase 2 (December 2025 - January 2026).
* **Communication Center/Messaging Center:** Essential for automated **email notifications**, **in-app messaging**, and **To-Do task orchestration** to guide parents, schools, and administrators through deadlines and workflow steps. This is implemented early in Phase 2 (December 2025).
* **Document Service:** Provides secure storage (Azure Blob), **virus scanning**, and **document lifecycle management** for critical documents uploaded during verification. This is integrated in Phase 2.
