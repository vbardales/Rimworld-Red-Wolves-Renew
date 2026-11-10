---
mod: Red Wolves Renew
packageId: nelim.redwolves
repo: Rimworld-Red-Wolves-Renew
remote: https://github.com/vbardales/Rimworld-Red-Wolves-Renew.git
visibility: public
detached: yes
workflow_stage: playTests[1.0.0]
licence: open
licence_at: "2026-11-02: upstream LICENSE is MIT (Ryan Schneider, 2020), confirmed on RadHazard/RimworldRedWolves (spdx MIT); LICENSE and ATTRIBUTION.md carry it"
upstream_mod_remotes:
  - https://github.com/RadHazard/RimworldRedWolves
settings_audit: not_applicable
localization: complete
translation_en: complete
translation_fr: complete
dependencies: none
workshop: 3811403044
published: yes
tested_on: "2026-11-03 pickle 96d4e48 (Pickle only, no game by hand; pass 1 English and French, 3, 5, 6, 7 green)"
automated: "29 checks passed, 0 failed on 2026-11-10 at Mod/ revision 3fd3a09 (Tests/test_mod.py, uv run --with lxml python Tests/test_mod.py); Check-ModBasics and Check-Translations PASS; Run-UnitTests not applicable (no code)"
remaining:
  - "2026-11-10: replay-audit 2 (ledger .replays/RedWolvesRenew-20261110.tsv): sections 1 to 7 fulfilled, stage back at playTests. Open 8.a (Mod sha not frozen: three backstory fixes a07c2f8 to 3fd3a09), 8.c and 8.f (pass 2 queued 5d3e 9a1c; pass 3, 5, 6, 7 greens dated at 96d4e48), 8.g, 8.i, 8.k (TESTING.md scenarios not all played), 8.j (regression after the fixes), 8.l (no Docs/runs journal, tested_on old), 8.m (code_review_sha absent), 8.n. Owed: convert Tests/test_mod.py to the generated Tests/Test-Mod.ps1 + Rule-OwnValues.ps1 shape (AGENTS.md Mod tests shape), About description link WARN (Check-ModBasics)"
  - "2026-11-02: unverified: source mod of the AnimalEquipment integration unknown (guard Owlchemist.AnimalGear.Equipment, upstream id, in no installed mod; Apparel_SmallAnimal* defs in no Animal Gear family mod checked by Audit). Guard is inert when absent; fix the id if the mod shows up on disk"
  - "2026-11-10: DEFECT FIXED at a07c2f8: the 2 backstories were typed AlienRace.BackstoryDef, which HAR 1.6 no longer has (now AlienRace.AlienBackstoryDef; game log: Type AlienRace.BackstoryDef is not a Def type or could not be found); defs, French DefInjected folder and Pickle step renamed. Pass 2 at a07c2f8 then showed a SECOND defect (game log: ArgumentNullException loading <baseDescription>; HAR 1.6 and Pawnmorpher 1.6 use <description>): fixed at ea3a5f2 (defs and French keys). Pass 2 French at ea3a5f2 showed a THIRD defect (game log: ArgumentNullException in SkillGain.LoadDataFromXmlCustom: 1.6 reads <Skill>n</Skill>, the defs had <li><defName>): fixed at 3fd3a09. Pass 2 English at 3fd3a09 showed a FOURTH defect (game log: ArgumentNullException in BackstoryTrait.LoadDataFromXmlCustom: 1.6 forcedTraits is <Trait>degree</Trait>, the def had <li><defName>+<chance>): fixed at bdaa5cc with <Psychopath>0</Psychopath> and <forcedTraitsChance>0.5</forcedTraitsChance> (UNVERIFIED: the HAR 1.6 field forcedTraitsChance is in the DLL, scale 0..1 assumed, no sample on disk; if the game rejects it, the next report says so). Pass 2 running on it: English 20261110-183030-706-1fcc, French 20261110-174819-210-9a1c (queued, stages the tree at start). Older note: Pawnmorph stagePatches keys are numeric indices into a list merged with the parent, in game only"
  - "2026-11-02: unverified: the game resolving {PAWN_gender} switches in thought and backstory descriptions, raw keys and clipping in game (playTests)"
  - "2026-11-03: unverified: upstream English token [PAWN_possesive] (typo) in the ForcedGeneral backstory: check in English in game (playTests); upstream typos left unchanged on purpose"
  - "2026-11-03: unverified: Pickle suite written, never played (7.d asks only for written suites; the first ticket is a playTests gesture). Things a first run may show: BiomeDef.CommonalityOfAnimal for the wild biomes, Pawnmorpher's hard dependencies for this game version (Humanoid Alien Races only is staged), whether the staging script sorts the wrong-order pass back into the right order (pass 4), the neutral gender segment of the switches, Pawnmorpher's own errors against no errors were logged"
  - "2026-11-03: interim: the 12 local Pickle steps (Tests/Pickle/Source) stay until NPT promotes the extras (gender switches and stat equals stay local as sole consumer; operations steps follow the Dalmatians Renew migration); then delete the copies and re-run Check-Steps (Audit ruling)"
  - "2026-11-10: pass results read (Mod/ revision 96d4e48). GREEN, kept minified in Tests/Pickle/Evidence: pass 1 English 6/6 (20261103-093835-192-cd3f), pass 1 French 6/6, pass 3 3/3, pass 6 5/5, pass 7 7/7 (pass 5 3/3 superseded by pass 7, deleted). RED, deleted after study: pass 2 English and French (1 scenario each, step 'def of type AlienRace.BackstoryDef comes from the mod' fails: DefFieldSteps does not resolve a non-Verse def type; tool limit, not a mod defect; ask NPT to resolve it, or drop the 2 backstory lines from 02-pawnmorpher.feature), pass 4 (A Dog Said 2 is loaded AFTER nelim.redwolves, so the game honours loadBefore and the wrong order cannot be staged: both scenarios void; retire 04-ads2-wrong-order.feature and its map, or ask NPT for a forced order). Update 2026-11-10: NPT fixed DefFieldSteps (ff44b8b), pass 4 retired at b9e7a9f (PickleTools cannot force a load order). Pass 2 at b9e7a9f both red with the old type error (2142, 4b42; the run read a stale DefFieldSteps). Refiled on NPT c724f37 (new error lists loaded types): English 20261110-173100-231-077f, French 20261110-173103-906-ec20, evidence Tests/Pickle/Inbox/pass2-english and pass2-french; if red again send PiT the exact error line; if the new text is missing TM checks the server tree. On RUN_DONE: summary.json then junit.xml, triage"
  - "2026-11-10: AUDIT 4.b/4.e/4.g: OptionalCompat.xml (one entry per optional target) is not in the repo; write it per docs/AUDIT.md 4.g. 6.f: FRENCH_REVIEW.md is the old name, regenerate TRANSLATION_REVIEW.md with scripts/Make-TranslationReview.ps1 (Check-Status INFO)"
  - "2026-11-10: unverified: Art/Preview.config.json is rewritten uncommitted in the working tree (new schema, not by this session); Render-Preview.cjs fails: 'ModIcon-source.png has excessive transparent padding'. Render outputs reverted, nothing committed. Preview.png last committed 2026-11-02. Per AUDIT 2.d to 2.f (2026-11-10) the Preview is now made once at mountPreview from the accepted gallery"
  - "2026-11-02: unverified: never seen running"
workshop_required_items: "n/a, no mandatory Workshop dependency (modDependencies empty)"
updated: 2026-11-10
protocols_read_sha: 409a3558069ff2cd86a4f7865826897b158fe959
---

# Red Wolves Renew: status

Current state only: the front matter above is the source of truth, run lines go to `docs/runs/`.
Check it with `scripts/Check-Status.ps1 -Mod RedWolvesRenew` (no ERROR).

## Dependencies and integrations (2026-11-02, revision of the commit that adds this section)

- Hard dependencies (`modDependencies`): none. The mod loads and works alone.
- DLC: none required. `loadAfter` names the five official DLC for ordering only.
- Optional integrations, all guarded and inert when the target is absent, declared in Mod/About/OptionalCompat.xml (2026-11-10, 6 entries: Pawnmorpher, Animal Gear (no workshopId, source mod unknown), Combat Extended, A Dog Said 2, Dogs mate, Better Crossbreeding; Check-OptionalCompat OK):
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
- Virginie's review: done 2026-11-03, validated as a whole by Virginie in this session, revision c23ee45. Corrections requested during the review: neutral forms daltonaire and incertan (al system), checked by her with Alpheratz; the other neutral forms contentæ, mignonæ, censæ, retrouvæ, transformæ, habituæ, nerveuxe confirmed; ChatGPT page-1 reviews read by her, corrections applied where she agreed (backstory title, ear text, partial hediff label, two muzzle texts, iris, soirées de poker). The review line of FRENCH_REVIEW.md is hers to fill.

## Tests (2026-11-03, TESTING.md, PUBLICATION.md)

- Scenarios A to L written in `TESTING.md` (preconditions, actions, expected results; figures checked against the defs). `PUBLICATION.md` written (description block, dependencies, comments owed); gallery order and comments finish at `writeDocs`.
- Automated: `Tests/test_mod.py`, `uv run --with lxml python Tests/test_mod.py`, 29 checks, all green on 2026-11-03 (XML, values, textures, About and LoadFolders, the real patches of ADS 2, Dogs mate, Better Crossbreeding and Combat Extended (the dead tools Replace was removed 2026-11-03) on fixtures with the target present and absent, and the A Dog Said predicate trap shown to fail). `Check-ModBasics` PASS, `Check-Translations` PASS, `Check-DefInjected` 0 errors. `Run-UnitTests.ps1` not applicable (no unit-test project, no code).
- Pickle: suite written 2026-11-03 in `Tests/Pickle` on the shared steps of Nelim's Pickle Tools (ColonistRace, DefFieldSteps, PickleTools 813dc0f; Virginie ruled against copying Dalmatians steps, NPT 2682e3 superseded): 6 features, 27 scenario blocks, 12 local steps (`Docs/steps.md`), 7 pass maps, 9 launches (`Tests/Pickle/README.md`). `Check-Steps.ps1 -StepPrefix "Red Wolves Renew"` passes (137 step lines, each one step); the assembly builds with 0 warnings. Never played. Not written: coats, butcher and rot, camera, removal, Combat Extended, Animal Gear (offline only or nothing to prove).
