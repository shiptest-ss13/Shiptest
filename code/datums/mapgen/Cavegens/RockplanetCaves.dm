#define ROCKPLANET_DEFAULT_ATMOS "co2=95;n2=3;TEMP=210.15"

/datum/map_generator/cave_generator/rockplanet
	open_turf_types = list(/turf/open/floor/plating/asteroid/rockplanet = 5,
						/turf/open/floor/plating/asteroid/rockplanet/sand = 1)

	closed_turf_types =  list(/turf/closed/mineral/random/asteroid/rockplanet = 1)

	mob_spawn_chance = 3

	mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goliath = 20,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 10,
//		/mob/living/simple_animal/hostile/ooze/grapes/asteroid = 20,
		/mob/living/simple_animal/hostile/asteroid/fugu = 30,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 50,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 10,
		/mob/living/simple_animal/hostile/alien/asteroid = 20,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10)


	flora_spawn_list = list(
		/obj/structure/flora/rock/jungle = 2,
		/obj/structure/flora/junglebush = 2,
		/obj/structure/flora/junglebush = 2,
		/obj/structure/flora/ash/cacti = 1)

		/obj/structure/salvageable/machine = 20,
		/obj/structure/salvageable/autolathe = 15,
		/obj/structure/salvageable/computer = 10,
		/obj/structure/salvageable/protolathe = 10,
		/obj/structure/salvageable/circuit_imprinter = 8,
		/obj/structure/salvageable/destructive_analyzer = 8,
		/obj/structure/salvageable/server = 8,
	)

	feature_spawn_list = list(/obj/structure/geyser/random = 1, /obj/effect/mine/shrapnel/human_only = 1)

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

/turf/open/floor/plating/asteroid/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[environment_type][rand(0,3)]"
