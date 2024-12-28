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
		/obj/item/stack/ore/iron = 7,
		/obj/item/stack/ore/plasma = 3,
		/obj/item/stack/ore/silver = 2,
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/titanium = 2,
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
	var/spawn_time = 150 //15 seconds
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
				ore_type_amount = rand(1,3)
			if(2)
				ore_type_amount = rand(3,5)
			if(3)
				ore_type_amount = rand(4,6)
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

/obj/structure/vein/classtwo
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/iron = 8,
		/obj/item/stack/ore/plasma = 3,
		/obj/item/stack/ore/silver = 4,
		/obj/item/stack/ore/uranium = 2,
		/obj/item/stack/ore/titanium = 5,
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

/obj/structure/vein/classthree
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/iron = 9,
		/obj/item/stack/ore/plasma = 3,
		/obj/item/stack/ore/silver = 5,
		/obj/item/stack/ore/uranium = 2,
		/obj/item/stack/ore/titanium = 6,
		/obj/item/stack/ore/diamond = 4,
		/obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/bluespace_crystal = 3,
		)
	max_mobs = 6 //Best not to go past 6 due to balance and lag reasons
	spawn_time = 80
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/nest = 60,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 10,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf/nest = 10,
		)

/obj/structure/vein/ice
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/wolf = 30,
		/mob/living/simple_animal/hostile/asteroid/polarbear = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow/nest = 20,
		/mob/living/simple_animal/hostile/asteroid/ice_demon = 10,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp = 5,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity = 20,
	)
	//Ice planets earn a slightly higher rare ore chance on account of them being notably harder
	//Alongside being a much more reliable source of plasma
	ore_list = list(
		/obj/item/stack/ore/iron = 7,
		/obj/item/stack/ore/plasma = 7,
		/obj/item/stack/ore/silver = 3,
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/titanium = 2,
		/obj/item/stack/ore/titanium = 2,
		/obj/item/stack/ore/gold = 1,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/ice = 7,
		)

/obj/structure/vein/ice/classtwo
	mining_charges = 8
	vein_class = 2
	ore_list = list(
		/obj/item/stack/ore/iron = 8,
		/obj/item/stack/ore/plasma = 9,
		/obj/item/stack/ore/silver = 5,
		/obj/item/stack/ore/uranium = 2,
		/obj/item/stack/ore/titanium = 6,
		/obj/item/stack/ore/diamond = 2,
		/obj/item/stack/ore/gold = 3,
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/ice = 8,
		)
	max_mobs = 6
	spawn_time = 100

/obj/structure/vein/ice/classthree
	mining_charges = 10
	vein_class = 3
	ore_list = list(
		/obj/item/stack/ore/iron = 8,
		/obj/item/stack/ore/plasma = 9,
		/obj/item/stack/ore/silver = 6,
		/obj/item/stack/ore/uranium = 2,
		/obj/item/stack/ore/titanium = 6,
		/obj/item/stack/ore/diamond = 4,
		/obj/item/stack/ore/gold = 6,
		/obj/item/stack/ore/bluespace_crystal = 4,
		/obj/item/stack/ore/ice = 8,
		)
	max_mobs = 6
	spawn_time = 80

// Asteroid veins are the same as the base planetary ones yield wise, but with the asteroid mobs.

/obj/structure/vein/asteroid
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 60,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20,
		)

/obj/structure/vein/classtwo/asteroid
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 60,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 15,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 5
		)

/obj/structure/vein/classthree/asteroid
	mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 60,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/carp/megacarp = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 10
		)

