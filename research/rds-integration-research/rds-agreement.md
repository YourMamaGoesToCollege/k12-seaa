# RDS

## RDS Integration Solution Design (K12 Residency Validation)

| Document Status                    | Version | Last Updated | Owner                                |
| :--------------------------------- | :------ | :----------- | :----------------------------------- |
| **DRAFT / CONFIRMED ARCHITECTURE** | 1.0     | 2025-10-XX   | K12 System Architect / Product Owner |

---

### Executive Summary: K12 Residency Validation Integration

This document summarizes the proposed asynchronous integration between the K12 application (MyPortal K12) and the Residency Determination Service (RDS), managed by CFI. The primary mechanism for communication is **Azure Service Bus**, utilizing queues hosted within the K12 Azure environment.

The critical architectural decision is that RDS will process requests and retrieve data from state agencies (DOR and DMV), but RDS will return the **raw agency evaluation data** within the response payload. The **K12 system will be the authoritative source of truth** for residency determination, applying K12-specific business rules and logic to the raw data provided by RDS.

The process is asynchronous, typically taking **24–36 hours** to send a response back, based on the DOR and DMV file processing schedules (daily).

---

### 1. Solution Summary and Architecture

#### 1.a. Integration Flow and Key Components

The K12 Residency Validation service is part of the overall RDS validation service intended to validate K12 applicant residency.

**Data Flow:**

1. **K12 Request:** The K12 application creates a request payload containing household member data (e.g., described in Request payload documentation). K12 puts a message for residency validation data into an **Azure Service Bus Queue** (hosted in the K12 Azure environment). RDS will provide an acknowledgement response for the request.
2. **RDS Processing:** The RDS validation service picks up the message from the K12 Azure queue to process the request. The RDS system then validates residency using DOR (tax filings, daily at 7:30 PM EST) and DMV (Driver's Licence evaluation and Vehicle Registration, daily at 7:00 AM EST).
3. **RDS Response:** When responses return from DOR and DMV, RDS processes them and pushes the result back into a K12 Azure Service Bus Queue. RDS will send the **raw data** from each agency evaluation (DOR and DMV) as part of the overall response payload, which includes detailed tracking information. The response structure also includes a `completionStatus` and any `expand/expando` data for correlation.
4. **K12 Determination:** K12 processes the residency response, runs its own residency rules (based on input from SEAA) against the raw agency data, and performs a rollup to determine residency (`validationResult = Y/N`). **K12 is the source of truth** for the final residency determination decision.

**Key Integration Technology:**

* **Messaging:** **Azure Service Bus** is used for reliable asynchronous messaging, including message queues and dead letter queues.
* **K12 Platform:** The target system is a cloud-native, microservices-based architecture hosted on **Microsoft Azure**, utilizing services like Azure App Service, Azure Functions, Azure SQL Database, and Azure Key Vault.

#### 1.b. Environment(s) for Solution

The integration components leverage the K12 Azure environment. RDS requires connectivity to the K12 queues across all relevant environments.

| Environment Type      | Purpose/Usage                        | Location                        |
| :-------------------- | :----------------------------------- | :------------------------------ |
| **Development/CI/CD** | Developer testing, automated testing | K12 Azure Environment / Sandbox |
| **Staging/UAT**       | User acceptance testing              | K12 Azure Environment           |
| **Production**        | Live operations                      | K12 Azure Environment           |

For each environment, K12 must provide RDS (CFI) with the necessary connection information and credentials to access the queues.

---

### 2. Define Security Handshake

The security model focuses on providing RDS (as an external client) secure access to the K12-owned Azure Service Bus queues.

1. **Secure Connection Requirement:** A secure connection to the Azure Service Bus is mandatory.
2. **Credential Management:** K12 needs to provide RDS with **Connection Information (credentials, etc.)** for each environment to enable RDS to connect to the K12 message queue. These credentials (API keys, connection strings) will typically be managed securely by the K12 system using **Azure Key Vault**.
3. **Access Control:** RDS will be a client coming in to pick up and drop off messages in the K12 Azure environment. K12 may need to open up firewalls to allow this access.
4. **Standard Security Protocols:** The underlying K12 architecture utilizes robust security features including Azure Active Directory (Entra ID) and Azure Private Link for network isolation. The final technical specification will need to confirm the exact authentication mechanism used for the Service Bus connection, which may be API keys or Mutual TLS (mTLS).
5. **Auditability:** Security procedures must ensure a full **audit trail** for all residency determinations and API calls for compliance.

---

### 3. When/Schedule for Solution

The integration is a multi-phased project tracked across multiple Program Increments (PIs).

| Project Epic/Version                     | Status                     | Target Fix Versions |
| :--------------------------------------- | :------------------------- | :------------------ |
| Enabler and RDS Integration ([K12-2964]) | Ready for BA               | PI 2, PI 3          |
| RDS Integration ([K12-3844])             | Open (Implementation Epic) | PI 4                |

**Integration Timeline Milestones (Draft Roadmap):**

The comprehensive integration roadmap suggests the following sequence, assuming the discovery and research were completed around October 2025:

| Phase                               | Activities/Target                                                                   |
| :---------------------------------- | :---------------------------------------------------------------------------------- |
| **Phase 0: Discovery & Planning**   | Schedule meeting, review MOUs, finalize architecture.                               |
| **Phase 1: Proof of Concept (PoC)** | Set up sandbox access, implement basic authentication, test case creation/query.    |
| **Phase 2: Adapter Development**    | Build RDS Adapter microservice, implement retry/circuit breaker, add caching layer. |
| **Phase 3: Integration Testing**    | End-to-end testing, load testing, security penetration testing, UAT.                |
| **Phase 4: Pilot Deployment**       | Deploy to production with feature flag (10% traffic).                               |
| **Phase 5: Full Rollout**           | Enable integration for 100% of applications, establish ongoing monitoring.          |

**Operational Timeline:**

* **Agency Processing:** DMV runs daily at 7:00 AM EST, and DOR runs daily at 7:30 PM EST.
* **Determination Time:** The process is asynchronous and normally takes **24–36 hours** to send a response back.
* **Peak Volume:** The biggest volume of residency determination requests is expected during the application period (February–April).

---

### 4. Data Retention Requirements (Needs Discussion)

The current plan requires more focused discussion and definition regarding data retention, as this is currently a critical unknown and a high-priority topic.

**Current Status and Requirements:**

* **Critical Unknown:** Need more information, requirements, and rules about data retention for residency information.
* **Data Classification:** The data exchanged includes PII (SSN, name, address, DOB) and is considered **HIGH** sensitivity.
* **Audit Requirement:** All RDS and K12 residency operations, including the raw data received from DMV and DOR, must be included in the application **audit log system** for full traceability and external auditing.
* **Statutory Framework:** The K12 team needs to determine the applicability of retention policies. Residency verification falls under G.S. 115C-562.3, which mandates electronic verification across state agencies.
* **Action Items:** Jill/PVG were assigned to retrieve the next level of requirements/retention policies from SEAA. The technical specification template currently leaves audit log retention (`_____ years`) and data retention (`_____ years`) as **[TO BE DETERMINED]**.

**Needed Discussion Points:**

The team must convene a focused meeting to finalize retention rules, specifically covering:

1. **K12 Source of Truth Data:** How long must K12 retain the final residency determination, and must this align with FERPA guidelines for student records?
2. **Raw Agency Data Retention:** Since RDS returns the raw data from DOR/DMV evaluations, what is the required retention period for this high-sensitivity PII?
3. **Audit Log Retention:** What is the mandated retention period for the comprehensive audit log detailing every stage of the validation process (request, responses, final decision, appeals)?
4. **Data Deletion:** Are there "right to be forgotten" or data minimization requirements that dictate when and how archived or purged cases must be handled?
5. **Agency MOUs:** Confirm data retention obligations stemming from the underlying data sharing agreements RDS has with DOR and DMV.
