/obj/item/attachment/rail_light
	name = "Rail Light"
	desc = "Rail mounted gun light for better visibility down range."
	icon_state = "raillight"

	light_color = "#FFCC66"
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 0.8
	light_on = FALSE

/obj/item/attachment/rail_light/Toggle(obj/item/gun/gun, mob/user)
	. = ..()
	set_light_on(toggled)
	update_icon()

/obj/item/attachment/rail_light/Attach(obj/item/gun/gun, mob/user)
	. = ..()
	if(!.)
		return

	set_light_flags(light_flags | LIGHT_ATTACHED)

/obj/item/attachment/rail_light/Detach(obj/item/gun/gun, mob/user)
	. = ..()
	if(!.)
		return

	set_light_flags(light_flags & ~LIGHT_ATTACHED)
