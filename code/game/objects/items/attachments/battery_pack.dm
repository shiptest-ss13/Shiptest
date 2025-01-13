/obj/item/attachment/battery_pack
	name = "Auxillary Battery Pack"
	desc = "Assault and battery."
	icon_state = "laserpointer"

	attach_features_flags = ATTACH_REMOVABLE_HAND | ATTACH_TOGGLE
	pixel_shift_x = 10
	pixel_shift_y = 0
	wield_delay = 0.1 SECONDS
	var/obj/item/stock_parts/cell/gun/battery_cell // the cell in the attachment

/obj/item/attachment/battery_pack/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	toggled = FALSE
	gun.cell = gun_cell

/obj/item/attachment/battery_pack/toggle_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(toggled)
		gun.cell = battery_cell
	else
		gun.cell = gun_cell
