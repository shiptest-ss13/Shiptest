GLOBAL_LIST_INIT(astroloot, list(
	/obj/item/stack/ore/uranium = 50,
	/obj/item/stack/ore/iron = 50,
	/obj/item/stack/ore/plasma = 75,
	/obj/item/stack/ore/silver = 50,
	/obj/item/stack/ore/gold = 50,
	/obj/item/stack/ore/diamond = 25,
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
	/obj/item/gps/mining = 10,
	/obj/item/extraction_pack = 10,
	/obj/item/reagent_containers/food/drinks/beer = 15,
	))

/obj/structure/spawner/mining
	name = "monster den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within most caves or mining asteroids."
	icon_state = "hole"
	max_mobs = 3
	icon = 'icons/mob/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/goldgrub, /mob/living/simple_animal/hostile/asteroid/goliath, /mob/living/simple_animal/hostile/asteroid/hivelord, /mob/living/simple_animal/hostile/asteroid/basilisk, /mob/living/simple_animal/hostile/asteroid/fugu)
	faction = list("mining")
	density = 0

/obj/structure/spawner/mining/deconstruct(disassembled)
	adestroy_effect()
	drop_astroloot()
	return ..()

/obj/structure/spawner/mining/proc/adestroy_effect()
	playsound(loc,'sound/effects/explosionfar.ogg', 200, TRUE)
	visible_message("<span class='boldannounce'>[src] collapses, sealing everything inside!</span>\n<span class='warning'>Ores fall out of the cave as it is destroyed!</span>")

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

/obj/structure/spawner/mining/carp
	name = "carp den"
	desc = "A den housing a nest of space carp, seems fishy!"
	mob_types = list(/mob/living/simple_animal/hostile/carp)
	spawn_text = "emerges from"
