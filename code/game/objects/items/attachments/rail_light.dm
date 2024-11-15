/obj/item/attachment/rail_light
	name = "rail light"
	desc = "A flashlight made to be mounted on a firearm."
	icon_state = "raillight"
	light_color = COLOR_LIGHT_ORANGE
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 5
	light_power = 0.9
	light_on = FALSE

	attach_features_flags = ATTACH_REMOVABLE_HAND|ATTACH_TOGGLE
	pixel_shift_x = 1
	pixel_shift_y = 4
	wield_delay = 0.1 SECONDS

/obj/item/attachment/rail_light/toggle_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	set_light_on(toggled)
	update_icon()

/obj/item/attachment/rail_light/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(!.)
		return

	set_light_flags(light_flags | LIGHT_ATTACHED)

/obj/item/attachment/rail_light/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(!.)
		return

	set_light_flags(light_flags & ~LIGHT_ATTACHED)
