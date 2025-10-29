# Usage & Automation Recipes — Copilot + AA acceptance

Purpose: Usage patterns, security guidance, and CI automation recipes for integrating Copilot into AA acceptance workflows.

Sections

1) Recommended dev flow
- Reproduce in Storybook or Playwright, copy minimal HTML/template.
- Use Triaging snippet to map to AA acceptance items.
- Use Remediation snippet to get code + jest-axe test.
- Implement in a branch, run unit & E2E tests locally.
- Push PR with `accessibility` label and fill the PR checklist.

2) CI automation recipe
- Playwright + axe job runs on PR and nightly.
- If critical/serious violations, create/update work items and attach axe JSON.
- Optionally call internal LLM (sanitized) to generate suggested remediation and append to work item (developer must opt-in).

3) Safety & PII rules
- Sanitize HTML snippets. Remove names, IDs, and sensitive attributes before LLM submission.
- Prefer internal LLM endpoints. If using 3rd-party, ensure legal approval.

4) Traceability
- Add `LLM metadata` in work item comment: model, prompt hash, and date.
- Annotate code with `// LLM-suggested-fix: prompt-hash=...` for reviewers.

5) Example Git hook
- Pre-commit: add a hook to inject `// LLM-suggested-fix` when developer indicates the change was LLM-assisted (simple `git commit-msg` template).


