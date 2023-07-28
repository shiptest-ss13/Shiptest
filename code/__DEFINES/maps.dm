/*
The /tg/ codebase allows mixing of hardcoded and dynamically-loaded z-levels.
Z-levels can be reordered as desired and their properties are set by "traits".
See map_config.dm for how a particular station's traits may be chosen.
The list DEFAULT_MAP_TRAITS at the bottom of this file should correspond to
the maps that are hardcoded, as set in _maps/_basemap.dm. SSmapping is
responsible for loading every non-hardcoded z-level.

As of 2018-02-04, the typical z-levels for a single-level station are:
1: CentCom
2: Station
3-4: Randomized space
5: Mining
6: City of Cogs
7-11: Randomized space
12: Empty space
13: Transit space

Multi-Z stations are supported and multi-Z mining and away missions would
require only minor tweaks.
*/

// helpers for modifying jobs, used in various job_changes.dm files

#define MAP_CURRENT_VERSION 1

#define SPACERUIN_MAP_EDGE_PAD 15

// traits
// boolean - marks a level as having that property if present
#define ZTRAIT_CENTCOM "CentCom"
#define ZTRAIT_STATION "Station"
#define ZTRAIT_MINING "Mining"
#define ZTRAIT_RESERVED "Reserved"
#define ZTRAIT_AWAY "Away Mission"
#define ZTRAIT_SPACE_RUINS "Space Ruins"

// enum - how SSsun should calculate sun exposure on this level
// if left null, AZIMUTH is assumed
#define ZTRAIT_SUN_TYPE "Sun Cycle Type"
	// default & original SSsun behaviour - orbit the 'station' horizontially.
	// solar panels will cast a line (default 20 steps) and if it is occluded they lose sunlight
	#define AZIMUTH null
	// static, exposed
	// the solar panel must be within 1 tile of space, or another "groundless" turf, to be exposed to sunlight
	#define STATIC_EXPOSED "Static Exposed"
	// static, obscured
	// solar panels are never exposed to sunlight
	#define STATIC_OBSCURED "Static Obscured"

// number - bombcap is multiplied by this before being applied to bombs
#define ZTRAIT_BOMBCAP_MULTIPLIER "Bombcap Multiplier"

// number - default gravity if there's no gravity generators or area overrides present
#define ZTRAIT_GRAVITY "Gravity"

// string - type path of the z-level's baseturf (defaults to space)
#define ZTRAIT_BASETURF "Baseturf"

// default trait definitions, used by SSmapping
#define ZTRAITS_CENTCOM list(ZTRAIT_CENTCOM = TRUE)
#define ZTRAITS_STATION list(ZTRAIT_STATION = TRUE)
#define ZTRAITS_SPACE list(ZTRAIT_SPACE_RUINS = TRUE)
#define ZTRAITS_LAVALAND list( \
	ZTRAIT_MINING = TRUE, \
	ZTRAIT_BOMBCAP_MULTIPLIER = 2, \
	ZTRAIT_BASETURF = /turf/open/lava/smooth/lava_land_surface)
#define ZTRAITS_WHITESANDS list( \
	ZTRAIT_MINING = TRUE, \
	ZTRAIT_BOMBCAP_MULTIPLIER = 2, \
	ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid/whitesands)
#define ZTRAITS_ICEMOON list( \
	ZTRAIT_MINING = TRUE, \
	ZTRAIT_BOMBCAP_MULTIPLIER = 2, \
	ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid/snow/ice)
#define ZTRAITS_ICEMOON_UNDERGROUND list( \
	ZTRAIT_MINING = TRUE, \
	ZTRAIT_BOMBCAP_MULTIPLIER = 2, \
	ZTRAIT_BASETURF = /turf/open/lava/plasma/ice_moon)

#define DL_NAME "name"
#define DL_TRAITS "traits"
#define DECLARE_LEVEL(NAME, TRAITS) list(DL_NAME = NAME, DL_TRAITS = TRAITS)

// must correspond to _basemap.dm for things to work correctly
#define DEFAULT_MAP_TRAITS list( \
	DECLARE_LEVEL("CentCom", ZTRAITS_CENTCOM), \
)

//Reserved turf type
#define RESERVED_TURF_TYPE /turf/open/space/basic //What the turf is when not being used

//Ruin Generation

#define PLACEMENT_TRIES 100 //How many times we try to fit the ruin somewhere until giving up (really should just swap to some packing algo)

#define PLACE_DEFAULT "random"
#define PLACE_SAME_Z "same" //On same z level as original ruin
#define PLACE_SPACE_RUIN "space" //On space ruin z level(s)
#define PLACE_LAVA_RUIN "lavaland" //On lavaland ruin z levels(s)
#define PLACE_BELOW "below" //On z levl below - centered on same tile
#define PLACE_RESERVED "reserved" //On reserved ruin z level


///Map generation defines
#define BIOME_LOWEST_HUMIDITY "biome_lowest_humidity"
#define BIOME_LOW_HUMIDITY "biome_low_humidity"
#define BIOME_MEDIUM_HUMIDITY "biome_medium_humidity"
#define BIOME_HIGH_HUMIDITY "biome_high_humidity"
#define BIOME_HIGHEST_HUMIDITY "biome_highest_humidity"

#define BIOME_COLDEST "coldest"
#define BIOME_COLD "cold"
#define BIOME_WARM "warm"
#define BIOME_TEMPERATE "perfect"
#define BIOME_HOT "hot"
#define BIOME_HOTTEST "hottest"

#define BIOME_COLDEST_CAVE "coldest_cave"
#define BIOME_COLD_CAVE "cold_cave"
#define BIOME_WARM_CAVE "warm_cave"
#define BIOME_HOT_CAVE "hot_cave"


#define ALLOCATION_FREE 1
#define ALLOCATION_QUADRANT 2

#define QUADRANT_MAP_SIZE 127

#define QUADRANT_SIZE_BORDER 3
#define TRANSIT_SIZE_BORDER 3

#define DEFAULT_ALLOC_JUMP 5

#define MAP_EDGE_PAD 5
