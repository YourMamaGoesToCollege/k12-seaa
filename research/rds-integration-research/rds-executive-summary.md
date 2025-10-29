# RDS Research - Executive Summary & Quick Reference

**Purpose:** Quick reference guide for the comprehensive RDS research documentation  
**Last Updated:** 2025-10-15

---

## 📚 Research Documents Overview

### 1. [rds-residency-verification-system.md](./rds-residency-verification-system.md) - Main Research Document
**1,134 lines | 45KB**

Comprehensive technical and business research covering:
- ✅ Business overview and organizational structure (NCSEAA, CFI, CFNC)
- ✅ System architecture analysis (Level 1-11 technical depth)
- ✅ Integration specifications and proposed patterns
- ✅ Hypothetical data models and API endpoints
- ✅ Security, compliance, and state agency coordination
- ✅ Blind spots and critical information gaps
- ✅ Integration roadmap with phases

**Read this if:** You need complete technical and business understanding of RDS

### 2. [rds-meeting-preparation.md](./rds-meeting-preparation.md) - Meeting Guide
**583 lines | 20KB**

Structured preparation for RDS system owners meeting:
- ✅ Meeting agenda (90-120 minutes)
- ✅ 20 priority-ranked questions (🔴 Critical, 🟡 High, 🟢 Medium)
- ✅ 5 detailed integration scenarios
- ✅ Information request checklist
- ✅ Success criteria and follow-up actions
- ✅ Risk mitigation strategies

**Read this if:** You're preparing for or attending the RDS system owners meeting

### 3. [rds-integration-specification.md](./rds-integration-specification.md) - Technical Spec Template
**645 lines | 17KB**

Technical specification template to complete after meeting:
- ⏳ API endpoints and authentication (to be filled in)
- ⏳ Data models and schemas (to be filled in)
- ⏳ Performance SLAs and rate limits (to be filled in)
- ⏳ Error handling and retry strategies (to be filled in)
- ⏳ Security, monitoring, and support details (to be filled in)

**Use this to:** Document actual RDS technical specifications after discovery meeting

---

## 🔑 Key Findings

### What We Know ✅

**RDS Business Purpose:**
- Centralized residency determination for all NC higher education institutions
- Operated by NCSEAA in partnership with College Foundation, Inc. (CFI)
- Established to ensure consistent residency classifications statewide
- Reusable determination across multiple institutions and aid programs

**Process Workflow:**
1. **Initial Consideration** → Student submits documents, RDS determines resident/non-resident
2. **Reconsideration** → Student circumstances change, can request re-evaluation
3. **Appeal** → Formal appeal process overseen by State Education Assistance Authority
4. **Reuse** → Once determined, classification applies to all NC institutions

**Statutory Framework:**
- **G.S. 115C-562.3** mandates electronic verification across state agencies:
  - DMV (driver's license validation)
  - DPI (school enrollment records)
  - Department of Revenue (tax filings)
  - DHHS (benefits enrollment)
  - Department of Commerce (employment)
  - State Board of Elections (voter registration)

**K-12 Residency Requirements:**
- 12-month NC domicile requirement
- Documents: NC driver's license, utility bills, bank statements, tax records
- Currently verified via **MyPortal document upload** (not RDS integration)

### What We DON'T Know ❌

**Critical Unknowns:**
- ❌ Does RDS provide an API for third-party integration?
- ❌ Is K-12 scholarship verification in scope for RDS?
- ❌ What authentication method is used? (OAuth, API keys, SAML?)
- ❌ Real-time vs. batch processing capabilities?
- ❌ Webhook/callback support for status notifications?
- ❌ Performance SLAs (response time, availability)?
- ❌ Integration onboarding timeline?
- ❌ Cost structure (if any) for API access?
- ❌ Support model and SLAs?

**Architectural Uncertainty:**
- May be **web portal only** (no programmatic API)
- May be **higher-ed focused** (K-12 out of scope)
- May require **batch file exchange** instead of real-time API
- May require **net-new development** to support K-12 use cases

---

## 🎯 Critical Questions for Meeting

### Must Answer (🔴 Critical Priority)

1. **Does RDS provide a programmatic API?**
   - If yes → Get documentation, sandbox access, onboarding timeline
   - If no → Discuss roadmap for API development or alternative integration methods

2. **Is RDS designed to support K-12 residency verification?**
   - If yes → Proceed with integration planning
   - If no → Discuss requirements for extending RDS to K-12 programs

3. **What is the integration timeline?**
   - Onboarding process steps?
   - Required approvals (MOU, security review)?
   - Fast-track possibilities?

4. **What authentication mechanism is required?**
   - OAuth 2.0, API keys, mTLS, SAML?
   - Credential issuance and rotation process?

5. **Real-time API calls or batch processing only?**
   - Response time for determinations?
   - Webhook support for async notifications?

---

## 🚨 Blind Spots & Risks

### 🔴 HIGH RISK

**No Public API Documentation**
- **Impact:** Cannot plan integration architecture with certainty
- **Mitigation:** 
  - Prepare for multiple scenarios (API, batch, manual)
  - Build fallback manual verification in MyPortal
  - Advocate for API development if needed

**K-12 Scope Unclear**
- **Impact:** RDS may be higher-ed only, requiring alternative verification
- **Mitigation:**
  - Establish executive sponsorship for K-12 integration
  - Demonstrate business value (30K+ Opportunity Scholarship students)
  - Explore alternative state agency APIs (DMV, DPI directly)

**Integration Timeline Unknown**
- **Impact:** K-12 system launch may be delayed
- **Mitigation:**
  - Implement interim manual verification workflow
  - Negotiate fast-track onboarding
  - Phased rollout (pilot with 10% of applications)

### 🟡 MEDIUM RISK

**Dual System Architecture (MyPortal + RDS)**
- **Impact:** Data duplication, conflicting determinations
- **Mitigation:**
  - Define authoritative source of truth
  - Implement data reconciliation process
  - Clear user communication about verification method

**Performance Unknown**
- **Impact:** May not support real-time user experience
- **Mitigation:**
  - Design async workflow (notify parent when determination complete)
  - Aggressive caching strategy
  - Optimistic eligibility (assume resident, verify later)

---

## 📋 Pre-Meeting Checklist

### For K-12 Team
- [ ] Review all three RDS research documents
- [ ] Prepare K-12 system architecture diagrams
- [ ] Identify must-have vs. nice-to-have integration features
- [ ] Gather volume estimates (applications per year, peak periods)
- [ ] Prepare timeline constraints (when integration must be live)
- [ ] Identify legal/compliance contacts for MOU discussions

### Information to Request
- [ ] API documentation (OpenAPI/Swagger)
- [ ] Data model schemas (JSON/XML)
- [ ] Sandbox environment access
- [ ] Technical contact information
- [ ] MOU/data sharing agreement template
- [ ] Security review checklist
- [ ] Integration onboarding guide

---

## 🎬 Next Steps

### Immediate (This Week)
1. **Schedule discovery meeting** with RDS system owners
2. **Review** comprehensive research documents with K-12 team
3. **Prepare** architecture diagrams showing proposed integration
4. **Identify** stakeholders and decision-makers

### Short-Term (Weeks 1-4)
1. **Conduct** RDS discovery meeting
2. **Receive** API documentation and technical specifications
3. **Complete** integration specification template
4. **Initiate** MOU/legal agreement process (if required)

### Medium-Term (Weeks 5-16)
1. **Build** proof-of-concept integration
2. **Develop** RDS Adapter microservice
3. **Implement** caching and circuit breaker patterns
4. **Test** in sandbox environment

### Long-Term (Weeks 17-28)
1. **Conduct** integration and load testing
2. **Complete** security review
3. **Execute** UAT with NCSEAA staff
4. **Deploy** to production (phased rollout)

---

## 📞 Next Action Required

**🎯 PRIMARY ACTION:** Schedule meeting with RDS system owners (NCSEAA/CFI)

**Meeting Request Email Template:**

```
Subject: Request for Technical Discovery Meeting - K-12 System Integration with RDS

Dear [RDS Technical Lead],

I am the architect for the K-12 SEAA software system currently under development 
for the Opportunity Scholarship and ESA+ programs. We are exploring integration 
with the NC Residency Determination Service (RDS) for residency verification.

I have conducted preliminary research on RDS and prepared a comprehensive list 
of technical questions. I would like to schedule a 90-120 minute technical 
discovery meeting to discuss:

1. RDS API capabilities and integration options
2. K-12 program support and scope
3. Authentication, security, and compliance requirements
4. Integration timeline and onboarding process

Could we schedule a meeting in the next 1-2 weeks? I can provide an agenda 
and question list in advance.

Thank you,
[Your Name]
K-12 System Architect
```

---

## 📚 Related Documents

**In this repository:**
- [research/ddd-1.md](./ddd-1.md) - References RDS in bounded context model
- [research/full-domain.md](./full-domain.md) - Third-party systems section includes RDS
- [stakeholder-decision/diagrams/dependency-map.md](../stakeholder-decision/diagrams/dependency-map.md) - State agency dependencies

**External references:**
- **RDS Homepage:** https://www.ncresidency.org/
- **RDS Process Guide:** https://www.ncresidency.org/residency-process/
- **NCSEAA K-12:** https://k12.ncseaa.edu/residency/
- **NC Statute G.S. 115C-562.3:** https://www.ncleg.gov/EnactedLegislation/Statutes/HTML/BySection/Chapter_115C/GS_115C-562.3.html

---

## 💡 Quick Tips

**When meeting with RDS team:**
- ✅ Approach as collaborative partnership, not interrogation
- ✅ Frame K-12 integration as mutual benefit (expands RDS scope)
- ✅ Acknowledge RDS team's expertise
- ✅ Be prepared for "no API available" scenario
- ✅ Offer resources/co-funding if helpful to accelerate integration

**When discussing with K-12 stakeholders:**
- ✅ Set expectation that RDS integration is uncertain
- ✅ Present fallback options (manual verification in MyPortal)
- ✅ Emphasize strategic value of RDS integration (consistency, audit trail)
- ✅ Be transparent about risks and timelines

**Technical implementation:**
- ✅ Design for resilience (circuit breaker, retry logic, caching)
- ✅ Build adapter pattern to isolate RDS integration
- ✅ Implement graceful degradation (fallback to manual verification)
- ✅ Plan for eventual consistency (async workflows)

---

## ✅ Research Completion Status

- [x] Web research on NC RDS system
- [x] Web research on CFI/CFNC organization
- [x] Web research on K-12 statutory requirements
- [x] Web research on NC state IT standards
- [x] Business overview documentation
- [x] Technical architecture analysis (Level 1-11)
- [x] Integration patterns and specifications
- [x] Data models and API endpoints (hypothetical)
- [x] Security and compliance requirements
- [x] Meeting preparation guide
- [x] Technical specification template
- [x] Blind spots and risk analysis
- [x] Executive summary and quick reference

**Status:** ✅ RESEARCH COMPLETE - Ready for discovery meeting

---

**Document Version:** 1.0  
**Last Updated:** 2025-10-15  
**Next Review:** After RDS system owners meeting
