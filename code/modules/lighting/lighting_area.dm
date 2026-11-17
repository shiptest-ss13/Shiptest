/area
	luminosity = 1
	///List of mutable appearances we underlay to show light
	///In the form plane offset + 1 -> appearance to use
	var/list/mutable_appearance/lighting_effects = null
	///Whether this area has a currently active base lighting, bool
	var/area_has_base_lighting = FALSE
	///alpha 0-255 of lighting_effect and thus baselighting intensity
	var/base_lighting_alpha = 0
	///The colour of the light acting on this area
	var/base_lighting_color = COLOR_WHITE
	///How much our base lighting adds to get_lumcount(), 0-1. Need this for basicmobs otherwise lumcount is always 0
	var/base_lighting_lumcount = 0

/area/proc/set_base_lighting(new_base_lighting_color = -1, new_alpha = -1)
	if(base_lighting_alpha == new_alpha && base_lighting_color == new_base_lighting_color)
		return FALSE
	if(new_alpha != -1)
		base_lighting_alpha = new_alpha
	if(new_base_lighting_color != -1)
		base_lighting_color = new_base_lighting_color
	update_base_lighting()
	return TRUE

/area/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, base_lighting_color))
			set_base_lighting(new_base_lighting_color = var_value)
			return TRUE
		if(NAMEOF(src, base_lighting_alpha))
			set_base_lighting(new_alpha = var_value)
			return TRUE
		if(NAMEOF(src, static_lighting))
			. = ..()
			if(static_lighting)
				create_area_lighting_objects()
			else
				remove_area_lighting_objects()
			return
	return ..()

/area/proc/update_base_lighting()
	if(!area_has_base_lighting && (!base_lighting_alpha || !base_lighting_color))
		return

	if(!area_has_base_lighting)
		add_base_lighting()
		return
	remove_base_lighting()
	if(base_lighting_alpha && base_lighting_color)
		add_base_lighting()

/area/proc/remove_base_lighting()
	cut_overlay(lighting_effects[1])
	lighting_effects = null
	area_has_base_lighting = FALSE
	base_lighting_lumcount = 0
	if(!static_lighting)
		return
	for(var/turf/area_turf in src)
		if(area_turf.lighting_object)
			area_turf.luminosity = 0

/area/proc/add_base_lighting()
	lighting_effects = list()
	var/mutable_appearance/light = mutable_appearance('icons/effects/alphacolors.dmi', "white")
	light.color = base_lighting_color
	light.layer = LIGHTING_LAYER
	light.blend_mode = BLEND_ADD
	light.appearance_flags = RESET_TRANSFORM | RESET_ALPHA | RESET_COLOR
	light.alpha = base_lighting_alpha
	SET_PLANE_W_SCALAR(light, LIGHTING_PLANE, 0)
	lighting_effects += light

	add_overlay(lighting_effects[1])
	area_has_base_lighting = TRUE
	var/list/color_channels = rgb2num(base_lighting_color)
	base_lighting_lumcount = (base_lighting_alpha / 255) * (color_channels[1] + color_channels[2] + color_channels[3]) / 765
	if(!static_lighting)
		return
	for(var/turf/area_turf in src)
		area_turf.luminosity = 1
