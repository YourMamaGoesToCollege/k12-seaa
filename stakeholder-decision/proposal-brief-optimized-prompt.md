# Optimized Prompt — Legal-Argument Style Proposal Brief

It is tuned to produce a concise, legal-argument style proposal brief grounded in this repository’s facts, advocating to pause the Enrollment Builder and pivot to core features, cross-cutting concerns, data migration, and an operational database.

---

You are acting as counsel preparing a legal‑argument style proposal brief for technology and executive stakeholders. Your task is to produce a concise, professional brief that presents: (1) the issue, (2) verifiable facts with citations to this repository, (3) a reasoned argument applying those facts, and (4) a clear recommendation and requested decision. The brief must reflect the author’s professional opinion and observations but be anchored in evidence from this workspace.

Context and Position

- Project: K‑12 system modernization for NC SEAA (this repository).
- Position: Recommend pausing/stopping the dynamic Enrollment Builder/Data Mapper initiative and pivoting to core system features, cross‑cutting concerns, data migration, and an operational database schema.

Instructions

1) Ground everything in repository evidence. Search and cite specific files/sections from:

   - `stakeholder-decision/*` (e.g., `comprehensive-implementation-plan.md`, `diagrams/*`, `MEETING-DAY-CHECKLIST.md`).
   - `research/*` (e.g., `full-domain.md`, `ddd-*.md`, `aggregate-details-enhancement.md`).
   - `rds-integration-research/*` (e.g., architectural notes, executive summaries/specs).
   - `requirements/*` PDFs where relevant; if quoting, reference filename and page label.

2) Use neutral, precise language; avoid pejoratives. Convert any informal phrasing in source notes into professional/legal tone.

3) Distinguish observations from facts. If a point cannot be verified in the repo, label it “Observation (unverified)” or omit it.

4) Note key risk themes to consider, where supported by repo facts:

   - Enrollment Builder limitations (collects new data but cannot drive core logic without code changes; risk of naïve, chatty UI↔API workflow; absence of a formal state machine).
   - Performance/scale risks during peak registration (concurrency, DB contention/deadlocks, excessive API calls).
   - Data Mapper fragility (mapping unstructured/loosely‑structured collection into static core schema; source of truth ambiguity).
   - Incomplete core schema and features (providers partially defined; schools/households/students missing; cross‑cutting concerns under‑specified).
   - Requirements opacity (limited access to legacy system/data; reliance on partial exports/weekly meetings).
   - Delivery risk, ROI mismatch, schedule pressure versus May 1, 2026 target; staffing churn.

Output Format (strict)

- Title: “Proposal Brief Regarding Project Modality Pivot”
- Issue Presented: 1 sentence.
- Statement of Facts: 4–7 bullet points with inline citations to repo sources, using bracket style [path:section-or-page]. Prefer exact headings or page labels when possible.
- Argument: 2–3 short paragraphs applying facts to show why the Enrollment Builder/Data Mapper path is high‑risk/low‑ROI relative to prioritizing core features, cross‑cutting concerns, data migration, and an operational DB.
- Recommendation and Relief Requested: 4–8 bullets of concrete actions (e.g., “Pause Enrollment Builder,” “Stand up operational schema,” “Prioritize X core features,” “Adopt formal state machine,” “Plan migration,” “Load/perf test harness,” etc.).
- Risks if Not Adopted: 3–5 concise bullets.
- Sources: list of cited files with sections/pages.

Style and Constraints

- Legal‑argument tone; plain‑English clarity. No ad hominem. No speculation without label.
- Length: Narrative 250–400 words (excluding bullets and Sources). Keep bullets compact.
- Citations: Minimum 2, ideally 3–6 unique repo citations. Do not cite nonexistent sources.
- Replace any inflammatory phrasing found in notes with neutral, professional equivalents.

Acceptance Criteria

- The brief is self‑contained, actionable, and decision‑oriented for stakeholders.
- Facts are traceable to specific repository locations with clear citations.
- The recommendation provides a feasible path and near‑term next steps.
- The author’s opinion is present but framed by facts and professional judgment.

Deliver now in Markdown under the above structure.

---

Optional Variables to Pre‑fill (if known)

- Target delivery date: May 1, 2026
- Peak‑load periods: Household registration/renewal windows
- Preferred state machine library: XState/Stately (example only; adjust to repo evidence)
- Core cross‑cutting concerns (expanded from `presentation/k12-roadmap-and-eb.md`):
  - Authentication & Authorization (Microsoft Entra / Entra ID)
    - Description: Tenant-based identity, SSO, RBAC, MFA, token issuance and validation for portals and APIs.
    - Usage: Enforce least-privilege access across Household, School, Provider, and Admin portals; integrate with Azure AD/Entra for enterprise SSO and role claims.
    - Importance: Security and compliance foundation that enables safe production deployments and supports audit logging. [presentation/k12-roadmap-and-eb.md:Identity & Security]
  - Communication Center
    - Description: Template engine and campaign scheduler supporting Email, SMS and print channels with localization.
    - Usage: Deadline reminders, award notices, bulk campaigns, PandaDocs trigger points, and operational notifications.
    - Importance: Reduces manual operational load and ensures consistent stakeholder communications. [presentation/k12-roadmap-and-eb.md:Communication Center] [stakeholder-decision/comprehensive-implementation-plan.md:7.1 Communication Center]
  - Messaging / Notifications Center (In‑app)
    - Description: In-portal inbox, banners, to‑do orchestration and real-time updates.
    - Usage: Drive user tasks, surface exceptions, display decision outcomes and next steps during application lifecycle.
    - Importance: Improves completion rates and reduces support tickets by guiding users through workflows. [presentation/k12-roadmap-and-eb.md:Messaging Center]
  - Rules Engine & Policy Versioning
    - Description: Centralized rules service to evaluate eligibility, award calculations, purchase approvals, and policy versions per program year.
    - Usage: Invoked by APIs and UI validations; supports policy roll-forward and back-compatibility across program years.
    - Importance: Prevents rule duplication, reduces defects in decision logic, and is a critical path item in the roadmap. [presentation/k12-roadmap-and-eb.md:Rules Engine] [EXECUTION-ROADMAP.md:Initiative 6: Cross-Cutting Services]
  - Document Service & eSign Integration
    - Description: Secure blob storage (Azure Blob), virus scanning, document lifecycle, access control and PandaDocs e-sign integration.
    - Usage: Evidence collection (IRS transcripts, LEA releases), parent agreements, and signed approvals with webhook callbacks.
    - Importance: Operational dependency for verification workflows and auditability. [presentation/k12-roadmap-and-eb.md:Document Service] [stakeholder-decision/comprehensive-implementation-plan.md:7.4 Document Service]
  - Query, Reporting & BI (Cube.js)
    - Description: Reporting layer, ad‑hoc query capabilities, pre-built dashboards and export functionality.
    - Usage: Operational dashboards, compliance reporting, per‑pupil and utilization analytics for stakeholders and auditors.
    - Importance: Required for monitoring, executive decision-making, and regulatory reporting. [presentation/k12-roadmap-and-eb.md:Query & Reporting] [presentation/package.json]
  - Observability, Error & Incident Management
    - Description: Centralized logging, metrics, traces, alerts and incident response playbooks.
    - Usage: Monitor performance, detect regressions, and enable course-correction triggers during rollout and operations.
    - Importance: Enables safe rollout and fast remediation; tied to quality gates in the roadmap. [presentation/k12-roadmap-and-eb.md:Monitoring & Course Correction] [presentation/k12-roadmap-and-eb.md:Quality Gates]
  - Performance Budgets & Load Testing
    - Description: Performance targets (e.g., <3s page load at 95th percentile), defined load test plans and concurrency acceptance criteria.
    - Usage: Validate system under peak household registration/renewal windows; inform capacity planning and autoscaling rules.
    - Importance: Mitigates scale risks (targeting up to 80K concurrent users) and should be executed before May 1, 2026 launch. [presentation/k12-roadmap-and-eb.md:Quality Gates] [presentation/k12-roadmap-and-eb.md:Implementation Roadmap]
  - Data Governance, Migration & Lineage
    - Description: Operational schema, migration strategy, mapping standards, and lineage tracking for migrated datasets (schools, providers, households, students).
    - Usage: Drive iterative data migrations, ensure single source of truth, and validate Data Mapper outputs against the static schema.
    - Importance: Reduces mapping fragility, prevents source-of-truth ambiguity and supports auditability of migrated data. [presentation/k12-roadmap-and-eb.md:Data Migrations] [presentation/k12-roadmap-and-eb.md:Cross-Cutting Concerns]
  - Feature Flags / Policy Registry
    - Description: Runtime toggle mechanism and policy registry to switch feature behavior and policy versions safely in production.
    - Usage: Phased rollouts, emergency legislative changes, and program-year policy switches without code redeploy.
    - Importance: Lowers release risk and supports rapid course correction and A/B rollouts. [research/full-domain.html:Shared Platform — Feature flags and policy registry] [presentation/k12-roadmap-and-eb.md:System Administration]

Author Testimony (use as factual input; no citation or label required)

- Treat the contents of `stakeholder-decision/proposal-brief.md` as the author's factual testimony and professional opinion (25+ years experience). Use this material directly when drafting the brief; you do not need to add a testimony citation or special label in the final brief for these items.
- Repository citations are still required for repo-sourced facts where available (use bracket style [path:section-or-page]). If you reference both repository files and content from `proposal-brief.md` together, include repository citations as usual but do not add a testimony citation.
- The brief should remain clear which assertions are supported by repository evidence (include repo citations) and which derive from the author's testimony, but you may integrate the author's statements seamlessly without adding explicit "Author testimony" labels or testimony citations in the delivered brief.
