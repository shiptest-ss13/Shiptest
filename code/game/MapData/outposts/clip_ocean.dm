#define COLOR_ARROWSONG_LIGHTING "#97442f"
#define ARROWSONG_ATMOS "o2=22;n2=82;TEMP=305"

#define ARROWSONG_TURF_HELPER(turf_type)			\
	/turf/open/floor/##turf_type/clip_outpost {		\
		initial_gas_mix = ARROWSONG_ATMOS;					\
		planetary_atmos = TRUE;							\
		light_color = COLOR_ARROWSONG_LIGHTING;		\
	}													\
	/turf/open/floor/##turf_type/clip_outpost/lit {	\
		light_power = 1;								\
		light_range = 2;								\
	}

ARROWSONG_TURF_HELPER(plating)
ARROWSONG_TURF_HELPER(hangar)
ARROWSONG_TURF_HELPER(plasteel/dark)
ARROWSONG_TURF_HELPER(plasteel/tech)
ARROWSONG_TURF_HELPER(plating/asteroid/waterplanet)
