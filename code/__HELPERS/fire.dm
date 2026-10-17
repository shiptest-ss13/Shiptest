/proc/spray_fire_line(atom/source, list/turfs, fire_source = "fire breath", ignite_turfs = FALSE, power = 4, flame_color = "red")
	var/list/hit_list = list()
	for(var/turf/burn_turf in turfs)
		if(istype(burn_turf, /turf/closed))
			break
		new /obj/effect/hotspot(burn_turf)
		burn_turf.hotspot_expose(700,50,1)
		if(ignite_turfs)
			burn_turf.ignite_turf(power,flame_color)
		for(var/mob/living/victim in burn_turf.contents)
			if((victim in hit_list) || victim == source)
				continue
			hit_list += victim
			victim.adjustFireLoss(20)
			to_chat(victim, span_userdanger("You're hit by [source]'s [fire_source]!"))

		// deals damage to mechs
		for(var/obj/mecha/mech in burn_turf.contents)
			if(mech in hit_list)
				continue
			hit_list += mech
			mech.take_damage(45, BRUTE, "melee", 1)
		sleep(1.5)
