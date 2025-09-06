/datum/map_generator/planet_generator/moon
	mountain_height = 0.8
	perlin_zoom = 65

	primary_area_type = /area/overmap_encounter/planetoid/moon

	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_LOW_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_HIGH_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/lunar_surface
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_LOW_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_HIGH_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/lunar_surface
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_LOW_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_HIGH_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/lunar_surface
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_LOW_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_HIGH_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/lunar_surface
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/rocky,
			BIOME_LOW_HUMIDITY = /datum/biome/rocky,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_HIGH_HUMIDITY = /datum/biome/lunar_surface,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/lunar_surface,
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/rocky,
			BIOME_LOW_HUMIDITY = /datum/biome/rocky,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/rocky,
			BIOME_HIGH_HUMIDITY = /datum/biome/rocky,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/lunar_surface
		)
	)
	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/moon,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/moon,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/moon,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/moon,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/moon
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/moon,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/moon,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/moon,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/moon,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/moon
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/moon,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/moon,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/moon,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/moon,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/moon
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/moon,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/moon,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/moon,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/moon,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/moon
		)
	)

//biomes

/datum/biome/lunar_surface
	open_turf_types = list(/turf/open/floor/plating/asteroid/moon/lit/surface_craters = 1)
	flora_spawn_chance = 3
	mob_spawn_chance = 0

	feature_spawn_chance = 1
	feature_spawn_list = list(
		/obj/effect/spawner/random/greeble/moon_crater = 15,
		/obj/structure/vein/moon = 2,
		/obj/structure/vein/moon/classtwo = 4,
		/obj/structure/vein/moon/classthree = 1,

	)

/datum/biome/rocky
	open_turf_types = list(/turf/open/floor/plating/asteroid/moon_coarse/lit/surface_craters = 1)

	feature_spawn_chance = 0.3
	feature_spawn_list = list(
		/obj/effect/spawner/random/greeble/moon_crater = 1
	)

/datum/biome/cave/moon
	open_turf_types = list(/turf/open/floor/plating/asteroid/moon = 1)
	closed_turf_types = list(/turf/closed/mineral/random/moon = 1)

	feature_spawn_chance = 0.1
	feature_spawn_list = list(
		/obj/structure/vein/moon = 6,
		/obj/structure/vein/moon/classtwo = 4,
		/obj/structure/vein/moon/classthree = 1,
	)

//Redudent, possibly remove.
/obj/effect/spawner/random/greeble/moon_crater
	name = "random planet greeble chance"
	loot = list(/obj/effect/greeble_spawner/moon)

/obj/effect/greeble_spawner/moon
	name = "moon greeble spawner"
	template_subtype_path = /datum/map_template/greeble/moon/crater

/datum/map_template/greeble/moon/crater/crater_1
	name = "Crater 1"
	mappath = "_maps/templates/greebles/moon/moon_crater_1.dmm"

/datum/map_template/greeble/moon/crater/crater_2
	name = "Crater 2"
	mappath = "_maps/templates/greebles/moon/moon_crater_2.dmm"

/datum/map_template/greeble/moon/crater/crater_3
	name = "Crater 3"
	mappath = "_maps/templates/greebles/moon/moon_crater_3.dmm"

/datum/map_template/greeble/moon/crater/crater_4
	name = "Crater 4"
	mappath = "_maps/templates/greebles/moon/moon_crater_4.dmm"

/datum/map_template/greeble/moon/crater/crater_5
	name = "Crater 5"
	mappath = "_maps/templates/greebles/moon/moon_crater_5.dmm"

/datum/map_template/greeble/moon/crater/crater_6
	name = "Crater 6"
	mappath = "_maps/templates/greebles/moon/moon_crater_6.dmm"
