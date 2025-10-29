# Communication & Notification Matrix

Purpose: map domain events/operations (DDD context) to required external communications (email/SMS/print) and in‑app notifications. Each entry lists DDD element, parent/context, operation triggers, aggregate/root, recipients, recommended channels, reminder patterns (when recipients need reminders/status updates), and message intent (status vs action required).

Assumptions

- Default communication channels: Email (primary), In‑app notifications (secondary), SMS (opt‑in for urgent reminders). Postal/print used only for legal/compliance notices where required.
- Time semantics: "T0" = event occurrence time; reminder timings are suggestions and should be configurable per program.

Guidance for implementers

- Create centralized Notification templates keyed by event type and locale.
- Store notification audit records (who, what, when, channel, delivery status) on the related aggregate for compliance.
- Support idempotency (ensure duplicate events don't create duplicate external messages).

---

1) Application lifecycle — submission / status

- DDD element: Event / Aggregate
- Parent / Context: Application & Eligibility Context / `Application` aggregate
- Operations / triggers: ApplicationSubmitted; ApplicationStatusChanged (underReview, accepted/eligible, ineligible, waitlisted, awarded, declined)
- Aggregate / Root: `Application`
- Recipients: Parent/Guardian (primary), Caseworker (if assigned), School contact (if relevant)
- Channels: Email (receipt/status), In‑app (status + action tasks), SMS (opt‑in for submission receipt and urgent deadlines)
- Reminders / status updates:
  - T0: Receipt confirmation (Email + In‑app) — immediate
  - T0+48h: If supporting docs required and not uploaded, reminder (Email + In‑app)
  - Status changes: immediate status notification (Email + In‑app)  
  - 3 days before any deadline triggered by status (e.g., accept award) — reminder (Email; SMS opt‑in)
- Message intent: Action required (upload docs, sign), Status update (progress)

2) Eligibility / Determination intake

- DDD element: Event / Value object
- Parent / Context: EligibilityDetermination / `EligibilityDetermination` aggregate
- Operations / triggers: EligibilityDeterminationSubmitted, EligibilityDeterminationResultPublished
- Recipients: Parent/Guardian, Caseworker
- Channels: Email (result + instructions), In‑app (detailed determination view)
- Reminders / status updates:
  - T0: Submission acknowledgement (Email + In‑app)
  - If determination requires more info: reminders at T0+48h and T0+7d
  - On final determination: immediate notification (Email + In‑app)
- Message intent: Action required (provide docs), Status update (result)

3) Domicile & verification notifications

- DDD element: Events / Aggregate
- Parent / Context: DomicileVerification / `DomicileDetermination` or `EligibilityVerificationCase`
- Operations / triggers: DomicileVerificationInitiated, VerificationDocumentationRequested, DomicileVerified, DomicileDenied
- Recipients: Parent/Guardian, School (if verification affects school assignment), Caseworker
- Channels: Email (requests/results), In‑app (upload UI + status), SMS (deadline reminders opt‑in)
- Reminders / status updates:
  - T0: Verification started (Email + In‑app)
  - Deadline reminders: 7d/3d/24h before required document submission deadline (Email; SMS opt‑in)
  - On final result: immediate notification with next steps (Email + In‑app)
- Message intent: Action required (upload docs), Status update (result)

4) Lottery / award offering / acceptance

- DDD element: Event / Aggregate
- Parent / Context: Awarding & Funding / `Award` / `AwardOffer`
- Operations / triggers: LotteryConducted, AwardOfferMade, AwardAccepted, AwardDeclined
- Recipients: Parent/Guardian, School Admin
- Channels: Email (result and offer details), In‑app (offer acceptance flow), SMS (opt‑in urgent acceptance reminders)
- Reminders / status updates:
  - T0: Lottery results / offer (Email + In‑app)
  - 7d/3d/24h before acceptance deadline: reminders (Email; SMS opt‑in)
  - If offer accepted: confirmation (Email + In‑app)
- Message intent: Action required (accept/decline), Status update

5) Award activation & account creation

- DDD element: Event
- Parent / Context: ScholarshipAccount / `ScholarshipAccount` aggregate
- Operations / triggers: AwardActivated, ScholarshipAccountCreated, FundsMovedToWallet
- Recipients: Parent/Guardian
- Channels: Email (activation, balance summary), In‑app (wallet UI), Push/SMS (opt‑in for immediate funds notice)
- Reminders / status updates:
  - T0: Account created / funds available (Email + In‑app)
  - Monthly balance summary (Email; In‑app reports)
- Message intent: Status update (balance and funding), Action required (set up payment preferences)

6) To‑Do / Document requests / Deadlines

- DDD element: Entity / Task
- Parent / Context: ToDoItem / `Notice` aggregate
- Operations / triggers: ToDoCreated, ToDoOverdue, DeadlineApproaching
- Recipients: Parent/Guardian, Assigned staff
- Channels: In‑app (task list, progress), Email (initial + overdue), SMS (for urgent/near‑deadline opt‑in)
- Reminders / status updates:
  - T0: To‑Do created (In‑app; Email for primary)
  - Deadline reminders: configurable series (7d/3d/1d/2h) based on urgency
  - Overdue escalation: 1d/3d escalations to staff (Email + In‑app)
- Message intent: Action required (complete task), Status update (completion)

7) ParentAgreement / LEA Release signing

- DDD element: Aggregate / Event
- Parent / Context: ParentAgreement / `ParentAgreement` aggregate
- Operations / triggers: ParentAgreementRequested, ParentAgreementSigned, LEAReleaseSigned
- Recipients: Parent/Guardian, LEA Contact
- Channels: Email (signature request + receipts), In‑app (signing workflow), SMS (opt‑in reminders)
- Reminders / status updates:
  - T0: Signature request (Email + In‑app)
  - Reminders: 7d/3d/1d before signature deadline; daily until signed up to configurable limit
  - On signed: confirmation (Email + In‑app)
- Message intent: Action required (sign), Status update (signed)

8) Purchase / purchase review / payment

- DDD element: Aggregate / Events
- Parent / Context: Purchasing & Expenses / `PurchaseRequest`, `ScholarshipAccount`
- Operations / triggers: PurchaseSubmitted, PurchaseApproved, PurchaseRejected, PaymentProcessed, RefundProcessed
- Recipients: Parent/Guardian, Provider/Seller, Finance team
- Channels: Email (submission + decision + payment receipts), In‑app (purchase history + status), SMS (opt‑in for payment status)
- Reminders / status updates:
  - T0: Submission acknowledgement (Email + In‑app)
  - On approval/rejection: immediate notification with rationale and next steps (Email + In‑app)
  - On payment: payment receipt (Email + In‑app)
  - If pending action required (e.g., more docs), reminder series (48h/7d)
- Message intent: Action required (supply fix), Status update (approval/payment)

9) Accessory / timing rule violations

- DDD element: Policy validation result
- Parent / Context: Rules Engine evaluation on `PurchaseRequest`
- Operations / triggers: PurchaseValidationFailed (rule code), PurchaseValidationPassed
- Recipients: Parent/Guardian, Review Team (if escalated)
- Channels: In‑app (detailed rule failure), Email (summary + remediation), Staff escalation channels (email + case assignment)
- Reminders / status updates:
  - T0: Immediate notification explaining rule violation and remediation steps (In‑app + Email)
  - If remediation required: reminders 48h/7d until resolved; escalate to staff if unresolved
- Message intent: Action required (correct purchase), Status update

10) Provider / vendor enrollment & payment

- DDD element: Aggregate / Events
- Parent / Context: Provider Enrollment / `Provider` aggregate
- Operations / triggers: ProviderApplied, ProviderEnrolled, ProviderPaymentProcessed, ProviderPaymentFailed
- Recipients: Provider contact, Finance team
- Channels: Email (application status, payments), In‑app (provider portal), Vendor-specific channels (EFT/remittance files)
- Reminders / status updates:
  - T0: Application receipt and enrollment decision notifications
  - Payment retries/failures: immediate notification and schedule for retries; monthly payment summaries
  - Credential expirations: 30d/7d reminders prior to expiration
- Message intent: Action required (complete onboarding), Status update (payments)

11) Compliance / audit / misuse / sanctions

- DDD element: Aggregate / Events
- Parent / Context: Compliance & Agreements / `ComplianceRecord`
- Operations / triggers: MisuseDetected, ComplianceRecordCreated, AwardTerminated, AwardRevoked
- Recipients: Parent/Guardian, Program Admins, Legal (if escalated)
- Channels: Email (formal notices), In‑app (case details), Phone/SMS (ops escalation as needed)
- Reminders / status updates:
  - T0: High‑priority notification to parent and assigned caseworker (Email + In‑app; phone for urgent)
  - Escalation timeline: immediate, 24h, 72h depending on severity; legal/termination notices follow required legal cadence
- Message intent: Action required (respond/appeal), Status update (investigation progress)

12) Renewal & re‑evaluation

- DDD element: Events / Aggregate
- Parent / Context: Renewal / `ContinuingEligibility`
- Operations / triggers: RenewalOfferSent, RenewalApplicationStarted, RenewalCompleted
- Recipients: Parent/Guardian
- Channels: Email (announcements + instructions), In‑app (renewal workflow), SMS (opt‑in reminders)
- Reminders / status updates:
  - Announcement: T0 when renewal window opens
  - Periodic reminders: 30d/14d/7d/1d before renewal deadline
  - Post-deadline: outcome notification (Email + In‑app)
- Message intent: Action required (complete renewal), Status update

13) Verification sample selection / audit sampling

- DDD element: Event
- Parent / Context: Verification Sampling Service / `EligibilityVerificationCase`
- Operations / triggers: VerificationSampleSelected, VerificationDocumentationRequested
- Recipients: Selected households, Caseworkers
- Channels: Email (notice + instructions), In‑app (upload UI), SMS (opt‑in deadline reminders)
- Reminders / status updates:
  - T0: Selection notification (Email + In‑app)
  - Deadlines: 14d/7d/3d/1d reminders and overdue escalation to staff
- Message intent: Action required (submit docs), Status update

14) Disbursement & school payment

- DDD element: Event
- Parent / Context: Disbursements / `DisbursementOrder` / `Payment`
- Operations / triggers: DisbursementInitiated, SchoolPaid, PaymentConfirmed
- Recipients: School finance contact, Parent/Guardian (if relevant), Program Finance
- Channels: Email (confirmation + remittance), In‑app (payment ledger), Vendor/EFT channels
- Reminders / status updates:
  - T0: Disbursement notice to school (Email + remittance attachment)
  - On confirmation: payment confirmed notification
  - Exceptions: alert finance team and affected stakeholders immediately
- Message intent: Status update (payment executed), Action required (resolve exception)

15) Tax reporting & year‑end notices

- DDD element: Event / Value object
- Parent / Context: Reporting & Tax / `TaxReportEntry`
- Operations / triggers: Tax1099GPrepared, YearEndStatementAvailable
- Recipients: Parent/Guardian, Finance/Reporting
- Channels: Email (forms + instructions), In‑app (downloadable forms), Postal/print if legally required
- Reminders / status updates:
  - T0: Year‑end forms available notification
  - Follow up: 30d reminder to download/acknowledge
- Message intent: Status update (forms), Action required (acknowledge/consult tax advisor)

16) Admin / staff operational alerts

- DDD element: System events / Operational notices
- Parent / Context: Platform / `Notice` / `ToDoItem`
- Operations / triggers: IntegrationFailure (RDS, ClassWallet), SLA_Breach, ExceptionQueueItem
- Recipients: Admins, On‑call SRE, Program Managers
- Channels: Email (paged + summary), In‑app staff dashboard, PagerDuty/ops channel for critical incidents
- Reminders / status updates:
  - T0: Immediate alert to on‑call (PagerDuty)
  - Status updates: every 15–60 minutes depending on severity until resolved
- Message intent: Action required (investigate/resolve), Status update (incident progress)

---

Condensed bullet list (event — preferred channels / category)

- ApplicationSubmitted — Email / In‑app (receipt)
- ApplicationStatusChanged (underReview/eligible/ineligible/waitlisted/awarded) — Email / In‑app (status)
- EligibilityDeterminationSubmitted — Email / In‑app
- EligibilityDeterminationResultPublished — Email / In‑app
- DomicileVerificationInitiated — Email / In‑app
- VerificationDocumentationRequested — Email / In‑app / SMS opt‑in
- DomicileVerified / DomicileDenied — Email / In‑app
- LotteryConducted — Email / In‑app
- AwardOfferMade — Email / In‑app / SMS opt‑in (deadline)
- AwardAccepted / AwardDeclined — Email / In‑app
- AwardActivated / ScholarshipAccountCreated / FundsMovedToWallet — Email / In‑app
- ToDoItemCreated / DeadlineApproaching / ToDoOverdue — In‑app / Email / SMS opt‑in
- ParentAgreementRequested / ParentAgreementSigned / LEAReleaseSigned — Email / In‑app / SMS opt‑in
- PurchaseSubmitted / PurchaseApproved / PurchaseRejected — Email / In‑app
- PaymentProcessed / RefundProcessed / SchoolPaid — Email / In‑app
- PurchaseValidationFailed (rule violation) — In‑app / Email (explain remediation)
- ProviderApplied / ProviderEnrolled / ProviderPaymentFailed — Email / In‑app
- MisuseDetected / ComplianceRecordCreated / AwardTerminated — Email / In‑app / Phone for urgent escalation
- RenewalOfferSent / RenewalDeadlineApproaching / RenewalCompleted — Email / In‑app / SMS opt‑in
- VerificationSampleSelected — Email / In‑app / SMS opt‑in
- Tax1099GPrepared / YearEndStatementAvailable — Email / In‑app / Postal when required
- IntegrationFailure / SLA_Breach / ExceptionQueueItem — Email (ops) / PagerDuty / In‑app staff alerts

If you'd like, I can:

- Export this matrix to CSV (columns: event, dddElement, aggregate, recipients, channel, reminderSchedule, messageIntent) for the comms team.
- Produce sample notification templates (subject + body + merge fields) for 8 high‑priority events (ApplicationSubmitted, AwardOfferMade, AwardActivated, PurchaseRejected, MisuseDetected, ToDoOverdue, ProviderEnrolled, Tax1099GPrepared).

---

Document history

- 2025-10-16: Created initial communication & notification matrix and reminder schedules.
