# K12-SEAA Modernization: Execution Roadmap
## High-Velocity Delivery Plan | Oct 2025 - May 1, 2026

**Timeline:** 7 months (28 weeks)  
**Hard Deadline:** May 1, 2026  
**Team Capacity:** 16 Full-Stack Developers (4 teams × 4 devs), 2 Architects, DevOps Team, 1 DBA  
**Approach:** Startup mode - minimal process, maximum velocity

---

## Executive Summary

This is a **pragmatic, execution-focused roadmap** for delivering the K12-SEAA platform. Four parallel development teams will work concurrently on independent tracks, converging for integration and testing.

**Key Numbers:**
- **110+ features** across 6 major capability areas
- **4 parallel tracks** to maximize throughput
- **6 months of development** + 1 month testing/launch
- **2 scholarship programs:** ESA+ and Opportunity Scholarship
- **4 web portals:** Household, School, Provider, Admin

**Success Factors:**
1. Parallel team execution minimizes dependencies
2. Vertical slice delivery enables continuous integration
3. Pragmatic prioritization focuses on MVP features
4. Architects unblock teams and manage integration points
5. Weekly sync meetings (not daily standups)

---

## Team Structure & Allocation

### Team Alpha (4 Full-Stack Devs)
**Focus:** Household Portal & Applications  
**Primary Responsibility:** Family-facing features (ESA+, OS applications, renewals)

### Team Bravo (4 Full-Stack Devs)
**Focus:** Admin Portal & Operations  
**Primary Responsibility:** Internal workflows (processing, verification, awards, reporting)

### Team Charlie (4 Full-Stack Devs)
**Focus:** School & Provider Portals  
**Primary Responsibility:** School and provider-facing features (enrollment, certification, payments)

### Team Delta (4 Full-Stack Devs)
**Focus:** Financial & Payment Systems  
**Primary Responsibility:** Payment processing, ClassWallet, reconciliation, compliance

### Architects (2)
**Role:** Design decisions, technical unblocking, integration architecture, code reviews  
**Allocation:** Float across teams as needed

### DevOps Team
**Role:** CI/CD, infrastructure, monitoring, deployments  
**Work Mode:** Support all teams, establish automation early

### DBA (1)
**Role:** Database schema design, migrations, performance optimization  
**Work Mode:** Embed with teams during schema design phases

---

## Initiative Roadmap (7 Months)

### Initiative 1: Core Platform Foundation
**Months 1-2 (Oct-Nov 2025)**  
**Goal:** Establish technical foundation and core workflows

**Deliverables:**
- Authentication and authorization (Microsoft Entra)
- Database schema (all core entities)
- Base Angular application structure (4 portals)
- Base .NET API structure (RESTful services)
- CI/CD pipelines operational
- Development and staging environments live

**Success Metric:** All teams can deploy independently to staging

---

### Initiative 2: Application & Enrollment Workflows
**Months 1-3 (Oct-Dec 2025)**  
**Goal:** Families can apply for ESA+ and Opportunity Scholarship

**Team Alpha Deliverables:**
- ESA+ new application workflow (multi-step form)
- Opportunity Scholarship application workflow
- Income verification module
- Document upload functionality
- Domicile verification
- Application submission and confirmation
- Renewal workflows (simplified)
- Application status tracking

**Critical Dependencies:**
- Document storage service (Azure Blob)
- Email notification service
- Rules engine for eligibility
- Integration with PandaDocs for signatures

**Success Metric:** Complete end-to-end application submission flow

---

### Initiative 3: Admin Processing & Verification
**Months 2-4 (Nov-Jan 2026)**  
**Goal:** SEAA staff can review, verify, and approve applications

**Team Bravo Deliverables:**
- Application review dashboard
- Verification workflows (income, domicile, disability)
- State agency integration framework (DMV, DPI, DOR, DHHS)
- Verification sampling service (4% random selection)
- Award calculation engine
- Award lifecycle management
- Lottery service (for Opportunity Scholarship)
- Communication and case management
- Reporting dashboards (key metrics)

**Critical Dependencies:**
- State agency API integrations (high risk - need early testing)
- Rules engine for award calculations
- Notification service
- Query builder (Cube.js or similar)

**Success Metric:** Application moves from submission to approved award

---

### Initiative 4: School & Provider Operations
**Months 2-4 (Nov-Jan 2026)**  
**Goal:** Schools and providers can manage enrollments and payments

**Team Charlie Deliverables:**
- School registration and profile management
- Student enrollment certification
- Parent endorsement workflows
- School payment tracking dashboard
- Provider directory (public-facing)
- Provider registration and approval
- Invoice submission for providers
- Compliance tracking (testing, financial reviews)

**Critical Dependencies:**
- Integration with DPI (per pupil allocation data)
- Payment processing infrastructure (Team Delta)
- Rules engine for certification/endorsement logic

**Success Metric:** School certifies student, parent endorses, payment flows

---

### Initiative 5: Payment & Financial Systems
**Months 3-4 (Dec-Jan 2026)**  
**Goal:** Automated payment processing and financial compliance

**Team Delta Deliverables:**
- Payment processing infrastructure (ACH generation)
- ClassWallet integration (ESA+ wallet provisioning)
- ESA+ purchase request workflows (on/off marketplace)
- Purchase approval rules engine
- Expense categorization and validation
- Payment reconciliation module
- Rollover calculation (ESA+ $4,500 annual, $30,000 lifetime)
- Minimum spending enforcement ($1,000 threshold)
- Tax reporting (1099-G generation)

**Critical Dependencies:**
- ClassWallet API (vendor dependency - high risk)
- State payment rails (ACH, checks)
- Rules engine for purchase approval
- Financial compliance requirements

**Success Metric:** Payment issued to school/provider, ESA+ funds allocated to ClassWallet

---

### Initiative 6: Cross-Cutting Services
**Months 2-3 (Nov-Dec 2025)**  
**Goal:** Shared services supporting all teams

**Architect-Led with Team Support:**
- Communication Center (email template engine, scheduled campaigns)
- Messaging Center (in-app notifications, To-Do tasks)
- Rules Engine (eligibility, awards, purchase approvals, compliance)
- Document Service (secure storage, virus scanning, lifecycle)
- Query & Reporting Service (Cube.js, custom dashboards)
- Audit & Logging Service (immutable event log)

**Critical Dependencies:**
- Email service (SendGrid or similar)
- Azure Blob Storage
- Rules engine framework (Drools, custom, or similar)

**Success Metric:** All teams consuming shared services

---

### Initiative 7: Testing, UAT & Launch
**Months 5-7 (Feb-Apr 2026)**  
**Goal:** Production-ready system on May 1, 2026

**All Teams Participate:**

**Month 5 (Feb 2026) - Integration Testing:**
- End-to-end workflow testing (all features)
- Integration testing (all external systems)
- Performance testing (80K concurrent users)
- Security testing and penetration testing
- Defect identification and triage

**Month 6 (Mar 2026) - UAT & Refinement:**
- User acceptance testing (SEAA staff, schools, families)
- Defect resolution (prioritized fixes)
- Performance optimization
- User feedback incorporation
- Documentation finalization

**Month 7 (Apr 2026) - Production Prep:**
- Production environment setup and validation
- Data migration from legacy systems
- Staff training (admin portal, workflows)
- Go/no-go decision criteria review
- Final smoke tests
- **Go-Live: May 1, 2026**

**Success Metric:** Zero critical defects, performance SLA met, stakeholder sign-off

---

## Feature Roadmap by Team Track

### Track 1: Household Portal (Team Alpha)
**Priority:** High - Revenue-generating user interface

| Month | Features | Dependencies |
|-------|----------|--------------|
| **Oct** | - Authentication (Entra)<br>- User registration<br>- ESA+ application (Part 1: Student info) | - DevOps (environments)<br>- DBA (schema) |
| **Nov** | - ESA+ application (Part 2: Income, documents)<br>- OS application workflow<br>- Document upload service | - Document storage<br>- Email notifications |
| **Dec** | - Renewal workflows<br>- Application status tracking<br>- Communication preferences | - Rules engine<br>- Messaging center |
| **Jan** | - Household profile management<br>- School selection and transfer<br>- Payment history | - School data (Team Charlie)<br>- Payment data (Team Delta) |
| **Feb-Apr** | - Testing, refinement, production prep | - All integrations complete |

**Key Deliverables (End of Jan):**
- Complete ESA+ application flow
- Complete OS application flow
- Renewal submission
- Application status visibility

---

### Track 2: Admin Portal (Team Bravo)
**Priority:** High - Core operational workflows

| Month | Features | Dependencies |
|-------|----------|--------------|
| **Oct** | - Authentication (Entra)<br>- Admin dashboard (metrics)<br>- Application list/search | - DevOps (environments)<br>- DBA (schema) |
| **Nov** | - Application review workflow<br>- Income verification module<br>- Domicile verification | - State agency integrations<br>- Document service |
| **Dec** | - Verification sampling (4%)<br>- Award calculation engine<br>- Lottery service | - Rules engine<br>- Notification service |
| **Jan** | - Award lifecycle management<br>- Communication/case management<br>- Reporting dashboards | - Query service<br>- All team data |
| **Feb-Apr** | - Testing, refinement, production prep | - All integrations complete |

**Key Deliverables (End of Jan):**
- Review and approve applications
- Verify eligibility (income, domicile, disability)
- Calculate and assign awards
- Run lottery (if needed)
- Generate reports

---

### Track 3: School & Provider Portals (Team Charlie)
**Priority:** Medium - Dependent on applications being submitted

| Month | Features | Dependencies |
|-------|----------|--------------|
| **Oct-Nov** | - Authentication (Entra)<br>- School registration<br>- School profile management | - DevOps (environments)<br>- DBA (schema) |
| **Dec** | - Student enrollment certification<br>- Parent endorsement workflows<br>- School payment dashboard | - Household data (Team Alpha)<br>- Payment data (Team Delta)<br>- Rules engine |
| **Jan** | - Provider registration<br>- Provider directory (public)<br>- Invoice submission | - Payment infrastructure<br>- Document service |
| **Feb-Apr** | - Testing, refinement, production prep | - All integrations complete |

**Key Deliverables (End of Jan):**
- School certifies students
- Parents endorse (select school)
- Schools track payments
- Providers submit invoices

---

### Track 4: Financial Systems (Team Delta)
**Priority:** Critical - Payments must be accurate and compliant

| Month | Features | Dependencies |
|-------|----------|--------------|
| **Oct-Nov** | - Payment infrastructure design<br>- ACH file generation<br>- Payment tracking database | - DevOps (secure environments)<br>- DBA (financial schema)<br>- Compliance requirements |
| **Dec** | - ClassWallet integration (sandbox)<br>- ESA+ purchase workflows<br>- Purchase approval rules | - ClassWallet API access<br>- Rules engine<br>- Document service |
| **Jan** | - Payment reconciliation<br>- Rollover calculation<br>- Tax reporting (1099-G)<br>- Minimum spending | - Award data (Team Bravo)<br>- Expense data<br>- IRS requirements |
| **Feb-Apr** | - Testing, refinement, production prep | - All integrations complete |

**Key Deliverables (End of Jan):**
- ACH payments to schools/providers
- ESA+ wallet provisioning
- Purchase approval workflows
- Financial compliance (rollover, tax, spending)

---

## Critical Dependencies & Integration Points

### Month 1 (Oct 2025) - Foundation Dependencies
**What Must Be Ready:**
1. ✅ Azure infrastructure provisioned (VMs, App Services, SQL, Blob Storage)
2. ✅ Microsoft Entra integration configured (SSO for all portals)
3. ✅ Database schema designed and initial migration scripts ready
4. ✅ CI/CD pipelines operational (GitHub Actions → Azure)
5. ✅ Dev, Staging, Production environments accessible
6. ✅ Base Angular and .NET project templates created

**Blockers if Not Ready:**
- Teams cannot deploy code
- Authentication will not work
- No shared data model

**Owner:** Architects + DevOps + DBA

---

### Month 2 (Nov 2025) - Shared Services Dependencies
**What Must Be Ready:**
1. ✅ Document storage service (Azure Blob, virus scanning)
2. ✅ Email notification service (SendGrid or Azure Communication)
3. ✅ Logging and monitoring (Application Insights)
4. ✅ Initial rules engine framework (even if simple)
5. ✅ PandaDocs integration (for signatures)

**Blockers if Not Ready:**
- Team Alpha cannot complete applications (need document upload)
- Team Bravo cannot send notifications
- Team Delta cannot validate expenses

**Owner:** Architects + DevOps (infrastructure), Teams (implementation)

---

### Month 3 (Dec 2025) - State Agency Integration Dependencies
**What Must Be Ready:**
1. ✅ State agency API connections established (DMV, DPI, DOR, DHHS)
2. ✅ Integration framework with timeout/error handling
3. ✅ Manual fallback workflows defined
4. ✅ Rules engine operational (eligibility, awards, purchase approval)
5. ✅ Messaging center operational (in-app notifications, To-Do tasks)

**Blockers if Not Ready:**
- Team Bravo cannot verify domicile electronically (will slow processing)
- Team Bravo cannot calculate awards accurately
- Team Alpha cannot see application status updates

**Owner:** Architects (framework), Team Bravo (implementation)

**Risk Mitigation:**
- Start state agency coordination **immediately** (legal, MOUs, API access)
- Build manual fallback workflows from day one
- Do NOT wait for agency APIs to be perfect - design for failure

---

### Month 4 (Jan 2026) - Payment Integration Dependencies
**What Must Be Ready:**
1. ✅ ClassWallet API integration complete (sandbox tested, production ready)
2. ✅ ACH payment file generation tested with bank
3. ✅ Payment reconciliation workflows operational
4. ✅ All team data models stable (no more schema changes)

**Blockers if Not Ready:**
- Team Delta cannot provision ESA+ wallets
- Team Delta cannot issue payments to schools
- Financial compliance features will not work

**Owner:** Team Delta + Architects + DBA

**Risk Mitigation:**
- ClassWallet sandbox access **immediately** (vendor dependency - high risk)
- Coordinate with state payment rails early
- Build idempotency into all payment transactions

---

### Month 5-7 (Feb-Apr 2026) - Testing & Launch Dependencies
**What Must Be Ready:**
1. ✅ All features code-complete by end of January
2. ✅ Production environment hardened (security, performance)
3. ✅ Data migration scripts tested and validated
4. ✅ Staff training materials prepared
5. ✅ UAT test plans and scenarios documented
6. ✅ Go/no-go decision criteria agreed upon

**Blockers if Not Ready:**
- Cannot meet May 1 deadline
- Defects will escape to production
- Staff will not know how to use the system

**Owner:** All teams + Architects + DevOps

---

## Concurrent Development Strategy

### How 4 Teams Work in Parallel Without Blocking

**Principle 1: Vertical Slice Ownership**
- Each team owns complete vertical slices (UI → API → DB)
- No handoffs between "frontend team" and "backend team"
- Teams deploy independently to staging

**Principle 2: API-First Contracts**
- Teams agree on API contracts early (week 1 of each feature)
- Mock APIs until real implementation is ready
- Swagger/OpenAPI documentation is source of truth

**Principle 3: Database Schema Coordination**
- DBA designs schema collaboratively with teams (weeks 1-2)
- Schema changes freeze after month 3 (no more breaking changes)
- Migration scripts reviewed by DBA before deployment

**Principle 4: Shared Service as Libraries**
- Cross-cutting services packaged as NuGet packages (backend) or npm packages (frontend)
- Teams consume services via versioned packages
- Architects own shared service contracts

**Principle 5: Integration Points Managed by Architects**
- External integrations (ClassWallet, PandaDocs, state agencies) owned by architects
- Teams consume via abstraction layer (no direct API calls)
- Architects unblock teams on integration issues

---

## Weekly Sync Cadence (Minimal Process)

### Monday Morning Sync (1 hour, all hands)
**Purpose:** Alignment, blockers, dependencies

**Agenda:**
1. Each team: 5-minute update (what shipped last week, what's next, blockers)
2. Architects: Integration point updates, design decisions
3. DevOps: Infrastructure updates, deployment status
4. DBA: Schema changes, performance issues
5. Blockers escalation: Who can unblock what

**Output:** Clear action items, escalations to leadership if needed

**No:**
- No daily standups
- No retrospectives
- No sprint planning ceremonies
- No estimation poker

---

### Friday Afternoon Demo (30 minutes, optional attendance)
**Purpose:** Show working software, celebrate progress

**Format:**
- Any team member can demo what they shipped this week
- No slides, just working software
- Informal, voluntary, high energy

**No:**
- No required attendance
- No status reports
- No formal acceptance criteria review

---

### Async Communication (Slack/Teams)
**Purpose:** Real-time coordination, quick decisions

**Channels:**
- `#team-alpha`, `#team-bravo`, `#team-charlie`, `#team-delta` (team-specific)
- `#architecture` (design decisions, integration questions)
- `#blockers` (anything preventing work)
- `#deployments` (CI/CD notifications)
- `#general` (everything else)

**Response SLA:**
- Blockers: Within 1 hour
- Questions: Within 4 hours (same business day)
- Design discussions: Within 24 hours

---

## Risk Management (Pragmatic)

### Top 5 Risks & Mitigations

**Risk 1: State Agency Integrations Delayed**
- **Probability:** High
- **Impact:** Medium (can use manual fallback)
- **Mitigation:**
  - Start legal/MOU process **this week**
  - Build manual fallback workflows from day one
  - Weekly status calls with agency liaisons
  - Escalate to SEAA leadership if no progress by month 2

**Risk 2: ClassWallet API Issues**
- **Probability:** Medium
- **Impact:** High (ESA+ payments will not work)
- **Mitigation:**
  - Get sandbox access **this week**
  - Test happy path + error scenarios early (month 2)
  - Weekly calls with ClassWallet engineering
  - Escalate to vendor account manager if blocked
  - Have backup plan (manual wallet provisioning if needed)

**Risk 3: Team Member Attrition**
- **Probability:** Medium (7-month project)
- **Impact:** High (knowledge loss, velocity drop)
- **Mitigation:**
  - Cross-train within teams (pair programming)
  - Document architectural decisions (ADRs)
  - Code reviews catch knowledge silos
  - Architects can parachute into any team

**Risk 4: Scope Creep**
- **Probability:** High (stakeholders will ask for "just one more thing")
- **Impact:** High (will miss deadline)
- **Mitigation:**
  - **Hard freeze on new features after month 3**
  - "Phase 2" list for post-launch enhancements
  - Architects and leadership own scope decisions
  - Every new request requires removing something else

**Risk 5: Performance at Scale (80K Users)**
- **Probability:** Medium
- **Impact:** High (system unusable during peak load)
- **Mitigation:**
  - Load testing starts month 3 (before code complete)
  - Performance budgets defined early (page load < 2s)
  - Caching strategy (Redis) implemented by month 3
  - CDN for static assets
  - Database indexing reviewed by DBA monthly

---

## Success Metrics (Weekly Tracking)

### Development Velocity
- **Features shipped per week** (target: 3-5 features across all teams)
- **Code commits per day** (indicator of activity, not quality)
- **Pull requests merged** (target: 20-30 per week across all teams)

### Quality Indicators
- **Critical bugs in production** (target: 0)
- **Critical bugs in staging** (target: < 5 per week)
- **Test coverage** (target: > 70% for core workflows)
- **Security vulnerabilities** (target: 0 high/critical)

### Integration Health
- **API uptime (staging)** (target: > 99%)
- **Build success rate** (target: > 95%)
- **Deployment frequency** (target: daily to staging, weekly to production)

### Team Morale
- **Blocker resolution time** (target: < 1 day)
- **Team velocity trend** (are teams speeding up or slowing down?)
- **Overtime hours** (target: minimal - sustainable pace)

**Tracking Method:** Simple spreadsheet, updated Friday afternoon, reviewed Monday morning

---

## Decision-Making Framework (Fast)

### Level 1: Team Decisions (Immediate)
**Scope:** Implementation details, UI/UX within their portal, local architecture

**Decision Maker:** Team (consensus or senior dev)

**Examples:**
- Component structure in Angular
- API endpoint naming conventions
- Validation logic for forms

**No approval needed**

---

### Level 2: Architecture Decisions (Same Day)
**Scope:** Cross-team impact, shared services, integration patterns, database schema

**Decision Maker:** Architects (after consulting affected teams)

**Examples:**
- API versioning strategy
- Caching approach (Redis vs in-memory)
- State agency integration error handling

**SLA:** Decision within 1 business day

**Documentation:** ADR (Architecture Decision Record) in GitHub

---

### Level 3: Scope Decisions (Same Week)
**Scope:** Adding/removing features, timeline changes, resource allocation

**Decision Maker:** Leadership (CFO, SEAA Director) based on architect/PM recommendation

**Examples:**
- Cut a feature to meet deadline
- Add a feature that's legally required
- Delay a non-critical feature to Phase 2

**SLA:** Decision within 1 week

**Documentation:** Update roadmap document, communicate to all teams

---

## What We're NOT Doing (Startup Mode)

### ❌ No Heavy Agile Ceremonies
- No 2-week sprints with planning, review, retro
- No story points or velocity tracking
- No burndown charts
- No backlog refinement sessions

**Instead:** Ship features when ready, weekly sync for alignment

---

### ❌ No Extensive Documentation
- No detailed requirements documents
- No user story templates with acceptance criteria
- No test plans with 100 test cases per feature

**Instead:** Working software is the documentation, basic ADRs for architecture

---

### ❌ No Process for Process Sake
- No mandatory code reviews (but strongly encouraged)
- No strict commit message formats
- No time tracking or story point estimation

**Instead:** Trust teams to deliver, focus on outcomes not process

---

### ❌ No Premature Optimization
- No micro-service architecture (start with monolith)
- No Kubernetes (use Azure App Services)
- No elaborate caching in month 1

**Instead:** Build for May 1 deadline, optimize in Phase 2 if needed

---

## What We ARE Doing (Essentials Only)

### ✅ Continuous Integration & Deployment
- Every commit to main triggers build
- Automated tests run on every PR
- Deployments to staging daily
- Deployments to production weekly (after month 3)

**Why:** Fast feedback, catch issues early, ship frequently

---

### ✅ Code Reviews (Pragmatic)
- At least one other person reviews code before merge
- Focus on logic errors, security issues, integration concerns
- No nitpicking on style (use automated linting)

**Why:** Knowledge sharing, catch bugs, maintain quality

---

### ✅ Automated Testing (Targeted)
- Unit tests for business logic (rules engine, calculations)
- Integration tests for critical workflows (application → approval → payment)
- End-to-end tests for happy paths (Playwright or similar)

**Why:** Confidence to deploy, prevent regressions, enable fast iteration

---

### ✅ Monitoring & Alerting
- Application Insights for errors and performance
- Alerts for critical failures (e.g., payment processing down)
- Log aggregation for troubleshooting

**Why:** Know when things break, diagnose issues quickly

---

### ✅ Weekly Sync & Demo
- Monday morning alignment (1 hour)
- Friday afternoon demo (30 minutes, optional)

**Why:** Stay aligned, celebrate progress, surface blockers

---

## Phase 2 Parking Lot (Post-Launch)

**These are valuable but NOT in scope for May 1, 2026:**

1. **Mobile App (iOS/Android)**
   - Responsive web is sufficient for launch
   - Mobile app can come later if user demand is high

2. **Advanced Analytics & Data Warehouse**
   - Basic reporting dashboards are sufficient
   - Cube.js or Power BI for deeper analytics can come later

3. **AI/ML Features**
   - Fraud detection
   - Predictive modeling for application approval
   - Chatbot for FAQs

4. **Advanced Workflow Automation**
   - Robotic Process Automation (RPA) for manual tasks
   - Intelligent document processing (OCR for uploads)

5. **Multi-Language Support (Beyond English/Spanish)**
   - English and Spanish are required
   - Other languages can be added based on demand

6. **Integration with Additional State Agencies**
   - Focus on DMV, DPI, DOR, DHHS for launch
   - Other agencies can be added incrementally

**Decision Point:** After 3 months of production operation, reassess Phase 2 priorities based on user feedback and operational data

---

## Conclusion

This roadmap is designed for **velocity and execution**. We have 7 months to deliver a production-ready system serving 80,000 users. The approach is:

1. **Four parallel teams** working on independent tracks
2. **Minimal process overhead** - no heavy Agile ceremonies
3. **Pragmatic architecture** - monolith, proven technology (Angular, .NET, SQL, Azure)
4. **Fast decision-making** - teams empowered, architects unblock, leadership decides scope
5. **Risk management** - identify top risks, mitigate early, escalate blockers
6. **Weekly sync** - align on progress, surface blockers, make decisions
7. **Phase 2 for nice-to-haves** - focus ruthlessly on MVP for May 1

**Success = Production launch on May 1, 2026 with core features working reliably.**

Let's build this. 🚀

---

**Document Owner:** Technical Architects  
**Last Updated:** October 2025  
**Next Review:** Weekly (Monday morning sync)
