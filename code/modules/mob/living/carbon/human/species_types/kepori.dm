/datum/species/kepori
	name = "\improper Kepori"
	id = SPECIES_KEPORI
	default_color = "6060FF"
	species_traits = list(SCLERA, MUTCOLORS, MUTCOLORS_SECONDARY)
	inherent_traits = list(TRAIT_SCOOPABLE)
	mutant_bodyparts = list("kepori_body_feathers", "kepori_head_feathers", "kepori_tail_feathers", "kepori_feathers")
	default_features = list("mcolor" = "0F0", "wings" = "None", "kepori_feathers" = "None", "kepori_head_feathers" = "None",  "kepori_body_feathers" = "None", "kepori_tail_feathers" = "None")
	meat = /obj/item/food/meat/slab/chicken
	disliked_food = FRIED | GROSS | CLOTH
	liked_food = MEAT | GORE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	loreblurb = "Kepori are a species covered in feathers vaguely reminiscent of earth’s extinct troodontidae. They’re small and sometimes seen as weak by other species due to their hollow bones but make up for that in speed and reflexes. They tend to woop when excited, scared, or for any other reason at all."
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	species_clothing_path = 'icons/mob/clothing/species/kepori.dmi'
	species_eye_path = 'icons/mob/species/kepori/kepori_eyes.dmi'
	heatmod = 0.67
	coldmod = 1.5
	// brutemod = 1.5
	// burnmod = 1.5
	speedmod = -0.10

	bodytemp_heat_damage_limit = HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT + 35
	bodytemp_cold_damage_limit = HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT + 3

	max_temp_comfortable = HUMAN_BODYTEMP_NORMAL + 40
	min_temp_comfortable = HUMAN_BODYTEMP_NORMAL - 3

	bodytemp_autorecovery_divisor = HUMAN_BODYTEMP_AUTORECOVERY_DIVISOR - 4

	fire_overlay = "generic"

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

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/kepori,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/kepori,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/kepori,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/kepori,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/kepori,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/kepori,
	)

	species_robotic_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/kepori,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/kepori,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/surplus/kepori,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/surplus/kepori,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/surplus/kepori,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/surplus/kepori,
	)

	robotic_eyes = /obj/item/organ/eyes/robotic/kepori

	//I'm not emotionally prepared to spend ten more hours splicing overlays together
	damage_overlay_type = ""

/datum/species/kepori/New()
	. = ..()
	// This is in new because "[HEAD_LAYER]" etc. is NOT a constant compile-time value. For some reason.
	// Why not just use HEAD_LAYER? Well, because HEAD_LAYER is a number, and if you try to use numbers as indexes,
	// BYOND will try to make it an ordered list. So, we have to use a string. This is annoying, but it's the only way to do it smoothly.
	offset_clothing = list(
		"[HEAD_LAYER]" = list(
							"[NORTH]" = list("x" = 8, "y" = -3),
							"[EAST]" = list("x" = 19, "y" = -3), //ISSUE: The head sprites seem to be cut off when given an offset this large, combined with kepori offset
							"[SOUTH]" = list("x" = 8, "y" = -3),
							"[WEST]" = list("x" =  -3, "y" = -3)
							),
		"[GLASSES_LAYER]" = list(
							"[NORTH]" = list("x" = 8, "y" = -3),
							"[EAST]" = list("x" = 19, "y" = -3),
							"[SOUTH]" = list("x" = 8, "y" = -3),
							"[WEST]" = list("x" =  -3, "y" = -3)
							),
		"[FACEMASK_LAYER]" = list(
							"[NORTH]" = list("x" = 8, "y" = -3),
							"[EAST]" = list("x" = 19, "y" = -3),
							"[SOUTH]" = list("x" = 8, "y" = -3),
							"[WEST]" = list("x" =  -3, "y" = -3)
							),
		"[BELT_LAYER]" = list(
							"[NORTH]" = list("x" = 8, "y" = -1),
							"[EAST]" = list("x" = 8, "y" = -1),
							"[SOUTH]" = list("x" = 8, "y" = -1),
							"[WEST]" = list("x" =  9, "y" = -1)
							),
		"[EARS_LAYER]" = list(
							"[NORTH]" = list("x" = 8, "y" = -3),
							"[EAST]" = list("x" = 19, "y" = -3),
							"[SOUTH]" = list("x" = 8, "y" = -3),
							"[WEST]" = list("x" =  -3, "y" = -3)
							),
		"[SUIT_STORE_LAYER]" = list(
							"[NORTH]" = list("x" = 8, "y" = -1),
							"[EAST]" = list("x" = 8, "y" = -1),
							"[SOUTH]" = list("x" = 8, "y" = -1),
							"[WEST]" = list("x" =  -8, "y" = -1)
							),
	)

// First list is left hand, second list is right hand. This is used for inhand offsets.
/datum/species/kepori/get_item_offsets_for_dir(dir, hand)
	//LEFT/RIGHT
	if(dir & NORTH)
		return list(list("x" = 9, "y" = -1), list("x" = 7, "y" = -1))
	if(dir & SOUTH)
		return list(list("x" = 7, "y" = -1), list("x" = 9, "y" = -1))
	if(dir & EAST)
		return list(list("x" = 18, "y" = -2), list("x" = 21, "y" = -2)) //("x" = 18, "y" = 2), list("x" = 21, "y" = -1))
	if(dir & WEST)
		return list(list("x" = -4, "y" = -2), list("x" = -1, "y" = -2)) //("x" = -5, "y" = -1), list("x" = -1, "y" = 2))

/datum/species/kepori/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_kepori_name()
	return kepori_name()

/datum/species/kepori/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self, swap)
	if(..()) //If it already fits, then it's fine.
		return TRUE
	if(slot != ITEM_SLOT_MASK)
		return FALSE
	//Blocks all items that are equippable to other slots. (block anything with a flag that ISN'T item_slot_mask)
	if(I.slot_flags & ~ITEM_SLOT_KEPORI_BEAK)
		return FALSE
	if(H.wear_mask && !swap)
		return FALSE
	if(I.w_class > WEIGHT_CLASS_SMALL)
		return FALSE
	//ya ain't got no biters to put it in sir
	if(!H.get_bodypart(BODY_ZONE_HEAD))
		return FALSE
	return H.equip_delay_self_check(I, bypass_equip_delay_self)

/datum/species/kepori/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()

	C.base_pixel_x -= 8
	C.pixel_x = C.base_pixel_x
	C.update_hands_on_rotate()

	if(ishuman(C))
		keptackle = new
		keptackle.Grant(C)

/datum/species/kepori/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()

	C.base_pixel_x += 8
	C.pixel_x = C.base_pixel_x
	C.stop_updating_hands()

	if(keptackle)
		keptackle.Remove(C)

	qdel(C.GetComponent(/datum/component/tackler))

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
		to_chat(H, span_notice("You relax, no longer ready to pounce."))
		return
	H.AddComponent(/datum/component/tackler, stamina_cost= kep.tackle_stam_cost, base_knockdown= kep.base_knockdown, range= kep.tackle_range, speed= kep.tackle_speed, skill_mod= kep.skill_mod, min_distance= kep.min_distance)
	H.visible_message(span_notice("[H] gets ready to pounce!"), \
		span_notice("You ready yourself to pounce!"), null, COMBAT_MESSAGE_RANGE)
