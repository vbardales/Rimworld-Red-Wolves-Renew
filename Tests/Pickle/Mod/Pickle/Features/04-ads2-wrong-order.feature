# Pass 4: A Dog Said 2 loaded BEFORE this mod, the order the mod's metadata forbids. English only.
#
# D3. The negative control, and the scenario that justifies <loadBefore>. ADS 2's own last patch copies
# the three categories' recipeUsers onto the real surgery recipes, taking each list as it stands at
# that moment. This mod's addition, made afterwards, goes into a list nothing reads any more, and
# nothing is logged.
#
# Not compared with a plain animal alone: every vanilla animal sits in at least one of ADS 2's
# categories, the rat in the first, so the rat is not a base list. The red wolf must offer fewer
# operations than the timber wolf and none of what only the timber wolf offers.
#
# The symptom is asserted as a green result, not awaited as a red one. If these steps fail, the
# mechanism ATTRIBUTION.md and README.md describe is not what the game does, and the documents need
# correcting. The first scenario asserts the order was really applied: the staging script sorts a load
# order from the mods' own rules, and a mod that declares loadBefore may be put back in the right
# order, in which case the pass cannot be staged and this is recorded in STATUS.md.
#
# This is the one pass that steps outside the supported configuration on purpose.

@requires:nelim.pickletools.deffields
@requires:SamBucher.ADogSaidAnimalProsthetics2
Feature: The red wolf beside A Dog Said 2, in the wrong load order

  Scenario: A Dog Said 2 really is loaded first
    Then mod "SamBucher.ADogSaidAnimalProsthetics2" loads before "nelim.redwolves"

  Scenario: the timber wolf keeps its operations and the red wolf loses them
    Then Red Wolves Renew "Wolf_Timber" offers more operations than "Rat"
    And Red Wolves Renew "Wolf_Red" offers fewer operations than "Wolf_Timber"
    And Red Wolves Renew "Wolf_Red" offers none of the operations that "Wolf_Timber" offers and "Rat" does not
