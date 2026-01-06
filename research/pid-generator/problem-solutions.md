# PID Problem Statement — Explicit Overview and Options

## 1) Explicit overview of the problem

- Current PID format: nine digits beginning with '7' (length and pattern like SSNs).
- Problem: nine-digit numeric PIDs are frequently flagged as SSNs by DLP/email/document scanners, increasing false positives and operational friction.
- Legacy population: all existing PIDs follow this nine-digit pattern, so any change impacts many systems and workflows.
- Goals:
  - Eliminate SSN-like appearance to reduce false-positive PII detection.
  - Preserve ability to join and audit across systems (legacy and new).
  - Minimize operational and migration risk while meeting privacy and compliance constraints.

## 2) Options for what the PID looks like (formats, length, algorithms)

For each option list pros/cons and scale/collision notes.

A. Opaque random token (recommended for privacy)

- Format examples: ULID (26 chars, Crockford base32), UUIDv4 (36 chars with hyphens), base58 or base32 short token.
- Length: 16–26 chars recommended (e.g., 128-bit → 22 base32 chars).
- Collision risk: negligible at 128 bits; safe for population sizes >>100M.
- Pros: non-PII, non-reversible, no inference risk, compatible with scanners.
- Cons: longer, less human-friendly to type.

B. Compact human-friendly token (license-plate style)

- Format examples: 8–12 alphanumeric groups (e.g., ABC-12D-EF3).
- Length: 8–12 chars (excluding separators). Can include checksum char.
- Collision math: with ~36^10 ≈ 3.6e15 space for 10 chars; however, practical alphabet reduction and checksum reduce usable space.
- Pros: easier to read/type, better for manual entry or printed cards.
- Cons: still could resemble other codes; smaller effective space if constrained; must include checksum to avoid transcription errors.

C. Deterministic HMAC-derived token (for deduplication)

- Format: HMAC(KMS-secret, canonicalized attributes) then encode/truncate (e.g., 20–26 chars).
- Pros: same inputs produce same token — helps deterministic matching.
- Cons: if secret is compromised, linkability risk across datasets; key management critical.

D. Hybrid (internal DB id + public opaque token)

- Format: internal sequential PK (not exposed) + public opaque token that maps to it.
- Pros: short public token possible, internal continuity preserved.
- Cons: mapping table required; must ensure token uniqueness and rotate mapping if needed.

E. Versioned prefix

- Always include version prefix: e.g., PIDv1-xxxx or v2-xxxx for future migrations/format changes.

Checksum recommendation

- For any human-entered format include a 1–2 character checksum (Mod-37, base32 crc) to catch transcription errors.

Suggested defaults

- Default production: ULID (26 chars) or a 22–24 char base32 token (privacy-first).
- If human entry required: 12–14 char base32 token grouped (XXXX-XXXX-XXXX) + 1 checksum char.
- If deterministic matching required for onboarding: HMAC approach but only for matching pipelines; do not expose raw inputs or reuse secret across environments.

## 3) Risks and mitigations

- Risk: Breaking downstream integrations that reference the legacy 9-digit PID.
  - Mitigation: maintain mapping table legacy_pid → new_pid; support both ids during a transition window; phased cutover.
- Risk: Users or admins continue using old nine-digit values (documents/reports still flagged).
  - Mitigation: UI/UX controls to surface new PID prominently; retired format still resolvable but marked deprecated; communications/training.
- Risk: Key compromise (for HMAC/deterministic approaches).
  - Mitigation: store keys in KMS (Azure Key Vault), restrict access, rotate keys, log every resolve/match operation.
- Risk: Incorrect bulk re-assignment affecting large population.
  - Mitigation: staged pilot, sampling validation, idempotent bulk-import, dry-run mode, reconciliation reports.
- Risk: Human-friendly short tokens increase collision risk or inference.
  - Mitigation: add checksum, central issuance, collision checks at create-time, reserve extra bits for entropy.
- Risk: Audit/discovery/legal requests require mapping to PII.
  - Mitigation: keep encrypted payloads and strict RBAC for resolution; audit every resolution.

## 4) Addressing items discussed in the attached doc (options & tradeoffs)

A. Replace all legacy PIDs with new >9-digit PIDs (full re‑assignment)

- Pros:
  - Eliminates SSN-like tokens across the board.
  - One canonical format simplifies forward operations.
- Cons:
  - High operational risk if mapping/backfill is incorrect.
  - Requires widespread updates to reports, integrations, and admin tools.
  - Admins needing legacy research will require access to old → new mapping.
- When to choose: strong organizational mandate to eliminate legacy tokens quickly and resources to validate full migration.

B. Keep legacy PIDs and use new-creation rule for new records only (incremental)

- Pros:
  - Lower immediate risk; simpler rollout; new records not flagged going forward.
  - Smaller migration surface; legacy lookups preserved.
- Cons:
  - Dual-format ecosystem long-term; must handle both formats in code and docs.
  - Legacy tokens continue to trigger DLP on historical artifacts.
- When to choose: limited project scope or when migration cost/risk is prohibitive.

C. Hybrid approach (backfill selectively + preserve legacy mapping)

- Strategy:
  - Issue new PIDs for all new records.
  - Run prioritized backfill for active cohorts or high-value subsets.
  - Maintain mapping for legacy PIDs; deprecate legacy tokens gradually.
- Pros: balances risk and benefit; reduces immediate DLP problems for new documents; allows staged validation.
- Cons: requires operational plan for mapping and reconciliation.

D. Operational items from doc and options

- Admin research: keep legacy PID visible in admin UI as secondary identifier; document lookup process.
- Document/email DLP flags: update DLP rules to whitelist known internal token pattern only if safe; better: change PID format to avoid whitelist dependencies.
- Database complexity: add mapping table (legacy_pid, new_pid, effective_date, status, audit_id). Use views/abstraction layer so downstream apps query canonical_pid.
- Communication: notify stakeholders of identifier strategy and timeline; provide lookup tools for vendors and admins.

## Recommendations & next decision points

- Short-term: implement new PID generation for all new records (format: ULID or 22–24 char base32) and include version prefix. Do not change legacy PIDs immediately.
- Medium-term: design and test a backfill/merge process for legacy PIDs with idempotent bulk-import and reconciliation, run a pilot on a representative subset.
- Required decisions:
  1. Must PIDs be deterministic for onboarding dedup? (yes/no)
  2. Choose production token format (ULID / UUID / custom base32 / short human token).
  3. Decide migration approach: full reassign / new-only / hybrid.
  4. Confirm KMS choice and key governance (recommend Azure Key Vault).
- Operational artifacts to produce next:
  - Mapping schema (legacy_pid → pid) and sample ERD.
  - Migration playbook: pilot, dry-run, validation checks, rollback plan.
  - API contract for PID service including format/version in response.

## Next steps (actionable)

- Confirm desired PID format and determinism requirement with stakeholders.
- Prototype generation code for the chosen format and produce example tokens.
- Draft and validate a mapping table and run a small pilot backfill.
- Prepare admin lookup UI to display both legacy and new PIDs during transition.
