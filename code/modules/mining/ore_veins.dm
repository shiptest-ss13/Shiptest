/obj/structure/vein
	name = "ore vein"
	icon = 'icons/obj/lavaland/terrain.dmi'
	icon_state = "geyser"
	anchored = TRUE
	layer = HIGH_TURF_LAYER
	move_resist = INFINITY

	var/mining_charges = 9
	//Classification of the quality of possible ores within a vein, used to determine difficulty
	var/vein_class = 1
	//A weighted list of all possible ores that can generate in a vein
	//The design process is that class 1 veins have a small chance of generating with class 2 ores and so on
	//As higher class veins will be increasingly harder to mine
	var/list/ore_list = list(
		/obj/item/stack/ore/iron = 5,
		/obj/item/stack/ore/plasma = 4,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/titanium = 1,
		)
	//The post initialize list of all possible drops from the vein
	var/list/vein_contents = list()
	//Mob spawning variables
	var/max_mobs = 5
	var/spawn_time = 100 //10 seconds
	var/mob_types = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50,
		/*/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30,
		/mob/living/simple_animal/hostile/asteroid/brimdemon = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal = 1,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten = 1,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/crystal = 1,*/
		)
	var/spawn_text = "emerges from"
	var/faction = list("hostile")
	var/spawn_sound = list('sound/effects/break_stone.ogg')
	var/spawner_type = /datum/component/spawner
	var/spawn_distance_min = 4
	var/spawn_distance_max = 6


//Generates amount of ore able to be pulled from the vein (mining_charges) and types of ore within it (vein_contents)
/obj/structure/vein/Initialize()
	. = ..()
	var/ore_type_amount
	mining_charges = rand(round(mining_charges/1.5),mining_charges*1.5)
	switch(vein_class)
		if(1)
			ore_type_amount = rand(1,3)
		if(2)
			ore_type_amount = rand(3,5)
		if(3)
			ore_type_amount = rand(4,6)
		else
			ore_type_amount = 1
	for(ore_type_amount, ore_type_amount>0, ore_type_amount--)
		var/picked
		picked = pickweight(ore_list)
		vein_contents.Add(picked)
		ore_list.Remove(picked)

/obj/structure/vein/deconstruct(disassembled)
	destroy_effect()
	return..()

/obj/structure/vein/proc/begin_spawning()
	AddComponent(spawner_type, mob_types, spawn_time, faction, spawn_text, max_mobs, spawn_sound, spawn_distance_min, spawn_distance_max)

//Pulls a random ore from the vein list per vein_class
/obj/structure/vein/proc/drop_ore()
	var/class
	class = vein_class
	for(class, class>0, class--)
		var/picked
		picked = pick(vein_contents)
		new picked(loc,rand(5,10))

/obj/structure/vein/proc/destroy_effect()
	playsound(loc,'sound/effects/explosionfar.ogg', 200, TRUE)
	visible_message("<span class='boldannounce'>[src] collapses!</span>")
