# K12 System Workflows Matrix

Purpose: catalog and group the primary operational workflows in the K12 system (enrollment, verification, funding, purchasing, provider onboarding, compliance, renewals, finance, and operations). Each workflow entry contains DDD context, where it sits in the K12/school/fiscal year, step-by-step tasks and operations, roles/owners, required communications, decision points, and acceptance criteria. Use this as a source for mapping to epics, stories, runbooks, and automation.

Assumptions

- School year: Typically Aug–Jun; Fiscal year: State-dependent (commonly Jul–Jun). Workflows that depend on fiscal windows should reference payout cycles and budget windows.
- Team roles (example): Parent/Guardian, Student, School Admin (LEA), Caseworker, Program Admin, Finance, Provider, SRE/On‑call, Legal.

Organization and timeline guidance

- Group workflows into three phases: Pre‑Enrollment (planning & outreach), Enrollment & Verification (application, eligibility, domicile), Post‑Award Operations (wallets, purchasing, payments, compliance, renewals).
- For fiscal activities (GL posting, disbursements, year‑end reporting), align to fiscal quarters and month-end close schedules.

---

Workflow group A — Pre‑Enrollment & Outreach

1) Program Outreach & Eligibility Campaigns

- DDD context: Program / Marketing
- Typical timeline: Pre‑school year (May–Aug) + periodic outreach ahead of open enrollment windows
- High level tasks:
  - Prepare eligibility guidance and materials (legal/program team)
  - Publish enrollment window and instructions (Program Admin)
  - Coordinate with LEAs for outreach lists (Data/Integration)
  - Open communication channels (email campaigns, website updates)
- Roles: Program Admin, Legal, Communications, Data Team
- Communications: Broadcast emails, website banners, printable flyers
- Decisions: Open/close enrollment windows; eligibility rule clarifications
- Acceptance criteria:
  - Materials approved by Legal/Program
  - Enrollment window publishing confirmed; communication sent to target audience

Workflow group B — Enrollment & Verification

2) Application Submission & Intake

- DDD context: Application / `Application` aggregate
- Timeline: Open enrollment window (e.g., Aug–Oct) — ongoing intake during open window
- Tasks:
  - Parent submits application (form capture)
  - System validates input (syntactic) and creates `Application` aggregate
  - Auto-assign ToDoItems for required documents based on program rules
  - Send submission receipt & instructions
- Roles: Parent, System (forms), Caseworker
- Communications: Receipt email, in‑app ToDo, follow-up reminders
- Decisions: Accept for review vs incomplete; route to verification or auto-eligible flow
- Acceptance criteria:
  - Application record created and accessible in staff UI
  - Required ToDoItems generated based on rules

3) Eligibility Determination & Domicile Verification

- DDD context: EligibilityDetermination / `EligibilityVerificationCase`
- Timeline: Immediately after intake; may span days/weeks depending on verification
- Tasks:
  - Run automated eligibility checks (income thresholds, program rules)
  - Initiate domicile verification (document-based or state agency query)
  - Caseworker completes manual review for edge cases
  - Publish determination result and next steps
- Roles: System, Caseworker, State Agency (for API/verification), Parent
- Communications: Determination email, ToDo requests, verification requests (email/in‑app), deadline reminders
- Decisions: Eligible / Ineligible / Further review required
- Acceptance criteria:
  - Determination recorded with supporting evidence and audit trail
  - If domicile verification required, evidence uploaded or state confirmation captured

4) Lottery & Award Offers

- DDD context: Award / `AwardOffer`
- Timeline: After application close & verification windows (e.g., Nov–Dec depending on timing)
- Tasks:
  - Run lottery algorithm or awarding rules
  - Create `AwardOffer` records and expiration deadlines
  - Notify recipients and track acceptance status
- Roles: Program Admin, System, Parent, School Admin
- Communications: Lottery results, offer emails, acceptance reminders (7d/3d/24h)
- Decisions: Accept/Decline award
- Acceptance criteria:
  - AwardOffer recorded with deadline; acceptance/decline captured and processed

Workflow group C — Post‑Award Operations (funds, wallets, purchasing)

5) Wallet Provisioning & Funds Activation

- DDD context: ScholarshipAccount / `ScholarshipAccount`
- Timeline: Immediately after award acceptance or scheduled activation (e.g., start of term)
- Tasks:
  - Provision external wallet (ClassWallet) via Integration Service
  - Move funds into wallet (funding transaction) and reconcile
  - Notify parent about wallet and initial balance
- Roles: Integration Service, Finance, Parent
- Communications: Wallet created notice, balance summary, monthly statements
- Decisions: Manual hold on funds if compliance issues; trigger DNPE checks before external transfers
- Acceptance criteria:
  - External wallet created with externalWalletId; funding transaction settled and reflected in platform ledger

6) Purchasing & Merchant Payments

- DDD context: PurchaseRequest / `PurchaseRequest`
- Timeline: Ongoing during enrollment/use period; subject to spend controls and rules
- Tasks:
  - Parent or Provider submits purchase for approval
  - Rules Engine evaluates; auto-approve or route to manual review
  - On approval, call ClassWallet to authorize/process payment
  - Record transaction and produce receipt; reconcile merchant settlements
- Roles: Parent, Provider, Rules Engine, Finance, Caseworker
- Communications: Submission ack, approval/rejection with reasons, payment receipts
- Decisions: Approve/Reject purchase, escalate for manual review
- Acceptance criteria:
  - Purchase record and payment transaction created; receipt sent; ledger updated

7) Provider Enrollment & Payouts

- DDD context: Provider / `Provider`
- Timeline: Before providers can receive payouts; onboarding ongoing year-round
- Tasks:
  - Provider applies and submits credentials, tax info (TIN/EIN), bank info
  - Compliance checks (DNPE), manual verification if required
  - Provider approved and added to payout schedule
  - Run payout batches and send remittances
- Roles: Provider, Finance, Legal, Program Admin
- Communications: Enrollment ack, approval, payout remittance notices
- Decisions: Approve provider; block/unblock payouts per DNPE or compliance
- Acceptance criteria:
  - Provider record with verified bank/TIN and DNPE status; payout transactions reconcile

Workflow group D — Compliance, Audits & Exceptions

8) Compliance Investigations & Misuse Handling

- DDD context: ComplianceRecord / `ComplianceRecord`
- Timeline: Triggered on detection (real-time) or periodic sampling
- Tasks:
  - Detect potential misuse (rules engine, audits, tip lines)
  - Create `ComplianceRecord` and assign caseworker
  - Collect evidence, notify parent, allow appeal/response, escalate to Legal if warranted
  - If confirmed, actions: recover funds, terminate award, update GL entries
- Roles: Caseworker, Program Admin, Legal, Finance
- Communications: High-priority notices, case assignments, escalation emails
- Decisions: Close case as non-issue / corrective action / sanctions
- Acceptance criteria:
  - Investigation record with evidence, communications log, and final determination; GL adjustments and audit trail created

9) Renewal & Continuing Eligibility

- DDD context: Renewal / `ContinuingEligibility`
- Timeline: Annual or as defined (e.g., March–May for following school year)
- Tasks:
  - Notify families of renewal windows and required docs
  - Accept renewal applications, re-run eligibility checks
  - Update ScholarshipAccount and wallet status accordingly
- Roles: Parent, Caseworker, System
- Communications: Renewal announcements, reminders (30d/14d/7d/1d), result notifications
- Decisions: Renew / Deny / Further review
- Acceptance criteria:
  - Renewal decisions recorded with audit trail; wallet and funding adjusted as needed

Workflow group E — Finance, GL, and Month‑End Close

10) Month‑End Close & GL Export

- DDD context: Financials / GL
- Timeline: Monthly (end-of-month), quarter, and fiscal year close
- Tasks:
  - Run nightly reconciliation processes; resolve exceptions
  - Generate GL export batches per schedule; post to ERP
  - Produce month-end reports and variance analysis
  - Archive export batches and reconciliation reports
- Roles: Finance, Integration, SRE/Operations
- Communications: Batch completion notices, exception alerts, CFO/Controller reports
- Decisions: Post/hold GL batches; roll forward unresolved exceptions
- Acceptance criteria:
  - GL export successfully posted; reconciliation within thresholds; exceptions tracked

11) Year‑End Reporting & Tax Forms

- DDD context: Reporting / `TaxReportEntry`
- Timeline: Year-end (Dec–Jan) and tax filing windows
- Tasks:
  - Generate 1099/1099G or equivalent forms from transaction history
  - Validate recipient data and mailing addresses; produce postal or electronic distributions
  - Retention of records and audit package
- Roles: Finance, Legal, Program Admin
- Communications: Year-end statement notices, tax forms delivery
- Decisions: Approve final tax package for distribution
- Acceptance criteria:
  - Tax forms generated, distributed, and reconciled to ledger; audit package produced

Workflow group F — Platform Operations & Incident Response

12) Integration Failures & Incident Handling

- DDD context: Operational / `Notice` / `Exception`
- Timeline: Real-time/As‑occurs
- Tasks:
  - Monitor integration health (ClassWallet, state APIs)
  - On failure, run retry logic and create incident ticket
  - Escalate to on‑call SRE and notify stakeholders; provide status updates until resolved
  - Post-incident review and runbook updates
- Roles: SRE, Integration Engineers, Program Ops, Finance when payment-related
- Communications: PagerDuty alerts, incident summaries, stakeholder emails
- Decisions: Failover to manual processes; schedule maintenance windows
- Acceptance criteria:
  - Incident acknowledged and resolved within SLA; postmortem completed for major incidents

---

Timeline — logical order and fiscal alignment (condensed)

- Pre‑Enrollment: May–Aug — Outreach & materials produced; enrollment window planning
- Enrollment & Verification: Aug–Nov — Intake, determination, domicile verification, lottery/awards
- Post‑Award: Sep–Ongoing — Wallet provisioning, purchasing, provider onboarding
- Fiscal Operations: Monthly — Nightly reconciliation, month‑end GL exports, quarterly reporting
- Renewals: Feb–May — Renewal windows and continuing eligibility
- Year‑End: Dec–Jan — Tax reporting, forms, and audits

Draft acceptance gate checklist (for operational readiness)

- Enrollment pipeline: schema locked, form validation, ToDo generation, notification templates
- Verification: state API connectivity tested, sample verification pass rate > 95% in sandbox
- Payments: ClassWallet sandbox end-to-end, idempotency keys exercised, reconciliation job green
- GL: sample export imported into ERP without errors; sequence numbers validated
- Observability: dashboards for balances, pending transactions, webhook health, reconciliation status

Next steps / export options

- I can export these workflows to CSV (workflow, step, actor, trigger, channel, acceptance criteria) or generate Jira epics/stories for the top 8 workflows.

Document history

- 2025-10-16: Created workflows matrix and timeline.
