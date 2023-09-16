//Copy-pasted kepori stuff
/datum/species/vox
	name = "\improper Vox"
	id = SPECIES_VOX
	default_color = "6060FF"
	species_age_min = 17
	species_age_max = 280
	species_traits = list(EYECOLOR, NO_UNDERWEAR)
	mutant_bodyparts = list("vox_head_quills", "vox_neck_quills")
	default_features = list("mcolor" = "0F0", "wings" = "None", "vox_head_quills" = "None", "vox_neck_quills" = "None", "body_size" = "Normal")
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/chicken
	disliked_food = GRAIN
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	loreblurb = "Vox test"
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	species_clothing_path = 'icons/mob/clothing/species/vox.dmi'
	species_eye_path = 'icons/mob/vox_parts.dmi'
	punchdamagelow = 6
	punchdamagehigh = 12
	mutanttongue = /obj/item/organ/tongue/vox
	species_language_holder = /datum/language_holder/vox

	bodytemp_heat_divisor = VOX_BODYTEMP_HEAT_DIVISOR
	bodytemp_cold_divisor = VOX_BODYTEMP_COLD_DIVISOR
	bodytemp_autorecovery_min = VOX_BODYTEMP_AUTORECOVERY_MIN

	bodytype = BODYTYPE_VOX

	species_chest = /obj/item/bodypart/chest/vox
	species_head = /obj/item/bodypart/head/vox
	species_l_arm = /obj/item/bodypart/l_arm/vox
	species_r_arm = /obj/item/bodypart/r_arm/vox
	species_l_leg = /obj/item/bodypart/leg/left/vox
	species_r_leg = /obj/item/bodypart/leg/right/vox

	species_robotic_chest = /obj/item/bodypart/chest/robot/vox
	species_robotic_head = /obj/item/bodypart/head/robot/vox
	species_robotic_l_arm = /obj/item/bodypart/l_arm/robot/surplus/vox
	species_robotic_r_arm = /obj/item/bodypart/r_arm/robot/surplus/vox
	species_robotic_l_leg = /obj/item/bodypart/leg/left/robot/surplus/vox
	species_robotic_r_leg = /obj/item/bodypart/leg/right/robot/surplus/vox

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
			to_chat(H, "<span class='danger'>[pick(allergy_reactions)]</span>")
		else if(prob(5))
			H.emote("clack")
		return FALSE //Its a bit TOO mean to have the chems not work at all.
	return ..()

/datum/species/vox/get_item_offsets_for_dir(dir, hand)
	////LEFT/RIGHT
	switch(dir)
		if(SOUTH)
			return list(list("x" = 10, "y" = -1), list("x" = 8, "y" = -1))
		if(NORTH)
			return list(list("x" = 9, "y" = 0), list("x" = 9, "y" = 0))
		if(EAST)
			return list(list("x" = 18, "y" = 2), list("x" = 21, "y" = -1))
		if(WEST)
			return list(list("x" = -5, "y" = -1), list("x" = -1, "y" = 2))

/datum/action/innate/tail_hold
	name = "Tail Hold"
	desc = "Store an item in your tail's grip."
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
	RegisterSignal(owner, COMSIG_ATOM_DIR_CHANGE, .proc/handle_sprite_magic, override = TRUE)

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
				to_chat(H,"<span class='notice'>You move \the [I] into your tail's grip.</span>")
				RegisterSignal(owner, COMSIG_PARENT_EXAMINE, .proc/on_examine)
				handle_sprite_magic(force = TRUE)
				return

		to_chat(H, "<span class='warning'>You are unable to hold that item in your tail!</span>")

/datum/action/innate/tail_hold/proc/on_examine(datum/source, mob/user, list/examine_list)
	var/mob/living/carbon/human/H = owner
	if(held_item)
		examine_list += "<span class='notice'>[capitalize(H.p_they())] [H.p_are()] holding \a [held_item] in [H.p_their()] tail.</span>"

/datum/action/innate/tail_hold/proc/handle_sprite_magic(mob/M, olddir, newdir, force = FALSE)
	if(!held_item)
		if(held_item_overlay)
			owner.cut_overlay(held_item_overlay)
			held_item_overlay = null
		return
	if(olddir == newdir && !force)
		return

	newdir ||= owner.dir

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
