# PID Generator — Meeting Prep

Date: 2025-12-19

This document prepares the client meeting for the K12 PID Generator modernization. It consolidates the problem statement, desired PID characteristics and uses, a recommended technical design, key risks, and suggested questions for the client.

## 1. Problem statement (detailed)

North Carolina needs a persistent, privacy-preserving identifier for students (and related actors such as parents/guardians and households) that can be used across the full K→12 lifecycle. Current systems sometimes rely on sensitive PII (for example SSNs) or ad-hoc local identifiers that:

- Create privacy and compliance risk when used for joins or audits.
- Break when students move between systems or change demographics.
- Prevent reliable cross-year linking, auditability, and long-term reporting.

The modernization project must deliver a PID capability that:

- Provides a single canonical identifier usable across Application, RDS, MyPortal, payments, and other systems.
- Is auditable and supports merges/dedup workflows without exposing PII.
- Supports bulk import and reconciling legacy identifiers.
- Fits NC privacy, statutory, and operational requirements.

Constraints and context:

- Integrates with existing state systems (MyPortal, RDS, ClassWallet, award services).
- Must support long-lived records (multi-year) and high-read throughput for resolution.
- Requires secure key management (recommended: Azure Key Vault) and strict RBAC for resolution actions.

## 2. PID characteristics, uses, and mechanisms

Characteristics

- Persistent: A PID must remain stable for the life of the student record unless explicitly merged.
- Opaque: The PID should not embed PII (no SSN fragments, DOB, or geographic codes).
- Collision-resistant: Generation must avoid collisions at system scale.
- Versioned: Include a version or prefix (e.g., PIDv1) to allow format evolution.
- Optionally human-usable: A shorter human-friendly token is possible but introduces collision and privacy tradeoffs.

Primary uses

- Global join key for identity and program state across services.
- Anchor for audit trails and event logs.
- Pseudonymization/tokenization of PII for downstream systems.
- Bulk import and reconciliation of legacy data with idempotent mapping.

Mechanisms

- Generation approaches:
  - Random (privacy-first): cryptographically-random 128-bit (UUIDv4/ULID) encoded (base32/base58). Non-reversible.
  - Deterministic (matching-friendly): HMAC(secret, canonicalized attributes) → truncated token. Reproducible but reversible if secret exposed.
  - Hybrid: internal sequential id (DB PK) + public opaque token that maps to it.
- Storage: map PID → encrypted identity payload (PII) using envelope encryption (cloud KMS).
- Resolution: secure API (RBAC/claims) that returns authorized attributes or a pointer to encrypted payload.
- Merge/duplicate handling: preserve history, mark old PIDs as superseded, never delete raw audit records.

## 3. Technical overview (recommended design)

Service boundaries

- A single PID Service (microservice) with a minimal, well-documented API and event publication.

Suggested API surface (examples)

- POST /pids
  - Purpose: generate a PID (random or deterministic modes). Accepts minimal non-sensitive attributes and an idempotency key.
  - Returns: { pid, version, createdAt }
- GET /pids/{pid}
  - Purpose: retrieve non-PII metadata and status (active, merged, superseded).
- POST /pids/resolve
  - Purpose: resolve pid → identity (requires elevated scope). Returns only authorized attributes.
- POST /pids/merge
  - Purpose: merge two PIDs (requires reason, actor, and audit note). Produces a merge event and marks one PID as superseded.
- POST /pids/bulk-import
  - Purpose: idempotent backfill of existing ids with mapping to new PIDs.

Data model (high level)

- PID table
  - pid (PK)
  - version
  - status { active, merged, superseded }
  - encrypted_payload_ref (blob or column) — encrypted PII
  - created_by, created_at, source
  - key_version (KMS key id) for envelope encryption

Security & key management

- Envelope encryption with Azure Key Vault (recommended) or equivalent KMS.
- Strict RBAC: only allowed services/roles can call resolve; maintain fine-grained authorization on actions (generate, resolve, merge, export).
- Audit all actions with actor, timestamp, operation, and reason.

Operational requirements

- Idempotency for creates and bulk imports.
- Monitoring and alerting for decryption failures, KMS errors, and unusual resolve volumes.
- Sandbox/test keys and a separate test dataset that guarantees no collision with production.

Performance and scaling

- Expect high read-to-write ratio. Cache non-PII metadata at the edge (CDN) or using a read-optimized store.
- Horizontal scaling behind a load balancer; stateless API servers and single durable store for PID mapping.

Migration & dedup strategy

- Bulk backfill with idempotency keys and retain source IDs.
- Probabilistic matching pipeline (name/DOB/address) followed by human review for merges.
- Keep a mapping table of legacy ids → new pid for a reasonable retention window.

## 4. Short risk and mitigation list

- Risk: deterministic PID generation exposes linkability if secret compromised.
  - Mitigation: prefer random tokens for production; if deterministic needed, protect secret in KMS and limit use.
- Risk: key-management failure (lost key version) prevents decryption.
  - Mitigation: documented key-rotation, backup, and emergency unwrap procedures; test rewrap during maintenance windows.
- Risk: downstream systems expect SSNs or other PII as join keys.
  - Mitigation: integration adapters and a phased cutover with parallel-run and reconciliation reports.
- Risk: duplicate resolution at scale is labor-intensive.
  - Mitigation: invest in probabilistic matching and a human-in-the-loop UI for merges.
- Risk: audit and legal discovery demands access to PII.
  - Mitigation: clearly defined access paths, RBAC, and a legal/operations playbook for requests.

## 5. Questions for today's client meeting

1. Do you require PIDs to be non-reversible (one-way) or must authorized parties be able to fully resolve to PII?
2. Which roles/systems must be allowed to resolve PID→PII? Are there external third parties (ClassWallet, vendors) that need this capability?
3. Is there a statutory retention or deletion requirement for PII we must enforce? Who owns retention policy decisions?
4. Do you have a preference on identifier format (opaque random like UUID/ULID, short human token, or deterministic HMAC)?
5. Is deterministic generation required for onboarding dedup, or can we use a hybrid/dedup pipeline instead?
6. What are the expected throughput and latency SLOs for generate and resolve operations (p50/p95/p99)?
7. Who owns merge decisions and what business rules should drive automatic vs manual merges?
8. For migration: can we run a phased backfill (parallel-run), and will legacy source IDs be retained for lookups during transition?
9. Which KMS/key-store should we use? (Recommended: Azure Key Vault). Who will manage key rotation and access?
10. Do we need a separate sandbox/test namespace and guaranteed non-colliding test tokens?
11. Is parental consent required before issuing a PID for minors, or can PIDs be created automatically on record creation?
12. What systems must adopt PID immediately and which can adopt later? Prioritize integration order (MyPortal, Application Service, RDS, Payments, ClassWallet).
13. Preferred rollout approach: phased by system/context or a single cutover date?
14. Incident response: who will be notified and what is the escalation path if the PID service is compromised?

## 6. Suggested immediate next steps (for the project team)

1. Confirm the resolution policy (reversible vs non-reversible) and key management choice.
2. Approve an API contract (OpenAPI skeleton) and RBAC model for the PID Service.
3. Prototype a minimal PID service (random token mode) and run a small backfill of a sample dataset to validate dedup processes.
4. Schedule a migration/dedup workshop with data owners and a representative sample of legacy records.

---

Prepared by: project research

## 7. PID formatted value — length, encoding, and human-friendly tokens

This section clarifies what we mean by the "formatted value" of a PID and gives concrete recommendations.

Key concepts

- Entropy (bits): how many random bits the token encodes. More bits → lower collision probability.
- Charset: which characters are allowed (base32, base58, base62, hex). Some charsets are easier for humans.
- Representation length: number of characters presented to users or systems.
- Collision model: with n issued tokens and H bits of entropy, expected collisions ≈ n^2 / (2 * 2^H) (birthday approximation).

Common encodings and examples

- UUIDv4 (hex): 128 bits of randomness (commonly shown as 36 characters with hyphens, 32 hex chars without). Very low collision risk but long and not human-friendly.
- ULID / Base32 Crockford: 26 chars (130 bits encoded). Human-sortable (time prefix), human-friendly charset, compact for storage.
- Base58 (Bitcoin alphabet): ~5.86 bits per char — shorter tokens for the same entropy compared to base32/hex, but less standard for text input.

Tradeoffs for "license-plate style" short tokens

- Short tokens (6–8 chars) are easy to read and type, but carry low entropy and therefore higher collision risk unless centrally issued and checked.
- If you must use short, license-plate-style tokens:
  - Issue them centrally (service guarantees uniqueness at create time).
  - Reserve a character set that avoids ambiguous characters (e.g., omit 0/O and 1/I/L).
  - Add a check digit (single checksum character) to detect common transcription errors.
  - Accept that long-term scale (tens of millions) is infeasible with 6–8 chars without collisions.

Collision math—practical guidance

- Example: base32 characters ≈ 5 bits/char.
  - 8 chars ≈ 40 bits. For n = 10 million (1e7) records, expected collisions ≈ 1e14 / (2 * 2^40) ≈ 45 (too high).
  - 12 chars ≈ 60 bits. For n = 10 million, expected collisions ≈ 4.3e-5 (negligible). For n = 100 million, ≈ 0.004 (still very small).
  - 26 chars (ULID) ≈ 130 bits: collision probability is effectively zero for any plausible population.

Checksum & transcription

- A short checksum (1–2 chars) appended to a human token catches common mistakes and prevents trivial mistypes from resolving to a different valid PID.
- Options: a 6-bit CRC (maps to one base64/base32 char) or a single mod-N check character (e.g., modulo 37 with alphanumeric mapping).

Formatting & presentation

- Use uppercase and group characters (e.g., XXXX-XXXX-XXXX) for readability.
- Prefer character sets without confusing glyphs (Crockford base32 is good: 0 and O are mapped/normalized; humans can type easily).

Recommendations (practical defaults)

1. Default (production, privacy-first): ULID or UUIDv4 encoded in a compact string. Example: ULID (26-char Crockford base32) — good entropy, sortable, and reasonably compact.

2. If human-entry is required but you still need safety at scale: use a 12–16 character base32 token (60–80 bits of entropy) plus a single checksum char and group with dashes for readability.

3. License-plate style (only if absolutely necessary): 8–10 central-issued chars + 1 checksum char, central uniqueness enforcement, and explicit limitation that these tokens are not generated client-side.

4. Always version the format (prefix like `PIDv1-`) so you can change encoding or length later without ambiguity.

5. Document the charset and a normalization policy (uppercase, strip spaces/dashes, map common ambiguous chars) so integration teams can implement robust parsing.

Summary

Short, license-plate-like PIDs are convenient but risky at scale unless you centralize issuance and keep a checksum. For most K12 use-cases where durability, privacy, and scale matter, prefer 26-char ULID (or UUIDv4) or a 12–16 char base32 token with checksum when human entry is required.

