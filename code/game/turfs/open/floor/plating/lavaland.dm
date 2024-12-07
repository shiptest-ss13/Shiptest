///baseturf

/turf/open/floor/plating/asteroid/basalt
	name = "basalt"
	baseturfs = /turf/open/floor/plating/asteroid/basalt
	icon = 'icons/turf/planetary/lava.dmi'
	icon_state = "basalt"
	base_icon_state = "basalt"
	floor_variance = 0
	digResult = /obj/item/stack/ore/glass/basalt
	light_color = COLOR_LAVAPLANET_LIGHT

	layer = STONE_TURF_LAYER

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH_ROCKY)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH_ROCKY)
	smooth_icon = 'icons/turf/floors/basalt.dmi'

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/asteroid/basalt/lava //lava underneath
	baseturfs = /turf/open/lava/smooth

/turf/open/floor/plating/asteroid/basalt/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/asteroid/basalt/Initialize(mapload, inherited_virtual_z)
	. = ..()

/turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/lava/smooth/lava_land_surface

///Sand

/turf/open/floor/plating/asteroid/purple
	name = "volcanic sand"
	desc = "Sand, filled with a wide array of volcanic minerals have turned it a soft black color. Suprisingly good for plants, all things considered"
	icon = 'icons/turf/lavaland_purple.dmi'
	smooth_icon = 'icons/turf/floors/volcanicsand.dmi'

	icon_state = "sand-255"
	base_icon_state = "sand"

	baseturfs = /turf/open/floor/plating/asteroid/purple
	digResult = /obj/item/stack/ore/glass/basalt
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_LAVAPLANET_LIGHT

	slowdown = 1.5

	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND

	has_footsteps = TRUE
	footstep_icon_state = "shrouded"

	floor_variance = 83
	max_icon_states = 5

	layer = SAND_TURF_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH)


/turf/open/floor/plating/asteroid/purple/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(floor_variance))
		add_overlay("sandalt_[rand(1,max_icon_states)]")

/turf/open/floor/plating/asteroid/purple/lit
	light_range = 2
	light_power = 0.3
	baseturfs = /turf/open/floor/plating/asteroid/purple/lit

///Grass

/turf/open/floor/plating/asteroid/dirt/grass/lavaland

	name = "crimson grass"
	desc = "This grass is actually native to Teceti. It has adapted extremely well to the hot enviroments of lava planets, as it is adept at absorbing the red light that passes the atmosphere."
	baseturfs = /turf/open/floor/plating/asteroid/purple/lit
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	icon = 'icons/turf/floors/crimsongrass.dmi'
	smooth_icon = 'icons/turf/floors/crimsongrass.dmi'
	light_range = 2
	light_power = 0.6
	light_color = COLOR_LAVAPLANET_LIGHT

//legacy grass tiles, deprecated but not removed yet as to avoid a massive repath
/turf/open/floor/plating/grass/lava
	name = "crimson grass"
	desc = "This grass is actually native to Teceti. It has adapted extremely well to the hot enviroments of lava planets, as well as absorbing the non-absorbed red light of the atmosphere."
	baseturfs = /turf/open/floor/plating/grass/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	icon_state = "grass-255"
	base_icon_state = "grass"
	planetary_atmos = TRUE
	icon = 'icons/turf/floors/crimsongrass.dmi'
	smooth_icon = 'icons/turf/floors/crimsongrass.dmi'
	light_range = 2
	light_power = 0.6
	light_color = COLOR_LAVAPLANET_LIGHT
	gender = PLURAL

/turf/open/floor/plating/grass/lava/orange
	baseturfs = /turf/open/floor/plating/grass/lava/orange

/turf/open/floor/plating/grass/lava/purple
	baseturfs = /turf/open/floor/plating/grass/lava/purple

///The Moss
/turf/open/floor/plating/moss
	name = "mossy carpet"
	desc = "When the forests burned away and the sky grew dark, the moss learned to feed on the falling ash."
	baseturfs = /turf/open/floor/plating/ashplanet //explosions and damage can destroy the moss
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	icon_state = "moss"
	icon = 'icons/turf/lava_moss.dmi'
	base_icon_state = "moss"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	layer = HIGH_TURF_LAYER
	gender = PLURAL
	light_power = 1
	light_range = 2
	pixel_x = -9
	pixel_y = -9

///Ruin Turfs (to-do, move all ruin turfs into their own bespoke files)

/turf/open/floor/concrete/pavement/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	light_range = 2
	light_power = 0.6
	light_color = COLOR_LAVAPLANET_LIGHT

/turf/open/floor/concrete/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	light_range = 2
	light_power = 0.6
	light_color = COLOR_LAVAPLANET_LIGHT

/turf/open/floor/concrete/slab_1/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	light_range = 2
	light_power = 0.6
	light_color = COLOR_LAVAPLANET_LIGHT

/turf/open/floor/plating/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	light_range = 2
	light_power = 0.6
	light_color = COLOR_LAVAPLANET_LIGHT

/turf/open/floor/plating/rust/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	light_range = 2
	light_power = 0.6
	light_color = COLOR_LAVAPLANET_LIGHT

/turf/open/floor/plasteel/white/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	light_range = 2
	light_power = 0.6
	light_color = COLOR_LAVAPLANET_LIGHT

/turf/open/floor/plasteel/dark/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	light_range = 2
	light_power = 0.6
	light_color = COLOR_LAVAPLANET_LIGHT

/turf/open/floor/plating/asteroid/obsidian
	name = "obsidian"
	desc = "Cooled magma forms a dark, cool glass."
	icon = 'icons/turf/planetary/lava.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/icerock
	icon_state = "obsidian"
	base_icon_state = "obsidian"
	floor_variance = 0
	dug = TRUE
	smoothing_flags = null
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

	planetary_atmos = TRUE
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/open/floor/plating/asteroid/obsidian/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_LAVAPLANET_LIGHT
