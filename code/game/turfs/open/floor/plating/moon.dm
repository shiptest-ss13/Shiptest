//TURFS

/turf/open/floor/plating/asteroid/moon
	gender = PLURAL
	name = "regolith"
	desc = "Supposedly poisonous to humanoids."
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark
	icon = 'icons/turf/floors/moonsand.dmi'
	icon_state = "sand-255"
	base_icon_state = "sand"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	layer = SAND_TURF_LAYER
	planetary_atmos = TRUE
	initial_gas_mix = AIRLESS_ATMOS
	slowdown = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH)
	MAP_SWITCH(pixel_x = 0, pixel_x = -19)
	MAP_SWITCH(pixel_y = 0, pixel_y = -19)

	floor_variance = 83
	max_icon_states = 5

	has_footsteps = TRUE
	footstep_icon_state = "moon"

	smooth_icon = 'icons/turf/floors/moonsand.dmi'

/turf/open/floor/plating/asteroid/moon/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(floor_variance))
		add_overlay("sandalt_[rand(1,max_icon_states)]")

/turf/open/floor/plating/asteroid/sand/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-19, -19)
		transform = translation
		icon = smooth_icon
		icon_plating = null

/turf/open/floor/plating/asteroid/moon/safe
	planetary_atmos = FALSE
	initial_gas_mix = "o2=22;n2=82;TEMP=293.15"


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
	footstep = FOOTSTEP_ASTEROID
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

