# Bulk Triage Prompts — Summarize recurring issues

Purpose: Prompts to summarize recurring a11y patterns across an axe report or set of nodes.

Prompts

1) Top recurring issues
```
Given a list of axe nodes (redacted), summarize the top 5 recurring issues by selector or component and for each provide a 1-line recommended fix and suggested owner. Output as a markdown table with columns: issue, count, suggested fix, owner.
```

2) Prioritization matrix
```
Given a list of violations with impact and routes, produce a prioritized remediation matrix (priority, rule id, selector, route, suggested owner).
```
