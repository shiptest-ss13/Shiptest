/obj/item/attachment/silencer
	name = "suppressor"
	desc = "An attachment for the barrel of a firearm. Muffles the gunshot and muzzle flash."
	icon_state = "silencer"

	slot = ATTACHMENT_SLOT_MUZZLE
	pixel_shift_x = 1
	pixel_shift_y = 2
	spread_mod = -1
	size_mod = 1

/obj/item/attachment/silencer/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.suppressed = TRUE

/obj/item/attachment/silencer/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.suppressed = FALSE
	return TRUE

/obj/item/attachment/silencer/cobra
	size_mod = 0
	attach_features_flags = ATTACH_NO_SPRITE
