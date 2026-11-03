using System.Collections.Generic;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace RedWolvesRenew.PickleSteps
{
    /// <summary>
    /// What a scenario has spawned, by the alias its feature gave it. Pawns are remembered by
    /// thingIDNumber, not by reference: a save and reload replaces every object, and the number is
    /// what the game keeps.
    /// </summary>
    internal static class Scene
    {
        private static readonly Dictionary<string, int> ids = new Dictionary<string, int>();

        internal static void Reset() => ids.Clear();

        internal static Map Map(PickleContext ctx)
        {
            ctx.Require(Current.Game != null && Find.CurrentMap != null,
                "no current map: load the test-colony fixture before this step");
            return Find.CurrentMap;
        }

        internal static void Remember(string alias, Pawn pawn) => ids[alias] = pawn.thingIDNumber;

        internal static Pawn Named(PickleContext ctx, string alias)
        {
            int id;
            ctx.Require(ids.TryGetValue(alias, out id), $"no animal was spawned under the alias '{alias}'");
            Map(ctx);
            var pawn = PawnsFinder.AllMapsWorldAndTemporary_AliveOrDead.FirstOrDefault(p => p.thingIDNumber == id);
            ctx.Require(pawn != null, $"the pawn behind '{alias}' (thingIDNumber {id}) no longer exists");
            return pawn;
        }
    }
}
