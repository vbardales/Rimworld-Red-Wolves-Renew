# Pass 5 (alone) and pass 7 (with Better Crossbreeding): Dogs mate (Continued) beside this mod.
# English only.
#
# E. Mod/Patches/Compat_DogsMate.xml appends Wolf_Red to Dogs mate's group "Wolf", which holds
# Wolf_Arctic and Wolf_Timber. Dogs mate then fills race.canCrossBreedWith of every race of the group at
# startup. The game reads that list on the MALE only, so both directions are asserted. The husky is the
# control: it sits in another group, and a pass where the red wolf seeks it means the patch put it in
# the wrong one.
#
# The effect lives in a list another mod builds while the game loads, and the failure is silent: no
# error, no warning, a wolf that simply never courts the timber wolf.

@requires:nelim.pickletools.deffields
@requires:Mlie.DogsMate
Feature: The red wolf beside Dogs mate (Continued)

  Scenario: the red wolf courts the vanilla wolves and they court it
    Then mod "Mlie.DogsMate" is loaded
    And Nelim's Pickle Tools: the pawn kind "Wolf_Red" is in the mating group "Wolf"
    And Nelim's Pickle Tools: the race "Wolf_Red" lists "Wolf_Timber" as a crossbreeding partner
    And Nelim's Pickle Tools: the race "Wolf_Red" lists "Wolf_Arctic" as a crossbreeding partner
    And Nelim's Pickle Tools: the race "Wolf_Timber" lists "Wolf_Red" as a crossbreeding partner
    And Nelim's Pickle Tools: the race "Wolf_Arctic" lists "Wolf_Red" as a crossbreeding partner

  Scenario: the red wolf is not put among dogs
    Then Nelim's Pickle Tools: the race "Wolf_Red" does not list "Husky" as a crossbreeding partner
    And Nelim's Pickle Tools: the race "Husky" does not list "Wolf_Red" as a crossbreeding partner

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.redwolves"
