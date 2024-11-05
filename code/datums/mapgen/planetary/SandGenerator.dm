/datum/map_generator/planet_generator/sand
	mountain_height = 0.8
	perlin_zoom = 70

	primary_area_type = /area/overmap_encounter/planetoid/sand

	// these are largely placeholder biomes and could do with being improved
	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/sand,
			BIOME_LOW_HUMIDITY = /datum/biome/sand,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/grass/dead,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand/icecap,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand/icecap
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/sand,
			BIOME_LOW_HUMIDITY = /datum/biome/sand/riverbed,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/wasteland,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand/wasteland,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand/icecap
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/sand,
			BIOME_LOW_HUMIDITY = /datum/biome/sand,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/riverbed,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/sand,
			BIOME_LOW_HUMIDITY =/datum/biome/sand/grass/dead,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/grass,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand/grass,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand/grass
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY =/datum/biome/sand/sulfur_plains,
			BIOME_LOW_HUMIDITY = /datum/biome/sand/sulfur_plains,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/riverbed,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand/grass,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand/grass
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/sand/sulfur_plains,
			BIOME_LOW_HUMIDITY = /datum/biome/sand/sulfur_plains,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/sulfur_plains,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand/sulfur_plains,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand
		)
	)

	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/sand/volcanic/acidic,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/sand,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/sand
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/sand/volcanic/acidic,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/sand/volcanic,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/sand,
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/sand/volcanic/acidic,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/sand/volcanic,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/sand,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/sand
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/sand/volcanic/lava,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/sand/volcanic,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/sand/volcanic,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/sand,
		)
	)

/datum/biome/sand
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/lit = 1)
	flora_spawn_chance = 3
	flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 4 ,
		/obj/structure/flora/ash/cap_shroom = 4 ,
		/obj/structure/flora/ash/stem_shroom = 4 ,
	)
	feature_spawn_chance = 0.1
	feature_spawn_list = list(
		/obj/structure/geyser/random = 8,
		/obj/structure/vein = 8,
		/obj/structure/vein/classtwo = 4,
		/obj/structure/elite_tumor = 4,
		/obj/structure/vein/classthree = 2,
		/obj/effect/spawner/random/anomaly/sand = 1,
		/obj/effect/greeble_spawner/whitesands/oasis = 1,
	)
	mob_spawn_chance = 4
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/random = 50,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30,
		/mob/living/simple_animal/hostile/human/hermit/survivor/random = 25,
	)

/datum/biome/sand/wasteland
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/whitesands/lit = 50,
		/turf/open/floor/plating/asteroid/whitesands/dried/lit = 40,
		/turf/closed/mineral/random/whitesands = 20,
		/turf/closed/wall/mineral/titanium/survival/pod = 1,
		/turf/closed/wall/rust = 1
	)
	flora_spawn_chance = 20
	flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 4,
		/obj/structure/flora/ash/cap_shroom = 4,
		/obj/structure/flora/ash/stem_shroom = 4,
		/obj/effect/decal/remains/human = 4,
		/obj/effect/spawner/random/maintenance = 40,
	)

/datum/biome/sand/grass
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/grass/lit = 1)
	flora_spawn_chance = 5
	flora_spawn_list = list(
		/obj/structure/flora/ash/cacti = 2,
		/obj/structure/flora/ash/fern = 4,
		/obj/structure/flora/tree/tall/whitesands = 4,
		/obj/structure/flora/rock = 3,
		/obj/structure/flora/rock/pile = 3,
	)
	mob_spawn_chance = 1
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/human/hermit/survivor/random = 1,
	)

/datum/biome/sand/grass/dead
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/grass/dead/lit = 1)
	flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 2,
		/obj/structure/flora/ash/cap_shroom = 2,
		/obj/structure/flora/ash/stem_shroom = 2,
		/obj/structure/flora/ash/fern = 4,
		/obj/structure/flora/tree/dead/barren = 4,
		/obj/structure/flora/rock = 3,
		/obj/structure/flora/rock/pile = 3,
	)

/datum/biome/sand/icecap
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/lit = 1, /turf/open/floor/plating/asteroid/snow/lit/whitesands = 5)
	flora_spawn_chance = 4
	mob_spawn_chance = 1
	flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 2 ,
		/obj/structure/flora/ash/cap_shroom = 2 ,
		/obj/structure/flora/ash/stem_shroom = 2 ,
		/obj/structure/flora/rock = 3,
		/obj/structure/flora/rock/pile = 3,
	)

/datum/biome/sand/riverbed
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried/lit = 1)
	flora_spawn_chance = 0
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/random = 40,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 20,
		/mob/living/simple_animal/hostile/human/hermit/survivor/random = 40,
	)

/datum/biome/sand/sulfur_plains //plains
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/lit = 1)
	flora_spawn_chance = 0
	feature_spawn_chance = 1
	feature_spawn_list = list(
		/obj/effect/spawner/lootdrop/greeble/sulfurpool = 1
	)
	mob_spawn_chance = 0

/datum/biome/cave/sand
	closed_turf_types = list(/turf/closed/mineral/random/whitesands = 1)
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/whitesands = 5,
		/turf/open/floor/plating/asteroid/whitesands/dried = 1
	)
	flora_spawn_chance = 4
	flora_spawn_list = list(
		/obj/structure/flora/rock = 4,
		/obj/structure/flora/rock/pile = 4,
		/obj/structure/flora/ash/fern = 2,
		/obj/structure/flora/ash/puce = 1,
	)
	feature_spawn_list = list(
		/obj/structure/vein = 8,
		/obj/structure/geyser/random = 4,
		/obj/structure/vein/classtwo = 4,
		/obj/structure/elite_tumor = 4,
		/obj/effect/spawner/random/anomaly/sand/cave = 1
	)
	mob_spawn_chance = 4
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/random = 50,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10,
	)

/datum/biome/cave/sand/deep
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 1)
	mob_spawn_chance = 4
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/random = 50,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 20,
		/obj/structure/spawner/burrow/sand_planet = 25
	)

/datum/biome/cave/sand/volcanic
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 1)
	mob_spawn_chance = 2

/datum/biome/cave/sand/volcanic/lava
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 7, /turf/open/lava = 1)

/datum/biome/cave/sand/volcanic/acidic
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 1, /turf/open/water/whitesands = 8)

/obj/effect/spawner/lootdrop/greeble/sulfurpool
	loot = list(
			/obj/effect/greeble_spawner/whitesands/sulfurpool1 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool2 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool3 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool4 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool5 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool6 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool7 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool8 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool9 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool10 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool11 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool12 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool13 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool14 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool15 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool16 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool17 = 5,
			/obj/effect/greeble_spawner/whitesands/sulfurpool18 = 5,
		)

/obj/effect/greeble_spawner/whitesands/sulfurpool1
	template = /datum/map_template/greeble/whitesands/sulfurpool1

/obj/effect/greeble_spawner/whitesands/sulfurpool2
	template = /datum/map_template/greeble/whitesands/sulfurpool2

/obj/effect/greeble_spawner/whitesands/sulfurpool3
	template = /datum/map_template/greeble/whitesands/sulfurpool3

/obj/effect/greeble_spawner/whitesands/sulfurpool4
	template = /datum/map_template/greeble/whitesands/sulfurpool4

/obj/effect/greeble_spawner/whitesands/sulfurpool5
	template = /datum/map_template/greeble/whitesands/sulfurpool5

/obj/effect/greeble_spawner/whitesands/sulfurpool6
	template = /datum/map_template/greeble/whitesands/sulfurpool6

/obj/effect/greeble_spawner/whitesands/sulfurpool7
	template = /datum/map_template/greeble/whitesands/sulfurpool7

/obj/effect/greeble_spawner/whitesands/sulfurpool8
	template = /datum/map_template/greeble/whitesands/sulfurpool8

/obj/effect/greeble_spawner/whitesands/sulfurpool9
	template = /datum/map_template/greeble/whitesands/sulfurpool9

/obj/effect/greeble_spawner/whitesands/sulfurpool10
	template = /datum/map_template/greeble/whitesands/sulfurpool10

/obj/effect/greeble_spawner/whitesands/sulfurpool10
	template = /datum/map_template/greeble/whitesands/sulfurpool10

/obj/effect/greeble_spawner/whitesands/sulfurpool11
	template = /datum/map_template/greeble/whitesands/sulfurpool11

/obj/effect/greeble_spawner/whitesands/sulfurpool12
	template = /datum/map_template/greeble/whitesands/sulfurpool12

/obj/effect/greeble_spawner/whitesands/sulfurpool13
	template = /datum/map_template/greeble/whitesands/sulfurpool13

/obj/effect/greeble_spawner/whitesands/sulfurpool14
	template = /datum/map_template/greeble/whitesands/sulfurpool14

/obj/effect/greeble_spawner/whitesands/sulfurpool15
	template = /datum/map_template/greeble/whitesands/sulfurpool15

/obj/effect/greeble_spawner/whitesands/sulfurpool16
	template = /datum/map_template/greeble/whitesands/sulfurpool16

/obj/effect/greeble_spawner/whitesands/sulfurpool17
	template = /datum/map_template/greeble/whitesands/sulfurpool17

/obj/effect/greeble_spawner/whitesands/sulfurpool18
	template = /datum/map_template/greeble/whitesands/sulfurpool18

/datum/map_template/greeble/whitesands/sulfurpool1
	name = "Sulfur Greeble 1"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_1.dmm"

/datum/map_template/greeble/whitesands/sulfurpool2
	name = "Sulfur Greeble 2"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_2.dmm"

/datum/map_template/greeble/whitesands/sulfurpool3
	name = "Sulfur Greeble 3"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_3.dmm"

/datum/map_template/greeble/whitesands/sulfurpool4
	name = "Sulfur Greeble 4"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_4.dmm"

/datum/map_template/greeble/whitesands/sulfurpool5
	name = "Sulfur Greeble 5"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_5.dmm"

/datum/map_template/greeble/whitesands/sulfurpool6
	name = "Sulfur Greeble 6"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_6.dmm"

/datum/map_template/greeble/whitesands/sulfurpool7
	name = "Sulfur Greeble 7"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_7.dmm"

/datum/map_template/greeble/whitesands/sulfurpool8
	name = "Sulfur Greeble 8"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_8.dmm"

/datum/map_template/greeble/whitesands/sulfurpool9
	name = "Sulfur Greeble 9"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_9.dmm"

/datum/map_template/greeble/whitesands/sulfurpool10
	name = "Sulfur Greeble 10"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_10.dmm"

/datum/map_template/greeble/whitesands/sulfurpool11
	name = "Sulfur Greeble 11"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_11.dmm"

/datum/map_template/greeble/whitesands/sulfurpool12
	name = "Sulfur Greeble 12"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_12.dmm"

/datum/map_template/greeble/whitesands/sulfurpool13
	name = "Sulfur Greeble 13"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_13.dmm"

/datum/map_template/greeble/whitesands/sulfurpool14
	name = "Sulfur Greeble 14"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_14.dmm"

/datum/map_template/greeble/whitesands/sulfurpool15
	name = "Sulfur Greeble 15"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_15.dmm"

/datum/map_template/greeble/whitesands/sulfurpool16
	name = "Sulfur Greeble 16"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_16.dmm"

/datum/map_template/greeble/whitesands/sulfurpool17
	name = "Sulfur Greeble 17"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_17.dmm"

/datum/map_template/greeble/whitesands/sulfurpool18
	name = "Sulfur Greeble 18"
	mappath = "_maps/templates/greebles/whitesands/sulfur_pool_18.dmm"

/obj/effect/greeble_spawner/whitesands/oasis
	template = /datum/map_template/greeble/whitesands/oasis

/datum/map_template/greeble/whitesands/oasis
	name = "Rare Oasis"
	mappath = "_maps/templates/greebles/whitesands/oasis_1.dmm"
	clear_everything = TRUE

/obj/effect/spawner/lootdrop/twentypercentpucespawn
	name = "20% puce spawn chance"
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "puce"
	loot = list(
			/obj/structure/flora/ash/puce = 5,
		)

/obj/effect/spawner/lootdrop/twentypercentpucespawn/Initialize(mapload)
	if(prob(20))
		return ..()
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/lootdrop/fiftycavefern
	name = "50% cave fern spawn chance"
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "cavefern" //needs new sprites.
	loot = list(
			/obj/structure/flora/ash/fern = 5,
		)

/obj/effect/spawner/lootdrop/fiftycavefern/Initialize(mapload)
	if(prob(50))
		return ..()
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/lootdrop/fourtywsfauna
	name = "40% whitesands fauna spawn chance"
	loot = list(
			/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/random = 15,
			/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 20,
			/mob/living/simple_animal/hostile/human/hermit/survivor/random = 5,
		)

	icon = 'icons/mob/lavaland/lavaland_monsters_wide.dmi'
	icon_state = "ws_goliath"

/obj/effect/spawner/lootdrop/fourtywsfauna/Initialize(mapload)
	if(prob(40))
		return ..()
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/lootdrop/seventyrock
	name = "70% rock spawn chance"
	icon = 'icons/obj/flora/rocks.dmi'
	loot = list(
			/obj/structure/flora/rock = 5,
		)

/obj/effect/spawner/lootdrop/seventyrock/Initialize(mapload)
	if(prob(70))
		return ..()
	return INITIALIZE_HINT_QDEL
