/datum/species/lizard
	// Reptilian humanoids with scaled skin and tails.
	name = "\improper Sarathi"
	id = SPECIES_SARATHI
	default_color = "00FF00"
	species_age_max = 175
	species_traits = list(MUTCOLORS, LIPS, EMOTE_OVERLAY, MUTCOLORS_SECONDARY)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE
	mutant_bodyparts = list("tail_lizard", "face_markings", "frills", "horns", "spines", "body_markings")
	coldmod = 1.5
	heatmod = 0.67
	default_features = list("mcolor" = "0F0", "tail_lizard" = "Smooth", "face_markings" = "None", "horns" = "None", "frills" = "None", "spines" = "None", "body_markings" = "None")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	skinned_type = /obj/item/stack/sheet/animalhide/lizard
	exotic_bloodtype = "L"
	disliked_food = GRAIN | DAIRY | CLOTH | GROSS
	liked_food = GORE | MEAT
	deathsound = 'sound/voice/lizard/deathsound.ogg'
	wings_icons = list("Dragon")
	species_language_holder = /datum/language_holder/lizard
	blush_color = COLOR_BLUSH_TEAL

	species_organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/lizard,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/lizard,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/lizard,
	)

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/lizard,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/lizard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/lizard,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/lizard,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/lizard/digitigrade,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/lizard/digitigrade,
	)

	prosthetic_style = /datum/sprite_accessory/body/prosthetic/sarathi

	// Sarathi are coldblooded and can stand a greater temperature range than humans
	bodytemp_heat_damage_limit = HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT + 30
	bodytemp_cold_damage_limit = HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT - 10
	max_temp_comfortable = HUMAN_BODYTEMP_NORMAL + 20
	min_temp_comfortable = HUMAN_BODYTEMP_NORMAL
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

/datum/species/lizard/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/fuel)
		return TRUE
	return ..()

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
		to_chat(H, span_notice("You ignite a small flame in your mouth."))
		var/obj/item/organ/stomach/belly = owner.getorganslot(ORGAN_SLOT_STOMACH)
		belly.reagents.remove_reagent(/datum/reagent/fuel,4)
	else
		qdel(N)
		to_chat(H, span_warning("You don't have any free hands."))

/datum/action/innate/liz_lighter/IsAvailable()
	if(..())
		var/obj/item/organ/stomach/belly = owner.getorganslot(ORGAN_SLOT_STOMACH)
		if(belly && belly.reagents.has_reagent(/datum/reagent/fuel, 4))
			return TRUE
		return FALSE

/// Lizards are cold blooded and do not stabilize body temperature naturally
/datum/species/lizard/natural_bodytemperature_stabilization(datum/gas_mixture/environment, mob/living/carbon/human/H)
	return 0

/datum/species/lizard/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_lizard_name(gender)

	var/randname = lizard_name(gender)

	if(lastname)
		randname += " [lastname]"

	return randname
