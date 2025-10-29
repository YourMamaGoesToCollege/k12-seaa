# Copilot Inline Prompts — Accessibility (A11y)

Paste these short comment prompts into code or Copilot Chat to get focused guidance and code suggestions for accessibility fixes, tests, and PR text. They're optimized for GitHub Copilot / Copilot Chat in VS Code.

Guidelines

- Keep snippets small and include only the minimal reproduction (a small HTML or Angular template fragment).
- Prefix inline prompts in code with `// copilot:` or `/* copilot:` to nudge Copilot.
- Require a human reviewer for any code change suggested by Copilot.

---

1) Explain violation (short)
// copilot: Explain in 3 bullets why this axe violation is happening and list the closest WCAG success criteria.

Usage: paste this above the axe node HTML snippet.

Example:
// copilot: Explain in 3 bullets why this axe violation is happening and list the closest WCAG success criteria.
// copilot: HTML: <div role="button" class="pay">Pay</div>

---

2) Provide remediation + test (Angular)
/*copilot: Provide (1) an accessible Angular template replacement for the HTML below, (2) a jest-axe unit test that asserts no axe violations, and (3) a 1-line PR description. Output only code blocks.*/
// copilot: HTML: <div role="button" class="pay">Pay</div>

---

3) Generate Playwright reproduction test
// copilot: Write a Playwright test that navigates to route "/apply" and reproduces a failure for selector ".cta" using keyboard navigation. Test must run under `npx playwright test`.

---

4) Create work item body (Azure DevOps)
/*copilot: Using the axe node below, generate a concise Azure DevOps work item body in Markdown with: summary, route or Storybook id, DOM selector, HTML snippet, failure summary, reproduction Playwright snippet (minimal), suggested owner, and tests to add.*/
// copilot: Node: { "id": "color-contrast", "impact": "critical", "html": "<button class=\"cta\">Buy</button>", "target": [".cta"] }

---

5) Bulk triage summary
// copilot: Given a list of axe nodes (paste below), summarize top 5 recurring issues by selector or component and for each provide a 1-line recommended fix and suggested owner. Output as a markdown table.

---

6) PR safety note generator
// copilot: Produce a short PR safety note (2-3 bullets) explaining what manual validation the reviewer must do after applying this a11y fix (keyboard + screen reader + contrast checks).

---

7) LLM prompt sanitizer (developer helper)
// copilot: Sanitize this HTML snippet for LLM submission by removing PII and truncating long attribute values. Return only the sanitized HTML.
// copilot: HTML: <paste HTML here>

---

8) Add `// LLM-suggested-fix` header
// copilot: Generate a single-line header comment to annotate files changed by an LLM-suggested fix with a prompt hash, e.g., `// LLM-suggested-fix: prompt-hash=...`.

---

Usage tips

- Use the smallest reproducible example when asking for code fixes.
- Always add tests (jest-axe or Playwright) to any AI-suggested fix.
- Keep the LLM prompt local (MCP or Azure OpenAI private endpoint) when possible.
