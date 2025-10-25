//Copy-pasted kepori stuff
/datum/species/vox
	name = "\improper Vox"
	id = SPECIES_VOX
	default_color = "6060FF"
	species_age_max = 280
	species_traits = list(HAS_BONE, HAS_FLESH)
	mutant_bodyparts = list("vox_head_quills", "vox_neck_quills")
	default_features = list("mcolor" = "0F0", "wings" = "None", "vox_head_quills" = "None", "vox_neck_quills" = "None")
	meat = /obj/item/food/meat/slab/chicken
	disliked_food = GRAIN
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	loreblurb = "Vox are a big bird-like species with quills, much larger and much more long-lasting than other species. Sadly, not much else is known."
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	species_clothing_path = 'icons/mob/clothing/species/vox.dmi'
	species_eye_path = 'icons/mob/species/vox/vox_parts.dmi'
	punchdamagelow = 6
	punchdamagehigh = 12
	mutanttongue = /obj/item/organ/tongue/vox
	species_language_holder = /datum/language_holder/vox

	bodytemp_heat_divisor = VOX_BODYTEMP_HEAT_DIVISOR
	bodytemp_cold_divisor = VOX_BODYTEMP_COLD_DIVISOR
	bodytemp_autorecovery_min = VOX_BODYTEMP_AUTORECOVERY_MIN

	max_temp_comfortable = HUMAN_BODYTEMP_NORMAL + 10
	min_temp_comfortable = HUMAN_BODYTEMP_NORMAL - 20

	bodytemp_heat_damage_limit = HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT + 10
	bodytemp_cold_damage_limit = HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT - 20

	bodytype = BODYTYPE_VOX

	custom_overlay_icon = 'icons/mob/species/vox/vox_overlays.dmi'
	damage_overlay_type = "vox"

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/vox,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/vox,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/vox,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/vox,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/vox,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/vox,
	)

	species_robotic_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/vox,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/vox,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/surplus/vox,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/surplus/vox,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/surplus/vox,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/surplus/vox,
	)

	var/datum/action/innate/tail_hold/tail_action

	var/static/list/allergy_reactions = list(
		"Your beak itches.",
		"Your stomach churns.",
		"Your tail flicks on its own.",
		"Your quills feel heavy.",
		"Your lungs struggle to fill."
		)

	var/static/list/allergic_to = typecacheof(
		list(
			/datum/reagent/medicine/ephedrine,
			/datum/reagent/medicine/atropine,
			/datum/reagent/medicine/epinephrine,
			/datum/reagent/medicine/mannitol,
			/datum/reagent/medicine/antihol,
			/datum/reagent/medicine/stimulants,
			/datum/reagent/medicine/inaprovaline
		)
	)

/datum/species/vox/New()
	. = ..()
	// This is in new because "[HEAD_LAYER]" etc. is NOT a constant compile-time value. For some reason.
	// Why not just use HEAD_LAYER? Well, because HEAD_LAYER is a number, and if you try to use numbers as indexes,
	// BYOND will try to make it an ordered list. So, we have to use a string. This is annoying, but it's the only way to do it smoothly.
	offset_clothing = list(
		"[SUIT_STORE_LAYER]" = list(
							"[NORTH]" = list("x" = 8, "y" = 0),
							"[EAST]" = list("x" = 8, "y" = 0),
							"[SOUTH]" = list("x" = 8, "y" = 0),
							"[WEST]" = list("x" =  -8, "y" = 0)
							),
		"[EARS_LAYER]" = list(
							"[NORTH]" = list("x" = 8, "y" = 0),
							"[EAST]" = list("x" = 8, "y" = 0),
							"[SOUTH]" = list("x" = 8, "y" = 0),
							"[WEST]" = list("x" =  -8, "y" = 0)
							),
	)

/datum/species/vox/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_vox_name()
	return vox_name()

/datum/species/vox/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	C.base_pixel_x -= 9
	C.pixel_x = C.base_pixel_x
	C.update_hands_on_rotate()

	tail_action = new
	tail_action.Grant(C)

/datum/species/vox/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	C.base_pixel_x += 9
	C.pixel_x = C.base_pixel_x
	C.stop_updating_hands()

	if(tail_action)
		QDEL_NULL(tail_action)

/datum/species/vox/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(allergic_to[chem.type]) //Is_type_in_typecache is BAD.
		H.reagents.add_reagent(/datum/reagent/toxin/histamine, chem.metabolization_rate * 3)
		if(prob(5))
			to_chat(H, span_danger("[pick(allergy_reactions)]"))
		else if(prob(5))
			H.emote("clack")
		return FALSE //Its a bit TOO mean to have the chems not work at all.
	return ..()

/datum/species/vox/get_item_offsets_for_dir(dir, hand)
	//LEFT/RIGHT
	if(dir & NORTH)
		return list(list("x" = 9, "y" = 0), list("x" = 9, "y" = 0))
	if(dir & SOUTH)
		return list(list("x" = 10, "y" = -1), list("x" = 8, "y" = -1))
	if(dir & EAST)
		return list(list("x" = 18, "y" = 2), list("x" = 21, "y" = -1))
	if(dir & WEST)
		return list(list("x" = -5, "y" = -1), list("x" = -1, "y" = 2))

/datum/action/innate/tail_hold
	name = "Tail Hold"
	desc = "Store an item in your tail's grip."
	button_icon_state = "tail_hold"
	var/obj/item/held_item
	var/mutable_appearance/held_item_overlay

	var/static/list/offsets = list(\
		"north" = list("x" = -11, "y" = 3),
		"east" = list("x" = -15, "y" = 0),
		"south" = list("x" = -10, "y" = 0),
		"west" = list("x" = 30, "y" = 0)
	)

/datum/action/innate/tail_hold/Destroy()
	if(held_item)
		held_item.forceMove(get_turf(owner))
		held_item = null

	handle_sprite_magic()
	UnregisterSignal(owner, COMSIG_PARENT_EXAMINE)
	return ..()

/datum/action/innate/tail_hold/Grant(mob/M)
	. = ..()
	RegisterSignal(owner, COMSIG_ATOM_DIR_CHANGE, PROC_REF(handle_sprite_magic), override = TRUE)

/datum/action/innate/tail_hold/Trigger()
	var/mob/living/carbon/human/H = owner
	if(held_item)
		if(!H.put_in_hands(held_item))
			held_item.forceMove(get_turf(owner))
		held_item = null
		handle_sprite_magic()
		UnregisterSignal(owner, COMSIG_PARENT_EXAMINE)

	else
		var/obj/item/I = H.get_active_held_item()
		if(I && I.w_class <= WEIGHT_CLASS_SMALL)
			if(H.temporarilyRemoveItemFromInventory(I, FALSE, FALSE))
				held_item = I
				to_chat(H,span_notice("You move \the [I] into your tail's grip."))
				RegisterSignal(owner, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
				handle_sprite_magic(force = TRUE)
				return

		to_chat(H, span_warning("You are unable to hold that item in your tail!"))

/datum/action/innate/tail_hold/proc/on_examine(datum/source, mob/user, list/examine_list)
	var/mob/living/carbon/human/H = owner
	if(held_item)
		examine_list += span_notice("[capitalize(H.p_they())] [H.p_are()] holding \a [held_item] in [H.p_their()] tail.")

/datum/action/innate/tail_hold/proc/handle_sprite_magic(mob/M, olddir, newdir, force = FALSE)
	if(!held_item)
		if(held_item_overlay)
			owner.cut_overlay(held_item_overlay)
			held_item_overlay = null
		return

	if(olddir == newdir && !force)
		return

	newdir ||= owner.dir

	newdir = normalize_dir_to_cardinals(newdir)

	owner.cut_overlay(held_item_overlay)
	var/dirtext = dir2text(newdir)
	var/icon_file = held_item.lefthand_file

	switch(newdir)
		if(EAST, SOUTH)
			icon_file = held_item.lefthand_file
		if(WEST, NORTH)
			icon_file = held_item.righthand_file

	var/mutable_appearance/new_overlay = mutable_appearance(icon_file, held_item.item_state, HANDS_LAYER)

	new_overlay = center_image(new_overlay, held_item.inhand_x_dimension, held_item.inhand_y_dimension)

	new_overlay.pixel_x = offsets[dirtext]["x"]
	new_overlay.pixel_y = offsets[dirtext]["y"]

	held_item_overlay = new_overlay
	owner.add_overlay(new_overlay)
