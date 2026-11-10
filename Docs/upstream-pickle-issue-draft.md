# Draft: issue for RimWorks/Rimworld-Pickle (not filed; Virginie posts it or says so)

**Title:** `test-colony` fixture aborts the game at the second colony load when Humanoid Alien Races and Pawnmorpher are active

**Body:**

A mod whose Pickle pass stages Humanoid Alien Races (erdelf.HumanoidAlienRaces, Workshop 839005762) and Pawnmorpher (tachyonite.pawnmorpherpublic, Workshop 1786466855) on top of Pickle's shared `test-colony` save crashes the game natively. Humanoid Alien Races alone is fine.

Setup: RimWorld 1.6.4871, headless Linux runner, Pickle's `test-colony` fixture (saved with Core, Royalty, Ideology, Biotech, Anomaly, Odyssey, Harmony and Pickle only). Load order in the failing runs: Harmony, Core and the DLC, RimLogging, Pickle, Humanoid Alien Races, Pawnmorpher, then the mod under test and its steps.

What happens: the first scenario passes. When the next scenario reloads the colony, `Player.log` shows 25 x

```
[ERROR] [AlienRace/AlienPartGenerator:804] Could not resolve cross refs: System.NullReferenceException
  at AlienRace.AlienPartGenerator+AlienComp.ExposeDataInternal () (AlienPartGenerator.cs:804)
  at AlienRace.AlienPartGenerator+AlienComp.PostExposeData () (AlienPartGenerator.cs:770)
  at Verse.ThingWithComps.ExposeData ()
  at Verse.Pawn.ExposeData ()
  at Verse.CrossRefHandler.ResolveAllCrossReferences ()
```

then `Could not regenerate layer Verse.SectionLayer_Sand` (and `_Snow`, `_FogOfWar`) with a NullReferenceException, a native crash report whose managed stack ends in `SectionLayer_Sand:Regenerate <- Section:RegenerateAllLayers <- MapDrawer:RegenerateEverythingNow <- Map:FinalizeInit`, and `Aborted (core dumped)`, Pickle exit code 134. The report is partial (`exitReason: in-progress`).

Bisect on the same fixture and game build:
- Humanoid Alien Races + the mod, no Pawnmorpher: 6 of 6 scenarios pass, no `AlienPartGenerator` error, exit 0.
- Humanoid Alien Races + Pawnmorpher + the mod: abort as above, in every run (five runs).

Our reading, not proven: the fixture's pawns were saved without Pawnmorpher or Humanoid Alien Races data, and `AlienComp.ExposeDataInternal` throws on them once both mods are active.

Questions: can `test-colony` be regenerated, or an alternative fixture offered, with Humanoid Alien Races and Pawnmorpher loaded? Is there a known way for a mod to test beside Pawnmorpher with the shared fixture? We can supply the full `Player.log` of a failing run.
