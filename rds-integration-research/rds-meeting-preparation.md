# RDS System Owners Meeting - Preparation Guide

**Meeting Purpose:** Technical discovery for integrating NC Residency Determination Service (RDS) with K-12 SEAA software system

**Prepared By:** K-12 System Architect  
**Date:** 2025-10-15  
**Meeting Duration:** 90-120 minutes recommended

---

## Meeting Agenda (Proposed)

### Part 1: Introductions & Context (10 min)
- Introduce K-12 SEAA project and team
- Explain integration need and business value
- Set expectations for technical deep dive

### Part 2: RDS System Overview (20 min)
- Request RDS architectural overview presentation
- Understand current consumer landscape (who integrates today?)
- Learn about roadmap and strategic direction

### Part 3: Technical Integration Deep Dive (40 min)
- API capabilities and authentication
- Data models and workflow
- Performance, security, and compliance
- Error handling and support model

### Part 4: K-12 Integration Planning (20 min)
- Discuss K-12-specific requirements
- Review proposed integration architecture
- Identify dependencies and blockers
- Establish next steps and timeline

### Part 5: Q&A and Wrap-Up (10 min)

---

## Pre-Meeting Preparation Checklist

### For K-12 Team
- [ ] Review comprehensive RDS research document
- [ ] Prepare architecture diagrams showing proposed integration
- [ ] Identify must-have vs. nice-to-have integration features
- [ ] Prepare list of sample use cases and user stories
- [ ] Gather legal/compliance contacts for MOU discussions
- [ ] Prepare timeline constraints (when must integration be live?)

### Information to Bring
- [ ] K-12 system architecture diagram
- [ ] Sample residency verification workflow (current state)
- [ ] Volume estimates (applications per year, peak periods)
- [ ] Security/compliance documentation (NIST 800-53, FERPA)
- [ ] Proposed integration architecture (target state)

---

## Priority-Ranked Questions

### 🔴 CRITICAL - Must Answer in This Meeting

#### 1. Integration Feasibility
**Q:** Does RDS provide a programmatic API (REST, SOAP, or other) for third-party systems to integrate with?

**Why Critical:** If no API exists, entire integration approach must pivot to manual process or alternative verification methods.

**Follow-ups:**
- If yes: Can we get API documentation today?
- If yes: When can we get sandbox access?
- If no: Is API development on the roadmap? What timeline?
- If no: What alternatives exist (batch files, shared database, portal-only)?

---

#### 2. K-12 Program Support
**Q:** Is RDS designed to support K-12 scholarship residency verification, or only higher education?

**Why Critical:** May discover RDS is out-of-scope for K-12, requiring completely different approach.

**Follow-ups:**
- Are there any K-12 programs currently using RDS?
- What would be required to extend RDS for K-12 use cases?
- Is there a different residency verification system for K-12?

---

#### 3. Integration Timeline
**Q:** What is the typical timeline from initial request to production integration for a new consumer?

**Why Critical:** K-12 system launch timeline depends on RDS integration availability.

**Follow-ups:**
- What are the steps in the onboarding process?
- What approvals or agreements are required (MOU, security review)?
- Who are the decision-makers we need to work with?
- Can we fast-track if executive sponsorship exists?

---

#### 4. Authentication & Authorization
**Q:** What authentication mechanism is required for API access?

**Why Critical:** Security architecture design depends on auth method (OAuth, API keys, certs, etc.).

**Follow-ups:**
- Is OAuth 2.0 supported?
- Are API keys issued per environment (dev, staging, prod)?
- What authorization scopes/permissions exist?
- How are credentials rotated and managed?

---

#### 5. Real-Time vs. Batch
**Q:** Does RDS support real-time API calls, or only batch/asynchronous processing?

**Why Critical:** User experience design (immediate feedback vs. async notifications) depends on this.

**Follow-ups:**
- What is typical response time for residency determination?
- Can we poll for status updates? At what frequency?
- Are webhooks available for status change notifications?

---

### 🟡 HIGH PRIORITY - Should Answer in This Meeting

#### 6. Data Model & Endpoints
**Q:** Can we review the complete API data model and available endpoints?

**Desired Information:**
- OpenAPI/Swagger specification
- JSON/XML schemas for requests and responses
- List of all API endpoints (create, read, update, delete operations)
- Sample API calls with request/response examples

---

#### 7. Residency Determination Workflow
**Q:** What is the end-to-end workflow for residency determination from case creation to final decision?

**Desired Information:**
- Average time from submission to determination (hours? days?)
- Percentage auto-approved vs. manual review
- What triggers manual review vs. automated approval?
- How are reconsiderations and appeals processed?
- Can we track case progress programmatically?

---

#### 8. State Agency Integrations
**Q:** How does RDS integrate with state agencies (DMV, DPI, Revenue, etc.) for electronic verification per G.S. 115C-562.3?

**Desired Information:**
- Which agencies have live integrations today?
- Which integrations are planned but not yet implemented?
- What is the data exchange mechanism (API, batch, manual)?
- What are typical response times from agencies?
- What happens if agency verification fails or times out?

---

#### 9. Higher-Ed Integration Examples
**Q:** How do UNC, community colleges, and private institutions currently integrate with RDS?

**Desired Information:**
- Which institutions use API vs. manual portal lookup?
- Success stories or lessons learned from past integrations
- Common integration challenges and how they were overcome
- Can we speak with a reference customer?

---

#### 10. Performance & Scalability
**Q:** What are the system performance characteristics and capacity limits?

**Desired Information:**
- Average API response time (ms)
- P95/P99 latency
- Rate limits (requests per minute/hour)
- Peak capacity (requests per second)
- Scheduled maintenance windows
- Historical uptime/availability metrics (SLA)

---

### 🟢 MEDIUM PRIORITY - Nice to Answer in This Meeting

#### 11. Error Handling & Resilience
**Q:** What error codes and responses can we expect from the API?

**Desired Information:**
- HTTP status codes used (400, 401, 403, 404, 500, etc.)
- Error response format (JSON structure)
- Retry guidance (which errors are retryable?)
- Circuit breaker recommendations
- How to handle partial failures (e.g., DMV API down but other checks pass)

---

#### 12. Caching & Data Freshness
**Q:** Can we cache residency determinations locally? For how long?

**Desired Information:**
- Recommended cache TTL (time to live)
- How are invalidations handled (if determination changes)?
- Is there a cache-control header or version indicator?
- What happens if cached data becomes stale?

---

#### 13. Support & SLAs
**Q:** What technical support is available for integration partners?

**Desired Information:**
- Support team contact (email, phone, ticketing system)
- Support hours (business hours only or 24/7?)
- Response time SLAs (P1/P2/P3 incidents)
- Escalation procedures for critical issues
- Developer community or Slack channel

---

#### 14. Cost & Licensing
**Q:** Is there a cost associated with RDS API access?

**Desired Information:**
- Per-transaction fees?
- Annual licensing fees?
- Volume discounts?
- Free tier for NC state agencies?
- Billing and invoicing process

---

#### 15. Data Retention & Privacy
**Q:** What is the data retention policy for residency cases?

**Desired Information:**
- How long are cases retained in RDS?
- When/how are cases archived or purged?
- Can students request data deletion (right to be forgotten)?
- What data is logged in audit trails?
- Who has access to audit logs?

---

#### 16. Change Management
**Q:** How are API changes and updates communicated to integration partners?

**Desired Information:**
- How far in advance are breaking changes announced?
- Is API versioning used (/v1, /v2)?
- How long are deprecated endpoints supported?
- Is there a developer newsletter or announcement channel?
- Beta/preview programs for testing new features?

---

#### 17. Testing & Sandbox
**Q:** Is there a sandbox or test environment for integration development?

**Desired Information:**
- Sandbox URL and credentials
- Does sandbox have full feature parity with production?
- Can we create test data in sandbox?
- Is sandbox data reset periodically?
- Can we load test against sandbox?

---

#### 18. Monitoring & Observability
**Q:** Does RDS provide integration health metrics or status page?

**Desired Information:**
- Public status page (like status.example.com)?
- Health check endpoint for monitoring?
- Webhook delivery metrics?
- Can we subscribe to incident notifications?

---

#### 19. Compliance & Auditing
**Q:** What compliance certifications does RDS maintain?

**Desired Information:**
- NIST 800-53 compliance
- SOC 2 Type II audit reports
- FERPA compliance documentation
- Penetration testing results
- How are audit logs provided to consumers?

---

#### 20. Roadmap & Future Features
**Q:** What new capabilities are planned for RDS in the next 12-24 months?

**Desired Information:**
- Webhook/event streaming support
- GraphQL API (in addition to REST)
- Self-service developer portal
- Expanded document types (e.g., digital identity verification)
- K-12-specific enhancements

---

## Scenarios & Use Cases to Discuss

### Scenario 1: New K-12 Application (Happy Path)
**User Story:** Parent submits Opportunity Scholarship application for student who just moved to NC

**Workflow:**
1. Parent completes application in MyPortal
2. K-12 system checks if RDS case exists for student
3. No case found → Create new RDS case via API
4. RDS prompts parent to upload NC driver's license and utility bill
5. RDS auto-validates driver's license with DMV
6. RDS determines: RESIDENT (12-month requirement met)
7. K-12 system proceeds with eligibility calculation and award

**Questions:**
- Can steps 2-6 complete in <5 seconds for good UX?
- Can we embed RDS document upload UI in MyPortal (white-label)?
- How do we handle cases where determination takes 24-48 hours (manual review)?

---

### Scenario 2: Returning Student (Cache Hit)
**User Story:** Student had Opportunity Scholarship last year, renewing for 2025-26

**Workflow:**
1. Parent submits renewal application in MyPortal
2. K-12 system checks if RDS case exists for student
3. Case found → Retrieve current determination: RESIDENT (valid until 2026-07-31)
4. K-12 system proceeds immediately with renewal (no re-verification needed)

**Questions:**
- Can we cache determination locally to avoid repeated API calls?
- How do we detect if determination has been invalidated (e.g., student moved)?
- Should we re-verify residency annually or trust RDS expiration date?

---

### Scenario 3: Borderline Case (Manual Review)
**User Story:** Military family stationed in NC but maintaining legal residence in VA

**Workflow:**
1. Parent submits application and indicates military status
2. K-12 system creates RDS case with military exemption flag
3. RDS escalates to manual review (not auto-approved)
4. NCSEAA staff reviewer requests additional documentation (military orders)
5. Staff approves: RESIDENT (military exemption)
6. K-12 system receives notification and proceeds with award

**Questions:**
- How long does manual review typically take (days? weeks?)
- Can we track case status programmatically (e.g., status = "PENDING_REVIEW")?
- Are webhooks available to notify K-12 system when review completes?
- Should K-12 system send proactive reminders to parent while case is pending?

---

### Scenario 4: Non-Resident Outcome
**User Story:** Student recently moved to NC from FL, only 6 months of domicile

**Workflow:**
1. Parent submits application
2. RDS determines: NON-RESIDENT (does not meet 12-month requirement)
3. K-12 system denies scholarship eligibility
4. Parent receives notification with instructions to reapply after 12 months

**Questions:**
- Can parent request reconsideration via API or only manual process?
- How do we handle partial residency (6 months in NC, will reach 12 months mid-year)?
- Should we proactively calculate "eligible date" and notify parent when to reapply?

---

### Scenario 5: RDS System Outage
**User Story:** Parent submits application during RDS maintenance window

**Workflow (Proposed):**
1. Parent submits application
2. K-12 system calls RDS API → 503 Service Unavailable
3. Circuit breaker trips, falls back to manual verification
4. K-12 system prompts parent to upload residency documents directly to MyPortal
5. NCSEAA staff manually reviews documents and updates K-12 system
6. When RDS returns to service, staff creates retroactive RDS case for audit trail

**Questions:**
- Is this fallback approach acceptable to NCSEAA leadership?
- How do we prevent fraud during manual verification?
- What is typical RDS downtime duration (minutes? hours?)?
- Do you provide advance notice of maintenance windows?

---

## Information to Request

### Documentation
- [ ] API documentation (OpenAPI/Swagger spec)
- [ ] Data model schema (JSON/XML)
- [ ] Developer onboarding guide
- [ ] Sample code/SDKs (if available)
- [ ] Integration architecture diagram
- [ ] Security and compliance documentation
- [ ] MOU/data sharing agreement template

### Access & Credentials
- [ ] Sandbox environment URL and credentials
- [ ] API key or OAuth client credentials (for sandbox)
- [ ] Technical contact information (name, email, phone)
- [ ] Support ticketing system access

### Legal & Governance
- [ ] Data sharing agreement (MOU) template
- [ ] Security review checklist
- [ ] Procurement process documentation (if fees apply)
- [ ] FERPA compliance attestation

---

## Follow-Up Actions (Post-Meeting)

### Immediate (Within 1 Week)
- [ ] Send meeting notes to RDS team for validation
- [ ] Review any documentation provided
- [ ] Set up sandbox environment access
- [ ] Begin MOU/legal agreement process (if required)
- [ ] Schedule technical deep dive #2 (if needed)

### Short-Term (Within 1 Month)
- [ ] Build proof-of-concept integration
- [ ] Validate API authentication
- [ ] Test create/read/update operations
- [ ] Document integration patterns
- [ ] Present findings to K-12 system stakeholders

### Long-Term (1-3 Months)
- [ ] Complete full integration development
- [ ] Conduct security review
- [ ] Execute UAT with NCSEAA staff
- [ ] Obtain production credentials
- [ ] Deploy to production (phased rollout)

---

## Key Talking Points

### Value Proposition for RDS Team
**Why integrating K-12 is beneficial for RDS:**
- Expands RDS scope beyond higher-ed to K-12 market (30,000+ Opportunity Scholarship students)
- Demonstrates statewide residency verification platform vision
- Reduces redundant verification across NCSEAA programs
- Centralizes compliance and audit trail for all state aid programs
- Positions RDS as authoritative source for NC residency across all education levels

### K-12 Business Requirements
**What K-12 system must accomplish:**
- Verify residency for ~30,000 Opportunity Scholarship applicants annually
- Verify residency for ~12,000 ESA+ applicants annually
- Peak load: Feb-Apr (application windows)
- Must comply with G.S. 115C-562.3 statutory requirements
- Must support audit and compliance reporting
- Must provide timely parent/student notifications

### Non-Negotiables for K-12 System
**Integration requirements we cannot compromise on:**
1. **Security:** Must meet NIST 800-53 and FERPA standards
2. **Performance:** <5 second response time for real-time queries (if synchronous)
3. **Reliability:** Fallback mechanism required if RDS unavailable
4. **Auditability:** Complete audit trail for all residency determinations
5. **Data Privacy:** PII must be encrypted at rest and in transit

---

## Risk Mitigation Strategies

### Risk: No API Available (RDS is Portal-Only)
**Mitigation:**
- Negotiate portal access for NCSEAA K-12 staff
- Build manual verification workflow in MyPortal
- Advocate for API development on RDS roadmap (offer to co-fund)
- Explore alternative verification via DMV/DPI APIs directly

### Risk: K-12 Not in Scope for RDS
**Mitigation:**
- Escalate to NCSEAA executive leadership for strategic alignment
- Build business case (cost savings, consistency, audit benefits)
- Offer to fund development of K-12 module within RDS
- Implement interim solution (manual verification) until RDS extended

### Risk: Long Integration Timeline (6+ Months)
**Mitigation:**
- Fast-track by offering dedicated developer resources
- Simplify scope (read-only integration first, write operations later)
- Negotiate interim data sharing arrangement (batch files)
- Implement phased rollout (pilot with 10% of applications)

### Risk: Unacceptable Performance (Slow API)
**Mitigation:**
- Implement async workflow (notify parent when determination complete)
- Aggressive caching strategy (cache determinations for 30 days)
- Batch operations during off-peak hours
- Pre-create RDS cases for returning students

---

## Success Criteria for This Meeting

**Must Achieve:**
✅ Confirm whether programmatic API exists  
✅ Understand onboarding timeline and process  
✅ Identify technical point of contact for follow-up  
✅ Receive or schedule delivery of API documentation  
✅ Establish next steps and owners

**Should Achieve:**
✅ Review API data model and endpoints  
✅ Discuss K-12-specific integration requirements  
✅ Understand authentication and security requirements  
✅ Get access to sandbox environment  
✅ Identify any legal/compliance blockers

**Nice to Achieve:**
✅ Live demo of RDS API in action  
✅ Review integration architecture diagrams  
✅ Meet support team members  
✅ Tour of RDS system backend (if on-site)  
✅ Introduction to other integration partners for reference

---

## Post-Meeting Deliverable

**Create a follow-up document:**
- Meeting attendees and roles
- Answers to all priority questions
- Identified blockers and mitigation plans
- Technical specifications received
- Agreed-upon next steps with owners and deadlines
- Updated integration architecture diagram (if changes required)
- Risk assessment and mitigation plan
- Revised project timeline

**Share with stakeholders:**
- K-12 System development team
- NCSEAA K-12 program managers
- Legal/compliance team
- Executive sponsors

---

## Contact Information Template

**To be filled in during/after meeting:**

| Role | Name | Email | Phone | Notes |
|------|------|-------|-------|-------|
| RDS Product Owner | | | | Decision maker for integrations |
| RDS Technical Lead | | | | API and architecture expert |
| RDS DevOps/Infrastructure | | | | Sandbox access, credentials |
| RDS Support Lead | | | | Ongoing support escalations |
| Legal/Compliance Contact | | | | MOU and data sharing agreements |

---

## Appendix: Technical Terms to Clarify

If RDS team uses any of these terms, ask for clarification:
- **"The System"** - Which system? RDS, MyPortal, or another?
- **"Partner integrations"** - Which partners? Higher-ed only or K-12 too?
- **"Real-time"** - Sub-second? Minutes? Hours?
- **"API"** - REST, SOAP, GraphQL, or something else?
- **"Authentication"** - OAuth, API keys, SAML, certificates?
- **"Determination"** - Automated or manual review?
- **"Sandbox"** - Full-featured or limited subset?
- **"SLA"** - Formal contractual SLA or informal target?

---

**Remember:** This meeting is about **discovery and partnership**, not interrogation. Approach with collaborative mindset, acknowledge RDS team's expertise, and frame K-12 integration as mutual benefit opportunity.

**Good luck!** 🚀
