/obj/item/attachment/laser_sight
	name = "laser sight"
	desc = "This laser sight is designed to be rail-mounted on a compatible firearm to provide increased accuracy."
	icon_state = "laserpointer"
	attach_features_flags = ATTACH_REMOVABLE_HAND|ATTACH_TOGGLE
	pixel_shift_x = 1
	pixel_shift_y = 4

	spread_mod = -1

/obj/item/attachment/laser_sight/Toggle(obj/item/gun/gun, mob/user)
	. = ..()

	playsound(user, toggled ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
