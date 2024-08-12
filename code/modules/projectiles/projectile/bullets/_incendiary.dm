/obj/projectile/bullet/incendiary
	damage = 20
	var/fire_stacks = 4
	var/ignite_turfs = FALSE
	var/power = 1
	var/flame_color = "red"

/obj/projectile/bullet/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

/obj/projectile/bullet/incendiary/Move()
	. = ..()
	var/turf/location = get_turf(src)
	if(location)
		new /obj/effect/hotspot(location)
		location.hotspot_expose(700, 50, 1)
		if(ignite_turfs)
			location.IgniteTurf(power,flame_color)
