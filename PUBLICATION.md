# Publication: Red Wolves Renew

What the Workshop page asks for and the repository holds nowhere else. State: written at `writeTests`
(2026-11-03); the description, the gallery and the comments are finished at `writeDocs`.

## Steam description

```markdown
Pausbrak's Red Wolves, brought forward to the latest RimWorld version. A smaller, shyer wolf, russet-coated, driven extinct on Earth in the 21st century and cloned back in the 22nd.

I am not the author of this mod. The animal, the textures and the writing are Pausbrak's. My part is declaring it for the latest RimWorld version, rewriting the A Dog Said patch that had stopped working, adding the Dogs mate and Better Crossbreeding patches, and writing the French. Credit goes to Pausbrak; mistakes in the update are mine. If they come back to it, or ask me to take this down, I will.

Original mod: [Red Wolves](https://steamcommunity.com/sharedfiles/filedetails/?id=2014889466), source at [RadHazard/RimworldRedWolves](https://github.com/RadHazard/RimworldRedWolves), last touched December 2022.

## What it adds

- The red wolf: two thirds the body size of a timber wolf, hunting smaller prey, harder to provoke and shyer to tame. It takes cold down to -25 degrees and makes less mess than its cousin.
- Four coats, one plain and three variants, four times out of five.
- Found sparsely in temperate forest and swamp, and more sparsely still in boreal forest, cold bog and arid shrubland.

## Integrations

Each loads only if you have the mod it targets. None is required.

- A Dog Said... Animal Prosthetics 2: the red wolf is offered the same prosthetics as the timber wolf.
- Dogs mate: the red wolf joins the wolf group.
- Better Crossbreeding: red wolves and timber wolves cross each way, the pup being either parent's kind.
- Pawnmorpher: a red wolf morph, with its own mutations, memories and backstories.
- Combat Extended: melee chances for the red wolf.
- Animal Gear: sweaters, scarves, flak and plate cut for a red wolf.

## What changed in this update

The animal itself is unchanged: its defs are the ones Pausbrak shipped. The update declares the latest RimWorld version, rewrites the A Dog Said patch (the 1.4 version named recipes that no longer exist), and adds the Dogs mate and Better Crossbreeding patches. French is new. No balance value was changed.

Content mod: removing it mid-game will lose any red wolf already in play.

## IF I GO QUIET

If I do not answer within a reasonable time after being contacted, anyone may freely update this or any other of my mods, including publishing a continuation of it. All credit must be preserved.

## AI-GENERATED

The update work was done with the help of Claude (Anthropic): the patches, the French translation, the tests and the documentation. The preview and icon images were made by the owner with DALL-E (OpenAI).

## THANKS

Thanks to Pausbrak for the wolf, to Mlie for Dogs mate and for keeping it alive, to DizzyEevee for Better Crossbreeding, to SamBucher for A Dog Said, to the Pawnmorpher team, and to the Combat Extended team.

Licensed MIT, like the original. See `ATTRIBUTION.md` in the repository for what was taken and what was changed.

[Source code on GitHub](https://github.com/vbardales/Rimworld-Red-Wolves-Renew)
```

The existing `About.xml` description still says the update changed nothing and lists four integrations: it is
replaced from this block by the CI sync at `writeDocs`, not by hand.

## Dependencies and DLC to declare

- Hard dependencies: none.
- DLC: none required. `loadAfter` names the five official DLC for ordering.
- `loadBefore`: `SamBucher.ADogSaidAnimalProsthetics2` (its category patch runs once, at its own pass).
- `loadAfter`: `tachyonite.pawnmorpherpublic`, `Owlchemist.AnimalGear.Equipment` (original author's id, no
  installed mod matches it; inert when absent).
- Workshop ids: A Dog Said 2 3238353862, Dogs mate 2441132298, Better Crossbreeding 3520675842,
  Nocturnal Animals 2269731409 (nothing to patch: inherited), Pawnmorpher 1786466855.

## Adult content

None. The Workshop content boxes: no adult content, no violence beyond the base game's animals.

## Gallery

Order of the captures and what each shows: decided at `shootGallery`, after the shotlist. Not written yet.

## Thank-you comments

One main comment per Workshop page, for the whole collection (`WORKSHOP_COMMENTS.md`): Pausbrak's Red Wolves
(2014889466) is not yet in the register, so a comment is owed once this item is visible; Mlie (Dogs mate,
2441132298), DizzyEevee (Better Crossbreeding, 3520675842) and SamBucher (A Dog Said 2, 3238353862) are to be
checked against the register at `writeDocs`. Nothing drafted yet; nothing posted.
