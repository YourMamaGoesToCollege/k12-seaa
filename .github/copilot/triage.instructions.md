# Triage Prompts — Map axe node → WCAG / AA checklist

Purpose: Fast prompts to map an axe violation node to the WCAG AA acceptance checklist and provide short remediation suggestions.

System reminder: Use the repository system message in `COPILOT_PROMPTS.md` when running these prompts in Copilot Chat.

Prompts

1) Short mapping
```
Map this axe node to the WCAG 2.1 AA acceptance checklist items and explain in 2 bullets why it fails.
Node: {paste axe node JSON (redacted)}
```

2) Short mapping + reproduction steps
```
Explain the violation in 2 bullets, map to WCAG AA items, and provide 3 quick steps to reproduce in Playwright.
Node: {paste axe node JSON (redacted)}
```

Examples

Node example (redacted):
```
{
  "id": "color-contrast",
  "impact": "critical",
  "help": "Elements must have sufficient color contrast",
  "nodes": [ { "html": "<button class=\"cta\">Buy</button>", "target": [".cta"] } ]
}
```

Use the "Short mapping" prompt above with the example to get a 2-bullet explanation and the WCAG codes (e.g., 1.4.3 Contrast (AA)).
