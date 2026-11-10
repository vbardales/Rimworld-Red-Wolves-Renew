using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace RedWolvesRenew.PickleSteps
{
    /// <summary>
    /// Texts with a colonist in them, resolved the way the game resolves them for a player: the
    /// {PAWN_gender ? ... : ... : ...} switches of the Pawnmorpher thoughts and backstories. No file
    /// read can say what the game does with a switch, and the neutral form (the third segment) is the
    /// one most likely to be wrong. A throwaway colonist of the asked gender is generated, never spawned.
    /// </summary>
    [PickleSteps]
    public class TextSteps
    {
        private static Pawn Colonist(PickleContext ctx, string gender)
        {
            Gender wanted;
            switch (gender)
            {
                case "male": wanted = Gender.Male; break;
                case "female": wanted = Gender.Female; break;
                case "neutral": wanted = Gender.Male; break;
                default: ctx.Require(false, $"'{gender}' is not male, female or neutral"); return null;
            }
            var pawn = PawnGenerator.GeneratePawn(new PawnGenerationRequest(
                PawnKindDefOf.Colonist, Faction.OfPlayer, forceGenerateNewPawn: true, fixedGender: wanted));
            // The game's neutral gender: the one the French "al" segment answers.
            if (gender == "neutral") pawn.gender = Gender.None;
            return pawn;
        }

        private static string ThoughtText(PickleContext ctx, string defName, int stage, string gender)
        {
            var def = DefDatabase<ThoughtDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThoughtDef named '{defName}' is loaded in this pass");
            ctx.Require(def.stages != null && stage >= 0 && stage < def.stages.Count, $"{defName} has no stage {stage}");
            var pawn = Colonist(ctx, gender);
            try { return def.stages[stage].description.Formatted(pawn.Named("PAWN")).Resolve(); }
            finally { pawn.Discard(true); }
        }

        private static string BackstoryText(PickleContext ctx, string defName, string gender)
        {
            // The defs are written as AlienRace.AlienBackstoryDef; the game's own type lookup finds it without
            // this assembly referencing Humanoid Alien Races, and the cast says it is a vanilla backstory too.
            var type = GenTypes.GetTypeInAnyAssembly("AlienRace.AlienBackstoryDef") ?? typeof(BackstoryDef);
            var def = GenDefDatabase.GetDefSilentFail(type, defName, false) as BackstoryDef;
            ctx.Require(def != null, $"no backstory named '{defName}' (a {type.FullName}) is loaded in this pass");
            var pawn = Colonist(ctx, gender);
            try { return def.FullDescriptionFor(pawn).Resolve(); }
            finally { pawn.Discard(true); }
        }

        [Then("Red Wolves Renew stage {int} of the thought {string} reads {string} for a {word} colonist")]
        public void ThoughtContains(PickleContext ctx, int stage, string defName, string fragment, string gender)
        {
            var text = ThoughtText(ctx, defName, stage, gender);
            ctx.Assert(text.Contains(fragment), $"stage {stage} of {defName} reads '{text}' for a {gender} colonist, expected it to contain '{fragment}'");
        }

        [Then("Red Wolves Renew the backstory {string} reads {string} for a {word} colonist")]
        public void BackstoryContains(PickleContext ctx, string defName, string fragment, string gender)
        {
            var text = BackstoryText(ctx, defName, gender);
            ctx.Assert(text.Contains(fragment), $"{defName} reads '{text}' for a {gender} colonist, expected it to contain '{fragment}'");
        }

        [Then("Red Wolves Renew no switch or token is left in the backstory {string} for a {word} colonist")]
        public void BackstoryResolved(PickleContext ctx, string defName, string gender)
        {
            var text = BackstoryText(ctx, defName, gender);
            ctx.Assert(!text.Contains("{PAWN_") && !text.Contains("[PAWN_"),
                $"{defName} still holds an unresolved switch or token for a {gender} colonist: '{text}'");
        }

        // An observation, not an assertion: the English ForcedGeneral backstory carries the upstream
        // token [PAWN_possesive] (a typo, left unchanged on purpose). What the game prints for it is not
        // known; the report carries the text so that a person can read it.
        [When("Red Wolves Renew attaches the text of the backstory {string} for a {word} colonist")]
        public void AttachBackstory(PickleContext ctx, string defName, string gender) =>
            ctx.Attach($"{defName}, {gender} colonist", BackstoryText(ctx, defName, gender));
    }
}
