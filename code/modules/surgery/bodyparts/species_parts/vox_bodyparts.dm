/obj/item/bodypart/head/vox
	static_icon = 'icons/mob/species/vox/bodyparts.dmi'
	limb_id = SPECIES_VOX
	is_dimorphic = FALSE
	bodytype = BODYTYPE_VOX | BODYTYPE_ORGANIC
	should_draw_greyscale = FALSE
	draw_sclera = FALSE
	dmg_overlay_icon = 'icons/mob/species/vox/vox_overlays.dmi'

/obj/item/bodypart/chest/vox
	static_icon = 'icons/mob/species/vox/bodyparts.dmi'
	limb_id = SPECIES_VOX
	is_dimorphic = FALSE
	bodytype = BODYTYPE_VOX | BODYTYPE_ORGANIC
	acceptable_bodytype = BODYTYPE_VOX
	should_draw_greyscale = FALSE
	dmg_overlay_icon = 'icons/mob/species/vox/vox_overlays.dmi'

/obj/item/bodypart/l_arm/vox
	static_icon = 'icons/mob/species/vox/bodyparts.dmi'
	limb_id = SPECIES_VOX
	bodytype = BODYTYPE_VOX | BODYTYPE_ORGANIC
	should_draw_greyscale = FALSE
	dmg_overlay_icon = 'icons/mob/species/vox/vox_overlays.dmi'

/obj/item/bodypart/r_arm/vox
	static_icon = 'icons/mob/species/vox/bodyparts.dmi'
	limb_id = SPECIES_VOX
	bodytype = BODYTYPE_VOX | BODYTYPE_ORGANIC
	should_draw_greyscale = FALSE
	dmg_overlay_icon = 'icons/mob/species/vox/vox_overlays.dmi'

/obj/item/bodypart/leg/left/vox
	static_icon = 'icons/mob/species/vox/bodyparts.dmi'
	limb_id = SPECIES_VOX
	bodytype = BODYTYPE_VOX | BODYTYPE_ORGANIC
	should_draw_greyscale = FALSE
	dismemberable = FALSE //BIG MEATY THIGHS
	dmg_overlay_icon = 'icons/mob/species/vox/vox_overlays.dmi'

/obj/item/bodypart/leg/right/vox
	static_icon = 'icons/mob/species/vox/bodyparts.dmi'
	limb_id = SPECIES_VOX
	bodytype = BODYTYPE_VOX | BODYTYPE_ORGANIC
	should_draw_greyscale = FALSE
	dismemberable = FALSE
	dmg_overlay_icon = 'icons/mob/species/vox/vox_overlays.dmi'

/obj/item/bodypart/tail/vox
	static_icon = 'icons/mob/species/vox/bodyparts.dmi'
	limb_id = SPECIES_VOX
	bodytype = BODYTYPE_VOX | BODYTYPE_ORGANIC
	should_draw_greyscale = FALSE
	max_damage = 50
	max_stamina_damage = 50
	body_damage_coeff = 0.75
	body_weight = 12
	can_wag = FALSE
	can_thump = TRUE
	dismemberable = FALSE
	dmg_overlay_icon = 'icons/mob/species/vox/vox_overlays.dmi'
	bodypart_actions = list(/datum/action/innate/tail_hold)

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

/datum/action/innate/tail_hold/Remove(mob/M)
	if(held_item)
		held_item.forceMove(get_turf(owner))
		held_item = null

	handle_sprite_magic()
	UnregisterSignal(M, COMSIG_ATOM_EXAMINE)
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
		UnregisterSignal(owner, COMSIG_ATOM_EXAMINE)

	else
		var/obj/item/I = H.get_active_held_item()
		if(I && I.w_class <= WEIGHT_CLASS_SMALL)
			if(H.temporarilyRemoveItemFromInventory(I, FALSE, FALSE))
				held_item = I
				to_chat(H,span_notice("You move \the [I] into your tail's grip."))
				RegisterSignal(owner, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
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
