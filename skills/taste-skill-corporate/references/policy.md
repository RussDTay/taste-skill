# Corporate policy reference

## 1. Neutral defaults (only when no brand guide is supplied)

- Type: system stack `system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif`.
- Colour: one accent, near-black text on white or near-white; every text/background pair at
  4.5:1 or better (3:1 for large text and UI borders).
- Logo: a text wordmark placeholder named `TODO(brand): logo`.
- State in the hand-off that defaults were used, so brand can replace them.

## 2. Pre-hand-off checklist

- [ ] No request leaves the origin (DevTools network tab or `grep -rnE 'https?://'`).
- [ ] No Google Fonts, CDN, analytics, embed or tracking code.
- [ ] Fonts: local `woff2` with licence file, or system stack.
- [ ] Every image is an approved asset or a marked placeholder; every image has alt text (or `alt=""` if decorative).
- [ ] One `h1`, landmark regions (`header`, `main`, `footer`, `nav`), `lang` on `<html>`.
- [ ] Keyboard: everything reachable, visible focus, skip link, no traps.
- [ ] Contrast AA on all text and controls, at all breakpoints (1440, 1024, 768, 390).
- [ ] `prefers-reduced-motion` disables non-essential motion.
- [ ] No inline handlers or `eval`; works under the CSP below.
- [ ] External links use `rel="noopener noreferrer"`.
- [ ] No invented claims, names, numbers, quotes or certifications; open items tagged `TODO(legal)`.
- [ ] Dependencies pinned, licences listed.

## 3. Suggested Content-Security-Policy

```
default-src 'self'; img-src 'self' data:; font-src 'self'; style-src 'self';
script-src 'self'; connect-src 'self'; base-uri 'self'; form-action 'self'; frame-ancestors 'none'
```

Loosen only for a named, approved need (for example `style-src 'unsafe-inline'` if the stack
requires it), and record the reason in the hand-off.

## 4. Hand-off note template

```
Page: <name>             Date: <date>
Brand inputs: <guide used / neutral defaults>
Assets and licences: <file, source, licence>
Fonts: <family, source, licence>
Open items: TODO(legal) ..., TODO(security) ..., TODO(brand) ...
CSP: <as above, with any deviations and why>
Accessibility: <checks run, results, known gaps>
Verification: <what was run (checker, gate, browser sizes) and what was not>
```
