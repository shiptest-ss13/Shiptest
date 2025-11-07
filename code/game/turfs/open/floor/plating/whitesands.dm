///sand (but not like the other sand that's also called sand)

/turf/open/floor/plating/asteroid/whitesands
	name = "salted sand"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands
	icon = 'icons/turf/planetary/whitesands.dmi'
	icon_state = "sand"
	planetary_atmos = TRUE
	base_icon_state = WHITESANDS_SAND_ENV
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	layer = SAND_TURF_LAYER
	digResult = /obj/item/stack/ore/glass/whitesands
	floor_variance = 83
	max_icon_states = 5
	slowdown = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH)
	light_color = COLOR_SANDPLANET_LIGHT

	has_footsteps = TRUE
	footstep_icon_state = "whitesand"

	smooth_icon = 'icons/turf/floors/whitesand.dmi'

/turf/open/floor/plating/asteroid/whitesands/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(floor_variance))
		add_overlay("sandalt_[rand(1,max_icon_states)]")

/turf/open/floor/plating/asteroid/whitesands/lit
	light_range = 2
	light_power = 0.6
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/lit

/turf/open/floor/plating/asteroid/whitesands/lit/smooth
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH, SMOOTH_GROUP_FLOOR_HEXACRETE)

/turf/open/floor/plating/asteroid/whitesands/rocky
	has_footsteps = FALSE

/turf/open/floor/plating/asteroid/whitesands/rocky/Initialize(mapload, inherited_virtual_z)
	. = ..()
	add_overlay("sandalt_[rand(6,9)]")

/turf/open/floor/plating/asteroid/whitesands/dried
	name = "dried sand"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	base_icon_state = "dried_up"
	icon_state = "dried_up"
	icon_plating = null
	base_icon_state = WHITESANDS_DRIED_ENV
	layer = STONE_TURF_LAYER
	footstep = FOOTSTEP_ASTEROID
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	digResult = /obj/item/stack/ore/glass/whitesands
	slowdown = 0
	smooth_icon = 'icons/turf/floors/whitesands_rock.dmi'
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH_ROCKY)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH_ROCKY, SMOOTH_GROUP_FLOOR_PLASTEEL)
	has_footsteps = FALSE

/turf/open/floor/plating/asteroid/whitesands/remove_air(amount)
	return return_air()

/turf/open/floor/plating/asteroid/whitesands/dried/lit
	light_range = 2
	light_power = 0.6
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried/lit

///basalt

/turf/open/floor/plating/asteroid/basalt/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	icon_state = "whitesands_basalt0"
	dug = TRUE
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/plating/asteroid/basalt/whitesands/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "whitesands_basalt[rand(0,1)]"

///grass

/turf/open/floor/plating/asteroid/whitesands/grass
	name = "purple grass"
	desc = "The few known flora on Whitesands are in a purplish color."
	icon = 'icons/turf/floors/whitesands_grass.dmi' //PLACEHOLDER ICON, YELL AT LOCAL MOTH WOMAN //moth woman did not do this, it was imaginos
	smooth_icon = 'icons/turf/floors/whitesands_grass.dmi'
	icon_state = "ws_grass"
	base_icon_state = "ws_grass"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/grass/dead
	turf_type = /turf/open/floor/plating/asteroid/whitesands/grass
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_GRASS)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_GRASS)
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	layer = GRASS_TURF_LAYER
	slowdown = 0
	light_color = COLOR_SANDPLANET_LIGHT
	has_footsteps = FALSE

/turf/open/floor/plating/asteroid/whitesands/grass/getDug()
	. = ..()
	ScrapeAway()

/turf/open/floor/plating/asteroid/whitesands/grass/burn_tile()
	ScrapeAway()
	return TRUE

/turf/open/floor/plating/asteroid/whitesands/grass/ex_act(severity, target)
	. = ..()
	ScrapeAway()

/turf/open/floor/plating/asteroid/whitesands/grass/lit
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/grass/dead/lit
	turf_type = /turf/open/floor/plating/asteroid/whitesands/grass
	light_power = 1
	light_range = 2

/turf/open/floor/plating/asteroid/whitesands/grass/dead
	name = "dead grass"
	desc = "The few known flora on Whitesands also don't tend to live for very long, especially after the war."
	color = "#ddffb3" //the green makes a grey color, dead as hell
	baseturfs = /turf/open/floor/plating/asteroid/whitesands
	turf_type = /turf/open/floor/plating/asteroid/whitesands/grass/dead
	dug = TRUE

/turf/open/floor/plating/asteroid/whitesands/grass/dead/lit
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/lit
	turf_type = /turf/open/floor/plating/asteroid/whitesands/grass/dead/lit
	light_power = 1
	light_range = 2

///the singular snow tile:

/turf/open/floor/plating/asteroid/snow/lit/whitesands
	light_color = COLOR_SANDPLANET_LIGHT
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/lit
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/concrete/whitesands/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/concrete/reinforced/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/concrete/reinforced/whitesands/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/concrete/pavement/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/concrete/pavement/whitesands/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/concrete/slab_1/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/concrete/slab_1/whitesands/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/concrete/slab_4/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/concrete/slab_4/whitesands/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/plating/whitesands/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/wood/maple/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/wood/walnut/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/wood/ebony/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/plasteel/white/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/tiles/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/slab_1/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/slab_2/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/plasteel/dark/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/carpet/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/carpet/black/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/carpet/green/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/plasteel/patterned/brushed/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/pod/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/engine/hull/interior/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/engine/hull/reinforced/interior/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

//stairs

/turf/open/floor/plasteel/stairs/whitesand
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	name = "exterior stairs"

/turf/open/floor/plasteel/stairs/whitesand/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_SANDPLANET_LIGHT
