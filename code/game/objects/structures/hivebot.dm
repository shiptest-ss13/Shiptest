/obj/structure/hivebot_beacon
	name = "beacon"
	desc = "Some odd beacon thing."
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "def_radar-off"
	anchored = TRUE
	density = TRUE
	var/bot_type = "norm"
	var/bot_amt = 10
	var/spawn_time_min
	var/spawn_time_max

/obj/structure/hivebot_beacon/Initialize()
	. = ..()
	var/datum/effect_system/smoke_spread/smoke = new
	smoke.set_up(2, loc)
	smoke.start()
	visible_message("<span class='boldannounce'>[src] warps in!</span>")
	playsound(src.loc, 'sound/effects/empulse.ogg', 25, TRUE)
	addtimer(CALLBACK(src, .proc/warpbots), rand(spawn_time_min, spawn_time_max))

/obj/structure/hivebot_beacon/proc/warpbots()
	icon_state = "def_radar"
	visible_message("<span class='danger'>[src] turns on!</span>")
	while(bot_amt > 0)
		bot_amt--
		switch(bot_type)
			if("norm")
				new /mob/living/simple_animal/hostile/hivebot(get_turf(src))
			if("range")
				new /mob/living/simple_animal/hostile/hivebot/range(get_turf(src))
			if("rapid")
				new /mob/living/simple_animal/hostile/hivebot/rapid(get_turf(src))

	sleep(100)
	visible_message("<span class='boldannounce'>[src] warps out!</span>")
	playsound(src.loc, 'sound/effects/empulse.ogg', 25, TRUE)
	qdel(src)
	return

/obj/structure/spawner/wasteplanet/hivebot
	name = "hivebot fabricator"
	desc = "An active fabricator, creating hivebots out of resources from below the surface."

	icon = 'icons/obj/machines/bsm.dmi'
	icon_state = "bsm_on"

	faction = list("mining")
	max_mobs = 5
	max_integrity = 250
	mob_types = list(
		/mob/living/simple_animal/hostile/hivebot/wasteplanet = 40,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/ranged = 40,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/ranged/rapid = 10,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/strong = 5,
		/mob/living/simple_animal/hostile/hivebot/mechanic = 5
	)
	spawn_text = "crawls out of"
	spawn_sound = list('sound/effects/suitstep2.ogg')
	move_resist = INFINITY
	anchored = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	var/obj/effect/light_emitter/hivespawner/emitted_light

/obj/structure/spawner/wasteplanet/hivebot/Initialize()
	. = ..()
	emitted_light = new(loc)

/obj/structure/spawner/wasteplanet/hivebot/deconstruct(disassembled)
	destroy_effect()
	drop_loot()
	return ..()

/obj/structure/spawner/wasteplanet/hivebot/Destroy()
	QDEL_NULL(emitted_light)
	return ..()

/obj/structure/spawner/wasteplanet/hivebot/proc/destroy_effect()
	playsound(loc,'sound/effects/explosionfar.ogg', 200, TRUE)
	visible_message("<span class='boldannounce'>[src] begins to rattle and shake, sparks flying off of it!")


/obj/structure/spawner/wasteplanet/hivebot/proc/drop_loot()
	var/datum/effect_system/smoke_spread/smoke = new
	smoke.set_up(2, loc)
	smoke.start()
	new /obj/effect/particle_effect/sparks(loc)
	new /obj/effect/spawner/lootdrop/waste/hivebot/beacon(loc)

/obj/effect/light_emitter/hivespawner
	set_luminosity = 4
	set_cap = 2.5
	light_color = COLOR_RED_LIGHT


/obj/structure/spawner/wasteplanet/hivebot/low_threat
	max_mobs = 4
	spawn_time = 300

/obj/structure/spawner/wasteplanet/hivebot/medium_threat
	max_mobs = 5
	spawn_time = 250

/obj/structure/spawner/wasteplanet/hivebot/high_threat
	max_mobs = 7
	spawn_time = 200

/obj/structure/spawner/wasteplanet/hivebot/extreme_threat
	max_mobs = 10
	spawn_time = 150


