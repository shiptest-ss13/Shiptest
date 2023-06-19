//Necropolis Tendrils, which spawn lavaland monsters and break into a chasm when killed
/obj/structure/spawner/lavaland
	name = "necropolis tendril"
	desc = "A vile tendril of corruption, originating deep underground. Terrible monsters are pouring out of it."

	icon = 'icons/mob/nest.dmi'
	icon_state = "tendril"

	faction = list("mining")
	max_mobs = 5
	max_integrity = 450
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/tendril)

	move_resist = INFINITY // just killing it tears a massive hole in the ground, let's not move it
	anchored = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF

	var/gps = null
	var/obj/effect/light_emitter/tendril/emitted_light

GLOBAL_LIST_INIT(tendrils, list())
/obj/structure/spawner/lavaland/Initialize()
	. = ..()
	emitted_light = new(loc)
	for(var/F in RANGE_TURFS(1, src))
		if(ismineralturf(F))
			var/turf/closed/mineral/M = F
			M.ScrapeAway(null, CHANGETURF_IGNORE_AIR)
	GLOB.tendrils += src

/obj/structure/spawner/lavaland/deconstruct(disassembled)
	new /obj/effect/collapse(loc)
	new /obj/structure/closet/crate/necropolis/tendril(loc)
	return ..()


/obj/structure/spawner/lavaland/Destroy()
	var/last_tendril = TRUE
	if(GLOB.tendrils.len>1)
		last_tendril = FALSE

	if(last_tendril && !(flags_1 & ADMIN_SPAWNED_1))
		if(SSachievements.achievements_enabled)
			for(var/mob/living/L in view(7,src))
				if(L.stat || !L.client)
					continue
				L.client.give_award(/datum/award/achievement/boss/tendril_exterminator, L)
				L.client.give_award(/datum/award/score/tendril_score, L) //Progresses score by one
	GLOB.tendrils -= src
	QDEL_NULL(emitted_light)
	return ..()

/obj/effect/light_emitter/tendril
	set_luminosity = 4
	set_cap = 2.5
	light_color = LIGHT_COLOR_LAVA

/obj/effect/collapse
	name = "collapsing necropolis tendril"
	desc = "Get clear!"
	layer = TABLE_LAYER
	icon = 'icons/mob/nest.dmi'
	icon_state = "tendril"
	anchored = TRUE
	density = TRUE
	var/obj/effect/light_emitter/tendril/emitted_light

/obj/effect/collapse/Initialize()
	. = ..()
	emitted_light = new(loc)
	visible_message("<span class='boldannounce'>The tendril writhes in fury as the earth around it begins to crack and break apart! Get back!</span>")
	visible_message("<span class='warning'>Something falls free of the tendril!</span>")
	playsound(loc,'sound/effects/tendril_destroyed.ogg', 200, FALSE, 50, TRUE, TRUE)
	addtimer(CALLBACK(src, .proc/collapse), 50)

/obj/effect/collapse/Destroy()
	QDEL_NULL(emitted_light)
	return ..()

/obj/effect/collapse/proc/collapse()
	for(var/mob/M in range(7,src))
		shake_camera(M, 15, 1)
	playsound(get_turf(src),'sound/effects/explosionfar.ogg', 200, TRUE)
	visible_message("<span class='boldannounce'>The tendril falls inward, the ground around it erupting into bubbling lava!</span>") //WS edit.
	for(var/turf/T in range(2,src))
		if(!T.density)
			T.TerraformTurf(/turf/open/lava/smooth/lava_land_surface, /turf/open/lava/smooth/lava_land_surface, flags = CHANGETURF_INHERIT_AIR) //WS edit, instead of chasms this produces lava instead.
	qdel(src)

	//these are good for mappers and already see use in some maps.

/obj/structure/spawner/lavaland/goliath
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/goliath/beast/tendril)

/obj/structure/spawner/lavaland/legion
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/hivelord/legion/tendril)

/obj/structure/spawner/lavaland/icewatcher
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing)

/obj/structure/spawner/lavaland/whitesandsbasilisk
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands)

	//these are ones that we want to see spawning on worlds.

/obj/structure/spawner/lavaland/low_threat //this is the most common one, it shouldn't be a huge issue for most players.
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/tendril = 27,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/tendril = 26,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/tendril = 26,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing = 1,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20
	)
	max_mobs = 4
	spawn_time = 300

/obj/structure/spawner/lavaland/medium_threat //this is less common. It starts getting dangerous here.
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/tendril = 27,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/tendril = 26,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/tendril = 26,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing = 1,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20
	)
	max_mobs = 6
	spawn_time = 200 //they spawn a little faster

/obj/structure/spawner/lavaland/high_threat //this should be rare. People will have trouble with this.
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/tendril = 27,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/tendril = 26,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/tendril = 26,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing = 1,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20
	)
	max_mobs = 9
	spawn_time = 200

/obj/structure/spawner/lavaland/extreme_threat //extremely rare
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/tendril = 27,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/tendril = 26,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/tendril = 26,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing = 1,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20
	)
	max_mobs = 12
	spawn_time = 150 //bring a friend and some automatic weapons

//and sand world ones. More legions, no brimdemons, no icewings.

/obj/structure/spawner/lavaland/sand_world/low_threat
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/tendril = 20,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/tendril = 40,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40
	)
	max_mobs = 5
	spawn_time = 300

/obj/structure/spawner/lavaland/sand_world/medium_threat
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/tendril = 20,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/tendril = 40,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40
	)
	max_mobs = 7
	spawn_time = 200

/obj/structure/spawner/lavaland/sand_world/high_threat
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/tendril = 20,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/tendril = 40,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40
	)
	max_mobs = 10
	spawn_time = 200

/obj/structure/spawner/lavaland/sand_world/extreme_threat
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/tendril = 20,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/tendril = 40,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40
	)
	max_mobs = 12
	spawn_time = 150
