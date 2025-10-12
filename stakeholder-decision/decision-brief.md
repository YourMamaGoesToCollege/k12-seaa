# IT Stakeholder Decision Brief
## SEAA K-12 Modernization: Enrollment Builder Strategic Decision

**Date:** October 2025  
**For:** IT Stakeholder Meeting (Tuesday)  
**Prepared by:** Technical Architecture Team  
**Distribution:** Senior IT Leadership & Business Stakeholders

---

## Executive Summary

The SEAA K-12 modernization project faces a critical architectural decision regarding the custom Enrollment Builder component. After one year of development effort on the Angular/.NET platform, the project has allocated over 50% of engineering resources to building a dynamic form builder that allows CFI administrators to configure application forms without developer intervention.

**The Decision Required:**
- **Option A:** Continue Enrollment Builder development and complete it for Phase 1 delivery (~10 additional weeks)
- **Option B:** Retire/postpone Enrollment Builder to Phase 2; redirect resources to core K-12 workflows using Angular reactive forms

**Our Recommendation:** **Option B** – Retire the Enrollment Builder from Phase 1 scope and focus all resources on delivering production-ready core K-12 application workflows using Angular's native reactive forms.

**Rationale:** The Enrollment Builder lacks critical architectural components (state machine, data mapping layer), consumes disproportionate resources, and creates unacceptable data integrity risks. Core scholarship workflows (ESA+, Opportunity Scholarship) and cross-cutting infrastructure remain incomplete. **Critical constraint: All functionality must be complete by May 1, 2026. Option A cannot meet this hard deadline.**

---

## Background & Context

### Platform Overview
College Foundation, Inc. (CFI) manages North Carolina's K-12 scholarship programs (ESA+ and Opportunity Scholarship) serving up to 80,000 concurrent users. The current legacy system experiences scalability failures and requires immediate modernization.

The new platform consists of:
- **Four Angular Web Applications:** Household Portal, School Portal, Provider Portal, Admin Portal
- **Backend Services:** .NET APIs, SQL Server, Azure APIM
- **Target Users:** Parents/guardians, students, school administrators, service providers, CFI staff

**Critical Timeline Constraint:**
- **May 1, 2026:** All core functionality must be complete and production ready
- **Post-May 1, 2026:** Support and maintenance only - no new feature development

### The Enrollment Builder Promise
The Enrollment Builder was conceived to allow non-technical CFI administrators to:
- Design and modify application forms through a visual interface
- Add/remove form fields dynamically
- Update validation rules without code deployment
- Adapt forms to changing program requirements (annual legislative updates)

### Current State Assessment

**Development Progress:**
- 12 months of active development
- ~50%+ of total engineering capacity allocated
- Component exists in pre-production state
- Not integrated with core workflows
- No production testing completed

**Technical Gaps Identified:**

1. **Missing State Machine Architecture**
   - No XState or formal state management implementation
   - Workflow logic embedded in ad-hoc component code
   - Brittle transition handling between application steps
   - Difficult to audit or validate compliance requirements

2. **Data Integrity Risk**
   - Dynamic form data cannot be reliably mapped to static SQL Server schema
   - No real-time data mapper built or designed
   - Risk of data loss or corruption during form field changes
   - Cannot guarantee consistency for audit/compliance requirements

3. **Limited Business Value vs. Cost**
   - Angular reactive forms provide robust, type-safe form handling
   - Form changes still require QA and regulatory review regardless of tool
   - Annual program updates are scheduled, not ad-hoc
   - Developer involvement reduced but not eliminated (schema changes still required)

4. **Incomplete Feature Set**
   - Advanced validation logic (eligibility rules, income calculations) not supported
   - Cross-field dependencies difficult to configure
   - Multi-step workflow orchestration incomplete
   - Document upload integration not finalized

**Effort to Complete:** Estimated 10 additional weeks of focused development, plus 4-6 weeks of integration testing and defect resolution. **Total: 14-16 weeks of critical path work.**

**Impact on Hard Deadline:** This timeline makes the May 1, 2026 deadline **impossible to achieve**. Core functionality would not be complete until early summer 2026 at the earliest, missing the required deadline by several months.

---

## Option Analysis

### Option A: Continue Enrollment Builder Development

**What Remains:**
1. Implement state machine architecture (XState integration) – 3 weeks
2. Build data mapping layer (dynamic to relational) – 4 weeks
3. Complete validation framework – 2 weeks
4. Integrate with workflow engine and APIs – 2 weeks
5. End-to-end testing and defect resolution – 6 weeks
6. Production hardening and documentation – 2 weeks

**Total Effort:** 19 weeks (includes testing buffer)

**Risks:**
- **CRITICAL: Misses Hard Deadline:** Cannot complete by end of April 2026 - would push to late summer 2026 or beyond, missing May early adopter access and June client turnover entirely
- **Technical Debt:** Data mapping layer is complex, high-risk architectural component
- **Resource Constraint:** Core workflows remain blocked or under-resourced
- **Scope Creep:** Additional feature requests likely during development/testing
- **Data Integrity:** Schema migration strategy for existing applications unclear
- **Opportunity Cost:** Cross-cutting services (Communications, Rules Engine, Security) remain incomplete
- **Contract Risk:** Missing June turnover date may have contractual and financial penalties

**Benefits:**
- Delivers on original promise to business stakeholders
- Potential long-term operational efficiency (if successful)
- Reduces developer involvement for minor form changes

**Cost Impact:**
- **Engineering:** ~1,900 hours (2.5 FTE for 4 months)
- **QA/Testing:** ~600 hours
- **Total Cost:** $180,000 - $240,000 (estimated)
- **Delayed Value:** Core application functionality delayed 4-5 months
- **CRITICAL: Misses Hard Deadline:** Cannot meet May 1, 2026 requirement

### Option B: Retire Enrollment Builder from Phase 1

**Approach:**
1. Archive Enrollment Builder codebase as Phase 2 candidate
2. Implement ESA+ and Opportunity Scholarship applications using Angular reactive forms
3. Redirect engineering resources to core workflows and cross-cutting services
4. Re-evaluate Enrollment Builder in Phase 2 with lessons learned

**Immediate Work (Next 24 Weeks):**

**Core K-12 Application Workflows (8 weeks):**
- ESA+ New Student Application (reactive forms) – 2 weeks
- Opportunity Scholarship Application (reactive forms) – 2 weeks
- Renewal workflows (both programs) – 1 week
- Income verification workflow – 1 week
- Eligibility determination submission – 1 week
- Document Upload integration – 1 week

**Cross-Cutting Infrastructure (8 weeks):**
- Communication Center (email templates, scheduling, triggers) – 2 weeks
- Messaging Center (in-app notifications, banner, modal, inbox) – 2 weeks
- Rules Engine integration (eligibility, financial calculations) – 2 weeks
- Microsoft Entra Security (roles, permissions, RBAC) – 1 week
- Document Management (PandaDoc integration, scanning) – 1 week

**Parallel Testing & Integration (ongoing):**
- End-to-end workflow testing – 4 weeks
- Performance/load testing (80K concurrent users) – 2 weeks
- User acceptance testing – 4 weeks
- Security testing and remediation – 2 weeks

**Risks:**
- **Political/Stakeholder:** Must communicate change rationally to business leaders
- **Perception:** May appear as project failure or reversal
- **Future Commitment:** No guarantee Enrollment Builder returns in Phase 2

**Benefits:**
- **CRITICAL: Meets Hard Deadline:** Only viable path to complete all functionality by May 1, 2026
- **Reduced Complexity:** Proven Angular patterns, lower technical risk
- **Better Testing:** More time for quality assurance and user acceptance testing
- **Complete Features:** All core workflows operational and hardened
- **Data Integrity:** Static forms map directly to static schema (no mapping layer required)
- **Team Focus:** Engineering resources concentrated on high-value features
- **Contract Compliance:** Meets deadline commitments without delay or penalties

**Cost Impact:**
- **Engineering:** Redirected capacity (no new cost)
- **Form Maintenance:** Developer time for annual updates (~40 hours/year estimated)
- **Total Savings:** $180,000 - $240,000 in Phase 1
- **Accelerated Value:** Core functionality delivered 4-5 months earlier

---

## Timeline Impact Analysis

### Current State (with Enrollment Builder)
- **October 15, 2025:** Enrollment Builder development continues
- **January 2026:** Enrollment Builder feature-complete (optimistic)
- **March 2026:** Integration testing complete
- **April 2026:** Cross-cutting services integration begins
- **June 2026:** Core workflows completed
- **August 2026:** End-to-end testing
- **September-October 2026:** UAT and defect resolution
- **November-December 2026:** Production deployment (BEST CASE)
- **CRITICAL FAILURE:** Misses May 1, 2026 hard deadline by 6+ months, making project completion impossible within required timeframe

### Recommended Path (without Enrollment Builder)
- **October 15, 2025:** Pivot to reactive forms; begin core workflow development
- **November 2025:** ESA+ and OS application forms complete
- **December 2025:** Renewal and verification workflows complete
- **December 2025:** Cross-cutting services integrated
- **January-February 2026:** End-to-end testing and performance validation
- **March 2026:** User acceptance testing
- **March 2026:** Security audit and remediation
- **April 2026:** Production hardening and training
- **May 1, 2026:** All core functionality complete ✅
- **Post-May 1, 2026:** Support and maintenance (no new features)
- **Buffer:** Adequate schedule cushion for unforeseen issues while meeting hard deadline

---

## Critical Dependencies & Risk Matrix

### Critical Path Items (Option A - Continue Builder)
1. **Enrollment Builder State Machine:** Blocks all form workflow testing
2. **Data Mapping Layer:** Blocks production data integrity validation
3. **Validation Framework:** Blocks compliance/audit readiness
4. **API Integration:** Blocks backend service development
5. **Cross-Cutting Services:** Delayed until Enrollment Builder complete

**Risk Level:** **HIGH** – Multiple critical-path dependencies create schedule fragility

### Critical Path Items (Option B - Retire Builder)
1. **Reactive Forms Development:** Well-understood Angular pattern
2. **API Endpoints:** Parallel development possible
3. **Cross-Cutting Services:** Immediate focus, no blockers
4. **Data Schema:** Static, well-defined, compliant with DDD model
5. **Testing:** Earlier start, more iterations possible

**Risk Level:** **MEDIUM-LOW** – Fewer dependencies, proven technology stack

### Risk Comparison Matrix

| Risk Category | Option A (Continue) | Option B (Retire) |
|--------------|---------------------|-------------------|
| **Schedule Overrun** | HIGH (75% probability) | LOW (25% probability) |
| **Technical Complexity** | HIGH (unproven architecture) | LOW (proven patterns) |
| **Data Integrity** | HIGH (mapping layer risk) | LOW (direct schema mapping) |
| **Resource Availability** | MEDIUM (over-allocated) | LOW (focused allocation) |
| **Scope Creep** | HIGH (feature expansion likely) | LOW (fixed scope) |
| **Testing Coverage** | MEDIUM (compressed timeline) | HIGH (adequate time) |
| **Business Continuity** | MEDIUM (delayed go-live) | LOW (on-time delivery) |
| **Stakeholder Confidence** | MEDIUM (uncertain outcome) | HIGH (clear deliverables) |

---

## Financial & Effort Summary

### Option A Total Cost
- Development: $180,000 - $240,000
- Delayed delivery cost (opportunity): $500,000+ (estimated business impact)
- **Total Phase 1 Impact:** $680,000 - $740,000

### Option B Total Cost
- Immediate savings: $180,000 - $240,000
- Annual form maintenance: ~$8,000/year (40 hours × $200/hr)
- **Total Phase 1 Impact:** Net savings + earlier value delivery

### 3-Year Total Cost of Ownership
- **Option A:** Higher upfront, potential long-term savings (if successful)
- **Option B:** Lower Phase 1 cost, predictable maintenance, lower risk

**Break-Even Analysis:** Option A requires successful operation for 20+ years with zero major refactoring to achieve cost parity with Option B, assuming all technical risks are mitigated.

---

## Recommendation

**We recommend Option B: Retire the Enrollment Builder from Phase 1.**

### Justification
1. **CRITICAL: Only Viable Path to Meet Hard Deadline:** Option A cannot complete by May 1, 2026. Option B is the only way to meet the required deadline.
2. **Risk Mitigation:** Eliminating the Enrollment Builder removes the highest technical and schedule risk from Phase 1
3. **Quality Assurance:** Provides adequate testing time for mission-critical scholarship workflows
4. **Resource Optimization:** Redirects engineering capacity to incomplete, high-value features
5. **Data Integrity:** Removes architectural risk of dynamic-to-static data mapping failures
6. **Contract Compliance:** Meets turnover commitments without penalties or delays

### Implementation Approach
1. **Immediate (This Week):**
   - Communicate decision to extended team
   - Archive Enrollment Builder codebase with documentation
   - Reassign engineering resources to core workflows

2. **Short Term (Next 30 Days):**
   - Complete ESA+ application using reactive forms
   - Complete Opportunity Scholarship application using reactive forms
   - Begin cross-cutting services integration

3. **Medium Term (60-90 Days):**
   - Complete all renewal and verification workflows
   - Finalize cross-cutting services (Communications, Rules, Security)
   - Begin end-to-end testing

4. **Phase 2 Consideration (Post-May 1, 2026):**
   - Re-evaluate Enrollment Builder with Phase 1 lessons learned
   - Consider alternative solutions (low-code platforms, form-as-a-service)
   - Make data-driven decision based on actual form change frequency

### Success Criteria for Option B
- ✅ Core K-12 workflows operational by December 2025
- ✅ Cross-cutting services integrated by December 2025
- ✅ End-to-end testing complete by February 2026
- ✅ UAT and stakeholder approval by March 2026
- ✅ All core functionality complete by May 1, 2026 (HARD DEADLINE MET)
- ✅ Zero critical data integrity issues
- ✅ Platform supports 80,000+ concurrent users

---

## Next Steps

1. **IT Stakeholder Decision (Tuesday Meeting):**
   - Present this analysis
   - Facilitate discussion of options
   - Request formal decision from leadership

2. **If Option B Approved:**
   - Execute communication plan (internal team, CFI leadership, NC SEAA)
   - Update project plan and timeline
   - Reassign resources and update sprint planning
   - Schedule Phase 2 roadmap discussion (post-May 1, 2026)

3. **If Option A Approved:**
   - **CRITICAL:** Acknowledge that May 1, 2026 hard deadline CANNOT be met
   - Communicate to stakeholders revised timeline (fall 2026 or later)
   - Assess contractual and financial penalties for missing deadlines
   - Implement enhanced project oversight and milestone gates

---

## Appendix: References

- **Domain-Driven Design Documentation:** `/research/full-domain.md`
- **C4 Architecture Diagrams:** `/research/ddd-1.md`
- **Aggregate and Entity Models:** `/research/aggregate-details-enhancement.md`
- **ESA+ and OS Domain Analysis:** `/research/ddd-2.md`
- **Statutory and Compliance Requirements:** See references in full-domain.md

---

**Document Control:**
- Version: 1.0
- Last Updated: October 2025
- Contact: Technical Architecture Team
- Classification: Internal - Leadership Distribution
