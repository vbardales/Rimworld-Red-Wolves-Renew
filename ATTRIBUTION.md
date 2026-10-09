# Red Wolves — what was taken, and what was changed

## Source

| | |
|---|---|
| Mod | Red Wolves |
| Author | Pausbrak (Ryan Schneider) |
| Workshop | [2014889466](https://steamcommunity.com/sharedfiles/filedetails/?id=2014889466) |
| Repository | https://github.com/RadHazard/RimworldRedWolves — last push December 2022 |
| Last version supported | 1.4 |
| Licence | MIT — see `LICENSE` |

## What was taken

Everything the 1.4 folder holds, plus the shared assets at the mod root.

| File | Origin |
|---|---|
| `Defs/Races_Animal_RedWolf.xml` | `1.4/Defs/`, **byte for byte** |
| `Patches/Addon_ADogSaid.xml` | `1.4/Patches/`, **rewritten** — see below |
| `Patches/Addon_CombatExtended.xml` | `1.4/Patches/`, unchanged |
| `ModIntegrations/Pawnmorpher/` | `1.4/ModIntegrations/`, unchanged |
| `ModIntegrations/AnimalEquipment/` | `1.4/ModIntegrations/`, unchanged |
| `Textures/Things/Wolf_Red/*` | unchanged, twelve files |
| `Textures/Parts/WolfRed/*` | unchanged — Pawnmorpher body parts |

`LoadFolders.xml` is rewritten: see below.

## What was left behind

- **`Textures/Things/Wolf_Red/Wolf_Red_SkinSet.xml`** — the configuration file for a third-party
  animal-variants assembly. The mod stopped using it at **1.1**, when Pausbrak moved the four coats
  to the game's own `alternateGraphics`; the 1.0 folder still carried an
  `Addon_AnimalVarietyCoats.xml` patch, and 1.1 onward does not. The file has been dead weight in
  `Textures/` ever since, and shipping it would only mislead.
- The `1.0` through `1.3` folders, and the author's `README.md`, `balance.md` and `changelog.md`.
  They are worth reading and they are still online at the upstream repository.

## What was changed

### Nothing in the animal

`Races_Animal_RedWolf.xml` is identical to the 1.4 file, byte for byte. This mod is the exception
among the animal ports:

- **No wildness breakage.** The red wolf declares no `wildness` of its own, inheriting
  `ThingBaseWolf`'s. Vanilla moved that value to the `Wildness` stat correctly on its own, so
  nothing was lost. Every animal that *did* override the field silently lost it in 1.6.
- **No variants breakage.** The four coats already ran on the game's `alternateGraphics` with an
  `alternateGraphicChance`, rather than on one of the third-party assemblies that died with 1.5.
- **No egg breakage.** It lays nothing, so the `CompEggLayer` change cannot reach it.

### `LoadFolders.xml`, rewritten for a single version

The original arbitrated four versions and their conditional integrations. Only 1.6 remains, and the
folders moved up out of the `1.4/` directory, so the file was rewritten rather than trimmed — but
the two conditions are Pausbrak's, unchanged, package ids included:

```xml
<li IfModActive="tachyonite.pawnmorpher, tachyonite.pawnmorpherpublic">ModIntegrations/Pawnmorpher</li>
<li IfModActive="Owlchemist.AnimalGear.Equipment">ModIntegrations/AnimalEquipment</li>
```

A conditional folder is not read at all when its condition fails, which is why the Pawnmorpher defs
can reference Pawnmorpher's own types without risk.

### The A Dog Said patch, rewritten because it did nothing

This is the one place where Pausbrak's file could not be carried over as it stood.

`Addon_ADogSaid.xml` named thirteen recipes one by one — `InstallPegLegAnimal`,
`InstallBionicEyeAnimal`, `InstallBionicAnimalStomach`, `InstallSimpleProstheticTailAnimal` and the
rest — inside a `PatchOperationFindMod` guarded on the display name *A Dog Said... Animal
Prosthetics*. That is **A Dog Said 1**, which is dead. **A Dog Said 2**
(`SamBucher.ADogSaidAnimalProsthetics2`) renamed every recipe the patch targeted. Both halves
missed independently: the guard never matched, and had it matched, the xpath would have selected
nothing. The mod's own description promised prosthetics for the red wolf, which is worse than
saying nothing.

ADS 2 does not name recipes one by one. It keeps three abstract `RecipeDef`s — `ADS_Cat1` (medieval
replacements), `ADS_Cat2` (+ simple prosthetics), `ADS_Cat3` (+ bionics) — declared in
`1.6/Defs/AnimalCategories/Animal_Categories.xml`, and its own last patch copies their
`recipeUsers` onto the real surgery bases. Adding an animal means adding one `<li>` to those lists,
which is what every `ModCompat` file in ADS 2 does.

**All three lists**, because the red wolf is a variant of the timber wolf, and `Wolf_Timber` is in
all three of ADS 2's categories. They are cumulative: sixty animals in the first, fifty-three in
the second, thirty in the third.

Two details that look optional and are not:

- The guard is a **`PatchOperationConditional` on `ADS_Cat1`**, not `MayRequire`. On an
  `<Operation>`, `MayRequire` is read by nothing — `Verse.PatchOperation` has no such field — so
  the operation would apply whether ADS 2 is loaded or not. With the conditional, ADS 2's absence
  selects nothing, no `<nomatch>` is declared, and the operation reports success in silence.
- `About.xml` gained **`<loadBefore>SamBucher.ADogSaidAnimalProsthetics2`**. ADS 2's category patch
  copies those lists onto the real recipes **once**, at its own pass. A mod loaded after it writes
  into a list nobody reads again — the patch would apply cleanly and still change nothing.

## What has not been verified

**No integration has been tested against a running 1.6 build of the mod it targets**, because that
would mean installing and running A Dog Said 2, Combat Extended, Pawnmorpher and Animal Gear. The
A Dog Said patch is written against ADS 2's files as they sit on disk, which is a reading and not a
run. What is guaranteed is the safe half: while those mods are absent, the two conditional folders
are never read, the Combat Extended patch sits inside a `PatchOperationFindMod` guard, and the
A Dog Said patch selects nothing.

## Verification

Two scripts check the mod before release: every def reference and every `ParentName` resolves
against **Core alone**, so no DLC is required, and each reference points at the right *type* of def.

The validators read the whole folder, `ModIntegrations/` included, so they do report unresolved
names there — eight `ParentName`s and sixteen C# types. Every one of them belongs to Pawnmorpher,
Humanoid Alien Races or Combat Extended, and every one sits either inside a conditional folder or
inside a `PatchOperationFindMod` guard. That list is the expected output, not a defect: the game
never reads those files unless the mod that defines those names is loaded. Anything appearing
outside that list would be a real fault.
