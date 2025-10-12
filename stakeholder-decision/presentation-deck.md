# IT Stakeholder Presentation
## SEAA K-12 Modernization: Enrollment Builder Strategic Decision

**Presentation Date:** Tuesday, March 2025  
**Audience:** Senior IT Leadership & Business Stakeholders  
**Duration:** 45 minutes (30 min presentation + 15 min Q&A)

---

## Slide 1: Title Slide

**SEAA K-12 Modernization**  
**Enrollment Builder: Strategic Decision Required**

IT Stakeholder Decision Meeting  
March 2025

College Foundation, Inc.  
North Carolina SEAA Programs

---

## Slide 2: Agenda

1. **Executive Summary** – The decision before us
2. **Background & Context** – Platform overview and current state
3. **The Enrollment Builder Challenge** – What we built and what's missing
4. **Option A: Continue Development** – Complete the Enrollment Builder
5. **Option B: Strategic Pivot** – Retire from Phase 1, focus on core workflows
6. **Comparative Analysis** – Risk, cost, timeline impacts
7. **Recommendation** – Our path forward
8. **Next Steps** – Decision and implementation

---

## Slide 3: Executive Summary

### The Decision

**Should we continue building the custom Enrollment Builder for Phase 1, or pivot to Angular reactive forms?**

**Current Situation:**
- 12 months of development effort
- 50%+ of engineering resources allocated to Enrollment Builder
- Core K-12 workflows remain incomplete
- Cross-cutting infrastructure partially built
- April 2026 delivery target at risk

**Two Options:**
- **A:** Complete Enrollment Builder (10+ weeks) → delayed Phase 1 delivery
- **B:** Retire Enrollment Builder → redirect resources to core workflows → April 2026 target achievable

**Our Recommendation:** **Option B**

---

## Slide 4: Platform Overview

### SEAA K-12 Modernization Scope

**Programs:**
- ESA+ (Education Student Accounts) – students with disabilities
- Opportunity Scholarship – income-qualified families
- **Users:** Up to 80,000 concurrent (legacy system crashes under load)

**Platform Architecture:**
- **Front End:** 4 Angular SPAs (Household, School, Provider, Admin portals)
- **Backend:** .NET APIs, SQL Server, Azure APIM
- **Integrations:** ClassWallet, PandaDocs, State agencies, Payment rails

**Key Features:**
- Application submission and renewal
- Eligibility determination and income verification
- Award calculation and lottery processing
- School certification and parent endorsement
- Payment disbursements and compliance tracking

---

## Slide 5: What is the Enrollment Builder?

### The Vision

**Goal:** Enable CFI administrators to build and modify application forms without developer support

**Capabilities (Planned):**
- Visual form designer interface
- Drag-and-drop field configuration
- Dynamic validation rule creation
- Real-time form publishing
- Self-service form management

**Business Value (Expected):**
- Reduce developer dependency for form changes
- Adapt quickly to legislative/program updates
- Lower long-term maintenance costs
- Empower business users

**Technology:** Angular components + .NET backend + dynamic data storage

---

## Slide 6: Current State Assessment

### Development Progress (12 Months)

**Completed:**
- ✅ Basic form builder UI (Angular components)
- ✅ Field type library (text, select, date, etc.)
- ✅ Preview/render capability
- ✅ Basic storage mechanism

**In Progress / Incomplete:**
- ⚠️ State machine architecture (workflow logic)
- ⚠️ Data mapping layer (dynamic → SQL Server)
- ⚠️ Advanced validation framework
- ⚠️ Integration with APIs and services
- ⚠️ Production testing and hardening

**Not Started:**
- ❌ Real-time data mapper (critical component)
- ❌ Schema migration tooling
- ❌ End-to-end workflow orchestration
- ❌ Compliance audit trail

**Resource Allocation:** 50%+ of engineering team (6-8 FTEs over 12 months)

---

## Slide 7: Technical Gaps Identified

### Critical Architecture Issues

#### 1. **Missing State Machine**
- **Problem:** No XState or formal workflow engine implemented
- **Impact:** Brittle workflow logic, difficult to audit, compliance risk
- **Effort to Fix:** 3 weeks

#### 2. **Data Integrity Risk**
- **Problem:** Dynamic form data cannot map cleanly to static SQL schema
- **Impact:** Data loss risk, audit trail gaps, regulatory exposure
- **Effort to Fix:** 4 weeks (complex, high-risk component)

#### 3. **Incomplete Validation**
- **Problem:** Advanced rules (eligibility, income calculations) not supported
- **Impact:** Manual workarounds, business logic gaps
- **Effort to Fix:** 2 weeks

#### 4. **Limited Integration**
- **Problem:** Not connected to core APIs, workflows, or services
- **Impact:** Isolated component, no end-to-end testing possible
- **Effort to Fix:** 2 weeks + 6 weeks testing

**Total Effort to Production-Ready:** 14-19 weeks

---

## Slide 8: Business Value vs. Cost Reality

### Anticipated Benefits (If Successful)
- ✅ Reduced developer time for minor form updates
- ✅ Faster response to program changes (in theory)
- ✅ Business user empowerment

### Actual Constraints (Reality Check)
- ❌ Annual program changes are scheduled, not ad-hoc
- ❌ Legislative updates require legal review regardless of tool
- ❌ Form changes still require QA testing and UAT
- ❌ Schema changes still require developer involvement
- ❌ Regulatory compliance review cannot be bypassed
- ❌ Developer time reduced, not eliminated

### Cost-Benefit Analysis
- **Investment:** $180K - $240K (Phase 1) + ongoing maintenance
- **Savings:** ~40 hours/year developer time (estimated)
- **Break-Even:** 20+ years (assumes zero refactoring or technical debt)

**Conclusion:** Limited business value relative to investment and risk

---

## Slide 9: Option A – Continue Enrollment Builder

### Complete Development for Phase 1

**Remaining Work:**
1. Implement state machine (XState) – 3 weeks
2. Build data mapping layer – 4 weeks
3. Complete validation framework – 2 weeks
4. Integrate with APIs and workflows – 2 weeks
5. End-to-end testing – 6 weeks
6. Production hardening – 2 weeks

**Total Timeline:** 19 weeks (~5 months)

**Impact on Phase 1:**
- ✅ Delivers original vision
- ✅ Potential long-term operational efficiency
- ❌ Delays core workflows by 4-5 months
- ❌ Pushes delivery to August-September 2026 (3-4 month slip)
- ❌ Cross-cutting services remain incomplete
- ❌ Compressed testing window (quality risk)
- ❌ Resource over-allocation continues

**Total Cost:** $180K - $240K development + delayed value delivery

---

## Slide 10: Option B – Strategic Pivot

### Retire Enrollment Builder from Phase 1

**Approach:**
1. Archive Enrollment Builder codebase (preserve for Phase 2 evaluation)
2. Implement ESA+ and OS applications using **Angular reactive forms** (proven pattern)
3. Redirect engineering resources to core workflows and cross-cutting services
4. Re-evaluate Enrollment Builder in Phase 2 based on actual operational needs

**Immediate Benefits:**
- ✅ Proven technology (Angular reactive forms used by thousands of apps)
- ✅ Type-safe, well-tested, well-documented
- ✅ Direct schema mapping (no data integrity risk)
- ✅ Faster development (established patterns)
- ✅ Better testing coverage (more time available)
- ✅ Resource reallocation to high-value features

**Timeline to Complete Core Workflows:**
- ESA+ and OS applications: 4 weeks
- Renewal and verification workflows: 3 weeks
- Cross-cutting services: 8 weeks
- End-to-end testing: 4 weeks
- **Total:** 16 weeks (April 2026 target achievable)

**Cost Impact:** Net savings of $180K - $240K in Phase 1

---

## Slide 11: Timeline Comparison

### Current Path (with Enrollment Builder)

```
March 2025          Enrollment Builder development continues
├─ June 2025        Builder feature-complete (optimistic)
├─ August 2025      Integration testing complete
├─ October 2025     Cross-cutting services begin
├─ January 2026     Core workflows completed
├─ March 2026       End-to-end testing
├─ May 2026         UAT and defect resolution
└─ July-Aug 2026    Production deployment (3-4 month slip)
```

**Risk:** High probability of further delays

---

### Recommended Path (without Enrollment Builder)

```
March 2025          Pivot to reactive forms; core workflow development
├─ April 2025       ESA+ and OS forms complete
├─ May 2025         Renewal and verification workflows complete
├─ June 2025        Cross-cutting services integrated
├─ July-Aug 2025    End-to-end testing and performance validation
├─ Sept 2025        User acceptance testing
├─ Oct 2025         Security audit and remediation
├─ Nov-Jan 2026     Production hardening and training
├─ Feb 2026         Soft launch (limited cohort)
└─ April 2026       Full production deployment ✅
```

**Risk:** Low probability of delays; 2-month buffer included

---

## Slide 12: Risk Matrix Comparison

| Risk Category | Option A (Continue) | Option B (Retire) |
|--------------|--------------------:|------------------:|
| **Schedule Overrun** | **HIGH** (75%) | LOW (25%) |
| **Technical Complexity** | **HIGH** | LOW |
| **Data Integrity** | **HIGH** | LOW |
| **Resource Availability** | MEDIUM | LOW |
| **Scope Creep** | **HIGH** | LOW |
| **Testing Coverage** | MEDIUM | **HIGH** |
| **Business Continuity** | MEDIUM | **HIGH** |
| **Stakeholder Confidence** | MEDIUM | **HIGH** |

### Critical Dependencies (Option A)
1. State machine architecture → blocks workflow testing
2. Data mapping layer → blocks data integrity validation
3. Validation framework → blocks compliance readiness
4. API integration → blocks backend services
5. Cross-cutting services → delayed until Builder complete

**Multiple single points of failure**

---

## Slide 13: Cost & Value Analysis

### 3-Year Total Cost of Ownership

#### Option A: Complete Enrollment Builder
- Phase 1 development: **$180K - $240K**
- Delayed delivery opportunity cost: **$500K+** (estimated business impact)
- Maintenance and support: **$50K/year**
- Technical debt remediation: **$100K - $200K** (projected)
- **3-Year Total:** **$980K - $1.39M**

#### Option B: Reactive Forms
- Phase 1 development: **$0** (redirected resources)
- Annual form maintenance: **$8K/year** (40 hours developer time)
- Platform maintenance: **$30K/year** (normal operations)
- **3-Year Total:** **$114K**

**Net Savings (Option B):** **$866K - $1.28M over 3 years**

---

## Slide 14: Cross-Cutting Services at Risk

### Currently Incomplete (Partially Built, Not Integrated)

**If Enrollment Builder continues, these remain delayed:**

1. **Communication Center**
   - Email template engine
   - Scheduled campaigns (deadlines, reminders)
   - Event-triggered notifications
   - **Business Impact:** Manual communications, missed deadlines, user confusion

2. **Messaging Center**
   - In-app notifications (banner, modal, inbox)
   - Task alerts and To-Do orchestration
   - **Business Impact:** Poor user experience, support call volume

3. **Rules Engine**
   - Centralized eligibility calculations
   - Income verification logic
   - Award determination algorithms
   - **Business Impact:** Manual processing, errors, compliance risk

---

4. **Microsoft Entra Security**
   - Role-based access control (RBAC)
   - Permission management across portals
   - Group synchronization
   - **Business Impact:** Security vulnerabilities, audit failures

5. **Document Management**
   - PandaDoc integration
   - PDF upload and storage
   - Virus scanning and validation
   - **Business Impact:** Document processing delays, security risk

6. **Query Builder**
   - Ad-hoc reporting layer (Cube.js)
   - Data access for business users
   - **Business Impact:** Limited operational visibility, manual reporting

**These are mission-critical services** – without them, the platform cannot operate effectively.

---

## Slide 15: Our Recommendation

### **Option B: Retire Enrollment Builder from Phase 1**

**Why This is the Right Decision:**

1. **Risk Mitigation**
   - Eliminates highest technical and schedule risk
   - Removes data integrity exposure
   - Proven technology reduces uncertainty

2. **On-Time Delivery**
   - April 2026 go-live achievable
   - 2-month schedule buffer for unknowns
   - Adequate testing and UAT time

3. **Quality & Stability**
   - More testing time = fewer production defects
   - Static forms = predictable data model
   - Better user acceptance testing

4. **Resource Optimization**
   - Focus on incomplete, high-value features
   - Complete cross-cutting services
   - Better team morale and focus

5. **Business Continuity**
   - Scholarship processing not delayed
   - 80,000 users served on schedule
   - Regulatory compliance maintained

---

## Slide 16: Implementation Roadmap (Option B)

### Phase 1 Execution Plan (March 2025 - April 2026)

**Q2 2025 (March - May):**
- ✅ Pivot to reactive forms (1 week transition)
- ✅ ESA+ application form development (2 weeks)
- ✅ Opportunity Scholarship form development (2 weeks)
- ✅ Renewal workflows (1 week)
- ✅ Income verification workflow (1 week)
- ✅ Eligibility determination submission (1 week)
- ✅ Document upload integration (1 week)

**Q3 2025 (June - August):**
- ✅ Communication Center integration (2 weeks)
- ✅ Messaging Center implementation (2 weeks)
- ✅ Rules Engine integration (2 weeks)
- ✅ Microsoft Entra Security (1 week)
- ✅ Document Management (PandaDoc) (1 week)
- ✅ End-to-end workflow testing (4 weeks)
- ✅ Performance/load testing (2 weeks)

**Q4 2025 (September - November):**
- ✅ User acceptance testing (UAT) (6 weeks)
- ✅ Security audit and penetration testing (3 weeks)
- ✅ Defect resolution and hardening (3 weeks)

**Q1 2026 (December - February):**
- ✅ Production environment setup and validation (3 weeks)
- ✅ Data migration and cutover planning (2 weeks)
- ✅ Staff training and documentation (3 weeks)
- ✅ Soft launch (limited cohort) (4 weeks)

**Q2 2026 (March - April):**
- ✅ Production deployment (April 2026) ✅
- ✅ Post-launch monitoring and support

---

## Slide 17: Phase 2 Considerations

### What Happens to Enrollment Builder?

**Not Abandoned – Re-evaluated**

**Phase 2 Planning (Post-April 2026):**
1. Analyze Phase 1 operational data:
   - How often do forms actually change?
   - What types of changes occur?
   - Is developer involvement truly a bottleneck?

2. Consider alternative solutions:
   - Low-code platforms (OutSystems, Mendix)
   - Form-as-a-Service solutions (Typeform, JotForm Enterprise)
   - Headless CMS with form builders (Contentful, Strapi)
   - Continue with reactive forms (if working well)

3. Make data-driven decision:
   - Actual ROI calculation based on real usage
   - Technical debt assessment from Phase 1
   - Budget and resource availability

**Key Principle:** Validate assumptions before major investment

---

## Slide 18: Stakeholder Communication Plan

### Managing the Message

**Internal Team (This Week):**
- Transparent communication of decision rationale
- Acknowledge hard work on Enrollment Builder
- Emphasize strategic pivot, not failure
- Clear role assignments for reactive forms development

**CFI Leadership (Next Week):**
- Present business case for Option B
- Highlight risk mitigation and on-time delivery
- Address concerns about form maintenance
- Commit to Phase 2 evaluation

**NC SEAA (Following Week):**
- Reassure on April 2026 commitment
- Explain technical decision in business terms
- Preview Phase 1 feature completeness
- Schedule demo of core workflows (May 2025)

**Success Metrics:**
- Team morale and focus improvement
- Stakeholder confidence in revised plan
- No major resistance or pushback

---

## Slide 19: Success Criteria (Option B)

### How We Measure Success

**Delivery Milestones:**
- ✅ Core K-12 workflows operational by **June 2025**
- ✅ Cross-cutting services integrated by **July 2025**
- ✅ End-to-end testing complete by **September 2025**
- ✅ UAT and stakeholder approval by **November 2025**
- ✅ Production launch **April 2026** (on schedule)

**Quality Metrics:**
- ✅ Zero critical data integrity issues in production
- ✅ Platform supports 80,000+ concurrent users (load tested)
- ✅ <2% defect escape rate post-UAT
- ✅ 95%+ user satisfaction in initial surveys
- ✅ 100% regulatory compliance (audit ready)

**Business Outcomes:**
- ✅ ESA+ and OS applications processed without manual intervention
- ✅ Award calculations automated and auditable
- ✅ Payment disbursements on schedule
- ✅ Reduced support call volume (improved UX)
- ✅ Staff productivity gains from workflow automation

---

## Slide 20: Decision Framework

### What We Need from This Meeting

**Required Decision:** Select Option A or Option B

**Decision Criteria:**
1. **Risk Tolerance:** Can we accept 75% probability of schedule overrun (Option A)?
2. **Business Priority:** Is Enrollment Builder more important than on-time delivery?
3. **Resource Reality:** Can we sustain 50%+ allocation to Builder while other features suffer?
4. **Data Integrity:** Are we comfortable with dynamic data mapping risks?
5. **Stakeholder Commitment:** Will leadership support extended timeline (Option A)?

**Recommended Decision Process:**
1. Review analysis and ask clarifying questions (15 min)
2. Discuss concerns and alternatives (10 min)
3. Formal vote or consensus decision (5 min)
4. Document decision and rationale (immediately after meeting)

**Next Steps (Post-Decision):**
- Update project plan and timeline
- Communicate to extended team and stakeholders
- Execute transition (if Option B)
- Establish oversight and checkpoint meetings

---

## Slide 21: Questions & Discussion

**Key Questions to Consider:**

1. **Schedule:** Can we afford a 3-4 month delay to Phase 1 delivery?

2. **Risk:** Are we comfortable with the data integrity risks of Option A?

3. **Value:** Does the Enrollment Builder deliver sufficient ROI to justify the investment?

4. **Resources:** Can we continue allocating 50%+ of engineering to the Builder?

5. **Alternatives:** Should we consider commercial form solutions in Phase 2?

6. **Stakeholders:** How will CFI and NC SEAA react to this decision?

7. **Future:** What if form changes are more frequent than we expect?

**Open Floor for Discussion**

---

## Slide 22: Appendix – Reference Materials

**Available in Repository:**

- **Decision Brief (2-3 pages):** `/stakeholder-decision/decision-brief.md`
- **Domain-Driven Design:** `/research/full-domain.md`
- **C4 Architecture Diagrams:** `/research/ddd-1.md`
- **Aggregate Models:** `/research/aggregate-details-enhancement.md`
- **ESA+ and OS Domain Analysis:** `/research/ddd-2.md`
- **Visual Diagrams:** `/stakeholder-decision/diagrams/`

**Additional Resources:**
- Project timeline (Gantt chart)
- Resource allocation spreadsheet
- Technical architecture documentation
- Risk register

---

## Slide 23: Contact & Follow-Up

**Technical Architecture Team**

**Post-Meeting Deliverables:**
- Decision documentation and rationale
- Updated project plan (within 3 days)
- Stakeholder communication plan (within 1 week)
- Resource reallocation plan (within 1 week)
- First sprint plan under new direction (within 2 weeks)

**Questions or Concerns:**
- Schedule 1:1 meetings with architecture team
- Review supporting documentation in repository
- Escalate to project steering committee if needed

**Thank you for your time and consideration.**

---

# Presentation Notes

## Delivery Guidance

**Tone:** Professional, factual, solution-oriented (not defensive)

**Key Messages to Emphasize:**
1. This is a strategic decision, not a failure
2. Both options are viable; Option B has better risk/reward profile
3. We're recommending the path that best serves the business
4. Enrollment Builder can be revisited in Phase 2 with real data

**Anticipated Objections (and Responses):**

**Objection:** "We promised the Enrollment Builder to stakeholders."
- **Response:** "Yes, and we're committed to it long-term. We're proposing to defer it to Phase 2 based on new information about technical complexity and schedule risk. We'd rather deliver a stable platform on time than an unstable platform late."

**Objection:** "Developers will have to change forms every time regulations change."
- **Response:** "That's true, but regulations change annually on a predictable schedule, and changes still require legal/compliance review regardless of the tool. The developer time is minimal (40 hours/year estimated) compared to the $240K and 4-month delay we're avoiding."

**Objection:** "We've already invested 12 months in the Enrollment Builder."
- **Response:** "Sunk cost. The question is: what's the best path forward from here? We can preserve the Builder code for Phase 2 evaluation, but continuing now creates unacceptable schedule and technical risk."

**Objection:** "Can we do both – finish the Builder AND deliver on time?"
- **Response:** "No. The math doesn't work. We need 19 weeks for the Builder plus 16 weeks for core workflows, and there's only 14 months until April 2026. We don't have 35 weeks of runway, and that assumes zero delays or issues."

**Closing:** "We're confident Option B is the right call. But we're here to support whatever decision leadership makes. What questions can we answer?"

---

# End of Presentation
