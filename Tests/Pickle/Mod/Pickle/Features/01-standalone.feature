# Pass 1: the mod and nothing optional. Run once in English and once in French (see
# Tests/Pickle/README.md for the exact commands). Scenarios tagged @english or @french are written
# against the language their pass was launched in; the language is never switched here.
#
# Only what a running game can show is kept in Gherkin. The XML, the values as written, the texture
# paths, About.xml and LoadFolders.xml, and the patch files applied to fixtures are checked offline by
# Tests/test_mod.py. What is read here is what the game kept after loading a whole mod list.
#
# The animal steps (spawn, tame, name, training, information card) and the def steps (field, where a
# def comes from, biome, surgery recipes) are Nelim's Pickle Tools' (ColonistRace and DefFieldSteps,
# PickleTools 813dc0f); "Red Wolves Renew ..." steps are the few this mod needs beyond them.

@requires:nelim.pickletools.deffields
@requires:nelim.pickletools.colonistrace
Feature: The red wolf on its own

  Scenario: the mod owns the animal and no optional integration is loaded
    Then mod "nelim.redwolves" is loaded
    And Nelim's Pickle Tools: the def "Wolf_Red" of type "ThingDef" comes from the mod "nelim.redwolves"
    And Nelim's Pickle Tools: the def "Wolf_Red" of type "PawnKindDef" comes from the mod "nelim.redwolves"
    And mod "tachyonite.pawnmorpherpublic" is not loaded
    And mod "SamBucher.ADogSaidAnimalProsthetics2" is not loaded
    And mod "Mlie.DogsMate" is not loaded
    And mod "DizzyEevee.BetterCrossbreeding" is not loaded

  # B. The values the game kept. Scenario B of TESTING.md.
  Scenario: the race carries the original author's values and inherits the vanilla wolf's
    Then Nelim's Pickle Tools: def "Wolf_Red" of type "ThingDef" field "race.baseBodySize" is "0.68"
    And Nelim's Pickle Tools: def "Wolf_Red" of type "ThingDef" field "race.maxPreyBodySize" is "1.8"
    And Nelim's Pickle Tools: def "Wolf_Red" of type "ThingDef" field "race.manhunterOnTameFailChance" is "0.1"
    And Nelim's Pickle Tools: def "Wolf_Red" of type "ThingDef" field "race.manhunterOnDamageChance" is "0.7"
    And Nelim's Pickle Tools: def "Wolf_Red" of type "ThingDef" field "race.useMeatFrom" is "Wolf_Timber"
    And Nelim's Pickle Tools: def "Wolf_Red" of type "ThingDef" field "race.nameOnTameChance" is "1"
    And Nelim's Pickle Tools: def "Wolf_Red" of type "ThingDef" field "race.trainability" is "Advanced"
    And Red Wolves Renew the stat "ComfyTemperatureMin" of the thing "Wolf_Red" is "-25"
    And Red Wolves Renew the stat "FilthRate" of the thing "Wolf_Red" is "1.6"
    And Red Wolves Renew the stat "Wildness" of the thing "Wolf_Red" equals that of the thing "Wolf_Timber"

  Scenario: the red wolf is wild in the five biomes the mod names
    Then Nelim's Pickle Tools: the biome "TemperateForest" lists the wild animal "Wolf_Red"
    And Nelim's Pickle Tools: the biome "TemperateSwamp" lists the wild animal "Wolf_Red"
    And Nelim's Pickle Tools: the biome "BorealForest" lists the wild animal "Wolf_Red"
    And Nelim's Pickle Tools: the biome "ColdBog" lists the wild animal "Wolf_Red"
    And Nelim's Pickle Tools: the biome "AridShrubland" lists the wild animal "Wolf_Red"

  # A. The animal exists, spawns, takes a name the moment it is tamed, is offered its trainings, and
  #    its information card lists Wildness. The timber wolf is the control: the card of a wild animal
  #    of its own kind shows the same line at the same value (the red wolf inherits ThingBaseWolf's 0.85).
  Scenario: a tamed red wolf is named on the spot, is offered its trainings and lists Wildness
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Nelim's Pickle Tools: the wild animal "Rusty" of kind "Wolf_Red" is spawned
    And Nelim's Pickle Tools: the wild animal "Control" of kind "Wolf_Timber" is spawned
    Then Nelim's Pickle Tools: the animal "Rusty" has no name
    And Nelim's Pickle Tools: the information card of the animal "Control" lists the stat "Wildness" at "85%"
    And Nelim's Pickle Tools: the information card of the animal "Rusty" lists the stat "Wildness" at "85%"
    When Nelim's Pickle Tools: the animal "Rusty" is tamed
    Then Nelim's Pickle Tools: the animal "Rusty" belongs to the player
    And Nelim's Pickle Tools: the animal "Rusty" has a name
    And Nelim's Pickle Tools: the animal "Rusty" offers the training "Obedience"
    And Nelim's Pickle Tools: the animal "Rusty" offers the training "Release"
    And Nelim's Pickle Tools: the animal "Rusty" offers the training "Rescue"
    And Nelim's Pickle Tools: the animal "Rusty" offers the training "Haul"
    And no errors were logged
    And no warnings from mod "nelim.redwolves"

  # D2. A Dog Said 2 absent: the guarded patch says nothing and adds nothing. Whatever a vanilla
  #     animal is offered, and no more.
  Scenario: without A Dog Said 2 the red wolf is offered what any vanilla animal is offered
    Then Nelim's Pickle Tools: the surgery recipes of the race "Wolf_Red" match those of the race "Rat"

  # L. Text, in the language of this pass. The language step is an assertion about the pass, not a
  #    switch: a pass that fell back to English silently would prove nothing about French.
  @english
  Scenario: the animal and its puppy read in English
    Then Red Wolves Renew this pass runs in English
    And Nelim's Pickle Tools: def "Wolf_Red" of type "ThingDef" field "label" is "red wolf"
    And Red Wolves Renew the def "Wolf_Red" of type "ThingDef" has a description beginning "A smaller, more timid species of wolf"
    And Nelim's Pickle Tools: def "Wolf_Red" of type "PawnKindDef" field "label" is "red wolf"
    And Nelim's Pickle Tools: def "Wolf_Red" of type "PawnKindDef" field "labelPlural" is "red wolves"
    And Red Wolves Renew the first life stage of pawn kind "Wolf_Red" is labelled "red wolf puppy" and pluralised "red wolf puppies"

  @french
  Scenario: the animal and its puppy read in French
    Then Red Wolves Renew this pass runs in French
    And Nelim's Pickle Tools: def "Wolf_Red" of type "ThingDef" field "label" is "loup rouge"
    And Red Wolves Renew the def "Wolf_Red" of type "ThingDef" has a description beginning "Une espèce de loup plus petite et plus craintive"
    And Nelim's Pickle Tools: def "Wolf_Red" of type "PawnKindDef" field "label" is "loup rouge"
    And Nelim's Pickle Tools: def "Wolf_Red" of type "PawnKindDef" field "labelPlural" is "loups rouges"
    And Red Wolves Renew the first life stage of pawn kind "Wolf_Red" is labelled "louveteau rouge" and pluralised "louveteaux rouges"
