# Pass 2 (English, then French): Pawnmorpher beside this mod. Humanoid Alien Races is Pawnmorpher's
# hard dependency for this game version and is named first in the map.
#
# G. ModIntegrations/Pawnmorpher loads through IfModActive="tachyonite.pawnmorpherpublic" in
# LoadFolders.xml. A guard naming an id no mod has loads nothing and logs nothing: that fault was found
# once in this port, so the first scenario asserts the defs exist, not that the log is quiet. The French
# files sit in the same folder, so they load with it and nowhere else.
#
# L. The {PAWN_gender ? ... : ... : ...} switches of the backstories and thoughts. Offline, only the
# syntax can be read; here the game resolves them for a male, a female and a neutral colonist, the
# neutral form being the third segment (the al system, validated by Virginie, STATUS.md).
#
# Not asserted: the numeric stagePatches keys of the French mutation texts. They point into a list
# merged with Pawnmorpher's, so what they land on is a person's reading of an open health tab.

@requires:tachyonite.pawnmorpherpublic
Feature: The red wolf morph beside Pawnmorpher

  Scenario: the Pawnmorpher folder loaded and every kind of def of it exists
    Then mod "tachyonite.pawnmorpherpublic" is loaded
    And mod "erdelf.HumanoidAlienRaces" is loaded
    And Red Wolves Renew the def "RedWolfMorph" of type "Pawnmorph.MorphDef" comes from the mod "nelim.redwolves"
    And Red Wolves Renew the def "PawnmorphRedWolfTF" of type "Verse.HediffDef" comes from the mod "nelim.redwolves"
    And Red Wolves Renew the def "PawnmorphRedWolfTFPartial" of type "Verse.HediffDef" comes from the mod "nelim.redwolves"
    And Red Wolves Renew the def "EtherRedWolfMuzzle" of type "Verse.HediffDef" comes from the mod "nelim.redwolves"
    And Red Wolves Renew the def "RedWolfTransformationMemory" of type "RimWorld.ThoughtDef" comes from the mod "nelim.redwolves"
    And Red Wolves Renew the def "RedWolfRevertedMemory" of type "RimWorld.ThoughtDef" comes from the mod "nelim.redwolves"
    And Red Wolves Renew the def "RedwolfmorphConservationVolunteerGeneral" of type "RimWorld.BackstoryDef" comes from the mod "nelim.redwolves"
    And Red Wolves Renew the def "RedwolfmorphConservationForcedGeneral" of type "RimWorld.BackstoryDef" comes from the mod "nelim.redwolves"

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.redwolves"

  @english
  Scenario: the morph reads in English and the backstory resolves every pronoun
    Then Red Wolves Renew this pass runs in English
    And Red Wolves Renew the def "RedWolfMorph" of type "Pawnmorph.MorphDef" has a description beginning "Like their wild counterparts"
    And Red Wolves Renew no switch or token is left in the backstory "RedwolfmorphConservationVolunteerGeneral" for a female colonist
    And Red Wolves Renew no switch or token is left in the backstory "RedwolfmorphConservationVolunteerGeneral" for a male colonist

  # Observation only. The upstream English token [PAWN_possesive] (a typo, kept on purpose) sits in this
  # backstory; whether the game prints it raw or drops it is not known. The text goes in the report.
  @english
  Scenario: the English text of the backstory with the upstream token is read in the report
    When Red Wolves Renew attaches the text of the backstory "RedwolfmorphConservationForcedGeneral" for a female colonist
    And Red Wolves Renew attaches the text of the backstory "RedwolfmorphConservationForcedGeneral" for a male colonist

  @french
  Scenario: the morph, its hediffs and a mutation read in French
    Then Red Wolves Renew this pass runs in French
    And Red Wolves Renew the def "RedWolfMorph" of type "Pawnmorph.MorphDef" is labelled "morphe de loup rouge"
    And Red Wolves Renew the def "RedWolfMorph" of type "Pawnmorph.MorphDef" has a description beginning "Comme leurs équivalents sauvages"
    And Red Wolves Renew the def "PawnmorphRedWolfTF" of type "Verse.HediffDef" is labelled "morphe de loup rouge"
    And Red Wolves Renew the def "PawnmorphRedWolfTFPartial" of type "Verse.HediffDef" is labelled "morphe partiel de loup rouge"
    And Red Wolves Renew the def "EtherRedWolfMuzzle" of type "Verse.HediffDef" is labelled "museau de loup rouge"

  @french
  Scenario Outline: the backstory with a switch resolves to the form of the colonist
    Then Red Wolves Renew the backstory "RedwolfmorphConservationVolunteerGeneral" reads "<volunteer>" for a <gender> colonist
    And Red Wolves Renew the backstory "RedwolfmorphConservationForcedGeneral" reads "<forced>" for a <gender> colonist
    And Red Wolves Renew no switch or token is left in the backstory "RedwolfmorphConservationVolunteerGeneral" for a <gender> colonist
    And Red Wolves Renew no switch or token is left in the backstory "RedwolfmorphConservationForcedGeneral" for a <gender> colonist

    Examples:
      | gender  | volunteer             | forced                          |
      | male    | il a été volontaire   | retrouvé en partie transformé   |
      | female  | elle a été volontaire | retrouvée en partie transformée |
      | neutral | al a été volontaire   | retrouvæ en partie transformæ   |

  @french
  Scenario Outline: the thoughts with a switch resolve to the form of the colonist
    Then Red Wolves Renew stage 0 of the thought "RedWolfTransformationMemory" reads "<transformed>" for a <gender> colonist
    And Red Wolves Renew stage 0 of the thought "RedWolfRevertedMemory" reads "<reverted>" for a <gender> colonist
    And Red Wolves Renew stage 1 of the thought "RedWolfRevertedMemory" reads "<cute>" for a <gender> colonist

    Examples:
      | gender  | transformed       | reverted         | cute        |
      | male    | Si je suis censé  | suis content de  | si mignon   |
      | female  | Si je suis censée | suis contente de | si mignonne |
      | neutral | Si je suis censæ  | suis contentæ de | si mignonæ  |
