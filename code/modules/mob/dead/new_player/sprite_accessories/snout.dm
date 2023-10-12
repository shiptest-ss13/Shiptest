/datum/sprite_accessory/snouts
	key = "snout"
	generic = "Snout"
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/lizard_snouts.dmi'
	var/use_muzzled_sprites = TRUE
	recommended_species = list(SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_LIZARD, SPECIES_REPTILE)
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/snouts/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if((H.wear_mask && (H.wear_mask.flags_inv & HIDEFACE)) || (H.head && (H.head.flags_inv & HIDEFACE)) || !HD)
		return TRUE
	return FALSE

/datum/sprite_accessory/snouts/none
	name = "None"
	icon_state = "none"
	use_muzzled_sprites = FALSE
	factual = FALSE

//shiptest lizard face markings, not for reptiles as the resprite changes the face
/datum/sprite_accessory/snouts/sarathi
	icon = 'icons/mob/species/lizard/markings.dmi'
	body_zone = BODY_ZONE_HEAD
	color_src = MUTCOLORS_SECONDARY
	synthetic_icon_state = "none"
	recommended_species = list(SPECIES_LIZARD)

/datum/sprite_accessory/snouts/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/snouts/jaw
	name = "Jaw"
	icon_state = "jaw"

/datum/sprite_accessory/snouts/top
	name = "Top Stripe"
	icon_state = "top"

/datum/sprite_accessory/snouts/eye
	name = "Alligator Skink"
	icon_state = "eye"

// legacy snouts, for the reptile legacy sprite or whatever the hell people use it for

/datum/sprite_accessory/snouts/lizard
	recommended_species = list(SPECIES_LIZARD, SPECIES_MAMMAL, SPECIES_REPTILE, SPECIES_ASHWALKER)

/datum/sprite_accessory/snouts/lizard/sharp
	name = "Sharp"
	icon_state = "sharp"

/datum/sprite_accessory/snouts/lizard/round
	name = "Round"
	icon_state = "round"

/datum/sprite_accessory/snouts/lizard/sharplight
	name = "Sharp + Light"
	icon_state = "sharplight"

/datum/sprite_accessory/snouts/lizard/roundlight
	name = "Round + Light"
	icon_state = "roundlight"

// SR/bubber snouts

/datum/sprite_accessory/snouts/mammal
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/snouts.dmi'
	color_src = USE_MATRIXED_COLORS
	recommended_species = list(SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_HUMANOID)

/datum/sprite_accessory/snouts/mammal/vulpkanin
	recommended_species = list(SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_VULP, SPECIES_HUMANOID)

/datum/sprite_accessory/snouts/mammal/tajaran
	recommended_species = list(SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_TAJARAN, SPECIES_HUMANOID)

/datum/sprite_accessory/snouts/mammal/akula
	recommended_species = list(SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_AKULA, SPECIES_AQUATIC, SPECIES_HUMANOID)

/datum/sprite_accessory/snouts/mammal/bird
	name = "Beak"
	icon_state = "bird"

/datum/sprite_accessory/snouts/mammal/bigbeak
	name = "Big Beak"
	icon_state = "bigbeak"

/datum/sprite_accessory/snouts/mammal/bug
	name = "Bug"
	icon_state = "bug"
	color_src = USE_ONE_COLOR
	extra2 = TRUE
	extra2_color_src = MUTCOLORS3

/datum/sprite_accessory/snouts/mammal/elephant
	name = "Elephant"
	icon_state = "elephant"
	extra = TRUE
	extra_color_src = MUTCOLORS3

/datum/sprite_accessory/snouts/mammal/husky
	name = "Husky"
	icon_state = "husky"

/datum/sprite_accessory/snouts/mammal/rhino
	name = "Horn"
	icon_state = "rhino"
	extra = TRUE
	extra = MUTCOLORS3

/datum/sprite_accessory/snouts/mammal/rodent
	name = "Rodent"
	icon_state = "rodent"

/datum/sprite_accessory/snouts/mammal/vulpkanin/lcanid
	name = "Mammal, Long"
	icon_state = "lcanid"

/datum/sprite_accessory/snouts/mammal/lcanidalt
	name = "Mammal, Long ALT"
	icon_state = "lcanidalt"

/datum/sprite_accessory/snouts/mammal/vulpkanin/lcanidstriped
	name = "Mammal, Long, Striped"
	icon_state = "lcanidstripe"

/datum/sprite_accessory/snouts/mammal/lcanidstripedalt
	name = "Mammal, Long, Striped ALT"
	icon_state = "lcanidstripealt"

/datum/sprite_accessory/snouts/mammal/tajaran/scanid
	name = "Mammal, Short"
	icon_state = "scanid"

/datum/sprite_accessory/snouts/mammal/tajaran/scanidalt
	name = "Mammal, Short ALT"
	icon_state = "scanidalt"

/datum/sprite_accessory/snouts/mammal/tajaran/scanidalt2
	name = "Mammal, Short ALT 2"
	icon_state = "scanidalt2"

/datum/sprite_accessory/snouts/mammal/tajaran/scanidalt3
	name = "Mammal, Short ALT 3"
	icon_state = "scanidalt3"

/datum/sprite_accessory/snouts/mammal/tajaran/normal
	name = "Tajaran, normal"
	icon_state = "ntajaran"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/snouts/mammal/wolf
	name = "Mammal, Thick"
	icon_state = "wolf"

/datum/sprite_accessory/snouts/mammal/wolfalt
	name = "Mammal, Thick ALT"
	icon_state = "wolfalt"

/datum/sprite_accessory/snouts/mammal/otie
	name = "Otie"
	icon_state = "otie"

/datum/sprite_accessory/snouts/mammal/otiesmile
	name = "Otie Smile"
	icon_state = "otiesmile"

/*/datum/sprite_accessory/snouts/mammal/round
	name = "Mammal Round"
	icon_state = "round"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/snouts/mammal/roundlight
	name = "Mammal Round + Light"
	icon_state = "roundlight"
	color_src = USE_ONE_COLOR*/

/datum/sprite_accessory/snouts/mammal/pede
	name = "Scolipede"
	icon_state = "pede"

/datum/sprite_accessory/snouts/mammal/sergal
	name = "Sergal"
	icon_state = "sergal"

/datum/sprite_accessory/snouts/mammal/akula/shark
	name = "Shark"
	icon_state = "shark"

/datum/sprite_accessory/snouts/mammal/akula/hshark
	name = "hShark"
	icon_state = "hshark"

/datum/sprite_accessory/snouts/mammal/akula/hshark_eyes
	name = "hShark and eyes"
	icon_state = "hshark_eyes"

/*/datum/sprite_accessory/snouts/mammal/sharp
	name = "Mammal Sharp"
	icon_state = "sharp"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/snouts/mammal/sharplight
	name = "Mammal Sharp + Light"
	icon_state = "sharplight"
	color_src = USE_ONE_COLOR*/

/datum/sprite_accessory/snouts/mammal/toucan
	name = "Toucan"
	icon_state = "toucan"

/datum/sprite_accessory/snouts/mammal/redpanda
	name = "WahCoon"
	icon_state = "wah"

/datum/sprite_accessory/snouts/mammal/redpandaalt
	name = "WahCoon ALT"
	icon_state = "wahalt"

/******************************************
**************** Snouts *******************
*************but higher up*****************/

/datum/sprite_accessory/snouts/mammal/fbird
	name = "Beak (Top)"
	icon_state = "fbird"

/datum/sprite_accessory/snouts/mammal/fbigbeak
	name = "Big Beak (Top)"
	icon_state = "fbigbeak"

/datum/sprite_accessory/snouts/mammal/fbug
	name = "Bug (Top)"
	icon_state = "fbug"
	color_src = USE_ONE_COLOR
	extra2 = TRUE
	extra2_color_src = MUTCOLORS3

/datum/sprite_accessory/snouts/mammal/felephant
	name = "Elephant (Top)"
	icon_state = "felephant"
	extra = TRUE
	extra_color_src = MUTCOLORS3

/datum/sprite_accessory/snouts/mammal/frhino
	name = "Horn (Top)"
	icon_state = "frhino"
	extra = TRUE
	extra = MUTCOLORS3

/datum/sprite_accessory/snouts/mammal/fhusky
	name = "Husky (Top)"
	icon_state = "fhusky"

/datum/sprite_accessory/snouts/mammal/vulpkanin/flcanid
	name = "Mammal, Long (Top)"
	icon_state = "flcanid"

/datum/sprite_accessory/snouts/mammal/flcanidalt
	name = "Mammal, Long ALT (Top)"
	icon_state = "flcanidalt"

/datum/sprite_accessory/snouts/mammal/vulpkanin/flcanidstriped
	name = "Mammal, Long, Striped (Top)"
	icon_state = "flcanidstripe"

/datum/sprite_accessory/snouts/mammal/flcanidstripedalt
	name = "Mammal, Long, Striped ALT (Top)"
	icon_state = "flcanidstripealt"

/datum/sprite_accessory/snouts/mammal/tajaran/fscanid
	name = "Mammal, Short (Top)"
	icon_state = "fscanid"

/datum/sprite_accessory/snouts/mammal/tajaran/fscanidalt
	name = "Mammal, Short ALT (Top)"
	icon_state = "fscanidalt"

/datum/sprite_accessory/snouts/mammal/tajaran/fscanidalt2
	name = "Mammal, Short ALT 2 (Top)"
	icon_state = "fscanidalt2"

/datum/sprite_accessory/snouts/mammal/tajaran/fscanidalt3
	name = "Mammal, Short ALT 3 (Top)"
	icon_state = "fscanidalt3"

/datum/sprite_accessory/snouts/mammal/fwolf
	name = "Mammal, Thick (Top)"
	icon_state = "fwolf"

/datum/sprite_accessory/snouts/mammal/fwolfalt
	name = "Mammal, Thick ALT (Top)"
	icon_state = "fwolfalt"

/datum/sprite_accessory/snouts/mammal/fotie
	name = "Otie (Top)"
	icon_state = "fotie"

/datum/sprite_accessory/snouts/mammal/fotiesmile
	name = "Otie Smile (Top)"
	icon_state = "fotiesmile"

/datum/sprite_accessory/snouts/mammal/frodent
	name = "Rodent (Top)"
	icon_state = "frodent"

/*/datum/sprite_accessory/snouts/mammal/fround
	name = "Mammal Round (Top)"
	icon_state = "fround"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/snouts/mammal/froundlight
	name = "Mammal Round + Light (Top)"
	icon_state = "froundlight"
	color_src = USE_ONE_COLOR*/

/datum/sprite_accessory/snouts/mammal/fpede
	name = "Scolipede (Top)"
	icon_state = "fpede"

/datum/sprite_accessory/snouts/mammal/fsergal
	name = "Sergal (Top)"
	icon_state = "fsergal"

/datum/sprite_accessory/snouts/mammal/fshark
	name = "Shark (Top)"
	icon_state = "fshark"

/*/datum/sprite_accessory/snouts/mammal/fsharp
	name = "Mammal Sharp (Top)"
	icon_state = "fsharp"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/snouts/mammal/fsharplight
	name = "Mammal Sharp + Light (Top)"
	icon_state = "fsharplight"
	color_src = USE_ONE_COLOR*/

/datum/sprite_accessory/snouts/mammal/ftoucan
	name = "Toucan (Top)"
	icon_state = "ftoucan"

/datum/sprite_accessory/snouts/mammal/fredpanda
	name = "WahCoon (Top)"
	icon_state = "fwah"

/datum/sprite_accessory/snouts/mammal/skulldog
	name = "Skulldog"
	icon_state = "skulldog"
	extra = TRUE
	//extra_color_src = MATRIXED

/datum/sprite_accessory/snouts/mammal/hanubus
	name = "Anubus"
	icon_state = "hanubus"

/datum/sprite_accessory/snouts/mammal/hpanda
	name = "Panda"
	icon_state = "hpanda"

/datum/sprite_accessory/snouts/mammal/hjackal
	name = "Jackal"
	icon_state = "hjackal"

/datum/sprite_accessory/snouts/mammal/hspots
	name = "Hyena"
	icon_state = "hspots"

/datum/sprite_accessory/snouts/mammal/hhorse
	name = "Horse"
	icon_state = "hhorse"

/datum/sprite_accessory/snouts/mammal/hzebra
	name = "Zebra"
	icon_state = "hzebra"

/datum/sprite_accessory/snouts/mammal/sbeak
	name = "Corvid Beak"
	icon_state = "sbeak"
	extra = TRUE
	//extra_color_src = MATRIXED

/datum/sprite_accessory/snouts/mammal/akula/shark_light
	name = "Shark Light"
	icon_state = "sharkblubber"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/snouts/mammal/rat
	name = "Rat"
	icon_state = "rat"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/snouts/mammal/stubby
	name = "Stubby"
	icon_state = "stubby"
	color_src = USE_MATRIXED_COLORS
	use_muzzled_sprites = FALSE
