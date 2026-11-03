# Pass 6 (alone) and pass 7 (with Dogs mate): Better Crossbreeding beside this mod. English only.
#
# F. Mod/Patches/Compat_BetterCrossbreeding.xml makes the red wolf and the timber wolf cross each way,
# with a coin-flip pup. Two halves, both asserted on the live defs: the list on the MALE's race (what the
# game reads to pair them) and the DZY.CrossBreeding.Extension on the MOTHER's kind (what the mod reads
# to decide the pup). Neither half alone breeds anything. The extension class is spelled
# DZY.CrossBreeding in the assembly; a patch copied from the mod's Example/ names a type that does not
# exist, and the extension would then simply be missing.
#
# What is NOT played here: a pregnancy through to a birth. The mod keeps a per-save dictionary of
# fathers, so it would need a save and a reload.

@requires:DizzyEevee.BetterCrossbreeding
Feature: The red wolf beside Better Crossbreeding

  Scenario: the red wolf and the timber wolf seek each other, once
    Then mod "DizzyEevee.BetterCrossbreeding" is loaded
    And Red Wolves Renew the male "Wolf_Red" lists "Wolf_Timber" once
    And Red Wolves Renew the male "Wolf_Timber" lists "Wolf_Red" once

  Scenario: each mother has a coin-flip outcome for the other kind
    Then Red Wolves Renew the mother kind "Wolf_Red" carries one Better Crossbreeding extension
    And Red Wolves Renew the mother kind "Wolf_Timber" carries one Better Crossbreeding extension
    And Red Wolves Renew the mother kind "Wolf_Red" has the outcome Random when the father kind is "Wolf_Timber"
    And Red Wolves Renew the mother kind "Wolf_Timber" has the outcome Random when the father kind is "Wolf_Red"

  Scenario: this patch paired the red wolf with no dog
    Then Red Wolves Renew the male "Wolf_Red" does not seek "Husky" to mate with
    And Red Wolves Renew the mother kind "Wolf_Red" has no outcome when the father kind is "Husky"

  # Tagged: with Dogs mate loaded (pass 7) the vanilla wolves DO seek each other, by that mod's Wolf
  # group, which is not this patch's doing. Pass 7 excludes this tag; pass 6 plays it.
  @without-dogsmate
  Scenario: without Dogs mate the vanilla wolves do not seek each other
    Then Red Wolves Renew the male "Wolf_Timber" does not seek "Wolf_Arctic" to mate with

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.redwolves"
