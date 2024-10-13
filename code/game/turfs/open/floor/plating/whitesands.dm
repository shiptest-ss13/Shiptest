/turf/open/floor/plating/asteroid/whitesands
	name = "salted sand"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands
	icon = 'icons/turf/planetary/whitesands.dmi'
	icon_state = "sand"
	icon_plating = "sand"
	planetary_atmos = TRUE
	base_icon_state = WHITESANDS_SAND_ENV
	initial_gas_mix = WHITESANDS_ATMOS //Fallback, and used to tell the AACs that this is the exterior
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	digResult = /obj/item/stack/ore/glass/whitesands
	max_icon_states = 0
	floor_variance = 0
	slowdown = 1.5

/turf/open/floor/plating/asteroid/whitesands/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/lit

/turf/open/floor/plating/asteroid/whitesands/dried
	name = "dried sand"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	base_icon_state = "dried_up"
	icon_state = "dried_up"
	icon_plating = null
	base_icon_state = WHITESANDS_DRIED_ENV
	layer = STONE_TURF_LAYER
	digResult = /obj/item/stack/ore/glass/whitesands
	slowdown = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_SNOWED)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_SNOWED)
	var/smooth_icon = 'icons/turf/floors/whitesands_rock.dmi'

/turf/open/floor/plating/asteroid/whitesands/dried/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-19, -19)
		transform = translation
		icon = smooth_icon
		icon_plating = null

/turf/open/floor/plating/asteroid/whitesands/remove_air(amount)
	return return_air()

/turf/open/floor/plating/asteroid/whitesands/dried/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried/lit

/turf/open/floor/plating/grass/whitesands
	initial_gas_mix = WHITESANDS_ATMOS

/turf/open/floor/plating/asteroid/basalt/whitesands
	initial_gas_mix = WHITESANDS_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	icon_state = "whitesands_basalt0"
	icon_plating = "whitesands_basalt0"
	dug = TRUE

/turf/open/floor/plating/asteroid/basalt/whitesands/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "whitesands_basalt[rand(0,1)]"

/turf/open/floor/plating/asteroid/whitesands/grass
	name = "purple grass"
	desc = "The few known flora on Whitesands are in a purplish color."
	icon = 'icons/turf/floors/whitesands_grass.dmi' //PLACEHOLDER ICON, YELL AT LOCAL MOTH WOMAN //moth woman did not do this, it was imaginos
	icon_state = "ws_grass"
	base_icon_state = "ws_grass"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands
	turf_type = /turf/open/floor/plating/asteroid/whitesands/grass
	initial_gas_mix = WHITESANDS_ATMOS
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

/turf/open/floor/plating/asteroid/whitesands/grass/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-19, -19)
		transform = translation
		icon_plating = null

/turf/open/floor/plating/asteroid/whitesands/grass/lit
	light_power = 1
	light_range = 2

/turf/open/floor/plating/asteroid/whitesands/grass/dead
	name = "dead grass"
	desc = "The few known flora on Whitesands also don't tend to live for very long, especially after the war."
	color = "#ddffb3" //the green makes a grey color, dead as hell

/turf/open/floor/plating/asteroid/whitesands/grass/dead/lit
	light_power = 1
	light_range = 2
