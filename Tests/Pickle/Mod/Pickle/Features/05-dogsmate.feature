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

@requires:Mlie.DogsMate
Feature: The red wolf beside Dogs mate (Continued)

  Scenario: the red wolf courts the vanilla wolves and they court it
    Then mod "Mlie.DogsMate" is loaded
    And Red Wolves Renew the male "Wolf_Red" will seek "Wolf_Timber" to mate with
    And Red Wolves Renew the male "Wolf_Red" will seek "Wolf_Arctic" to mate with
    And Red Wolves Renew the male "Wolf_Timber" will seek "Wolf_Red" to mate with
    And Red Wolves Renew the male "Wolf_Arctic" will seek "Wolf_Red" to mate with

  Scenario: the red wolf is not put among dogs
    Then Red Wolves Renew the male "Wolf_Red" does not seek "Husky" to mate with
    And Red Wolves Renew the male "Husky" does not seek "Wolf_Red" to mate with

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.redwolves"
