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
localization: complete
translation_en: complete
translation_fr: partial
dependencies: none
workshop: 3811403044
published: yes
tested_on: never
remaining:
  - "2026-11-02: unverified: source mod of the AnimalEquipment integration unknown (guard Owlchemist.AnimalGear.Equipment, upstream id, in no installed mod; Apparel_SmallAnimal* defs in no Animal Gear family mod checked by Audit). Guard is inert when absent; fix the id if the mod shows up on disk"
  - "2026-11-02: unverified: French review by Virginie (FRENCH_REVIEW.md, 17 rows flagged)"
  - "2026-11-02: unverified: AlienRace.BackstoryDef keys (2 backstories) not provable by Check-DefInjected (type not resolved); Pawnmorph stagePatches keys are numeric indices into a list merged with the parent, in game only"
  - "2026-11-02: unverified: the game resolving {PAWN_gender} switches in thought and backstory descriptions, raw keys and clipping in game (playTests)"
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

## Translation audit (2026-11-02, revision of the commit that adds this section, TRANSLATIONS.md)

- Inventory: no C# and no Keyed text. All player-facing text sits in Defs: 18 defs in `Mod/Defs`, `Mod/ModIntegrations/AnimalEquipment/Defs` (the sweater) and `Mod/ModIntegrations/Pawnmorpher/Defs` (morph, hediffs, 6 thought defs of 4 stages each, 4 mutations with their `stagePatches`, 2 backstories). The patches add no text. 75 source texts plus 19 nested ones.
- English: carried by the Defs themselves (native fallback); no English language folder needed.
- French lives in `Mod/Languages/French/DefInjected` (wolf race and kind), `Mod/ModIntegrations/AnimalEquipment/Languages/French/DefInjected` (sweater) and `Mod/ModIntegrations/Pawnmorpher/Languages/French/DefInjected` (everything for Pawnmorpher), each in the load folder of its target so that nothing is injected when the target mod is absent. 101 injected texts.
- Checks: `Check-Translations.ps1` PASS (75 texts, 19 nested). `Check-DefInjected.ps1` with the Pawnmorpher, Alien Races and Harmony assemblies: no error except the two BackstoryDef keys it cannot type-check (`AlienRace.BackstoryDef` unresolved), listed as unverified.
- Agreement: switches `{PAWN_gender ? ... : ... : ...}` with the al system for the neutral segment where a participle, adjective or pronoun agrees with the colonist (backstories, mutations, 3 thoughts). Texts with no colonist (base mutation descriptions, hediffs) are epicene ("la personne"). No tu, no vous, no nous.
- `FRENCH_REVIEW.md` generated by `Make-FrenchReview.ps1`; doubts in `french-review-flags.json` (17 rows).
- Virginie's review: not done. `translation_fr` stays `partial` until then (`remaining`, `unverified`).
