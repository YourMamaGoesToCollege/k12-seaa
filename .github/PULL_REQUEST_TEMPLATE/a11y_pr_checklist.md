# Accessibility PR Checklist

Please complete this checklist before requesting review.

- [ ] I ran unit tests including `jest-axe` for updated components.
- [ ] I ran Playwright E2E a11y checks locally for affected routes.
- [ ] Storybook stories updated and `@storybook/addon-a11y` shows no critical issues.
- [ ] Keyboard-only navigation has been validated.
- [ ] Screen reader smoke tested (VoiceOver / NVDA) for the critical flow.
- [ ] I added or updated automated tests (jest-axe or Playwright) that reproduce the issue and assert the fix.
- [ ] I linked the Azure DevOps work item that tracks this accessibility fix.
- [ ] I added a short note describing the accessibility impact and verification steps in the PR description.

If the change was suggested by an AI/LLM, include the prompt (redacted) and add `// LLM-suggested-fix: prompt-hash=...` to changed files.
