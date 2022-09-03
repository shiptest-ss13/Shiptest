/datum/biome/grass
	open_turf_types = list(/turf/open/floor/plating/grass/beach/lit = 1)
	flora_spawn_list = list(
		/obj/structure/flora/tree/jungle = 1,
		/obj/structure/flora/ausbushes/brflowers = 1,
		/obj/structure/flora/ausbushes/fernybush = 1,
		/obj/structure/flora/ausbushes/fullgrass = 1,
		/obj/structure/flora/ausbushes/genericbush = 1,
		/obj/structure/flora/ausbushes/grassybush = 1,
		/obj/structure/flora/ausbushes/lavendergrass = 1,
		/obj/structure/flora/ausbushes/leafybush = 1,
		/obj/structure/flora/ausbushes/palebush = 1,
		/obj/structure/flora/ausbushes/pointybush = 1,
		/obj/structure/flora/ausbushes/ppflowers = 1,
		/obj/structure/flora/ausbushes/reedbush = 1,
		/obj/structure/flora/ausbushes/sparsegrass = 1,
		/obj/structure/flora/ausbushes/stalkybush = 1,
		/obj/structure/flora/ausbushes/stalkybush = 1,
		/obj/structure/flora/ausbushes/sunnybush = 1,
		/obj/structure/flora/ausbushes/ywflowers = 1,
		/obj/structure/flora/tree/palm = 1,
	)
	flora_spawn_chance = 25
	mob_spawn_list = list(
		/mob/living/simple_animal/butterfly = 1,
		/mob/living/simple_animal/chicken/rabbit/normal = 1,
		/mob/living/simple_animal/mouse = 1,
		/mob/living/simple_animal/cow = 1,
		/mob/living/simple_animal/deer = 1
	)
	mob_spawn_chance = 1

/datum/biome/grass/dense
	flora_spawn_chance = 70
	mob_spawn_list = list(

		/mob/living/simple_animal/butterfly = 4,
		/mob/living/simple_animal/hostile/retaliate/poison/snake = 5,
		/mob/living/simple_animal/hostile/poison/bees/toxin = 3,
	)
	mob_spawn_chance = 2
	feature_spawn_chance = 0.1

/datum/biome/beach
	open_turf_types = list(/turf/open/floor/plating/asteroid/sand/lit = 1)
	mob_spawn_list = list(/mob/living/simple_animal/crab = 7, /mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 5)
	mob_spawn_chance = 1
	flora_spawn_list = list(
		/obj/structure/flora/tree/palm = 1,
		/obj/structure/flora/rock/beach = 3,
	)
	flora_spawn_chance = 3

/datum/biome/beach/dense
	open_turf_types = list(/turf/open/floor/plating/asteroid/sand/dense/lit = 1)
	flora_spawn_list = list(
		/obj/structure/flora/rock/asteroid = 6,
		/obj/structure/flora/rock/beach = 1
	)
	flora_spawn_chance = 0.6

/datum/biome/ocean
	open_turf_types = list(/turf/open/water/beach = 1)
	mob_spawn_list = list(
		/mob/living/simple_animal/beachcarp/bass = 1,
		/mob/living/simple_animal/beachcarp/trout = 1,
		/mob/living/simple_animal/beachcarp/salmon = 1,
		/mob/living/simple_animal/beachcarp/perch = 1,
	)
	mob_spawn_chance = 1.4
	flora_spawn_list = list(
		/obj/structure/flora/rock/beach = 1,
		/obj/structure/flora/rock/pile = 1
	)
	flora_spawn_chance = 1

/datum/biome/ocean/deep
	open_turf_types = list(/turf/open/water/beach/deep = 1)
	mob_spawn_chance = 1.4
	mob_spawn_list = list(
		/mob/living/simple_animal/beachcarp/bass = 5,
		/mob/living/simple_animal/beachcarp/trout = 5,
		/mob/living/simple_animal/beachcarp/salmon = 5,
		/mob/living/simple_animal/beachcarp/perch = 5,
	)

/datum/biome/cave/beach
	open_turf_types = list(/turf/open/floor/plating/asteroid/sand/dense = 1)
	closed_turf_types = list(/turf/closed/mineral/random/beach = 1)
	flora_spawn_chance = 4
	flora_spawn_list = list(/obj/structure/flora/rock/beach = 1, /obj/structure/flora/rock/asteroid = 6)
	mob_spawn_chance = 1
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/bear/cave = 5,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 1,
	)

/datum/biome/cave/beach/cove
	open_turf_types = list(/turf/open/floor/plating/asteroid/sand/dense = 1)
	flora_spawn_list = list(/obj/structure/flora/tree/dead_pine = 1, /obj/structure/flora/rock/beach = 1)
	flora_spawn_chance = 5

/datum/biome/cave/beach/magical
	open_turf_types = list(/turf/open/floor/grass/fairy/beach = 1)
	flora_spawn_chance = 20
	flora_spawn_list = list(
		/obj/structure/flora/ausbushes/grassybush = 1,
		/obj/structure/flora/ausbushes/fernybush = 1,
		/obj/structure/flora/ausbushes/fullgrass = 1,
		/obj/structure/flora/ausbushes/genericbush = 1,
		/obj/structure/flora/ausbushes/grassybush = 1,
		/obj/structure/flora/ausbushes/leafybush = 1,
		/obj/structure/flora/ausbushes/palebush = 1,
		/obj/structure/flora/ausbushes/pointybush = 1,
		/obj/structure/flora/ausbushes/reedbush = 1,
		/obj/structure/flora/ausbushes/sparsegrass = 1,
		/obj/structure/flora/ausbushes/stalkybush = 1,
		/obj/structure/flora/ausbushes/stalkybush = 1,
		/obj/structure/flora/ausbushes/sunnybush = 1,
	)
	mob_spawn_chance = 5
	mob_spawn_list = list(
		/mob/living/simple_animal/butterfly = 1,
		/mob/living/simple_animal/slime/pet = 1,
		/mob/living/simple_animal/hostile/lightgeist = 1
	)
