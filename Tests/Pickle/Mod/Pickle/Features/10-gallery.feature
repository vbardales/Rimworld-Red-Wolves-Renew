# SHOTLIST: Red Wolves Renew gallery (written 2026-11-11 at shootGallery, revised after the director pass; no scenario yet)
#
# STORY. One day at Nelim's Sanctuary. Nelim (the protagonist, the only colonist) meets a shy young red wolf, Ember, at dawn on the
# river bridge, wins her trust with a piece of meat, meets her three cousins' coats at noon, walks home with her under the torii,
# and at dusk finds her with a timber wolf and a puppy among the flowers. Rhythm: one hour per scene (07, 09, 12, 15, 18), same
# day, `I set the hour to N` in each scenario, Nelim keeps the same garments. The series shows the animal (plain coat and the three
# variants A, B, C, adult and puppy), its shyness, and both crossing integrations (Dogs mate, Better Crossbreeding).
# Not shown, and why: the Pawnmorpher folder (Pickle cannot load the colony with Pawnmorpher and Humanoid Alien Races, upstream
# issue 83), Combat Extended and A Dog Said 2 (no image), Animal Gear sweater (mod not installed, no NSB entry).
#
# ONE PASS MAP for the whole series (`wsl-deps.gallery.map`, to write at rate-gallery): the NSB base map `wsl-deps.sanctuary.map`,
# Mlie.DogsMate 2441132298, DizzyEevee.BetterCrossbreeding 3520675842, nelim.redwolves path:RedWolvesRenew/Mod.
# NSB: places river-bridge, statue-garden, bare-clearing, cloister, flower-garden are free to use (validated or free zones);
# no colonist outside NSB, no change to a colonist property, no NSB animal, no domestic animal outside the mod (Wolf_Red is the mod's
# own animal, authorized by default; Wolf_Timber is a wild-wolf cousin of the mod's group, anonymous fauna).
#
# NELIM, every scene: teal `Apparel_BasicShirt` dyed rgb (64, 130, 138) over the fixture's `Apparel_Pants` (cool colour against the
# russet coats, same garments all day), hair `Roo_HD_Hair_Highpony` (her canon high ponytail with side strands, NELIM-PROFIL.md), colour near-black brown as the fixture, no hat; `Nelim's Sanctuary: Nelim has her own face`, then mouth
# `MouthSmile` and lids `LidCheerful` (smile by default, the sanctuary map has VEFA); map temperature 20 degrees; `facial
# expression is "normal+blink"` last and in one call (no sweat, no unwritten frown); game paused for the capture; studio presentation
# mode; item and name labels hidden; `the other colonists are out of frame`.
# EVERY SCENE starts with `the animals are removed from the sanctuary "<place>"` (acts once, before the wolves are spawned).
# THE WOLVES: Ember = `an adult animal of kind "Wolf_Red" named "Ember" is spawned at (x, z)`, `has gender female`, `is given coat 0`
# (coat A), re-spawned in every scenario (each Scenario reloads the save). Coat indexes: -1 plain, 0 A, 1 B, 2 C. No wolf wears
# clothes (no apparel of the mod is staged). Each wolf is held mid-action by a forced job then `I let N ticks pass`, then paused.
#
# ---------------------------------------------------------------------------------------------------------------------------------
#   1. redwolf-1-bridge-fog
#               a. river-bridge, 7h, weather "Fog", `I let 60 ticks pass` after the set-up (+1 game hour of story: dawn).
#               b. DECOR: `TorchLamp` lit at (138, 125) and (131, 123); `PlantPot` at (139, 122) and (138, 126) each with `Plant_Daylily` fully grown;
#          `Stool` at (141, 126); `Plant_YellowTallGrass` at (132, 126), (133, 122), (141, 122); all removed after the scene. Fog and
#          lit torches give two warm pools of light.
#               c. LIVING: Ember (coat 0, female) ON the bridge, facing east; the river and the bamboo edge behind.
#               d. NELIM at (141, 124) facing west, `carries the item "Meat_Muffalo"`, smile, body turned half away (non-threatening).
#               e. ACTION: `"Ember" stands at (131, 124)` then `"Ember" is forced to walk to (137, 124)`, `I let 45 ticks pass`: Ember is caught
#          mid-stride, legs apart as in a walk, head toward Nelim. Instant: she just stepped onto the planks; next she
#          will stop or flee. Pause the game after the ticks.
#               f. COMPOSITION: WIDE, `I frame the rectangle from (129, 120) to (145, 129)` (16 cells across, so the wolf is 30 px at 268 px). Ember at the left third on the planks, Nelim at the right third, torch posts
#          in the foreground, river in fog behind, low light from the east.
#               g. SUBJECT: Nelim offers meat to a shy red wolf coming across the bridge. The image alone says: wolf, wary approach, an offer.
#               j. MOD: the red-russet wolf, the only warm colour in a grey-blue fog scene, readable at 268 px.
#  SUBTITLE: "At dawn a shy red wolf comes across the bridge."
#
#   2. redwolf-2-the-offer
#               a. statue-garden, 9h, weather "Clear", 2 game hours after scene 1 (hour set to 9, `I let 60 ticks pass`).
#               b. DECOR: `Meat_Muffalo` on the ground at (156, 97) (Nelim `puts down what it carries at (156, 97)`); `Brazier` unlit at (152, 97);
#          `Stool` at (151, 102); `Plant_Daylily` fully grown at (157, 101), (158, 97), (154, 95); `PlantPot_Bonsai` at (153, 96);
#          `TorchLamp` lit at (150, 100); the garden's statues stay (validated place). Removed after the scene.
#               c. LIVING: Ember seen from the FRONT (she walks south, towards the camera). One animal.
#               d. NELIM at (153, 100) facing east, smile, hands empty (she has just set the meat down), body half turned away.
#               e. ACTION: `"Ember" stands at (156, 103)`, `"Ember" is forced to walk to (156, 98)`, `I let 40 ticks pass`: Ember is mid-step towards the
#          meat. Instant: just before, Nelim put the meat down and stepped back; just after, Ember sniffs it.
#               f. COMPOSITION: TIGHT, `I frame the rectangle from (151, 94) to (160, 104)`: Ember large in the front third looking at the camera,
#          meat in front of her, Nelim in the back left, statue behind, morning light from the left.
#               g. SUBJECT: trust being built; the image says Nelim offered meat and the wolf comes for it.
#               j. MOD: the wolf's face and russet coat fill a third of the frame.
#  SUBTITLE: "Meat on the ground, a few careful steps closer."
#
#   3. redwolf-3-four-coats
#               a. bare-clearing (zoom 6), 12h, weather "Clear", `I let 60 ticks pass` (noon, 3 game hours after scene 2).
#               b. DECOR: `TorchLamp` unlit at (190, 149) and (203, 155); `PlantPot` with `Plant_Daylily` fully grown at (190, 153) and (203, 148);
#          `Plant_Daylily` fully grown at (192, 157), (196, 158), (200, 157); `Stool` at (201, 153); `Plant_YellowTallGrass` at (195, 152),
#          (197, 152), (199, 151) as bedding; `Brazier` unlit at (193, 148); the clearing's own flower border and bare soil behind.
#               c. LIVING: FOUR wolves, one of each coat: Ember (coat 0, `Wolf_Red`), "Sable" (coat -1, plain), "Rowan" (coat 1, B), "Flint"
#          (coat 2, C), all `an adult animal of kind "Wolf_Red" named "<name>" is spawned at (x, z)` at (194, 152), (196, 150), (198, 153),
#          (200, 150), genders alternated. Ember and Sable face south (toward the camera), Rowan faces east, Flint faces west.
#               d. NELIM at (203, 152) facing west, smile, `carries the item "Meat_Muffalo"`.
#               e. ACTION: Flint `lies at (198, 153) facing west` (asleep in the sun); Rowan `is forced to walk to (199, 151)` towards the bedding;
#          Ember and Sable `stand` looking at Nelim. `I let 30 ticks pass`. Instant: Nelim has just broken the meat in two and held a piece
#          out; the wolves turn to her.
#               f. COMPOSITION: MEDIUM-WIDE, `I frame the rectangle from (189, 145) to (206, 159)`: group left of centre, Nelim at the right edge,
#          wolves in two rows, noon light.
#               g. SUBJECT: the four coats of the red wolf together, with Nelim sharing meat. Image says: same animal, four coats.
#               j. MOD: four russet-to-pale wolves in a row, each coat distinguishable at 268 px.
#  SUBTITLE: "The red wolf comes in four coats."
#
#   4. redwolf-4-under-the-torii
#               a. cloister (178, 128), 15h, weather "Clear", `I let 60 ticks pass` (afternoon, 3 game hours after scene 3).
#               b. DECOR: the cloister's own torii, komainu and wall lanterns stay; `TorchLamp` lit at (176, 125) and (181, 125) at the first pillars;
#          `PlantPot_Bonsai` at (173, 126); `Stool` at (183, 127); `Plant_Daylily` fully grown at (175, 123), (180, 123), (182, 129).
#          Removed after the scene.
#               c. LIVING: Ember (coat 0), one animal, seen from the side (profile) next to Nelim.
#               d. NELIM at (176, 125), smile, looking down at the wolf, hands empty.
#               e. ACTION: `"Nelim" is forced to walk to (178, 128)`, `"Ember" follows "Nelim" within 1 cells`, `I let 50 ticks pass`: both caught
#          mid-step, the wolf at her knee. Instant: the first steps through the gate; next, into the cloister.
#               f. COMPOSITION: WIDE, zoom 4.5 on the entry, the two small figures in the lower right third, the torii and lanterns as depth,
#          afternoon sun from the west.
#               g. SUBJECT: the wolf now follows her home. Image says: a woman and her wolf come back through the gate.
#               j. MOD: the russet wolf against the grey stone and dark wood, readable at 268 px.
#  SUBTITLE: "By afternoon she follows Nelim home."
#
#   5. redwolf-5-family
#               a. flower-garden (validated 2026-11-06), 18h, weather "Clear", `I let 60 ticks pass` (dusk, 3 game hours after scene 4).
#               b. DECOR: `TorchLamp` lit at (150, 108) and (158, 108); `Brazier` lit at (148, 110) at the
#          left of the frame; `PlantPot` at (152, 106) and (160, 106) with `Plant_Daylily` fully grown; `Plant_Daylily` fully grown at (151, 104), (155, 104), (159, 104), (163, 108);
#          `Plant_YellowTallGrass` at (153, 111), (155, 112), (157, 111) as a bed under the wolves; `Stool` at (149, 112); the garden's own flowers fill the soil.
#               c. LIVING: THREE animals: Ember (mother, coat 0, `lies at (155, 110) facing south`, toward the camera), "Bram" (`an adult animal of kind
#          "Wolf_Timber" named "Bram"`, gender male, `lies at (158, 111) facing west`), "Pip" (`an animal of kind "Wolf_Red" named "Pip" is
#          spawned at (156, 107) at life stage 0`, coat 1, `stands at (156, 107) facing south`, in the foreground). The puppy faces the camera.
#               d. NELIM at (147, 110) facing east, smile, hands empty, watching.
#               e. ACTION: Ember and Bram have just lain down; Pip has just looked up at Nelim: `"Pip" is forced to walk to` one cell towards
#          her, `I let 20 ticks pass`. Instant: just before, the pup ran in; just after, it curls up beside its mother.
#               f. COMPOSITION: MEDIUM, `I frame the rectangle from (146, 103) to (163, 116)`; Pip low in the foreground, the adults behind, warm light
#          from the right at dusk, flowers in the foreground.
#               g. SUBJECT: the red wolf and the timber wolf rest with a pup between them: the two crossing mods. The wolves' two coats and the pup
#          say the red wolf mixes with the timber wolf.
#               j. MOD: a red puppy beside a timber wolf and a red wolf, readable at 268 px (three animals, three tones).
#  SUBTITLE: "At dusk she lies down with the timber wolf and their pup."
#
#   6. redwolf-6-info-card (interface window, set aside from the scoring, no subtitle): the information card of the red wolf on
#  `exhibition-zone`, 12h; the card shows body size 0.68, cold down to -25. The window is cropped to its frame with ffmpeg
#  (5 px of background each side, height whole); `Crop-SettingsShot.ps1` is for the settings window only.
#
# INCLUDED ANIMALS (rule 5): Wolf_Red: plain coat in scene 3 (Sable); coat A in scenes 1, 2, 3, 4, 5 (Ember); coat B in scenes 3 and
# 5 (Rowan, Pip); coat C in scene 3 (Flint); puppy in scene 5 (Pip); seen from the front in scenes 2, 3, 5.
# SERIES (k): one story, five hours, one outfit; plans: wide (1, 4), tight (2), medium-wide (3), medium (5); opening scene 1 sets the
# bridge and dawn, closing scene 5 the dusk; rhythm advances (shy, approach, trust, home, family).
# RISKS: cells of scenes 3 to 5 and the decor cells are read on the empty photos of the places at rate-gallery; a step that fails on
# a non-standable cell moves the cell; a forced walk of 40 to 50 ticks may carry Ember past the frame (shorten); fog darkens scene 1
# (the two lit torches answer it); Pickle `I let N ticks pass` uses `Nelim's Pickle Tools: I let N ticks pass` (240 s delay).
@requires:nelim.pickletools.colonistrace
@requires:nelim.sanctuarybacklot
Feature: Red wolf gallery

  Scenario: redwolf-1-bridge-fog
    Given I set the hour to 7
    And I set the weather to "Fog"
    And Nelim's Pickle Tools: the colonists are sent to the map corner
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "river-bridge"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 60 ticks pass
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Pickle Tools: a female adult animal of kind "Wolf_Red" named "Ember" is spawned at (131, 124)
    And Nelim's Pickle Tools: the animal "Ember" is given coat 0
    And Nelim's Pickle Tools: the animal "Ember" stands at (131, 124) facing East
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (138, 125)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (138, 125) is lit
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (131, 123)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (131, 123) is lit
    And Nelim's Pickle Tools: I place the decor "PlantPot" at (139, 122)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (139, 122) fully grown
    And Nelim's Pickle Tools: I place the decor "PlantPot" at (138, 126)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (138, 126) fully grown
    And Nelim's Pickle Tools: I place the decor "Stool" at (141, 126)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (132, 126)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (133, 122)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (141, 122)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (64, 130, 138)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" stands at (141, 124) facing West
    And Nelim's Pickle Tools: "Nelim" carries the item "Meat_Muffalo"
    And Nelim's Pickle Tools: I frame the rectangle from (129, 120) to (145, 129)
    And Nelim's Pickle Tools: "Ember" is forced to walk to (137, 124)
    And Nelim's Pickle Tools: I let 45 ticks pass
    And Nelim's Pickle Tools: time is paused for the capture
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Nelim's Pickle Tools: the map is shown alone for a capture
    When I take a screenshot "redwolf-1-bridge-fog"
    And Nelim's Pickle Tools: the interface is shown again
    And Nelim's Pickle Tools: the decor is removed

  Scenario: redwolf-2-the-offer
    Given I set the hour to 9
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the colonists are sent to the map corner
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "statue-garden"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 60 ticks pass
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Pickle Tools: a female adult animal of kind "Wolf_Red" named "Ember" is spawned at (156, 103)
    And Nelim's Pickle Tools: the animal "Ember" is given coat 0
    And Nelim's Pickle Tools: the animal "Ember" stands at (156, 103) facing South
    And Nelim's Pickle Tools: I place the decor "Meat_Muffalo" at (156, 97)
    And Nelim's Pickle Tools: I place the decor "Brazier" at (152, 97)
    And Nelim's Pickle Tools: I place the decor "Stool" at (151, 102)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (157, 101) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (158, 97) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (154, 95) fully grown
    And Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" at (153, 96)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (150, 100)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (150, 100) is lit
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (64, 130, 138)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" stands at (153, 100) facing East
    And Nelim's Pickle Tools: I frame the rectangle from (151, 94) to (160, 104)
    And Nelim's Pickle Tools: "Ember" is forced to walk to (156, 98)
    And Nelim's Pickle Tools: I let 40 ticks pass
    And Nelim's Pickle Tools: time is paused for the capture
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Nelim's Pickle Tools: the map is shown alone for a capture
    When I take a screenshot "redwolf-2-the-offer"
    And Nelim's Pickle Tools: the interface is shown again
    And Nelim's Pickle Tools: the decor is removed

  Scenario: redwolf-3-four-coats
    Given I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the colonists are sent to the map corner
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "bare-clearing"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 60 ticks pass
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Pickle Tools: a female adult animal of kind "Wolf_Red" named "Ember" is spawned at (194, 152)
    And Nelim's Pickle Tools: the animal "Ember" is given coat 0
    And Nelim's Pickle Tools: a male adult animal of kind "Wolf_Red" named "Sable" is spawned at (196, 150)
    And Nelim's Pickle Tools: the animal "Sable" is given coat -1
    And Nelim's Pickle Tools: a male adult animal of kind "Wolf_Red" named "Rowan" is spawned at (198, 153)
    And Nelim's Pickle Tools: the animal "Rowan" is given coat 1
    And Nelim's Pickle Tools: a female adult animal of kind "Wolf_Red" named "Flint" is spawned at (200, 150)
    And Nelim's Pickle Tools: the animal "Flint" is given coat 2
    And Nelim's Pickle Tools: the animal "Ember" stands at (194, 152) facing South
    And Nelim's Pickle Tools: the animal "Sable" stands at (196, 150) facing South
    And Nelim's Pickle Tools: the animal "Rowan" stands at (198, 153) facing East
    And Nelim's Pickle Tools: the animal "Flint" lies at (198, 153) facing West
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (190, 149)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (203, 155)
    And Nelim's Pickle Tools: I place the decor "PlantPot" at (190, 153)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (190, 153) fully grown
    And Nelim's Pickle Tools: I place the decor "PlantPot" at (203, 148)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (203, 148) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (192, 157) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (196, 158) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (200, 157) fully grown
    And Nelim's Pickle Tools: I place the decor "Stool" at (201, 153)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (195, 152)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (197, 152)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (199, 151)
    And Nelim's Pickle Tools: I place the decor "Brazier" at (193, 148)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (64, 130, 138)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" stands at (203, 152) facing West
    And Nelim's Pickle Tools: "Nelim" carries the item "Meat_Muffalo"
    And Nelim's Pickle Tools: I frame the rectangle from (189, 145) to (206, 159)
    And Nelim's Pickle Tools: "Rowan" is forced to walk to (199, 151)
    And Nelim's Pickle Tools: I let 30 ticks pass
    And Nelim's Pickle Tools: time is paused for the capture
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Nelim's Pickle Tools: the map is shown alone for a capture
    When I take a screenshot "redwolf-3-four-coats"
    And Nelim's Pickle Tools: the interface is shown again
    And Nelim's Pickle Tools: the decor is removed

  Scenario: redwolf-4-under-the-torii
    Given I set the hour to 15
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the colonists are sent to the map corner
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "cloister"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 60 ticks pass
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Pickle Tools: a female adult animal of kind "Wolf_Red" named "Ember" is spawned at (176, 124)
    And Nelim's Pickle Tools: the animal "Ember" is given coat 0
    And Nelim's Pickle Tools: the animal "Ember" stands at (176, 124) facing East
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (176, 125)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (176, 125) is lit
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (181, 125)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (181, 125) is lit
    And Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" at (173, 126)
    And Nelim's Pickle Tools: I place the decor "Stool" at (183, 127)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (175, 123) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (180, 123) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (182, 129) fully grown
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (64, 130, 138)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 125) facing East
    And Nelim's Pickle Tools: I frame the cell (178, 128) at zoom 4.5
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (178, 128)
    And Nelim's Pickle Tools: "Ember" follows "Nelim" within 1 cells
    And Nelim's Pickle Tools: I let 50 ticks pass
    And Nelim's Pickle Tools: time is paused for the capture
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Nelim's Pickle Tools: the map is shown alone for a capture
    When I take a screenshot "redwolf-4-under-the-torii"
    And Nelim's Pickle Tools: the interface is shown again
    And Nelim's Pickle Tools: the decor is removed

  Scenario: redwolf-5-family
    Given I set the hour to 18
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the colonists are sent to the map corner
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "flower-garden"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 60 ticks pass
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Pickle Tools: a female adult animal of kind "Wolf_Red" named "Ember" is spawned at (155, 110)
    And Nelim's Pickle Tools: the animal "Ember" is given coat 0
    And Nelim's Pickle Tools: a male adult animal of kind "Wolf_Timber" named "Bram" is spawned at (158, 111)
    And Nelim's Pickle Tools: a female animal of kind "Wolf_Red" named "Pip" is spawned at (156, 107) at life stage 0
    And Nelim's Pickle Tools: the animal "Pip" is given coat 1
    And Nelim's Pickle Tools: the animal "Ember" lies at (155, 110) facing South
    And Nelim's Pickle Tools: the animal "Bram" lies at (158, 111) facing West
    And Nelim's Pickle Tools: the animal "Pip" stands at (156, 107) facing South
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (150, 108)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (150, 108) is lit
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (158, 108)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (158, 108) is lit
    And Nelim's Pickle Tools: I place the decor "Brazier" at (148, 110)
    And Nelim's Pickle Tools: the decor "Brazier" at (148, 110) is lit
    And Nelim's Pickle Tools: I place the decor "PlantPot" at (152, 106)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (152, 106) fully grown
    And Nelim's Pickle Tools: I place the decor "PlantPot" at (160, 106)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (160, 106) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (151, 104) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (155, 104) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (159, 104) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (163, 108) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (153, 111)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (155, 112)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (157, 111)
    And Nelim's Pickle Tools: I place the decor "Stool" at (149, 112)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (64, 130, 138)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" stands at (147, 110) facing East
    And Nelim's Pickle Tools: I frame the rectangle from (146, 103) to (163, 116)
    And Nelim's Pickle Tools: "Pip" is forced to walk to (155, 107)
    And Nelim's Pickle Tools: I let 20 ticks pass
    And Nelim's Pickle Tools: time is paused for the capture
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Nelim's Pickle Tools: the map is shown alone for a capture
    When I take a screenshot "redwolf-5-family"
    And Nelim's Pickle Tools: the interface is shown again
    And Nelim's Pickle Tools: the decor is removed

