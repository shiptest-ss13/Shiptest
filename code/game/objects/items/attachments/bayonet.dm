/obj/item/attachment/bayonet
	name = "bayonet"
	desc = "Stabby-Stabby"
	icon_state = "bayonet"
	var/extra_force = 10
	pixel_shift_x = 1
	pixel_shift_y = 4

/obj/item/attachment/bayonet/Attach(obj/item/gun/gun, mob/user)
	. = ..()
	gun.force += extra_force
	gun.hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/attachment/bayonet/Detach(obj/item/gun/gun, mob/user)
	. = ..()
	gun.force -= extra_force
	gun.hitsound = initial(gun.hitsound)
	return TRUE
