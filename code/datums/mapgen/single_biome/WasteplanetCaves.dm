/datum/map_generator/single_biome/wasteplanet
	initial_closed_chance = 45
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3

	biome_type = /datum/biome/cave/wasteplanet
	area_type = /area/overmap_encounter/planetoid/wasteplanet

/datum/biome/cave/wasteplanet
	open_turf_types = list(/turf/open/floor/plating/asteroid/wasteplanet = 50,
						/turf/open/floor/plating/rust/wasteplanet = 10,
						/turf/open/floor/plating/wasteplanet = 5)
	closed_turf_types =  list(/turf/closed/mineral/random/wasteplanet = 45,
							/turf/closed/wall/rust = 10,)

	flora_spawn_list = list(
		/obj/structure/mecha_wreckage/ripley = 15,
		/obj/structure/mecha_wreckage/ripley/firefighter = 9,
		/obj/structure/mecha_wreckage/ripley/mkii = 9,
		/obj/structure/girder = 60,
		/obj/structure/reagent_dispensers/fueltank = 30,
		/obj/item/stack/cable_coil/cut = 30,
		/obj/effect/decal/cleanable/greenglow = 60,
		/obj/effect/decal/cleanable/glass = 30,
		/obj/structure/closet/crate/secure/loot = 3,
		/obj/machinery/portable_atmospherics/canister/toxins = 3,
		/obj/machinery/portable_atmospherics/canister/carbon_dioxide = 3,
		/obj/structure/radioactive = 6,
		/obj/structure/radioactive/stack = 6,
		/obj/structure/radioactive/waste = 6,
		/obj/structure/flora/ash/garden/waste = 15,
		/obj/structure/flora/ash/glowshroom = 90,

		/obj/structure/salvageable/machine = 20,
		/obj/structure/salvageable/autolathe = 15,
		/obj/structure/salvageable/computer = 10,
		/obj/structure/salvageable/protolathe = 10,
		/obj/structure/salvageable/circuit_imprinter = 8,
		/obj/structure/salvageable/destructive_analyzer = 8,
		/obj/structure/salvageable/server = 8,
	)
	feature_spawn_list = list(
		/obj/structure/geyser/random = 1,
		/obj/effect/mine/shrapnel/human_only = 1
	)
	mob_spawn_list = list(
		//hivebots, not too difficult
		/mob/living/simple_animal/hostile/hivebot/strong/rockplanet = 70,
		/mob/living/simple_animal/hostile/hivebot/range/rockplanet = 40,
		/mob/living/simple_animal/hostile/hivebot/rapid/rockplanet = 30,
		//crystal mobs, very difficult
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal = 1,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten = 1,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/crystal = 1,
		//bots, are hostile
		/mob/living/simple_animal/bot/firebot/rockplanet = 15,
		/mob/living/simple_animal/bot/secbot/ed209/rockplanet = 3,
		/mob/living/simple_animal/hostile/abandoned_minebot = 15,
		/mob/living/simple_animal/bot/floorbot/rockplanet = 15,
	)

	flora_spawn_chance = 10
	feature_spawn_chance = 0.1
	mob_spawn_chance = 2
