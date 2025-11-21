# NC Residency Determination Service (RDS) - Comprehensive Research & Integration Guide

**Document Purpose:** Deep technical and business research on the North Carolina Residency Determination Service (RDS) for integration with the K-12 SEAA software system.

**Last Updated:** 2025-10-15  
**Prepared For:** Architect meeting with RDS system owners

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Business Overview](#business-overview)
3. [System Architecture (Level 1-11 Deep Dive)](#system-architecture)
4. [Integration Specifications](#integration-specifications)
5. [Data Models & Formats](#data-models--formats)
6. [Security & Compliance](#security--compliance)
7. [Critical Questions for System Owners](#critical-questions-for-system-owners)
8. [Blind Spots & Risk Areas](#blind-spots--risk-areas)
9. [Integration Roadmap](#integration-roadmap)
10. [References & Resources](#references--resources)

---

## Executive Summary

The North Carolina Residency Determination Service (RDS) is a **centralized, authoritative system** for establishing student residency status for tuition and state financial aid eligibility across all NC public and private higher education institutions. Operated under the NC State Education Assistance Authority (NCSEAA) in partnership with College Foundation, Inc. (CFI), the RDS system is critical for:

- **K-12 Scholarship Programs** (Opportunity Scholarship, ESA+)
- **Higher Education State Aid Programs** (NC Need-Based Grants)
- **Tuition Classification** (In-state vs. Out-of-state rates)

**Key Finding:** RDS appears to operate primarily as a **web-based user-facing application** rather than an API-first platform. Integration capabilities for third-party systems are **not publicly documented**, creating significant architectural uncertainty for K-12 system integration.

**Strategic Importance:** Residency verification is a **prerequisite eligibility requirement** for K-12 scholarship awards. Without confirmed RDS integration, the K-12 system must implement alternative residency verification workflows.

---

## Business Overview

### 1.1 Organizational Structure

**Primary Operator:** North Carolina State Education Assistance Authority (NCSEAA)

**Partner Organizations:**
- **College Foundation, Inc. (CFI)** - Nonprofit established 1955, administers:
  - Education loan programs
  - Grant and scholarship programs funded by NC state
  - NC 529 college savings program (tax-advantaged)
  - College Foundation of North Carolina (CFNC.org) platform

**Stakeholder Ecosystem:**
- University of North Carolina System (UNC)
- North Carolina Community College System (NCCCS)
- North Carolina Independent Colleges and Universities (NCICU)
- K-12 Private Schools (for Opportunity Scholarship/ESA+ programs)

### 1.2 Business Purpose & Value Proposition

**Problem Solved:** Prior to RDS, each NC institution independently determined residency status, leading to:
- Inconsistent residency classifications across institutions
- Duplicative verification processes
- Student confusion and administrative burden
- Lack of centralized audit trail

**RDS Solution:** Single residency determination that:
- Applies uniformly across ALL NC institutions
- Reduces administrative overhead for institutions
- Provides consistent student experience
- Creates centralized compliance and audit capability

### 1.3 Business Process Workflow

#### Phase 1: Initial Consideration (First-Time Determination)
**Trigger:** Student applying to NC college or seeking state financial aid  
**Requirements:** 
- Domicile in North Carolina for 12+ consecutive months prior to claiming residency
- Submit documentation package (driver's license, utility bills, tax records, etc.)
- Complete RDS online interview/questionnaire

**Outcomes:**
- **Resident** - Eligible for in-state tuition and state aid
- **Non-Resident** - Out-of-state rates, ineligible for state aid

#### Phase 2: Reconsideration Process
**Trigger:** Student circumstances change (e.g., parent relocates to NC, marriage, military service)  
**Process:** Submit updated documentation and request reconsideration  
**Timeline:** Not publicly documented (critical gap)

#### Phase 3: Appeal Process
**Trigger:** Student disagrees with initial determination AND no circumstances have changed  
**Authority:** State Education Assistance Authority reviews appeal  
**Outcome:** Final determination binding across all institutions

#### Phase 4: Maintenance & Reuse
**Key Feature:** Once residency is established in RDS, classification is **reusable across all NC institutions and aid programs** without re-verification (unless circumstances change)

### 1.4 Statutory & Regulatory Framework

**Governing Statute:** G.S. 115C-562.3 (K-12 Scholarship Domicile Verification)

**Key Provisions:**
1. **12-Month Domicile Requirement** - Legal residence in NC for at least 12 consecutive months
2. **Multi-Agency Electronic Verification** - Mandates coordination with:
   - Division of Motor Vehicles (DMV) - Driver's license/state ID validation
   - Department of Public Instruction (DPI) - Public school enrollment records
   - Department of Commerce - Employment records
   - Department of Health and Human Services (DHHS) - Benefits enrollment
   - Department of Revenue - Tax filings
   - State Board of Elections - Voter registration
   - State Chief Information Officer - Facilitates electronic verification infrastructure

3. **Fallback Procedures** - Statute requires manual verification procedures when electronic systems unavailable

**Critical Gap:** While statute mandates inter-agency electronic verification, **public documentation does not reveal implementation details, APIs, or data exchange protocols**.

### 1.5 K-12 Program-Specific Residency Requirements

#### Opportunity Scholarship
- **Income-based program** for private school tuition
- **Residency Required:** Student must reside in NC with parent/guardian by start of school year
- **Acceptable Documents:**
  - NC driver's license or state ID
  - Utility bills (electric, water, gas)
  - Bank statements
  - Government checks or paychecks
  - Property tax records

#### ESA+ (Education Student Accounts)
- **Disability-based program** for students with IEPs requiring special education
- **Same residency requirements** as Opportunity Scholarship
- **Additional Documentation:** Proof of disability and special education eligibility

**Verification Method:** Currently documents submitted via **MyPortal** (NCSEAA's K-12 application platform), not through RDS

**Architectural Anomaly:** K-12 programs use **MyPortal document upload** for residency verification, NOT the centralized RDS system used for higher education. This suggests:
- RDS may be higher-ed focused
- K-12 integration may require net-new development
- Dual-system architecture may exist (MyPortal + RDS)

---

## System Architecture

### 2.1 Level 1: System Context (High-Level)

```
┌─────────────────────────────────────────────────────────────┐
│                    RDS System Context                        │
│                                                              │
│  [Students/Families] ──────► [RDS Portal] ◄────┐           │
│                                   │             │            │
│                                   │             │            │
│                                   ▼             │            │
│                          [RDS Core Engine]      │            │
│                                   │             │            │
│                    ┌──────────────┼───────┐     │            │
│                    ▼              ▼       ▼     │            │
│            [State Agencies]  [NCSEAA]  [CFI]    │            │
│            - DMV             - Grants   - CFNC  │            │
│            - DPI             - Loans            │            │
│            - Revenue                            │            │
│            - DHHS                               │            │
│            - Commerce                           │            │
│            - Elections                          │            │
│                                                              │
│  [Higher Ed Institutions] ◄───── [Results]                  │
│  [K-12 Systems (?)]       ◄───── [Results?]                │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 Level 2-3: Application Architecture (Inferred)

**Technology Stack (Inferred from Public Site):**
- **Frontend:** Web-based application (likely ASP.NET or Java-based given NC state standards)
- **Authentication:** Appears to use user account creation (email/password) - SSO capabilities unknown
- **Data Validation:** Federal and state agency integrations for identity verification
- **Database:** Not disclosed (likely SQL Server or Oracle given state standards)

**Deployment Model:**
- Hosted by NC state infrastructure (not cloud-native based on domain patterns)
- HTTPS encryption for data transmission
- Likely behind NC state firewall/network perimeter

### 2.3 Level 4-6: Data Flow Architecture

#### User Journey (Inferred)
1. **Account Creation** - Student creates account with email, password, personal info
2. **Interview/Questionnaire** - Guided questions about domicile, intent, documentation
3. **Document Upload** - Submit supporting documents (PDFs, images)
4. **Identity Validation** - System validates SSN, tax info, vehicle registration against:
   - IRS records
   - NC DMV database
   - Other state agency databases
5. **Adjudication** - Automated rules engine OR manual review determines residency
6. **Notification** - Student receives determination via email/portal
7. **Institution Access** - Colleges/universities access determination results (method unknown)

**Critical Unknowns:**
- How do institutions query RDS results? API? Manual lookup? Batch file?
- How are results synchronized to institution SIS systems?
- What is the data retention period for RDS cases?
- How are updates/changes propagated to consuming systems?

### 2.4 Level 7-8: Integration Architecture (MAJOR GAP)

**Public Documentation Findings:**
- ❌ **No public API documentation** found on ncresidency.org
- ❌ **No webhooks/callbacks** mentioned in public materials
- ❌ **No developer portal or technical documentation** accessible
- ❌ **No integration examples or SDKs** published
- ✅ **NC State IT integration standards exist** but don't specifically reference RDS

**Possible Integration Models (Speculative):**

#### Model A: API-Based Integration (Preferred)
```
K-12 System ──[HTTPS/REST]──► RDS API
                                │
                                ├─► POST /residency-cases
                                ├─► GET /residency-cases/{caseId}
                                ├─► GET /residency-cases/by-student/{ssn}
                                └─► PUT /residency-cases/{caseId}/reconsider
```

#### Model B: Portal-Only (Current K-12 Model)
```
Parent ──► MyPortal ──► Upload Documents ──► NCSEAA Staff Review
                                               │
                                               └─► Manual Determination
```

#### Model C: Batch File Exchange
```
RDS System ──► Nightly Batch Job ──► SFTP Server ──► K-12 System Import
```

#### Model D: Shared Database (Anti-Pattern)
```
RDS Database ◄──[Direct SQL Query]──► K-12 System
```

### 2.5 Level 9-10: Data Architecture & Standards

**NC State IT Standards (Applicable to RDS):**
- **Security:** Based on NIST 800-53 framework
- **Data Classification:** PII/PHI sensitivity levels
- **Encryption:** At-rest and in-transit requirements
- **Access Control:** Role-based access control (RBAC)
- **Audit Logging:** Full audit trail for compliance

**Data Integration Standard (NC State CIO):**
- Prefer standardized APIs over custom integrations
- RESTful services with JSON payloads (modern standard)
- SOAP/XML for legacy systems
- Secure transport (TLS 1.2+)
- OAuth 2.0 or SAML for authentication

### 2.6 Level 11: Operational & Non-Functional Architecture

#### Performance Characteristics (Unknown)
- Request volume capacity?
- Response time SLAs?
- Availability targets (99.9%? 99.99%)?
- Peak load periods (admissions cycles)?

#### Disaster Recovery
- RPO/RTO targets?
- Backup procedures?
- Failover capabilities?

#### Monitoring & Observability
- Health check endpoints?
- Status page for system availability?
- Integration error notification mechanism?

---

## Integration Specifications

### 3.1 Critical Integration Questions (UNANSWERED)

#### API Availability
1. **Does RDS provide a RESTful API for third-party systems?**
   - If yes: What authentication method? (OAuth 2.0, API keys, mTLS?)
   - If yes: Is there a developer sandbox/test environment?
   - If yes: What is the onboarding process for new consumers?
   - If no: What alternative integration methods are supported?

2. **What data can be exchanged via API?**
   - Create residency case?
   - Query residency status?
   - Update case with new documentation?
   - Retrieve case history?
   - Subscribe to status changes?

#### Real-Time vs. Batch
3. **Are real-time API calls supported or only batch processing?**
   - Synchronous vs. asynchronous workflows?
   - Rate limiting policies?
   - Bulk import capabilities?

#### Callbacks & Notifications
4. **Does RDS support webhooks for status change notifications?**
   - When residency determination is complete?
   - When reconsideration is requested?
   - When appeal decision is rendered?

5. **If no webhooks, what polling frequency is acceptable?**
   - Can we query status every 5 minutes? Hourly? Daily?

#### Data Governance
6. **What is the authoritative source of truth for student residency?**
   - Is RDS read-only for consumers?
   - Can K-12 system write data to RDS or only read?
   - How are conflicts resolved between RDS and K-12 data?

7. **Data residency and retention policies?**
   - How long are residency determinations valid?
   - When/how is data purged?
   - Can historical records be accessed?

### 3.2 Proposed K-12 Integration Architecture

**Assumption:** RDS provides API access (to be confirmed)

```
┌────────────────────────────────────────────────────────────────┐
│                    K-12 SEAA System                            │
│                                                                 │
│  ┌──────────────────┐         ┌────────────────────┐          │
│  │  Application     │         │   RDS Adapter      │          │
│  │  Service         │────────►│   (Integration)    │─────┐    │
│  │                  │         │                    │     │    │
│  │  - Eligibility   │         │  - Create Case     │     │    │
│  │  - Award Calc    │         │  - Query Status    │     │    │
│  │  - Certification │         │  - Handle Errors   │     │    │
│  └──────────────────┘         │  - Retry Logic     │     │    │
│           │                    │  - Cache Results   │     │    │
│           │                    └────────────────────┘     │    │
│           │                             ▲                 │    │
│           ▼                             │                 │    │
│  ┌──────────────────┐                  │                 │    │
│  │  Residency       │                  │                 │    │
│  │  Aggregate       │                  │                 │    │
│  │                  │                  │                 │    │
│  │  - RDS Case ID   │                  │                 │    │
│  │  - Status        │                  │                 │    │
│  │  - Determination │                  │                 │    │
│  │  - Valid Until   │                  │                 │    │
│  └──────────────────┘                  │                 │    │
│           │                             │                 │    │
│           ▼                             │                 │    │
│  ┌──────────────────────────────────────┴─────────────┐  │    │
│  │            Event Bus                               │  │    │
│  │  - ResidencyDetermined                             │  │    │
│  │  - ResidencyExpired                                │  │    │
│  │  - ReconsiderationRequired                         │  │    │
│  └────────────────────────────────────────────────────┘  │    │
│                                                           │    │
└───────────────────────────────────────────────────────────┼────┘
                                                            │
                          HTTPS/REST                        │
                                                            ▼
                              ┌─────────────────────────────────┐
                              │      NC RDS System              │
                              │                                 │
                              │  - Residency API (?)            │
                              │  - Authentication               │
                              │  - Rate Limiting                │
                              │  - Audit Logging                │
                              │                                 │
                              └─────────────────────────────────┘
```

### 3.3 Integration Patterns

#### Pattern 1: Proactive Case Creation (Preferred)
```
1. Parent submits K-12 application in MyPortal
2. K-12 system checks if RDS case exists for student
3. If not exists → Create RDS case via API
4. If exists → Retrieve current status
5. If status = Resident → Proceed with eligibility
6. If status = Pending/Non-Resident → Hold application, notify parent
```

#### Pattern 2: Reactive Verification (Fallback)
```
1. Parent submits residency documents in MyPortal
2. K-12 staff manually verifies documents
3. Staff creates/updates RDS case manually (if RDS portal access available)
4. Staff updates K-12 system with residency determination
```

#### Pattern 3: Periodic Synchronization (Batch)
```
1. RDS generates nightly batch file of all K-12 student determinations
2. K-12 system imports batch file via SFTP
3. System updates local residency records
4. Triggers workflow for any status changes
```

### 3.4 Error Handling & Resilience

**Critical Scenarios:**
- RDS API unavailable (503 errors)
- Network timeout
- Authentication failure
- Rate limit exceeded
- Malformed response data
- Student not found in RDS
- Conflicting determinations

**Resilience Strategies:**
1. **Circuit Breaker Pattern** - Stop calling RDS after N failures, retry with exponential backoff
2. **Caching** - Store recent RDS responses locally (with TTL), serve from cache if RDS down
3. **Graceful Degradation** - Allow manual residency verification as fallback
4. **Dead Letter Queue** - Queue failed RDS calls for later retry/manual review
5. **Monitoring & Alerts** - Real-time alerts when RDS integration fails

---

## Data Models & Formats

### 4.1 Residency Case Entity (Inferred Model)

**Note:** This is a **hypothetical data model** based on business requirements. Actual RDS data model is undocumented.

```json
{
  "rdsCaseId": "RDS-2025-123456",
  "studentInfo": {
    "ssn": "XXX-XX-XXXX",
    "firstName": "Jane",
    "middleName": "Marie",
    "lastName": "Doe",
    "dateOfBirth": "2010-05-15",
    "email": "jane.doe@example.com",
    "phone": "+1-919-555-1234"
  },
  "domicileInfo": {
    "currentAddress": {
      "street1": "123 Main St",
      "street2": "Apt 4B",
      "city": "Raleigh",
      "state": "NC",
      "zipCode": "27601",
      "county": "Wake"
    },
    "domicileEstablishedDate": "2023-08-01",
    "intendedDomicile": true,
    "priorResidencyState": "VA"
  },
  "verificationDocuments": [
    {
      "documentId": "DOC-789012",
      "documentType": "NC_DRIVERS_LICENSE",
      "issueDate": "2024-01-15",
      "expirationDate": "2029-01-15",
      "documentNumber": "12345678",
      "uploadedDate": "2025-02-01T10:30:00Z",
      "verificationStatus": "VERIFIED"
    },
    {
      "documentId": "DOC-789013",
      "documentType": "UTILITY_BILL",
      "serviceType": "ELECTRIC",
      "accountHolder": "Jane Doe",
      "serviceAddress": "123 Main St, Raleigh, NC 27601",
      "billDate": "2025-01-15",
      "uploadedDate": "2025-02-01T10:32:00Z",
      "verificationStatus": "VERIFIED"
    }
  ],
  "determination": {
    "status": "RESIDENT",
    "determinationDate": "2025-02-05T14:22:00Z",
    "determinedBy": "SYSTEM_AUTO",
    "effectiveDate": "2025-08-01",
    "expirationDate": "2026-07-31",
    "reason": "12-month domicile requirement met",
    "confidenceScore": 0.95
  },
  "auditTrail": [
    {
      "eventType": "CASE_CREATED",
      "timestamp": "2025-02-01T10:28:00Z",
      "userId": "student-123456",
      "details": "Initial case submission"
    },
    {
      "eventType": "DOCUMENT_UPLOADED",
      "timestamp": "2025-02-01T10:30:00Z",
      "userId": "student-123456",
      "details": "NC Driver's License uploaded"
    },
    {
      "eventType": "AUTO_VERIFICATION_COMPLETED",
      "timestamp": "2025-02-05T14:20:00Z",
      "userId": "SYSTEM",
      "details": "DMV verification successful"
    },
    {
      "eventType": "DETERMINATION_ISSUED",
      "timestamp": "2025-02-05T14:22:00Z",
      "userId": "SYSTEM",
      "details": "Resident status approved"
    }
  ],
  "programEligibility": {
    "higherEducation": true,
    "k12OpportunityScholarship": true,
    "k12ESAPlus": true,
    "needBasedGrants": true
  },
  "metadata": {
    "createdDate": "2025-02-01T10:28:00Z",
    "lastModifiedDate": "2025-02-05T14:22:00Z",
    "version": 3
  }
}
```

### 4.2 API Endpoints (Hypothetical)

**Note:** These are **proposed endpoints** based on industry best practices. Actual RDS API is undocumented.

#### Create Residency Case
```http
POST /api/v1/residency-cases
Content-Type: application/json
Authorization: Bearer {access_token}

{
  "studentSSN": "XXX-XX-XXXX",
  "firstName": "Jane",
  "lastName": "Doe",
  "dateOfBirth": "2010-05-15",
  "currentAddress": { ... },
  "programType": "K12_OPPORTUNITY_SCHOLARSHIP"
}

Response 201 Created:
{
  "caseId": "RDS-2025-123456",
  "status": "PENDING_DOCUMENTS",
  "nextSteps": [
    "Upload NC driver's license or state ID",
    "Upload utility bill from last 30 days"
  ]
}
```

#### Query Residency Status
```http
GET /api/v1/residency-cases/{caseId}
Authorization: Bearer {access_token}

Response 200 OK:
{
  "caseId": "RDS-2025-123456",
  "determination": {
    "status": "RESIDENT",
    "effectiveDate": "2025-08-01",
    "expirationDate": "2026-07-31"
  }
}
```

#### Search by Student SSN
```http
GET /api/v1/residency-cases/search?ssn={ssn}&program=K12_OS
Authorization: Bearer {access_token}

Response 200 OK:
{
  "cases": [
    {
      "caseId": "RDS-2025-123456",
      "status": "RESIDENT",
      "programType": "K12_OPPORTUNITY_SCHOLARSHIP"
    }
  ]
}
```

#### Upload Document
```http
POST /api/v1/residency-cases/{caseId}/documents
Content-Type: multipart/form-data
Authorization: Bearer {access_token}

documentType: NC_DRIVERS_LICENSE
file: [binary data]

Response 201 Created:
{
  "documentId": "DOC-789012",
  "status": "PENDING_VERIFICATION"
}
```

#### Webhook Event (if supported)
```http
POST {client_webhook_url}
Content-Type: application/json
X-RDS-Signature: {hmac_signature}

{
  "eventType": "residency.determination.completed",
  "caseId": "RDS-2025-123456",
  "timestamp": "2025-02-05T14:22:00Z",
  "determination": {
    "status": "RESIDENT",
    "effectiveDate": "2025-08-01"
  }
}
```

### 4.3 Document Types (Based on Public Requirements)

**Required Documents:**
- `NC_DRIVERS_LICENSE` - NC driver's license
- `NC_STATE_ID` - NC identification card
- `UTILITY_BILL` - Electric, water, gas bill
- `BANK_STATEMENT` - Bank or credit card statement
- `GOVERNMENT_CHECK` - Social Security, welfare, unemployment
- `PAYCHECK_STUB` - Employer paycheck stub
- `PROPERTY_TAX_BILL` - NC property tax statement
- `VOTER_REGISTRATION` - NC voter registration card
- `VEHICLE_REGISTRATION` - NC vehicle registration
- `TAX_RETURN` - NC state tax return

**Special Circumstances:**
- `MILITARY_ORDERS` - Active duty military stationed in NC
- `DIVORCE_DECREE` - Custody documentation for dependent student
- `LEASE_AGREEMENT` - Rental agreement in NC
- `MORTGAGE_STATEMENT` - Home ownership in NC

### 4.4 Status Enumeration

**Residency Case Statuses:**
- `PENDING_SUBMISSION` - Case created, awaiting documents
- `PENDING_DOCUMENTS` - Incomplete documentation
- `PENDING_VERIFICATION` - Documents under review
- `PENDING_MANUAL_REVIEW` - Escalated to staff adjudication
- `RESIDENT` - Approved as NC resident
- `NON_RESIDENT` - Denied, not meeting 12-month requirement
- `RECONSIDERATION_REQUESTED` - Student requested reconsideration
- `APPEAL_PENDING` - Formal appeal under review
- `APPEAL_APPROVED` - Appeal overturned original determination
- `APPEAL_DENIED` - Appeal upheld original determination
- `EXPIRED` - Determination no longer valid (past expiration date)
- `CANCELLED` - Case withdrawn by student

---

## Security & Compliance

### 5.1 NC State Security Standards

**Applicable Framework:** NIST 800-53 (Federal Information Security Management Act)

**Key Controls:**
- **AC-2:** Account Management (user provisioning, deprovisioning)
- **AC-3:** Access Enforcement (role-based access control)
- **AU-2:** Audit Events (comprehensive logging)
- **IA-2:** Identification and Authentication (multi-factor auth)
- **SC-8:** Transmission Confidentiality (TLS 1.2+)
- **SC-28:** Protection of Information at Rest (AES-256 encryption)
- **SI-4:** Information System Monitoring (intrusion detection)

### 5.2 Data Classification

**PII Sensitivity Level:** HIGH (SSN, DOB, address, financial documents)

**Handling Requirements:**
- Encryption at rest (database, file storage)
- Encryption in transit (HTTPS with TLS 1.2+)
- Access logging and audit trail
- Data minimization (only collect necessary data)
- Right to erasure (GDPR-like compliance for data deletion)

### 5.3 Authentication & Authorization

**Expected Methods:**
- **OAuth 2.0** (industry standard for API authentication)
- **API Keys** (simpler but less secure)
- **SAML 2.0** (enterprise SSO)
- **Mutual TLS (mTLS)** (certificate-based authentication)

**Authorization Scopes (Proposed):**
- `residency:cases:read` - Query residency cases
- `residency:cases:write` - Create/update cases
- `residency:documents:upload` - Upload verification documents
- `residency:admin` - Administrative functions

### 5.4 Compliance Requirements

**FERPA (Family Educational Rights and Privacy Act):**
- Student education records must be protected
- Parental consent required for disclosure (K-12)
- Right to inspect and amend records

**NC Public Records Law:**
- Residency determinations may be subject to public records requests
- Balance transparency with privacy protection

**State Procurement Law:**
- Integration may require formal procurement process
- MOU (Memorandum of Understanding) between NCSEAA and consuming agency

### 5.5 Inter-Agency Data Sharing

**Required MOUs (Based on G.S. 115C-562.3):**
1. **NC Department of Transportation (DMV)** - Driver's license verification
2. **NC Department of Public Instruction (DPI)** - School enrollment records
3. **NC Department of Revenue** - Tax filing verification
4. **NC Department of Health and Human Services (DHHS)** - Benefits enrollment
5. **NC Department of Commerce** - Employment verification
6. **NC State Board of Elections** - Voter registration
7. **State Chief Information Officer** - Technical infrastructure coordination

**Data Sharing Protocols:**
- **Privacy:** Minimum necessary data disclosure
- **Security:** Secure transport mechanisms (VPN, SFTP, HTTPS)
- **Auditability:** Log all inter-agency data requests
- **Response Time:** SLAs for verification responses (currently undocumented)

---

## Critical Questions for System Owners

### 6.1 Strategic & Governance Questions

1. **What is the strategic vision for RDS integration with K-12 programs?**
   - Is K-12 integration planned on the RDS roadmap?
   - What is the priority level for K-12 vs. higher-ed integrations?
   - What is the expected timeline for K-12 integration capability?

2. **Who owns the RDS product and technical architecture?**
   - NCSEAA staff or CFI staff?
   - Internal development team or third-party vendor?
   - How are enhancement requests prioritized?

3. **What is the governance process for new integrations?**
   - Formal RFP process?
   - MOU/data sharing agreement required?
   - Security review and penetration testing required?
   - What is typical onboarding timeline (weeks? months?)?

### 6.2 Technical Architecture Questions

4. **Does RDS currently expose a RESTful API or web services?**
   - If yes: What authentication mechanism? (OAuth, API keys, SAML?)
   - If yes: Is there OpenAPI/Swagger documentation available?
   - If yes: Is there a sandbox/test environment for integration testing?
   - If no: What is the roadmap for API development?

5. **What integration patterns are currently supported?**
   - Real-time API calls (synchronous)?
   - Asynchronous job queue?
   - Batch file exchange (SFTP, AWS S3)?
   - Direct database access (not recommended but sometimes reality)?
   - Manual portal data entry only?

6. **What is the underlying technology stack?**
   - Programming language (.NET, Java, Python)?
   - Database (SQL Server, Oracle, PostgreSQL)?
   - Hosting environment (on-prem, Azure, AWS)?
   - Message queue/event bus (if any)?

7. **How do higher-ed institutions currently consume RDS data?**
   - API integration?
   - Manual portal lookup by financial aid staff?
   - Nightly batch file delivered via SFTP?
   - Single sign-on (SSO) for seamless portal access?

### 6.3 Data & Workflow Questions

8. **What is the complete data model for a residency case?**
   - Can we receive full JSON/XML schema documentation?
   - What fields are required vs. optional?
   - What are the valid values for enumerated fields (status codes, document types)?

9. **What is the residency determination workflow?**
   - How long does typical adjudication take (minutes? hours? days?)?
   - What percentage are auto-approved vs. manual review?
   - What triggers manual review vs. automated approval?
   - Can we programmatically track case progress?

10. **How are residency determinations maintained over time?**
    - How long is a determination valid (1 year? 4 years? indefinitely)?
    - When/how are determinations expired or invalidated?
    - How are reconsiderations and appeals tracked?
    - Can a student have multiple active cases?

11. **How is data synchronized with consuming systems?**
    - Push model (RDS pushes updates to consumers)?
    - Pull model (consumers poll RDS for changes)?
    - Event-driven (webhooks on status changes)?
    - Batch synchronization (daily/weekly exports)?

### 6.4 Security & Compliance Questions

12. **What authentication and authorization mechanisms are required?**
    - OAuth 2.0 client credentials flow?
    - API key management and rotation?
    - IP whitelisting?
    - Mutual TLS (certificate-based auth)?

13. **What are the rate limits and throttling policies?**
    - Requests per minute/hour/day?
    - Burst capacity?
    - Cost per API call (if any)?

14. **What is the data retention and privacy policy?**
    - How long is student data retained in RDS?
    - How can students request data deletion (GDPR-like)?
    - What data is logged in audit trails?
    - Who has access to audit logs?

15. **What are the disaster recovery and business continuity plans?**
    - RTO (Recovery Time Objective) and RPO (Recovery Point Objective)?
    - Backup frequency?
    - Failover capabilities?
    - What happens to K-12 workflows if RDS is down for 24+ hours?

### 6.5 Integration Support Questions

16. **What technical support is available for integration partners?**
    - Dedicated integration support team?
    - Response time SLAs for support tickets?
    - Email, phone, or ticketing system?
    - Office hours or 24/7 support?

17. **Is there a developer community or knowledge base?**
    - Developer portal with documentation?
    - Code samples or SDKs (C#, Java, Python, Node.js)?
    - Integration troubleshooting guides?
    - Postman collections or API testing tools?

18. **What is the change management process for API updates?**
    - How far in advance are breaking changes announced?
    - Is API versioning used (/v1, /v2)?
    - How long are deprecated endpoints supported?

### 6.6 Performance & Scalability Questions

19. **What are the system performance characteristics?**
    - Average API response time (ms)?
    - P95/P99 latency?
    - Peak traffic capacity (requests per second)?
    - Batch upload limits (how many cases can be created in one call)?

20. **What is the peak load profile?**
    - College admissions cycles (when is RDS busiest)?
    - K-12 application periods (Feb-Apr for Opportunity Scholarship)?
    - How do you ensure K-12 integrations don't impact higher-ed performance?

### 6.7 Cost & Licensing Questions

21. **Is there a cost associated with RDS API access?**
    - Per-transaction fee?
    - Annual license fee?
    - Volume-based pricing?
    - Free for NC state agencies?

22. **Are there any licensing or IP constraints?**
    - Proprietary software limitations?
    - Open-source components we should be aware of?

---

## Blind Spots & Risk Areas

### 7.1 Critical Information Gaps

**🔴 HIGH RISK - Unknown Integration Capabilities**
- **No public API documentation** - Entire integration approach is uncertain
- **No technical contact information** - Don't know who to reach for integration inquiries
- **No onboarding process** - Unknown how to become an RDS API consumer
- **No SLA commitments** - Can't architect for reliability without knowing RDS uptime guarantees

**🟡 MEDIUM RISK - Architectural Assumptions**
- **Assuming RDS has programmatic access** - May only support manual portal entry
- **Assuming real-time integration** - May only support batch/nightly updates
- **Assuming K-12 scope inclusion** - RDS may be exclusively for higher-ed
- **Assuming modern tech stack** - May be legacy system with limited extensibility

**🟢 LOW RISK - Operational Details**
- **Exact adjudication timeline** - Can plan for manual fallback if slow
- **Cost structure** - Can budget for integration fees if required
- **Support model** - Can staff appropriately based on support availability

### 7.2 Technical Debt Risks

**Scenario 1: No API Available**
- **Impact:** K-12 system cannot integrate programmatically
- **Mitigation:** 
  - Build manual residency verification workflow in MyPortal (current approach)
  - Advocate for RDS API development on NCSEAA roadmap
  - Explore alternative verification methods (DMV API, DPI API directly)

**Scenario 2: Batch-Only Integration**
- **Impact:** Real-time eligibility checks impossible, delayed user experience
- **Mitigation:**
  - Design async workflow (notify parent when determination complete)
  - Cache determinations locally for faster repeat lookups
  - Implement optimistic eligibility (assume resident, verify later)

**Scenario 3: Legacy SOAP/XML API**
- **Impact:** Higher development complexity, slower performance
- **Mitigation:**
  - Build adapter layer to translate SOAP ↔ REST for internal services
  - Consider API gateway pattern (Azure APIM) to modernize interface

**Scenario 4: Competing Priorities (Higher-Ed First)**
- **Impact:** K-12 integration deprioritized, delayed launch
- **Mitigation:**
  - Establish executive sponsorship (NCSEAA leadership buy-in)
  - Demonstrate business case (volume of K-12 verifications)
  - Offer to co-fund development if needed

### 7.3 Data Quality & Consistency Risks

**Issue: Dual Systems (MyPortal + RDS)**
- MyPortal currently accepts residency documents for K-12
- RDS is separate system for higher-ed
- **Risk:** Conflicting determinations, data duplication, user confusion

**Issue: Stale Data**
- Student moves out of NC mid-year but RDS determination still valid
- **Risk:** Awarding scholarship to ineligible student, audit findings

**Issue: Missing Data**
- Student never completed RDS determination (only for K-12, not college-bound)
- **Risk:** Blocked application flow if RDS lookup is required

### 7.4 Compliance & Audit Risks

**Issue: Audit Trail Gaps**
- If RDS integration is async or batch, timing gaps may exist
- **Risk:** Auditor questions why student was awarded before residency verified

**Issue: Data Sharing Agreements**
- K-12 system accessing RDS data may require new MOU
- **Risk:** Legal/procurement delays blocking integration

**Issue: FERPA Compliance**
- Sharing student data between NCSEAA systems may require consent
- **Risk:** Privacy violation if not properly consented

### 7.5 Operational Risks

**Issue: Single Point of Failure**
- K-12 eligibility dependent on RDS availability
- **Risk:** Outage blocks all new applications

**Mitigation Strategies:**
1. **Circuit Breaker + Fallback** - Switch to manual verification if RDS down
2. **Caching** - Store recent determinations locally (24-48 hour TTL)
3. **Read Replicas** - If RDS provides read-only database access
4. **Eventual Consistency** - Allow provisional awards, verify residency within 7 days

---

## Integration Roadmap

### 8.1 Phase 0: Discovery & Planning (Weeks 1-4)

**Activities:**
- [x] Conduct web research on RDS (this document)
- [ ] Schedule meeting with RDS system owners (NCSEAA/CFI)
- [ ] Request technical documentation (API specs, data models)
- [ ] Review existing MOUs/data sharing agreements
- [ ] Identify legal/compliance requirements for K-12 integration
- [ ] Define success criteria for integration

**Deliverables:**
- Technical integration specification document
- MOU/legal agreement (if required)
- Integration architecture diagram (approved)

### 8.2 Phase 1: Proof of Concept (Weeks 5-8)

**Activities:**
- [ ] Set up RDS sandbox/test environment access
- [ ] Implement basic API authentication
- [ ] Create sample residency case via API
- [ ] Query residency status via API
- [ ] Test error handling and edge cases
- [ ] Validate data model mapping

**Success Criteria:**
- Successfully create and retrieve residency case
- <500ms API response time for queries
- 100% authentication success rate
- Zero PII data leakage

### 8.3 Phase 2: Adapter Development (Weeks 9-16)

**Activities:**
- [ ] Build RDS Adapter microservice
- [ ] Implement retry logic and circuit breaker
- [ ] Add caching layer (Redis/Azure Cache)
- [ ] Create residency aggregate in K-12 domain model
- [ ] Implement event publishing (ResidencyDetermined)
- [ ] Build admin UI for manual residency override
- [ ] Write comprehensive unit and integration tests

**Deliverables:**
- RDS Adapter service (containerized)
- API documentation (internal)
- Test coverage >80%

### 8.4 Phase 3: Integration Testing (Weeks 17-20)

**Activities:**
- [ ] End-to-end testing in staging environment
- [ ] Load testing (simulate 1000 concurrent requests)
- [ ] Failover testing (RDS outage scenarios)
- [ ] Data reconciliation (K-12 DB vs. RDS)
- [ ] Security penetration testing
- [ ] UAT with NCSEAA staff

**Success Criteria:**
- <1% error rate under peak load
- <5 second total workflow time (create case → determination)
- Zero data integrity issues in reconciliation
- Pass security audit

### 8.5 Phase 4: Pilot Deployment (Weeks 21-24)

**Activities:**
- [ ] Deploy to production (feature flag disabled)
- [ ] Enable for 10% of new applications (canary release)
- [ ] Monitor metrics (latency, error rate, cache hit rate)
- [ ] Collect user feedback
- [ ] Tune performance (cache TTL, retry policies)
- [ ] Document operational runbooks

**Success Criteria:**
- <0.1% error rate in production
- >95% user satisfaction (surveyed)
- Zero critical incidents

### 8.6 Phase 5: Full Rollout (Weeks 25-28)

**Activities:**
- [ ] Enable RDS integration for 100% of applications
- [ ] Deprecate manual residency verification workflow (if applicable)
- [ ] Train support staff on RDS integration troubleshooting
- [ ] Update parent-facing documentation
- [ ] Establish ongoing monitoring and alerting

**Deliverables:**
- Production deployment (100% traffic)
- Operational dashboard (Grafana/Azure Monitor)
- Support documentation and runbooks

---

## References & Resources

### 9.1 Official RDS Resources

- **RDS Homepage:** https://www.ncresidency.org/
- **RDS Process Guide:** https://www.ncresidency.org/residency-process/
- **RDS FAQ:** https://www.ncresidency.org/faqs/
- **RDS Guidebook (PDF):** https://www.ncseaa.edu/wp-content/uploads/sites/1171/2020/11/Other_01292019125006_Doc.-36-RDS-Guidebook-Revised-October-2018.pdf

### 9.2 NCSEAA K-12 Resources

- **K-12 Home:** https://k12.ncseaa.edu/
- **Residency Verification:** https://k12.ncseaa.edu/residency/
- **Opportunity Scholarship:** https://k12.ncseaa.edu/opportunity-scholarship/
- **ESA+ Program:** https://k12.ncseaa.edu/the-education-student-accounts/
- **K-12 Statutes:** https://www.ncseaa.edu/psr/k12-programs/

### 9.3 College Foundation, Inc. (CFI) Resources

- **CFI Homepage:** https://www.cfi.org/
- **CFNC.org:** https://www.cfnc.org/
- **Residency Determination on CFNC:** https://www.cfnc.org/apply-to-college/residency-determination/

### 9.4 NC State IT Standards

- **NC IT Standards:** https://it.nc.gov/resources/state-it-standards
- **Statewide Security Policies:** https://it.nc.gov/programs/cybersecurity-risk-management/esrmo-initiatives/statewide-information-security-policies
- **Data Integration Standard:** https://it.nc.gov/documents/applicationdata-integration-standard/open

### 9.5 Legal & Statutory Resources

- **G.S. 115C-562.3 (K-12 Domicile Verification):** https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html
- **G.S. 143B-1376 (State CIO Security Standards):** https://www.ncleg.gov/EnactedLegislation/Statutes/PDF/BySection/Chapter_143B/GS_143B-1376.pdf

### 9.6 Related Systems

- **NC Department of Public Instruction (DPI):** https://www.dpi.nc.gov/
- **NC DPI Third-Party Data Integration:** https://www.dpi.nc.gov/about-dpi/technology-services/third-party-data-integration
- **NC Department of Transportation (DMV):** https://www.ncdot.gov/dmv/

---

## Appendix A: Glossary

- **CFI** - College Foundation, Inc., nonprofit administrator of NCSEAA programs
- **CFNC** - College Foundation of North Carolina, online platform for college/career planning
- **Domicile** - Legal residence with intent to remain indefinitely (12-month NC requirement)
- **ESA+** - Education Student Accounts program for students with disabilities
- **FERPA** - Family Educational Rights and Privacy Act (student data privacy)
- **K-12 SEAA** - K-12 State Education Assistance Authority programs (Opportunity Scholarship, ESA+)
- **MOU** - Memorandum of Understanding (data sharing agreement)
- **MyPortal** - NCSEAA's K-12 application portal for parents/students
- **NCICU** - North Carolina Independent Colleges and Universities
- **NCCCS** - North Carolina Community College System
- **NCSEAA** - North Carolina State Education Assistance Authority
- **NIST 800-53** - National Institute of Standards and Technology security control framework
- **Opportunity Scholarship** - Income-based private school tuition scholarship
- **RDS** - Residency Determination Service
- **SSN** - Social Security Number
- **UNC** - University of North Carolina System

---

## Document Version History

| Version | Date       | Author           | Changes                                  |
|---------|------------|------------------|------------------------------------------|
| 1.0     | 2025-10-15 | AI Researcher    | Initial comprehensive research document  |

