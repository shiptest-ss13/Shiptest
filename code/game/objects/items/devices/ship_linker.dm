/obj/item/ship_linker
	name = "Ship Linker"
	desc = "A dev tool for now"
	icon = 'icons/obj/tools.dmi'
	icon_state = "multitool"
	var/datum/overmap/ship/controlled/linked_ship

/obj/item/ship_linker/examine(mob/user)
	. = ..()
	if(linked_ship)
		. += "Linked to: [linked_ship]"

/obj/item/ship_linker/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	linked_ship = port.current_ship

/obj/item/ship_linker/disconnect_from_shuttle(obj/docking_port/mobile/port)
	. = ..()
	linked_ship = null

/obj/item/ship_linker/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !check_allowed_items(target))
		return
	playsound(src, 'sound/weapons/empty.ogg', 30, TRUE)
	if(do_after(user, 3 SECONDS, TRUE, src))
		target.connect_to_shuttle(linked_ship.shuttle_port, linked_ship.shuttle_port.docked, TRUE)
		to_chat(user, span_notice("You link the [target] to the [linked_ship]."))
		playsound(src, 'sound/weapons/empty.ogg', 30, TRUE)
