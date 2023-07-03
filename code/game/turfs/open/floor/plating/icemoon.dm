//Ice Planets now begin

/turf/open/floor/planetary/iceplanet
	name = "icy rock"
	desc = "The coarse rock that covers the surface."
	icon = 'icons/turf/snow.dmi'
	baseturfs = /turf/open/floor/planetary/iceplanet
	icon_state = "icemoon_ground_coarse1"
	icon_plating = "icemoon_ground_coarse1"
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	base_icon_state = "icemoon_ground_coarse"
	footstep = FOOTSTEP_ICE
	barefootstep = FOOTSTEP_ICE
	clawfootstep = FOOTSTEP_ICE
	broken_states = list("icemoon_ground_cracked")
	burnt_states = list("icemoon_ground_smooth")
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	floor_variance = 100
	max_icon_states = 7
	can_dig = FALSE
	floor_variants = TRUE
	light_color = COLOR_ICEPLANET_LIGHT

/turf/open/floor/planetary/iceplanet/cracked
	floor_variance = 0
	icon_state = "icemoon_ground_cracked"
	base_icon_state = "icemoon_ground_cracked"

/turf/open/floor/planetary/iceplanet/smooth
	floor_variance = 0
	icon_state = "icemoon_ground_smooth"
	base_icon_state = "icemoon_ground_smooth"

/turf/open/floor/planetary/iceplanet/lit
	baseturfs = /turf/open/floor/planetary/iceplanet/lit
	lit = TRUE

/turf/open/floor/planetary/iceplanet/smooth/lit
	baseturfs = /turf/open/floor/planetary/iceplanet/lit
	lit = TRUE

/turf/open/floor/planetary/iceplanet/cracked/lit
	baseturfs = /turf/open/floor/planetary/iceplanet/lit
	lit = TRUE

//This is so fucking snowflake
//Shut up.

//Snow

/turf/open/floor/planetary/snow/iceplanet
	baseturfs = /turf/open/floor/planetary/iceplanet
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	light_color = COLOR_ICEPLANET_LIGHT

/turf/open/floor/planetary/snow/iceplanet/under
	icon_state = "snow_dug"
	planetary_atmos = TRUE
	can_dig = FALSE

/turf/open/floor/planetary/snow/iceplanet/lit
	baseturfs = /turf/open/floor/planetary/iceplanet/lit
	lit = TRUE

/turf/open/floor/planetary/snow/iceplanet/under/lit
	baseturfs = /turf/open/floor/planetary/iceplanet/lit
	lit = TRUE

//and colder snow. I hate this file honestly

/turf/open/floor/planetary/snow/iceplanet/ice
	name = "icy snow"
	desc = "Looks colder."
	baseturfs = /turf/open/floor/planetary/snow/iceplanet/ice
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	floor_variance = 0
	icon_state = "snow-ice"
	icon_plating = "snow-ice"
	base_icon_state = "snow_cavern"
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	max_icon_states = 7
	can_burn = FALSE

/turf/open/floor/planetary/snow/iceplanet/ice/lit
	baseturfs = /turf/open/floor/planetary/snow/iceplanet/ice/lit
	lit = TRUE

//now the iceberg tile

/turf/open/floor/planetary/iceplanet/iceberg
	name = "cracked ice floor"
	desc = "A sheet of solid ice. It seems too cracked to be slippery anymore."
	baseturfs = /turf/open/floor/planetary/iceplanet/iceberg
	icon_state = "iceberg"
	icon_plating = "iceberg"
	base_icon_state = "iceberg"
	broken_states = list("iceberg")

/turf/open/floor/planetary/iceplanet/iceberg/lit
	baseturfs = /turf/open/floor/planetary/iceplanet/iceberg/lit
	lit = TRUE

//and the actual ice

/turf/open/floor/planetary/ice/iceplanet
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	light_color = COLOR_ICEPLANET_LIGHT
	baseturfs = /turf/open/floor/planetary/iceplanet/iceberg

/turf/open/floor/planetary/ice/iceplanet/iceberg
	name = "cracked ice floor"
	desc = "A sheet of solid ice. It looks cracked, yet still slippery."
	icon_state = "ice1"

/turf/open/floor/planetary/ice/iceplanet/lit
	lit = TRUE
	baseturfs = /turf/open/floor/planetary/iceplanet/iceberg/lit

/turf/open/floor/planetary/ice/iceplanet/iceberg/lit
	lit = TRUE
	baseturfs = /turf/open/floor/planetary/iceplanet/iceberg/lit

//liquid cold plasma

/turf/open/floor/planetary/lava/plasma/iceplanet
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/planetary/lava/plasma/iceplanet
	//it inherits these but I'm restating it for clarity
	light_range = 3
	light_power = 0.75
	light_color = LIGHT_COLOR_PURPLE
