/proc/spray_fire_line(atom/source, list/turfs, fire_source = "fire breath", ignite_turfs = FALSE, power = 4, flame_color = "red")
	var/list/hit_list = list()
	for(var/turf/T in turfs)
		if(istype(T, /turf/closed))
			break
		new /obj/effect/hotspot(T)
		T.hotspot_expose(700,50,1)
		if(ignite_turfs)
			T.ignite_turf(power,flame_color)
		for(var/mob/living/L in T.contents)
			if((L in hit_list) || L == source)
				continue
			hit_list += L
			L.adjustFireLoss(20)
			to_chat(L, span_userdanger("You're hit by [source]'s [fire_source]!"))

		// deals damage to mechs
		for(var/obj/mecha/M in T.contents)
			if(M in hit_list)
				continue
			hit_list += M
			M.take_damage(45, BRUTE, "melee", 1)
		sleep(1.5)
