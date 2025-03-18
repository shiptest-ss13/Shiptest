/obj/item/attachment/alof
	name = "alof tube"
	desc = "An antiquated spring operated magazine attachment for the HP Beacon. Has a capacity of three rounds."
	icon_state = "alof"

	attach_features_flags = ATTACH_REMOVABLE_HAND
	pixel_shift_x = 10
	pixel_shift_y = 0
	wield_delay = 0.1 SECONDS
	var/obj/item/ammo_box/magazine/internal/shot/alof/mag

/obj/item/attachment/alof/Initialize()
	. = ..()
	mag = new /obj/item/ammo_box/magazine/internal/shot/alof(src)

/obj/item/attachment/alof/Destroy()
	. = ..()
	QDEL_NULL(mag)

/obj/item/attachment/alof/on_attacked(obj/item/gun/gun, mob/user, obj/item)
	. = ..()
	if(istype(item,/obj/item/ammo_casing) || istype(item, /obj/item/ammo_box))
		attackby(item,user)

/obj/item/attachment/alof/attackby(obj/item/I, mob/living/user, params)
	if(istype(I,/obj/item/ammo_casing) || istype(I, /obj/item/ammo_box))
		mag.attackby(I,user)
	else
		return ..()
/obj/item/attachment/alof/attack_self(mob/user)
	. = ..()
	mag.attack_self(user)

/obj/item/attachment/alof/on_unique_action(obj/item/gun/gun, mob/user, obj/item)
	. = ..()
	if(gun.bolt_locked)
		var/obj/item/ammo_casing/casing_to_insert = mag.get_round(TRUE)
		if(gun.magazine.give_round(casing_to_insert,TRUE))
			mag.stored_ammo -= casing_to_insert
			to_chat(user,span_notice("\The [src] automatically loads another round into \the [gun]!"))

/obj/item/ammo_box/magazine/internal/shot/alof
	name = "alof tube internal magazine"
	ammo_type = /obj/item/ammo_casing/a4570
	caliber = ".45-70"
	max_ammo = 3
	instant_load = TRUE
