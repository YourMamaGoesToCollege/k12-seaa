# Proposal Brief Regarding Project Modality Pivot


## Issue Presented

Pause the Enrollment Builder/Data Mapper and pivot development to deliver core platform features, cross‑cutting services, and an operational schema to meet the May 1, 2026 production target.


## Statement of Facts

- The program has a non-negotiable delivery date of May 1, 2026 and must support peak loads approaching 80,000 concurrent users; this creates an unforgiving schedule and scale requirement for foundational services.
- The current Enrollment Builder proof-of-concept persists form captures into a secondary micro-schema and relies on a Data Mapper to convert that data into the operational schema; stabilization and mapping will consume significant engineering effort.
- Cross-cutting platform services — identity and security, document/e-sign, communications, messaging, rules engine, reporting, and observability — are prerequisites for auditable, production-grade operations and cannot be deferred.
- External integrations (payment/vendor systems and multiple state agency APIs) and partially defined core schemas (schools, households, students) form a fragile critical path that will fail without a stable operational schema and early integration testing.



## Argument

Continuing down the Enrollment Builder/Data Mapper path materially increases the chance of mission failure. The current approach postpones an operational schema, scattering business logic into ad-hoc mapping rules and a chatty UI↔API pattern that will amplify concurrency and contention problems during peak registration. This design trades short-term flexibility for long-term fragility: more PIs to stabilize, more edge cases to reconcile, and a sustained maintenance burden that will divert resources from core delivery. The roadmap’s success metrics—production readiness, auditability, and reliable performance—are best achieved by delivering core platform services first, locking in a stable schema, and then introducing carefully scoped dynamic form capabilities.



## Recommendation and Relief Requested

- Immediately pause all new Enrollment Builder feature work and halt expansion of the Data Mapper effort; only critical stabilization fixes approved by engineering leadership should proceed.
- Stand up a production-grade operational schema now and launch prioritized, repeatable migration waves for Schools, Providers, Households, and Students with automated validation and rollback.
- Re-sequence delivery to make cross‑cutting services the top priority: identity and access controls, secure document and e-sign flows, centralized communications and messaging, a versioned rules engine, reporting, and observability.
- Mandate a formal state‑machine implementation for all workflow orchestration; reject ad-hoc transition patterns in favor of provable, testable state logic.
- Build and run a focused load/performance test program that validates the system at target concurrency before any production traffic window.
- Dedicate PI capacity to harden payments and ClassWallet integration with idempotency, reconciliation, and transaction-level audit trails.
- Limit any Enrollment Builder scope to strictly non-decision metadata capture, backed by aggressive monitoring and automatic alerts.
- Require an executive-level go/no‑go gate before reintroducing EB at scale: migration completeness validated, performance gates passed, and all external integrations proven stable.



## Risks if Not Adopted

- High probability of missing the May 1, 2026 target as stabilization and mapping work consumes schedule and funding.
- Increased risk of production outages or service degradation during peak registration periods caused by the chatty UI↔API model and micro-schema contention.
- Accumulation of systemic technical debt that will require years of remediation and ongoing operational overhead.
- Elevated regulatory and audit exposure due to incomplete document workflows, weak lineage, and insufficient transaction-level auditing.



## Sources

- Internal presentation materials and roadmap documents
- Author testimony and expert observations (used as material input)
