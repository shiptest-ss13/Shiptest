#define SPECIES_TESHARI "teshari"

//the fucking shit i do for friends
//if youre reading this piper, im so sorry.

/datum/species/teshari
	name = "\improper Tesari"
	id = SPECIES_TESHARI
	default_color = "6060FF"
	species_traits = list(MUTCOLORS, EYECOLOR, NO_UNDERWEAR)
	inherent_traits = list(TRAIT_SCOOPABLE)
	mutant_bodyparts = list("ears", "tail_lizard") //im lazy
	default_features = list("mcolor" = "0F0", "wings" = "None", "ears" = "Plain", "tail_lizard" = "Plain", "body_size" = "Normal")
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/chicken
	disliked_food = GROSS | GRAIN
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	loreblurb = "Teshari, availi, who gives a shit, theyre the same thing. Allegedly, satan made them to tormet those in the 4th-9th layers of hell. Somehow escaped into space where neither god or devil can contain them. The Teceti government allegedly fends off waves of these things like the fucking emu war"
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	species_clothing_path = 'modular_zubbers/modules/species/horror_why_am_i_doing_this/icons/onmob_teshari.dmi'
	species_eye_path = 'modular_zubbers/modules/species/horror_why_am_i_doing_this/icons/bodyparts.dmi'
	heatmod = 0.67
	coldmod = 1.5
	brutemod = 1.5
	burnmod = 1.5
	speedmod = -0.25
	bodytemp_normal = HUMAN_BODYTEMP_NORMAL + 30
	bodytemp_heat_damage_limit = HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT + 30
	bodytemp_cold_damage_limit = HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT + 30
	species_language_holder = /datum/language_holder/kepori

	//unique_prosthesis = TRUE

	species_chest = /obj/item/bodypart/chest/teshari
	species_head = /obj/item/bodypart/head/teshari
	species_l_arm = /obj/item/bodypart/l_arm/teshari
	species_r_arm = /obj/item/bodypart/r_arm/teshari
	species_l_leg = /obj/item/bodypart/leg/left/teshari
	species_r_leg = /obj/item/bodypart/leg/right/teshari

/datum/species/teshari/New()
	. = ..()
	// This is in new because "[HEAD_LAYER]" etc. is NOT a constant compile-time value. For some reason.
	// Why not just use HEAD_LAYER? Well, because HEAD_LAYER is a number, and if you try to use numbers as indexes,
	// BYOND will try to make it an ordered list. So, we have to use a string. This is annoying, but it's the only way to do it smoothly.
	offset_clothing = list(
		"[BACK_LAYER]" = list("[NORTH]" = list("x" = 0, "y" = -5), "[EAST]" = list("x" = 4, "y" = -5), "[SOUTH]" = list("x" = 0, "y" = -5), "[WEST]" = list("x" =  -4, "y" = -5)))

/datum/species/kepori/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_teshari_name()

	var/randname = teshari_name()

	if(lastname)
		randname += " [lastname]"

	return randname



/proc/random_unique_teshari_name(attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(teshari_name())

		if(!findname(.))
			break

/proc/teshari_name()
	var/newname = ""

	for(var/i in 1 to rand(2, 3))
		newname += pick(list("chi", "chu", "ka", "ki", "kyo", "ko", "la", "li", "mi", "ni", "nu", "nyu", "se", "ri", "ro", "ru", "ryu", "sa", "si", "syo", "sus"))
	return capitalize(newname)



///ACCESSORIES GOD I HATE MYSELF

/datum/sprite_accessory/ears/teshari
	color_src = HAIR
	icon = 'modular_zubbers/modules/species/horror_why_am_i_doing_this/icons/bodyparts.dmi'

/datum/sprite_accessory/ears/teshari/regular
	name = "Teshari Regular"
	icon_state = "teshari_regular"

/datum/sprite_accessory/ears/teshari/feathers_bushy
	name = "Teshari Feathers Bushy"
	icon_state = "teshari_feathers_bushy"

/datum/sprite_accessory/ears/teshari/feathers_mohawk
	name = "Teshari Feathers Mohawk"
	icon_state = "teshari_feathers_mohawk"

/datum/sprite_accessory/ears/teshari/feathers_spiky
	name = "Teshari Feathers Spiky"
	icon_state = "teshari_feathers_spiky"

/datum/sprite_accessory/ears/teshari/feathers_pointy
	name = "Teshari Feathers Pointy"
	icon_state = "teshari_feathers_pointy"

/datum/sprite_accessory/ears/teshari/feathers_upright
	name = "Teshari Feathers Upright"
	icon_state = "teshari_feathers_upright"

/datum/sprite_accessory/ears/teshari/feathers_droopy
	name = "Teshari Feathers Droopy"
	icon_state = "teshari_feathers_droopy"

/datum/sprite_accessory/ears/teshari/feathers_longway
	name = "Teshari Feathers Longway"
	icon_state = "teshari_feathers_longway"

/datum/sprite_accessory/ears/teshari/feathers_ponytail
	name = "Teshari Feathers Ponytail"
	icon_state = "teshari_feathers_ponytail"

/datum/sprite_accessory/ears/teshari/feathers_mushroom
	name = "Teshari Feathers Mushroom"
	icon_state = "teshari_feathers_mushroom"
	//color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/teshari/feathers_backstrafe
	name = "Teshari Feathers Backstrafe"
	icon_state = "teshari_feathers_backstrafe"
	//color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/teshari/feathers_thinmohawk
	name = "Teshari Feathers Thin Mohawk"
	icon_state = "teshari_feathers_thinmohawk"
	//color_src = USE_ONE_COLOR

/datum/sprite_accessory/tails/lizard/teshari
	color_src = USE_ONE_COLOR // i hate these things why do i even bother
	default_color = DEFAULT_PRIMARY
	icon = 'modular_zubbers/modules/species/horror_why_am_i_doing_this/icons/bodyparts.dmi'

/datum/sprite_accessory/tails/lizard/teshari/default
	name = "Teshari (Default)"
	icon_state = "teshari_default"

/datum/sprite_accessory/tails/lizard/teshari/fluffy
	name = "Teshari (Fluffy)"
	icon_state = "teshari_fluffy"
/datum/sprite_accessory/tails/lizard/teshari/thin
	name = "Teshari (Thin)"
	icon_state = "teshari_thin"

