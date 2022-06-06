/datum/biome/sand
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/lit = 1)
	flora_spawn_chance = 3
	flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 4 ,
		/obj/structure/flora/ash/cap_shroom = 4 ,
		/obj/structure/flora/ash/stem_shroom = 4 ,
		/obj/structure/flora/ash/cacti = 2,
	)
	feature_spawn_chance = 0.1
	feature_spawn_list = list(/obj/structure/geyser/random = 1, /obj/structure/elite_tumor = 2)
	mob_spawn_chance = 4
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30,
		/mob/living/simple_animal/hostile/asteroid/whitesands/survivor/random = 25,
	)

/datum/biome/sand/oasis
/datum/biome/sand/icecap
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/lit = 1, /turf/open/floor/plating/asteroid/snow/lit/whitesands = 5)
	flora_spawn_chance = 4
	mob_spawn_chance = 1
	flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 2 ,
		/obj/structure/flora/ash/cap_shroom = 2 ,
		/obj/structure/flora/ash/stem_shroom = 2 ,
		/obj/structure/flora/rock/icy = 3,
		/obj/structure/flora/rock/pile/icy = 3,
	)

/datum/biome/sand/path
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried/lit = 1)
	flora_spawn_chance = 0
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 40,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 20,
		/mob/living/simple_animal/hostile/asteroid/whitesands/survivor/random = 40,
	)

/datum/biome/sand/acid
	open_turf_types = list(/turf/open/acid/whitesands = 1)
	flora_spawn_chance = 0
	feature_spawn_chance = 0
	mob_spawn_chance = 0

/datum/biome/cave/sand
	closed_turf_types = list(/turf/closed/mineral/random/whitesands = 1)
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands = 5, /turf/open/floor/plating/asteroid/whitesands/dried = 1)
	flora_spawn_chance = 4
	flora_spawn_list = list(
		/obj/structure/flora/rock = 4,
		/obj/structure/flora/rock/pile = 4,
		/obj/structure/flora/ash/whitesands/fern = 2,
		/obj/structure/flora/ash/whitesands/puce = 1,
	)
	feature_spawn_list = list(/obj/structure/geyser/random = 1, /obj/structure/elite_tumor = 2)
	mob_spawn_chance = 4
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10,
	)

/datum/biome/cave/sand/deep
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 1)
	mob_spawn_chance = 4
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50,
		/obj/structure/spawner/lavaland/goliath = 6,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40,
		/obj/structure/spawner/lavaland/whitesandsbasilisk = 6,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30,
		/obj/structure/spawner/lavaland/legion = 3,
		/obj/structure/spawner/lavaland/legion = 3,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10,
	)

/datum/biome/cave/sand/volcanic
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 1)
	mob_spawn_chance = 2

/datum/biome/cave/sand/volcanic/lava
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 1, /turf/open/lava = 10)

/datum/biome/cave/sand/volcanic/acidic
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 1, /turf/open/acid/whitesands = 7)
