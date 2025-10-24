GLOBAL_LIST_EMPTY(ore_veins)

/obj/structure/vein
	name = "ore vein"
	desc = "A mostly subsurface ore deposit."
	icon = 'icons/obj/lavaland/terrain.dmi'
	icon_state = "geyser"
	anchored = TRUE
	layer = LOW_ITEM_LAYER
	move_resist = INFINITY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	//Whether the mining scanner is able to locate this vein.
	var/detectable = TRUE
	var/mining_charges = 6
	//Classification of the quality of possible ores within a vein
	//Used to determine difficulty & ore amounts
	//Intended to range from class one to class three. Class four exists as a mission landmark
	var/vein_class = 1
	//A weighted list of all possible ores that can generate in a vein
	//The design process is that class 1 veins have a small chance of generating with class 2 ores and so on
	//As higher class veins will be increasingly harder to mine
	var/list/ore_list = list(
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/plasma = 20,
		)
	//The post initialize list of all possible drops from the vein
	//Meant to be player facing in the form of mining scanners
	//Contents won't be randomized if the list isn't empty on initialize
	var/list/vein_contents = list()
	//Allows subtyped veins to determine how long it takes to mine one mining charge
	var/mine_time_multiplier = 1
	//Allows subtyped veins to determine how much loot is dropped per drop_ore call
	var/drop_rate_amount_min = 15
	var/drop_rate_amount_max = 20
	///variables for the mob spawners we generate
	var/max_mobs = 3
	var/spawn_time = 10 SECONDS
	var/mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		)
	var/spawn_text = "emerges from"
	var/faction = list(FACTION_HOSTILE, FACTION_MINING)
	var/spawn_sound = list('sound/effects/break_stone.ogg')
	var/spawner_type = /datum/component/spawner

	///how away from the source can mob spawners create something
	var/spawner_distance_min = 0
	var/spawner_distance_max = 1


	var/currently_spawning = FALSE

	///how far away can we create mob_spawners?
	var/spawn_distance_min = 4
	var/spawn_distance_max = 6


	///a list of currently active spawners created by the vein. Used to keep us from going insane when we turn them on / off
	var/list/active_spawners = list()

	///how many waves are you expected to endure before a break
	var/waves_per_break = 3
	///what consequetive wave are we on? Non-consequetive waves reset this tally
	var/wave_tally = 0
	///how long will our spawners create mobs for?
	var/wave_length = 45 SECONDS
	///how long is our break after we do enough waves?
	var/wave_downtime = 1 MINUTES

	///var for a timer
	var/wave_timer
	//ditto
	var/wave_end_cooldown

	///the drill currently digging us
	var/obj/machinery/drill/our_drill

//Generates amount of ore able to be pulled from the vein (mining_charges) and types of ore within it (vein_contents)
/obj/structure/vein/Initialize()
	. = ..()
	var/ore_type_amount
	mining_charges = rand(round(mining_charges - 2),mining_charges + 2)
	if(!LAZYLEN(vein_contents))
		switch(vein_class)
			if(1)
				ore_type_amount = rand(2,6)
			if(2)
				ore_type_amount = rand(6,10)
			if(3)
				ore_type_amount = rand(8,14)
			if(4)
				ore_type_amount = rand(10,18)
			else
				ore_type_amount = 1
		for(var/ore_count in 1 to ore_type_amount)
			var/picked = pick_weight(ore_list)
			vein_contents.Add(picked)
			ore_list.Remove(picked)
			if(!LAZYLEN(ore_list))
				break
	GLOB.ore_veins += src

/obj/structure/vein/examine(mob/user)
	. = ..()
	if(!detectable)
		. += span_notice("This vein has been marked as a site of no interest, and will not show up on deep core scans.")

/obj/structure/vein/Destroy()
	destroy_effect()
	GLOB.ore_veins -= src
	return ..()

/obj/structure/vein/proc/begin_spawning()
	currently_spawning = TRUE
	START_PROCESSING(SSprocessing, src)

/obj/structure/vein/proc/stop_spawning()
	if(currently_spawning)
		currently_spawning = FALSE
		STOP_PROCESSING(SSprocessing, src)
		COOLDOWN_RESET(src, wave_timer)
		return FALSE
	return TRUE

/obj/structure/vein/process(seconds_per_tick)
	if(!currently_spawning)
		return
	try_spawning_spawner()

/obj/structure/vein/proc/try_spawning_spawner()
	if(!COOLDOWN_FINISHED(src, wave_timer))
		return
	COOLDOWN_START(src, wave_timer, wave_length)
	if(!increment_wave_tally())
		return FALSE
	var/breaches_to_spawn = clamp(vein_class, 1, vein_class - length(active_spawners))
	for(var/mob_index in 1 to breaches_to_spawn)
		if(length(active_spawners) >= vein_class)
			return

		var/turf/open/spawning_tile = pick_tile()

		var/obj/effect/drill_spawner/bug_breach = new /obj/effect/drill_spawner(spawning_tile)
		active_spawners += bug_breach
		bug_breach.our_vein = src
		bug_breach.AddComponent(spawner_type, mob_types, spawn_time, faction, spawn_text, max_mobs, spawn_sound, spawner_distance_min, spawner_distance_max)
		bug_breach.start_death_timer(wave_length - 5 SECONDS)

/obj/structure/vein/proc/pick_tile(list/peel)
	if(!length(peel))
		peel = turf_peel(spawn_distance_max, spawn_distance_min, src, TRUE)
	var/turf/open/spawning_tile
	if(length(peel))
		spawning_tile = pick(peel)
	else
		spawning_tile = pick(circleviewturfs(loc, spawn_distance_max))
	if(istype(spawning_tile, /turf/closed))
		return pick_tile(peel)
	for(var/obj/object in spawning_tile.contents)
		if(object.density || istype(object, /obj/effect/drill_spawner))
			return pick_tile(peel)
	return spawning_tile

/obj/structure/vein/proc/increment_wave_tally()
	if(!our_drill || !our_drill.active)
		wave_tally = 0
		return TRUE
	wave_tally += 1
	if(wave_tally > waves_per_break)
		wave_tally = 0
		our_drill.say("Seismic disturbances subsiding. Estimated return in [time2text(wave_downtime, "mm:ss")].")
		return FALSE
	return TRUE


//Pulls a random ore from the vein list per vein_class
/obj/structure/vein/proc/drop_ore(multiplier,obj/machinery/drill/current)
	var/list/adjacent_turfs = get_adjacent_open_turfs(current)
	var/drop_location = src.loc //Backup in case we can't find an adjacent turf
	if(adjacent_turfs.len)
		drop_location = pick(adjacent_turfs)
	for(var/vein_content_count in 1 to vein_class)
		var/picked = pick(vein_contents)
		new picked(drop_location,round(rand(drop_rate_amount_min,drop_rate_amount_max)*multiplier))

/obj/structure/vein/proc/destroy_effect()
	playsound(loc,'sound/effects/explosionfar.ogg', 200, TRUE)
	visible_message(span_boldannounce("[src] collapses!"))

//
//	Planetary and Class Subtypes
//	The current set of subtypes are heavily subject to future balancing and reworking as the balance of them is tested more
//

//lavaland veins, same as basetype
/obj/structure/vein/lavaland
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		)

/obj/structure/vein/lavaland/classtwo
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/gold = 1,
		)
	max_mobs = 2
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 1,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf/nest = 5,
		)

/obj/structure/vein/lavaland/classtwo/rare
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/gold = 20,
		/obj/item/stack/ore/diamond = 5,
		/obj/item/stack/ore/bluespace_crystal = 5
		)

/obj/structure/vein/lavaland/classthree
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/iron = 6,
		/obj/item/stack/ore/plasma = 6,
		/obj/item/stack/ore/gold = 1,
		)
	max_mobs = 3 //Best not to go past 6 due to balance and lag reasons
	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 5,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf/nest = 10,
		)

/obj/structure/vein/lavaland/classthree/rare
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/diamond = 8,
		/obj/item/stack/ore/bluespace_crystal = 5,
		)

// TODO: populate all planet veins with class 4s ; this exact path should not be used, used as a templa
/obj/structure/vein/classfour
	mining_charges = 30
	vein_class = 4
//
// Ice planets

/obj/structure/vein/ice
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf = 40,
		/mob/living/basic/bear/polar = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/ice_demon = 5,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp = 1,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity = 25,
	)
	//Ice planets earn a slightly higher rare ore chance on account of them being notably harder
	//Alongside being a much more reliable source of plasma
	ore_list = list(
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/titanium = 15,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/silver = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/ice = 7,
		)

/obj/structure/vein/ice/classtwo
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/iron = 15,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/silver = 10,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/ice = 8,
		)
	max_mobs = 6
	spawn_time = 10 SECONDS

/obj/structure/vein/ice/classtwo/rare
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/ice = 10,
		)

/obj/structure/vein/ice/classthree
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/iron = 2,
		/obj/item/stack/ore/gold = 2,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/silver = 5,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/ice = 8,
		)
	max_mobs = 6
	spawn_time = 8 SECONDS

/obj/structure/vein/ice/classthree/rare
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/ice = 10,
		)

/obj/structure/vein/ice/classfour
	mining_charges = 30
	vein_class = 4
	ore_list = list(
		/obj/item/stack/ore/iron = 2,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/silver = 5,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/bluespace_crystal = 4,
		/obj/item/stack/ore/ice = 8,
		)
	max_mobs = 6
	spawn_time = 8 SECONDS
//Jungle

/obj/structure/vein/jungle
	// class 1 has easy mobs, the ones you find on the surface
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf/random = 50,
		/mob/living/basic/bear/cave = 30,
		/mob/living/simple_animal/hostile/poison/giant_spider = 5,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 1,
	)

	ore_list = list(
		/obj/item/stack/ore/iron = 50,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 15,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/titanium = 1,
		)

/obj/structure/vein/jungle/classtwo
	mining_charges = 8
	vein_class = 2
	//We then start to introduce the unused jungle mobs... slowly.
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf/random = 75,
		/mob/living/basic/bear/cave = 60,
		/mob/living/simple_animal/hostile/poison/giant_spider = 45,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 20,
		/mob/living/simple_animal/hostile/jungle/seedling = 1,
		/mob/living/simple_animal/hostile/jungle/mega_arachnid = 1,
		/mob/living/simple_animal/hostile/jungle/mook = 1,
	)
	ore_list = list(
		/obj/item/stack/ore/iron = 50,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/titanium = 4,
		)
	max_mobs = 2
	spawn_time = 15 SECONDS

/obj/structure/vein/jungle/classtwo/rare
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/diamond = 5,
		)

/obj/structure/vein/jungle/classthree
	mining_charges = 10
	vein_class = 3
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf/random = 20,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 1,
		/mob/living/simple_animal/hostile/jungle/seedling = 5,
		/mob/living/simple_animal/hostile/jungle/mega_arachnid = 20,
		/mob/living/simple_animal/hostile/jungle/mook = 30,
	)
	ore_list = list(
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 10,
		/obj/item/stack/ore/titanium = 4,
		)
	//jungle mobs are kind of fucking hard, less max
	max_mobs = 3
	spawn_time = 10 SECONDS

/obj/structure/vein/jungle/classthree/rare
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/diamond = 10,
		)

//Sand planets - more or less the same as lavaland but with the sand planet variants

/obj/structure/vein/sand
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 30,
		)

	ore_list = list(
		/obj/item/stack/ore/iron = 45,
		/obj/item/stack/ore/titanium = 20,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/uranium = 1,
		)

/obj/structure/vein/sand/classtwo
	mining_charges = 8
	vein_class = 2
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 30,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/heat = 10,
		)

	ore_list = list(
		/obj/item/stack/ore/iron = 35,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/uranium = 4,
		)
	max_mobs = 6
	spawn_time = 10 SECONDS

/obj/structure/vein/sand/classtwo/rare
	mining_charges = 12
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/diamond = 2,
		)

/obj/structure/vein/sand/classthree
	mining_charges = 10
	vein_class = 3

	ore_list = list(
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/uranium = 6,
		)

	max_mobs = 6
	spawn_time = 8 SECONDS

/obj/structure/vein/sand/classthree/rare
	mining_charges = 14
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/diamond = 4,
		)

// rockplanet

/obj/structure/vein/rockplanet
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 20,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 30,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 10,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 10,
		)

	ore_list = list(
		/obj/item/stack/ore/iron = 80,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/gold = 4,
		)

/obj/structure/vein/rockplanet/classtwo
	mining_charges = 8
	vein_class = 2
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 50,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 30,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 5,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 5,
		)

	ore_list = list(
		/obj/item/stack/ore/iron = 60,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/gold = 4,
		)

	max_mobs = 3
	spawn_time = 10 SECONDS

/obj/structure/vein/rockplanet/classthree
	mining_charges = 10
	vein_class = 3

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 50,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 40,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 5,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 5,
		/mob/living/simple_animal/hostile/asteroid/fugu/asteroid = 5,
		)

	ore_list = list(
		/obj/item/stack/ore/iron = 30,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/gold = 6,
		)

	max_mobs = 3
	spawn_time = 8 SECONDS

/obj/structure/vein/rockplanet/classfour
	mining_charges = 30
	vein_class = 4

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 50,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 40,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 5,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 5,
		/mob/living/simple_animal/hostile/asteroid/fugu/asteroid = 5,
		)

	ore_list = list(
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/gold = 3,
		)

//moons, have a dupe of asteroid but less of an emphasis on  goliaths

/obj/structure/vein/moon
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 5,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20,
		)

	ore_list = list(
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/titanium = 20,
		/obj/item/stack/ore/gold = 2,
		/obj/item/stack/ore/uranium = 2,
		)

/obj/structure/vein/moon/classtwo
	mining_charges = 8
	vein_class = 2
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 10,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 15,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 1
		)

	ore_list = list(
		/obj/item/stack/ore/iron = 30,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/uranium = 5,
		)
	max_mobs = 3
	spawn_time = 10 SECONDS

/obj/structure/vein/moon/classthree
	mining_charges = 10
	vein_class = 3

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 10,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 1
		)
	ore_list = list(
		/obj/item/stack/ore/iron = 15,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/uranium = 7,
		)

	max_mobs = 3
	spawn_time = 8 SECONDS

/obj/structure/vein/moon/classfour
	mining_charges = 15
	vein_class = 4
	drop_rate_amount_min = 30
	drop_rate_amount_max = 40

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 10,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal = 5,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/crystal = 5,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten = 5,
		)
	ore_list = list(
		/obj/item/stack/ore/ice = 10
		)

	max_mobs = 6
	spawn_time = 8 SECONDS

//Desert planets, since they actually have their own mobs we use those

/obj/structure/vein/desert
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/antlion = 100,
		/mob/living/simple_animal/hostile/asteroid/antlion/mega = 10,
		)

	//same surface ore drop rate too...
	ore_list = list(
		/obj/item/stack/ore/gold = 20,
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/diamond = 5,
		/obj/item/stack/ore/titanium = 4,
		)

/obj/structure/vein/desert/classtwo
	mining_charges = 8
	vein_class = 2
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/antlion = 70,
		/mob/living/simple_animal/hostile/asteroid/antlion/mega = 10,
		)

	ore_list = list(
		/obj/item/stack/ore/gold = 30,
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/plasma = 7,
		/obj/item/stack/ore/diamond = 7,
		/obj/item/stack/ore/titanium = 5,
		)
	max_mobs = 3
	spawn_time = 10 SECONDS

/obj/structure/vein/desert/classthree
	mining_charges = 10
	vein_class = 3

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/antlion = 50,
		/mob/living/simple_animal/hostile/asteroid/antlion/mega = 5,
		)

	ore_list = list(
		/obj/item/stack/ore/gold = 15,
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/plasma = 7,
		/obj/item/stack/ore/diamond = 7,
		/obj/item/stack/ore/titanium = 7,
		)

	max_mobs = 3
	spawn_time = 8 SECONDS


//Shrouded planets... There's a reason the surface is so barren...

/obj/structure/vein/shrouded
	mining_charges = 8
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/royalcrab = 50,
		/mob/living/simple_animal/hostile/alien = 5,
		/mob/living/simple_animal/hostile/alien/drone = 5,
		/mob/living/simple_animal/hostile/alien/sentinel = 1,
		)

	//same surface ore drop rate
	ore_list = list(
		/obj/item/stack/ore/uranium = 30,
		/obj/item/stack/ore/plasma = 25,
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/stack/ore/titanium = 6,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/diamond = 1,
		)

	max_mobs = 3
	spawn_time = 5 SECONDS
	///His greed was his downfall
	var/greed_chance = 20

/obj/structure/vein/shrouded/Initialize()
	. = ..()
	if(prob(greed_chance))
		max_mobs = 15

/obj/structure/vein/shrouded/classtwo
	mining_charges = 10
	vein_class = 2
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/royalcrab = 30,
		/mob/living/simple_animal/hostile/alien = 5,
		/mob/living/simple_animal/hostile/alien/drone = 5,
		/mob/living/simple_animal/hostile/alien/sentinel = 1,
		)

	ore_list = list(
		/obj/item/stack/ore/uranium = 20,
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/stack/ore/titanium = 6,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/diamond = 1,
		)

	spawn_time = 8 SECONDS

	greed_chance = 30

/obj/structure/vein/shrouded/classthree
	mining_charges = 12
	vein_class = 3

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/royalcrab = 10,
		/mob/living/simple_animal/hostile/alien = 5,
		/mob/living/simple_animal/hostile/alien/drone = 5,
		/mob/living/simple_animal/hostile/alien/sentinel = 1,
		)

	ore_list = list(
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/stack/ore/titanium = 8,
		/obj/item/stack/ore/gold = 7,
		/obj/item/stack/ore/diamond = 5,
		)

	greed_chance = 40
	spawn_time = 6 SECONDS

// Asteroid veins.

/obj/structure/vein/asteroid
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 60,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20,
		)

	ore_list = list(
		/obj/item/stack/ore/plasma = 40,
		/obj/item/stack/ore/iron = 65,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/bluespace_crystal = 1,
		)

/obj/structure/vein/asteroid/classtwo
	mining_charges = 8
	vein_class = 2

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 60,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 15,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 5
		)

	ore_list = list(
		/obj/item/stack/ore/plasma = 30,
		/obj/item/stack/ore/iron = 55,
		/obj/item/stack/ore/titanium = 7,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/bluespace_crystal = 3,
		)

	max_mobs = 3
	spawn_time = 10 SECONDS

/obj/structure/vein/asteroid/classtwo/rare
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/ice = 10,
		)

/obj/structure/vein/asteroid/classthree
	mining_charges = 10
	vein_class = 3

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 60,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 10
		)

	ore_list = list(
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/iron = 30,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/gold = 7,
		/obj/item/stack/ore/uranium = 7,
		/obj/item/stack/ore/bluespace_crystal = 5,
		)

	max_mobs = 3
	spawn_time = 8 SECONDS

/obj/structure/vein/asteroid/classthree/rare
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/ice = 10,
		)

// Waterplanet veins.

/obj/structure/vein/waterplanet
	mob_types = list(
		/mob/living/basic/bear/cave = 60,
		/mob/living/simple_animal/hostile/carp = 40,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 20,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 10,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 8,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 1,
		)

	ore_list = list(
		/obj/item/stack/ore/plasma = 40,
		/obj/item/stack/ore/iron = 65,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/bluespace_crystal = 1,
		)

/obj/structure/vein/waterplanet/classtwo
	mining_charges = 8
	vein_class = 2

	mob_types = list(
		/mob/living/basic/bear/cave = 50,
		/mob/living/simple_animal/hostile/carp = 30,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 30,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 15,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 10,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 1,
		)

	ore_list = list(
		/obj/item/stack/ore/plasma = 30,
		/obj/item/stack/ore/iron = 55,
		/obj/item/stack/ore/titanium = 7,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/bluespace_crystal = 3,
		)

	max_mobs = 3
	spawn_time = 10 SECONDS

/obj/structure/vein/waterplanet/classthree
	mining_charges = 10
	vein_class = 3

	mob_types = list(
		/mob/living/basic/bear/cave = 10,
		/mob/living/simple_animal/hostile/carp = 20,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 10,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 40,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 25,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 5,
		)

	ore_list = list(
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/iron = 30,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/gold = 7,
		/obj/item/stack/ore/uranium = 7,
		/obj/item/stack/ore/bluespace_crystal = 5,
		)

	max_mobs = 3
	spawn_time = 8 SECONDS

