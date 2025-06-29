/obj/structure/spawner
	name = "monster nest"
	icon = 'icons/mob/nest.dmi'
	icon_state = "hole"
	max_integrity = 100

	move_resist = INFINITY
	anchored = TRUE
	density = TRUE

	var/max_mobs = 5
	var/spawn_time = 300 //30 seconds default
	var/mob_types = list(/mob/living/simple_animal/hostile/carp)
	var/spawn_text = "emerges from"
	var/faction = list("hostile")
	var/spawn_sound = list('sound/effects/break_stone.ogg')
	var/spawner_type = /datum/component/spawner
	var/spawn_distance_min = 1
	var/spawn_distance_max = 1

/obj/structure/spawner/Initialize()
	. = ..()
	AddComponent(spawner_type, mob_types, spawn_time, faction, spawn_text, max_mobs, spawn_sound, spawn_distance_min, spawn_distance_max)

/obj/structure/spawner/attack_animal(mob/living/simple_animal/M)
	if(faction_check(faction, M.faction, FALSE)&&!M.client)
		return
	..()

/obj/structure/spawner/carp
	name = "carp spawn" //the non game spawn meaning
	desc = "A puddle, which appears to be full of carp"
	icon_state = "puddle"
	icon = 'icons/obj/watercloset.dmi'
	max_integrity = 150
	max_mobs = 5
	spawn_time = 1200
	mob_types = list(/mob/living/simple_animal/hostile/carp)
	spawn_text = "swims out of"
	faction = list("carp")
