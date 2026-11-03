using System.Collections.Generic;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace RedWolvesRenew.PickleSteps
{
    /// <summary>
    /// What this suite needs and Nelim's Pickle Tools does not say (PickleTools 813dc0f: ColonistRace
    /// animal steps and DefFieldSteps cover spawn, tame, name, trainings, the information card, field
    /// reads, where a def comes from, the crossing lists and the Better Crossbreeding extension; Virginie
    /// ruled on 2026-11-03 that this suite does not copy Dalmatians steps). Reads of the live defs, after
    /// every patch of the mod list under test has been applied.
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

        private static HashSet<string> Operations(PickleContext ctx, string defName) =>
            new HashSet<string>(Thing(ctx, defName).AllRecipes.Select(r => r.defName));

        // ---- operations offered by an animal (A Dog Said... Animal Prosthetics 2) ----
        // The shared "surgery recipes of the race X match those of the race Y" proves the right order;
        // these say how the wrong order differs, which it cannot.

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

        // Every vanilla animal sits in at least one of A Dog Said 2's categories, so no animal offers the
        // plain base list to compare against. The timber wolf is in all three and the rat in the first,
        // hence what the timber wolf offers and the rat does not comes from the second and third.
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

        // ---- stats (the field step reads public fields; statBases is a list of modifiers) ----

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

        // A description is a paragraph: its start is what says the French file was injected.
        [Then("Red Wolves Renew the def {string} of type {string} has a description beginning {string}")]
        public void DefDescription(PickleContext ctx, string defName, string typeName, string start)
        {
            var type = GenTypes.GetTypeInAnyAssembly(typeName);
            ctx.Require(type != null, $"the type '{typeName}' is not loaded in this pass");
            var def = GenDefDatabase.GetDef(type, defName, false);
            ctx.Require(def != null, $"no {typeName} named '{defName}' is loaded in this pass");
            var text = def.description ?? "";
            ctx.Assert(text.StartsWith(start), $"{typeName} {defName} has the description '{text}', expected one beginning '{start}'");
        }

        // The shared field step walks public fields; a life stage sits in a list.
        [Then("Red Wolves Renew the first life stage of pawn kind {string} is labelled {string} and pluralised {string}")]
        public void PuppyLabels(PickleContext ctx, string defName, string label, string plural)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(defName);
            ctx.Require(kind != null, $"no PawnKindDef named '{defName}' is loaded in this pass");
            var stages = kind.lifeStages;
            ctx.Require(stages != null && stages.Count > 0, $"{defName} has no life stages");
            var stage = stages[0];
            ctx.Assert(stage.label == label && stage.labelPlural == plural,
                $"the first stage of {defName} reads '{stage.label}' and '{stage.labelPlural}', expected '{label}' and '{plural}'");
        }
    }
}
