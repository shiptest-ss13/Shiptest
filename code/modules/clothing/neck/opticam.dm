//to-do: weigh annoyance of refactoring toggleable neck-type to not be /poncho with time I have to work.
/obj/item/clothing/neck/opticamo
	name = "\improper optical camouflage cloak"
	desc = "A soft, long woven cloak made from a silky material, highly calibrated sensors, and a localized computing mesh."
	icon = 'icons/obj/clothing/neck/opticam.dmi'
	mob_overlay_icon = 'icons/mob/clothing/neck/opticam.dmi'
	base_icon_state = "opticam"
	icon_state = "opticam-0"
	w_class = WEIGHT_CLASS_BULKY
	body_parts_covered = CHEST | GROIN | LEGS | ARMS
	flags_inv = HIDESUITSTORAGE

	greyscale_colors = null
	greyscale_icon_state = null

	alternate_worn_layer = BODY_FRONT_LAYER

	equip_sound = 'sound/items/equip/straps_equip.ogg'
	equip_delay_self = EQUIP_DELAY_COAT
	equip_delay_other = EQUIP_DELAY_COAT * 1.5
	strip_delay = EQUIP_DELAY_COAT * 1.5
	equip_self_flags = EQUIP_ALLOW_MOVEMENT | EQUIP_SLOWDOWN

	actions_types = list(/datum/action/item_action/toggle_hood, /datum/action/item_action/toggle_opticamo)

	power_use_amount = POWER_CELL_USE_HIGH

	var/hoodup = FALSE

	var/processing = FALSE

	var/next_cell_update = 0

	var/datum/status_effect/cloak_type = STATUS_EFFECT_CLOAKED


	var/cell_override = /obj/item/stock_parts/cell/high

/obj/item/clothing/neck/opticamo/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	AddComponent(/datum/component/cell, cell_override, _has_cell_overlays=FALSE, _cell_weight_class = WEIGHT_CLASS_SMALL)
	update_appearance()

/obj/item/clothing/neck/opticamo/dropped(mob/user)
	. = ..()
	if(hoodup)
		toggle_hood(user)
	deactivate(user)

/obj/item/clothing/neck/opticamo/ui_action_click(user, action)
	if(istype(action, /datum/action/item_action/toggle_hood))
		playsound(src, 'sound/items/equip/equipping_short_generic.ogg', 15)
		if(do_after(user, 15, user, IGNORE_USER_LOC_CHANGE))
			toggle_hood(user)
	else if(istype(action, /datum/action/item_action/toggle_opticamo))
		toggle_cloak(user)

/obj/item/clothing/neck/opticamo/proc/toggle_hood(mob/user)
	deactivate(user)
	hoodup = !hoodup
	icon_state = "[base_icon_state]-[hoodup]"
	to_chat(user, "You [hoodup ? "put up" : "tuck away"] [src]'s hood")
	if(hoodup)
		flags_inv = HIDESUITSTORAGE | HIDEHAIR | HIDEEARS
	else
		flags_inv = HIDESUITSTORAGE
	update_appearance()
	user.update_inv_head()

/obj/item/clothing/neck/opticamo/proc/toggle_cloak(mob/user)
	if(processing)
		deactivate(user)
	else
		activate(user)

/obj/item/clothing/neck/opticamo/emp_act(severity)
	. = ..()
	if(processing)
		do_sparks(4, 0, loc)
		processing = FALSE
	var/datum/component/cell/our_cell = GetComponent(/datum/component/cell)
	our_cell?.inserted_cell.emp_act(severity)

/obj/item/clothing/neck/opticamo/proc/activate(mob/living/user)
	if(processing)
		return

	//be quiet
	flags_inv = HIDEGLOVES|HIDESUITSTORAGE|HIDEJUMPSUIT|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEHORNS|HIDESHOES
	user.update_inv_w_uniform()

	if(ishuman(user))
		var/mob/living/carbon/human/active_user = user
		active_user.name_override = "???"


	playsound(user, 'sound/effects/cloakon.ogg', 50)
	user.apply_status_effect(cloak_type)
	processing = TRUE
	START_PROCESSING(SSobj, src)

/obj/item/clothing/neck/opticamo/proc/deactivate(mob/living/user)
	if(!processing)
		return

	flags_inv = HIDEHAIR|HIDEEARS
	user.update_inv_w_uniform()

	if(ishuman(user))
		var/mob/living/carbon/human/active_user = user
		active_user.name_override = null

	playsound(user, 'sound/effects/cloakoff.ogg', 50)
	user.remove_status_effect(cloak_type)
	STOP_PROCESSING(SSobj, src)
	processing = FALSE

/obj/item/clothing/neck/opticamo/process(seconds_per_tick)
	if(world.time > next_cell_update)
		next_cell_update = world.time + 100
		update_overlays()

	if(!hoodup)
		deactivate(wearer.resolve())
		return

	if(!(item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		deactivate(wearer.resolve())
		return

/obj/item/clothing/neck/opticamo/update_appearance(updates)
	icon_state = "[base_icon_state]-[hoodup]"
	. = ..()

/obj/item/clothing/neck/opticamo/update_overlays()
	. = ..()
	var/datum/component/cell/our_cell = GetComponent(/datum/component/cell)
	if(!our_cell.inserted_cell)
		return cut_overlays()
	var/charge = our_cell.inserted_cell.percent()
	if(charge > 66)
		. += "charge-100"
	else if(charge > 20)
		. += "charge-66"
	else
		. += "charge-33"

/datum/action/item_action/toggle_opticamo
	name = "Toggle optical camoflague"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "power_yellow"

/datum/action/item_action/toggle_opticamo/Trigger()
	if(!istype(target, /obj/item/clothing/neck/opticamo) || !..())
		return

/datum/action/item_action/toggle_opticamo/IsAvailable()
	var/datum/component/cell/our_cell = target.GetComponent(/datum/component/cell)
	if(!our_cell.inserted_cell || !our_cell.inserted_cell?.percent())
		return FALSE
	if(!istype(target, /obj/item/clothing/neck/opticamo))
		return FALSE
	var/obj/item/clothing/neck/opticamo/camo = target
	if(!camo.hoodup)
		return FALSE
	. = ..()

/obj/item/clothing/neck/opticamo/tvstatic
	cloak_type = STATUS_EFFECT_STATIC_CLOAK
