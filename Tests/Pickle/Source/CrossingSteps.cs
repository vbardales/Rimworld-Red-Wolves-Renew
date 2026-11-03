using System.Collections;
using System.Linq;
using HarmonyLib;
using RimWorks.Pickle;
using Verse;

namespace RedWolvesRenew.PickleSteps
{
    /// <summary>
    /// What the live defs say about crossing, after Dogs mate (Mlie.DogsMate) and Better Crossbreeding
    /// (DizzyEevee.BetterCrossbreeding) have run on a whole mod list. Both mods are read by reflection so
    /// that this assembly does not reference them: a pass without them never loads their types.
    /// </summary>
    [PickleSteps]
    public class CrossingSteps
    {
        private static ThingDef Race(PickleContext ctx, string defName)
        {
            var def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null && def.race != null, $"no animal ThingDef named '{defName}' is loaded in this pass");
            return def;
        }

        // The vanilla field both mods feed: Dogs mate fills it at startup from its groups, the Better
        // Crossbreeding patch fills it from XML. The game reads it on the MALE only (JobGiver_Mate).
        [Then("Red Wolves Renew the male {string} will seek {string} to mate with")]
        public void MaleSeeks(PickleContext ctx, string male, string female)
        {
            var list = Race(ctx, male).race.canCrossBreedWith;
            var names = list == null ? "nothing" : string.Join(", ", list.Select(d => d.defName));
            ctx.Assert(list != null && list.Any(d => d.defName == female), $"{male} seeks [{names}], not {female}");
        }

        [Then("Red Wolves Renew the male {string} does not seek {string} to mate with")]
        public void MaleDoesNotSeek(PickleContext ctx, string male, string female)
        {
            Race(ctx, female);
            var list = Race(ctx, male).race.canCrossBreedWith;
            ctx.Assert(list == null || list.All(d => d.defName != female), $"{male} seeks {female}, which this pass does not expect");
        }

        [Then("Red Wolves Renew the male {string} lists {string} once")]
        public void ListedOnce(PickleContext ctx, string male, string female)
        {
            var list = Race(ctx, male).race.canCrossBreedWith;
            var count = list == null ? 0 : list.Count(d => d.defName == female);
            ctx.Assert(count == 1, $"{male} lists {female} {count} times");
        }

        // Better Crossbreeding reads a DZY.CrossBreeding.Extension on the MOTHER's kind.
        [Then("Red Wolves Renew the mother kind {string} has the outcome {word} when the father kind is {string}")]
        public void MotherOutcome(PickleContext ctx, string mother, string behavior, string father)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(mother);
            ctx.Require(kind != null, $"no PawnKindDef named '{mother}' is loaded in this pass");
            var type = AccessTools.TypeByName("DZY.CrossBreeding.Extension");
            ctx.Require(type != null, "Better Crossbreeding's DZY.CrossBreeding.Extension is not loaded in this pass");
            var ext = kind.modExtensions?.FirstOrDefault(e => e != null && e.GetType() == type);
            ctx.Assert(ext != null, $"{mother} carries no DZY.CrossBreeding.Extension");
            var outcomes = (IEnumerable)AccessTools.Field(type, "outcomes").GetValue(ext);
            var seen = new System.Collections.Generic.List<string>();
            foreach (var o in outcomes)
            {
                var ot = o.GetType();
                var k = (PawnKindDef)AccessTools.Field(ot, "kindDef").GetValue(o);
                var b = (string)AccessTools.Field(ot, "behavior").GetValue(o);
                seen.Add($"{k?.defName}={b}");
                if (k != null && k.defName == father)
                {
                    ctx.Assert(b == behavior, $"{mother} by {father} has the outcome {b}, expected {behavior}");
                    return;
                }
            }
            ctx.Assert(false, $"{mother} has no outcome for the father {father}; it has [{string.Join(", ", seen)}]");
        }

        [Then("Red Wolves Renew the mother kind {string} has no outcome when the father kind is {string}")]
        public void NoMotherOutcome(PickleContext ctx, string mother, string father)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(mother);
            ctx.Require(kind != null, $"no PawnKindDef named '{mother}' is loaded in this pass");
            var type = AccessTools.TypeByName("DZY.CrossBreeding.Extension");
            ctx.Require(type != null, "Better Crossbreeding's DZY.CrossBreeding.Extension is not loaded in this pass");
            var ext = kind.modExtensions?.FirstOrDefault(e => e != null && e.GetType() == type);
            if (ext == null) return;
            var outcomes = (IEnumerable)AccessTools.Field(type, "outcomes").GetValue(ext);
            foreach (var o in outcomes)
            {
                var k = (PawnKindDef)AccessTools.Field(o.GetType(), "kindDef").GetValue(o);
                ctx.Assert(k == null || k.defName != father, $"{mother} has an outcome for the father {father}, which this pass does not expect");
            }
        }

        [Then("Red Wolves Renew the mother kind {string} carries one Better Crossbreeding extension")]
        public void OneExtension(PickleContext ctx, string mother)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(mother);
            ctx.Require(kind != null, $"no PawnKindDef named '{mother}' is loaded in this pass");
            var type = AccessTools.TypeByName("DZY.CrossBreeding.Extension");
            ctx.Require(type != null, "Better Crossbreeding's DZY.CrossBreeding.Extension is not loaded in this pass");
            var n = kind.modExtensions == null ? 0 : kind.modExtensions.Count(e => e != null && e.GetType() == type);
            ctx.Assert(n == 1, $"{mother} carries {n} Better Crossbreeding extensions");
        }
    }
}
