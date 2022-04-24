/turf/open/floor/plating/asteroid/whitesands
	name = "salted sand"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands
	icon = 'whitesands/icons/turf/floors/whitesands/ws_floors.dmi'
	icon_state = "sand"
	icon_plating = "sand"
	planetary_atmos = TRUE
	environment_type = WHITESANDS_SAND_ENV
	initial_gas_mix = WHITESANDS_ATMOS //Fallback, and used to tell the AACs that this is the exterior
	digResult = /obj/item/stack/ore/glass
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/// Drops itemstack when dug and changes icon
/turf/open/floor/plating/asteroid/getDug()
	new digResult(src, 5)
	if(postdig_icon_change)
		if(!postdig_icon)
			icon_plating = "[initial(src.icon_state)]_dug"
			icon_state = "[initial(src.icon_state)]_dug"
	dug = TRUE

/turf/open/floor/plating/asteroid/whitesands/dried
	name = "dried sand"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	icon_state = "dried_up"
	icon_plating = "dried_up"
	environment_type = WHITESANDS_DRIED_ENV
	digResult = /obj/item/stack/ore/glass

/turf/open/floor/plating/asteroid/whitesands/remove_air(amount)
	return return_air()

/turf/open/floor/plating/grass/whitesands
	initial_gas_mix = WHITESANDS_ATMOS
