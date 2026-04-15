//to-do: weigh annoyance of refactoring toggleable neck-type to not be /poncho with time I have to work.
/obj/item/clothing/neck/poncho/opticamo
	name = "brown cloak"
	desc = "It's a cape that can be worn around your neck."
	icon = 'icons/obj/clothing/cloaks.dmi'
	icon_state = "qmcloak"
	w_class = WEIGHT_CLASS_BULKY
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESUITSTORAGE
	greyscale_colors = null
	greyscale_icon_state = null

	equip_sound = 'sound/items/equip/straps_equip.ogg'
	equip_delay_self = EQUIP_DELAY_COAT
	equip_delay_other = EQUIP_DELAY_COAT * 1.5
	strip_delay = EQUIP_DELAY_COAT * 1.5
	equip_self_flags = EQUIP_ALLOW_MOVEMENT | EQUIP_SLOWDOWN

	var/charge_per_attack = 1000
	var/cell_override = /obj/item/stock_parts/cell/high

/obj/item/melee/powerfist/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cell, cell_override, _has_cell_overlays=FALSE)
	update_appearance()

/obj/item/clothing/neck/opticamo/update_overlays()
	. = ..()
	var/datum/component/cell/our_cell = GetComponent(/datum/component/cell)
	if(!our_cell.inserted_cell)
		return cut_overlays()
	var/charge = our_cell.inserted_cell.percent()
	if(charge > 66)
		. += "powerfist-3"
	else if(charge > 20)
		. += "powerfist-2"
	else
		. += "powerfist-1"



/datum/action/toggle_opticamo
	name = "Toggle optical camoflague"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"
