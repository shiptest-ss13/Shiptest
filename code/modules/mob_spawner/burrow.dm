GLOBAL_LIST_INIT(ore_probability, list(
	/obj/item/stack/ore/plasma = 75,
	/obj/item/stack/ore/hematite = 75,
	/obj/item/stack/ore/rutile = 50,
	/obj/item/stack/ore/galena = 50,
	/obj/item/stack/ore/gold = 50,
	/obj/item/stack/ore/autunite = 50,
	/obj/item/stack/ore/diamond = 25,
	/obj/effect/mob_spawn/human/corpse/damaged/legioninfested = 25,
	/obj/effect/mob_spawn/human/corpse/damaged/legioninfested = 25,
	/obj/effect/mob_spawn/human/corpse/damaged/legioninfested = 25
	))

/obj/structure/spawner/burrow
	name = "burrow entrance"
	desc = "A hole in the ground, filled with fauna ready to defend it."
	max_integrity = 250
	faction = list("mining")
	max_mobs = 3

/obj/structure/spawner/burrow/Initialize()
	. = ..()
	clear_rock()

/**
 * Clears rocks around the spawner when it is created
 *
 */
/obj/structure/spawner/burrow/proc/clear_rock()
	for(var/turf/F in RANGE_TURFS(2, src))
		if(abs(src.x - F.x) + abs(src.y - F.y) > 3)
			continue
		if(ismineralturf(F))
			var/turf/closed/mineral/M = F
			M.ScrapeAway(null, CHANGETURF_IGNORE_AIR)

/obj/structure/spawner/burrow/deconstruct(disassembled)
	destroy_effect()
	drop_loot()
	return ..()

/**
 * Effects and messages created when the spawner is destroyed
 *
 */
/obj/structure/spawner/burrow/proc/destroy_effect()
	playsound(loc,'sound/effects/explosionfar.ogg', 200, TRUE)
	visible_message("<span class='boldannounce'>[src] collapses, sealing everything inside!</span>\n<span class='warning'>Ores fall out of the burrow as it is destroyed!</span>")

/**
 * Drops items after the spawner is destroyed
 *
 */
/obj/structure/spawner/burrow/proc/drop_loot()
	for(var/type in GLOB.ore_probability)
		var/chance = GLOB.ore_probability[type]
		if(!prob(chance))
			continue
		new type(loc, rand(5, 10))

/obj/structure/spawner/burrow/lava_planet
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 27,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 26,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/nest = 26,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing = 1
	)

/obj/structure/spawner/burrow/sand_planet
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 40,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 20
	)

/obj/structure/spawner/burrow/ice_planet
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf,
		/mob/living/simple_animal/hostile/asteroid/polarbear
	)

/obj/structure/spawner/burrow/ice_planet/hard
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 35,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow/nest = 35,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp = 15,
		/mob/living/simple_animal/hostile/asteroid/ice_demon = 15
	)

/obj/structure/spawner/burrow/jungle_planet
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf/random,
		/mob/living/simple_animal/hostile/retaliate/bat,
		/mob/living/simple_animal/hostile/retaliate/poison/snake
	)

/obj/structure/spawner/burrow/rock_plant
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet
	)

/obj/structure/spawner/burrow/asteroid
	mob_types = list (
		/mob/living/simple_animal/hostile/asteroid/goliath,
		/mob/living/simple_animal/hostile/asteroid/hivelord,
		/mob/living/simple_animal/hostile/carp
	)
