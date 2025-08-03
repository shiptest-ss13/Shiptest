/obj/structure/ms13/workbench
	name = "Workbench for power armors"
	icon = 'icons/obj/clothing/power_armor/workbench.dmi'
	icon_state = "station"
	pixel_y = -16
	pixel_x = -16
	anchored = TRUE
	var/obj/item/clothing/suit/space/hardsuit/ms13/power_armor/obj_connected = null

/obj/structure/ms13/workbench/examine(mob/user)
	. = ..()
	. += "Alt+left click to connect workbench to power armor."

/obj/structure/ms13/workbench/AltClick(mob/user)
	if(!obj_connected)
		obj_connected = locate(/obj/item/clothing/suit/space/hardsuit/ms13/power_armor) in loc
		if(istype(obj_connected))
			var/icon/chains = new(icon, "chains")
			add_overlay(chains)
			obj_connected.link_to = src
			to_chat(user, span_notice("You connect the power armor to workbench!"))
			return TRUE
		obj_connected = null
	else
		cut_overlays()
		obj_connected.link_to = null
		obj_connected = null
		to_chat(user, span_notice("You disconnect the power armor to workbench!"))
		return TRUE
	return FALSE
