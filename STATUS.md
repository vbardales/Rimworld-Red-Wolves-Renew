---
mod: Red Wolves Renew
packageId: nelim.redwolves
repo: Rimworld-Red-Wolves-Renew
remote: https://github.com/vbardales/Rimworld-Red-Wolves-Renew.git
visibility: public
detached: yes
workflow_stage: localize[1.0.0]
licence: open
licence_at: "2026-11-02: upstream LICENSE is MIT (Ryan Schneider, 2020), confirmed on RadHazard/RimworldRedWolves (spdx MIT); LICENSE and ATTRIBUTION.md carry it"
upstream_mod_remotes:
  - https://github.com/RadHazard/RimworldRedWolves
settings_audit: not_applicable
localization: unchecked
translation_en: unchecked
translation_fr: unchecked
dependencies: none
workshop: 3811403044
published: yes
tested_on: never
remaining:
  - "2026-11-02: unverified: source mod of the AnimalEquipment integration unknown (guard Owlchemist.AnimalGear.Equipment, upstream id, in no installed mod; Apparel_SmallAnimal* defs in no Animal Gear family mod checked by Audit). Guard is inert when absent; fix the id if the mod shows up on disk"
  - "2026-11-02: unverified: never seen running"
updated: 2026-11-02
protocols_read_sha: f5204fe856d1247623f508eb566f01b782a087b8
---

# Red Wolves Renew: status

Current state only: the front matter above is the source of truth, run lines go to `docs/runs/`.
Check it with `scripts/Check-Status.ps1 -Mod RedWolvesRenew` (no ERROR).

## Dependencies and integrations (2026-11-02, revision of the commit that adds this section)

- Hard dependencies (`modDependencies`): none. The mod loads and works alone.
- DLC: none required. `loadAfter` names the five official DLC for ordering only.
- Optional integrations, all guarded and inert when the target is absent:
  - Pawnmorpher (`tachyonite.pawnmorpherpublic`, Workshop 1786466855; the upstream `tachyonite.pawnmorpher` guard was dropped: IfModActive needs every listed id, and that one is installed nowhere, so the folder never loaded): `ModIntegrations/Pawnmorpher`, loaded by `IfModActive` in `LoadFolders.xml`.
  - Animal Gear (`Owlchemist.AnimalGear.Equipment`): `ModIntegrations/AnimalEquipment`, loaded by `IfModActive`.
  - Combat Extended: `Patches/Addon_CombatExtended.xml`, `PatchOperationFindMod`.
  - A Dog Said Animal Prosthetics 2 (`SamBucher.ADogSaidAnimalProsthetics2`, 3238353862): `Patches/Addon_ADogSaid.xml`, `PatchOperationConditional`; `loadBefore` declared.
  - Dogs mate (`Mlie.DogsMate`, 2441132298): `Patches/Compat_DogsMate.xml`, red wolf added to the "Wolf" group beside Wolf_Timber.
  - Better Crossbreeding (`DizzyEevee.BetterCrossbreeding`, 3520675842): `Patches/Compat_BetterCrossbreeding.xml`, red wolf and Wolf_Timber cross each way, pup either parent's kind (Random), Audit ruling 2026-11-02.
  - Nocturnal Animals (`Mlie.XNDNocturnalAnimals`, 2269731409): not applicable, no patch. Its `1.6/Patches/Core/Races_Animal_WildCanines.xml` sets `Crepuscular` on the abstract `ThingBaseWolf`; Wolf_Red has `ParentName="ThingBaseWolf"` and no `modExtensions` of its own, so it inherits the classification of Wolf_Timber. Read in files only, not seen in game.
- Offline test of the two new patches: lxml, document-level XPath, with an existing list and extension on the target; the list and extension are created or appended, nothing changes without the target.

## Settings audit (2026-11-02, revision 91539ce, MOD_SETTINGS.md)

- Result: `not_applicable`.
- Inventory: the mod is a 1.6 declaration of Pausbrak's red wolf. It ships XML defs, patches and textures only (`Mod/` holds `About`, `Defs`, `ModIntegrations`, `Patches`, `Textures`; no `Assemblies`, no C# in the repository). The only behaviour it configures is the animal's own stats, which players already tune through other mods; no player need for an option was found, and inventing one would be decorative. Optional integrations (Pawnmorpher, Animal Gear, Combat Extended, A Dog Said 2, Dogs mate, Better Crossbreeding) are switched on by the presence of the target mod, not by an option.
- Verified in sources: no `Verse.Mod` or `ModSettings` reference and no `MainButtonDef` in any XML of `Mod/` (bounded `grep` over `Mod/`, 0 hits), and no assembly to register a settings page. So no "Mod options" entry and no MainButtons shortcut exist, empty or hidden.
- Not run: nothing in game, no automated test (there is no `Tests/` folder and no code to test).
