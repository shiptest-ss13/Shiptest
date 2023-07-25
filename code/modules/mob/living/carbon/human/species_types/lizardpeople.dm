/datum/species/lizard
	// Reptilian humanoids with scaled skin and tails.
	name = "\improper Sarathi"
	id = SPECIES_LIZARD
	default_color = "00FF00"
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,SCLERA,EMOTE_OVERLAY,MUTCOLORS_SECONDARY)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE
	mutant_bodyparts = list("tail_lizard", "face_markings", "frills", "horns", "spines", "body_markings", "legs")
	mutanttongue = /obj/item/organ/tongue/lizard
	mutant_organs = list(/obj/item/organ/tail/lizard)
	coldmod = 1.5
	heatmod = 0.67
	default_features = list("mcolor" = "0F0", "tail_lizard" = "Smooth", "face_markings" = "None", "horns" = "None", "frills" = "None", "spines" = "None", "body_markings" = "None", "legs" = "Normal Legs", "body_size" = "Normal")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/lizard
	skinned_type = /obj/item/stack/sheet/animalhide/lizard
	exotic_bloodtype = "L"
	disliked_food = GRAIN | DAIRY
	liked_food = GROSS | MEAT
	inert_mutation = FIREBREATH
	deathsound = 'sound/voice/lizard/deathsound.ogg'
	wings_icons = list("Dragon")
	species_language_holder = /datum/language_holder/lizard
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	mutanteyes = /obj/item/organ/eyes/lizard
	sclera_color = "#fffec4"
	blush_color = COLOR_BLUSH_TEAL

	species_chest = /obj/item/bodypart/chest/lizard
	species_head = /obj/item/bodypart/head/lizard
	species_l_arm = /obj/item/bodypart/l_arm/lizard
	species_r_arm = /obj/item/bodypart/r_arm/lizard
	species_l_leg = /obj/item/bodypart/leg/left/lizard
	species_r_leg = /obj/item/bodypart/leg/right/lizard

	species_robotic_chest = /obj/item/bodypart/chest/robot/lizard
	species_robotic_head = /obj/item/bodypart/head/robot/lizard
	species_robotic_l_arm = /obj/item/bodypart/l_arm/robot/surplus/lizard
	species_robotic_r_arm = /obj/item/bodypart/r_arm/robot/surplus/lizard
	species_robotic_l_leg = /obj/item/bodypart/leg/left/robot/surplus/lizard
	species_robotic_r_leg = /obj/item/bodypart/leg/right/robot/surplus/lizard

	robotic_eyes = /obj/item/organ/eyes/robotic/lizard

	// Lizards are coldblooded and can stand a greater temperature range than humans
	bodytemp_heat_damage_limit = HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT + 20 // This puts lizards 10 above lavaland max heat for ash lizards.
	bodytemp_cold_damage_limit = HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT - 10
	loreblurb = "The Sarathi are a cold-blooded reptilian species originating from the planet Kalixcis, where they evolved alongside the Elzuosa. Kalixcian culture places no importance on blood-bonds, and those from it tend to consider their family anyone they are sufficiently close to, and choose their own names."

	ass_image = 'icons/ass/asslizard.png'
	var/datum/action/innate/liz_lighter/internal_lighter

/datum/species/lizard/on_species_loss(mob/living/carbon/C)
	if(internal_lighter)
		internal_lighter.Remove(C)
	..()

/datum/species/lizard/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	if(ishuman(C))
		internal_lighter = new
		internal_lighter.Grant(C)

/datum/action/innate/liz_lighter
	name = "Ignite"
	desc = "(Requires you to drink welding fuel beforehand)"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "fire"
	icon_icon = 'icons/effects/fire.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/liz_lighter/Activate()
	var/mob/living/carbon/human/H = owner
	var/obj/item/lighter/liz/N = new(H)
	if(H.put_in_hands(N))
		to_chat(H, "<span class='notice'>You ignite a small flame in your mouth.</span>")
		H.reagents.del_reagent(/datum/reagent/fuel,4)
	else
		qdel(N)
		to_chat(H, "<span class='warning'>You don't have any free hands.</span>")

/datum/action/innate/liz_lighter/IsAvailable()
	if(..())
		var/mob/living/carbon/human/H = owner
		if(H.reagents && H.reagents.has_reagent(/datum/reagent/fuel,4))
			return TRUE
		return FALSE

/// Lizards are cold blooded and do not stabilize body temperature naturally
/datum/species/lizard/natural_bodytemperature_stabilization(datum/gas_mixture/environment, mob/living/carbon/human/H)
	return

/datum/species/lizard/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_lizard_name(gender)

	var/randname = lizard_name(gender)

	if(lastname)
		randname += " [lastname]"

	return randname

/*
Lizard subspecies: ASHWALKERS
*/
/datum/species/lizard/ashwalker
	name = "Ash Walker"
	id = SPECIES_ASHWALKER
	examine_limb_id = SPECIES_LIZARD
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS, NO_UNDERWEAR)
	inherent_traits = list(TRAIT_CHUNKYFINGERS,TRAIT_NOBREATH)
	species_language_holder = /datum/language_holder/lizard/ash
	digitigrade_customization = DIGITIGRADE_FORCED

//WS Edit Start - Kobold
//Ashwalker subspecies: KOBOLD
/datum/species/lizard/ashwalker/kobold
	name = "Kobold"
	id = SPECIES_KOBOLD
	examine_limb_id = SPECIES_LIZARD
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS, NO_UNDERWEAR)
	inherent_traits = list(TRAIT_CHUNKYFINGERS,TRAIT_NOBREATH)
	species_language_holder = /datum/language_holder/lizard/ash

/datum/species/lizard/ashwalker/kobold/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..() //call everything from species/on_species_gain()
	C.dna.add_mutation(DWARFISM)
//WS Edit End - Kobold
