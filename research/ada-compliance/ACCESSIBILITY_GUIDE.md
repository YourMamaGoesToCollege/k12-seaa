# Accessibility & ADA (WCAG) Guidance for Angular 19

This file consolidates accessibility tool recommendations, testing checklists, CI guidance, and Angular-specific tips for an Angular 19 application. Use it as a living guide for devs, QA, and accessibility reviewers.

## Recommended tools

- axe-core / jest-axe / @axe-core/playwright
- Playwright for E2E automation (preferred) or Cypress
- Storybook + @storybook/addon-a11y for component-driven checks
- pa11y / pa11y-ci for page-level CI checks
- lighthouse / lighthouse-ci for periodic audits
- Accessibility Insights and Chrome Accessibility Panel for manual inspection
- NVDA (Windows) and VoiceOver (macOS) for screen reader testing

## Quick checklist

### Component-level (Storybook + unit tests)

- Semantic HTML elements used where possible
- Accessible names for interactive controls (labels, `aria-label`, `aria-labelledby`)
- Focusable elements and visible focus styles
- Keyboard interactions documented and validated
- Role/state attributes present when needed (`aria-expanded`, `aria-pressed`)
- Color contrast meets WCAG AA
- jest-axe run for each component story

### Page-level

- Landmarks and skip link exist and function
- Form controls have explicit labels and associated error messages (aria-describedby)
- Modals trap focus and restore focus on close
- Dynamic content uses Live Region announcements or LiveAnnouncer
- Data tables have headers and captions
- Keyboard-only journeys complete all critical flows

### Manual checks

- Screen reader walkthroughs for key flows
- Keyboard-only walkthrough
- Mobile assistive tech (VoiceOver/TalkBack)
- High-contrast and zoom (200%) checks

## Playwright integration (recommended)

- Use `@playwright/test` + `axe-core` to run accessibility scans during E2E tests
- Fail CI on Critical/Serious violations
- Store axe reports as artifacts

## Angular-specific tips

- Use `@angular/cdk/a11y` (FocusTrap, LiveAnnouncer)
- Prefer Angular Material or an accessible UI library as a baseline
- Implement a focus management service for route changes
- Avoid decorative ARIA; prefer native semantics
- Use `aria-hidden` carefully for presentational content

## CI strategy

- PRs: run unit tests (jest-axe) and Storybook a11y checks
- Pre-merge: run Playwright E2E with axe on preview build
- Nightly: lighthouse-ci full-site audit
- Annotate PRs with report summaries and GitHub annotations for failures

## Acceptance policy

- Blockers/Critical: must fix before merge
- Serious: fix in same sprint
- Minor: schedule in backlog

## Resources & references

- WCAG 2.1 AA guidelines
- axe-core documentation
- Playwright docs (accessibility section)
- Angular CDK a11y docs

---

For runnable examples and CI workflow, see the files in `research/ada-compliance/playwright` and `.github/workflows`.
