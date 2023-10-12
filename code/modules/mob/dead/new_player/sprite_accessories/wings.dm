// When adding or making new wing sprites, try to use matrixed colours!
// You can find a color palette to work with in the wings icon file as 'colorpalette matrixcolors'
// Check some of the wings that make use of them for examples on how to make it look decent
/datum/sprite_accessory/wings
	icon = 'icons/mob/clothing/wings.dmi'
	generic = "Wings"
	key = "wings"
	color_src = USE_ONE_COLOR
	recommended_species = list(SPECIES_HUMAN, SPECIES_SYNTHHUMAN, SPECIES_LIZARD, SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_SYNTHLIZ)
	organ_type = /obj/item/organ/wings
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER, BODY_ADJ_LAYER)

/datum/sprite_accessory/wings/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.wear_suit && H.try_hide_mutant_parts)
		return TRUE
	return FALSE

/datum/sprite_accessory/wings/none
	name = "None"
	icon_state = "none"
	factual = FALSE

//Human/Misc wings

/datum/sprite_accessory/wings/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	locked = TRUE
	color_src = USE_ONE_COLOR
	default_color = "FFF"

/datum/sprite_accessory/wings_open/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	color_src = USE_ONE_COLOR
	default_color = "FFF"

//Sarathi wings

/datum/sprite_accessory/wings/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings_open/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/megamoth
	name = "Megamoth"
	icon_state = "megamoth"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE
	color_src = USE_ONE_COLOR
	default_color = "FFF"

/datum/sprite_accessory/wings_open/megamoth
	name = "Megamoth"
	icon_state = "megamoth"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	color_src = USE_ONE_COLOR
	default_color = "FFF"

/datum/sprite_accessory/wings/mothra
	name = "Mothra"
	icon_state = "mothra"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE
	color_src = USE_ONE_COLOR
	default_color = "FFF"

/datum/sprite_accessory/wings_open/mothra
	name = "Mothra"
	icon_state = "mothra"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	color_src = USE_ONE_COLOR
	default_color = "FFF"

//Robotic species wings

/datum/sprite_accessory/wings/robotic
	name = "Robotic"
	icon_state = "robotic"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/robotic
	name = "Robotic"
	icon_state = "robotic"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32

/datum/sprite_accessory/wings/moth
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/moth_wings.dmi' //TODO: transfer shiptest exlucisve wings to moudlar file
	default_color = "FFF"
	recommended_species = list(SPECIES_MOTH, SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_INSECT) //Mammals too, I guess. They wont get flight though, see the wing organs for that logic
	organ_type = /obj/item/organ/wings/moth
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/wings/moth/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/wings/moth/monarch
	name = "Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/wings/moth/luna
	name = "Luna"
	icon_state = "luna"

/datum/sprite_accessory/wings/moth/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/wings/moth/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/wings/moth/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/wings/moth/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/wings/moth/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/wings/moth/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/wings/moth/punished
	name = "Burnt Off"
	icon_state = "burnt"
	locked = TRUE

/datum/sprite_accessory/wings/moth/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/wings/moth/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/wings/moth/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/wings/moth/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/wings/moth/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/wings/moth/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/wings/moth/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/wings/moth/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/wings/moth/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/wings/moth/brown
	name = "Brown"
	icon_state = "brown"

/datum/sprite_accessory/wings/moth/feathery
	name = "Feathery"
	icon_state = "feathery"

/datum/sprite_accessory/wings/moth/rosy
	name = "Rosy"
	icon_state = "rosy"

/datum/sprite_accessory/wings/moth/plasmafire
	name = "Plasmafire"
	icon_state = "plasmafire"

//Wings for various species

/datum/sprite_accessory/wings/mammal
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/wings.dmi'
	default_color = DEFAULT_PRIMARY
	recommended_species = list(SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_LIZARD, SPECIES_INSECT, SPECIES_SYNTHLIZ)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/wings/mammal/bat //TODO: port my sprite from hyper for this one
	name = "Bat"
	icon_state = "bat"

/datum/sprite_accessory/wings/mammal/fairy
	name = "Fairy"
	icon_state = "fairy"

/datum/sprite_accessory/wings/mammal/feathery
	name = "Feathery"
	icon_state = "feathery"

/datum/sprite_accessory/wings/mammal/featheryalt1
	name = "Feathery (alt 1)"
	icon_state = "featheryalt1"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/featheryalt2
	name = "Feathery (alt 2)"
	icon_state = "featheryalt2"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/bee
	name = "Bee"
	icon_state = "bee"

/datum/sprite_accessory/wings/mammal/succubus
	name = "Succubus"
	icon_state = "succubus"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/dragon_synth
	name = "Dragon (synthetic alt)"
	icon_state = "dragonsynth"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/dragon_alt1
	name = "Dragon (alt 1)"
	icon_state = "dragonalt1"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/dragon_alt2
	name = "Dragon (alt 2)"
	icon_state = "dragonalt2"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/harpywings
	name = "Harpy"
	icon_state = "harpy"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/harpywingsalt1
	name = "Harpy (alt 1)"
	icon_state = "harpyalt"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/harpywingsalt2
	name = "Harpy (Bat)"
	icon_state = "harpybat"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/top/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if((H.wear_suit && (H.try_hide_mutant_parts || (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(H.dna.species, H.wear_suit.species_exception)))))
		return TRUE
	return FALSE

/datum/sprite_accessory/wings/mammal/top/harpywings_top
	name = "Harpy (Top)"
	icon_state = "harpy_top"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/top/harpywingsalt1_top
	name = "Harpy (alt 1) (Top)"
	icon_state = "harpyalt_top"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/top/harpywingsalt2_top
	name = "Harpy (Bat) (Top)"
	icon_state = "harpybat_top"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/low_wings
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/wings.dmi'
	name = "Low wings"
	icon_state = "low"

/datum/sprite_accessory/wings/low_wings_top
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/wings.dmi'
	name = "Low wings (Top)"
	icon_state = "low_top"
