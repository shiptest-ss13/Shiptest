/datum/species/lizard
	// Reptilian humanoids with scaled skin and tails.
	name = "\improper Sarathi"
	id = SPECIES_LIZARD
	default_color = "00FF00"
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,SCLERA,EMOTE_OVERLAY)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE
	mutant_bodyparts = list("tail_lizard", "snout", "spines", "horns", "frills", "body_markings", "legs")
	mutantbrain = /obj/item/organ/brain/lizard
	mutanteyes = /obj/item/organ/eyes/lizard
	mutantears = /obj/item/organ/ears/lizard
	mutanttongue = /obj/item/organ/tongue/lizard
	mutantlungs = /obj/item/organ/lungs/lizard
	mutantheart = /obj/item/organ/heart/lizard
	mutantstomach = /obj/item/organ/stomach/lizard
	mutantliver = /obj/item/organ/liver/lizard
	mutant_organs = list(/obj/item/organ/tail/lizard, /obj/item/organ/lizard_second_heart)
	coldmod = 1.5
	heatmod = 0.67
	default_features = list("mcolor" = "0F0", "tail_lizard" = "Smooth", "snout" = "Round", "horns" = "None", "frills" = "None", "spines" = "None", "body_markings" = "None", "legs" = "Normal Legs", "body_size" = "Normal")
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
	sclera_color = "fffec4"

	species_chest = /obj/item/bodypart/chest/lizard
	species_head = /obj/item/bodypart/head/lizard
	species_l_arm = /obj/item/bodypart/l_arm/lizard
	species_r_arm = /obj/item/bodypart/r_arm/lizard
	species_l_leg = /obj/item/bodypart/leg/left/lizard
	species_r_leg = /obj/item/bodypart/leg/right/lizard
	// Lizards are coldblooded and can stand a greater temperature range than humans
	bodytemp_heat_damage_limit = HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT + 20 // This puts lizards 10 above lavaland max heat for ash lizards.
	bodytemp_cold_damage_limit = HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT - 10
	loreblurb = "The Sarathi are a cold-blooded reptilian species originating from the planet Kalixcis, where they evolved alongside the Elzuosa. Kalixcian culture places no importance on blood-bonds, and those from it tend to consider their family anyone they are sufficiently close to, and choose their own names."

	ass_image = 'icons/ass/asslizard.png'
	var/datum/action/innate/liz_lighter/internal_lighter

/datum/species/lizard/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	C.mob_surgery_speed_mod -= 0.15
	RegisterSignal(C, COMSIG_CARBON_GAIN_ORGAN, .proc/on_gained_organ)
	RegisterSignal(C, COMSIG_CARBON_LOSE_ORGAN, .proc/on_removed_organ)
	if(ishuman(C))
		internal_lighter = new
		internal_lighter.Grant(C)

/datum/species/lizard/on_species_loss(mob/living/carbon/C)
	C.mob_surgery_speed_mod += 0.15
	UnregisterSignal(C, COMSIG_CARBON_GAIN_ORGAN)
	UnregisterSignal(C, COMSIG_CARBON_LOSE_ORGAN)
	C.remove_client_colour(/datum/client_colour/monochrome/lizard)
	if(internal_lighter)
		internal_lighter.Remove(C)
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

/datum/species/lizard/on_tail_lost(mob/living/carbon/human/tail_owner, obj/item/organ/tail/lost_tail, on_species_init)
	. = ..()
	if(!.)
		return
	if(lost_tail.type in mutant_organs)
		RegisterSignal(tail_owner, COMSIG_MOVABLE_MOVED, .proc/on_move)

/datum/species/lizard/on_tail_regain(mob/living/carbon/human/tail_owner, obj/item/organ/tail/found_tail, on_species_init)
	. = ..()
	if(!.)
		return
	if(found_tail.type in mutant_organs)
		UnregisterSignal(tail_owner, COMSIG_MOVABLE_MOVED)

/datum/species/lizard/clear_tail_moodlets(mob/living/carbon/human/former_tail_owner)
	. = ..()
	UnregisterSignal(former_tail_owner, COMSIG_MOVABLE_MOVED)

/datum/species/lizard/proc/on_gained_organ(mob/living/receiver, obj/item/organ/tongue/organ)
	SIGNAL_HANDLER

	if(!istype(organ) || !(organ.taste_sensitivity <= LIZARD_TASTE_SENSITIVITY || organ.organ_flags))
		return
	receiver.remove_client_colour(/datum/client_colour/monochrome/lizard)

/datum/species/lizard/proc/on_removed_organ(mob/living/unceiver, obj/item/organ/tongue/organ)
	SIGNAL_HANDLER

	if(!istype(organ) || organ.taste_sensitivity > LIZARD_TASTE_SENSITIVITY)
		return
	unceiver.add_client_colour(/datum/client_colour/monochrome/lizard)

/datum/species/lizard/proc/on_move(mob/living/mover, atom/old_loc, movement_dir, forced, list/old_locs)
	SIGNAL_HANDLER

	if(!movement_dir || !prob(1))
		return
	mover.Knockdown(1 SECONDS)
	to_chat(mover, span_warning("You trip from your imbalance!"))

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
