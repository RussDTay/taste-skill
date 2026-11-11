# Notices

web-design-power bundles five skills as internal modules. Each module keeps its original licence
file in its folder. Its `GUIDE.md` is the original `SKILL.md` with the frontmatter removed and
install paths pointed at this skill.

| Module | Source | Author | Licence |
|---|---|---|---|
| `modules/impeccable` | impeccable (pbakaus/impeccable) | Paul Bakaus and contributors | Apache-2.0 (see `modules/impeccable/LICENSE`, `NOTICE.md`) |
| `modules/taste` | taste-skill (Leonxlnx/taste-skill) | Leonxlnx | MIT |
| `modules/unslop` | unslop (heydamir/unslop) | Damir Sokolovsky ([@heydamir](https://x.com/heydamir)) | CC BY 4.0. Keep this credit in any copy or adaptation |
| `modules/design-extract` | designlang / design-extract | Manavarya Singh | MIT |
| `modules/playwright` | playwright-cli (microsoft/playwright-cli) | Microsoft | Apache-2.0 |

Changes made to the modules: frontmatter removed, `SKILL.md` renamed to `GUIDE.md`, hard-coded
install paths rewritten to `modules/<module>/`. Rebuild with `tools/build-web-design-power.sh`.
