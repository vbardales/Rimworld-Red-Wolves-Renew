# Pass 2 (English): Pawnmorpher beside this mod. Humanoid Alien Races is Pawnmorpher's
# hard dependency for this game version and is named first in the map.
#
# G. ModIntegrations/Pawnmorpher loads through IfModActive="tachyonite.pawnmorpherpublic" in
# LoadFolders.xml. A guard naming an id no mod has loads nothing and logs nothing: that fault was found
# once in this port, so the first scenario asserts the defs exist, not that the log is quiet. The French
# files sit in the same folder, so they load with it and nowhere else.
#
# Cut to this one scenario on 2026-11-10 (Virginie, via Audit). Pawnmorpher on top of Humanoid Alien Races aborts
# the game natively at the second colony load of the shared test-colony fixture (saved without both mods; its
# pawns carry no AlienComp data): tickets a348 and 1fcc, exit 134, 25 x AlienPartGenerator:804. HAR alone is clean
# (ticket c291). So the colony-bound scenarios (log quiet, the English text, the French morph, the gender switches
# of the backstories and thoughts) are not applicable here: see TESTING.md, "Not applicable in Pickle".
# One run, one language: the defs do not depend on it.

@requires:nelim.pickletools.deffields
@requires:tachyonite.pawnmorpherpublic
Feature: The red wolf morph beside Pawnmorpher

  Scenario: the Pawnmorpher folder loaded and every kind of def of it exists
    Then mod "tachyonite.pawnmorpherpublic" is loaded
    And mod "erdelf.HumanoidAlienRaces" is loaded
    And Nelim's Pickle Tools: the def "RedWolfMorph" of type "Pawnmorph.MorphDef" comes from the mod "nelim.redwolves"
    And Nelim's Pickle Tools: the def "PawnmorphRedWolfTF" of type "HediffDef" comes from the mod "nelim.redwolves"
    And Nelim's Pickle Tools: the def "PawnmorphRedWolfTFPartial" of type "HediffDef" comes from the mod "nelim.redwolves"
    And Nelim's Pickle Tools: the def "EtherRedWolfMuzzle" of type "HediffDef" comes from the mod "nelim.redwolves"
    And Nelim's Pickle Tools: the def "RedWolfTransformationMemory" of type "ThoughtDef" comes from the mod "nelim.redwolves"
    And Nelim's Pickle Tools: the def "RedWolfRevertedMemory" of type "ThoughtDef" comes from the mod "nelim.redwolves"
    And Nelim's Pickle Tools: the def "RedwolfmorphConservationVolunteerGeneral" of type "AlienRace.AlienBackstoryDef" comes from the mod "nelim.redwolves"
    And Nelim's Pickle Tools: the def "RedwolfmorphConservationForcedGeneral" of type "AlienRace.AlienBackstoryDef" comes from the mod "nelim.redwolves"
