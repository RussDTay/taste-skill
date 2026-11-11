# taste-skill (Gemini CLI context)

This extension bundles two agent skills from `skills/`:

- `design-taste-frontend`: build, redesign or review websites and landing pages (layout, copy, motion, checks).
- `taste-skill-corporate`: company-policy layer. Use it together with the first whenever the work is for a company.
  It overrides the first where policy is stricter (no third-party requests, self-hosted fonts, approved assets only,
  WCAG 2.2 AA, strict CSP, hand-off note).

Activate the matching skill when asked to build, design, restyle or review a web page or UI.
Checks need Node 22+ and Chrome, Edge or Chromium. If they cannot run, say so; never claim a page was checked.
Gemini does not run the Claude Stop hook: run `node <skill>/scripts/gate.mjs` yourself before finishing.
