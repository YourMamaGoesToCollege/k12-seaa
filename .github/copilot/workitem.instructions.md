# Work Item Prompts — Generate Azure DevOps issue bodies

Purpose: Create well-structured Azure DevOps work item bodies from axe nodes for triage and assignment.

Prompts

1) Work item body (detailed)
```
Convert this axe node to a clear Azure DevOps work item body. Include: short summary, route or Storybook id, DOM selector, redacted HTML snippet, failure summary, screenshot link placeholder, reproduction Playwright snippet (minimal), suggested owner (frontend), and tests to add. Output as Markdown suitable for the work item description.
Node: {paste node JSON (redacted)}
```

2) Short issue for quick triage
```
Create a 4-line issue body with title, impact, selector, and 1-line suggested fix.
Node: {paste node JSON (redacted)}
```

Templates

- Use the repository's issue template `.github/ISSUE_TEMPLATE/accessibility_issue.md` as the canonical schema. Populate those fields when creating work items.
- Add `LLM metadata` section: include `model`, `prompt-hash`, and `date` for traceability.
