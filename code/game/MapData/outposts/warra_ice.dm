#define COLOR_WARRA_OUTPOST_LIGHTING "#1B1D2E"
#define YEBIRI_ATMOS "o2=22;n2=82;TEMP=261.15"

#define WARRA_OUTPOST_TURF_HELPER(turf_type)			\
	/turf/open/floor/##turf_type/warra_outpost {		\
		initial_gas_mix = YEBIRI_ATMOS;					\
		planetary_atmos = TRUE;							\
		light_color = COLOR_WARRA_OUTPOST_LIGHTING;		\
	}													\
	/turf/open/floor/##turf_type/warra_outpost/lit {	\
		light_power = 1;								\
		light_range = 2;								\
	}

WARRA_OUTPOST_TURF_HELPER(plating/asteroid/snow)
WARRA_OUTPOST_TURF_HELPER(plating/asteroid/snow/no_smooth)
WARRA_OUTPOST_TURF_HELPER(plating/asteroid/icerock)
WARRA_OUTPOST_TURF_HELPER(plating/ice)
WARRA_OUTPOST_TURF_HELPER(plating)
WARRA_OUTPOST_TURF_HELPER(hangar)
WARRA_OUTPOST_TURF_HELPER(plasteel/patterned)
WARRA_OUTPOST_TURF_HELPER(plasteel/patterned/cargo_one)
WARRA_OUTPOST_TURF_HELPER(plasteel/patterned/brushed)
WARRA_OUTPOST_TURF_HELPER(plasteel/tech/grid)
WARRA_OUTPOST_TURF_HELPER(plasteel/tech)

/area/outpost/exterior/warra
	name = "Yebiri External"
	sound_environment = SOUND_ENVIRONMENT_CITY
	ambience_index = AMBIENCE_SPOOKY

/area/outpost/exterior/warra/wilderness
	name = "Yebiri Wilderness"
	sound_environment = SOUND_ENVIRONMENT_FOREST
	ambience_index = AMBIENCE_TUNDRA
	icon_state = "space_near"

/turf/open/floor/plating/asteroid/snow/no_smooth
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_SNOWED, SMOOTH_GROUP_FLOOR_PLASTEEL)
