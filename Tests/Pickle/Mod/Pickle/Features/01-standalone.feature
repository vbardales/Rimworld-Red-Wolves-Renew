# Pass 1: the mod and nothing optional. Run once in English and once in French (see
# Tests/Pickle/README.md for the exact commands). Scenarios tagged @english or @french are written
# against the language their pass was launched in; the language is never switched here.
#
# Only what a running game can show is kept in Gherkin. The XML, the values as written, the texture
# paths, About.xml and LoadFolders.xml, and the patch files applied to fixtures are checked offline by
# Tests/test_mod.py. What is read here is what the game kept after loading a whole mod list.

Feature: The red wolf on its own

  Scenario: the mod owns the animal and no optional integration is loaded
    Then mod "nelim.redwolves" is loaded
    And Red Wolves Renew the thing "Wolf_Red" comes from the mod "nelim.redwolves"
    And Red Wolves Renew the pawn kind "Wolf_Red" comes from the mod "nelim.redwolves"
    And mod "tachyonite.pawnmorpherpublic" is not loaded
    And mod "SamBucher.ADogSaidAnimalProsthetics2" is not loaded
    And mod "Mlie.DogsMate" is not loaded
    And mod "DizzyEevee.BetterCrossbreeding" is not loaded

  # B. The values the game kept. Scenario B of TESTING.md.
  Scenario: the race carries the original author's values and inherits the vanilla wolf's
    Then Red Wolves Renew the race of "Wolf_Red" reads "baseBodySize" as "0.68"
    And Red Wolves Renew the race of "Wolf_Red" reads "maxPreyBodySize" as "1.8"
    And Red Wolves Renew the race of "Wolf_Red" reads "manhunterOnTameFailChance" as "0.1"
    And Red Wolves Renew the race of "Wolf_Red" reads "manhunterOnDamageChance" as "0.7"
    And Red Wolves Renew the race of "Wolf_Red" reads "useMeatFrom" as "Wolf_Timber"
    And Red Wolves Renew the race of "Wolf_Red" reads "nameOnTameChance" as "1"
    And Red Wolves Renew the race of "Wolf_Red" reads "trainability" as "Advanced"
    And Red Wolves Renew the stat "ComfyTemperatureMin" of the thing "Wolf_Red" is "-25"
    And Red Wolves Renew the stat "FilthRate" of the thing "Wolf_Red" is "1.6"
    And Red Wolves Renew the stat "Wildness" of the thing "Wolf_Red" equals that of the thing "Wolf_Timber"

  Scenario: the red wolf is wild in the five biomes the mod names and in no other
    Then Red Wolves Renew the pawn kind "Wolf_Red" is wild in the biome "TemperateForest"
    And Red Wolves Renew the pawn kind "Wolf_Red" is wild in the biome "TemperateSwamp"
    And Red Wolves Renew the pawn kind "Wolf_Red" is wild in the biome "BorealForest"
    And Red Wolves Renew the pawn kind "Wolf_Red" is wild in the biome "ColdBog"
    And Red Wolves Renew the pawn kind "Wolf_Red" is wild in the biome "AridShrubland"
    And Red Wolves Renew the pawn kind "Wolf_Red" is not wild in the biome "TropicalRainforest"
    And Red Wolves Renew the pawn kind "Wolf_Red" is not wild in the biome "IceSheet"

  # A. The animal exists, spawns, takes a name the moment it is tamed, is offered its trainings, and
  #    its information card lists Wildness. The timber wolf is the control: the card of a wild animal
  #    of its own kind shows the same line at the same value.
  Scenario: a tamed red wolf is named on the spot, is offered its trainings and lists Wildness
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Red Wolves Renew spawns the wild animal "Rusty" as "Wolf_Red"
    And Red Wolves Renew spawns the wild animal "Control" as "Wolf_Timber"
    Then Red Wolves Renew "Rusty" has no name
    And Red Wolves Renew the information card of "Control" lists the stat "Wildness" at "85%"
    And Red Wolves Renew the information card of "Rusty" lists the stat "Wildness" at "85%"
    When Red Wolves Renew tames "Rusty"
    Then Red Wolves Renew "Rusty" belongs to the player
    And Red Wolves Renew "Rusty" has a name
    And Red Wolves Renew "Rusty" offers training "Obedience"
    And Red Wolves Renew "Rusty" offers training "Release"
    And Red Wolves Renew "Rusty" offers training "Rescue"
    And Red Wolves Renew "Rusty" offers training "Haul"
    And no errors were logged
    And no warnings from mod "nelim.redwolves"

  # D2. A Dog Said 2 absent: the guarded patch says nothing and adds nothing. Whatever a vanilla
  #     animal is offered, and no more.
  Scenario: without A Dog Said 2 the red wolf is offered what any vanilla animal is offered
    Then Red Wolves Renew "Wolf_Red" offers the same operations as "Rat"

  # L. Text, in the language of this pass. The language step is an assertion about the pass, not a
  #    switch: a pass that fell back to English silently would prove nothing about French.
  @english
  Scenario: the animal and its puppy read in English
    Then Red Wolves Renew this pass runs in English
    And Red Wolves Renew the thing "Wolf_Red" is labelled "red wolf"
    And Red Wolves Renew the thing "Wolf_Red" has a description beginning "A smaller, more timid species of wolf"
    And Red Wolves Renew the pawn kind "Wolf_Red" is labelled "red wolf" and pluralised "red wolves"
    And Red Wolves Renew the first life stage of pawn kind "Wolf_Red" is labelled "red wolf puppy" and pluralised "red wolf puppies"

  @french
  Scenario: the animal and its puppy read in French
    Then Red Wolves Renew this pass runs in French
    And Red Wolves Renew the thing "Wolf_Red" is labelled "loup rouge"
    And Red Wolves Renew the thing "Wolf_Red" has a description beginning "Une espèce de loup plus petite et plus craintive"
    And Red Wolves Renew the pawn kind "Wolf_Red" is labelled "loup rouge" and pluralised "loups rouges"
    And Red Wolves Renew the first life stage of pawn kind "Wolf_Red" is labelled "louveteau rouge" and pluralised "louveteaux rouges"
