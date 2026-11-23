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

	// SCANNING //
	var/detectable = TRUE // can a mining scanner locate this vein?

	// ORE SPAWNING //
	var/mining_charges = 6 // how many ore lodes we have
	var/mining_charge_variance = 2 // how much to vary lodes by on init, + or - base
	var/vein_class = 1 // difficulty class - 1 to 4, with 4 being setpiece-only. determines number of spawns and ore yields
	var/list/ore_list = list( // weighted list of ores to pick to spawn in a vein
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/plasma = 20)
	var/list/vein_contents = list() // rolled vein contents
	var/drop_rate_amount_min = 15 // minimum amount of a rolled ore we drop
	var/drop_rate_amount_max = 20 // maximum amount of a rolled ore we drop
	var/ore_types_min = 1 // minimum number of types of ores we can roll
	var/ore_types_max = 1 // maximum number of types of ores we can roll

	// MOB SPAWNING //
	var/max_mobs = 3 // how many mobs EACH spawner is allowed to have out at once. setting this higher than 6 causes lag and balance problems so don't.
	var/spawn_time = 10 SECONDS // time between spawns
	var/mob_types = list( // weighted list of mobs to roll from
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20)
	var/spawn_text = "emerges from" // text for spawn message
	var/faction = list(FACTION_HOSTILE, FACTION_MINING) // factions spawned mobs have
	var/spawn_sound = list('sound/effects/break_stone.ogg') // sound for spawning
	var/spawner_type = /datum/component/spawner // type of component to put on spawners

	var/spawner_distance_min = 0 // min distance a spawner can place a mob
	var/spawner_distance_max = 1 // max distance a spawner can place a mob
	var/spawn_distance_min = 4 // minimum distance a vein can place a spawner
	var/spawn_distance_max = 6 // maximum distance a vein can place a spawner

	var/currently_spawning = FALSE // are we currently spawning mobs?
	var/list/active_spawners = list() // list containing our active spawners

	var/waves_per_break = 3 // how many waves do we get before a break?
	var/wave_tally = 0 // how far we are into our current set of waves
	var/wave_length = 45 SECONDS // length of a spawning wave
	var/wave_downtime = 1 MINUTES // length of break between waves

	var/wave_timer // var for our wave timer
	var/mine_time_multiplier = 1 // global mult on dig time
	var/obj/machinery/drill/our_drill // what drill is digging us


//Generates amount of ore able to be pulled from the vein (mining_charges) and types of ore within it (vein_contents)
/obj/structure/vein/Initialize()
	. = ..()
	var/ore_type_amount
	mining_charges = rand(round(mining_charges - mining_charge_variance),mining_charges + mining_charge_variance)
	if(!LAZYLEN(vein_contents))
		ore_type_amount = rand(ore_types_min, ore_types_max)
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
		bug_breach.AddComponent(spawner_type, mob_types, spawn_time, faction, spawn_text, max_mobs, spawn_sound, spawner_distance_min, spawner_distance_max, wave_downtime)
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
		new picked(drop_location,round(rand(drop_rate_amount_min,drop_rate_amount_max)*multiplier, 1))

/obj/structure/vein/proc/destroy_effect()
	playsound(loc,'sound/effects/explosionfar.ogg', 200, TRUE)
	visible_message(span_boldannounce("[src] collapses!"))

//
// PLANETARY SUBTYPES //
//

// LAVA-CLASS //
// class 1
/obj/structure/vein/lavaland
	ore_types_max = 2
	ore_list = list(
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/plasma = 20)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20)

// class 2
/obj/structure/vein/lavaland/classtwo
	mining_charges = 8
	vein_class = 2
	ore_types_max = 3
	ore_list = list(
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/gold = 1)

	max_mobs = 2 // let's not get too crazy just yet
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 1,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf/nest = 5)

/obj/structure/vein/lavaland/classtwo/rare
	ore_types_min = 3
	ore_types_max = 4
	ore_list = list(
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/gold = 20,
		/obj/item/stack/ore/diamond = 5,
		/obj/item/stack/ore/bluespace_crystal = 5)

// class 3
/obj/structure/vein/lavaland/classthree
	mining_charges = 10
	vein_class = 3
	ore_types_max = 3
	ore_list = list(
		/obj/item/stack/ore/iron = 6,
		/obj/item/stack/ore/plasma = 6,
		/obj/item/stack/ore/gold = 1)

	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 5,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf/nest = 10)

/obj/structure/vein/lavaland/classthree/rare
	ore_types_min = 3
	ore_types_max = 4
	ore_list = list(
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/diamond = 8,
		/obj/item/stack/ore/bluespace_crystal = 5)

// class 4
/obj/structure/vein/lavaland/classfour
	mining_charges = 30
	vein_class = 4
	ore_list = list(
		/obj/item/stack/ore/bluespace_crystal = 10) // pure bluespace!

	max_mobs = 6 // however
	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 5,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf/nest = 10)

// ICE-CLASS //
// class 1
/obj/structure/vein/ice
	ore_types_min = 3
	ore_types_max = 5
	ore_list = list( // better ore chance, these are harder
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/titanium = 15,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/silver = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/ice = 7)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf = 40,
		/mob/living/basic/bear/polar = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/ice_demon = 5,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp = 1,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity = 25)

// class 2
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
		/obj/item/stack/ore/ice = 8)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf = 40,
		/mob/living/basic/bear/polar = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/ice_demon = 10,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp = 3,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity = 25)

/obj/structure/vein/ice/classtwo/rare
	drop_rate_amount_min = 30 // only ice - but a lot!
	drop_rate_amount_max = 40
	ore_list = list(
		/obj/item/stack/ore/ice = 10)

// class 3
/obj/structure/vein/ice/classthree
	mining_charges = 10
	vein_class = 3
	ore_types_min = 4
	ore_types_max = 7
	ore_list = list(
		/obj/item/stack/ore/iron = 2,
		/obj/item/stack/ore/gold = 2,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/silver = 5,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/ice = 8)

	max_mobs = 6
	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf = 40,
		/mob/living/basic/bear/polar = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/ice_demon = 15,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp = 5,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity = 30)

/obj/structure/vein/ice/classthree/rare
	drop_rate_amount_min = 30 // only ice - but a lot!
	drop_rate_amount_max = 40
	ore_list = list(
		/obj/item/stack/ore/ice = 10)

// class 4
/obj/structure/vein/ice/classfour
	mining_charges = 30
	vein_class = 4
	ore_types_min = 4
	ore_types_max = 7
	ore_list = list(
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/silver = 5,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/bluespace_crystal = 4,
		/obj/item/stack/ore/ice = 8)
	max_mobs = 6
	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf = 40,
		/mob/living/basic/bear/polar = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/ice_demon = 15,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp = 5,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity = 30)

// JUNGLE-CLASS //
// class 1
/obj/structure/vein/jungle
	ore_types_min = 2
	ore_types_max = 4
	ore_list = list(
		/obj/item/stack/ore/iron = 50,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 15,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/titanium = 1)

	mob_types = list( // easy surface mobs
		/mob/living/simple_animal/hostile/asteroid/wolf/random = 50,
		/mob/living/basic/bear/cave = 30,
		/mob/living/simple_animal/hostile/poison/giant_spider = 5,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 1)

// class 2
/obj/structure/vein/jungle/classtwo
	mining_charges = 8
	vein_class = 2
	ore_types_min = 2
	ore_types_max = 4
	ore_list = list(
		/obj/item/stack/ore/iron = 50,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/titanium = 4)

	max_mobs = 2
	spawn_time = 15 SECONDS // some big mobs can come out of these! take it easy
	mob_types = list( // mostly chaff, with a small chance of the tough jungle mobs
		/mob/living/simple_animal/hostile/asteroid/wolf/random = 75,
		/mob/living/basic/bear/cave = 60,
		/mob/living/simple_animal/hostile/poison/giant_spider = 45,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 20,
		/mob/living/simple_animal/hostile/jungle/seedling = 3,
		/mob/living/simple_animal/hostile/jungle/mega_arachnid = 3,
		/mob/living/simple_animal/hostile/jungle/mook = 3)

/obj/structure/vein/jungle/classtwo/rare
	ore_types_max = 2
	ore_list = list(
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/diamond = 5)

// class 3
/obj/structure/vein/jungle/classthree
	mining_charges = 10
	vein_class = 3
	ore_types_min = 2
	ore_types_max = 4
	ore_list = list(
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 10,
		/obj/item/stack/ore/titanium = 4)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf/random = 20,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 1,
		/mob/living/simple_animal/hostile/jungle/seedling = 5,
		/mob/living/simple_animal/hostile/jungle/mega_arachnid = 20,
		/mob/living/simple_animal/hostile/jungle/mook = 30)

/obj/structure/vein/jungle/classthree/rare
	ore_types_max = 2
	ore_list = list(
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/diamond = 10)

// class 4
/obj/structure/vein/jungle/classfour
	vein_class = 4
	mining_charges = 10
	ore_list = list(
		/obj/item/stack/ore/bluespace_crystal = 10)

	max_mobs = 4
	spawn_time = 10 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf/random = 20,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 1,
		/mob/living/simple_animal/hostile/jungle/seedling = 5,
		/mob/living/simple_animal/hostile/jungle/mega_arachnid = 20,
		/mob/living/simple_animal/hostile/jungle/mook = 30)

// SALTY SANDS-CLASS //
// class 1
/obj/structure/vein/sand
	ore_types_max = 2
	ore_list = list(
		/obj/item/stack/ore/iron = 45,
		/obj/item/stack/ore/titanium = 20,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/uranium = 5)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 30)

// class 2
/obj/structure/vein/sand/classtwo
	mining_charges = 8
	vein_class = 2
	ore_types_max = 2
	ore_list = list(
		/obj/item/stack/ore/iron = 25,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/uranium = 5)

	max_mobs = 6 // these things are squishy, don't hold back
	spawn_time = 10 SECONDS

/obj/structure/vein/sand/classtwo/rare
	mining_charges = 12
	ore_types_min = 1
	ore_types_max = 3
	ore_list = list(
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/diamond = 2)

// class 3
/obj/structure/vein/sand/classthree
	mining_charges = 10
	vein_class = 3
	ore_types_min = 2
	ore_types_max = 4
	ore_list = list(
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/uranium = 5)

	max_mobs = 6
	spawn_time = 8 SECONDS

/obj/structure/vein/sand/classthree/rare
	mining_charges = 14
	ore_types_min = 2
	ore_types_max = 3
	ore_list = list(
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/diamond = 5)

// class 4
// TODO

// ROCK-CLASS //
// class 1
/obj/structure/vein/rockplanet
	ore_types_min = 1
	ore_types_max = 3
	ore_list = list(
		/obj/item/stack/ore/iron = 60,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 10)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 20,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 30,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 10,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 10)

// class 2
/obj/structure/vein/rockplanet/classtwo
	mining_charges = 8
	vein_class = 2
	ore_types_min = 2
	ore_types_max = 3
	ore_list = list(
		/obj/item/stack/ore/iron = 50,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 15)

	spawn_time = 10 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 50,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 30,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 5,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 5)

// class 3
/obj/structure/vein/rockplanet/classthree
	mining_charges = 10
	vein_class = 3
	ore_types_min = 3
	ore_types_max = 4
	ore_list = list(
		/obj/item/stack/ore/iron = 30,
		/obj/item/stack/ore/uranium = 15,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/silver = 20,
		/obj/item/stack/ore/bluespace_crystal = 10)

	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 50,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 40,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 5,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 5,
		/mob/living/simple_animal/hostile/asteroid/fugu/asteroid = 5)

/obj/structure/vein/rockplanet/classthree/rare
	ore_list = list(
		/obj/item/stack/ore/uranium = 10) // yummy

// class 4
/obj/structure/vein/rockplanet/classfour
	mining_charges = 30
	vein_class = 4
	ore_types_min = 3
	ore_types_max = 5
	ore_list = list(
		/obj/item/stack/ore/iron = 25,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/gold = 15,
		/obj/item/stack/ore/silver = 20,
		/obj/item/stack/ore/bluespace_crystal = 15)

	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 50,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 40,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 5,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 5,
		/mob/living/simple_animal/hostile/asteroid/fugu/asteroid = 5)

// MOON-CLASS //
// class 1
/obj/structure/vein/moon
	ore_types_min = 2
	ore_types_max = 3
	ore_list = list(
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/titanium = 20,
		/obj/item/stack/ore/gold = 2,
		/obj/item/stack/ore/plasma = 2,
		/obj/item/stack/ore/uranium = 2)

	mob_types = list( // space mob variety hour
		/mob/living/simple_animal/hostile/asteroid/goliath = 5,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20)

// class 2
/obj/structure/vein/moon/classtwo
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/iron = 30,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/uranium = 5)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 10,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 15,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 5)

// class 3
/obj/structure/vein/moon/classthree
	mining_charges = 10
	vein_class = 3

	ore_list = list(
		/obj/item/stack/ore/iron = 5,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/uranium = 10)

	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 10,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 5)

// class 4
/obj/structure/vein/moon/classfour
	mining_charges = 15
	vein_class = 4
	drop_rate_amount_min = 30 // just ice - let's be generous
	drop_rate_amount_max = 40
	ore_list = list(
		/obj/item/stack/ore/ice = 10)

	max_mobs = 6
	spawn_time = 8 SECONDS
	mob_types = list( // crystal infection mobs. very, very high danger
		/mob/living/simple_animal/hostile/asteroid/goliath = 10,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal = 5,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/crystal = 5,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten = 5)

// DESERT-CLASS (currenty unused) //
// class 1
/obj/structure/vein/desert
	ore_types_min = 3
	ore_types_max = 4
	ore_list = list(
		/obj/item/stack/ore/gold = 20,
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/plasma = 5,
		/obj/item/stack/ore/diamond = 5,
		/obj/item/stack/ore/titanium = 4)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/antlion = 100,
		/mob/living/simple_animal/hostile/asteroid/antlion/mega = 10)

// class 2
/obj/structure/vein/desert/classtwo
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/gold = 30,
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/plasma = 7,
		/obj/item/stack/ore/diamond = 7,
		/obj/item/stack/ore/titanium = 5)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/antlion = 70,
		/mob/living/simple_animal/hostile/asteroid/antlion/mega = 10)

// class 3
/obj/structure/vein/desert/classthree
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/gold = 15,
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/plasma = 7,
		/obj/item/stack/ore/diamond = 7,
		/obj/item/stack/ore/titanium = 7)

	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/antlion = 50,
		/mob/living/simple_animal/hostile/asteroid/antlion/mega = 5)

// SHROUDED-CLASS (currently unused) //
// class 1
/obj/structure/vein/shrouded
	mining_charges = 8 // better - these are hard
	ore_types_min = 3
	ore_types_max = 5
	ore_list = list(
		/obj/item/stack/ore/uranium = 30,
		/obj/item/stack/ore/plasma = 25,
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/stack/ore/titanium = 6,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/diamond = 1)

	max_mobs = 3
	spawn_time = 5 SECONDS // glup
	var/greed_chance = 20 // chance that this vein becomes much, much harder
	mob_types = list( // scary...
		/mob/living/simple_animal/hostile/asteroid/royalcrab = 50,
		/mob/living/simple_animal/hostile/alien = 5,
		/mob/living/simple_animal/hostile/alien/drone = 5,
		/mob/living/simple_animal/hostile/alien/sentinel = 1)

/obj/structure/vein/shrouded/Initialize()
	. = ..()
	if(prob(greed_chance))
		max_mobs = 15
		spawn_time -= 1

// class 2
/obj/structure/vein/shrouded/classtwo
	mining_charges = 10
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/uranium = 20,
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/diamond = 1)

	spawn_time = 8 SECONDS
	greed_chance = 30
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/royalcrab = 30,
		/mob/living/simple_animal/hostile/alien = 5,
		/mob/living/simple_animal/hostile/alien/drone = 5,
		/mob/living/simple_animal/hostile/alien/sentinel = 1)

// class 3
/obj/structure/vein/shrouded/classthree
	mining_charges = 12
	vein_class = 3
	ore_types_min = 1
	ore_types_max = 3
	ore_list = list(
		/obj/item/stack/ore/uranium = 10,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/stack/ore/diamond = 5)

	spawn_time = 6 SECONDS
	greed_chance = 40
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/royalcrab = 10,
		/mob/living/simple_animal/hostile/alien = 5,
		/mob/living/simple_animal/hostile/alien/drone = 5,
		/mob/living/simple_animal/hostile/alien/sentinel = 1)

// ASTEROID TILE VEINS //
// class 1
/obj/structure/vein/asteroid
	ore_types_min = 1
	ore_types_max = 4
	ore_list = list(
		/obj/item/stack/ore/plasma = 40,
		/obj/item/stack/ore/iron = 65,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/bluespace_crystal = 1)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 60,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20)

/obj/structure/vein/asteroid/classtwo
	mining_charges = 8
	vein_class = 2
	ore_types_min = 3
	ore_types_max = 5
	ore_list = list(
		/obj/item/stack/ore/plasma = 30,
		/obj/item/stack/ore/iron = 55,
		/obj/item/stack/ore/titanium = 7,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/bluespace_crystal = 3)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 60,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 15,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 5)

/obj/structure/vein/asteroid/classtwo/rare
	drop_rate_amount_min = 30 // just ice - let's be generous
	drop_rate_amount_max = 40
	ore_list = list(
		/obj/item/stack/ore/ice = 10)

// class 3
/obj/structure/vein/asteroid/classthree
	mining_charges = 10
	vein_class = 3

	ore_list = list(
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/iron = 30,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/gold = 7,
		/obj/item/stack/ore/uranium = 7,
		/obj/item/stack/ore/bluespace_crystal = 5)

	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 60,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 10)

/obj/structure/vein/asteroid/classthree/rare
	mining_charges = 12
	drop_rate_amount_min = 30 // just ice - let's be generous
	drop_rate_amount_max = 40
	ore_list = list(
		/obj/item/stack/ore/ice = 10)

// class 4
// TODO

// AQUA-CLASS (currently unused) //
// class 1
/obj/structure/vein/waterplanet
	ore_types_min = 3
	ore_types_max = 5
	ore_list = list(
		/obj/item/stack/ore/plasma = 40,
		/obj/item/stack/ore/iron = 65,
		/obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/bluespace_crystal = 1)

	mob_types = list(
		/mob/living/basic/bear/cave = 60,
		/mob/living/simple_animal/hostile/carp = 40,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 20,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 10,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 8,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 1)

// class 2
/obj/structure/vein/waterplanet/classtwo
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/plasma = 30,
		/obj/item/stack/ore/iron = 55,
		/obj/item/stack/ore/titanium = 7,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/bluespace_crystal = 3)

	max_mobs = 3
	spawn_time = 10 SECONDS
	mob_types = list(
		/mob/living/basic/bear/cave = 50,
		/mob/living/simple_animal/hostile/carp = 30,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 30,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 15,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 10,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 1)

// class 3
/obj/structure/vein/waterplanet/classthree
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/iron = 30,
		/obj/item/stack/ore/titanium = 10,
		/obj/item/stack/ore/gold = 7,
		/obj/item/stack/ore/uranium = 7,
		/obj/item/stack/ore/bluespace_crystal = 5)

	max_mobs = 3
	spawn_time = 8 SECONDS
	mob_types = list(
		/mob/living/basic/bear/cave = 10,
		/mob/living/simple_animal/hostile/carp = 20,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 10,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 40,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 25,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 5)
