# VS Code Copilot Prompt Snippets — Accessibility

This repository includes a set of VS Code snippets (`.vscode/a11y-prompts.code-snippets`) to make it fast for developers to invoke Copilot for accessibility triage and remediation.

How to install

1. Project-level (recommended for team): commit `.vscode/a11y-prompts.code-snippets` to the repo (already present). Developers will get the snippets when they open the project in VS Code.

2. User-level (optional): copy the JSON into your VS Code User Snippets: open `Preferences: Configure User Snippets` → choose `New Global Snippets file` → paste the contents.

How to use

- Trigger by typing the snippet prefix (e.g., `a11y-explain`, `a11y-fix-test`) in the editor and pressing Tab.
- Each snippet inserts a short Copilot prompt comment and an editable placeholder where you paste the small HTML or component fragment.
- After expansion, place the caret on the prompt line and invoke Copilot or Copilot Chat (Ctrl+Enter / Copilot command) to produce suggestions.

Security & safety

- Remove any PII or production data before sending snippets to an external LLM.
- Prefer using Copilot with an internal/private model when available.
- Always add automated tests (jest-axe or Playwright) for any Copilot-suggested change.

Recommended workflow

1. Reproduce the failure in Storybook or Playwright and copy the minimal HTML or template fragment.
2. Use `a11y-explain` to get a short explanation and WCAG mapping.
3. Use `a11y-fix-test` to get a suggested fix + jest-axe test. Paste the suggestion into a local branch.
4. Add tests and run Playwright locally, then push a PR with `// LLM-suggested-fix: prompt-hash=...` and link to the accessibility issue.

If you want, I can also create a small VS Code extension scaffolding that preloads these prompts as commands in the Command Palette. Want me to scaffold that? 
