#define ROCKPLANET_DEFAULT_ATMOS "co2=95;n2=3;TEMP=210.15"

/datum/map_generator/cave_generator/rockplanet
	open_turf_types = list(/turf/open/floor/plating/asteroid/rockplanet = 5,
						/turf/open/floor/plating/asteroid/rockplanet/cracked = 1)

	closed_turf_types =  list(/turf/closed/mineral/random/asteroid/rockplanet = 1)

	mob_spawn_chance = 2
	flora_spawn_chance = 5
	mob_spawn_chance = 3

	mob_spawn_list = list(/mob/living/simple_animal/hostile/netherworld/asteroid = 30,
		/mob/living/simple_animal/hostile/asteroid/fugu/asteroid = 30,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 20, //mariuce
//		/mob/living/simple_animal/hostile/ooze/grapes/asteroid = 20,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 30,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 50,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 20,
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
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
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
	icon_state = "dry_soft0"
	base_icon_state = "dry_soft"
	floor_variance = 100
	max_icon_states = 7
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet

/turf/open/floor/plating/asteroid/rockplanet/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/asteroid/rockplanet/cracked
	name = "iron cracked sand"
	icon_state = "dry_cracked0"
	base_icon_state = "dry_cracked"
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet

/turf/open/floor/plating/asteroid/rockplanet/cracked/lit
	light_range = 2
	light_power = 0.6
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet/lit
	turf_type = /turf/open/floor/plating/asteroid/rockplanet/lit

/turf/open/floor/plating/asteroid/rockplanet/wet
	icon_state = "wet_soft0"
	base_icon_state = "wet_soft"

/turf/open/floor/plating/asteroid/rockplanet/wet/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/asteroid/rockplanet/wet/cracked
	name = "iron cracked sand"
	icon_state = "wet_cracked0"
	base_icon_state = "wet_cracked"

/turf/open/floor/plating/asteroid/rockplanet/wet/cracked/lit
	light_range = 2
	light_power = 0.6
