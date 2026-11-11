# Installing taste-skill in a corporate environment

The `/plugin marketplace add` flow needs GitHub access from each developer machine and may be
blocked by policy. These routes need no marketplace and no network after the first copy.

## Option A: vendor into the repository (recommended)

Commit the skills into the project so every developer and CI session gets the same reviewed copy.

```bash
git clone --depth 1 https://github.com/Leonxlnx/taste-skill.git /tmp/taste-skill
mkdir -p .claude/skills
cp -R /tmp/taste-skill/skills/taste-skill .claude/skills/design-taste-frontend
cp -R /tmp/taste-skill/skills/taste-skill-corporate .claude/skills/taste-skill-corporate
git add .claude/skills && git commit -m "Add taste-skill (vendored, reviewed)"
```

The folder name `design-taste-frontend` matches the skill's `name`, which its Stop hook expects.

## Option B: per-user install from an internal mirror

Mirror the repository to your internal Git host, then:

```bash
git clone <internal-mirror-url> ~/taste-skill && ~/taste-skill/install.sh
```

## Option C: managed marketplace

Host `.claude-plugin/marketplace.json` from the internal mirror and allow-list it in your managed
Claude Code settings, then users run `/plugin marketplace add <internal-url>` and
`/plugin install taste-skill@taste-skill`.

## Review notes for security teams

- The skill is Markdown, CSS, JS assets and Node scripts (Node 22+ and Chromium to run the checks).
- Upstream scripts can reach cdn.jsdelivr.net (icons), commons.wikimedia.org and picsum.photos
  (stand-in photos) and fonts.googleapis.com (font links). `taste-skill-corporate` forbids these in
  corporate work; additionally block them at the proxy if you want enforcement.
- A Stop hook runs `scripts/gate.mjs` locally. Review it, or disable hooks in managed settings and
  run the gate manually.
- Pin the vendored copy to a commit and re-review on update.
