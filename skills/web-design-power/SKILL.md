---
name: web-design-power
description: >-
  One power-user UX and web design skill that covers the whole job: research and flows, information
  architecture, UX planning, building new pages and app UI, design systems and tokens, critique with
  heuristic scoring, accessibility and performance audits, polishing, de-slopping AI-looking UI,
  copy, typography, color, layout, motion, responsive and native adaptation, extracting the design
  language of any live website, and verifying everything in a real browser. Use whenever the user
  wants to design, redesign, plan, critique, audit, polish, restyle, animate, test or extract a
  website, landing page, dashboard, app screen, component, flow, onboarding or design system, says
  a UI looks generic, templated or "AI-made", asks for UX help of any kind, or types
  /web-design-power.
argument-hint: "[ux|shape|build|site|unslop|extract|critique|audit|polish|test|... any impeccable command] [target]"
user-invocable: true
license: See NOTICE.md (Apache-2.0, MIT and CC-BY-4.0 modules)
hooks:
  Stop:
    - hooks:
        - type: command
          command: 'for f in ${CLAUDE_SKILL_DIR:+"$CLAUDE_SKILL_DIR/modules/taste/scripts/gate.mjs"} ${CLAUDE_PROJECT_DIR:+"$CLAUDE_PROJECT_DIR/.claude/skills/web-design-power/modules/taste/scripts/gate.mjs" "$CLAUDE_PROJECT_DIR/.agents/skills/web-design-power/modules/taste/scripts/gate.mjs"} ${HOME:+"$HOME/.claude/skills/web-design-power/modules/taste/scripts/gate.mjs" "$HOME/.agents/skills/web-design-power/modules/taste/scripts/gate.mjs"}; do if [ -f "$f" ]; then exec node "$f" --hook claude; fi; done; exit 0'
          timeout: 600
---

# Web Design Power

This is one skill. It contains five specialist toolkits as **modules**. They are not separate
skills and never get installed or invoked as separate skills. You pick the module (or the chain of
modules) the request needs, read that module's `GUIDE.md`, and run its references and scripts from
inside this folder.

`<skill>` is this folder, the one that holds this SKILL.md. Every module lives at
`<skill>/modules/<module>/`, and inside a module guide, "this folder", "the skill folder",
`<skill-base-dir>` and relative links all mean that module's own folder.

| Module | Folder | What it is best at |
|---|---|---|
| **impeccable** | `modules/impeccable` | The design-director engine. UX planning (`shape`), product context (`init`, PRODUCT.md), design systems (`document`, `extract`, DESIGN.md), heuristic critique, a11y/perf/responsive audit, 20+ refine commands, native iOS/Android, live variant mode, anti-pattern detector |
| **taste** | `modules/taste` | Building complete marketing and company websites from a brief: copy layer, dealt palettes/heroes/moments, real photographs and icons, a design kit, and a finish gate that checks the page in headless Chrome |
| **unslop** | `modules/unslop` | Turning vibecoded, AI-looking UI into a designed screen: a slop audit, a five-line direction, then nine ordered passes (spacing, color, icons, copy, type, layout, details, visuals, motion), plus a story video |
| **design-extract** | `modules/design-extract` | Pulling the full design language out of any URL (`npx designlang`): colors, type, spacing, shadows, components, WCAG score, plus Tailwind, shadcn, CSS variables, Figma variables and W3C tokens |
| **playwright** | `modules/playwright` | Driving a real browser: open, click, fill, snapshot, screenshot, record video, trace, mock requests, write Playwright tests. The eyes and hands for every verification and usability walk-through |

## Laws that hold across every module

1. **The brief wins.** A pinned palette, font, era, brand or constraint beats any module default,
   including taste's house rules and unslop's token suggestions. Redirecting a clear brief toward
   house taste is failure.
2. **Project truth before taste.** Read PRODUCT.md, DESIGN.md, existing tokens and components, and
   the running app before deciding anything. Refinement keeps the incumbent identity. Redesign
   replaces the look but keeps product truth, content and function.
3. **Decide the mode for the surface, not the product** (impeccable's Modes): **Persuade**
   (landing, marketing, pricing), **Operate** (app UI, dashboards, tools, settings), **Read** (docs,
   articles, help), **Experience** (portfolio, gallery). Persuade and Experience get bold, committed
   work. Operate and Read get precision, restraint and familiar patterns.
4. **Look at it.** Every design claim is checked against the rendered page at the sizes it ships
   at (at least 1440, 768 and 390 wide), through the module's own checker or the playwright module.
   Batch fixes between looks; do not screenshot after every tweak.
5. **Richness goes in content, not chrome.** Quiet neutrals and one accent for navigation, buttons
   and text; color, material and craft go into one or two moments the product owns. No purple-blue
   gradients, glows, gradient text, emoji labels, sparkle badges or glossy blobs unless the brief
   asks for them by name.
6. **Plain, specific copy.** Headlines name the thing and the buyer. Buttons are a verb and an
   object. No invented facts, testimonials, logos or metrics; anything assumed is marked and listed
   in the report.
7. **Accessibility is checked, not worried about.** Design boldly first, then let the audit
   (impeccable `audit`, taste's gate, design-extract's WCAG score) find contrast, focus, target size,
   motion and semantics problems, and fix every one.
8. **Finish the job.** The deliverable is complete except assets only the user can provide, and the
   report names those.
9. **Stay one skill.** Never run impeccable's `pin` verb or copy a module out as its own skill. If
   the user wants a shortcut, tell them to type `/web-design-power <command>`.

## Setup (once per session, before design work)

1. **Context.** Run `<skill>/modules/impeccable/scripts/impeccable context` from the user's project
   (on Windows without `sh`: `impeccable.cmd`). It loads PRODUCT.md, DESIGN.md, the surface brief and
   native-platform guidance and prints directives; follow them and do not rerun it. If it fails, say
   "Context loading did not run; I'll read the existing project context directly." and read those
   files yourself. Skip this step only for a pure extraction or browser-automation request.
2. **Platform.** Web is the default. When PRODUCT.md says `ios`, `android` or `adaptive`, impeccable
   routes to its native references and native variants. Live mode, the detector and taste's kit are
   web-only.
3. **Tools.** Node 22+ and a Chromium-family browser serve taste, unslop and design-extract. The
   playwright module needs `playwright-cli` (`npx playwright cli` with Playwright 1.59+, or `npm install -g @playwright/cli@latest`, see its Installation section);
   use plain Playwright when that is missing. Impeccable's launcher fetches its own engine binary on
   first run.
4. Read `<skill>/modules/impeccable/reference/craft-floor.md` immediately before the first UI edit of
   the session, whatever module is driving. It carries the quality floor and the absolute bans.

## Routing

Read the request, pick the row, open that module's `GUIDE.md` (and the references it names), and
follow it. Chains run left to right. When two rows fit, ask once.

| The user wants | Module chain | Start at |
|---|---|---|
| No argument, or "what can you do" | menu | Show the **Command menu** below, tailored to what `impeccable context` found. Never auto-run a command |
| UX end to end: "design the UX for", a flow, a feature from scratch | **UX pipeline** below | This file |
| Plan UX/UI before code: users, jobs, flows, IA, states | impeccable `shape` | `modules/impeccable/reference/shape.md` |
| Capture product context (users, voice, platform) | impeccable `init` | `modules/impeccable/reference/init.md` |
| A new marketing, company, product, shop, cafe, SaaS or game **website** from a brief (Persuade, web) | taste, then playwright verify | `modules/taste/GUIDE.md` |
| A new app screen, dashboard, tool, docs page or other Operate/Read surface | impeccable new-work | `modules/impeccable/reference/new-work.md` |
| A new native iOS/Android screen | impeccable new-work with native refs | `modules/impeccable/reference/new-work.md`, `ios.md`, `android.md` |
| "Looks AI-made / generic / vibecoded", purple gradients, glows, emoji labels | unslop, then impeccable `audit` | `modules/unslop/GUIDE.md` |
| Fix one aspect: `polish`, `bolder`, `quieter`, `distill`, `harden`, `onboard`, `animate`, `colorize`, `typeset`, `layout`, `delight`, `overdrive`, `clarify`, `adapt`, `optimize` | impeccable command | `modules/impeccable/reference/<command>.md` |
| Review or score a design (UX heuristics, hierarchy, cognitive load) | impeccable `critique` | `modules/impeccable/reference/critique.md` |
| Technical quality: a11y, performance, responsive, theming | impeccable `audit` (+ taste `perf.mjs` for pages) | `modules/impeccable/reference/audit.md` |
| "What design system does this site use", tokens, Tailwind/shadcn theme from a URL | design-extract | `modules/design-extract/GUIDE.md` |
| "Make mine like that site" / competitor teardown | design-extract, then impeccable `document` or new-work using the tokens as reference (not a copy) | `modules/design-extract/GUIDE.md` |
| Write DESIGN.md / design system from existing code | impeccable `document`, then `extract` | `modules/impeccable/reference/document.md` |
| Iterate visually in the browser, pick elements, generate variants | impeccable `live` / `generate` | `modules/impeccable/reference/live.md` |
| Screenshot, click through, test a flow, record a video, write Playwright tests | playwright | `modules/playwright/GUIDE.md` |
| A before/after story video of a redesign | unslop story | `modules/unslop/GUIDE.md`, section Story video |
| Detector hook or drift: `hooks`, `doctor` | impeccable | `modules/impeccable/reference/hooks.md`, `doctor.md` |

Impeccable's references speak of `/impeccable <command>`. Inside this skill that is
`/web-design-power <command>`. A taste or unslop instruction that names its own skill means this one.

### When modules disagree

- Taste's nine house rules and page plans govern **only** pages that taste builds (Persuade websites
  from a brief). They do not apply to app UI, docs, or refinements of an existing site.
- Unslop's rule "the features, content and order of sections stay" wins on any refinement. Use its
  full nine passes only for heavy slop; light slop goes to polish mode or impeccable `polish`.
- Impeccable's mode decides restraint. If taste's dealt effect or moment would land on an Operate
  surface, drop it.
- For tokens, the project's existing DESIGN.md or code wins, then a design-extract reference the user
  chose, then the driving module's defaults.
- Verification tools: taste's own scripts for taste pages (it forbids other browser tools during its
  gate), unslop's snapshot for live-site captures, playwright everywhere else.

## UX pipeline (for "do the UX" requests)

Run these stages in order. Ask the user at the two marked checkpoints, using the question tool when
there is one; skip the wait only if they said to just do it.

1. **Understand.** Run Setup. Read the product, the code and any live URL. If the user names
   competitors or references, run design-extract on up to three and note what each does well,
   without copying.
2. **Shape** (`modules/impeccable/reference/shape.md`). Users and their jobs, the core task, the
   flow as numbered steps with entry points, decisions and exits, the information architecture,
   the content each screen needs, and every state: empty, loading, error, partial, success,
   first-run. Write it to the surface brief the way shape directs.
   **Checkpoint 1:** show the flow and IA and wait.
3. **Direction.** Pick the mode per surface. Persuade websites take taste's deal. Everything else
   takes impeccable's new-work direction. For an existing UI with slop, take unslop's five lines.
   **Checkpoint 2:** show the direction and wait.
4. **Build.** With the driving module's procedure. Copy first, then layout, then visuals and
   motion. Reuse the project's components and tokens.
5. **Harden the UX.** impeccable `onboard` for first-run and empty states, `clarify` for labels and
   errors, `harden` for edge cases, overflow, i18n and failure paths, `adapt` for every breakpoint.
6. **Test like a user.** With the playwright module, walk the primary flow end to end at 1440 and
   390: click every primary action, submit forms with good and bad input, tab through with the
   keyboard only, and screenshot each state. Record a video when the user wants to share it.
   Write a Playwright test for the core flow when the project has a test setup.
7. **Evaluate.** impeccable `critique` (heuristic scores) and `audit` (a11y, perf, responsive).
   Fix every finding of real severity and run the check again.
8. **Document.** impeccable `document` writes or updates DESIGN.md from what shipped.
9. **Report.** Flow and IA, direction, what changed per stage, scores before and after, open
   issues, assumed facts, and assets the user must supply.

## Command menu

Present this when the skill is invoked with no argument.

- **Plan:** `ux` (full pipeline) · `shape` · `init`
- **Build:** `site` (taste website from a brief) · `build` (impeccable new-work) · `document` · `extract` (tokens from code)
- **Steal like an artist:** `extract-url <url>` (design-extract)
- **Evaluate:** `critique` · `audit` · `test <url>` (playwright walk-through)
- **Refine:** `unslop` · `polish` · `bolder` · `quieter` · `distill` · `harden` · `onboard`
- **Enhance:** `animate` · `colorize` · `typeset` · `layout` · `delight` · `overdrive`
- **Fix:** `clarify` · `adapt` · `optimize`
- **Iterate:** `live` · `generate`
- **Maintain:** `hooks` · `doctor`

`site` routes to `modules/taste/GUIDE.md`, `build` to `modules/impeccable/reference/new-work.md`,
`extract-url` to `modules/design-extract/GUIDE.md`, `test` to `modules/playwright/GUIDE.md`, `unslop`
to `modules/unslop/GUIDE.md`, `ux` to the UX pipeline above, and every other word to the impeccable
reference of the same name.

## Report shape

End every run with: what was asked, the mode and the module chain used, the direction in one or two
lines, the changes grouped by pass or stage, the verification run and its result (gate line, audit
scores, screenshots taken), anything not verified and why, assumed facts, and what the user still
has to provide.

Credits and licences for every module are in [NOTICE.md](NOTICE.md).
