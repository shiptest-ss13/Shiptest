///sand (but not like the other sand that's also called sand)

/turf/open/floor/plating/asteroid/whitesands
	name = "salted sand"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands
	icon = 'icons/turf/floors//ws_floors.dmi'
	icon_state = "sand"
	icon_plating = "sand"
	planetary_atmos = TRUE
	base_icon_state = WHITESANDS_SAND_ENV
	initial_gas_mix = WHITESANDS_ATMOS
	digResult = /obj/item/stack/ore/glass/whitesands
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/plating/asteroid/whitesands/lit
	light_range = 2
	light_power = 0.6
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/lit

/turf/open/floor/plating/asteroid/whitesands/dried
	name = "dried sand"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	icon_state = "dried_up"
	icon_plating = "dried_up"
	base_icon_state = WHITESANDS_DRIED_ENV
	digResult = /obj/item/stack/ore/glass/whitesands

/turf/open/floor/plating/asteroid/whitesands/remove_air(amount)
	return return_air()

/turf/open/floor/plating/asteroid/whitesands/dried/lit
	light_range = 2
	light_power = 0.6
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried/lit

///basalt

/turf/open/floor/plating/asteroid/basalt/whitesands
	initial_gas_mix = WHITESANDS_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	icon_state = "whitesands_basalt0"
	icon_plating = "whitesands_basalt0"
	dug = TRUE
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/plating/asteroid/basalt/whitesands/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "whitesands_basalt[rand(0,1)]"

///grass

/turf/open/floor/plating/asteroid/whitesands/grass
	name = "purple grass"
	desc = "The few known flora on Whitesands are in a purplish color."
	icon = 'icons/turf/floors/lava_grass_purple.dmi' //PLACEHOLDER ICON, YELL AT LOCAL MOTH WOMAN
	icon_state = "grass-0"
	base_icon_state = "grass"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands
	turf_type = /turf/open/floor/plating/asteroid/whitesands/grass
	initial_gas_mix = WHITESANDS_ATMOS
	planetary_atmos = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_GRASS)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_GRASS)
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/plating/asteroid/whitesands/grass/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-9, -9)
		transform = translation

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

///the singular snow tile:

/turf/open/floor/plating/asteroid/snow/lit/whitesands
	light_color = COLOR_SANDPLANET_LIGHT
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/lit
	initial_gas_mix = WHITESANDS_ATMOS

/turf/open/floor/concrete/whitesands
	initial_gas_mix = WHITESANDS_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/concrete/whitesands/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/concrete/reinforced/whitesands
	initial_gas_mix = WHITESANDS_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/concrete/reinforced/whitesands/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/concrete/pavement/whitesands
	initial_gas_mix = WHITESANDS_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/concrete/pavement/whitesands/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/concrete/slab_1/whitesands
	initial_gas_mix = WHITESANDS_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/concrete/slab_1/whitesands/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/whitesands
	initial_gas_mix = WHITESANDS_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/plating/whitesands/lit
	light_range = 2
	light_power = 0.6
