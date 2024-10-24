/datum/planet_type
	///The name we show on examine
	var/name = "planet"
	///The description we show on examine
	var/desc = "A planet."
	///The ID tag this planet uses. Depreciated
	var/planet = null
	///The ID  tag for the set of ruins this planet uses
	var/ruin_type = null
	///The mapgen we set when we are used
	var/mapgen = null
	///The fallback turf if mapgen fails.
	var/default_baseturf = null
	///The gravity we set. If higher than 1, slowdown effects will be applied
	var/gravity = 0
	///The weather we set when we are used
	var/weather_controller_type = null
	///The icon state on the token
	var/icon_state = "globe"
	///The color we set the token to, note this is overridden by fancy overmaps
	var/color = "#ffffff"
	///Our weight when picking a new overmap object
	var/weight = 20
	///Do we not self destruct when a ship undocks with no players left behind?
	var/preserve_level = FALSE
	///The sound we play when we are landed on. Not reccomended outside of stingers.
	var/landing_sound
	///We read from this list to let players know the most common ores on this planet, otherwise does nothing.
	var/list/primary_ores

/datum/planet_type/lava
	name = "lava planet"
	desc = "A planet rife with seismic and volcanic activity. High temperatures and dangerous xenofauna render it dangerous for the unprepared."
	planet = DYNAMIC_WORLD_LAVA
	icon_state = "lava"
	color = COLOR_ORANGE
	mapgen = /datum/map_generator/planet_generator/lava
	default_baseturf = /turf/open/floor/plating/asteroid/basalt/lava
	gravity = STANDARD_GRAVITY
	weather_controller_type = /datum/weather_controller/lavaland
	ruin_type = RUINTYPE_LAVA
	//landing_sound = 'sound/effects/planet_landing_2.ogg'
	primary_ores = list(\
		/obj/item/stack/ore/sulfur,
		/obj/item/stack/ore/galena,
		/obj/item/stack/ore/sulfur/pyrite,
		/obj/item/stack/ore/magnetite,
		/obj/item/stack/ore/plasma,
		)


/datum/planet_type/ice
	name = "frozen planet"
	desc = "A frozen planet covered in thick snow, thicker ice, and dangerous predators."
	planet = DYNAMIC_WORLD_ICE
	icon_state = "ice"
	color = COLOR_BLUE_LIGHT
	mapgen = /datum/map_generator/planet_generator/snow
	default_baseturf = /turf/open/floor/plating/asteroid/snow/icemoon
	gravity = STANDARD_GRAVITY
	weather_controller_type = /datum/weather_controller/snow_planet
	ruin_type = RUINTYPE_ICE
	//landing_sound = 'sound/effects/planet_landing_2.ogg'
	primary_ores = list(\
		/obj/item/stack/ore/malachite,
		/obj/item/stack/ore/quartzite,
		/obj/item/stack/ore/hematite,
		)

/datum/planet_type/jungle
	name = "jungle planet"
	desc = "A densely forested world, filled with vines, animals, and underbrush. Surprisingly habitable with a machete."
	planet = DYNAMIC_WORLD_JUNGLE
	icon_state = "jungle"
	color = COLOR_LIME
	mapgen = /datum/map_generator/planet_generator/jungle
	default_baseturf = /turf/open/floor/plating/dirt/jungle
	gravity = STANDARD_GRAVITY
	weather_controller_type = /datum/weather_controller/lush
	ruin_type = RUINTYPE_JUNGLE
	//landing_sound = 'sound/effects/planet_landing_1.ogg'
	primary_ores = list(\
		/obj/item/stack/ore/graphite/coal,
		/obj/item/stack/ore/malachite,
		/obj/item/stack/ore/sulfur,
		/obj/item/stack/ore/gold,
		/obj/item/stack/ore/diamond, //this isnt very common, but it's more common here than every other planet, so i list it here
		)

/datum/planet_type/rock
	name = "rock planet"
	desc = "A rocky red world in the midst of terraforming. While some plants have taken hold, it is widely hostile to life."
	planet = DYNAMIC_WORLD_ROCKPLANET
	icon_state = "rock"
	color = "#bd1313"
	mapgen = /datum/map_generator/planet_generator/rock
	default_baseturf = /turf/open/floor/plating/asteroid
	gravity = STANDARD_GRAVITY
	weather_controller_type = /datum/weather_controller/rockplanet
	ruin_type = RUINTYPE_ROCK
	//landing_sound = 'sound/effects/planet_landing_2.ogg'
	primary_ores = list(\
		/obj/item/stack/ore/hematite,
		/obj/item/stack/ore/sulfur,
		)

/datum/planet_type/sand
	name = "salty sand planet"
	desc = "A formerly vibrant world, turned to sand by the ravages of the ICW. The survivors of it are long mad by now."
	planet = DYNAMIC_WORLD_SAND
	icon_state = "whitesands"
	color = COLOR_GRAY
	mapgen = /datum/map_generator/planet_generator/sand
	default_baseturf = /turf/open/floor/plating/asteroid/whitesands
	gravity = STANDARD_GRAVITY
	weather_controller_type = /datum/weather_controller/desert
	ruin_type = RUINTYPE_SAND
	//landing_sound = 'sound/effects/planet_landing_2.ogg'
	primary_ores = list(\
		/obj/item/stack/ore/quartzite,
		/obj/item/stack/ore/hematite,
		/obj/item/stack/ore/rutile,
		)


/datum/planet_type/beach
	name = "ocean planet"
	desc = "The platonic ideal of vacation spots. Warm, comfortable temperatures, and a breathable atmosphere."
	planet = DYNAMIC_WORLD_BEACHPLANET
	icon_state = "ocean"
	color = "#c6b597"
	mapgen = /datum/map_generator/planet_generator/beach
	default_baseturf = /turf/open/floor/plating/asteroid/sand/lit
	gravity = STANDARD_GRAVITY
	weather_controller_type = /datum/weather_controller/lush
	ruin_type = RUINTYPE_BEACH
	//landing_sound = 'sound/effects/planet_landing_1.ogg'
	primary_ores = list(\
		/obj/item/stack/ore/hematite,
		/obj/item/stack/ore/malachite,
		/obj/item/stack/ore/plasma,
		)

/datum/planet_type/reebe
	name = "???"
	desc = "Some sort of strange portal. There's no identification of what this is."
	planet = DYNAMIC_WORLD_REEBE
	icon_state = "wormhole"
	color = COLOR_YELLOW
	mapgen = /datum/map_generator/single_biome/reebe
	gravity = STANDARD_GRAVITY
	default_baseturf = /turf/open/chasm/reebe_void
	weather_controller_type = null
	weight = 0
	ruin_type = RUINTYPE_YELLOW

/datum/planet_type/asteroid
	name = "legacy asteroid field"
	desc = "A field of asteroids with significant traces of minerals."
	planet = DYNAMIC_WORLD_ASTEROID
	icon_state = "asteroid"
	color = COLOR_GRAY
	mapgen = /datum/map_generator/planet_generator/asteroid
	// Space, because asteroid maps also include space turfs and the prospect of space turfs
	// existing without space as their baseturf scares me.
	default_baseturf = /turf/open/space
	weather_controller_type = null
	ruin_type = null // asteroid ruins when
	weight = 0
	//landing_sound = 'sound/effects/planet_landing_1.ogg'

/datum/planet_type/spaceruin
	name = "weak energy signal"
	desc = "A very weak energy signal originating from space."
	planet = DYNAMIC_WORLD_SPACERUIN
	icon_state = "signal_strange"
	color = null
	mapgen = /datum/map_generator/single_turf/space
	default_baseturf = /turf/open/space
	weather_controller_type = null
	ruin_type = RUINTYPE_SPACE
	//landing_sound = 'sound/effects/planet_landing_2.ogg'

/datum/planet_type/waste
	name = "waste disposal planet"
	desc = "A highly oxygenated world, coated in garbage, radiation, and rust."
	planet = DYNAMIC_WORLD_WASTEPLANET
	icon_state = "waste"
	color = "#a9883e"
	mapgen = /datum/map_generator/planet_generator/waste
	default_baseturf = /turf/open/floor/plating/asteroid/wasteplanet
	gravity = STANDARD_GRAVITY
	weather_controller_type = /datum/weather_controller/chlorine
	ruin_type = RUINTYPE_WASTE
	//landing_sound = 'sound/effects/planet_landing_2.ogg'
	primary_ores = list(\
		/obj/item/stack/ore/sulfur,
		/obj/item/stack/ore/hematite,
		/obj/item/stack/ore/plasma,
		/obj/item/stack/ore/autunite,
		/obj/item/stack/ore/galena,
		/obj/item/stack/ore/plasma,
		)


/datum/planet_type/gas_giant
	name = "gas giant"
	desc = "A floating ball of gas, with high gravity and even higher pressure."
	planet = DYNAMIC_WORLD_GAS_GIANT
	icon_state = "giant"
	color = COLOR_DARK_MODERATE_ORANGE
	mapgen = /datum/map_generator/single_biome/gas_giant
	gravity = GAS_GIANT_GRAVITY
	default_baseturf = /turf/open/chasm/gas_giant
	weather_controller_type = null
	ruin_type = null //it's a Gas Giant. Not Cloud fuckin City
	weight = 0
	preserve_level = TRUE
	//landing_sound = 'sound/effects/planet_landing_1.ogg'

/datum/planet_type/plasma_giant
	name = "plasma giant"
	desc = "The backbone of interstellar travel, the mighty plasma giant allows fuel collection to take place."
	planet = DYNAMIC_WORLD_PLASMA_GIANT
	color = COLOR_PURPLE
	mapgen = /datum/map_generator/single_biome/plasma_giant
	gravity = GAS_GIANT_GRAVITY
	default_baseturf = /turf/open/chasm/gas_giant/plasma
	weight = 0
	icon_state = "giant"
	preserve_level = TRUE
	//landing_sound = 'sound/effects/planet_landing_1.ogg'

/datum/planet_type/water
	name = "aqua planet"
	desc = "A very weak energy signal originating from a planet entirely covered in water with caves with oxygen pockets. (VERY UNFINISHED, YOU HAVE BEEN WARNED)"
	planet = DYNAMIC_WORLD_WATERPLANET
	icon_state = "water"
	color = LIGHT_COLOR_DARK_BLUE
	weight = 5

	ruin_type = RUINTYPE_WATER // minor planets have no ruins
	mapgen = /datum/map_generator/planet_generator/waterplanet
	default_baseturf = /turf/open/water/beach/deep
	weather_controller_type = /datum/weather_controller/waterplanet

/datum/planet_type/desert
	name = "desert planet"
	desc = "A very weak energy signal originating from a very hot and harsh planet."
	planet = DYNAMIC_WORLD_DESERT
	icon_state = "desert"
	color = "#f3c282"
	weight = 5

	ruin_type = RUINTYPE_DESERT // minor planets have no ruins
	mapgen = /datum/map_generator/planet_generator/desert
	default_baseturf = /turf/open/floor/plating/asteroid/desert/lit
	weather_controller_type = /datum/weather_controller/desert_yellow
	primary_ores = list(\
		/obj/item/stack/ore/graphite/coal,
		/obj/item/stack/ore/sulfur,
		/obj/item/stack/ore/quartzite,
		/obj/item/stack/ore/gold,
		)

/datum/planet_type/shrouded
	name = "shrouded planet"
	desc = "A very weak energy signal originating from a planet shrouded in a perpetual storm of bizzare, light absorbing particles."
	planet = DYNAMIC_WORLD_SHROUDED
	icon_state = "shrouded"
	color = "#783ca4"
	weight = 5

	//ruin_type = RUINTYPE_SHROUDED
	mapgen = /datum/map_generator/planet_generator/shrouded
	default_baseturf = /turf/open/floor/plating/asteroid/shrouded
	weather_controller_type = /datum/weather_controller/shrouded

	primary_ores = list(\
		/obj/item/stack/ore/autunite,
		/obj/item/stack/ore/plasma,
		/obj/item/stack/ore/magnetite,
		)

/datum/planet_type/moon
	name = "planetoid moon"
	desc = "A terrestrial satellite orbiting a nearby planet."
	planet = DYNAMIC_WORLD_MOON
	icon_state = "moon"
	color = "#d1c3c3"

	ruin_type = null // minor 'planets' have no ruins
	mapgen = /datum/map_generator/planet_generator/moon
	default_baseturf = /turf/open/floor/plating/asteroid/moon/lit
	weather_controller_type = null

	primary_ores = list(\
		/obj/item/stack/ore/quartzite,
		/obj/item/stack/ore/hematite,
		/obj/item/stack/ore/rutile,
		)

/datum/planet_type/battlefield
	name = "battlefield planet"
	desc = "The site of a major ICW battlefield. The remminants of a major city, colony, or nature reserve, reduced to a muddy hellscape by decades of fighing. Beware the toxic rain, wear a gas mask! (VERY UNFINISHED, YOU HAVE BEEN WARNED)"
	planet = DYNAMIC_WORLD_BATTLEFIELD
	icon_state = "battlefield"
	color = "#b32048"
	weight = 2

	ruin_type = RUINTYPE_BATTLEFIELD // minor 'planets' have no ruins
	mapgen = /datum/map_generator/planet_generator/battlefield
	default_baseturf = /turf/open/floor/plating/dirt/jungle/dark/lit/battlefield
	weather_controller_type = /datum/weather_controller/toxic

/datum/planet_type/debug
	name = "TEST PLANET"
	desc = "Pure white world for testing purposes, report if you see this"
	planet = DYNAMIC_WORLD_TEST
	icon_state = "hazard"
	color = COLOR_WHITE
	mapgen = /datum/map_generator/single_turf/test
	default_baseturf = /turf/open/floor/white/lit
	weather_controller_type = null
	ruin_type = null
	weight = 0
	//landing_sound = 'sound/effects/planet_landing_1.ogg'

/turf/open/floor/white/lit
	light_range = 2
	light_power = 1
	light_color = COLOR_VERY_LIGHT_GRAY
	baseturfs = /turf/open/floor/white/lit

/datum/map_generator/single_turf/test
	turf_type = /turf/open/floor/white/lit
	area_type = /area/overmap_encounter/planetoid

/datum/planet_type/snowball
	name = "snowball planet"
	desc = "A world entirely covered in snow; there is very likely nothing of intrest here."
	planet = DYNAMIC_WORLD_SNOWBALL
	icon_state = "misc"
	color = COLOR_WHITE
	mapgen = /datum/map_generator/single_turf/snowball
	default_baseturf = /turf/open/floor/plating/asteroid/snow/lit/snowball
	weather_controller_type = /datum/weather_controller/snow_planet/severe
	ruin_type = null
	weight = 1
	//landing_sound = 'sound/effects/planet_landing_1.ogg'

/datum/map_generator/single_turf/snowball
	turf_type = /turf/open/floor/plating/asteroid/snow/lit/snowball
	area_type = /area/overmap_encounter/planetoid/snowball

/turf/open/floor/plating/asteroid/snow/lit/snowball
	light_color = "#67769e"
