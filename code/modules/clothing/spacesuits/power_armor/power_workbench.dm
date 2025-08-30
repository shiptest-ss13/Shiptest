/obj/structure/power_armor_hoist
	name = "power armor hoist"
	icon = 'icons/obj/clothing/power_armor/workbench.dmi'
	icon_state = "station"
	pixel_y = -16
	pixel_x = -16
	anchored = TRUE
	var/obj/item/clothing/suit/space/hardsuit/power_armor/obj_connected = null

/obj/structure/power_armor_hoist/examine(mob/user)
	. = ..()
	. += "Alt+left click to connect hoist to power armor."

/obj/structure/power_armor_hoist/AltClick(mob/user)
	if(!obj_connected)
		obj_connected = locate(/obj/item/clothing/suit/space/hardsuit/power_armor) in loc
		if(istype(obj_connected))
			var/icon/chains = new(icon, "chains")
			add_overlay(chains)
			obj_connected.linked_to = src
			to_chat(user, span_notice("You connect the power armor to hoist!"))
			return TRUE
		obj_connected = null
	else
		cut_overlays()
		obj_connected.linked_to = null
		obj_connected = null
		to_chat(user, span_notice("You disconnect the power armor to hoist!"))
		return TRUE
	return FALSE
