# Research Technology Roadmap Decision Prompt

## Purpose

This file contains an "initial prompt" you can give to a large language model (or reuse as a human-facing brief) that instructs the model to read and use the repository contents (research documents, presentation, requirements, and attachments) to produce a practical, delivery-focused technology roadmap aligned to our project constraints and milestones (notably the May 1, 2026 production target).

## How to use

- Copy the text in the INITIAL_PROMPT block and pass it (with repository files attached or accessible) to the LLM.
- Optionally add extra constraints such as team capacity (FTEs), sprint length, or risk tolerances.
- The prompt asks for artifacts that can be mapped directly to Jira epics, stories, tasks, and acceptance criteria.

## INITIAL_PROMPT

```prompt
You are an expert technical program manager and system architect. Use the full contents of the provided repository (research docs, presentation deck, requirements PDFs, domain model, and the files in this workspace) as authoritative context. Produce a technology roadmap and a prioritized delivery plan that aligns product and engineering work to a hard production target of May 1, 2026.

Output required (produce all sections):
1) Executive summary: 3–5 sentences describing the recommended delivery approach and highest risks.
2) Goal and scope statement: concise definition of what "production-ready" means for May 1, 2026 (features, non-functional targets, scale/load targets, compliance gates).
3) Prioritized work breakdown: list Epics (high level) and for each Epic list 3–8 User Stories (or sub-epics) with short acceptance criteria. Mark each item with priority (P0/P1/P2), owner-type (Platform / Integration / Frontend / Ops), and an estimated size bucket (S/M/L).
4) Timeline & milestones: group Epics into a schedule with milestones and suggested sprint/PI boundaries (assume 2-week sprints unless told otherwise). Show a condensed timeline that ends May 1, 2026 and call out required nightly/weekend delivery windows for integrations or migrations.
5) Cross-cutting services priority: identity & access, document/e-sign, communications/messaging, rules engine, reporting, observability — specify minimal viable implementations and hardening steps (security, auditability, performance).
6) Data & schema plan: recommend an operational schema, migration waves for schools/providers/households/students, rollback strategy, data validation and reconciliation tasks.
7) Integration plan: ClassWallet, PandaDocs, state agency APIs, payment rails — include test harnesses, sandbox requirements, idempotency and reconciliation strategies.
8) Testing & validation: list unit/integration/load/performance tests, target concurrency validation approach (80,000 concurrent users), acceptance gating criteria, and a short performance test plan.
9) Risk register: top 8 risks with mitigation actions and triggers for escalation.
10) Deliverables mapped to Jira: for each Epic include a suggested Epic title, a sample Epic description, and 2–3 sample Story templates (with title, description, acceptance criteria, labels, components, and suggested story points). Also include suggested Jira labels, components, and milestone names.
11) Acceptance gates & go/no-go checklist to present to executives before any major scope increase or reintroducing Enrollment Builder at scale.

Constraints and assumptions:
- Treat program rules (ESA+ and Opportunity Scholarship) and the domain modeling in the repo as the source of truth for business rules.
- Prioritize cross-cutting platform services and a stable operational schema over dynamic form builders during this planning window.
- Assume limited team capacity; call out any assumptions about team size when estimating.

Formatting and verbosity expectations:
- Produce a compact roadmap (1–2 pages) and a more detailed appendix that can be expanded into Jira tickets.
- Provide explicit mapping for at least 5 Epics -> Stories that can be pasted into Jira.

If you need clarifying inputs (team size, sprint length, CI/CD capability), list them as questions and provide a best‑effort plan using reasonable defaults.
```

## Roadmap creation convention, template, and strategy

Below are practical conventions and a template to convert the roadmap into Jira-ready work items.

1. Start with goals & constraints

- Define the production definition (must-have features, non-functional targets such as concurrency, auditability, and compliance items).
- Capture hard dates (May 1, 2026) and immutable non-functional requirements (80k concurrent users, audit trail, payment idempotency).

2. Backwards plan from milestones

- Identify release gates (e.g., Schema locked, Integrations validated, Load-tested, Observability in place).
- Work backwards to derive the set of Epics and an order of execution.

3. Prioritize by risk and dependency

- High dependency and high-risk items (schema, integrations, identity, payments) should be P0 and scheduled earliest.

4. Use a 3-tier sizing and priority system

- Priority: P0 (must before gate), P1 (important), P2 (nice-to-have).
- Size: S (1–2 sprints), M (3–6 sprints), L (6+ sprints). Adjust to your team's cadence.

5. Convert Epics into Jira artifacts

- Epic: high-level theme (e.g., "Operational Schema & Migration").
- Stories: deliverable chunks with clear acceptance criteria (Given/When/Then) and story points.
- Tasks/Subtasks: implementation detail items (API endpoints, DB migrations, infra as code, runbook updates).

6. Continuous validation gates

- For each Epic, define an automated test/validation that must pass (unit tests, integration tests with test doubles, contract tests, load tests with defined pass/fail thresholds).

## Roadmap template (example)

- Milestone: Schema locked (Target date: 2025-12-01)

  - Epic: Operational Schema & Migration (P0, Size L)
    - Story: Define canonical Student/Household/School schemas (P0, S)
      - Acceptance: Schema documented, backward/forward compatibility rules defined, migration plan drafted.
    - Story: Build migration runner and validation tool (P0, M)
      - Acceptance: Tool runs in sandbox and validates sample datasets, supports rollbacks.

- Milestone: Cross-cutting services available (Target date: 2026-02-01)

  - Epic: Identity & Access (P0, M)
  - Epic: Document & e-sign integration (P0, M)

- Milestone: Integration & load validation (Target date: 2026-04-01)
  - Epic: Payments & ClassWallet hardening (P0, M)
  - Epic: State agency integrations (P0, M)

## Jira ticket examples (paste-ready)

Epic template

- Summary: [Epic] Operational Schema & Migration
- Description: Establish the production operational schema for Student, Household, School, and Provider; produce migration waves with validation and rollback; lock schema before downstream feature development.
- Acceptance Criteria: Schema documents in repo; migration tool with dry-run and rollback; automated validation checks; migration runbook.
- Labels: program:k12, milestone:schema-locked, priority:P0

Story template

- Summary: [Story] Document canonical Student schema and invariants
- Description: As a platform engineer, I need a canonical Student schema so that downstream services have a stable contract.
- Acceptance Criteria:
  - Given the schema document exists, when a developer implements Student APIs, then they can validate against the spec.
  - Schema includes required fields, types, constraints, and domain invariants.
- Story Points: 3
- Components: backend, data-model, api

Task template

- Summary: Add DB migration to create Student table v1
- Description: Implement DB migration and data migration runner; include unit tests and rollback steps.
- Acceptance Criteria: Migration applies in test environment and is reversible.

Suggested labels and components

- Labels: program:k12, program:esa, program:os, milestone:may-1-2026, priority:P0, risk:high
- Components: frontend, backend, data-model, integration:classwallet, integration:pandadocs, infra, observability

## Acceptance gates / Go-NoGo checklist

- Schema locked and migrated for core datasets (Schools, Students, Households, Providers)
- Identity & Access implemented and tested in staging
- Payments & ClassWallet integration validated with sandbox, idempotency and reconciliation tested
- Load test: system sustains defined concurrent user target with acceptable latencies
- Observability: metrics, alerts, and runbooks in place

## Notes and next steps

- Use the INITIAL_PROMPT to ask for three roadmap variants: "ambitious" (aggressive, more features), "balanced" (recommended), and "minimal" (only gates). This helps executives choose trade-offs quickly.
- After generating the roadmap, export the suggested Epics/Stories into CSV or use a script to bulk-import into Jira.

---

## Change log

- 2025-10-15: Added initial prompt, roadmap conventions, and Jira templates.
