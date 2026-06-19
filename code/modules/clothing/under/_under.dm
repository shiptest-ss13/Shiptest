/obj/item/clothing/under
	name = "under"
	icon = 'icons/obj/clothing/under/default.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/default.dmi'
	lefthand_file = 'icons/mob/inhands/clothing/suits_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/suits_righthand.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	permeability_coefficient = 0.9
	slot_flags = ITEM_SLOT_ICLOTHING
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	equip_sound = 'sound/items/equip/jumpsuit_equip.ogg'
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	cuttable = TRUE
	clothamnt = 3
	greyscale_colors = list(list(15, 17), list(10, 19), list(15, 10))
	greyscale_icon_state = "under"

	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC
	equip_delay_self = EQUIP_DELAY_UNDERSUIT
	equip_delay_other = EQUIP_DELAY_UNDERSUIT * 1.5
	strip_delay = EQUIP_DELAY_UNDERSUIT * 1.5

	var/has_sensor = HAS_SENSORS // For the crew computer
	var/random_sensor = TRUE
	var/sensor_mode = NO_SENSORS
	var/roll_down = FALSE
	var/roll_sleeves = FALSE
	var/adjusted = NORMAL_STYLE
	var/alt_covers_chest = FALSE // for rolled-down jumpsuits, FALSE = exposes chest and arms, TRUE = does not expose any part
	var/obj/item/clothing/accessory/attached_accessory
	var/mutable_appearance/accessory_overlay
	var/freshly_laundered = FALSE

	supports_variations = VOX_VARIATION
	blood_overlay_type = "uniform"

/obj/item/clothing/under/worn_overlays(isinhands = FALSE)
	. = ..()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damageduniform")
		if(HAS_BLOOD_DNA(src))
			. += setup_blood_overlay()
		if(accessory_overlay)
			. += accessory_overlay

/obj/item/clothing/under/Destroy()
	. = ..()
	if(attached_accessory)
		attached_accessory.detach(src)

/obj/item/clothing/under/attackby(obj/item/I, mob/user, params)
	if((has_sensor == BROKEN_SENSORS) && istype(I, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = I
		C.use(1)
		has_sensor = HAS_SENSORS
		to_chat(user,span_notice("You repair the suit sensors on [src] with [C]."))
		return 1
	if(attached_accessory && ispath(attached_accessory.pocket_storage_component_path) && loc == user)
		attached_accessory.attackby(I,user)
		return
	if(!attach_accessory(I, user))
		return ..()

/obj/item/clothing/under/update_clothes_damaged_state(damaged_state = CLOTHING_DAMAGED)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_w_uniform()
	if(has_sensor > NO_SENSORS)
		has_sensor = BROKEN_SENSORS

/obj/item/clothing/under/Initialize()
	. = ..()
	if(random_sensor)
		//make the sensor mode favor higher levels, except coords.
		sensor_mode = pick(SENSOR_OFF, SENSOR_LIVING, SENSOR_LIVING, SENSOR_VITALS, SENSOR_VITALS, SENSOR_VITALS, SENSOR_COORDS, SENSOR_COORDS)
	if(!(body_parts_covered & LEGS) && greyscale_icon_state == "under")
		greyscale_icon_state = "under_skirt"
	if(!roll_down)
		verbs -= /obj/item/clothing/under/verb/jumpsuit_rolldown
	if(!roll_sleeves)
		verbs -= /obj/item/clothing/under/verb/jumpsuit_rollsleeves

/obj/item/clothing/under/emp_act()
	. = ..()
	if(has_sensor > NO_SENSORS)
		sensor_mode = pick(SENSOR_OFF, SENSOR_OFF, SENSOR_OFF, SENSOR_LIVING, SENSOR_LIVING, SENSOR_VITALS, SENSOR_VITALS, SENSOR_COORDS)
		if(ismob(loc))
			var/mob/M = loc
			to_chat(M,span_warning("The sensors on the [src] change rapidly!"))

/obj/item/clothing/under/visual_equipped(mob/user, slot)
	..()
	if(adjusted)
		adjusted = NORMAL_STYLE
		if(!alt_covers_chest)
			body_parts_covered |= CHEST

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.update_inv_w_uniform()

	if(attached_accessory && slot != ITEM_SLOT_HANDS && ishuman(user))
		var/mob/living/carbon/human/H = user
		attached_accessory.on_uniform_equip(src, user)
		if(attached_accessory.above_suit)
			H.update_inv_wear_suit()

/obj/item/clothing/under/equipped(mob/user, slot)
	..()
	if(slot == ITEM_SLOT_ICLOTHING && freshly_laundered)
		freshly_laundered = FALSE
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "fresh_laundry", /datum/mood_event/fresh_laundry)

/obj/item/clothing/under/dropped(mob/user)
	if(attached_accessory)
		attached_accessory.on_uniform_dropped(src, user)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(attached_accessory.above_suit)
				H.update_inv_wear_suit()

	..()

/obj/item/clothing/under/proc/attach_accessory(obj/item/I, mob/user, notifyAttach = 1)
	. = FALSE
	if(istype(I, /obj/item/clothing/accessory))
		var/obj/item/clothing/accessory/accessory = I
		if(attached_accessory)
			if(user)
				to_chat(user, span_warning("[src] already has an accessory."))
			return
		else

			if(!accessory.can_attach_accessory(src, user)) //Make sure the suit has a place to put the accessory.
				return
			if(user && !user.temporarilyRemoveItemFromInventory(I))
				return
			if(!accessory.attach(src, user))
				return

			if(user && notifyAttach)
				to_chat(user, span_notice("You attach [accessory] to [src]."))

			if(ishuman(loc))
				var/mob/living/carbon/human/H = loc
				var/accessory_state = accessory.icon_state
				var/icon_file = accessory.mob_overlay_icon

				if((H.dna.species.bodytype & BODYTYPE_DIGITIGRADE) && ((accessory.supports_variations & DIGITIGRADE_VARIATION) || (accessory.supports_variations & DIGITIGRADE_VARIATION_SAME_ICON_FILE)))
					icon_file = DIGITIGRADE_ACCESSORY_PATH
					if((accessory.supports_variations & DIGITIGRADE_VARIATION_SAME_ICON_FILE))
						icon_file = accessory.mob_overlay_icon
						accessory_state = "[accessory_state]_digi"

				else if((H.dna.species.bodytype & BODYTYPE_VOX) && (accessory.supports_variations & VOX_VARIATION))
					icon_file = VOX_ACCESSORY_PATH
					if(accessory.vox_override_icon)
						icon_file = accessory.vox_override_icon

				else if((H.dna.species.bodytype & BODYTYPE_KEPORI) && (accessory.supports_variations & KEPORI_VARIATION))
					icon_file = KEPORI_ACCESSORY_PATH
					if(accessory.kepori_override_icon)
						icon_file = accessory.kepori_override_icon

				accessory_overlay = mutable_appearance(icon_file, "[accessory_state]")
				accessory_overlay.alpha = attached_accessory.alpha
				accessory_overlay.color = attached_accessory.color

				H.update_inv_w_uniform()
				H.update_inv_wear_suit()

			return TRUE

/obj/item/clothing/under/proc/remove_accessory(mob/user)
	if(!isliving(user))
		return
	if(!can_use(user))
		return

	if(attached_accessory)
		var/obj/item/clothing/accessory/accessory = attached_accessory
		attached_accessory.detach(src, user)
		if(user.put_in_hands(accessory))
			to_chat(user, span_notice("You detach [accessory] from [src]."))
		else
			to_chat(user, span_notice("You detach [accessory] from [src] and it falls on the floor."))

		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			H.update_inv_w_uniform()
			H.update_inv_wear_suit()


/obj/item/clothing/under/examine(mob/user)
	. = ..()
	if(freshly_laundered)
		. += "It looks fresh and clean."
	if(roll_down)
		if(adjusted == ROLLED_STYLE)
			. += "Alt-click on [src] to roll your suit back up."
		else
			. += "Alt-click on [src] to roll your suit down."
	if (has_sensor == BROKEN_SENSORS)
		. += "Its sensors appear to be shorted out."
	else if(has_sensor > NO_SENSORS)
		switch(sensor_mode)
			if(SENSOR_OFF)
				. += "Its sensors appear to be disabled."
			if(SENSOR_LIVING)
				. += "Its binary life sensors appear to be enabled."
			if(SENSOR_VITALS)
				. += "Its vital tracker appears to be enabled."
			if(SENSOR_COORDS)
				. += "Its vital tracker and tracking beacon appear to be enabled."
	if(attached_accessory)
		. += "\A [attached_accessory] is attached to it. You could Ctrl-click on it to remove it."
		if(attached_accessory.pocket_storage_component_path)
			. += "You could open the storage of \the [attached_accessory] with Alt-click."

/obj/item/clothing/under/rank
	dying_key = DYE_REGISTRY_UNDER
