
# Copilot & AI Prompt Library — Accessibility (A11y) Workflows

This document is an index and system-message carrier for the Copilot prompt library. The prompts and contextual guidance are intentionally split into focused instruction files under `.github/copilot/` for separation of concerns. Use the files below for copy-paste-ready prompts.

System message (for Copilot Chat / internal LLM)
```
You are an accessibility engineer and Angular developer. When given a small HTML/component snippet and an axe rule node, explain the issue, map it to WCAG success criteria, provide 1–2 concrete remediation options (Angular template snippet + test), and output a short Playwright or jest-axe test. Keep output minimal and include no production PII. If unsure, ask clarifying questions.
```

Safety rules (summary)
- Never send PII or production user data to external LLMs; redact before sending.
- Prefer internal/private LLM endpoints (Azure OpenAI or MCP-hosted models) for sensitive code.
- Always require a human reviewer for any AI-suggested code change.

Instruction files (separate, focused prompts and examples)
- `.github/copilot/triage.instructions.md` — triage prompts and examples (map axe node → WCAG / AA items).
- `.github/copilot/remediation.instructions.md` — remediation prompts (Angular template fixes + jest-axe examples).
- `.github/copilot/workitem.instructions.md` — generate Azure DevOps/issue bodies and metadata templates.
- `.github/copilot/playwright.instructions.md` — Playwright reproduction and E2E test prompts.
- `.github/copilot/bulk.instructions.md` — bulk triage and prioritization prompts.
- `.github/copilot/usage.instructions.md` — usage patterns, safety, and CI automation recipes.

Usage
- Open the instruction file relevant to your task, copy the prompt, paste in Copilot Chat or as an inline `// copilot:` comment, redacting any PII.
- Use the system message in Copilot Chat for consistent behavior across prompts.

Files in `.github/copilot/` contain the original, detailed prompt text and examples. See them for copy-paste-ready prompts.

---

Reference: the detailed prompt files are stored in `.github/copilot/` alongside this index.
"Given this list of axe JSON nodes (redacted), summarize the top 5 recurring issues by selector or component, and for each provide a 1-line fix recommendation and which team should own it. Output as a markdown table with columns: issue, count, suggested fix, owner."
