---
name: taste-skill-corporate
description: >-
  Corporate-safe wrapper for the design-taste-frontend (tasteskill) skill. Use this whenever a
  website, landing page, intranet page, product page or UI is built or reviewed inside a company
  and must follow its brand guide, accessibility policy, security rules and approved-asset rules:
  no third-party CDNs, web fonts or hot-linked photos, self-hosted fonts and icons, brand tokens
  from the company guide, WCAG 2.2 AA, a strict Content-Security-Policy, and a written
  hand-off note for design, legal and security review. It applies tasteskill for layout and
  craft, and overrides it wherever company policy is stricter.
---

# taste-skill-corporate

A policy layer over `design-taste-frontend` (tasteskill). tasteskill decides how the page is
composed and checked; this skill decides what a company is allowed to ship. If the two disagree,
**this skill wins**.

## 0. Before building, collect the inputs

Ask once, in one message, and use defaults only where stated:

1. **Brand guide**: colours, typefaces, logo files, tone of voice. If none is given, use the
   neutral defaults in `references/policy.md` section 1 and say so in the hand-off.
2. **Approved assets**: licensed photos, product screenshots, icon set. If none, build without
   photographs (see rule 4). Never invent client names, logos, quotes, metrics or certifications.
3. **Compliance scope**: WCAG level (default 2.2 AA), languages, regions (GDPR/cookie banner
   needed or not), whether the page is public or intranet.
4. **Stack**: static HTML, or the existing framework. Follow the repo's conventions and lint rules.

## Corporate rules (override tasteskill)

1. **No third-party requests at runtime.** No Google Fonts, no CDN scripts or styles, no hot-linked
   images, no analytics, tag managers, embeds or tracking pixels unless the user names them.
   Everything the page needs is served from the same origin.
2. **Fonts are self-hosted** `woff2` files from the brand guide, else a system font stack. Where
   tasteskill's `start.mjs` would emit Google Fonts `<link>` tags, replace them with local
   `@font-face` rules (`font-display: swap`) or the system stack.
3. **Icons are inline SVG or local files** with licences recorded. Do not run `icons.mjs` against a
   CDN on a restricted network; vendor the few icons needed and note their licence.
4. **Photos: only approved assets.** Do not use `photos.mjs` stand-in search (Wikimedia, picsum,
   etc.) for corporate work. With no approved photo, use brand colour, type, real product UI or a
   diagram instead, and leave a clearly marked placeholder slot listed in the hand-off. This
   deliberately overrides tasteskill's "licensed stand-in photographs" behaviour.
5. **Copy is claims-safe.** No unverifiable superlatives, statistics, awards, customer names or
   legal statements. Mark anything that needs sign-off with `TODO(legal):` in the source.
6. **Accessibility is a gate, not a polish step.** Contrast AA, visible focus, keyboard path,
   semantic landmarks, one `h1`, alt text, `prefers-reduced-motion` honoured, 44px touch targets,
   `lang` set. Motion from tasteskill stays, but must degrade to static with reduced motion.
7. **Security headers and markup.** No inline event handlers, no `eval`, no inline scripts that
   block a strict CSP; use external same-origin files or nonces. Provide the suggested CSP in the
   hand-off (`references/policy.md` section 3). External links get `rel="noopener noreferrer"`.
8. **Dependencies.** Prefer none. If one is needed, pin the exact version, state its licence, and
   check it against the company's allowed-licence list if the user provides one.
9. **Privacy.** No cookies, storage or third-party forms by default. If a form is needed, mark the
   endpoint as `TODO(security)` and do not collect more fields than the user specified.
10. **Keep tasteskill's craft rules** (one section per screen, equal edges, no captions under
    images, real-browser checks), except where rules 1 to 9 forbid the asset they assume.

## Workflow

1. Collect inputs (section 0).
2. Load `design-taste-frontend` and follow it for structure, system, copy and motion, applying the
   corporate rules above wherever it reaches for the network, stock photos or fonts.
3. Run tasteskill's checker and finish gate in a real browser, if Node and a Chromium are
   available. The checker runs locally and needs no network for the page itself. If it cannot run,
   say so; do not claim the page was checked.
4. Run the corporate checklist in `references/policy.md` section 2, including
   `grep -rnE 'https?://' <site>` to confirm that the only absolute URLs are intended outbound links.
5. Finish with the **hand-off note** (template in `references/policy.md` section 4): assets and
   licences, fonts, `TODO(legal)` and `TODO(security)` items, the suggested CSP, accessibility
   results, and what was and was not verified.

## Hooks note

tasteskill ships a Stop hook that runs `node scripts/gate.mjs`. Some company environments block
or review hooks. If hooks are disabled, run the gate manually at the end of the task and report
the result. Do not edit the hook to hide a failure.
