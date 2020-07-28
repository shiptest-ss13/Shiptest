/obj/machinery/porta_turret/ai/in_faction(mob/target)
	. = ..()
	if(ismouse(target))
		return TRUE

/obj/machinery/porta_turret/centcom_shuttle/ballistic
	stun_projectile = /obj/projectile/bullet
	lethal_projectile = /obj/projectile/bullet
	lethal_projectile_sound = 'sound/weapons/gun/smg/shot.ogg'
	stun_projectile_sound = 'sound/weapons/gun/smg/shot.ogg'
	desc = "A ballistic machine gun auto-turret."
