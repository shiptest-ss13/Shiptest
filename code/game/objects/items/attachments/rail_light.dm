/obj/item/attachment/rail_light
	name = "Rail Light"
	desc = "Rail mounted gun light for better visibility down range."
	icon_state = "laser_sight"

	light_color = "#FFCC66"
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 0.8
	light_on = FALSE

/obj/item/attachment/rail_light/Toggle(datum/component/attachment_holder/holder, obj/item/gun/gun, mob/user)
	. = ..()

	set_light_on(toggled)
	update_icon()
