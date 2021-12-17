GLOBAL_LIST_INIT(astroloot, list(
	/obj/item/stack/ore/uranium = 50,
	/obj/item/stack/ore/iron = 50,
	/obj/item/stack/ore/plasma = 75,
	/obj/item/stack/ore/silver = 50,
	/obj/item/stack/ore/gold = 50,
	/obj/item/stack/ore/diamond = 25,
	/obj/item/stack/ore/bananium = 5,
	/obj/item/stack/ore/titanium = 75,
	/obj/item/pickaxe/diamond = 15,
	/obj/item/borg/upgrade/modkit/cooldown = 5,
	/obj/item/borg/upgrade/modkit/damage = 5,
	/obj/item/borg/upgrade/modkit/range = 5,
	/obj/item/t_scanner/adv_mining_scanner/lesser = 15,
	/obj/item/kinetic_crusher = 15,
	/obj/effect/mob_spawn/human/corpse/damaged/legioninfested = 25,
	/obj/effect/mob_spawn/human/corpse/damaged/legioninfested = 25,
	/obj/effect/mob_spawn/human/corpse/damaged/legioninfested = 25,
	/obj/item/tank/jetpack/suit = 10,
	/obj/item/survivalcapsule = 15,
	/obj/item/reagent_containers/hypospray/medipen/survival = 15,
	/obj/item/card/mining_point_card = 15,
	/obj/item/gps/mining = 10,
	/obj/item/extraction_pack = 10,
	/obj/item/reagent_containers/food/drinks/beer = 15,
	))

/obj/structure/spawner
	name = "monster nest"
	icon = 'icons/mob/animal.dmi'
	icon_state = "hole"
	max_integrity = 100

	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	anchored = TRUE
	density = TRUE

	var/max_mobs = 5
	var/spawn_time = 300 //30 seconds default
	var/mob_types = list(/mob/living/simple_animal/hostile/carp)
	var/spawn_text = "emerges from"
	var/faction = list("hostile")
	var/spawner_type = /datum/component/spawner

/obj/structure/spawner/Initialize()
	. = ..()
	AddComponent(spawner_type, mob_types, spawn_time, faction, spawn_text, max_mobs)

/obj/structure/spawner/attack_animal(mob/living/simple_animal/M)
	if(faction_check(faction, M.faction, FALSE)&&!M.client)
		return
	..()


/obj/structure/spawner/syndicate
	name = "warp beacon"
	icon = 'icons/obj/device.dmi'
	icon_state = "syndbeacon"
	spawn_text = "warps in from"
	mob_types = list(/mob/living/simple_animal/hostile/syndicate/ranged)
	faction = list(ROLE_SYNDICATE)

/obj/structure/spawner/skeleton
	name = "bone pit"
	desc = "A pit full of bones, and some still seem to be moving..."
	icon_state = "hole"
	icon = 'icons/mob/nest.dmi'
	max_integrity = 150
	max_mobs = 15
	spawn_time = 150
	mob_types = list(/mob/living/simple_animal/hostile/skeleton)
	spawn_text = "climbs out of"
	faction = list("skeleton")

/obj/structure/spawner/clown
	name = "Laughing Larry"
	desc = "A laughing, jovial figure. Something seems stuck in his throat."
	icon_state = "clownbeacon"
	icon = 'icons/obj/device.dmi'
	max_integrity = 200
	max_mobs = 15
	spawn_time = 150
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/clown, /mob/living/simple_animal/hostile/retaliate/clown/fleshclown, /mob/living/simple_animal/hostile/retaliate/clown/clownhulk, /mob/living/simple_animal/hostile/retaliate/clown/longface, /mob/living/simple_animal/hostile/retaliate/clown/clownhulk/chlown, /mob/living/simple_animal/hostile/retaliate/clown/clownhulk/honcmunculus, /mob/living/simple_animal/hostile/retaliate/clown/mutant/blob, /mob/living/simple_animal/hostile/retaliate/clown/banana, /mob/living/simple_animal/hostile/retaliate/clown/honkling, /mob/living/simple_animal/hostile/retaliate/clown/lube)
	spawn_text = "climbs out of"
	faction = list("clown")

/obj/structure/spawner/mining/proc/adestroy_effect()
	playsound(loc,'sound/effects/explosionfar.ogg', 200, TRUE)
	visible_message("<span class='boldannounce'>[src] collapses, sealing everything inside!</span>\n<span class='warning'>Ores fall out of the cave as it is destroyed!</span>")

/obj/structure/spawner/mining
	name = "monster den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within most caves or mining asteroids."
	icon_state = "hole"
	max_mobs = 3
	icon = 'icons/mob/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/goldgrub, /mob/living/simple_animal/hostile/asteroid/goliath, /mob/living/simple_animal/hostile/asteroid/hivelord, /mob/living/simple_animal/hostile/asteroid/basilisk, /mob/living/simple_animal/hostile/asteroid/fugu)
	faction = list("mining")

/obj/structure/spawner/mining/deconstruct(disassembled)
	adestroy_effect()
	drop_astroloot()
	return ..()

/obj/structure/spawner/mining/proc/drop_astroloot()
	for(var/type in GLOB.astroloot)
		var/chance = GLOB.astroloot[type]
		if(!prob(chance))
			continue
		new type(loc, rand(5, 17))

/obj/structure/spawner/mining/goldgrub
	name = "goldgrub den"
	desc = "A den housing a nest of goldgrubs, annoying but arguably much better than anything else you'll find in a nest."
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/goldgrub)

/obj/structure/spawner/mining/goliath
	name = "goliath den"
	desc = "A den housing a nest of goliaths, oh god why?"
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/goliath)

/obj/structure/spawner/mining/hivelord
	name = "hivelord den"
	desc = "A den housing a nest of hivelords."
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/hivelord)

/obj/structure/spawner/mining/basilisk
	name = "basilisk den"
	desc = "A den housing a nest of basilisks, bring a coat."
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/basilisk)

/obj/structure/spawner/mining/wumborian
	name = "wumborian fugu den"
	desc = "A den housing a nest of wumborian fugus, how do they all even fit in there?"
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/fugu)
