# ClassWallet Integration Matrix

Purpose: catalog all the K12 domain events, operations, and workflows that require integration with ClassWallet (or equivalent student-account/wallet service). For each item we list DDD context, aggregate/root, operations/triggers, required API interactions (push/pull), reconciliation and idempotency notes, sandbox/test requirements, failure handling, and recommended notification/actions mapping.

Assumptions

- "ClassWallet" is the external wallet/payment provider used for scholarship fund management (activation, distributions, merchant payments, provider payouts).
- Integration should be implemented as a bounded context in the platform with explicit contracts, retry/backoff, and reconciliation jobs.

Guidance for implementers

- Implement async, event-driven integration via an Integration Service that subscribes to platform events and calls ClassWallet endpoints. Prefer webhooks + outbound signed callbacks for reliability.
- Maintain a local mirror of wallet state (balance, holds, transactions) with periodic reconciliation.
- Record all external transaction IDs and ensure idempotent operations using idempotency keys.
- Provide a sandbox harness to simulate ClassWallet responses, error modes, and latency for contract and load testing.

---

1) Award activation & wallet provisioning

- DDD element: Event
- Parent / Context: ScholarshipAccount / `ScholarshipAccount` aggregate
- Operations / triggers: AwardActivated, ScholarshipAccountCreated
- ClassWallet interactions:
  - API: Create Wallet / Account (POST /wallets)
  - Data sent: applicantId, accountId, legalName, initialBalance, metadata (awardId, program)
  - Response: externalWalletId, status, initialBalance
- Reconciliation / idempotency:
  - Use platform awardId as idempotency key when creating wallets
  - Reconcile missing wallets nightly: platform account without externalWalletId → requeue create
- Sandbox/test requirements:
  - API that simulates success, duplicate, and delayed creation responses; support rate-limit simulation
- Failure handling:
  - On transient error: retry with exponential backoff
  - On permanent failure: mark account for manual review and notify finance/ops
- Notification mapping:
  - On success: notify parent (Email + In‑app) Wallet created
  - On failure: notify ops and caseworker for intervention

2) Funds movement (funds moved to wallet / disbursements)

- DDD element: Command / Event
- Parent / Context: ScholarshipAccount, DisbursementOrder / `Payment`
- Operations / triggers: FundsMovedToWallet, DisbursementInitiated
- ClassWallet interactions:
  - API: Credit Wallet (POST /wallets/{id}/credits) or Transfer (POST /transfers)
  - Data sent: amount, currency, externalReference (disbursementId), metadata
  - Response: transactionId, status
- Reconciliation / idempotency:
  - Use disbursementId as idempotency key for credits/transfers
  - Reconcile ledger differences daily (platform balance vs ClassWallet ledger)
- Sandbox/test requirements:
  - Support success/failure, delayed settlements, duplicate transaction simulation
  - Simulate chargebacks and refunds
- Failure handling:
  - On pending settlement: mark transaction pending and notify finance
  - On permanent failure: retry per policy, escalate after N attempts
- Notification mapping:
  - On credit success: notify parent (Email + In‑app balance update) and finance
  - On failure: notify ops and affected stakeholders

3) Purchase authorization and merchant payments

- DDD element: Command / Aggregate
- Parent / Context: PurchaseRequest / `PurchaseRequest`
- Operations / triggers: PurchaseApproved → PaymentProcessed
- ClassWallet interactions:
  - API: Authorize Payment (POST /wallets/{id}/authorize) or Pay Merchant (POST /payments)
  - Data sent: purchaseId, walletId, amount, merchantId, orderDetails, idempotencyKey
  - Response: authorizationId, paymentId, status (authorized/declined)
- Reconciliation / idempotency:
  - Use purchaseId as idempotency key to prevent double-charges
  - Reconcile merchant settlements against purchase records nightly
- Sandbox/test requirements:
  - Test merchant approval, declines, partial captures, and holds
  - Simulate network errors and timeouts
- Failure handling:
  - On decline: notify user with reason code and remediation steps
  - On timeout: mark payment pending and run reconciliation
- Notification mapping:
  - On authorization success/failure: notify parent and provider (Email + In‑app)

4) Refunds & chargebacks

- DDD element: Command / Event
- Parent / Context: PurchaseRequest / `ScholarshipAccount`
- Operations / triggers: RefundProcessed, ChargebackReceived
- ClassWallet interactions:
  - API: Refund (POST /payments/{paymentId}/refunds), Query Chargeback (GET /chargebacks/{id})
  - Data sent: originalPaymentId, amount, reasonCode
  - Response: refundId, status
- Reconciliation / idempotency:
  - Track originalPaymentId; idempotency key = refundRequestId
  - Daily reconcile refunds/chargebacks against finance ledger
- Sandbox/test requirements:
  - Simulate partial/full refunds and chargebacks with different timelines
- Failure handling:
  - On refund failure: escalate to finance; mark for manual processing
  - On chargeback: create compliance case and notify parent + ops
- Notification mapping:
  - On refund: notify parent (Email + In‑app) and finance
  - On chargeback: immediate escalation to compliance and parent notification

5) Provider payouts (batch vendor payments)

- DDD element: Command / Event
- Parent / Context: Provider / `Provider` aggregate
- Operations / triggers: ProviderPayoutInitiated, ProviderPaymentProcessed, ProviderPaymentFailed
- ClassWallet interactions:
  - API: Initiate Payout (POST /payouts), Retrieve Payout Status (GET /payouts/{id})
  - Data sent: providerId, externalProviderAccount, amount, payoutBatchId
  - Response: payoutId, status, settlementDate
- Reconciliation / idempotency:
  - Use payoutBatchId + providerId as idempotency keys
  - Reconcile payouts with bank remittances and provider confirmations
- Sandbox/test requirements:
  - Batch payout testing, failure in batch, partial success handling
- Failure handling:
  - On partial failures: retry individual items; escalate if batch failure
- Notification mapping:
  - On payout success/failure: notify provider and finance (Email + In‑app)

6) Transaction ledger sync & reconciliation

- DDD element: Scheduled job / Event
- Parent / Context: Financials / `ScholarshipAccount`
- Operations / triggers: NightlyReconciliation, LedgerMismatchDetected
- ClassWallet interactions:
  - API: Fetch ledger / transactions (GET /wallets/{id}/transactions) with pagination
  - Data needed: transactions, balances, holds, pending items
- Reconciliation / idempotency:
  - Implement 3‑way reconciliation: platform ledger, ClassWallet ledger, bank settlement
  - Auto-create reconciliation cases for mismatches above threshold
- Sandbox/test requirements:
  - Large dataset reconciliation tests and simulated eventual consistency windows
- Failure handling:
  - Create exception cases for finance review; alert ops for systemic mismatches
- Notification mapping:
  - On mismatch: notify finance (Email + In‑app) and create ticket

7) Webhooks / asynchronous callbacks handling

- DDD element: Integration point / Event
- Parent / Context: Integration Service
- Operations / triggers: ClassWalletWebhookReceived (transactionUpdate, payoutUpdate, disputeUpdate)
- ClassWallet interactions:
  - API: Receive signed webhooks; validate signature, process event
  - Data: webhook event type, externalIds, status, metadata
- Reconciliation / idempotency:
  - Validate signature and idempotency using webhookId/externalEventId
  - Persist webhook receipt and processing status for audit
- Sandbox/test requirements:
  - Webhook replay, signature invalidation, duplicate delivery, delayed events
- Failure handling:
  - Respond 200 only after successful processing; otherwise return 5xx to trigger retries
  - Queue failed webhook events for replay after manual fix
- Notification mapping:
  - Map certain webhook events (chargeback, payout failure) to immediate notifications to finance/compliance

8) Authorization & access control (token lifecycle)

- DDD element: Integration security
- Parent / Context: Integration Service
- Operations / triggers: TokenIssued, TokenRotated, TokenRevoked
- ClassWallet interactions:
  - API: OAuth2 / API key rotation, JWT validation
  - Requirements: secure vault storage, rotation policy, least privilege
- Reconciliation / idempotency:
  - Log token events and alert on failed auth spikes
- Sandbox/test requirements:
  - Support expired/invalid tokens, key rotation simulation
- Failure handling:
  - On auth failure: alert ops and halt outbound calls until fixed
- Notification mapping:
  - Notify ops on repeated auth failures or key compromise

9) Limits, holds, and spend controls

- DDD element: Policy / Rules
- Parent / Context: ScholarshipAccount, Rules Engine
- Operations / triggers: HoldPlaced, SpendLimitReached, LimitLifted
- ClassWallet interactions:
  - API: PlaceHold (POST /wallets/{id}/holds), ReleaseHold, QueryLimits
  - Data: holdId, reason, amount, expiry
- Reconciliation / idempotency:
  - Idempotency by holdRequestId; reconcile holds nightly
- Sandbox/test requirements:
  - Simulate hold placement, expiration, and conflict scenarios
- Failure handling:
  - If hold fails: notify originating service and place local hold marker for retry
- Notification mapping:
  - Notify parent of holds/spend limits (Email + In‑app) and staff if escalation needed

10) Reporting & statement generation

- DDD element: Batch job / Event
- Parent / Context: Reporting / `TaxReportEntry`, Account Statements
- Operations / triggers: MonthlyStatementReady, TaxReportReady
- ClassWallet interactions:
  - API: Fetch historical transactions and balances for period (GET /wallets/{id}/transactions?from..to)
  - Data needed: itemized transactions, settlement records
- Reconciliation / idempotency:
  - Ensure exported data is snapshot-consistent and signed/audited
- Sandbox/test requirements:
  - Large history export performance tests and data integrity checks
- Failure handling:
  - If export fails: retry and alert reporting team; mark partial exports clearly
- Notification mapping:
  - Notify parents and finance when statements/tax reports are available (Email + In‑app)

11) Sandbox & contract testing requirements

- DDD element: Nonfunctional / Testing
- Parent / Context: Integration QA
- Requirements:
  - Sandbox must support: synchronous responses, delayed settlement, webhooks, duplicate events, rate limits, auth variations, failure modes
  - Provide a test matrix for happy-path and known error modes
- Notes:
  - Integration tests should run in CI against the sandbox with contract checks

12) Operational & monitoring requirements

- DDD element: Monitoring / Observability
- Parent / Context: Integration Service / Platform
- Requirements:
  - Instrument all calls (latency, status codes, error types), track SLOs for outbound integrations, alert on increased error rate or reconciliation failures
  - Provide dashboards for balances, pending items, and webhook health
- Notification mapping:
  - On sustained failure rates or reconciliation anomalies: alert SRE and Finance (PagerDuty + Email)

13) Legal / compliance & audit trails

- DDD element: Compliance
- Parent / Context: Finance / Legal
- Requirements:
  - Persist all external transaction IDs and signed webhook payloads; store for legally required retention period
  - Provide exportable audit trails for each `ScholarshipAccount` and `DisbursementOrder`
- Notification mapping:
  - Notify Legal/Finance on audit requests or data exports

---

  14) General Ledger (GL) posting & export

  - DDD element: Accounting / Event
  - Parent / Context: Financials / `ScholarshipAccount`, `DisbursementOrder`, `ProviderPayout`
  - Operations / triggers: GL_PostRequired (on disbursement, payout, refund), GL_Adjustment
  - ClassWallet interactions:
    - API: Fetch settled transactions and settlement details to derive GL entries (GET /wallets/{id}/transactions?settled=true)
    - Data needed: settled transaction rows, settlement dates, clearing references, fees
  - Reconciliation / idempotency:
    - Use platform transactionId + externalTransactionId as composite key for GL entry idempotency
    - Maintain GL export sequence numbers; avoid duplicate posting by tracking export batches
    - Implement periodic GL vs ledger reconciliation and auto-create adjustment entries for rounding/fee differences
  - Sandbox/test requirements:
    - Provide settled transaction exports, fee breakdowns, and partial settlement simulations for testing GL posting logic
  - Failure handling:
    - If GL export fails: pause downstream posting, alert Finance, and queue retry with audit trail
    - For mismatched records: auto-create exceptions for manual accounting adjustment and track adjustments as separate GL entries
  - Notification mapping:
    - Notify Finance when GL export completes/fails and provide downloadable export (CSV/ISO20022/ERP import format)

  15) DNPE (Do‑Not‑Pay / Exclusion) checks

  - DDD element: Compliance / Policy
  - Parent / Context: Provider Payouts / `Provider`, ScholarshipAccount / `ScholarshipAccount`
  - Operations / triggers: Before ProviderPayoutInitiated or before Credit Wallet/Transfer to external account
  - ClassWallet interactions:
    - API: Optionally call DNPE check service or include provider status in provider metadata when initiating payouts
    - Data sent/required: providerTIN, providerName, providerBankAccount, payoutBatchId
  - Reconciliation / idempotency:
    - Record DNPE check result with providerId and payoutBatchId to prevent repeated payouts to excluded entities
    - Track appeal/clearance state so that blocked providers are not retried until cleared
  - Sandbox/test requirements:
    - Simulate DNPE match, partial matches, and false positives in sandbox; support delayed clearance responses
  - Failure handling:
    - On DNPE match: block payout, create compliance case, notify Finance and Legal, and surface remediation steps to ops
    - On DNPE service failure: fail-safe to hold payout and queue DNPE check retries; alert ops if persistent
  - Notification mapping:
    - Immediate notification to Finance/Legal on DNPE match with relevant provider details; notify provider only per legal guidance


Condensed bullet list (integration event — ClassWallet action / category)

- AwardActivated / ScholarshipAccountCreated — Create Wallet (POST /wallets) / Provisioning
- FundsMovedToWallet / DisbursementInitiated — Credit Wallet / Funds Movement
- PurchaseApproved → PaymentProcessed — Authorize/Pay Merchant / Payment
- RefundProcessed / ChargebackReceived — Refund / Chargeback Handling
- ProviderPayoutInitiated — Initiate Payout (batch) / Provider Payments
- NightlyReconciliation — Fetch transactions / Reconciliation
- ClassWalletWebhookReceived — Handle webhook (transaction/payout/dispute) / Webhooks
- TokenIssued/Rotated — Manage auth tokens / Security
- HoldPlaced / SpendLimitReached — PlaceHold/ReleaseHold / Spend Controls
- MonthlyStatementReady / TaxReportReady — Fetch historical transactions / Reporting

If you'd like, I can:

- Export to CSV for the integration team (columns: event, dddElement, aggregate, classwalletEndpoint, idempotencyKey, retryPolicy, sandboxTestCases)
- Generate 6 paste-ready Jira stories for ClassWallet integration (wallet provisioning, payments, payouts, reconciliation, webhooks, monitoring)

Document history

- 2025-10-16: Created initial ClassWallet integration matrix.
