/datum/planet_type
	var/name = "planet"
	var/desc = "A planet."
	var/planet = null
	var/ruin_type = null
	var/mapgen = null
	var/default_baseturf = null
	var/weather_controller_type = null
	var/icon_state = "globe"
	var/color = "#ffffff"
	var/weight = 20

/datum/planet_type/lava
	name = "lava planet"
	desc = "A very weak energy signal originating from a planet with lots of seismic and volcanic activity."
	planet = DYNAMIC_WORLD_LAVA
	icon_state = "globe"
	color = COLOR_ORANGE
	mapgen = /datum/map_generator/planet_generator/lava
	default_baseturf = /turf/open/floor/plating/asteroid/basalt/lava
	weather_controller_type = /datum/weather_controller/lavaland
	ruin_type = RUINTYPE_LAVA

/datum/planet_type/ice
	name = "frozen planet"
	desc = "A very weak energy signal originating from a planet with traces of water and extremely low temperatures."
	planet = DYNAMIC_WORLD_ICE
	icon_state = "globe"
	color = COLOR_BLUE_LIGHT
	mapgen = /datum/map_generator/planet_generator/snow
	default_baseturf = /turf/open/floor/plating/asteroid/snow/icemoon
	weather_controller_type = /datum/weather_controller/snow_planet
	ruin_type = RUINTYPE_ICE

/datum/planet_type/jungle
	name = "jungle planet"
	desc = "A very weak energy signal originating from a planet teeming with life."
	planet = DYNAMIC_WORLD_JUNGLE
	icon_state = "globe"
	color = COLOR_LIME
	mapgen = /datum/map_generator/planet_generator/jungle
	default_baseturf = /turf/open/floor/plating/dirt/jungle
	weather_controller_type = /datum/weather_controller/lush
	ruin_type = RUINTYPE_JUNGLE

/datum/planet_type/rock
	name = "rock planet"
	desc = "A very weak energy signal originating from a iron rich and rocky planet."
	planet = DYNAMIC_WORLD_ROCKPLANET
	icon_state = "globe"
	color = "#bd1313"
	mapgen = /datum/map_generator/planet_generator/rock
	default_baseturf = /turf/open/floor/plating/asteroid
	weather_controller_type = /datum/weather_controller/rockplanet
	ruin_type = RUINTYPE_ROCK

/datum/planet_type/sand
	name = "sand planet"
	desc = "A very weak energy signal originating from a planet with many traces of silica."
	planet = DYNAMIC_WORLD_SAND
	icon_state = "globe"
	color = COLOR_GRAY
	mapgen = /datum/map_generator/planet_generator/sand
	default_baseturf = /turf/open/floor/plating/asteroid/whitesands
	weather_controller_type = /datum/weather_controller/desert
	ruin_type = RUINTYPE_SAND

/datum/planet_type/beach
	name = "beach planet"
	desc = "A very weak energy signal originating from a warm, oxygen rich planet."
	planet = DYNAMIC_WORLD_BEACHPLANET
	icon_state = "globe"
	color = "#c6b597"
	mapgen = /datum/map_generator/planet_generator/beach
	default_baseturf = /turf/open/floor/plating/asteroid/sand/lit
	weather_controller_type = /datum/weather_controller/lush
	ruin_type = RUINTYPE_BEACH

/datum/planet_type/reebe
	name = "???"
	desc = "Some sort of strange portal. There's no identification of what this is."
	planet = DYNAMIC_WORLD_REEBE
	icon_state = "wormhole"
	color = COLOR_YELLOW
	mapgen = /datum/map_generator/single_biome/reebe
	default_baseturf = /turf/open/chasm/reebe_void
	weather_controller_type = null
	weight = 0
	ruin_type = RUINTYPE_YELLOW

/datum/planet_type/asteroid
	name = "large asteroid"
	desc = "A large asteroid with significant traces of minerals."
	planet = DYNAMIC_WORLD_ASTEROID
	icon_state = "asteroid"
	color = COLOR_GRAY
	mapgen = /datum/map_generator/single_biome/asteroid
	// Space, because asteroid maps also include space turfs and the prospect of space turfs
	// existing without space as their baseturf scares me.
	default_baseturf = /turf/open/space
	weather_controller_type = null
	ruin_type = null // asteroid ruins when

/datum/planet_type/spaceruin
	name = "weak energy signal"
	desc = "A very weak energy signal originating from space."
	planet = DYNAMIC_WORLD_SPACERUIN
	icon_state = "strange_event"
	color = null
	mapgen = /datum/map_generator/single_turf/space
	default_baseturf = /turf/open/space
	weather_controller_type = null
	ruin_type = RUINTYPE_SPACE

/datum/planet_type/waste
	name = "waste disposal planet"
	desc = "A very weak energy signal originating from a planet marked as waste disposal."
	planet = DYNAMIC_WORLD_WASTEPLANET
	icon_state = "globe"
	color = "#a9883e"
	mapgen = /datum/map_generator/planet_generator/waste
	default_baseturf = /turf/open/floor/plating/asteroid/wasteplanet
	weather_controller_type = /datum/weather_controller/chlorine
	ruin_type = RUINTYPE_WASTE
