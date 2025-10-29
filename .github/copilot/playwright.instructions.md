# Playwright Prompts — Reproduce & test accessibility failures

Purpose: Small prompts to generate Playwright tests that reproduce axe failures and assert accessibility post-fix.

Prompts

1) Repro test
```
Write a Playwright test that navigates to route "<route>" and reproduces the issue selector "<selector>" using keyboard navigation. The test should run with `npx playwright test` and include an axe.run() assertion for no critical/serious violations.
```

2) Focus order test
```
Write a Playwright test that validates focus order on <route>, asserts visible focus, and checks that keyboard tabbing reaches all interactive elements.
```

3) Accessibility smoke test
```
Create a Playwright test that runs on the critical flows: login -> application -> document upload -> payment, and runs axe.run() on each page, saving JSON artifacts.
```
