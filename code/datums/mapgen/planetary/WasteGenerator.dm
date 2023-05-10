/datum/map_generator/planet_generator/waste

	mountain_height = 0.35
	perlin_zoom = 40

	initial_closed_chance = 45
	smoothing_iterations = 20
	birth_limit = 4
	death_limit = 3
	primary_area_type = /area/overmap_encounter/planetoid/wasteplanet

	//not sure if this is the best but it's there
	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/waste/crater,
			BIOME_LOW_HUMIDITY = /datum/biome/waste/crater,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/waste/clearing,
			BIOME_HIGH_HUMIDITY = /datum/biome/waste/clearing/mushroom,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/waste/metal/rust
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/waste/crater,
			BIOME_LOW_HUMIDITY = /datum/biome/waste/crater/rad,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/waste,
			BIOME_HIGH_HUMIDITY = /datum/biome/waste/clearing/mushroom,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/waste/tar_bed
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/waste/clearing,
			BIOME_LOW_HUMIDITY = /datum/biome/waste/clearing,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/waste/clearing/mushroom,
			BIOME_HIGH_HUMIDITY = /datum/biome/waste,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/waste
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/waste,
			BIOME_LOW_HUMIDITY = /datum/biome/waste/tar_bed,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/waste/metal,
			BIOME_HIGH_HUMIDITY = /datum/biome/waste,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/waste/metal/rust
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/waste,
			BIOME_LOW_HUMIDITY = /datum/biome/waste/tar_bed,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/waste/tar_bed,
			BIOME_HIGH_HUMIDITY = /datum/biome/waste/tar_bed/total,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/waste/tar_bed/total
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/waste/metal,
			BIOME_LOW_HUMIDITY = /datum/biome/waste/metal,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/waste/metal,
			BIOME_HIGH_HUMIDITY = /datum/biome/waste/metal/rust,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/waste/metal/rust
		)
	)

	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list( //irradiated caves
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/waste,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/waste,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/waste/tar_bed,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/waste/tar_bed/full,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/waste/tar_bed/full
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/waste,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/waste/rad,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/waste,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/waste/rad,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/waste
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/waste,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/waste,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/waste/metal,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/waste/metal,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/waste/tar_bed
		),
		BIOME_HOT_CAVE = list( //metal wreck for salvaging
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/waste/metal/hivebot,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/waste/metal/hivebot,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/waste/metal/hivebot,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/waste/metal/,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/waste/metal/
		)
	)

/datum/biome/waste
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/wasteplanet/lit = 80,
		/turf/open/floor/plating/rust/wasteplanet/lit = 15,
		/turf/open/floor/plating/wasteplanet/lit = 5
	)

	flora_spawn_list = list(

		//mech spawners
		/obj/effect/spawner/lootdrop/waste/mechwreck = 20,
		/obj/effect/spawner/lootdrop/waste/mechwreck/rare = 5,

		//decals and fluff structures
		/obj/effect/spawner/lootdrop/waste/trash = 180,
		/obj/effect/spawner/lootdrop/waste/radiation = 16,
		/obj/effect/spawner/lootdrop/waste/radiation/more_rads = 2,

		//stuff you can actually use
		/obj/effect/spawner/lootdrop/waste/girder = 60,
		/obj/structure/reagent_dispensers/fueltank = 20,
		/obj/structure/reagent_dispensers/watertank = 20,
		/obj/item/stack/cable_coil/cut = 50,
		/obj/structure/closet/crate/secure/loot = 3,
		/obj/effect/spawner/lootdrop/waste/atmos_can = 5,
		/obj/effect/spawner/lootdrop/waste/atmos_can/rare = 0.1,
		/obj/effect/spawner/lootdrop/waste/salvageable = 30,

		//plants
		/obj/structure/flora/ash/garden/waste = 7,
		/obj/structure/flora/ash/glowshroom = 20, //more common in caves


		//the illusive shrapnel plant
		/obj/effect/mine/shrapnel/human_only = 1
	)

	feature_spawn_list = list(
		/obj/effect/radiation/waste = 30,
		/obj/effect/radiation/waste/intense = 10,
		/obj/structure/geyser/random = 1
	)

	mob_spawn_list = list(
		//hivebots, not too difficult
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/strong = 70,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/ranged = 40,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/ranged/rapid = 30,
		//bots, are hostile
		/mob/living/simple_animal/bot/firebot/rockplanet = 15,
		/mob/living/simple_animal/bot/secbot/ed209/rockplanet = 3,
		/mob/living/simple_animal/hostile/abandoned_minebot = 15,
		/mob/living/simple_animal/bot/floorbot/rockplanet = 15,
	)

	flora_spawn_chance = 25
	feature_spawn_chance = 3
	mob_spawn_chance = 2

/datum/biome/waste/crater
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/wasteplanet/lit = 90,
		/turf/open/floor/plating/rust/wasteplanet/lit = 10,
	)

	flora_spawn_list = list(
		/obj/effect/spawner/lootdrop/waste/trash = 90,
		/obj/effect/spawner/lootdrop/waste/radiation = 16,
		/obj/effect/spawner/lootdrop/waste/radiation/more_rads = 2,
		/obj/effect/spawner/lootdrop/waste/atmos_can = 18,
		/obj/effect/spawner/lootdrop/waste/atmos_can/rare = 0.5,
		/obj/effect/spawner/lootdrop/waste/salvageable = 30,
	)
	mob_spawn_chance = 1

/datum/biome/waste/crater/rad
	flora_spawn_list = list(
		/obj/structure/flora/ash/glowshroom = 180,
		/obj/effect/spawner/lootdrop/waste/trash = 90,
		/obj/effect/spawner/lootdrop/waste/radiation = 50,
		/obj/effect/spawner/lootdrop/waste/radiation/more_rads = 25,
		/obj/effect/spawner/lootdrop/waste/atmos_can = 7,
		/obj/effect/spawner/lootdrop/waste/salvageable = 15
	)

/datum/biome/waste/clearing
	flora_spawn_chance = 20
	feature_spawn_chance = 6

/datum/biome/waste/clearing/mushroom
	flora_spawn_list = list(
		/obj/effect/spawner/lootdrop/waste/mechwreck = 20,
		/obj/effect/spawner/lootdrop/waste/trash = 90,
		/obj/effect/spawner/lootdrop/waste/radiation = 30,
		/obj/effect/spawner/lootdrop/waste/radiation/more_rads = 12,
		/obj/effect/spawner/lootdrop/waste/girder = 60,
		/obj/structure/reagent_dispensers/fueltank = 20,
		/obj/structure/reagent_dispensers/watertank = 20,
		/obj/item/stack/cable_coil/cut = 30,
		/obj/effect/spawner/lootdrop/waste/salvageable = 30,
		/obj/structure/flora/ash/garden/waste = 30,
		/obj/structure/flora/ash/glowshroom = 180,
		/obj/effect/mine/shrapnel/human_only = 1
	)

/datum/biome/waste/tar_bed //tar colorings
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/wasteplanet/lit = 70,
		/turf/open/floor/plating/rust/wasteplanet/lit = 10,
	)

/datum/biome/waste/tar_bed/total
	open_turf_types = list(
		/turf/open/water/tar/waste/lit
	)
	flora_spawn_chance = 0

/datum/biome/waste/metal
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/wasteplanet/lit = 5,
		/turf/open/floor/plating/rust/wasteplanet/lit = 45,
		/turf/open/floor/plating/wasteplanet/lit = 50
	)

	flora_spawn_list = list( //there are no plants here
		/obj/effect/spawner/lootdrop/waste/mechwreck = 20,
		/obj/effect/spawner/lootdrop/waste/mechwreck/rare = 5,
		/obj/effect/spawner/lootdrop/waste/trash = 90,
		/obj/effect/spawner/lootdrop/waste/radiation = 16,
		/obj/effect/spawner/lootdrop/waste/radiation/more_rads = 2,
		/obj/effect/spawner/lootdrop/waste/girder = 60,
		/obj/structure/reagent_dispensers/fueltank = 20,
		/obj/structure/reagent_dispensers/watertank = 20,
		/obj/item/stack/cable_coil/cut = 30,
		/obj/structure/closet/crate/secure/loot = 3,
		/obj/effect/spawner/lootdrop/waste/atmos_can = 18,
		/obj/effect/spawner/lootdrop/waste/atmos_can/rare = 0.1,
		/obj/effect/spawner/lootdrop/waste/salvageable = 30
	)
	mob_spawn_list = list( //nor organics, more biased towards hivebots though
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/strong = 80,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/ranged = 50,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/ranged/rapid = 50,
		/mob/living/simple_animal/bot/firebot/rockplanet = 15,
		/mob/living/simple_animal/bot/secbot/ed209/rockplanet = 3,
		/mob/living/simple_animal/hostile/abandoned_minebot = 15,
		/mob/living/simple_animal/bot/floorbot/rockplanet = 15,
	)

/datum/biome/waste/metal/rust
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/wasteplanet/lit = 1,
		/turf/open/floor/plating/rust/wasteplanet/lit = 10,
		/turf/open/floor/plating/wasteplanet/lit = 4
	)



/datum/biome/cave/waste
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/wasteplanet = 80,
		/turf/open/floor/plating/rust/wasteplanet = 15,
		/turf/open/floor/plating/wasteplanet = 5
	)

	closed_turf_types =  list(
		/turf/closed/mineral/random/asteroid/wasteplanet = 40,
		/turf/closed/wall/r_wall = 1,
		/turf/closed/wall/r_wall/rust = 3,
		/turf/closed/wall = 2,
		/turf/closed/wall/rust = 6
	)

	flora_spawn_list = list(
		/obj/effect/spawner/lootdrop/waste/mechwreck = 20,
		/obj/effect/spawner/lootdrop/waste/mechwreck/rare = 5,
		/obj/effect/spawner/lootdrop/waste/trash = 180,
		/obj/effect/spawner/lootdrop/waste/radiation = 16,
		/obj/effect/spawner/lootdrop/waste/radiation/more_rads = 2,
		/obj/effect/spawner/lootdrop/waste/girder = 60,
		/obj/structure/reagent_dispensers/fueltank = 20,
		/obj/structure/reagent_dispensers/watertank = 20,
		/obj/item/stack/cable_coil/cut = 50,
		/obj/structure/closet/crate/secure/loot = 3,
		/obj/effect/spawner/lootdrop/waste/atmos_can = 5,
		/obj/effect/spawner/lootdrop/waste/atmos_can/rare = 0.2,
		/obj/effect/spawner/lootdrop/waste/salvageable = 40,
		/obj/structure/flora/ash/garden/waste = 7,
		/obj/structure/flora/ash/glowshroom = 40, //more common in caves
		/obj/effect/mine/shrapnel/human_only = 1
	)

	feature_spawn_list = list(
		/obj/effect/radiation/waste = 30,
		/obj/effect/radiation/waste/intense = 10,
		/obj/structure/geyser/random = 1
	)
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/hivebot/strong/rockplanet = 70,
		/mob/living/simple_animal/hostile/hivebot/range/rockplanet = 40,
		/mob/living/simple_animal/hostile/hivebot/rapid/rockplanet = 30,
		/mob/living/simple_animal/bot/firebot/rockplanet = 15,
		/mob/living/simple_animal/bot/secbot/ed209/rockplanet = 3,
		/mob/living/simple_animal/hostile/abandoned_minebot = 15,
		/mob/living/simple_animal/bot/floorbot/rockplanet = 15,
	)
	feature_spawn_list = list(
		/obj/effect/radiation = 30,
	)
	flora_spawn_chance = 30
	feature_spawn_chance = 10
	mob_spawn_chance = 5

/datum/biome/cave/waste/tar_bed //tar colorings here
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/wasteplanet = 70,
		/turf/open/floor/plating/rust/wasteplanet = 20,
		/turf/open/water/tar/waste = 3
	)

/datum/biome/cave/waste/tar_bed/full
	open_turf_types = list(
		/turf/open/water/tar
	)
	flora_spawn_chance = 0

/datum/biome/cave/waste/rad
	flora_spawn_list = list(
		/obj/effect/spawner/lootdrop/waste/trash = 90,
		/obj/effect/spawner/lootdrop/waste/radiation = 50,
		/obj/effect/spawner/lootdrop/waste/radiation/more_rads = 25,
		/obj/effect/spawner/lootdrop/waste/atmos_can = 5,
		/obj/effect/spawner/lootdrop/waste/atmos_can/rare = 0.1,
		/obj/effect/spawner/lootdrop/waste/salvageable = 15,
		/obj/structure/flora/ash/glowshroom = 180
	)
	feature_spawn_chance = 12

/datum/biome/cave/waste/metal //deeper in, there's no normal stuff here
	open_turf_types = list(
		/turf/open/floor/plating/rust/wasteplanet = 10,
		/turf/open/floor/plating/wasteplanet = 4
	)
	closed_turf_types = list(
		/turf/closed/wall/r_wall = 1,
		/turf/closed/wall/r_wall/rust = 3,
		/turf/closed/wall = 5,
		/turf/closed/wall/rust = 10
	)
	flora_spawn_list = list(
		/obj/effect/spawner/lootdrop/waste/mechwreck = 20,
		/obj/effect/spawner/lootdrop/waste/mechwreck/rare = 5,
		/obj/effect/spawner/lootdrop/waste/trash = 90,
		/obj/effect/spawner/lootdrop/waste/radiation = 16,
		/obj/effect/spawner/lootdrop/waste/radiation/more_rads = 2,
		/obj/effect/spawner/lootdrop/waste/girder = 60,
		/obj/structure/reagent_dispensers/fueltank = 30,
		/obj/item/stack/cable_coil/cut = 30,
		/obj/structure/closet/crate/secure/loot = 3,
		/obj/effect/spawner/lootdrop/waste/atmos_can = 18,
		/obj/effect/spawner/lootdrop/waste/atmos_can/rare = 0.5,
		/obj/effect/spawner/lootdrop/waste/salvageable = 30
	)
	mob_spawn_list = list( //nor organics, more biased towards hivebots though
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/strong = 80,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/ranged = 50,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/ranged/rapid = 50,
		/mob/living/simple_animal/bot/firebot/rockplanet = 15,
		/mob/living/simple_animal/bot/secbot/ed209/rockplanet = 3,
		/mob/living/simple_animal/hostile/abandoned_minebot = 15,
		/mob/living/simple_animal/bot/floorbot/rockplanet = 15,
	)

/datum/biome/cave/waste/metal/hivebot
	mob_spawn_list = list( //Whoops! All hivebots!
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/strong = 80,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/ranged = 50,
		/mob/living/simple_animal/hostile/hivebot/wasteplanet/ranged/rapid = 50,
		/obj/structure/hivebot_beacon/wasteplanet = 20
	)
	mob_spawn_chance = 20
	//post my hivebot stuff: hivebot spawner, more hivebots
