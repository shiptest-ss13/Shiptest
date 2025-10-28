/obj/item/clothing/head
	name = BODY_ZONE_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	lefthand_file = 'icons/mob/inhands/clothing/hats_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/hats_righthand.dmi'
	icon_state = "tophat"
	item_state = "that"
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_HEAD
	var/blockTracking = 0 //For AI tracking
	var/can_toggle = null
	greyscale_icon_state = "hat"
	greyscale_colors = list(list(16,26))
	supports_variations = VOX_VARIATION
	blood_overlay_type = "helmet"

	equipping_sound = EQUIP_SOUND_VFAST_GENERIC
	unequipping_sound = UNEQUIP_SOUND_VFAST_GENERIC
	equip_delay_self = EQUIP_DELAY_HAT
	equip_delay_other = EQUIP_DELAY_HAT * 1.5
	strip_delay = EQUIP_DELAY_HAT * 1.5
	equip_self_flags = EQUIP_ALLOW_MOVEMENT

///Special throw_impact for hats to frisbee hats at people to place them on their heads/attempt to de-hat them.
/obj/item/clothing/head/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	. = ..()
	///if the thrown object's target zone isn't the head
	if(thrownthing.target_zone != BODY_ZONE_HEAD)
		return
	///ignore any hats with the tinfoil counter-measure enabled
	if(clothing_flags & ANTI_TINFOIL_MANEUVER)
		return
	///if the hat happens to be capable of holding contents and has something in it. mostly to prevent super cheesy stuff like stuffing a mini-bomb in a hat and throwing it
	if(LAZYLEN(contents))
		return
	if(iscarbon(hit_atom))
		var/mob/living/carbon/H = hit_atom
		if(istype(H.head, /obj/item))
			var/obj/item/WH = H.head
			///check if the item has NODROP
			if(HAS_TRAIT(WH, TRAIT_NODROP))
				H.visible_message(span_warning("[src] bounces off [H]'s [WH.name]!"), span_warning("[src] bounces off your [WH.name], falling to the floor."))
				return
			///check if the item is an actual clothing head item, since some non-clothing items can be worn
			if(istype(WH, /obj/item/clothing/head))
				var/obj/item/clothing/head/WHH = WH
				///SNUG_FIT hats are immune to being knocked off
				if(WHH.clothing_flags & SNUG_FIT)
					H.visible_message(span_warning("[src] bounces off [H]'s [WHH.name]!"), span_warning("[src] bounces off your [WHH.name], falling to the floor."))
					return
			///if the hat manages to knock something off
			if(H.dropItemToGround(WH))
				H.visible_message(span_warning("[src] knocks [WH] off [H]'s head!"), span_warning("[WH] is suddenly knocked off your head by [src]!"))
		if(H.equip_to_slot_if_possible(src, ITEM_SLOT_HEAD, 0, 1, 1, TRUE))
			H.visible_message(span_notice("[src] lands neatly on [H]'s head!"), span_notice("[src] lands perfectly onto your head!"))
		return
	if(iscyborg(hit_atom))
		var/mob/living/silicon/robot/R = hit_atom
		///hats in the borg's blacklist bounce off
		if(is_type_in_typecache(src, GLOB.blacklisted_borg_hats))
			R.visible_message(span_warning("[src] bounces off [R]!"), span_warning("[src] bounces off you, falling to the floor."))
			return
		else
			R.visible_message(span_notice("[src] lands neatly on top of [R]!"), span_notice("[src] lands perfectly on top of you."))
			R.place_on_head(src) //hats aren't designed to snugly fit borg heads or w/e so they'll always manage to knock eachother off




/obj/item/clothing/head/worn_overlays(isinhands = FALSE)
	. = ..()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damagedhelmet")
		if(HAS_BLOOD_DNA(src))
			. += setup_blood_overlay()

/obj/item/clothing/head/update_clothes_damaged_state(damaged_state = CLOTHING_DAMAGED)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_head()
