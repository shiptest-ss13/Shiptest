/obj/item/attachment/scope
	name = "scope"
	desc = "An attachment for the scope of a weapon. Allows one to aim down the sight."
	icon_state = "small_scope"

	slot = ATTACHMENT_SLOT_SCOPE
	pixel_shift_x = 1
	pixel_shift_y = 2
	size_mod = 1
	var/zoom_mod = 6
	var/zoom_out_mod = 2


/obj/item/attachment/scope/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.zoom_amt = zoom_mod
	gun.zoom_out_amt = zoom_out_mod

/obj/item/attachment/scope/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.zoom_amt = initial(gun.zoom_amt)
	gun.zoom_out_amt = initial(gun.zoom_out_amt)
	return TRUE
