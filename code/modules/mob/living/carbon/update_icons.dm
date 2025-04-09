//IMPORTANT: Multiple animate() calls do not stack well, so try to do them all at once if you can.
/mob/living/carbon/update_transform()
	var/matrix/ntransform = matrix(transform) //aka transform.Copy()
	var/final_pixel_y = pixel_y
	var/final_dir = dir
	var/changed = 0
	if(lying_angle != lying_prev && rotate_on_lying)
		changed++
		ntransform.TurnTo(lying_prev , lying_angle)
		if(!lying_angle) //Lying to standing
			final_pixel_y = get_standard_pixel_y_offset()
		else //if(lying != 0)
			if(lying_prev == 0) //Standing to lying
				pixel_y = base_pixel_y + get_standard_pixel_y_offset()
				final_pixel_y = base_pixel_y + get_standard_pixel_y_offset(lying_angle)
				if(dir & (EAST|WEST)) //Facing east or west
					final_dir = pick(NORTH, SOUTH) //So you fall on your side rather than your face or ass
	if(resize != RESIZE_DEFAULT_SIZE)
		changed++
		ntransform.Scale(resize)
		resize = RESIZE_DEFAULT_SIZE

	if(changed)
		animate(src, transform = ntransform, time = (lying_prev == 0 || lying_angle == 0) ? 2 : 0, pixel_y = final_pixel_y, dir = final_dir, easing = (EASE_IN|EASE_OUT))
		setMovetype(movement_type & ~FLOATING)  // If we were without gravity, the bouncing animation got stopped, so we make sure we restart it in next life().

/mob/living/carbon
	var/list/overlays_standing[TOTAL_LAYERS]

/mob/living/carbon/proc/apply_overlay(cache_index)
	if((. = overlays_standing[cache_index]))
		add_overlay(.)

/mob/living/carbon/proc/remove_overlay(cache_index)
	var/I = overlays_standing[cache_index]
	if(I)
		cut_overlay(I)
		overlays_standing[cache_index] = null

/mob/living/carbon/regenerate_icons()
	if(notransform)
		return 1
	icon_render_keys = list()
	update_inv_hands()
	update_inv_handcuffed()
	update_inv_legcuffed()
	update_fire()
	update_body_parts()


/mob/living/carbon/update_inv_hands()
	if(layered_hands)
		special_update_hands(override = TRUE)
		return

	remove_overlay(HANDS_LAYER)
	if (handcuffed)
		drop_all_held_items()
		return

	var/list/hands = list()
	for(var/obj/item/I in held_items)
		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			I.screen_loc = ui_hand_position(get_held_index_of_item(I))
			client.screen += I
			if(observers && observers.len)
				for(var/M in observers)
					var/mob/dead/observe = M
					if(observe.client && observe.client.eye == src)
						observe.client.screen += I
					else
						observers -= observe
						if(!observers.len)
							observers = null
							break

		var/icon_file = I.lefthand_file
		if(get_held_index_of_item(I) % 2 == 0)
			icon_file = I.righthand_file

		hands += I.build_worn_icon(default_layer = HANDS_LAYER, default_icon_file = icon_file, isinhands = TRUE)

	overlays_standing[HANDS_LAYER] = hands
	apply_overlay(HANDS_LAYER)


/mob/living/carbon/update_fire(fire_icon = "Generic_mob_burning")
	remove_overlay(FIRE_LAYER)
	if(on_fire || islava(loc))
		var/mutable_appearance/new_fire_overlay = mutable_appearance('icons/mob/OnFire.dmi', fire_icon, -FIRE_LAYER)
		new_fire_overlay.appearance_flags = RESET_COLOR
		overlays_standing[FIRE_LAYER] = new_fire_overlay

	apply_overlay(FIRE_LAYER)

/mob/living/carbon/update_damage_overlays()

	remove_overlay(DAMAGE_LAYER)

	var/mutable_appearance/damage_overlay = mutable_appearance('icons/mob/dam_mob.dmi', "blank", -DAMAGE_LAYER)
	overlays_standing[DAMAGE_LAYER] = damage_overlay

	for(var/obj/item/bodypart/BP as anything in bodyparts)
		if(BP.dmg_overlay_type)
			if(BP.brutestate)
				var/image/brute_overlay = image(BP.dmg_overlay_icon, "[BP.dmg_overlay_type]_[BP.body_zone]_[BP.brutestate]0")
				if(BP.use_damage_color)
					brute_overlay.color = BP.damage_color
				damage_overlay.add_overlay(brute_overlay)
			if(BP.burnstate)
				var/image/burn_overlay = image(BP.dmg_overlay_icon, "[BP.dmg_overlay_type]_[BP.body_zone]_[BP.burnstate]0")
				damage_overlay.add_overlay(burn_overlay)

	apply_overlay(DAMAGE_LAYER)


/mob/living/carbon/update_inv_wear_mask()
	remove_overlay(FACEMASK_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //Decapitated
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1]
		inv.update_appearance()

	if(wear_mask)
		if(!(ITEM_SLOT_MASK in check_obscured_slots()))
			overlays_standing[FACEMASK_LAYER] = wear_mask.build_worn_icon(default_layer = FACEMASK_LAYER, default_icon_file = 'icons/mob/clothing/mask.dmi', mob_species = dna?.species)
		update_hud_wear_mask(wear_mask)

	apply_overlay(FACEMASK_LAYER)

/mob/living/carbon/update_inv_neck()
	remove_overlay(NECK_LAYER)

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_NECK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_NECK) + 1]
		inv.update_appearance()

	if(wear_neck)
		if(!(ITEM_SLOT_NECK in check_obscured_slots()))
			overlays_standing[NECK_LAYER] = wear_neck.build_worn_icon(default_layer = NECK_LAYER, default_icon_file = 'icons/mob/clothing/neck.dmi', mob_species = dna?.species)
		update_hud_neck(wear_neck)

	apply_overlay(NECK_LAYER)

/mob/living/carbon/update_inv_back()
	remove_overlay(BACK_LAYER)

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1]
		inv.update_appearance()

	if(back)
		overlays_standing[BACK_LAYER] = back.build_worn_icon(default_layer = BACK_LAYER, default_icon_file = 'icons/mob/clothing/back.dmi', mob_species = dna?.species)
		update_hud_back(back)

	apply_overlay(BACK_LAYER)

/mob/living/carbon/update_inv_head()
	remove_overlay(HEAD_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //Decapitated
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_HEAD) + 1]
		inv.update_appearance()

	if(head)
		overlays_standing[HEAD_LAYER] = head.build_worn_icon(default_layer = HEAD_LAYER, default_icon_file = 'icons/mob/clothing/head.dmi', mob_species = dna?.species)
		update_hud_head(head)

	apply_overlay(HEAD_LAYER)


/mob/living/carbon/update_inv_handcuffed()
	remove_overlay(HANDCUFF_LAYER)
	if(handcuffed)
		overlays_standing[HANDCUFF_LAYER] = mutable_appearance('icons/mob/mob.dmi', "handcuff1", -HANDCUFF_LAYER)
		apply_overlay(HANDCUFF_LAYER)


//mob HUD updates for items in our inventory

//update whether handcuffs appears on our hud.
/mob/living/carbon/proc/update_hud_handcuffed()
	if(hud_used)
		for(var/hand in hud_used.hand_slots)
			var/atom/movable/screen/inventory/hand/H = hud_used.hand_slots[hand]
			if(H)
				H.update_appearance()

//update whether our head item appears on our hud.
/mob/living/carbon/proc/update_hud_head(obj/item/I)
	return

//update whether our mask item appears on our hud.
/mob/living/carbon/proc/update_hud_wear_mask(obj/item/I)
	return

//update whether our neck item appears on our hud.
/mob/living/carbon/proc/update_hud_neck(obj/item/I)
	return

//update whether our back item appears on our hud.
/mob/living/carbon/proc/update_hud_back(obj/item/I)
	return


//Overlays for the worn overlay so you can overlay while you overlay
//eg: ammo counters, primed grenade flashing, etc.
//"icon_file" is used automatically for inhands etc. to make sure it gets the right inhand file
/obj/item/proc/worn_overlays(isinhands = FALSE, icon_file)
	SHOULD_CALL_PARENT(TRUE)
	RETURN_TYPE(/list)

	. = list()


/mob/living/carbon/update_body()
	update_body_parts()

/mob/living/carbon/proc/update_body_parts(update_limb_data)
	//Check the cache to see if it needs a new sprite
	update_damage_overlays()
	var/list/needs_update = list()
	var/limb_count_update = FALSE
	for(var/obj/item/bodypart/BP as anything in bodyparts)
		BP.update_limb(is_creating = update_limb_data) //Update limb actually doesn't do much, get_limb_icon is the cpu eater.
		var/old_key = icon_render_keys?[BP.body_zone]
		icon_render_keys[BP.body_zone] = (BP.is_husked) ? BP.generate_husk_key().Join() : BP.generate_icon_key().Join()
		if(!(icon_render_keys[BP.body_zone] == old_key))
			needs_update += BP


	var/list/missing_bodyparts = get_missing_limbs()
	if(((dna ? dna.species.max_bodypart_count : 6) - icon_render_keys.len) != missing_bodyparts.len)
		limb_count_update = TRUE
		for(var/X in missing_bodyparts)
			icon_render_keys -= X

	if(!needs_update.len && !limb_count_update)
		return

	//GENERATE NEW LIMBS
	var/list/new_limbs = list()
	for(var/obj/item/bodypart/BP as anything in bodyparts)
		if(BP in needs_update)
			var/bp_icon = BP.get_limb_icon()
			new_limbs += bp_icon
			limb_icon_cache[icon_render_keys[BP.body_zone]] = bp_icon
		else
			new_limbs += limb_icon_cache[icon_render_keys[BP.body_zone]]

	remove_overlay(BODYPARTS_LAYER)

	if(new_limbs.len)
		overlays_standing[BODYPARTS_LAYER] = new_limbs

	apply_overlay(BODYPARTS_LAYER)


/////////////////////////
// Limb Icon Cache 2.0 //
/////////////////////////
//Updated by Kapu#1178
//TG variant port by MrSamu99#8996
/**
 * Called from update_body_parts() these procs handle the limb icon cache.
 * the limb icon cache adds an icon_render_key to a human mob, it represents:
 * - Gender, if applicable
 * - The ID of the limb
 * - Whether or not it's digitigrade
 * - Draw color, if applicable
 *
 * These procs only store limbs as to increase the number of matching icon_render_keys
 * This cache exists because drawing 6/7 icons for humans constantly is quite a waste
 * See RemieRichards on irc.rizon.net #coderbus (RIP remie :sob:)
*/
/obj/item/bodypart/proc/generate_icon_key()
	RETURN_TYPE(/list)
	. = list()
	if(is_dimorphic)
		. += "[limb_gender]-"
	. += "[limb_id]"
	. += "-[body_zone]"
	if(bodytype & BODYTYPE_DIGITIGRADE && !plantigrade_forced)
		. += "-digitigrade"
	if(should_draw_greyscale && draw_color)
		. += "-[draw_color]"

	return .

/obj/item/bodypart/proc/generate_husk_key()
	RETURN_TYPE(/list)
	. = list()
	. += "[husk_type]"
	. += "-husk"
	. += "-[body_zone]"
	return .

GLOBAL_LIST_EMPTY(masked_leg_icons_cache)

/obj/item/bodypart/leg/proc/generate_masked_leg(mutable_appearance/limb_overlay, image_dir = NONE)
	RETURN_TYPE(/list)
	if(!limb_overlay)
		return
	. = list()

	var/icon_cache_key = "[limb_overlay.icon]-[limb_overlay.icon_state]-[body_zone]"
	var/icon/new_leg_icon
	var/icon/new_leg_icon_lower

	//in case we do not have a cached version of the two cropped icons for this key, we have to create it
	if(!GLOB.masked_leg_icons_cache[icon_cache_key])
		var/icon/leg_crop_mask = (body_zone == BODY_ZONE_R_LEG ? icon('icons/mob/leg_masks.dmi', "right_leg") : icon('icons/mob/leg_masks.dmi', "left_leg"))
		var/icon/leg_crop_mask_lower = (body_zone == BODY_ZONE_R_LEG ? icon('icons/mob/leg_masks.dmi', "right_leg_lower") : icon('icons/mob/leg_masks.dmi', "left_leg_lower"))

		new_leg_icon = icon(limb_overlay.icon, limb_overlay.icon_state)
		new_leg_icon.Blend(leg_crop_mask, ICON_MULTIPLY)

		new_leg_icon_lower = icon(limb_overlay.icon, limb_overlay.icon_state)
		new_leg_icon_lower.Blend(leg_crop_mask_lower, ICON_MULTIPLY)

		GLOB.masked_leg_icons_cache[icon_cache_key] = list(new_leg_icon, new_leg_icon_lower)
	new_leg_icon = GLOB.masked_leg_icons_cache[icon_cache_key][1]
	new_leg_icon_lower = GLOB.masked_leg_icons_cache[icon_cache_key][2]

	//this could break layering in oddjob cases, but i'm sure it will work fine most of the time... right?
	var/mutable_appearance/new_leg_appearance = new(limb_overlay)
	new_leg_appearance.icon = new_leg_icon
	new_leg_appearance.layer = -BODYPARTS_LAYER
	new_leg_appearance.dir = image_dir //for some reason, things do not work properly otherwise
	. += new_leg_appearance
	var/mutable_appearance/new_leg_appearance_lower = new(limb_overlay)
	new_leg_appearance_lower.icon = new_leg_icon_lower
	new_leg_appearance_lower.layer = -BODYPARTS_LOW_LAYER
	new_leg_appearance_lower.dir = image_dir
	. += new_leg_appearance_lower
	return .

////Extremely special handling for species with abnormal hand placement. This essentially rebuilds the hand overlay every
////rotation, with every direction having a unique pixel offset for in-hands.
////On species gain, a signal is registered to track direction changes.
////SPECIAL_HAND_OVERLAY is for rendering items under the body.
/mob/living/carbon/proc/update_hands_on_rotate() //Required for unconventionally placed hands on species
	SIGNAL_HANDLER
	if(!layered_hands) //Defined in human_defines.dm
		RegisterSignal(src, COMSIG_ATOM_DIR_CHANGE, PROC_REF(special_update_hands))
		layered_hands = TRUE

/mob/living/carbon/proc/stop_updating_hands()
	if(layered_hands)
		UnregisterSignal(src, COMSIG_ATOM_DIR_CHANGE)
		layered_hands = FALSE
		remove_overlay(HANDS_UNDER_BODY_LAYER)

/mob/living/carbon/proc/special_update_hands(mob/M, olddir, newdir, override = FALSE)
	if(olddir == newdir && !override)
		return
	if(!newdir)
		newdir = dir //For when update_inv_hands() calls this proc instead of the signal
	remove_overlay(HANDS_LAYER)
	remove_overlay(HANDS_UNDER_BODY_LAYER)
	if (handcuffed)
		drop_all_held_items()
		return

	var/list/hands = list()
	var/list/hands_alt = list()
	for(var/obj/item/I in held_items)
		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			I.screen_loc = ui_hand_position(get_held_index_of_item(I))
			client.screen += I
		var/t_state = I.item_state
		if(!t_state)
			t_state = I.icon_state
		var/icon_file = I.lefthand_file
		var/layer
		var/mutable_appearance/hand_overlay
		if(get_held_index_of_item(I) % 2 == 0)
			icon_file = I.righthand_file
			if(newdir == WEST || newdir == NORTH)
				layer = HANDS_UNDER_BODY_LAYER //If facing left or up, the right hand's sprite will be rendered under the mob
			else
				layer = HANDS_LAYER
			hand_overlay = I.build_worn_icon(default_layer = layer, default_icon_file = icon_file, isinhands = TRUE, direction = newdir)

		else
			if(newdir == EAST || newdir == NORTH)
				layer = HANDS_UNDER_BODY_LAYER //If facing right or up, the left hand's sprite will be rendered under the mob
			else
				layer = HANDS_LAYER
			hand_overlay = I.build_worn_icon(default_layer = layer, default_icon_file = icon_file, isinhands = TRUE, direction = newdir)

		if(layer == HANDS_LAYER)
			hands += hand_overlay
		else
			hands_alt += hand_overlay
	overlays_standing[HANDS_LAYER] = hands
	overlays_standing[HANDS_UNDER_BODY_LAYER] = hands_alt
	apply_overlay(HANDS_LAYER)
	apply_overlay(HANDS_UNDER_BODY_LAYER)
