# RDS Integration Research & Azure Architecture

**Purpose:** Comprehensive research and documentation for integrating the K-12 SEAA system with the North Carolina Residency Determination Service (RDS), including complete Azure backend architecture.

**Created:** 2025-10-15  
**Related Issue:** #17

---

## Quick Start

**⭐ START HERE:** [`rds-executive-summary.md`](./rds-executive-summary.md)

Quick reference guide with:
- Research documents overview
- Key findings (what we know vs. don't know)
- Critical questions for system owners meeting
- Blind spots, risks, and next steps

---

## Documents in This Folder

### RDS Research Documentation

1. **[rds-executive-summary.md](./rds-executive-summary.md)** (324 lines)
   - Quick reference and executive summary
   - Key findings and critical gaps
   - Pre-meeting checklist
   - Action items

2. **[rds-residency-verification-system.md](./rds-residency-verification-system.md)** (1,134 lines)
   - Comprehensive RDS system research (Level 1-11 technical depth)
   - Business overview and organizational structure
   - System architecture analysis
   - Integration specifications and patterns
   - Data models and API endpoints (hypothetical)
   - Security, compliance, and state agency coordination
   - Blind spots and risk areas
   - Integration roadmap

3. **[rds-meeting-preparation.md](./rds-meeting-preparation.md)** (583 lines)
   - Structured meeting agenda (90-120 minutes)
   - 20 priority-ranked questions (Critical/High/Medium)
   - 5 detailed integration scenarios
   - Information request checklist
   - Success criteria and follow-up actions

4. **[rds-integration-specification.md](./rds-integration-specification.md)** (645 lines)
   - Technical specification template
   - To be completed after RDS discovery meeting
   - API endpoints, authentication, data models
   - Performance SLAs, error handling, security
   - Operations, monitoring, and support

### Azure Architecture Documentation

5. **[azure-architecture.md](./azure-architecture.md)** (1,054 lines)
   - Complete Azure backend architecture
   - 8 Mermaid diagrams covering:
     - High-level system architecture
     - RDS integration components
     - Service layer architecture
     - New residency validation sequence diagram
     - Re-verification sequence diagram
     - Event-driven architecture
     - Security architecture
     - CI/CD pipeline
   - Azure service configurations
   - Cost estimates (~$1,550/month)
   - Deployment patterns and monitoring strategy

---

## Key Findings

### What We Know ✅
- RDS is centralized NC residency determination system (NCSEAA + CFI)
- Governed by G.S. 115C-562.3 (multi-agency electronic verification)
- K-12 currently uses MyPortal document upload (not RDS integration)
- 12-month NC domicile requirement for scholarships

### Critical Unknowns ❌
- No public API documentation found
- K-12 integration capability unknown
- Integration method unclear (API vs. batch vs. manual)
- Authentication mechanism undocumented
- Performance SLAs not published

---

## Next Steps

1. **Review** `rds-executive-summary.md` (5-minute read)
2. **Schedule** discovery meeting with RDS system owners (NCSEAA/CFI)
3. **Use** `rds-meeting-preparation.md` to prepare for meeting
4. **Review** `azure-architecture.md` to understand backend design
5. **After meeting:** Complete `rds-integration-specification.md` template

---

## Azure Architecture Highlights

- **Cloud-Native Design**: Azure PaaS services (.NET Core, SQL Server)
- **Microservices Pattern**: Domain-driven service boundaries
- **Event-Driven**: Azure Event Grid for loose coupling
- **Multi-Layer Caching**: Redis + APIM for performance
- **Circuit Breaker**: Polly library for resilience
- **Security**: Azure AD, Key Vault, Private Link, TDE
- **Observability**: Application Insights + Log Analytics

---

## Related Documentation

- [Main Research Folder](../research/) - Domain-driven design documentation
- [Stakeholder Decision](../stakeholder-decision/) - Implementation planning

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-10-15 | System Architect | Initial RDS research and Azure architecture documentation |
