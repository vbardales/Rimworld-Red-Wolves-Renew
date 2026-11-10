# Test scenarios

One animal (a race def and a kind def), six patches and folders that load only beside another mod, one
translation set, no assembly. Little here can break loudly. What can break **silently** is a patch whose
xpath selects nothing, and a folder whose `IfModActive` id matches no mod: neither writes an error line.
Both faults were found in this port (the A Dog Said patch of the 1.4 version, the Pawnmorpher guard), so an
empty log is not a pass.

## Load order

```
nelim.redwolves                              this mod                             before it
SamBucher.ADogSaidAnimalProsthetics2         A Dog Said... Animal Prosthetics 2   after this mod (loadBefore)
tachyonite.pawnmorpherpublic                 Pawnmorpher                          before this mod (loadAfter)
Owlchemist.AnimalGear.Equipment              source of the sweater defs targeted  before this mod (loadAfter), id unconfirmed
```

No hard dependency. Every integration is optional and inert when its mod is absent.

## What to search the log for

`Player.log` is in `%USERPROFILE%\AppData\LocalLow\Ludeon Studios\RimWorld by Ludeon Studios\Player.log`.

| String | Meaning for this mod |
|---|---|
| `doesn't correspond to any field` | A field of the race or kind def that 1.6 no longer has. Expected count naming `Wolf_Red`: zero. |
| `Could not load UnityEngine.Texture2D` / `Failed to find any textures at` | A `texPath` with nothing behind it. |
| `Could not find parent node named` | `ThingBaseWolf` or `AnimalKindBaseWolf` gone from Core. |
| `Patch operation` ... `failed` | A patch whose xpath selected nothing. Expected from this mod without Combat Extended: zero. With Combat Extended: zero. |
| `Cannot find` ... `Def named` on `Wolf_Red` or `RedWolf` | A DefInjected key whose def is absent: a French file placed outside its load folder. Expected: zero. |

## Scenarios

### A. The animal exists, tames and is described (no optional mod)

Preconditions: this mod only, English. Actions: spawn a wild `Wolf_Red` in dev mode, tame it, open its
information card. Expected: it is a red wolf of the right size (body size 0.68), it takes a name when tamed,
it is offered Obedience, Release, Rescue and Haul, and the card lists Wildness.

### B. The values the game kept

Expected, read from the defs after loading: `baseBodySize` 0.68, `maxPreyBodySize` 1.8,
`manhunterOnTameFailChance` 0.10, `manhunterOnDamageChance` 0.70, `ComfyTemperatureMin` -25,
`FilthRate` 1.6, meat from `Wolf_Timber`. Wild in five biomes: temperate forest and swamp (0.05), boreal
forest, cold bog and arid shrubland (0.02).

### C. The coats

Expected: one plain coat and three variants, the variants drawn four times in five. Puppy and adult are both
drawn, in all rotations, with no pink square.

### D. A Dog Said 2

D1 mod present, declared order: the red wolf is in the three category lists (`ADS_Cat1`, `ADS_Cat2`, `ADS_Cat3`)
and is offered the same operations as the timber wolf. D2 mod absent: nothing added, nothing logged. D3 wrong
load order (A Dog Said 2 before this mod): the red wolf is **not** offered the operations. This is the
documented symptom that `loadBefore` prevents.

### E. Dogs mate

Mod present: `Wolf_Red` is in the "Wolf" group beside `Wolf_Timber` and `Wolf_Arctic`; a red wolf seeks, and is
sought by, a timber wolf. Mod absent: nothing.

### F. Better Crossbreeding

Mod present: a male red wolf may mate with a female timber wolf and the reverse (`canCrossBreedWith` on each
race), and the pup is either parent's kind (extension `DZY.CrossBreeding.Extension`, outcome `Random`, on each
kind). The timber wolf's own existing entries are kept. No pairing with dogs. Mod absent: nothing.

### G. Pawnmorpher

Mod present (`tachyonite.pawnmorpherpublic`): the folder `ModIntegrations/Pawnmorpher` loads, a red wolf morph
exists with its hediffs, memories, parts and two backstories, and the French files of that folder load with it.
Mod absent: the folder is not read, no DefInjected for it, no error.

### H. Animal Gear equipment

Mod present: the sweater and the patches to the small-animal apparel load. The source mod's id is not
confirmed (see "Known limits"), so this scenario cannot be played until it is found. Mod absent: nothing.

### I. Combat Extended

Mod present: the melee chances are added to the red wolf's stats. Mod absent: nothing.

### J. An existing save

Load a save with a red wolf, remove the mod, save again. Expected, per the original: the red wolf is lost and
nothing else breaks. This is a content mod.

### K. The mod list entry

About page shows name, author, description, preview and icon; the preview and icon are the shipped images.

### L. English and French

In French, the animal, its puppy, the sweater, and (with Pawnmorpher) the morph, the mutations, the thoughts and
the backstories show French text, with no raw key and no clipping. The gender switches of the backstories,
thoughts and mutation stages render a form, not the switch text.

## Automated tests

`Tests/test_mod.py`, run `uv run --with lxml python Tests/test_mod.py`: 29 checks, all green on 2026-11-03 at the
revision recorded in `STATUS.md`. XML well formed; the values of scenario B; texture paths; `About.xml` and
`LoadFolders.xml`; and the real patch files of scenarios D, E, F and I applied to fixtures, with the target
present and absent, on a list or extension that already exists, and with the A Dog Said predicate trap shown
to fail. Scripts: `scripts/Check-ModBasics.ps1`, `Check-Translations.ps1`, `Check-DefInjected.ps1` (with the
Pawnmorpher, Alien Races and Harmony assemblies) all pass; `Run-UnitTests.ps1` is not applicable (no unit-test
project, no code).

## Pickle

Written 2026-11-03, **never played**: `Tests/Pickle/` (README.md says how, `Docs/steps.md` lists the 12 local steps).
The animal and def steps are Nelim's Pickle Tools' (PickleTools 813dc0f; Virginie ruled against copying Dalmatians steps). Six features, seven passes, nine launches:
no optional mod (A, B, D2, L in English and French), Pawnmorpher (G and L, the gender switches resolved for a male,
a female and a neutral colonist), A Dog Said 2 in the declared and in the wrong order (D1, D3), Dogs mate (E),
Better Crossbreeding (F), and both crossing mods together. Not written: C (the coats, owner's decision), H and I
(offline only), J (a content mod, nothing to prove), K. `scripts/Check-Steps.ps1` passes: 6 features, 12 local patterns,
137 step lines, each resolving to one step.

## What cannot be tested offline

The game resolving `{PAWN_gender ? ... : ... : ...}` in thought and backstory descriptions; the numeric
`stagePatches` keys of the French mutation texts (they point into a list merged with Pawnmorpher's, so a change
upstream shifts them); the upstream token `[PAWN_possesive]` in the English of one backstory; any rendering.

## Known limits

- **Combat Extended `tools`.** The original's replace of `Wolf_Red/tools` selected nothing (the def declares no tools of
  its own) and was removed on 2026-11-03; the melee chances of the same patch are kept.
- **Animal Gear.** The guard `Owlchemist.AnimalGear.Equipment` is the original author's; no installed mod
  matches it, and the eight `Apparel_SmallAnimal*` defs that the patches target are in no Animal Gear mod
  checked. The folder is inert when absent.
- **Numeric `stagePatches` keys**, as above.

## Not applicable in Pickle: Pawnmorpher scenarios that need a colony (2026-11-10)

Pawnmorpher plus Humanoid Alien Races cannot load Pickle's shared `test-colony` save (saved without both mods): the game aborts natively at the second colony load (Pickle tickets a348 and 1fcc, exit 134; Humanoid Alien Races alone loads it, ticket c291). Decision of Virginie, 2026-11-10: pass 2 keeps only the scenario that every Pawnmorpher def exists and loads (it needs no colony). Cut, and so not verified in game: the quiet log of the colony load, the English text of the morph and of the two backstories (including the upstream `[PAWN_possesive]` token), the French morph, hediffs and mutation texts, the gender switches of the two backstories and the six thoughts (male, female, neutral), and the unresolved numeric `stagePatches` keys. They stay `unverified` in `STATUS.md` until upstream Pickle can load a colony with both mods.
