# Pass 3: A Dog Said... Animal Prosthetics 2 loaded AFTER this mod, the order the mod declares with
# loadBefore. English only.
#
# D1. The patch (Mod/Patches/Addon_ADogSaid.xml) adds the red wolf to ADS 2's three category lists. The
# assertion is not "the red wolf has some operations" but "it has the same ones the timber wolf has":
# both sit in all three categories, so any difference is a fault. The timber wolf and the rat are the
# controls: the timber wolf must offer more than a plain animal, or the comparison proves nothing.
#
# The effect lives in a list another mod builds while the game loads, and the failure is silent: no
# error, no warning, only operations that are not there.

@requires:nelim.pickletools.deffields
@requires:SamBucher.ADogSaidAnimalProsthetics2
Feature: The red wolf beside A Dog Said 2, in the declared load order

  Scenario: the load order is the one the mod declares
    Then mod "SamBucher.ADogSaidAnimalProsthetics2" is loaded
    And mod "nelim.redwolves" loads before "SamBucher.ADogSaidAnimalProsthetics2"

  Scenario: the red wolf is offered the same operations as the timber wolf
    Then Red Wolves Renew "Wolf_Timber" offers more operations than "Rat"
    And Red Wolves Renew "Wolf_Red" offers more operations than "Rat"
    And Nelim's Pickle Tools: the surgery recipes of the race "Wolf_Red" match those of the race "Wolf_Timber"

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.redwolves"
