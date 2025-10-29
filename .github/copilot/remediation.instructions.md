# Remediation Prompts — Generate Angular fixes + tests

Purpose: Prompts that produce concrete Angular template fixes and unit/E2E tests (jest-axe, Playwright) for developers to review and apply.

Prompts

1) Fix + jest-axe test
```
You are an Angular accessibility expert. For this component template: ```<div role="button" class="pay">Pay</div>``` provide: (1) an accessible Angular template replacement, (2) a jest-axe unit test that asserts no axe violations for the corrected component, and (3) a 1-line PR description. Output only the code blocks and the PR description.
```

2) Fix with ARIA and rationale
```
Provide an accessible fix using ARIA or native semantics (choose the best). Explain in 2 bullets why this is accessible and map to WCAG AA codes.
Component template: {paste template}
```

3) Safety wrapper
```
Before suggesting code, ensure no PII is present. If PII exists, return 'PII detected - redact and retry.'
```

Guidance
- Prefer native semantics over ARIA.
- Include tests alongside fixes (jest-axe preferred for unit, Playwright for E2E).
- Output must be minimal and reviewable; avoid large refactors without prompting.
