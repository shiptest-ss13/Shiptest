/obj/item/attachment/long_scope
	name = "long range scope"
	desc = "An attachment for the scope of a weapon. Allows one to aim down the sight."
	icon_state = "scope"

	slot = ATTACHMENT_SLOT_SCOPE
	pixel_shift_x = 1
	pixel_shift_y = 2
	size_mod = 1
	var/zoom_mod = 10
	var/zoom_out_mod = 3
	var/aim_slowdown_mod = 0.4


/obj/item/attachment/long_scope/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.zoom_amt = zoom_mod
	gun.zoom_out_amt = zoom_out_mod
	gun.aimed_wield_slowdown += aim_slowdown_mod

/obj/item/attachment/long_scope/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.zoom_amt = initial(gun.zoom_amt)
	gun.zoom_out_amt = initial(gun.zoom_out_amt)
	gun.aimed_wield_slowdown = initial(gun.aimed_wield_slowdown)
	return TRUE
