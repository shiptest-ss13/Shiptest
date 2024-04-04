/obj/projectile/magic
	name = "bolt"
	icon_state = "energy"
	damage = 0
	damage_type = OXY
	nodamage = TRUE
	armour_penetration = 100
	flag = "magic"

/obj/projectile/magic/aoe
	name = "Area Bolt"
	desc = "What the fuck does this do?!"
	damage = 0
	var/proxdet = TRUE

/obj/projectile/magic/aoe/Range()
	if(proxdet)
		for(var/mob/living/L in range(1, get_turf(src)))
			if(L.stat != DEAD && L != firer && !L.anti_magic_check())
				return Bump(L)
	..()
