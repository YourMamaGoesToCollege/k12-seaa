# Optimized Prompt — Legal-Argument Style Proposal Brief

Copy/paste the prompt below into your AI assistant. It is tuned to produce a concise, legal-argument style proposal brief grounded in this repository’s facts, advocating to pause the Enrollment Builder and pivot to core features, cross-cutting concerns, data migration, and an operational database.

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
- Core cross‑cutting concerns: authn/z, auditing, notifications, comms pipelines, error/incident mgmt, observability, performance budgets, data governance/lineage
