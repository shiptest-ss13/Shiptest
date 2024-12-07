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
	//Intended to range from class one to class three
	var/vein_class = 1
	//A weighted list of all possible ores that can generate in a vein
	//The design process is that class 1 veins have a small chance of generating with class 2 ores and so on
	//As higher class veins will be increasingly harder to mine
	var/list/ore_list = list(
		/obj/item/stack/ore/sulfur = 40,
		/obj/item/stack/ore/galena = 30,
		/obj/item/stack/ore/sulfur/pyrite = 20,
		/obj/item/stack/ore/magnetite = 20,
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/malachite = 20,
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
	//Mob spawning variables
	var/spawner_attached = FALSE //Probably a drastically less sloppy way of doing this, but it technically works
	var/spawning_started = FALSE
	var/max_mobs = 6
	var/spawn_time = 15 SECONDS
	var/mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		)
	var/spawn_text = "emerges from"
	var/faction = list("hostile","mining")
	var/spawn_sound = list('sound/effects/break_stone.ogg')
	var/spawner_type = /datum/component/spawner
	var/spawn_distance_min = 4
	var/spawn_distance_max = 6
	var/wave_length = 2 MINUTES
	var/wave_downtime = 30 SECONDS


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
			else
				ore_type_amount = 1
		for(var/ore_count in 1 to ore_type_amount)
			var/picked = pick_weight(ore_list)
			vein_contents.Add(picked)
			ore_list.Remove(picked)
	GLOB.ore_veins += src

/obj/structure/vein/examine(mob/user)
	. = ..()
	if(!detectable)
		. += span_notice("This vein has been marked as a site of no interest, and will not show up on deep core scans.")

/obj/structure/vein/Destroy()
	GLOB.ore_veins -= src
	return ..()

/obj/structure/vein/deconstruct(disassembled)
	destroy_effect()
	return..()

/obj/structure/vein/proc/begin_spawning()
	AddComponent(spawner_type, mob_types, spawn_time, faction, spawn_text, max_mobs, spawn_sound, spawn_distance_min, spawn_distance_max, wave_length, wave_downtime)
	spawner_attached = TRUE
	spawning_started = TRUE

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
	visible_message("<span class='boldannounce'>[src] collapses!</span>")

/obj/structure/vein/proc/toggle_spawning()
	spawning_started = SEND_SIGNAL(src, COMSIG_SPAWNER_TOGGLE_SPAWNING, spawning_started)


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
		/obj/item/stack/ore/sulfur = 30,
		/obj/item/stack/ore/galena = 20,
		/obj/item/stack/ore/sulfur/pyrite = 10,
		/obj/item/stack/ore/magnetite = 10,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/malachite = 10,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/gold = 2,
		/obj/item/stack/ore/bluespace_crystal = 1,
		)
	max_mobs = 6
	spawn_time = 100
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 5,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf/nest = 5,
		)

/obj/structure/vein/lavaland/classthree
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/sulfur = 9,
		/obj/item/stack/ore/galena = 9,
		/obj/item/stack/ore/sulfur/pyrite = 4,
		/obj/item/stack/ore/magnetite = 4,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/malachite = 4,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/gold = 2,
		/obj/item/stack/ore/bluespace_crystal = 1,
		)
	max_mobs = 6 //Best not to go past 6 due to balance and lag reasons
	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 10,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf/nest = 10,
		)
// Ice planets
/obj/structure/vein/ice
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf = 40,
		/mob/living/simple_animal/hostile/asteroid/polarbear = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/ice_demon = 5,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp = 1,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity = 25,
	)
	//Ice planets earn a slightly higher rare ore chance on account of them being notably harder
	//Alongside being a much more reliable source of plasma
	ore_list = list(
		/obj/item/stack/ore/malachite = 40,
		/obj/item/stack/ore/quartzite = 30,
		/obj/item/stack/ore/hematite = 20,
		/obj/item/stack/ore/gold = 20,
		/obj/item/stack/ore/rutile = 15,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/proustite = 10,
		/obj/item/stack/ore/autunite = 10,
		/obj/item/stack/ore/galena = 1,
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/ice = 7,
		)

/obj/structure/vein/ice/classtwo
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/malachite = 20,
		/obj/item/stack/ore/quartzite = 10,
		/obj/item/stack/ore/hematite = 10,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/rutile = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/proustite = 5,
		/obj/item/stack/ore/autunite = 5,
		/obj/item/stack/ore/galena = 3,
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/ice = 8,
		)
	max_mobs = 6
	spawn_time = 10 SECONDS

/obj/structure/vein/ice/classthree
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/malachite = 10,
		/obj/item/stack/ore/quartzite = 5,
		/obj/item/stack/ore/hematite = 2,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/rutile = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/proustite = 5,
		/obj/item/stack/ore/autunite = 5,
		/obj/item/stack/ore/galena = 6,
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
		/mob/living/simple_animal/hostile/bear/cave = 30,
		/mob/living/simple_animal/hostile/poison/giant_spider = 5,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 1,
	)

	//same surface ore drop rate too...
	ore_list = list(
		/obj/item/stack/ore/graphite/coal = 60,
		/obj/item/stack/ore/malachite = 50,
		/obj/item/stack/ore/sulfur = 40,
		/obj/item/stack/ore/gold = 30,
		/obj/item/stack/ore/proustite = 20,
		/obj/item/stack/ore/diamond = 10,
		/obj/item/stack/ore/galena = 1,
		/obj/item/stack/ore/rutile = 1,
		)

/obj/structure/vein/jungle/classtwo
	mining_charges = 8
	vein_class = 2
	//We then start to introduce the unused jungle mobs... slowly.
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf/random = 65,
		/mob/living/simple_animal/hostile/bear/cave = 50,
		/mob/living/simple_animal/hostile/poison/giant_spider = 25,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 10,
		/mob/living/simple_animal/hostile/jungle/seedling = 1,
		/mob/living/simple_animal/hostile/jungle/mega_arachnid = 1,
		/mob/living/simple_animal/hostile/jungle/mook = 1,
		/mob/living/simple_animal/hostile/jungle/leaper = 1,
	)
	ore_list = list(
		/obj/item/stack/ore/graphite/coal = 50,
		/obj/item/stack/ore/malachite = 40,
		/obj/item/stack/ore/sulfur = 30,
		/obj/item/stack/ore/gold = 20,
		/obj/item/stack/ore/proustite = 10,
		/obj/item/stack/ore/diamond = 10,
		/obj/item/stack/ore/galena = 4,
		/obj/item/stack/ore/rutile = 4,
		)
	max_mobs = 6
	spawn_time = 15 SECONDS

/obj/structure/vein/jungle/classthree
	mining_charges = 10
	vein_class = 3
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf/random = 20,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 1,
		/mob/living/simple_animal/hostile/jungle/seedling = 5,
		/mob/living/simple_animal/hostile/jungle/mega_arachnid = 20,
		/mob/living/simple_animal/hostile/jungle/mook = 30,
		/mob/living/simple_animal/hostile/jungle/leaper = 10,
	)
	ore_list = list(
		/obj/item/stack/ore/graphite/coal = 20,
		/obj/item/stack/ore/malachite = 20,
		/obj/item/stack/ore/sulfur = 20,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/proustite = 10,
		/obj/item/stack/ore/diamond = 10,
		/obj/item/stack/ore/galena = 6,
		/obj/item/stack/ore/rutile = 4,
		)
	//jungle mobs are kind of fucking hard, less max
	max_mobs = 4
	spawn_time = 10 SECONDS

//Sand planets - more or less the same as lavaland but with the sand planet variants

/obj/structure/vein/sand
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 30,
		)

	ore_list = list(
		/obj/item/stack/ore/quartzite = 50,
		/obj/item/stack/ore/hematite = 45,
		/obj/item/stack/ore/rutile = 20,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/sulfur/pyrite = 10,
		/obj/item/stack/ore/galena = 10,
		/obj/item/stack/ore/autunite = 1,
		/obj/item/stack/ore/diamond = 1,
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
		/obj/item/stack/ore/quartzite = 40,
		/obj/item/stack/ore/hematite = 35,
		/obj/item/stack/ore/rutile = 10,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/sulfur/pyrite = 5,
		/obj/item/stack/ore/galena = 5,
		/obj/item/stack/ore/autunite = 4,
		/obj/item/stack/ore/diamond = 4,
		)
	max_mobs = 6
	spawn_time = 10 SECONDS

/obj/structure/vein/sand/classthree
	mining_charges = 10
	vein_class = 3

	ore_list = list(
		/obj/item/stack/ore/quartzite = 15,
		/obj/item/stack/ore/hematite = 10,
		/obj/item/stack/ore/rutile = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/sulfur/pyrite = 5,
		/obj/item/stack/ore/galena = 5,
		/obj/item/stack/ore/autunite = 6,
		/obj/item/stack/ore/diamond = 6,
		)

	max_mobs = 6
	spawn_time = 8 SECONDS

// rockplanet

/obj/structure/vein/rockplanet
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 20,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 30,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 10,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 10,
		)

	ore_list = list(
		/obj/item/stack/ore/hematite = 80,
		/obj/item/stack/ore/sulfur = 25,
		/obj/item/stack/ore/malachite = 20,
		/obj/item/stack/ore/galena = 10,
		/obj/item/stack/ore/graphite = 10,
		/obj/item/stack/ore/autunite = 5,
		/obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/bluespace_crystal = 1,
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
		/obj/item/stack/ore/hematite = 60,
		/obj/item/stack/ore/sulfur = 15,
		/obj/item/stack/ore/malachite = 10,
		/obj/item/stack/ore/galena = 5,
		/obj/item/stack/ore/graphite = 5,
		/obj/item/stack/ore/autunite = 5,
		/obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/bluespace_crystal = 1,
		)

	max_mobs = 6
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
		/obj/item/stack/ore/hematite = 20,
		/obj/item/stack/ore/sulfur = 10,
		/obj/item/stack/ore/malachite = 5,
		/obj/item/stack/ore/galena = 5,
		/obj/item/stack/ore/graphite = 5,
		/obj/item/stack/ore/autunite = 5,
		/obj/item/stack/ore/gold = 6,
		/obj/item/stack/ore/diamond = 5,
		/obj/item/stack/ore/bluespace_crystal = 4,
		)

	max_mobs = 6
	spawn_time = 8 SECONDS

//wasteplanet
/obj/structure/vein/waste
	// class 1 has easy mobs, the ones you find on the surface
	mob_types = list(
		//hivebots, not too difficult
		/mob/living/simple_animal/hostile/hivebot/strong = 20,
		/mob/living/simple_animal/hostile/hivebot/ranged = 40,
		/mob/living/simple_animal/hostile/hivebot/ranged/rapid = 30,
		//bots, are hostile
		/mob/living/simple_animal/bot/firebot/rockplanet = 15,
		/mob/living/simple_animal/hostile/abandoned_minebot = 15,
		)

	//same surface ore drop rate too...
	ore_list = list(
		/obj/item/stack/ore/sulfur = 45,
		/obj/item/stack/ore/hematite = 40,
		/obj/item/stack/ore/plasma = 35,
		/obj/item/stack/ore/autunite = 30,
		/obj/item/stack/ore/galena = 30,
		/obj/item/stack/ore/malachite = 20,

		/obj/item/stack/ore/graphite = 2,
		/obj/item/stack/ore/proustite = 5,
		/obj/item/stack/ore/gold = 4,
		)

/obj/structure/vein/waste/classtwo
	mining_charges = 8
	vein_class = 2
	mob_types = list( //nor organics, more biased towards hivebots though
		/mob/living/simple_animal/hostile/hivebot/strong = 20,
		/mob/living/simple_animal/hostile/hivebot/ranged = 50,
		/mob/living/simple_animal/hostile/hivebot/ranged/rapid = 50,
		/mob/living/simple_animal/bot/firebot/rockplanet = 15,
		/mob/living/simple_animal/bot/secbot/ed209/rockplanet = 1,
		/mob/living/simple_animal/hostile/abandoned_minebot = 15,
		/mob/living/simple_animal/bot/floorbot/rockplanet = 15,
		/obj/structure/spawner/hivebot = 20
	)
	ore_list = list(
		/obj/item/stack/ore/sulfur = 35,
		/obj/item/stack/ore/hematite = 30,
		/obj/item/stack/ore/plasma = 25,
		/obj/item/stack/ore/autunite = 20,
		/obj/item/stack/ore/galena = 20,
		/obj/item/stack/ore/malachite = 10,

		/obj/item/stack/ore/graphite = 5,
		/obj/item/stack/ore/proustite = 10,
		/obj/item/stack/ore/gold = 8,
		/obj/item/stack/ore/diamond = 1,
		)
	//seeing as hivebots die in 1-2 hits from pistols we spawn more
	max_mobs = 7
	spawn_time = 10 SECONDS

/obj/structure/vein/waste/classthree
	mining_charges = 10
	vein_class = 3

	mob_types = list( //Whoops! All hivebots!
		/mob/living/simple_animal/hostile/hivebot/strong = 20,
		/mob/living/simple_animal/hostile/hivebot/ranged = 40,
		/mob/living/simple_animal/hostile/hivebot/ranged/rapid = 20,
		/mob/living/simple_animal/hostile/hivebot = 20,
		/mob/living/simple_animal/hostile/hivebot/defender = 1
	)
	ore_list = list(
		/obj/item/stack/ore/sulfur = 20,
		/obj/item/stack/ore/hematite = 15,
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/autunite = 10,
		/obj/item/stack/ore/galena = 10,
		/obj/item/stack/ore/malachite = 10,

		/obj/item/stack/ore/graphite = 7,
		/obj/item/stack/ore/proustite = 10,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/diamond = 5,
		)
	//ditto
	max_mobs = 7
	spawn_time = 8 SECONDS

//moons, have a dupe of asteroid but less of an emphasis on  goliaths

/obj/structure/vein/moon
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 5,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20,
		)

	//same surface ore drop rate too...
	ore_list = list(
		/obj/item/stack/ore/quartzite = 80,
		/obj/item/stack/ore/hematite = 40,
		/obj/item/stack/ore/rutile = 20,
		/obj/item/stack/ore/bluespace_crystal = 5,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/autunite = 2,
		/obj/item/stack/ore/galena = 2,
		/obj/item/stack/ore/diamond = 1,
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
		/obj/item/stack/ore/quartzite = 60,
		/obj/item/stack/ore/hematite = 30,
		/obj/item/stack/ore/rutile = 10,
		/obj/item/stack/ore/bluespace_crystal = 7,
		/obj/item/stack/ore/gold = 7,
		/obj/item/stack/ore/autunite = 5,
		/obj/item/stack/ore/galena = 5,
		/obj/item/stack/ore/diamond = 2,
		)
	max_mobs = 6
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
		/obj/item/stack/ore/quartzite = 20,
		/obj/item/stack/ore/hematite = 15,
		/obj/item/stack/ore/rutile = 10,
		/obj/item/stack/ore/bluespace_crystal = 7,
		/obj/item/stack/ore/gold = 7,
		/obj/item/stack/ore/autunite = 7,
		/obj/item/stack/ore/galena = 7,
		/obj/item/stack/ore/diamond = 5,
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
		/obj/item/stack/ore/graphite/coal = 60,
		/obj/item/stack/ore/sulfur = 40,
		/obj/item/stack/ore/quartzite = 40,
		/obj/item/stack/ore/gold = 20,
		/obj/item/stack/ore/hematite = 20,
		/obj/item/stack/ore/autunite = 10,
		/obj/item/stack/ore/galena = 7,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/diamond = 5,
		/obj/item/stack/ore/malachite = 5,
		/obj/item/stack/ore/rutile = 4,
		)

/obj/structure/vein/desert/classtwo
	mining_charges = 8
	vein_class = 2
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/antlion = 70,
		/mob/living/simple_animal/hostile/asteroid/antlion/mega = 10,
		)

	ore_list = list(
		/obj/item/stack/ore/graphite/coal = 40,
		/obj/item/stack/ore/sulfur = 30,
		/obj/item/stack/ore/quartzite = 30,
		/obj/item/stack/ore/gold = 30,
		/obj/item/stack/ore/hematite = 10,
		/obj/item/stack/ore/autunite = 10,
		/obj/item/stack/ore/galena = 8,
		/obj/item/stack/ore/plasma = 7,
		/obj/item/stack/ore/diamond = 7,
		/obj/item/stack/ore/malachite = 7,
		/obj/item/stack/ore/rutile = 5,
		)
	max_mobs = 6
	spawn_time = 10 SECONDS

/obj/structure/vein/desert/classthree
	mining_charges = 10
	vein_class = 3

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/antlion = 50,
		/mob/living/simple_animal/hostile/asteroid/antlion/mega = 5,
		)

	ore_list = list(
		/obj/item/stack/ore/graphite/coal = 20,
		/obj/item/stack/ore/sulfur = 15,
		/obj/item/stack/ore/quartzite = 15,
		/obj/item/stack/ore/gold = 15,
		/obj/item/stack/ore/hematite = 10,
		/obj/item/stack/ore/autunite = 10,
		/obj/item/stack/ore/galena = 10,
		/obj/item/stack/ore/plasma = 7,
		/obj/item/stack/ore/diamond = 7,
		/obj/item/stack/ore/malachite = 7,
		/obj/item/stack/ore/rutile = 7,
		)

	max_mobs = 6
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
		/obj/item/stack/ore/autunite = 30,
		/obj/item/stack/ore/plasma = 25,
		/obj/item/stack/ore/magnetite = 20,
		/obj/item/stack/ore/galena = 12,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/stack/ore/rutile = 6,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/quartzite = 5,
		/obj/item/stack/ore/diamond = 1,
		)

	max_mobs = -1
	spawn_time = 5 SECONDS
	///His greed was his downfall
	var/greed_chance = 10

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
		/obj/item/stack/ore/autunite = 20,
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/magnetite = 10,
		/obj/item/stack/ore/galena = 10,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/stack/ore/rutile = 6,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/quartzite = 5,
		/obj/item/stack/ore/diamond = 1,
		)

	spawn_time = 4 SECONDS

	greed_chance = 20

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
		/obj/item/stack/ore/autunite = 10,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/magnetite = 10,
		/obj/item/stack/ore/galena = 10,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/stack/ore/rutile = 8,
		/obj/item/stack/ore/gold = 7,
		/obj/item/stack/ore/quartzite = 7,
		/obj/item/stack/ore/diamond = 5,
		)

	greed_chance = 25
	spawn_time = 3 SECONDS

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
		/obj/item/stack/ore/hematite = 65,
		/obj/item/stack/ore/malachite = 50,
		/obj/item/stack/ore/sulfur = 5,
		/obj/item/stack/ore/rutile = 5,
		/obj/item/stack/ore/galena = 4,
		/obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/autunite = 3,
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
		/obj/item/stack/ore/hematite = 55,
		/obj/item/stack/ore/malachite = 40,
		/obj/item/stack/ore/sulfur = 7,
		/obj/item/stack/ore/rutile = 7,
		/obj/item/stack/ore/galena = 5,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/autunite = 5,
		/obj/item/stack/ore/bluespace_crystal = 3,
		)

	max_mobs = 6
	spawn_time = 10 SECONDS

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
		/obj/item/stack/ore/hematite = 30,
		/obj/item/stack/ore/malachite = 25,
		/obj/item/stack/ore/sulfur = 10,
		/obj/item/stack/ore/rutile = 10,
		/obj/item/stack/ore/galena = 7,
		/obj/item/stack/ore/gold = 7,
		/obj/item/stack/ore/autunite = 7,
		/obj/item/stack/ore/bluespace_crystal = 5,
		)

	max_mobs = 6
	spawn_time = 8 SECONDS


// Waterplanet veins.

/obj/structure/vein/waterplanet
	mob_types = list(
		/mob/living/simple_animal/hostile/bear/cave = 60,
		/mob/living/simple_animal/hostile/carp = 40,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 20,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 10,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 8,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 1,
		)

	ore_list = list(
		/obj/item/stack/ore/plasma = 40,
		/obj/item/stack/ore/hematite = 65,
		/obj/item/stack/ore/malachite = 50,
		/obj/item/stack/ore/sulfur = 5,
		/obj/item/stack/ore/rutile = 5,
		/obj/item/stack/ore/galena = 4,
		/obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/autunite = 3,
		/obj/item/stack/ore/bluespace_crystal = 1,
		)

/obj/structure/vein/waterplanet/classtwo
	mining_charges = 8
	vein_class = 2

	mob_types = list(
		/mob/living/simple_animal/hostile/bear/cave = 50,
		/mob/living/simple_animal/hostile/carp = 30,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 30,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 15,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 10,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 1,
		)

	ore_list = list(
		/obj/item/stack/ore/plasma = 30,
		/obj/item/stack/ore/hematite = 55,
		/obj/item/stack/ore/malachite = 40,
		/obj/item/stack/ore/sulfur = 7,
		/obj/item/stack/ore/rutile = 7,
		/obj/item/stack/ore/galena = 5,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/autunite = 5,
		/obj/item/stack/ore/bluespace_crystal = 3,
		)

	max_mobs = 6
	spawn_time = 10 SECONDS

/obj/structure/vein/waterplanet/classthree
	mining_charges = 10
	vein_class = 3

	mob_types = list(
		/mob/living/simple_animal/hostile/bear/cave = 10,
		/mob/living/simple_animal/hostile/carp = 20,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 10,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 40,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 25,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 5,
		)

	ore_list = list(
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/hematite = 30,
		/obj/item/stack/ore/malachite = 25,
		/obj/item/stack/ore/sulfur = 10,
		/obj/item/stack/ore/rutile = 10,
		/obj/item/stack/ore/galena = 7,
		/obj/item/stack/ore/gold = 7,
		/obj/item/stack/ore/autunite = 7,
		/obj/item/stack/ore/bluespace_crystal = 5,
		)

	max_mobs = 6
	spawn_time = 8 SECONDS

