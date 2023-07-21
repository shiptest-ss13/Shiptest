/datum/species/kepori
	name = "\improper Kepori"
	id = SPECIES_KEPORI
	default_color = "6060FF"
	species_traits = list(MUTCOLORS, EYECOLOR, NO_UNDERWEAR, MUTCOLORS_SECONDARY)
	inherent_traits = list(TRAIT_SCOOPABLE)
	mutant_bodyparts = list("kepori_body_feathers", "kepori_tail_feathers", "kepori_feathers")
	default_features = list("mcolor" = "0F0", "wings" = "None", "kepori_feathers" = "Plain", "kepori_body_feathers" = "Plain", "kepori_tail_feathers" = "Fan", "body_size" = "Normal")
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/chicken
	disliked_food = GROSS | FRIED
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	loreblurb = "Kepori are a species covered in feathers vaguely reminiscent of earth’s extinct troodontidae. They’re small and sometimes seen as weak by other species due to their hollow bones but make up for that in speed and reflexes. Those found in space are commonly known as rollaways. They tend to woop when excited, scared, or for any other reason at all."
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	species_clothing_path = 'icons/mob/clothing/species/kepori.dmi'
	species_eye_path = 'icons/mob/kepori_parts.dmi'
	heatmod = 0.67
	coldmod = 1.5
	brutemod = 1.5
	burnmod = 1.5
	speedmod = -0.25
	bodytemp_normal = HUMAN_BODYTEMP_NORMAL + 30
	bodytemp_heat_damage_limit = HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT + 30
	bodytemp_cold_damage_limit = HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT + 30
	mutanttongue = /obj/item/organ/tongue/kepori
	species_language_holder = /datum/language_holder/kepori
	var/datum/action/innate/keptackle/keptackle
	/// # Inherit tackling variables #
	/// See: [/datum/component/tackler/var/stamina_cost]
	var/tackle_stam_cost = 10
	/// See: [/datum/component/tackler/var/base_knockdown]
	var/base_knockdown = 0.2 SECONDS
	/// See: [/datum/component/tackler/var/range]
	var/tackle_range = 8
	/// See: [/datum/component/tackler/var/min_distance]
	var/min_distance = 1
	/// See: [/datum/component/tackler/var/speed]
	var/tackle_speed = 2
	/// See: [/datum/component/tackler/var/skill_mod]
	var/skill_mod = 2

	bodytype = BODYTYPE_KEPORI

	species_chest = /obj/item/bodypart/chest/kepori
	species_head = /obj/item/bodypart/head/kepori
	species_l_arm = /obj/item/bodypart/l_arm/kepori
	species_r_arm = /obj/item/bodypart/r_arm/kepori
	species_l_leg = /obj/item/bodypart/leg/left/kepori
	species_r_leg = /obj/item/bodypart/leg/right/kepori

	species_robotic_chest = /obj/item/bodypart/chest/robot/kepori
	species_robotic_head = /obj/item/bodypart/head/robot/kepori
	species_robotic_l_arm = /obj/item/bodypart/l_arm/robot/surplus/kepori
	species_robotic_r_arm = /obj/item/bodypart/r_arm/robot/surplus/kepori
	species_robotic_l_leg = /obj/item/bodypart/leg/left/robot/surplus/kepori
	species_robotic_r_leg = /obj/item/bodypart/leg/right/robot/surplus/kepori

/datum/species/kepori/New()
	. = ..()
	// This is in new because "[HEAD_LAYER]" etc. is NOT a constant compile-time value. For some reason.
	// Why not just use HEAD_LAYER? Well, because HEAD_LAYER is a number, and if you try to use numbers as indexes,
	// BYOND will try to make it an ordered list. So, we have to use a string. This is annoying, but it's the only way to do it smoothly.
	offset_clothing = list(
		"[HEAD_LAYER]" = list("[NORTH]" = list("x" = 0, "y" = -4), "[EAST]" = list("x" = 4, "y" = -4), "[SOUTH]" = list("x" = 0, "y" = -4), "[WEST]" = list("x" =  -4, "y" = -4)),
		"[GLASSES_LAYER]" = list("[NORTH]" = list("x" = 0, "y" = -4), "[EAST]" = list("x" = 4, "y" = -4), "[SOUTH]" = list("x" = 0, "y" = -4), "[WEST]" = list("x" =  -4, "y" = -4)),
		"[FACEMASK_LAYER]" = list("[NORTH]" = list("x" = 0, "y" = -5), "[EAST]" = list("x" = 4, "y" = -5), "[SOUTH]" = list("x" = 0, "y" = -5), "[WEST]" = list("x" =  -4, "y" = -5)),
	)

/datum/species/kepori/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_kepori_name()
	return kepori_name()

/datum/species/kepori/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self, swap)
	if(..()) //If it already fits, then it's fine.
		return TRUE
	if(slot == ITEM_SLOT_MASK)
		if(H.wear_mask && !swap)
			return FALSE
		if(I.w_class > WEIGHT_CLASS_SMALL)
			return FALSE
		if(!H.get_bodypart(BODY_ZONE_HEAD))
			return FALSE
		return equip_delay_self_check(I, H, bypass_equip_delay_self)

/datum/species/kepori/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	..()
	if(ishuman(C))
		keptackle = new
		keptackle.Grant(C)

/datum/species/kepori/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	if(keptackle)
		keptackle.Remove(C)
	qdel(C.GetComponent(/datum/component/tackler))
	..()


/datum/action/innate/keptackle
	name = "Pounce"
	desc = "Ready yourself to pounce."
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "tackle"
	icon_icon = 'icons/obj/clothing/gloves.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/keptackle/Activate()
	var/mob/living/carbon/human/H = owner
	var/datum/species/kepori/kep = H.dna.species
	if(H.GetComponent(/datum/component/tackler))
		qdel(H.GetComponent(/datum/component/tackler))
		to_chat(H, "<span class='notice'>You relax, no longer ready to pounce.</span>")
		return
	H.AddComponent(/datum/component/tackler, stamina_cost= kep.tackle_stam_cost, base_knockdown= kep.base_knockdown, range= kep.tackle_range, speed= kep.tackle_speed, skill_mod= kep.skill_mod, min_distance= kep.min_distance)
	H.visible_message("<span class='notice'>[H] gets ready to pounce!</span>", \
		"<span class='notice'>You ready yourself to pounce!</span>", null, COMBAT_MESSAGE_RANGE)
