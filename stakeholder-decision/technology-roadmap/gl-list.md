# General Ledger (GL) Integration Matrix

Purpose: define how platform financial events map to General Ledger entries, export formats, sequencing, idempotency rules, reconciliation processes, exception handling, and retention/audit expectations for the K12 program. This document is organized like `communication-list.md` and `class-wallet-list.md` to be directly usable by finance, integration, and ops teams.

Assumptions

- The GL is managed in an external ERP/accounting system that accepts periodic batch imports (CSV, ISO20022, or API). The platform must produce deterministic, auditable exports mapped to GL chart of accounts.
- Core financial events originate from platform aggregates: `ScholarshipAccount`, `DisbursementOrder`, `PurchaseRequest`, `ProviderPayout`, `Refund`, `Chargeback`.

Guidance for implementers

- Each export row must include: platformTransactionId, externalTransactionId (ClassWallet or bank), eventType, amount, currency, debitAccount, creditAccount, description/memo, settlementDate, exportBatchId, sequenceNumber, and checksum.
- Implement export batching with sequence numbering and idempotent imports (do not re-post the same sequenceNumber twice).
- Implement a reconciliation pipeline that performs 3‑way matching between platform ledger, ClassWallet ledger, and bank/ERP postings.

---

1) GL mapping: Disbursements

- DDD element: Event / Accounting Entry
- Parent / Context: Disbursement / `DisbursementOrder`
- Trigger: DisbursementInitiated, DisbursementSettled
- GL entries to create:
  - Debit: Program Expense (expense account e.g. 6xxxx)
  - Credit: Cash/Bank Clearing (liability) or Payable (2xxxx)
  - Fee entries: separate GL lines for processing fees (expense) and clearing differences
- Export behavior:
  - Export on settlement (settlementDate); include externalTransactionId and remittance reference
  - Batch with exportBatchId and per-row sequenceNumber
- Idempotency & sequencing:
  - Use composite id: exportBatchId + sequenceNumber; record postedBatchId to prevent duplicates
- Reconciliation:
  - Match disbursement records to bank statements and ClassWallet settled transactions; flag mismatches > threshold
- Notification mapping:
  - Notify Finance on batch completion with downloadable export and summary metrics

2) GL mapping: Wallet credits (funds moved to wallet)

- DDD element: Event / Accounting Entry
- Parent / Context: ScholarshipAccount / `ScholarshipAccount`
- Trigger: FundsMovedToWallet (funding events)
- GL entries to create:
  - Debit: Cash/Bank (asset) or Funding Source
  - Credit: Deferred Revenue / Wallet Liability (liability) until spent
- Export behavior:
  - Export on settled funding confirmation from ClassWallet
- Idempotency & sequencing:
  - Use fundingTransactionId as idempotency key; ensure single GL credit per funding
- Reconciliation:
  - Match funding records to ClassWallet credits and banking settlements

3) GL mapping: Purchases & merchant payments

- DDD element: Event / Accounting Entry
- Parent / Context: PurchaseRequest / `PurchaseRequest`
- Trigger: PurchaseApproved, PaymentProcessed
- GL entries to create:
  - Debit: Expense (specific program or merchant category)
  - Credit: Wallet Liability / Cash Clearing
  - On merchant fee: separate expense entry
- Export behavior:
  - Export when payment is settled/captured
- Idempotency & sequencing:
  - Use purchaseId + paymentId composite for idempotency
- Reconciliation:
  - Match to merchant settlement files and platform records; flag partial captures

4) GL mapping: Refunds & chargebacks

- DDD element: Event / Accounting Entry
- Parent / Context: PurchaseRequest / `ScholarshipAccount`
- Trigger: RefundProcessed, ChargebackReceived
- GL entries to create:
  - Debit: Wallet Liability / Cash Clearing (reverse original credit)
  - Credit: Revenue Reversal or Expense Reversal (depends on original entry)
  - Record chargeback fees as expense
- Export behavior:
  - Export on refund or chargeback settlement
- Idempotency & sequencing:
  - Track refundRequestId and originalPaymentId for idempotency
- Reconciliation:
  - Match refunds/chargebacks to bank/processor notices and create adjustment cases if amounts differ

5) GL mapping: Provider payouts and vendor payments

- DDD element: Batch Event / Accounting Entry
- Parent / Context: ProviderPayout / `Provider`
- Trigger: ProviderPayoutInitiated, ProviderPaymentProcessed
- GL entries to create:
  - Debit: Relevant Expense or Payable Clearing
  - Credit: Bank/Cash Clearing
  - Fees: expense lines for remittance fees
- Export behavior:
  - Export per payout batch with per-provider detail lines; include payoutBatchId
- Idempotency & sequencing:
  - Use payoutBatchId + providerId sequence numbers; log external payoutId
- Reconciliation:
  - Reconcile payouts with bank remittances and provider confirmations. Create exceptions for partial / failed items

6) GL mapping: Fees & processing costs

- DDD element: Event / Accounting Entry
- Parent / Context: Various (payments, payouts)
- Trigger: FeeCharged, FeeSettled
- GL entries to create:
  - Debit: Processing Fees (expense)
  - Credit: Bank/Cash Clearing (or liability if pre-funded)
- Export behavior:
  - Aggregate fees per period or include per-transaction lines as required by finance
- Reconciliation:
  - Aggregate and reconcile processor fee statements vs platform fee calculations

7) GL export formats & ERP integration

- Requirements:
  - Support CSV with clearly defined headers, sequence numbers, and checksums
  - Support ISO20022 or ERP-specific API payloads where required
  - Include mapping table: platform event types → GL account codes
- Security & retention:
  - Sign and store export batches; retain per legal retention policy

8) Reconciliation & exception handling

- Requirements:
  - Nightly 3‑way reconciliation: platform ledger, ClassWallet ledger, bank/ERP statements
  - Auto-open exception cases for mismatches beyond thresholds; track lifecycle of exceptions
  - Provide audit trail linking GL entries to original platform events and externalTransactionIds
- Notifications:
  - Alert Finance on reconciliation failures and provide drill-down report

9) Testing, sandbox & performance

- Requirements:
  - Sandbox exports with sample settled transactions and bank remittance files
  - Load test large export batches and reconciliation with large datasets
  - Contract tests for ERP import compatibility

10) DNPE & compliance controls (reference)

- Requirements:
  - For provider payout entries, include DNPE check status in export metadata
  - Block GL posting for payouts pending DNPE clearance if required by policy

11) Audit trail & retention

- Requirements:
  - Persist exportBatchId, sequenceNumbers, checksums, signatures, and link to `ScholarshipAccount`/`DisbursementOrder`
  - Retain signed webhook payloads, reconciliation reports, and manual adjustment records per legal retention rules

---

Condensed bullet list (event → GL action / account categories)

- DisbursementSettled — Debit: Expense (Program) / Credit: Cash Clearing
- FundsMovedToWallet (settled) — Debit: Cash / Credit: Wallet Liability (Deferred Revenue)
- PurchasePaymentSettled — Debit: Expense / Credit: Wallet Liability
- RefundSettled / ChargebackSettled — Debit: Wallet Liability / Credit: Revenue Reversal
- ProviderPayoutSettled — Debit: Expense/Payable Clearing / Credit: Cash
- FeeCharged — Debit: Processing Fees / Credit: Cash

If you'd like, I can:

- Produce CSV export templates (sample headers + one example row per event type)
- Generate 5 paste-ready Jira stories for GL integration (export pipeline, reconciliation job, exceptions UI, DNPE flagging in export, ERP import compatibility)

Document history

- 2025-10-16: Created GL integration matrix.
