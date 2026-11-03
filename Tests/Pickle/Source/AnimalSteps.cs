using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace RedWolvesRenew.PickleSteps
{
    /// <summary>
    /// The animal as a player meets it: spawned wild, tamed, named, offered its trainings, described
    /// on its information card. Copied from the Dalmatians Renew suite (NPT ruling, 2026-11-03) and cut
    /// to what a red wolf needs: no coat, butcher, rot or camera steps.
    /// </summary>
    [PickleSteps]
    public class AnimalSteps
    {
        [BeforeScenario]
        public void ResetScene(PickleContext ctx) => Scene.Reset();

        private static IntVec3 FreeCell(PickleContext ctx)
        {
            var map = Scene.Map(ctx);
            IntVec3 cell;
            var found = CellFinder.TryFindRandomCellNear(map.Center, map, 20,
                c => c.Standable(map) && c.GetEdifice(map) == null && c.GetFirstPawn(map) == null, out cell);
            ctx.Require(found, $"no free standable cell was found near {map.Center}");
            return cell;
        }

        private static Pawn Spawn(PickleContext ctx, string kindName, Faction faction, float age)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no PawnKindDef named '{kindName}' is loaded in this pass");
            var pawn = PawnGenerator.GeneratePawn(new PawnGenerationRequest(
                kind, faction, forceGenerateNewPawn: true, fixedBiologicalAge: age));
            GenSpawn.Spawn(pawn, FreeCell(ctx), Scene.Map(ctx));
            return pawn;
        }

        // The name is left alone on purpose: a wild animal has none, and giving it one here would
        // make the "takes a name the moment it is tamed" scenario pass whatever the race says.
        [Given("Red Wolves Renew spawns the wild animal {string} as {string}")]
        public void SpawnWild(PickleContext ctx, string alias, string kindName) =>
            Scene.Remember(alias, Spawn(ctx, kindName, null, 3f));

        [When("Red Wolves Renew tames {string}")]
        public void Tame(PickleContext ctx, string alias)
        {
            var animal = Scene.Named(ctx, alias);
            var tamer = Scene.Map(ctx).mapPawns.FreeColonistsSpawned.FirstOrDefault();
            ctx.Require(tamer != null, "the fixture has no free colonist to do the taming");
            ctx.Require(animal.Faction == null, $"{alias} already belongs to {animal.Faction?.Name}");
            InteractionWorker_RecruitAttempt.DoRecruit(tamer, animal);
        }

        // pawn.training is the same Pawn_TrainingTracker the Training tab reads, so this asks exactly
        // what the tab would show without opening it.
        [Then("Red Wolves Renew {string} offers training {string}")]
        public void OffersTraining(PickleContext ctx, string alias, string trainableName)
        {
            var animal = Scene.Named(ctx, alias);
            var trainable = DefDatabase<TrainableDef>.GetNamedSilentFail(trainableName);
            ctx.Require(trainable != null, $"no TrainableDef named '{trainableName}' is loaded in this pass");
            var accepted = animal.training.CanAssignToTrain(trainable, out var visible);
            ctx.Assert(visible, $"{alias}'s Training tab does not offer {trainableName}");
            ctx.Assert(accepted.Accepted, $"{alias} cannot be assigned to {trainableName}: {accepted.Reason}");
        }

        [Then("Red Wolves Renew {string} belongs to the player")]
        public void BelongsToPlayer(PickleContext ctx, string alias) =>
            ctx.Assert(Scene.Named(ctx, alias).Faction == Faction.OfPlayer, $"{alias} is not a player animal");

        [Then("Red Wolves Renew {string} has a name")]
        public void HasName(PickleContext ctx, string alias)
        {
            var name = Scene.Named(ctx, alias).Name;
            ctx.Assert(name != null, $"{alias} has no name after being tamed; nameOnTameChance should be 1");
        }

        [Then("Red Wolves Renew {string} has no name")]
        public void HasNoName(PickleContext ctx, string alias)
        {
            var name = Scene.Named(ctx, alias).Name;
            ctx.Assert(name == null, $"{alias} is already named {name}");
        }

        [Then("Red Wolves Renew the information card of {string} lists the stat {string} at {string}")]
        public void CardLists(PickleContext ctx, string alias, string statName, string value)
        {
            var stat = DefDatabase<StatDef>.GetNamedSilentFail(statName);
            ctx.Require(stat != null, $"no StatDef named '{statName}'");
            var entry = StatsReportUtility.StatsToDraw(Scene.Named(ctx, alias)).FirstOrDefault(e => e.stat == stat);
            ctx.Assert(entry != null, $"the information card of {alias} does not list {statName}");
            ctx.Assert(entry.ValueString.Trim() == value,
                $"the card lists {statName} at '{entry.ValueString}', expected '{value}'");
        }
    }
}
