# RDS Integration Technical Specification

**Status:** DRAFT - To be completed after RDS system owners meeting  
**Version:** 1.0  
**Last Updated:** 2025-10-15  
**Owner:** K-12 System Architect

---

## Document Purpose

This document serves as the **definitive technical specification** for integrating the K-12 SEAA system with the North Carolina Residency Determination Service (RDS). It will be completed after the discovery meeting with RDS system owners.

---

## Integration Overview

### Integration Type
**[TO BE DETERMINED]**
- [ ] RESTful API (synchronous)
- [ ] SOAP Web Services
- [ ] GraphQL API
- [ ] Batch File Exchange (SFTP/S3)
- [ ] Message Queue (Kafka/RabbitMQ/Azure Service Bus)
- [ ] Direct Database Access (not recommended)
- [ ] Manual Portal Entry Only (no integration)
- [ ] Other: _______________________

### Integration Pattern
**[TO BE DETERMINED]**
- [ ] Real-time API calls (K-12 → RDS)
- [ ] Asynchronous job queue (K-12→ Queue → RDS)
- [ ] Event-driven (webhooks/callbacks)
- [ ] Batch/scheduled sync (nightly, hourly)
- [ ] Hybrid (real-time reads, batch writes)

### Data Flow Direction
**[TO BE DETERMINED]**
- [ ] K-12 → RDS (write residency cases)
- [ ] K-12 ← RDS (read residency determinations)
- [ ] Bidirectional (read and write)

---

## Authentication & Authorization

### Authentication Method
**[TO BE DETERMINED]**
- [ ] OAuth 2.0 (Client Credentials Flow)
- [ ] OAuth 2.0 (Authorization Code Flow)
- [ ] API Keys
- [ ] SAML 2.0 SSO
- [ ] Mutual TLS (mTLS) with client certificates
- [ ] Basic Auth (username/password)
- [ ] Other: _______________________

### Credential Management
**[TO BE DETERMINED]**
- **Credential Issuer:** _______________________
- **Credential Rotation Policy:** _______________________
- **Credential Storage:** Azure Key Vault / AWS Secrets Manager / Other: _______
- **Environments:**
  - Sandbox: _______________________
  - Staging: _______________________
  - Production: _______________________

### Authorization Scopes
**[TO BE DETERMINED]**
```
[List required scopes/permissions]
Example:
- residency:cases:read
- residency:cases:write
- residency:documents:upload
```

---

## API Endpoints

### Base URLs
**[TO BE DETERMINED]**
- **Sandbox:** _______________________
- **Staging:** _______________________
- **Production:** _______________________

### Available Endpoints
**[TO BE COMPLETED AFTER MEETING]**

#### Endpoint 1: Create Residency Case
```
[TO BE DETERMINED]

Method: POST
Path: /api/v1/residency-cases
Headers:
  Authorization: Bearer {token}
  Content-Type: application/json

Request Body:
{
  [SCHEMA TO BE PROVIDED]
}

Response 201 Created:
{
  [SCHEMA TO BE PROVIDED]
}

Error Responses:
- 400 Bad Request: [details]
- 401 Unauthorized: [details]
- 403 Forbidden: [details]
- 500 Internal Server Error: [details]
```

#### Endpoint 2: Get Residency Case Status
```
[TO BE DETERMINED]

Method: GET
Path: /api/v1/residency-cases/{caseId}
Headers:
  Authorization: Bearer {token}

Response 200 OK:
{
  [SCHEMA TO BE PROVIDED]
}

Error Responses:
- 404 Not Found: [details]
```

#### Endpoint 3: Search Residency Cases
```
[TO BE DETERMINED]

Method: GET
Path: /api/v1/residency-cases/search?ssn={ssn}&program={program}
Headers:
  Authorization: Bearer {token}

Response 200 OK:
{
  [SCHEMA TO BE PROVIDED]
}
```

#### Endpoint 4: Upload Document
```
[TO BE DETERMINED]

Method: POST
Path: /api/v1/residency-cases/{caseId}/documents
Headers:
  Authorization: Bearer {token}
  Content-Type: multipart/form-data

Request Body:
  documentType: [ENUM]
  file: [binary]

Response 201 Created:
{
  [SCHEMA TO BE PROVIDED]
}
```

#### Additional Endpoints
```
[TO BE DETERMINED - List all other available endpoints]
```

---

## Data Models

### Residency Case
**[SCHEMA TO BE PROVIDED]**
```json
{
  "caseId": "string",
  "studentInfo": {
    "ssn": "string",
    "firstName": "string",
    "lastName": "string",
    "dateOfBirth": "date"
  },
  "determination": {
    "status": "RESIDENT | NON_RESIDENT | PENDING",
    "effectiveDate": "date",
    "expirationDate": "date"
  }
}
```

### Document Types
**[TO BE PROVIDED]**
```
Enumeration of valid document types:
- NC_DRIVERS_LICENSE
- NC_STATE_ID
- UTILITY_BILL
- [additional types...]
```

### Status Codes
**[TO BE PROVIDED]**
```
Enumeration of residency case statuses:
- PENDING_SUBMISSION
- PENDING_DOCUMENTS
- PENDING_VERIFICATION
- RESIDENT
- NON_RESIDENT
- [additional statuses...]
```

---

## Performance Characteristics

### Response Time SLAs
**[TO BE DETERMINED]**
- **API Query (GET):** _____ ms (P50), _____ ms (P95), _____ ms (P99)
- **API Create (POST):** _____ ms (P50), _____ ms (P95), _____ ms (P99)
- **Document Upload:** _____ seconds (typical)
- **Determination Time:** _____ hours/days (typical)

### Rate Limits
**[TO BE DETERMINED]**
- **Requests per minute:** _____
- **Requests per hour:** _____
- **Requests per day:** _____
- **Burst capacity:** _____
- **Rate limit headers:** X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset

### Availability SLA
**[TO BE DETERMINED]**
- **Uptime commitment:** _____ % (e.g., 99.9%, 99.95%)
- **Scheduled maintenance windows:** _____
- **Notification of downtime:** _____

---

## Error Handling

### HTTP Status Codes
**[TO BE DOCUMENTED]**
| Status Code | Meaning | Retry? | Notes |
|-------------|---------|--------|-------|
| 200 | Success | N/A | |
| 201 | Created | N/A | |
| 400 | Bad Request | No | Check request schema |
| 401 | Unauthorized | Yes | Refresh token |
| 403 | Forbidden | No | Insufficient permissions |
| 404 | Not Found | No | Case does not exist |
| 429 | Too Many Requests | Yes | Exponential backoff |
| 500 | Internal Server Error | Yes | RDS system issue |
| 503 | Service Unavailable | Yes | Maintenance or outage |

### Error Response Format
**[TO BE PROVIDED]**
```json
{
  "error": {
    "code": "string",
    "message": "string",
    "details": [],
    "timestamp": "ISO8601"
  }
}
```

### Retry Strategy
**[TO BE DETERMINED]**
- **Retryable errors:** 429, 500, 502, 503, 504, network timeouts
- **Non-retryable errors:** 400, 401, 403, 404
- **Retry attempts:** _____ (e.g., 3)
- **Backoff strategy:** Exponential (1s, 2s, 4s, 8s, ...)
- **Max retry time:** _____ seconds

---

## Security & Compliance

### Data Encryption
**[TO BE CONFIRMED]**
- **In Transit:** TLS 1.2+ required
- **At Rest:** AES-256 encryption (RDS responsibility)
- **Certificate Pinning:** [ ] Yes [ ] No

### Data Classification
**[TO BE CONFIRMED]**
- **PII Present:** Yes (SSN, name, address, DOB)
- **Sensitivity Level:** High
- **FERPA Applicable:** Yes
- **Data Retention:** _____ years

### Compliance Certifications
**[TO BE PROVIDED]**
- [ ] NIST 800-53 compliant
- [ ] SOC 2 Type II certified
- [ ] FERPA compliant
- [ ] Other: _______________________

### Audit Logging
**[TO BE CONFIRMED]**
- **RDS audit logs:** [ ] Available to consumers [ ] Internal only
- **K-12 audit requirements:** Log all API calls, responses, errors
- **Audit retention:** _____ years

---

## Webhooks / Callbacks (If Supported)

### Webhook Configuration
**[TO BE DETERMINED]**
- [ ] Webhooks supported
- [ ] Webhooks not supported (polling required)

### Event Types
**[TO BE PROVIDED]**
```
List of webhook events:
- residency.determination.completed
- residency.reconsideration.requested
- residency.appeal.decided
- [additional events...]
```

### Webhook Payload Format
**[TO BE PROVIDED]**
```json
{
  "eventId": "string",
  "eventType": "string",
  "timestamp": "ISO8601",
  "data": {
    "caseId": "string",
    [additional fields...]
  }
}
```

### Webhook Security
**[TO BE DETERMINED]**
- **Signature verification:** HMAC-SHA256, JWT, or other
- **Signature header:** X-RDS-Signature or other
- **IP whitelisting:** [ ] Required [ ] Optional

### Webhook Reliability
**[TO BE DETERMINED]**
- **Retry policy:** _____ attempts over _____ hours
- **Timeout:** _____ seconds
- **Idempotency:** [ ] Guaranteed [ ] Not guaranteed (K-12 must deduplicate)

---

## Integration Architecture

### K-12 System Components
```
┌───────────────────────────────────────────────┐
│         K-12 SEAA System                      │
│                                               │
│  ┌─────────────────────────────────────────┐ │
│  │  Application Service                    │ │
│  │  (Domain Logic)                         │ │
│  └────────────┬────────────────────────────┘ │
│               │                               │
│               ▼                               │
│  ┌─────────────────────────────────────────┐ │
│  │  RDS Adapter                            │ │
│  │  - API Client                           │ │
│  │  - Circuit Breaker                      │ │
│  │  - Retry Logic                          │ │
│  │  - Response Cache                       │ │
│  └────────────┬────────────────────────────┘ │
│               │                               │
└───────────────┼───────────────────────────────┘
                │
                │ HTTPS/REST
                ▼
┌───────────────────────────────────────────────┐
│         NC RDS System                         │
│                                               │
│  - Residency API                              │
│  - Authentication                             │
│  - Rate Limiting                              │
│  - Audit Logging                              │
└───────────────────────────────────────────────┘
```

### Circuit Breaker Configuration
**[TO BE DETERMINED]**
- **Failure threshold:** _____ consecutive failures
- **Timeout:** _____ seconds
- **Open circuit duration:** _____ seconds
- **Half-open test requests:** _____

### Caching Strategy
**[TO BE DETERMINED]**
- **Cache backend:** Redis / Azure Cache / In-Memory
- **Cache key:** caseId or student SSN
- **Cache TTL:** _____ hours/days
- **Cache invalidation:** Manual, time-based, or event-driven?

### Fallback Mechanism
**[TO BE DETERMINED]**
- **Fallback when RDS unavailable:** Manual verification in MyPortal
- **Graceful degradation:** [ ] Yes [ ] No
- **Dead letter queue:** [ ] Yes [ ] No

---

## Testing Strategy

### Sandbox Environment
**[TO BE PROVIDED]**
- **Sandbox URL:** _______________________
- **Sandbox credentials:** _______________________
- **Test data available:** [ ] Yes [ ] No
- **Feature parity with production:** [ ] Yes [ ] Partial [ ] No
- **Data reset frequency:** _______________________

### Test Scenarios
**[TO BE EXECUTED]**
- [ ] Create residency case (happy path)
- [ ] Query existing case
- [ ] Upload document
- [ ] Handle 401 Unauthorized (expired token)
- [ ] Handle 429 Rate Limit Exceeded
- [ ] Handle 500 Internal Server Error
- [ ] Handle network timeout
- [ ] Test webhook delivery (if applicable)
- [ ] Load testing (_____ requests/second)

### Performance Testing
**[TO BE CONDUCTED]**
- **Load test target:** _____ concurrent users
- **Stress test target:** _____ requests/second
- **Soak test duration:** _____ hours

---

## Deployment & Operations

### Deployment Environments
**[TO BE CONFIGURED]**
| Environment | Purpose | RDS Base URL | Credentials |
|-------------|---------|--------------|-------------|
| Local Dev | Developer testing | Sandbox | Dev keys |
| CI/CD | Automated tests | Sandbox | CI keys |
| Staging | UAT | Staging (if exists) | Staging keys |
| Production | Live | Production | Prod keys |

### Monitoring & Alerting
**[TO BE IMPLEMENTED]**
- **Metrics to monitor:**
  - API call volume (requests/min)
  - Response time (P50, P95, P99)
  - Error rate (%)
  - Circuit breaker state
  - Cache hit/miss ratio
- **Alerting thresholds:**
  - Error rate > _____% for _____ minutes
  - P95 latency > _____ ms
  - Circuit breaker open
- **Alerting channels:**
  - PagerDuty, Slack, Email, SMS

### Logging
**[TO BE IMPLEMENTED]**
- **Log all API requests:** URL, method, headers (excluding sensitive data)
- **Log all API responses:** Status code, body (excluding PII)
- **Log errors:** Full stack trace, request context
- **Log retention:** _____ days in hot storage, _____ years in cold storage
- **Log aggregation:** Azure Monitor, Splunk, ELK, or other

### Health Checks
**[TO BE IMPLEMENTED]**
- **RDS health check endpoint:** _______________________
- **K-12 adapter health check:** `/health` returns RDS connectivity status
- **Frequency:** Every _____ seconds

---

## Support & Escalation

### RDS Support Contacts
**[TO BE PROVIDED]**
| Support Tier | Contact | Email | Phone | Hours | SLA |
|--------------|---------|-------|-------|-------|-----|
| L1 - General | | | | | |
| L2 - Technical | | | | | |
| L3 - Engineering | | | | | |
| Emergency Escalation | | | | | |

### Incident Response
**[TO BE DEFINED]**
- **Severity 1 (Production Down):** Response time _____, resolution time _____
- **Severity 2 (Degraded Performance):** Response time _____, resolution time _____
- **Severity 3 (Non-Critical Issue):** Response time _____, resolution time _____

### Communication Channels
**[TO BE ESTABLISHED]**
- [ ] Email support: _______________________
- [ ] Phone support: _______________________
- [ ] Ticketing system: _______________________
- [ ] Slack channel: _______________________
- [ ] Developer portal: _______________________

---

## Legal & Governance

### Data Sharing Agreement
**[TO BE EXECUTED]**
- [ ] MOU required
- [ ] MOU template provided
- [ ] MOU signed by: _______________________
- [ ] Effective date: _______________________
- [ ] Renewal date: _______________________

### Security Review
**[TO BE COMPLETED]**
- [ ] Security questionnaire completed
- [ ] Penetration test results reviewed
- [ ] Vulnerability scan results reviewed
- [ ] Sign-off by: _______________________

### Procurement
**[TO BE DETERMINED]**
- [ ] No cost (free for NC agencies)
- [ ] Cost: $_____ per transaction / per year
- [ ] Purchase order required: _______________________
- [ ] Contract number: _______________________

---

## Timeline & Milestones

### Integration Roadmap
**[TO BE FINALIZED]**

| Milestone | Target Date | Status | Owner | Notes |
|-----------|-------------|--------|-------|-------|
| Discovery meeting | 2025-10-XX | [ ] | | |
| API documentation received | | [ ] | | |
| Sandbox access granted | | [ ] | | |
| MOU/legal agreement signed | | [ ] | | |
| Proof of concept complete | | [ ] | | |
| Integration development complete | | [ ] | | |
| Security review complete | | [ ] | | |
| UAT complete | | [ ] | | |
| Production credentials issued | | [ ] | | |
| Production deployment (pilot) | | [ ] | | |
| Production deployment (full) | | [ ] | | |

---

## Open Questions / Action Items

**[TO BE TRACKED]**

| Question | Assigned To | Due Date | Status | Answer |
|----------|-------------|----------|--------|--------|
| Does RDS API support K-12 programs? | | | | |
| What is onboarding timeline? | | | | |
| Can we get sandbox access? | | | | |
| [Add more as identified] | | | | |

---

## Appendix A: API Request/Response Examples

**[TO BE POPULATED WITH REAL EXAMPLES AFTER MEETING]**

### Example 1: Create Residency Case
```
[Real API call example here]
```

### Example 2: Query Residency Status
```
[Real API call example here]
```

---

## Appendix B: Code Samples

**[TO BE DEVELOPED]**

### C# Example
```csharp
// RDS API client example
public class RdsClient
{
    private readonly HttpClient _httpClient;
    private readonly string _apiKey;

    public async Task<ResidencyCase> CreateCaseAsync(CreateCaseRequest request)
    {
        // [Implementation details]
    }
}
```

### TypeScript Example
```typescript
// RDS API client example
export class RdsClient {
    constructor(private apiKey: string) {}

    async createCase(request: CreateCaseRequest): Promise<ResidencyCase> {
        // [Implementation details]
    }
}
```

---

## Document Approval

**[TO BE SIGNED OFF]**

| Role | Name | Signature | Date |
|------|------|-----------|------|
| K-12 System Architect | | | |
| RDS Technical Lead | | | |
| NCSEAA Program Manager | | | |
| Legal/Compliance | | | |

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 (DRAFT) | 2025-10-15 | AI Researcher | Initial template created |
| | | | [Future revisions] |

