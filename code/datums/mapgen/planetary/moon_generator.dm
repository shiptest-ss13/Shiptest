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
		/obj/effect/spawner/random/greeble/random_ruin_greeble = 1
	)

/datum/biome/rocky
	open_turf_types = list(/turf/open/floor/plating/asteroid/moon_coarse/lit/surface_craters = 1)

	feature_spawn_chance = 0.5
	feature_spawn_list = list(
		/obj/effect/spawner/random/greeble/random_ruin_greeble = 1
	)

/datum/biome/cave/moon
	open_turf_types = list(/turf/open/floor/plating/asteroid/moon = 1)
	closed_turf_types = list(/turf/closed/mineral/random/moon = 1)
//	flora_spawn_chance = 4
//	flora_spawn_list = list(/obj/structure/flora/rock/beach = 1, /obj/structure/flora/rock/asteroid = 6)


//GREEBLES

/obj/effect/spawner/random/greeble/random_ruin_greeble
	name = "random planet greeble chance"
	loot = list(
			/obj/effect/greeble_spawner/moon/crater1 = 5,
			/obj/effect/greeble_spawner/moon/crater2 = 5,
			/obj/effect/greeble_spawner/moon/crater3 = 5,
			/obj/effect/greeble_spawner/moon/crater4 = 5,
			/obj/effect/greeble_spawner/moon/crater5 = 5,
			/obj/effect/greeble_spawner/moon/crater6 = 5,
		)

/obj/effect/greeble_spawner
	name = "planet greeble spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x"
	var/datum/map_template/greeble/template

/obj/effect/greeble_spawner/Destroy()
	template = null // without this, capsules would be one use. per round.
	. = ..()

/obj/effect/greeble_spawner/Initialize()
	. = ..()
	template = new template()
	if(!template)
		WARNING("Greeble template not found!")
		return INITIALIZE_HINT_QDEL

	var/turf/deploy_location = get_turf(src)
	var/status = template.check_deploy(deploy_location)

	if(status != SHELTER_DEPLOY_ALLOWED)
		return INITIALIZE_HINT_QDEL

	INVOKE_ASYNC(src, /obj/effect/greeble_spawner/.proc/load_template)

/obj/effect/greeble_spawner/proc/load_template()
	var/turf/deploy_location = get_turf(src)
	template.load(deploy_location, centered = TRUE)
	qdel(src)

/obj/effect/greeble_spawner/moon
	name = "moon greeble spawner"

/obj/effect/greeble_spawner/moon/crater1
	template = /datum/map_template/greeble/moon/crater1

/obj/effect/greeble_spawner/moon/crater2
	template = /datum/map_template/greeble/moon/crater2

/obj/effect/greeble_spawner/moon/crater3
	template = /datum/map_template/greeble/moon/crater3

/obj/effect/greeble_spawner/moon/crater4
	template = /datum/map_template/greeble/moon/crater4

/obj/effect/greeble_spawner/moon/crater5
	template = /datum/map_template/greeble/moon/crater5

/obj/effect/greeble_spawner/moon/crater6
	template = /datum/map_template/greeble/moon/crater6

/datum/map_template/greeble
	var/description
	var/blacklisted_turfs
	var/whitelisted_turfs
	var/banned_areas
	var/banned_objects
	var/clear_everything = FALSE

/datum/map_template/greeble/New()
	. = ..()
	banned_areas = typecacheof(/area/ship, /area/overmap_encounter/planetoid/cave, /area/ruin)
	blacklisted_turfs = typecacheof(list(/turf/closed, /turf/open/indestructible))
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/greeble/proc/check_deploy(turf/deploy_location)
	var/affected = get_affected_turfs(deploy_location, centered=TRUE)
	for(var/turf/T in affected)
		var/area/A = get_area(T)
		if(is_type_in_typecache(A, banned_areas))
			return SHELTER_DEPLOY_BAD_AREA

		var/banned = is_type_in_typecache(T, blacklisted_turfs)
		var/permitted = is_type_in_typecache(T, whitelisted_turfs)
		if(banned && !permitted)
			return SHELTER_DEPLOY_BAD_TURFS

		for(var/obj/O in T)
			if((O.density && O.anchored) || is_type_in_typecache(O, banned_objects))
				return SHELTER_DEPLOY_ANCHORED_OBJECTS


	if(clear_everything)
		for(var/turf/T in affected)
			for(var/obj/O in T)
				if(istype(O, /obj/effect/greeble_spawner))
					continue
				qdel(O)
			for(var/mob/M in T)
				qdel(M)

	return SHELTER_DEPLOY_ALLOWED

/datum/map_template/greeble/moon/crater1
	name = "Crater 1"
	mappath = "_maps/templates/greebles/moon_crater1.dmm"

/datum/map_template/greeble/moon/crater2
	name = "Crater 2"
	mappath = "_maps/templates/greebles/moon_crater2.dmm"

/datum/map_template/greeble/moon/crater3
	name = "Crater 3"
	mappath = "_maps/templates/greebles/moon_crater3.dmm"

/datum/map_template/greeble/moon/crater4
	name = "Crater 4"
	mappath = "_maps/templates/greebles/moon_crater4.dmm"

/datum/map_template/greeble/moon/crater5
	name = "Crater 5"
	mappath = "_maps/templates/greebles/moon_crater5.dmm"

/datum/map_template/greeble/moon/crater6
	name = "Crater 6"
	mappath = "_maps/templates/greebles/moon_crater6.dmm"

//TURFS

/turf/open/floor/plating/asteroid/moon
	gender = PLURAL
	name = "regolith"
	desc = "Supposedly poisonous to humanoids."
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark
	icon = 'icons/turf/planetary/moon.dmi'
	icon_state = "moonsand"
	base_icon_state = "moonsand"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	layer = SAND_TURF_LAYER
	planetary_atmos = TRUE
	initial_gas_mix = AIRLESS_ATMOS
	slowdown = 1.1 //hardsuits will slow enough
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH)

	floor_variance = 0
	max_icon_states = 0

	has_footsteps = TRUE
	footstep_icon_state = "moon"

	smooth_icon = 'icons/turf/floors/moonsand.dmi'

/turf/open/floor/plating/asteroid/sand/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-19, -19)
		transform = translation
		icon = smooth_icon
		icon_plating = null

/turf/open/floor/plating/asteroid/moon/lit
	light_range = 2
	light_power = 1
	light_color = "#FFFFFF" // should look liminal, due to moons lighting
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark/lit

/turf/open/floor/plating/asteroid/moon/lit/surface_craters/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(8.3)) //calculator tells me this is 1 in 12
		getDug(TRUE)

/turf/open/floor/plating/asteroid/moon_coarse
	name = "coarse regolith"
	desc = "Harder moonrock, less dusty."
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark
	icon = 'icons/turf/planetary/moon.dmi'
	icon_state = "moonsand_coarse"
	base_icon_state = "moonsand_coarse"
	gender = PLURAL
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	floor_variance = 0
	max_icon_states = 0
	planetary_atmos = TRUE
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/asteroid/moon_coarse/lit
	light_range = 2
	light_power = 1
	light_color = "#FFFFFF" // should look liminal, due to moons lighting
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark/lit

/turf/open/floor/plating/asteroid/moon_coarse/lit/surface_craters
	floor_variance = 10
	max_icon_states = 0

/turf/open/floor/plating/asteroid/moon_coarse/lit/surface_craters/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(icon_state == "[base_icon_state]0")
		getDug(TRUE)

/turf/open/floor/plating/asteroid/moon_coarse/dark
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark
	icon_state = "moonsand_coarse_dark"
	base_icon_state = "moonsand_coarse_dark"

/turf/open/floor/plating/asteroid/moon_coarse/dark/lit
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark/lit
	light_range = 2
	light_power = 1
	light_color = "#FFFFFF" // should look liminal, due to moons lighting


/turf/closed/mineral/random/moon
	name = "moonrock"
	desc = "A great portal conductor, supposedly."
	icon = 'icons/turf/walls/moon.dmi'
	smooth_icon = 'icons/turf/walls/moon.dmi'
	icon_state = "moon-0"
	base_icon_state = "moon"
	initial_gas_mix = AIRLESS_ATMOS
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	turf_type = /turf/open/floor/plating/asteroid/moon_coarse/dark
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark
	mineralSpawnChanceList = list(/obj/item/stack/ore/autunite = 2, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/galena = 2, /obj/item/stack/ore/plasma = 1, /obj/item/stack/ore/hematite = 40, /obj/item/stack/ore/rutile = 20,
		/obj/item/stack/ore/bluespace_crystal = 5, /obj/item/stack/ore/quartzite = 80)

/turf/closed/mineral/random/moon/lit
	turf_type = /turf/open/floor/plating/asteroid/moon_coarse/dark/lit
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark/lit
