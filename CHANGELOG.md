# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it
in game.

## [1.0.0] — unreleased

On release: create the `v1.0.0` tag and the matching GitHub release.

First release of the 1.6 update of **Red Wolves**, by Pausbrak, last supporting 1.4.

The shortest of these updates: the animal itself needed no change at all.

### Added

- Support for RimWorld 1.6.
- `LICENSE`, the upstream MIT notice, which is what MIT asks in exchange for redistribution.

### Changed

- **`LoadFolders.xml` rewritten for a single version.** The original arbitrated 1.1 through 1.4 and
  their conditional integrations; the folders have moved up out of `1.4/`. The two `IfModActive`
  conditions are Pausbrak's, unchanged, package ids included.

### Removed

- `Textures/Things/Wolf_Red/Wolf_Red_SkinSet.xml`, the configuration file for a third-party
  animal-variants assembly. The mod stopped using it at 1.1, when the four coats moved to the
  game's own `alternateGraphics`.

### Notes

`Races_Animal_RedWolf.xml` is byte for byte the 1.4 file. The red wolf declares no `wildness` of
its own, so the change that silently untamed most animal mods on 1.6 could not reach it; it already
used vanilla `alternateGraphics` for its coats; and it lays no eggs. No balance value was changed.

The four integrations — A Dog Said, Combat Extended, Pawnmorpher, Animal Gear — ship as they
shipped upstream and have **not** been tested against 1.6 builds of those mods. They are inert
while their target is absent.
