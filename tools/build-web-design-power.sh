#!/usr/bin/env bash
# Assemble skills/web-design-power from the five source repos.
# Each source skill is vendored as a module with its SKILL.md renamed to
# GUIDE.md, so the result registers as ONE skill with no sub-skills.
#
#   tools/build-web-design-power.sh [SRC_ROOT]   # SRC_ROOT holds the five checkouts (default: ..)
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="${1:-$(dirname "$REPO")}"
OUT="$REPO/skills/web-design-power"
M="$OUT/modules"
NAME=web-design-power

rm -rf "$M"; mkdir -p "$M"

copy() { # src dest
  mkdir -p "$2"; cp -a "$1"/. "$2"/
  mv "$2/SKILL.md" "$2/GUIDE.md"
}

copy "$SRC/impeccable/.claude/skills/impeccable"   "$M/impeccable"
copy "$REPO/skills/taste-skill"                    "$M/taste"
copy "$SRC/unslop/skills/unslop"                   "$M/unslop"
copy "$SRC/design-extract/skills/extract-design"   "$M/design-extract"
copy "$SRC/playwright-cli/skills/playwright-cli"   "$M/playwright"

# Strip frontmatter from module guides (only the root SKILL.md may carry it),
# keeping the module's description as a one-line note.
for g in "$M"/*/GUIDE.md; do
  node -e '
    const fs=require("fs"),f=process.argv[1];let s=fs.readFileSync(f,"utf8");
    const m=s.match(/^---\n([\s\S]*?)\n---\n/);
    if(m){s=s.slice(m[0].length);}
    fs.writeFileSync(f,"<!-- Module guide inside the web-design-power skill. Not a standalone skill. -->\n"+s);
  ' "$g"
done

sed -i "s#directory that contains this SKILL.md#directory that contains this GUIDE.md (\`<skill>/modules/impeccable\`)#" "$M/impeccable/GUIDE.md"
# Re-point hard-coded install paths at the module locations.
grep -rlZ '\.claude/skills/impeccable/' "$M/impeccable" --include='*.md' | \
  xargs -0 sed -i "s#\.claude/skills/impeccable/#.claude/skills/$NAME/modules/impeccable/#g"
sed -i "s#<skill folder>#<skill>/modules/unslop#g" "$M/unslop/GUIDE.md"
# Module-relative "<skill>" in taste docs means modules/taste.
grep -rlZ '<skill>' "$M/taste" --include='*.md' | xargs -0 sed -i 's#<skill>/#<skill>/modules/taste/#g; s#`<skill>`#`<skill>/modules/taste`#g'
# The playwright module's helper agents/hooks are not needed; drop a stray agents dir if any.
rm -rf "$M/unslop/agents"

# Licences
for p in impeccable:impeccable design-extract:design-extract playwright-cli:playwright unslop:unslop; do
  cp "$SRC/${p%%:*}/LICENSE" "$M/${p##*:}/LICENSE"
done
cp "$REPO/LICENSE" "$M/taste/LICENSE"
[ -f "$SRC/impeccable/NOTICE.md" ] && cp "$SRC/impeccable/NOTICE.md" "$M/impeccable/NOTICE.md"
echo "built $OUT ($(du -sh "$OUT" | cut -f1))"
