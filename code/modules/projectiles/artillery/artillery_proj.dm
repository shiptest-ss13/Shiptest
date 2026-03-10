/obj/projectile/bullet/mortar
	name = "80mm shell"
	icon_state = "mortar"

	movement_type = PHASING
	pass_flags = PASSTABLE | PASSGRILLE | PASSGRILLE | PASSMOB | PASSCLOSEDTURF | LETPASSTHROW | PASSPLATFORM

	speed = 3
	damage = 0
	range = 1000
	light_color = COLOR_VERY_SOFT_YELLOW
	light_range = 1.5
	near_miss_sound = FALSE

/obj/projectile/bullet/mortar/scan_moved_turf()
	. = ..()

/obj/projectile/bullet/mortar/proc/payload()
	return

/obj/projectile/bullet/mortar/on_range()
	if(isarea(get_area(src), /area/overmap_encounter/planetoid/cave))
		to_chat(get_turf(src), span_danger("Something slams into the roof of the cave, but you appear protected!"))
	payload()
	return ..()

/obj/projectile/bullet/mortar/he/payload()
	explosion(get_turf(src), 1, 2, 5, 0, flame_range = 3)

/obj/projectile/bullet/mortar/incend/payload()
	explosion(get_turf(src), 0, 2, 3, 0, flame_range = 7)
	flame_radius(get_turf(src), 4)
	playsound(get_turf(src), pick('sound/weapons/gun/flamethrower/flamethrower1.ogg','sound/weapons/gun/flamethrower/flamethrower2.ogg','sound/weapons/gun/flamethrower/flamethrower3.ogg'), 35, 1, 4)

/obj/projectile/bullet/mortar/smoke
	///the smoke effect at the point of detonation
	var/datum/effect_system/smoke_spread/smoketype = /datum/effect_system/smoke_spread

/obj/projectile/bullet/mortar/smoke/payload()
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	explosion(get_turf(src), 0, 0, 1, 0,  flame_range = 3)
	playsound(get_turf(src), 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(10, get_turf(src), 11)
	smoke.start()

/obj/projectile/bullet/mortar/howi
	name = "150mm shell"
	icon_state = "howi"


/obj/projectile/bullet/mortar/howi/he/payload()
	explosion(get_turf(src), 1, 6, 7, 0, flame_range = 7)

/obj/projectile/bullet/mortar/howi/incend/payload()
	explosion(get_turf(src), 0, 3, 0, 0, 0, 3)
	flame_radius(5, get_turf(src))
	playsound(get_turf(src), pick('sound/weapons/gun/flamethrower/flamethrower1.ogg','sound/weapons/gun/flamethrower/flamethrower2.ogg','sound/weapons/gun/flamethrower/flamethrower3.ogg'), 35, 1, 4)

/obj/projectile/bullet/mortar/howi/smoke
	name = "150mm shell"
	icon_state = "howi"
