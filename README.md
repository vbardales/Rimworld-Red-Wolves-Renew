# Red Wolves Renew

Pausbrak's **Red Wolves**, brought forward to RimWorld 1.6.

**I am not the author of this mod.** The animal, the textures and the writing are Pausbrak's — all
I did was declare it for 1.6 and check that nothing in it had broken. Credit goes to them; mistakes
in the update are mine.

Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=2014889466 — last supporting
1.4. Source at https://github.com/RadHazard/RimworldRedWolves, last touched December 2022.
Abandoned, not withdrawn.

## What the mod does

It adds one animal.

- **Red wolf** — two thirds the body size of a timber wolf (0.68), hunting prey up to 1.8, harder
  to provoke than its cousin and shyer to tame. It takes cold down to −25 °C and leaves rather less
  filth. It borrows the timber wolf's meat.
- **Four coats**: the plain one, and three variants that turn up four times out of five.
- Found sparsely in temperate forest and swamp, more sparsely still in boreal forest, cold bog and
  arid shrubland.

No DLC required. No Harmony, no framework, no dependency of any kind.

Content mod: removing it mid-save will lose any red wolf already in play.

## Integrations

Each loads only if the mod it targets is present — the Pawnmorpher and Animal Gear folders through
the `LoadFolders.xml` conditions Pausbrak wrote, the two patches through a guard of their own:

| Integration | What it adds |
|---|---|
| A Dog Said 2 | Prosthetics and bionics for the red wolf, in all three of its categories, where the timber wolf sits. **Rewritten**: Pausbrak's version named ADS 1's recipes and had stopped working. |
| Combat Extended | Reworked tools. |
| Pawnmorpher | A red wolf morph, with its own mutations, hediffs, memories and backstories, and the body-part textures that go with them. |
| Animal Gear / Animal Equipment | Sweaters, scarves, flak and plate cut for a red wolf. |

Three of the four are the author's own work, shipped as they shipped upstream. All four are inert
while their target mod is absent — a conditional folder is never read at all, and the two patches
select nothing. **None has been checked against a running 1.6 build of the mod it targets**,
because that would mean installing and running those mods; what is guaranteed is that their
absence costs nothing.

## What changed in the 1.6 update

**One thing, and it is not in the animal.**

### The A Dog Said integration had stopped working

Pausbrak's patch named thirteen recipes one by one — `InstallPegLegAnimal`,
`InstallBionicEyeAnimal`, `InstallBionicAnimalStomach` and the rest — and guarded on the display
name of **A Dog Said 1**. A Dog Said 2 renamed every one of those recipes, and ADS 1 is dead. The
guard never matched; had it matched, the xpath would have selected nothing. The mod promised
prosthetics for the red wolf and delivered none.

ADS 2 keeps three abstract `RecipeDef`s instead — `ADS_Cat1` (medieval replacements), `ADS_Cat2`
(+ simple prosthetics), `ADS_Cat3` (+ bionics) — and its own last patch copies their `recipeUsers`
onto the real surgery bases. The rewritten patch adds the red wolf to all three, which is where
`Wolf_Timber` sits, and guards with a `PatchOperationConditional` that stays silent when ADS 2 is
absent. `About.xml` gained a `loadBefore` on it: that category patch runs once, at ADS 2's own
pass, so a mod loaded after it writes into a list nobody reads again.

### The animal itself

**Nothing**, and that is worth saying plainly rather than padding a list.

- The animal declares **no wildness of its own**. It inherits the vanilla wolf's, and vanilla moved
  that value to the `Wildness` stat correctly on its own. The breakage that hit almost every other
  animal mod on 1.6 could not reach this one.
- It already used the game's **`alternateGraphics`** for its four coats, with an
  `alternateGraphicChance`, rather than one of the third-party variant assemblies that died along
  the way.
- It lays no eggs, so `CompEggLayer` has nothing to say to it.
- Its defs are byte for byte the ones Pausbrak shipped for 1.4.

What this update does is declare 1.6, carry the four integrations across with their load
conditions, and drop `Wolf_Red_SkinSet.xml` — the configuration file for an animal-variants
assembly the mod stopped using at 1.1, left behind in `Textures/`.

## Terms

The original is **MIT** (`LICENSE`, copyright 2020 Ryan Schneider), and that notice ships with the
mod, which is the condition MIT places on redistribution.

If Pausbrak comes back to it, or asks for this to be taken down, it comes down.

If I do not answer within a reasonable time after being contacted, anyone may freely update this or
any other of my mods, including publishing a continuation of it. All credit must be preserved.

## Credits

- **Pausbrak** — the mod itself, in full: animal, textures, integrations, writing.
- 1.6 update by Nelim. Written with the help of Claude (Anthropic).
