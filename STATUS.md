---
localization: unchecked
translation_en: unchecked
translation_fr: unchecked
mod:          Red Wolves Renew
packageId:    nelim.redwolves
repo:         Rimworld-Red-Wolves-Renew
visibility:   public
detached:     no
workflow_stage: setupRepo
licence:      open
licence_at:   upstream LICENSE file, MIT
dependencies: to check
showcase:     none
tested_on:
workshop:
remaining:
  - "2026-11-02: defect: STATUS.md not from template (remote, settings_audit, upstream_mod_remotes missing), 1.h"
  - "2026-11-02: defect: no git remote, no GitHub repo linked, 1.e/1.f"
  - "2026-11-02: unverified: 1.b source/licence not recorded (1.a duplicate search done 2026-11-02: only upstream Red Wolves 2014889466 and Dire Wolf 2092915394 carry a red wolf def, no other duplicate)"
  - "2026-11-02: defect: About.xml description names 1.6 (rimworld-version warning)"
  - "2026-11-02: unverified: never seen running"
session:      maj:        2026-09-12, releve automatique
updated: 2026-11-02
---

# Red Wolves Renew — status

Read by a sweep across every mod, rather than by asking each thread in turn. It lives at the
root, never inside `Mod/`, so Steam never receives it.

The fields above were read off the disk on 2026-09-12. Four cannot be, and wait for whoever
holds this mod:

- **`stage`** — one of `port`, `showcase`, `preTest`, `done`, `tested`, `published`. Filled in
  from the session group where one exists; confirm it.
- **`tested_on`** — the date of the last run in game. Empty means never.
- **`dependencies`** — `declared` when every mod this one needs is named in the About's
  `modDependencies`, `to check` when a non-vanilla `loadAfter` suggests a dependency that is not
  declared, `none` when the mod needs nothing. An undeclared dependency is not cosmetic: on
  2026-09-11 Reequilibrage animaux took 47 vanilla animals down with it, Muffalo included, because
  the class it injects belongs to a mod that was not declared and not loaded.
- **`remaining`** — what is left, in three kinds: `feature` for something missing from a first
  release, `defect` for a known fault left unfixed, `unverified` for what could not be checked.
  The line already there is true of nearly the whole repository; replace it once it stops being.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source,
`alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing
to anyone — not a name, not an idea traceable to one mod, not a value derived from its assets.
