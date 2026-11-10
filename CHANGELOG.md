# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it
in game.

## [Unreleased]

On release: create the `v1.0.0` tag and the matching GitHub release.

First release of the 1.6 update of **Red Wolves**, by Pausbrak, last supporting 1.4.

The shortest of these updates: the animal itself needed no change at all.

Fixed: the two Pawnmorpher backstories were written as `AlienRace.BackstoryDef` with a `<baseDescription>` field, neither of which exists in Humanoid Alien Races 1.6 (they are `AlienRace.AlienBackstoryDef` and `<description>`), and listed skill gains as `<li><defName>` where 1.6 reads `<Skill>amount</Skill>`, so the game logged errors and did not load them; their French text moved with them.

### Added

- Support for RimWorld 1.6.
- **Dogs mate and Better Crossbreeding patches** (`Patches/Compat_DogsMate.xml`, `Patches/Compat_BetterCrossbreeding.xml`). The red wolf joins the "Wolf" group of Dogs mate beside the timber wolf, and crosses with the vanilla timber wolf each way under Better Crossbreeding, the pup being either parent's kind. Both are inert when the mod is absent. Nocturnal Animals needs nothing: the red wolf inherits the timber wolf's classification from `ThingBaseWolf`.
- `LICENSE`, the upstream MIT notice, which is what MIT asks in exchange for redistribution.

### Changed

- **The A Dog Said patch is rewritten, because it had stopped working.** It named thirteen recipes
  one by one and guarded on the display name of A Dog Said 1. ADS 2 renamed every one of them, and
  ADS 1 is dead: the guard never matched, and had it matched the xpath would have selected nothing.
  The mod promised prosthetics for the red wolf and delivered none. It now adds the animal to ADS 2's
  three category lists, `ADS_Cat1`, `ADS_Cat2`, `ADS_Cat3`, where `Wolf_Timber` sits, behind a
  `PatchOperationConditional` that stays silent when ADS 2 is absent.
- **`About.xml` declares `loadBefore` on `SamBucher.ADogSaidAnimalProsthetics2`.** That mod copies
  its category lists onto the real surgery recipes once, at its own pass; a mod loaded after it
  writes into a list nobody reads again.
- **The description no longer promises Combat Extended "reworked tools".** The line now says what the patch applies: melee dodge, crit and parry chances for the red wolf.
- **`LoadFolders.xml` rewritten for a single version.** The original arbitrated 1.1 through 1.4 and
  their conditional integrations; the folders have moved up out of `1.4/`. The two `IfModActive`
  conditions are Pausbrak's, unchanged, package ids included.

### Removed

- **The Combat Extended `tools` replace.** It targeted `Wolf_Red/tools`, which the def does not declare (the tools are inherited from `ThingBaseWolf`), so it never applied. The melee chances of the same patch are kept.

- `Textures/Things/Wolf_Red/Wolf_Red_SkinSet.xml`, the configuration file for a third-party
  animal-variants assembly. The mod stopped using it at 1.1, when the four coats moved to the
  game's own `alternateGraphics`.

### Notes

`Races_Animal_RedWolf.xml` is byte for byte the 1.4 file. The red wolf declares no `wildness` of
its own, so the change that silently untamed most animal mods on 1.6 could not reach it; it already
used vanilla `alternateGraphics` for its coats; and it lays no eggs. No balance value was changed.

Three of the four integrations, Combat Extended, Pawnmorpher, Animal Gear, ship as they shipped
upstream; the fourth is rewritten above. None has been tested against a **running** 1.6 build of
the mod it targets, only read against its files on disk. All four are inert while their target is
absent.
