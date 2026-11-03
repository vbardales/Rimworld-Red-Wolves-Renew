using System.Collections.Generic;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace RedWolvesRenew.PickleSteps
{
    /// <summary>
    /// Reads of the live defs, after every patch of the mod list under test has been applied. The
    /// offline suite (Tests/test_mod.py) reads the same XML before the game touches it; these read
    /// what the game kept. Wolf_Red names both a ThingDef and a PawnKindDef, and Pickle's own
    /// "def X ..." steps refuse a name two def types share, so the steps below say which one.
    /// </summary>
    [PickleSteps]
    public class DefSteps
    {
        private static ThingDef Thing(PickleContext ctx, string defName)
        {
            var def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}' is loaded in this pass");
            return def;
        }

        private static PawnKindDef Kind(PickleContext ctx, string defName)
        {
            var def = DefDatabase<PawnKindDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no PawnKindDef named '{defName}' is loaded in this pass");
            return def;
        }

        private static HashSet<string> Operations(PickleContext ctx, string defName) =>
            new HashSet<string>(Thing(ctx, defName).AllRecipes.Select(r => r.defName));

        // ---- operations offered by an animal (A Dog Said... Animal Prosthetics 2) ----

        [Then("Red Wolves Renew {string} offers the same operations as {string}")]
        public void SameOperations(PickleContext ctx, string thing, string other)
        {
            var a = Operations(ctx, thing);
            var b = Operations(ctx, other);
            var missing = b.Except(a).OrderBy(x => x).ToList();
            var extra = a.Except(b).OrderBy(x => x).ToList();
            ctx.Assert(missing.Count == 0 && extra.Count == 0,
                $"{thing} offers {a.Count} operations and {other} {b.Count}; " +
                $"only {other} offers [{string.Join(", ", missing)}]; only {thing} offers [{string.Join(", ", extra)}]");
        }

        // Every vanilla animal sits in at least one of A Dog Said 2's categories, so no animal offers
        // the plain base list to compare against. The timber wolf is in all three and the rat in the
        // first, hence what the timber wolf offers and the rat does not comes from the second and third.
        [Then("Red Wolves Renew {string} offers none of the operations that {string} offers and {string} does not")]
        public void NoneOfTheDifference(PickleContext ctx, string thing, string offering, string notOffering)
        {
            var mine = Operations(ctx, thing);
            var difference = Operations(ctx, offering).Except(Operations(ctx, notOffering)).OrderBy(x => x).ToList();
            ctx.Require(difference.Count > 0, $"{offering} offers nothing that {notOffering} does not: there is nothing to look for");
            var found = difference.Where(mine.Contains).ToList();
            ctx.Assert(found.Count == 0,
                $"{thing} offers {found.Count} of the {difference.Count} operations only {offering} offers: [{string.Join(", ", found)}]");
        }

        [Then("Red Wolves Renew {string} offers more operations than {string}")]
        public void MoreOperations(PickleContext ctx, string thing, string other)
        {
            int a = Operations(ctx, thing).Count, b = Operations(ctx, other).Count;
            ctx.Assert(a > b, $"{thing} offers {a} operations and {other} {b}; expected more for {thing}");
        }

        [Then("Red Wolves Renew {string} offers fewer operations than {string}")]
        public void FewerOperations(PickleContext ctx, string thing, string other)
        {
            int a = Operations(ctx, thing).Count, b = Operations(ctx, other).Count;
            ctx.Assert(a < b, $"{thing} offers {a} operations and {other} {b}; expected fewer for {thing}");
        }

        // ---- where the defs come from ----

        private static bool FromMod(ModContentPack pack, string packageId) =>
            pack != null && (string.Equals(pack.PackageId, packageId, System.StringComparison.OrdinalIgnoreCase) ||
                             string.Equals(pack.PackageIdPlayerFacing, packageId, System.StringComparison.OrdinalIgnoreCase));

        [Then("Red Wolves Renew the thing {string} comes from the mod {string}")]
        public void ThingFromMod(PickleContext ctx, string defName, string packageId)
        {
            var pack = Thing(ctx, defName).modContentPack;
            ctx.Assert(FromMod(pack, packageId), $"the thing {defName} comes from '{pack?.PackageIdPlayerFacing}', expected {packageId}");
        }

        [Then("Red Wolves Renew the pawn kind {string} comes from the mod {string}")]
        public void KindFromMod(PickleContext ctx, string defName, string packageId)
        {
            var pack = Kind(ctx, defName).modContentPack;
            ctx.Assert(FromMod(pack, packageId), $"the pawn kind {defName} comes from '{pack?.PackageIdPlayerFacing}', expected {packageId}");
        }

        // The Pawnmorpher folder is part of this mod's content pack, so its defs come from the mod
        // whichever type they are. The type is named in full ("Pawnmorph.MorphDef"): the game's own
        // type lookup finds it in any loaded assembly, so this assembly never references Pawnmorpher.
        [Then("Red Wolves Renew the def {string} of type {string} comes from the mod {string}")]
        public void DefFromMod(PickleContext ctx, string defName, string typeName, string packageId)
        {
            var def = AnyDef(ctx, defName, typeName);
            ctx.Assert(FromMod(def.modContentPack, packageId),
                $"{typeName} {defName} comes from '{def.modContentPack?.PackageIdPlayerFacing}', expected {packageId}");
        }

        internal static Def AnyDef(PickleContext ctx, string defName, string typeName)
        {
            var type = GenTypes.GetTypeInAnyAssembly(typeName);
            ctx.Require(type != null, $"the type '{typeName}' is not loaded in this pass");
            var def = GenDefDatabase.GetDef(type, defName, false);
            ctx.Require(def != null, $"no {typeName} named '{defName}' is loaded in this pass");
            return def;
        }

        // ---- the race, as the game kept it ----

        [Then("Red Wolves Renew the race of {string} reads {string} as {string}")]
        public void RaceField(PickleContext ctx, string defName, string field, string expected)
        {
            var race = Thing(ctx, defName).race;
            ctx.Require(race != null, $"{defName} has no race");
            var info = typeof(RaceProperties).GetField(field, System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);
            ctx.Require(info != null, $"RaceProperties has no public field named '{field}' in this game build");
            var actual = System.Convert.ToString(info.GetValue(race), System.Globalization.CultureInfo.InvariantCulture);
            ctx.Assert(actual == expected, $"the race of {defName} reads {field} as '{actual}', expected '{expected}'");
        }

        [Then("Red Wolves Renew the stat {string} of the thing {string} is {string}")]
        public void StatValue(PickleContext ctx, string statName, string defName, string expected)
        {
            var stat = DefDatabase<StatDef>.GetNamedSilentFail(statName);
            ctx.Require(stat != null, $"no StatDef named '{statName}'");
            var actual = Thing(ctx, defName).GetStatValueAbstract(stat);
            var wanted = float.Parse(expected, System.Globalization.CultureInfo.InvariantCulture);
            ctx.Assert(UnityEngine.Mathf.Approximately(actual, wanted), $"{defName} has {statName} at {actual}, expected {expected}");
        }

        [Then("Red Wolves Renew the stat {string} of the thing {string} equals that of the thing {string}")]
        public void StatEquals(PickleContext ctx, string statName, string defName, string other)
        {
            var stat = DefDatabase<StatDef>.GetNamedSilentFail(statName);
            ctx.Require(stat != null, $"no StatDef named '{statName}'");
            float a = Thing(ctx, defName).GetStatValueAbstract(stat), b = Thing(ctx, other).GetStatValueAbstract(stat);
            ctx.Assert(UnityEngine.Mathf.Approximately(a, b), $"{defName} has {statName} at {a} and {other} at {b}; the red wolf should inherit it");
        }

        // BiomeDef.CommonalityOfAnimal is the game's own answer to "does this biome spawn this animal",
        // after it has merged the race's wildBiomes with the biome's wildAnimals.
        [Then("Red Wolves Renew the pawn kind {string} is wild in the biome {string}")]
        public void WildIn(PickleContext ctx, string kindName, string biomeName)
        {
            var kind = Kind(ctx, kindName);
            var biome = DefDatabase<BiomeDef>.GetNamedSilentFail(biomeName);
            ctx.Require(biome != null, $"no BiomeDef named '{biomeName}'");
            ctx.Assert(biome.CommonalityOfAnimal(kind) > 0f, $"{kindName} is not wild in {biomeName}");
        }

        [Then("Red Wolves Renew the pawn kind {string} is not wild in the biome {string}")]
        public void NotWildIn(PickleContext ctx, string kindName, string biomeName)
        {
            var kind = Kind(ctx, kindName);
            var biome = DefDatabase<BiomeDef>.GetNamedSilentFail(biomeName);
            ctx.Require(biome != null, $"no BiomeDef named '{biomeName}'");
            ctx.Assert(biome.CommonalityOfAnimal(kind) <= 0f, $"{kindName} is wild in {biomeName}, which this pass does not expect");
        }

        // ---- text, in the language this pass was launched in ----

        // The language is chosen when the game starts, never during a run. This asserts the pass, so
        // that one which silently fell back to English cannot pass as French.
        [Then("Red Wolves Renew this pass runs in {word}")]
        public void PassLanguage(PickleContext ctx, string language)
        {
            var actual = LanguageDatabase.activeLanguage?.folderName ?? "(none)";
            ctx.Assert(actual.StartsWith(language, System.StringComparison.OrdinalIgnoreCase),
                $"this pass runs in '{actual}', expected {language}");
        }

        [Then("Red Wolves Renew the thing {string} is labelled {string}")]
        public void ThingLabel(PickleContext ctx, string defName, string label) =>
            ctx.Assert(Thing(ctx, defName).label == label, $"{defName} is labelled '{Thing(ctx, defName).label}', expected '{label}'");

        [Then("Red Wolves Renew the thing {string} has a description beginning {string}")]
        public void ThingDescription(PickleContext ctx, string defName, string start)
        {
            var text = Thing(ctx, defName).description ?? "";
            ctx.Assert(text.StartsWith(start), $"{defName} has the description '{text}', expected one beginning '{start}'");
        }

        [Then("Red Wolves Renew the pawn kind {string} is labelled {string} and pluralised {string}")]
        public void KindLabels(PickleContext ctx, string defName, string label, string plural)
        {
            var kind = Kind(ctx, defName);
            ctx.Assert(kind.label == label && kind.GetLabelPlural() == plural,
                $"{defName} reads '{kind.label}' and '{kind.GetLabelPlural()}', expected '{label}' and '{plural}'");
        }

        [Then("Red Wolves Renew the first life stage of pawn kind {string} is labelled {string} and pluralised {string}")]
        public void PuppyLabels(PickleContext ctx, string defName, string label, string plural)
        {
            var stages = Kind(ctx, defName).lifeStages;
            ctx.Require(stages != null && stages.Count > 0, $"{defName} has no life stages");
            var stage = stages[0];
            ctx.Assert(stage.label == label && stage.labelPlural == plural,
                $"the first stage of {defName} reads '{stage.label}' and '{stage.labelPlural}', expected '{label}' and '{plural}'");
        }

        [Then("Red Wolves Renew the def {string} of type {string} is labelled {string}")]
        public void DefLabel(PickleContext ctx, string defName, string typeName, string label)
        {
            var def = AnyDef(ctx, defName, typeName);
            ctx.Assert(def.label == label, $"{typeName} {defName} is labelled '{def.label}', expected '{label}'");
        }

        [Then("Red Wolves Renew the def {string} of type {string} has a description beginning {string}")]
        public void DefDescription(PickleContext ctx, string defName, string typeName, string start)
        {
            var text = AnyDef(ctx, defName, typeName).description ?? "";
            ctx.Assert(text.StartsWith(start), $"{typeName} {defName} has the description '{text}', expected one beginning '{start}'");
        }
    }
}
