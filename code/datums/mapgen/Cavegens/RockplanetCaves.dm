#define ROCKPLANET_DEFAULT_ATMOS "co2=95;n2=3;TEMP=210.15"

/datum/map_generator/cave_generator/rockplanet
	open_turf_types = list(/turf/open/floor/plating/asteroid/rockplanet = 5,
						/turf/open/floor/plating/asteroid/rockplanet/sand = 1)

	closed_turf_types =  list(/turf/closed/mineral/random/asteroid/rockplanet = 1)

	mob_spawn_chance = 2
	flora_spawn_chance = 5
	mob_spawn_chance = 3

	mob_spawn_list = list(
		//'regular' fauna, not too difficult
		/mob/living/simple_animal/hostile/netherworld/asteroid = 50,
		/mob/living/simple_animal/hostile/asteroid/fugu/asteroid = 50,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 40, //mariuce
		//crystal mobs, very difficult
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal = 1,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten = 1,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/crystal = 1,
		//bots, are hostile
		/mob/living/simple_animal/bot/firebot/rockplanet = 15,
		/mob/living/simple_animal/bot/secbot/ed209/rockplanet = 3,
		/mob/living/simple_animal/hostile/abandoned_minebot = 15,
		/mob/living/simple_animal/bot/floorbot/rockplanet = 15)
	mob_spawn_list = list(/mob/living/simple_animal/hostile/netherworld/asteroid = 30,
		/mob/living/simple_animal/hostile/asteroid/fugu/asteroid = 30,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 20, //mariuce
//		/mob/living/simple_animal/hostile/ooze/grapes/asteroid = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 30,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 50,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 20,
	)

	flora_spawn_list = list(
		/obj/structure/mecha_wreckage/ripley = 15,
		/obj/structure/mecha_wreckage/ripley/firefighter = 9,
		/obj/structure/mecha_wreckage/ripley/mkii = 9,
		/obj/structure/girder = 90,
		/obj/structure/reagent_dispensers/fueltank = 30,
		/obj/item/stack/cable_coil/cut = 30,
		/obj/effect/decal/cleanable/greenglow = 60,
		/obj/effect/decal/cleanable/glass = 30,
		/obj/structure/closet/crate/secure/loot = 3,
		/obj/machinery/portable_atmospherics/canister/toxins = 3,
		/obj/machinery/portable_atmospherics/canister/miasma = 3,
		/obj/machinery/portable_atmospherics/canister/carbon_dioxide = 3,
		/obj/structure/radioactive = 6,
		/obj/structure/radioactive/stack = 6,
		/obj/structure/radioactive/waste = 6,

		/obj/structure/salvageable/machine = 20,
		/obj/structure/salvageable/autolathe = 15,
		/obj/structure/salvageable/computer = 10,
		/obj/structure/salvageable/protolathe = 10,
		/obj/structure/salvageable/circuit_imprinter = 8,
		/obj/structure/salvageable/destructive_analyzer = 8,
		/obj/structure/salvageable/server = 8,
	)

	feature_spawn_list = list(/obj/structure/geyser/random = 1, /obj/effect/mine/shrapnel/human_only = 1)

	flora_spawn_list = list(
		/obj/structure/flora/rock = 3,
		/obj/structure/flora/tree/cactus = 4,
		/obj/structure/flora/ash/cacti = 1,
	)

	feature_spawn_chance = 0
	initial_closed_chance = 30
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3

/turf/closed/mineral/random/asteroid/rockplanet
	name = "iron rock"
	icon = 'icons/turf/mining.dmi'
	icon_state = "redrock"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	base_icon_state = "red_wall"
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	turf_type = /turf/open/floor/plating/asteroid/rockplanet
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 7, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 7, /obj/item/stack/ore/plasma = 15, /obj/item/stack/ore/iron = 55, /obj/item/stack/ore/titanium = 6,
		/turf/closed/mineral/gibtonite/rockplanet = 4, /obj/item/stack/ore/bluespace_crystal = 1)
	mineralChance = 30

/turf/closed/mineral/gibtonite/rockplanet
	name = "iron rock"
	icon = 'icons/turf/mining.dmi'
	icon_state = "redrock"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	base_icon_state = "red_wall"


/turf/open/floor/plating/asteroid/rockplanet
	name = "iron sand"
	icon_state = "ironsand0"
	environment_type = "ironsand"
	turf_type = /turf/open/floor/plating/asteroid/rockplanet
	floor_variance = 45
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/turf/open/floor/plating/asteroid/rockplanet/sand
	name = "iron dirt"
	icon_state = "irondirt0"
	environment_type = "irondirt"
	floor_variance = 0

/turf/open/floor/plating/asteroid/rockplanet/sand/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[environment_type][rand(0,3)]"
