# Using taste-skill with Gemini in a company

Gemini reaches this skill through three routes, depending on the product. Pick the one your
company has approved. Section 5 lists what is verified and what is not.

## 1. Gemini CLI: install as an extension (recommended)

This repo now has a `gemini-extension.json` and a root `GEMINI.md`. Gemini CLI discovers the skills
in the extension's `skills/` folder automatically.

```bash
# from an internal mirror (preferred in a company)
gemini extensions install <internal-mirror-url>
# or from a local checkout, for testing; changes show up without reinstalling
gemini extensions link /path/to/taste-skill
gemini extensions update taste-skill     # after you pull a new reviewed version
```

Check with `/skills list` inside a session: `design-taste-frontend` and `taste-skill-corporate`
should both appear.

## 2. Gemini CLI: vendor into the repository (no extension, no network)

Skills are plain folders with a `SKILL.md`. Gemini CLI reads workspace skills from
`.gemini/skills/` or `.agents/skills/`, and user skills from `~/.gemini/skills/` or `~/.agents/skills/`.

```bash
git clone --depth 1 <internal-mirror-url> /tmp/taste-skill
mkdir -p .gemini/skills
cp -R /tmp/taste-skill/skills/taste-skill .gemini/skills/design-taste-frontend
cp -R /tmp/taste-skill/skills/taste-skill-corporate .gemini/skills/taste-skill-corporate
git add .gemini/skills && git commit -m "Add taste-skill (vendored, reviewed)"
```

Or link a checkout: `gemini skills link /path/to/taste-skill/skills`.
The folder name `design-taste-frontend` matches the skill `name`; keep it.

## 3. Gemini web app, Gems and AI Studio (no file system)

These have no skill loader and cannot run the Node checks. Use the skill as instructions only:

1. Create a Gem (or an AI Studio system instruction) and paste the body of
   `skills/taste-skill-corporate/SKILL.md` (without the `---` frontmatter) plus
   `skills/taste-skill-corporate/references/policy.md`.
2. Optionally attach `skills/taste-skill/SKILL.md` and the `references/` files you need
   (`layout-v4.md`, `copy.md`, `system.md`) as knowledge files. The full skill is about 40 MB with
   assets, so attach only the Markdown.
3. Expect no real-browser checker or finish gate. Ask the Gem to finish with the hand-off note and
   run the checklist in `policy.md` section 2 by hand.

## 4. Company administration notes

- **Network allow-list** for Gemini CLI itself is set by your IT team; the skills add none. The upstream
  scripts can reach cdn.jsdelivr.net, commons.wikimedia.org, picsum.photos and fonts.googleapis.com;
  `taste-skill-corporate` forbids them, and you can block them at the proxy.
- **Data handling:** Gemini CLI sends prompts and file contents to Google's API under your company's
  Gemini or Vertex AI terms. Use the account type your policy requires.
- **Hooks:** the upstream `design-taste-frontend/SKILL.md` has a Claude-specific `hooks:` block that
  runs `gate.mjs` on Stop. Gemini hooks are configured separately (`hooks/hooks.json` in an
  extension) and the event names differ. Until you add an equivalent, run the gate manually:
  `node .gemini/skills/design-taste-frontend/scripts/gate.mjs`. Do not assume it ran.
- **Tool names:** the skill text speaks generally ("run", "read"), not Claude tool names, so it should
  read correctly to Gemini. Test one real page before rollout.
- **Pinning:** pin to a commit and re-review on update.

## 5. Verified and not verified

Verified against Gemini CLI's public docs: skills are folders with `SKILL.md`, discovered in
`.gemini/skills/` and `.agents/skills/`; extensions use `gemini-extension.json` with an optional
`contextFileName`; `gemini extensions link/update` and `gemini skills link` exist.

Not verified: I have not run Gemini CLI against this repo. Unconfirmed: whether Gemini ignores the
unknown `hooks:` frontmatter silently, and the exact `/skills` listing command in your version.
Run the smoke test below, and fix anything that differs.

## 6. Smoke test

1. Install by route 1 or 2.
2. In Gemini CLI: `/skills list`. Both skills appear.
3. Prompt: "Build a one-page site for a fictional B2B software company, following company policy."
4. Expect: questions about brand guide and approved assets, no Google Fonts or CDN links in the output,
   `grep -rnE 'https?://'` shows no unintended URLs, and a hand-off note at the end.

## Sources

- [Agent Skills (Gemini CLI)](https://geminicli.com/docs/cli/skills/)
- [Creating Agent Skills](https://geminicli.com/docs/cli/creating-skills/)
- [Extension reference](https://geminicli.com/docs/extensions/reference.md)
