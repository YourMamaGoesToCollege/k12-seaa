# K-12 SEAA Azure Architecture - Target Backend System

**Document Purpose:** Define the target Azure architecture for the K-12 SEAA backend system including integration with the NC Residency Determination Service (RDS)

**Last Updated:** 2025-10-15  
**Technology Stack:** Microsoft Azure, .NET Core, SQL Server

---

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Azure Services & Components](#azure-services--components)
3. [System Architecture Diagram](#system-architecture-diagram)
4. [RDS Integration Architecture](#rds-integration-architecture)
5. [Sequence Diagrams](#sequence-diagrams)
6. [Data Flow Patterns](#data-flow-patterns)
7. [Security & Compliance](#security--compliance)
8. [Deployment & Operations](#deployment--operations)

---

## Architecture Overview

The K-12 SEAA backend system is designed as a cloud-native, microservices-based architecture hosted on Microsoft Azure. The system supports:

- **Opportunity Scholarship** application and award processing
- **ESA+ (Education Student Accounts)** program management
- **Residency verification** integration with NC RDS
- **Document management** and storage
- **Payment processing** and disbursements
- **Event-driven workflows** for inter-service communication
- **Compliance and audit** capabilities

### Key Architecture Principles

1. **Cloud-Native:** Fully leverages Azure PaaS services
2. **Microservices:** Domain-driven service boundaries
3. **Event-Driven:** Asynchronous communication via Event Grid
4. **API-First:** RESTful APIs with Azure API Management
5. **Secure by Default:** Azure AD, Key Vault, Private Link
6. **Scalable:** Auto-scaling with App Services and Functions
7. **Observable:** Application Insights, Log Analytics

---

## Azure Services & Components

### Compute Services

| Service | Purpose | Usage |
|---------|---------|-------|
| **Azure App Service** | Host .NET Core Web APIs | Application Service, Award Service, Certification Service |
| **Azure Functions** | Serverless event processing | Batch jobs, event handlers, scheduled tasks |
| **Azure Logic Apps** | Workflow orchestration | Complex multi-step business processes, integrations |

### Data Services

| Service | Purpose | Usage |
|---------|---------|-------|
| **Azure SQL Database** | Relational data store | Student data, applications, awards, audit logs |
| **Azure Blob Storage** | Document storage | PDFs, images, exported reports |
| **Azure Cache for Redis** | Distributed caching | RDS response cache, session state |

### Integration & Messaging

| Service | Purpose | Usage |
|---------|---------|-------|
| **Azure API Management (APIM)** | API gateway | Rate limiting, authentication, monitoring |
| **Azure Event Grid** | Event routing | Domain events, integration events |
| **Azure Service Bus** | Message queue | Reliable async messaging, dead letter queue |

### Security & Identity

| Service | Purpose | Usage |
|---------|---------|-------|
| **Azure Active Directory (Entra ID)** | Identity provider | User authentication, RBAC |
| **Azure Key Vault** | Secrets management | Connection strings, API keys, certificates |
| **Azure Private Link** | Network isolation | Secure connectivity to PaaS services |

### Monitoring & Operations

| Service | Purpose | Usage |
|---------|---------|-------|
| **Application Insights** | APM & monitoring | Performance, errors, custom metrics |
| **Log Analytics** | Centralized logging | Aggregated logs, queries, alerts |
| **Azure Monitor** | Alerting & dashboards | Health checks, threshold alerts |

---

## System Architecture Diagram

### High-Level Azure Architecture

```mermaid
graph TB
    subgraph "External Users"
        Parent[Parents/Guardians]
        School[School Admins]
        Staff[NCSEAA Staff]
    end

    subgraph "Azure Front Door / CDN"
        FD[Azure Front Door<br/>Global Load Balancer]
    end

    subgraph "Azure App Services - Web Tier"
        Portal[MyPortal Web App<br/>.NET Core MVC]
        SchoolPortal[School Admin Portal<br/>.NET Core MVC]
        StaffPortal[Staff Portal<br/>.NET Core MVC]
    end

    subgraph "Azure API Management"
        APIM[API Management Gateway<br/>- Rate Limiting<br/>- OAuth 2.0<br/>- Monitoring]
    end

    subgraph "Azure App Services - API Tier"
        AppAPI[Application Service API<br/>.NET Core Web API]
        AwardAPI[Award Service API<br/>.NET Core Web API]
        CertAPI[Certification Service API<br/>.NET Core Web API]
        PaymentAPI[Payment Service API<br/>.NET Core Web API]
        DocAPI[Document Service API<br/>.NET Core Web API]
        ResidencyAPI[Residency Service API<br/>.NET Core Web API]
    end

    subgraph "Azure Functions - Serverless"
        BatchFunc[Batch Processing<br/>Timer Trigger]
        EventFunc[Event Handlers<br/>Event Grid Trigger]
        ValidationFunc[Validation Service<br/>HTTP Trigger]
    end

    subgraph "Azure Logic Apps"
        WorkflowLA[Award Workflow<br/>State Machine]
        IntegrationLA[RDS Integration<br/>Orchestrator]
        NotificationLA[Notification Engine<br/>Multi-channel]
    end

    subgraph "Azure Data Services"
        SQL[(Azure SQL Database<br/>- Students<br/>- Applications<br/>- Awards)]
        Blob[Azure Blob Storage<br/>- Documents<br/>- Reports]
        Redis[Azure Cache<br/>Redis]
    end

    subgraph "Azure Integration"
        EventGrid[Azure Event Grid<br/>Event Router]
        ServiceBus[Azure Service Bus<br/>Message Queue]
    end

    subgraph "Azure Security"
        AAD[Azure AD<br/>Entra ID]
        KeyVault[Key Vault<br/>Secrets]
        PrivateLink[Private Link<br/>Network Security]
    end

    subgraph "Azure Monitoring"
        AppInsights[Application Insights<br/>APM]
        LogAnalytics[Log Analytics<br/>Workspace]
        Monitor[Azure Monitor<br/>Alerts]
    end

    subgraph "External Systems"
        RDS[NC RDS System<br/>Residency Service]
        DMV[NC DMV API<br/>License Validation]
        Payment[Payment Rails<br/>ACH/Disbursement]
    end

    Parent --> FD
    School --> FD
    Staff --> FD
    
    FD --> Portal
    FD --> SchoolPortal
    FD --> StaffPortal
    
    Portal --> APIM
    SchoolPortal --> APIM
    StaffPortal --> APIM
    
    APIM --> AppAPI
    APIM --> AwardAPI
    APIM --> CertAPI
    APIM --> PaymentAPI
    APIM --> DocAPI
    APIM --> ResidencyAPI
    
    AppAPI --> SQL
    AwardAPI --> SQL
    CertAPI --> SQL
    
    AppAPI --> EventGrid
    AwardAPI --> EventGrid
    CertAPI --> EventGrid
    
    EventGrid --> EventFunc
    EventGrid --> ServiceBus
    
    ServiceBus --> WorkflowLA
    ServiceBus --> IntegrationLA
    
    ResidencyAPI --> Redis
    ResidencyAPI --> IntegrationLA
    
    IntegrationLA --> RDS
    IntegrationLA --> DMV
    
    DocAPI --> Blob
    PaymentAPI --> Payment
    
    BatchFunc --> SQL
    ValidationFunc --> SQL
    
    NotificationLA --> Parent
    NotificationLA --> School
    
    APIM -.-> AAD
    AppAPI -.-> KeyVault
    AwardAPI -.-> KeyVault
    
    AppAPI --> AppInsights
    AwardAPI --> AppInsights
    ResidencyAPI --> AppInsights
    
    AppInsights --> LogAnalytics
    LogAnalytics --> Monitor

    style RDS fill:#f9f,stroke:#333,stroke-width:2px
    style APIM fill:#0078d4,stroke:#333,stroke-width:2px
    style EventGrid fill:#ff6b6b,stroke:#333,stroke-width:2px
    style AAD fill:#00a4ef,stroke:#333,stroke-width:2px
```

---

## RDS Integration Architecture

### Detailed RDS Integration Components

```mermaid
graph TB
    subgraph "K-12 SEAA System - Azure"
        subgraph "API Gateway"
            APIM[Azure API Management]
        end
        
        subgraph "Application Services"
            AppService[Application Service API<br/>.NET Core]
            EligibilityService[Eligibility Service<br/>.NET Core]
        end
        
        subgraph "Residency Integration"
            ResidencyAPI[Residency Service API<br/>.NET Core Web API]
            RDSAdapter[RDS Adapter<br/>Integration Layer]
            CircuitBreaker[Circuit Breaker<br/>Polly Library]
            RetryPolicy[Retry Policy<br/>Exponential Backoff]
        end
        
        subgraph "Orchestration"
            ResidencyLA[Residency Workflow<br/>Azure Logic App]
            EventHandler[Event Handler<br/>Azure Function]
        end
        
        subgraph "Data Layer"
            ResidencyDB[(Residency Aggregate<br/>Azure SQL)]
            CacheRedis[Response Cache<br/>Azure Redis Cache]
        end
        
        subgraph "Event Bus"
            EventGrid[Azure Event Grid<br/>Domain Events]
        end
        
        subgraph "Monitoring"
            AppInsights[Application Insights<br/>Telemetry]
        end
    end
    
    subgraph "External - NC RDS System"
        RDSEndpoint[RDS API Endpoint<br/>HTTPS/REST]
        RDSPortal[RDS Portal<br/>Fallback Manual Entry]
    end
    
    subgraph "State Agencies"
        DMV[NC DMV API]
        DPI[NC DPI API]
    end
    
    APIM --> AppService
    AppService --> EligibilityService
    EligibilityService --> ResidencyAPI
    
    ResidencyAPI --> RDSAdapter
    RDSAdapter --> CircuitBreaker
    CircuitBreaker --> RetryPolicy
    RetryPolicy --> ResidencyLA
    
    ResidencyLA -->|API Call| RDSEndpoint
    ResidencyLA -->|Fallback| RDSPortal
    
    RDSEndpoint -.->|Verifies| DMV
    RDSEndpoint -.->|Verifies| DPI
    
    RDSAdapter --> CacheRedis
    ResidencyAPI --> ResidencyDB
    
    ResidencyAPI --> EventGrid
    EventGrid --> EventHandler
    
    ResidencyAPI --> AppInsights
    RDSAdapter --> AppInsights
    
    style RDSEndpoint fill:#f9f,stroke:#333,stroke-width:2px
    style EventGrid fill:#ff6b6b,stroke:#333,stroke-width:2px
    style CircuitBreaker fill:#ffd93d,stroke:#333,stroke-width:2px
    style CacheRedis fill:#dc3545,stroke:#333,stroke-width:2px
```

### RDS Integration Service Components

```mermaid
graph LR
    subgraph "Residency Service API"
        Controller[Residency Controller<br/>REST Endpoints]
        Service[Residency Domain Service]
        Repository[Residency Repository]
    end
    
    subgraph "RDS Adapter Layer"
        Adapter[RDS HTTP Client]
        Auth[OAuth 2.0 Client]
        Serializer[JSON Serializer]
        Mapper[DTO Mapper]
    end
    
    subgraph "Resilience Patterns"
        CB[Circuit Breaker<br/>Polly]
        Retry[Retry Policy<br/>Exponential Backoff]
        Timeout[Timeout Policy<br/>30s Max]
        Cache[Cache Policy<br/>Redis]
    end
    
    subgraph "Azure Services"
        KeyVault[Key Vault<br/>API Keys/Secrets]
        AppInsights[App Insights<br/>Telemetry]
        Redis[Azure Redis<br/>Cache]
    end
    
    Controller --> Service
    Service --> Repository
    Service --> Adapter
    
    Adapter --> Auth
    Adapter --> Serializer
    Adapter --> Mapper
    
    Adapter --> CB
    CB --> Retry
    Retry --> Timeout
    Timeout --> Cache
    
    Auth -.-> KeyVault
    Adapter --> AppInsights
    Cache --> Redis
    
    style CB fill:#ffd93d,stroke:#333,stroke-width:2px
    style Cache fill:#dc3545,stroke:#333,stroke-width:2px
```

---

## Sequence Diagrams

### Use Case 1: New Residency Validation for Household

This sequence diagram shows the complete workflow for validating residency when a parent submits a new K-12 scholarship application.

```mermaid
sequenceDiagram
    participant Parent as Parent/Guardian<br/>(Web Browser)
    participant Portal as MyPortal<br/>(Frontend)
    participant APIM as Azure API<br/>Management
    participant AppAPI as Application<br/>Service API
    participant ResAPI as Residency<br/>Service API
    participant RDSAdapter as RDS Adapter<br/>(Integration)
    participant Cache as Azure Redis<br/>Cache
    participant CircuitBreaker as Circuit Breaker<br/>(Polly)
    participant LogicApp as Azure Logic App<br/>(RDS Workflow)
    participant RDS as NC RDS System<br/>(External API)
    participant EventGrid as Azure Event Grid
    participant DB as Azure SQL<br/>Database
    participant Insights as Application<br/>Insights

    Note over Parent,RDS: New Residency Validation Flow

    Parent->>Portal: Submit K-12 Application<br/>(Household Info)
    Portal->>APIM: POST /api/applications
    APIM->>APIM: Validate OAuth Token
    APIM->>AppAPI: Forward Request
    
    AppAPI->>DB: Save Application<br/>(Status: Pending Residency)
    DB-->>AppAPI: Application Created
    
    AppAPI->>ResAPI: POST /api/residency/validate<br/>{householdId, studentSSN}
    
    ResAPI->>Insights: Log Request
    ResAPI->>Cache: Check Cache<br/>Key: SSN-{studentSSN}
    Cache-->>ResAPI: Cache Miss
    
    ResAPI->>RDSAdapter: ValidateResidency(household)
    RDSAdapter->>CircuitBreaker: Execute with Resilience
    
    alt Circuit Breaker Open
        CircuitBreaker-->>RDSAdapter: Fail Fast
        RDSAdapter-->>ResAPI: Service Unavailable
        ResAPI->>EventGrid: Publish: ResidencyValidationFailed
        ResAPI-->>AppAPI: 503 Service Unavailable
        AppAPI->>DB: Update Application<br/>(Status: Manual Review Required)
        AppAPI-->>Portal: Residency Check Failed<br/>(Manual Review Needed)
        Portal-->>Parent: Application Received<br/>Staff will verify residency
    else Circuit Breaker Closed
        CircuitBreaker->>LogicApp: Invoke RDS Workflow
        
        LogicApp->>LogicApp: Prepare Request<br/>(Map K-12 data to RDS format)
        LogicApp->>RDS: POST /api/v1/residency-cases<br/>{studentInfo, address, program: K12}
        
        alt RDS Case Creation Successful
            RDS->>RDS: Validate with DMV
            RDS->>RDS: Validate with DPI
            RDS->>RDS: Apply 12-month rule
            RDS-->>LogicApp: 201 Created<br/>{caseId, status: PENDING_DETERMINATION}
            
            LogicApp->>RDS: GET /api/v1/residency-cases/{caseId}/status
            
            alt Auto-Approved (Fast Path)
                RDS-->>LogicApp: {status: RESIDENT, effectiveDate, expirationDate}
                LogicApp-->>CircuitBreaker: Success Response
                CircuitBreaker-->>RDSAdapter: RDS Response
                
                RDSAdapter->>Cache: Cache Result<br/>(TTL: 24 hours)
                RDSAdapter-->>ResAPI: Residency Determination
                
                ResAPI->>DB: Save Residency Record<br/>(Status: RESIDENT, RDS Case ID)
                ResAPI->>EventGrid: Publish: ResidencyDetermined<br/>{householdId, status: RESIDENT}
                ResAPI->>Insights: Log Success
                ResAPI-->>AppAPI: 200 OK {status: RESIDENT}
                
                AppAPI->>AppAPI: Continue Eligibility Check
                AppAPI->>DB: Update Application<br/>(Status: Eligibility Review)
                AppAPI-->>Portal: Residency Verified ✓
                Portal-->>Parent: Application Processing<br/>Residency Confirmed
                
            else Manual Review Required
                RDS-->>LogicApp: {status: PENDING_MANUAL_REVIEW}
                LogicApp-->>CircuitBreaker: Async Response
                CircuitBreaker-->>RDSAdapter: Pending Status
                
                RDSAdapter-->>ResAPI: Residency Pending
                ResAPI->>DB: Save Residency Record<br/>(Status: PENDING, RDS Case ID)
                ResAPI->>EventGrid: Publish: ResidencyPending
                ResAPI-->>AppAPI: 202 Accepted {status: PENDING}
                
                AppAPI->>DB: Update Application<br/>(Status: Awaiting Residency)
                AppAPI-->>Portal: Residency Under Review
                Portal-->>Parent: Application Received<br/>Residency verification in progress
                
                Note over Parent,RDS: RDS Staff reviews case (24-48 hours)
                
                RDS->>LogicApp: Webhook: Determination Complete
                LogicApp->>EventGrid: Publish: ResidencyDetermined
                EventGrid->>ResAPI: Trigger: Update Residency Status
                ResAPI->>DB: Update Residency Record<br/>(Status: RESIDENT)
                ResAPI->>Portal: Send Notification to Parent
                Portal->>Parent: Email: Residency Approved
            end
            
        else RDS API Error
            RDS-->>LogicApp: 500 Internal Server Error
            LogicApp->>LogicApp: Retry with Exponential Backoff<br/>(Attempt 1, 2, 3)
            
            alt Retry Succeeds
                RDS-->>LogicApp: 201 Created
                Note over LogicApp,RDS: Continue success flow
            else Retry Fails
                LogicApp-->>CircuitBreaker: All Retries Failed
                CircuitBreaker->>CircuitBreaker: Open Circuit
                CircuitBreaker-->>RDSAdapter: Exception
                
                RDSAdapter->>Insights: Log Error<br/>(RDS API Unavailable)
                RDSAdapter-->>ResAPI: Integration Error
                
                ResAPI->>DB: Save Residency Record<br/>(Status: VERIFICATION_FAILED)
                ResAPI->>EventGrid: Publish: ResidencyValidationFailed
                ResAPI-->>AppAPI: 503 Service Unavailable
                
                AppAPI->>DB: Update Application<br/>(Status: Manual Review Required)
                AppAPI-->>Portal: Residency Check Failed
                Portal-->>Parent: Application Received<br/>Staff will verify residency manually
            end
        end
    end
```

### Use Case 2: Re-Verification of Existing Residency

This sequence diagram shows the workflow for re-verifying residency for a household that already has an RDS determination (e.g., renewal application).

```mermaid
sequenceDiagram
    participant Parent as Parent/Guardian<br/>(Renewal App)
    participant Portal as MyPortal<br/>(Frontend)
    participant APIM as Azure API<br/>Management
    participant AppAPI as Application<br/>Service API
    participant ResAPI as Residency<br/>Service API
    participant Cache as Azure Redis<br/>Cache
    participant RDSAdapter as RDS Adapter
    participant LogicApp as Azure Logic App
    participant RDS as NC RDS System
    participant DB as Azure SQL<br/>Database
    participant EventGrid as Azure Event Grid
    participant Insights as Application<br/>Insights

    Note over Parent,RDS: Re-Verification Flow (Renewal Application)

    Parent->>Portal: Submit Renewal Application<br/>(Same Household)
    Portal->>APIM: POST /api/applications/renew<br/>{householdId, studentId}
    APIM->>AppAPI: Forward Request
    
    AppAPI->>DB: Check Previous Application
    DB-->>AppAPI: Previous App Found<br/>(Had Residency Verified)
    
    AppAPI->>ResAPI: GET /api/residency/status/{householdId}
    
    ResAPI->>Cache: Check Cache<br/>Key: Household-{householdId}
    
    alt Cache Hit - Recent Determination
        Cache-->>ResAPI: {status: RESIDENT, expirationDate: 2026-07-31}
        ResAPI->>ResAPI: Check if Still Valid<br/>(expirationDate > today)
        
        alt Determination Still Valid
            ResAPI->>Insights: Log Cache Hit
            ResAPI-->>AppAPI: 200 OK {status: RESIDENT, source: CACHE}
            
            AppAPI->>AppAPI: Skip Re-Verification<br/>(Trust cached determination)
            AppAPI->>DB: Create Renewal Application<br/>(Status: Eligibility Review)
            AppAPI-->>Portal: Residency Pre-Verified ✓
            Portal-->>Parent: Renewal Processing<br/>No residency re-verification needed
            
        else Determination Expired
            ResAPI->>Cache: Invalidate Cache Entry
            Note over ResAPI,RDS: Proceed to fresh verification
        end
        
    else Cache Miss - Check Database
        Cache-->>ResAPI: Cache Miss
        ResAPI->>DB: Query Residency Record<br/>WHERE HouseholdId = {householdId}
        
        alt Previous Residency Record Found
            DB-->>ResAPI: {rdsCaseId, status: RESIDENT, expirationDate}
            ResAPI->>ResAPI: Check if Still Valid
            
            alt Still Valid - No Re-Verification Needed
                ResAPI->>Cache: Update Cache<br/>(TTL: 24 hours)
                ResAPI->>Insights: Log DB Hit
                ResAPI-->>AppAPI: 200 OK {status: RESIDENT}
                
                AppAPI->>DB: Create Renewal Application<br/>(Reuse Residency)
                AppAPI-->>Portal: Residency Pre-Verified ✓
                Portal-->>Parent: Renewal Processing
                
            else Expired - Re-Verification Required
                ResAPI->>RDSAdapter: RevalidateResidency({rdsCaseId})
                RDSAdapter->>LogicApp: Invoke Re-Verification Workflow
                
                LogicApp->>RDS: GET /api/v1/residency-cases/{rdsCaseId}
                
                alt RDS Case Still Active
                    RDS-->>LogicApp: {status: RESIDENT, expirationDate: 2026-07-31}
                    LogicApp-->>RDSAdapter: Current Determination
                    
                    RDSAdapter->>Cache: Update Cache
                    RDSAdapter-->>ResAPI: Still Valid
                    ResAPI->>DB: Update Residency Record<br/>(LastVerified: now)
                    ResAPI-->>AppAPI: 200 OK {status: RESIDENT}
                    
                    AppAPI->>DB: Create Renewal Application
                    AppAPI-->>Portal: Residency Confirmed ✓
                    Portal-->>Parent: Renewal Processing
                    
                else RDS Case Expired/Changed
                    RDS-->>LogicApp: {status: EXPIRED} or {status: NON_RESIDENT}
                    LogicApp-->>RDSAdapter: Status Changed
                    
                    RDSAdapter->>EventGrid: Publish: ResidencyStatusChanged
                    RDSAdapter-->>ResAPI: Re-Verification Required
                    
                    ResAPI->>DB: Update Residency Record<br/>(Status: REQUIRES_REVERIFICATION)
                    ResAPI-->>AppAPI: 409 Conflict<br/>(Re-verification needed)
                    
                    AppAPI->>DB: Create Renewal Application<br/>(Status: Pending Residency)
                    AppAPI-->>Portal: Residency Expired - New Verification Required
                    Portal-->>Parent: Please Update Residency Information
                    
                    Note over Parent,RDS: Parent must re-submit residency documents
                    Parent->>Portal: Upload New Documents
                    Note over Portal,RDS: Proceed to New Residency Validation Flow
                end
                
            end
            
        else No Previous Residency Record
            DB-->>ResAPI: No Record Found
            ResAPI->>Insights: Log New Household
            ResAPI-->>AppAPI: 404 Not Found
            
            AppAPI->>AppAPI: Treat as New Residency Validation
            Note over AppAPI,RDS: Proceed to New Residency Validation Flow
        end
    end
```

---

## Data Flow Patterns

### Event-Driven Architecture with Azure Event Grid

```mermaid
graph LR
    subgraph "Event Publishers"
        AppAPI[Application Service]
        AwardAPI[Award Service]
        ResAPI[Residency Service]
        CertAPI[Certification Service]
    end
    
    subgraph "Azure Event Grid"
        Topic1[Application Events Topic]
        Topic2[Residency Events Topic]
        Topic3[Award Events Topic]
    end
    
    subgraph "Event Subscribers"
        NotificationFunc[Notification Handler<br/>Azure Function]
        AuditFunc[Audit Logger<br/>Azure Function]
        WorkflowLA[Award Workflow<br/>Logic App]
        DataWarehouse[Data Warehouse Sync<br/>Azure Function]
    end
    
    AppAPI -->|ApplicationSubmitted| Topic1
    AppAPI -->|ApplicationApproved| Topic1
    
    ResAPI -->|ResidencyDetermined| Topic2
    ResAPI -->|ResidencyExpired| Topic2
    
    AwardAPI -->|AwardCalculated| Topic3
    AwardAPI -->|AwardDisbursed| Topic3
    
    Topic1 --> NotificationFunc
    Topic1 --> AuditFunc
    Topic1 --> WorkflowLA
    
    Topic2 --> WorkflowLA
    Topic2 --> NotificationFunc
    
    Topic3 --> NotificationFunc
    Topic3 --> DataWarehouse
    
    style Topic1 fill:#ff6b6b,stroke:#333,stroke-width:2px
    style Topic2 fill:#ff6b6b,stroke:#333,stroke-width:2px
    style Topic3 fill:#ff6b6b,stroke:#333,stroke-width:2px
```

### Caching Strategy

```mermaid
graph TB
    subgraph "Request Flow"
        Client[API Client]
        APIM[API Management]
        ResAPI[Residency API]
    end
    
    subgraph "Caching Layers"
        L1[L1: APIM Response Cache<br/>TTL: 5 min]
        L2[L2: Application Cache<br/>In-Memory, TTL: 15 min]
        L3[L3: Azure Redis Cache<br/>Distributed, TTL: 24 hours]
    end
    
    subgraph "Data Sources"
        DB[(Azure SQL<br/>Database)]
        RDS[RDS API<br/>External]
    end
    
    Client -->|Request| APIM
    APIM -->|Check L1| L1
    L1 -->|Miss| ResAPI
    
    ResAPI -->|Check L2| L2
    L2 -->|Miss| L3
    L3 -->|Miss| DB
    
    DB -->|Not Found| RDS
    
    RDS -->|Response| L3
    L3 -->|Store| L2
    L2 -->|Store| L1
    L1 -->|Response| Client
    
    style L1 fill:#ffd93d,stroke:#333,stroke-width:2px
    style L2 fill:#ffd93d,stroke:#333,stroke-width:2px
    style L3 fill:#dc3545,stroke:#333,stroke-width:2px
```

---

## Security & Compliance

### Azure Security Architecture

```mermaid
graph TB
    subgraph "User Access"
        User[End Users]
        Admin[Administrators]
    end
    
    subgraph "Identity & Access"
        AAD[Azure Active Directory<br/>Entra ID]
        B2C[Azure AD B2C<br/>Parent/Guardian Auth]
        RBAC[Role-Based Access Control]
        PIM[Privileged Identity Mgmt]
    end
    
    subgraph "API Security"
        APIM[API Management]
        OAuth[OAuth 2.0]
        JWT[JWT Validation]
    end
    
    subgraph "Network Security"
        WAF[Web Application Firewall]
        NSG[Network Security Groups]
        PrivateLink[Azure Private Link]
        VNet[Virtual Network]
    end
    
    subgraph "Data Protection"
        KeyVault[Azure Key Vault]
        TDE[Transparent Data Encryption]
        StorageEncryption[Storage Encryption at Rest]
    end
    
    subgraph "Compliance & Monitoring"
        Defender[Microsoft Defender<br/>for Cloud]
        Sentinel[Azure Sentinel<br/>SIEM]
        PolicyEngine[Azure Policy]
    end
    
    User --> WAF
    WAF --> APIM
    APIM --> OAuth
    OAuth --> AAD
    
    Admin --> PIM
    PIM --> AAD
    AAD --> RBAC
    
    APIM --> JWT
    JWT --> VNet
    VNet --> NSG
    NSG --> PrivateLink
    
    PrivateLink --> KeyVault
    KeyVault --> TDE
    KeyVault --> StorageEncryption
    
    Defender --> PolicyEngine
    Sentinel --> Defender
    
    style AAD fill:#00a4ef,stroke:#333,stroke-width:2px
    style KeyVault fill:#ffb900,stroke:#333,stroke-width:2px
    style WAF fill:#e81123,stroke:#333,stroke-width:2px
```

### Data Encryption Flow

```mermaid
graph LR
    subgraph "Data at Rest"
        SQL[(Azure SQL DB<br/>TDE Enabled)]
        Blob[Blob Storage<br/>AES-256]
        Redis[Redis Cache<br/>Encrypted]
    end
    
    subgraph "Data in Transit"
        HTTPS[TLS 1.2+<br/>HTTPS Only]
        PrivateLink[Private Link<br/>No Internet]
    end
    
    subgraph "Key Management"
        KeyVault[Azure Key Vault]
        CMK[Customer Managed Keys]
        HSM[Hardware Security Module]
    end
    
    KeyVault --> CMK
    CMK --> HSM
    
    HSM -.->|Encryption Key| SQL
    HSM -.->|Encryption Key| Blob
    HSM -.->|Encryption Key| Redis
    
    HTTPS --> SQL
    HTTPS --> Blob
    PrivateLink --> SQL
    PrivateLink --> Redis
    
    style KeyVault fill:#ffb900,stroke:#333,stroke-width:2px
    style HSM fill:#ffb900,stroke:#333,stroke-width:2px
```

---

## Deployment & Operations

### CI/CD Pipeline Architecture

```mermaid
graph LR
    subgraph "Source Control"
        GitHub[GitHub Repository<br/>Main Branch]
    end
    
    subgraph "Azure DevOps / GitHub Actions"
        Build[Build Pipeline<br/>.NET Core Build]
        Test[Unit Tests<br/>Integration Tests]
        Scan[Security Scan<br/>SonarQube/CodeQL]
        Package[Container Build<br/>Docker/ACR]
    end
    
    subgraph "Environments"
        Dev[Development<br/>Auto Deploy]
        Staging[Staging<br/>Manual Approval]
        Prod[Production<br/>Blue/Green Deploy]
    end
    
    subgraph "Azure Services"
        ACR[Azure Container Registry]
        AppService[App Services]
        Functions[Azure Functions]
        KeyVault[Key Vault<br/>Env-Specific Secrets]
    end
    
    GitHub -->|Push| Build
    Build --> Test
    Test --> Scan
    Scan --> Package
    
    Package --> ACR
    
    ACR -->|Deploy| Dev
    Dev -->|Promote| Staging
    Staging -->|Promote| Prod
    
    Dev --> AppService
    Dev --> Functions
    Dev -.-> KeyVault
    
    Staging --> AppService
    Staging --> Functions
    Staging -.-> KeyVault
    
    Prod --> AppService
    Prod --> Functions
    Prod -.-> KeyVault
    
    style GitHub fill:#24292e,stroke:#333,stroke-width:2px,color:#fff
    style ACR fill:#0078d4,stroke:#333,stroke-width:2px
```

### Monitoring & Observability

```mermaid
graph TB
    subgraph "Application Layer"
        API[.NET Core APIs]
        Functions[Azure Functions]
        LogicApps[Logic Apps]
    end
    
    subgraph "Telemetry Collection"
        AppInsights[Application Insights<br/>SDK Integration]
        DiagSettings[Diagnostic Settings]
    end
    
    subgraph "Data Storage"
        LogAnalytics[Log Analytics Workspace]
        MetricsStore[Azure Monitor Metrics]
    end
    
    subgraph "Analysis & Alerting"
        Workbooks[Azure Workbooks<br/>Dashboards]
        Alerts[Alert Rules<br/>Action Groups]
        Query[Kusto Queries<br/>KQL]
    end
    
    subgraph "Actions"
        PagerDuty[PagerDuty]
        Email[Email Notifications]
        Webhook[Webhook/Logic App]
    end
    
    API --> AppInsights
    Functions --> AppInsights
    LogicApps --> DiagSettings
    
    AppInsights --> LogAnalytics
    DiagSettings --> LogAnalytics
    AppInsights --> MetricsStore
    
    LogAnalytics --> Query
    Query --> Workbooks
    MetricsStore --> Alerts
    
    Alerts --> PagerDuty
    Alerts --> Email
    Alerts --> Webhook
    
    style AppInsights fill:#68217a,stroke:#333,stroke-width:2px
    style LogAnalytics fill:#0078d4,stroke:#333,stroke-width:2px
```

---

## Azure Service Configuration

### App Service Configuration

```yaml
App Service Plan:
  Tier: Premium V3 (P1V3 or higher)
  Auto-scaling: Enabled
    - Min Instances: 2
    - Max Instances: 10
    - Scale Rules:
      - CPU > 70% for 5 min → Scale Out
      - CPU < 30% for 10 min → Scale In
  
  Always On: Enabled
  HTTPS Only: Enabled
  Managed Identity: System-assigned
  
  Application Settings:
    - APPLICATIONINSIGHTS_CONNECTION_STRING: @KeyVault
    - AzureAd__ClientSecret: @KeyVault
    - ConnectionStrings__DefaultConnection: @KeyVault
    - RDS__ApiKey: @KeyVault
    - Redis__ConnectionString: @KeyVault
```

### Azure SQL Database Configuration

```yaml
Azure SQL Database:
  Tier: General Purpose
  Compute: Provisioned (4-8 vCores)
  Storage: 100-500 GB (auto-grow enabled)
  
  Security:
    - Transparent Data Encryption: Enabled
    - Advanced Data Security: Enabled
    - Auditing: Enabled (Log Analytics)
    - Firewall: Azure Services Only
    - Private Endpoint: Enabled
  
  High Availability:
    - Zone Redundant: Enabled (Production)
    - Backup Retention: 35 days
    - Point-in-time Restore: Enabled
    - Geo-Replication: Enabled (Production)
```

### Azure Redis Cache Configuration

```yaml
Azure Cache for Redis:
  Tier: Premium
  Capacity: P1 (6 GB) or higher
  
  Features:
    - Clustering: Enabled
    - Persistence: RDB backup every 60 min
    - Non-SSL Port: Disabled
    - Firewall: VNet integration
    - Geo-Replication: Enabled (Production)
  
  Configuration:
    - maxmemory-policy: allkeys-lru
    - Default TTL: 86400 (24 hours)
```

---

## Cost Optimization

### Azure Cost Estimates (Monthly)

| Service | Configuration | Est. Monthly Cost |
|---------|--------------|-------------------|
| App Service (x3 APIs) | Premium P1V3 x 3 | $450 |
| Azure Functions | Consumption Plan | $50 |
| Azure Logic Apps | Standard, 10K runs | $100 |
| Azure SQL Database | GP 4 vCore | $550 |
| Azure Blob Storage | 500 GB + operations | $25 |
| Azure Redis Cache | Premium P1 | $275 |
| API Management | Developer Tier | $50 |
| Event Grid | 1M operations | $2 |
| Application Insights | 10 GB data ingestion | $25 |
| Azure Key Vault | 10K operations | $5 |
| Azure AD B2C | 50K MAU | Free-$15 |
| **Total Estimated** | | **~$1,550/month** |

*Note: Costs will scale with usage. Production environment may require higher tiers.*

---

## Summary & Recommendations

### Architecture Highlights

1. **Cloud-Native Design**: Fully leverages Azure PaaS services for reduced operational overhead
2. **Microservices Pattern**: Domain-driven service boundaries with independent scaling
3. **Event-Driven Integration**: Loose coupling via Azure Event Grid for system resilience
4. **Multi-Layer Caching**: Redis + APIM caching reduces RDS API calls and improves performance
5. **Circuit Breaker Pattern**: Polly library protects against cascading failures
6. **Security First**: Azure AD, Key Vault, Private Link, TDE for comprehensive security
7. **Observable**: Application Insights + Log Analytics for full system visibility

### Next Steps

1. **Provision Azure Resources**: Use Terraform/Bicep for infrastructure as code
2. **Implement RDS Adapter**: Build .NET Core integration layer with Polly resilience
3. **Configure Event Grid**: Set up domain event topics and subscriptions
4. **Set Up Monitoring**: Configure Application Insights, alerts, and dashboards
5. **Establish CI/CD**: GitHub Actions or Azure DevOps pipelines
6. **Load Testing**: Validate auto-scaling and performance under load
7. **Security Review**: Penetration testing and compliance validation

---

## Document Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-10-15 | System Architect | Initial Azure architecture documentation |

