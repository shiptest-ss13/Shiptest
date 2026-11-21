/area
	/// If TRUE, we want to use the outdoors lighting rather than their defaults
	var/use_ztrait_lighting = FALSE
	/// The daylight we currently show, ZTRAIT_PLANETARY_LIGHTING list. Null when unlit
	var/list/planet_daylight
	/// Base lighting here is daylight that edge lights already add to, so get_lumcount takes the brighter of the two
	var/base_lighting_is_daylight = FALSE
	/// Daylight base colour as 0-1 channels, the least light our lighting objects draw
	var/list/base_lighting_channels

/turf
	/// Whether this turf lit itself with planet daylight before base lighting existed, so it may still light daylight edges
	var/can_emit_planet_daylight = FALSE
	/// Whether this turf draws its own corner light over daylight
	var/planet_daylight_exact = FALSE

/// Furthest a turf's own coloured light is looked for when deciding exact daylight
#define DAYLIGHT_BREAK_LIGHT_REACH 3

/// A time of day a planet can be at, rolled once when the planet is created
/datum/time_of_day
	var/name = "midday"
	/// Multiplies the planet's own daylight power
	var/power_multiplier = 1
	/// Dimmest power allowed after multiplier
	var/min_power = 0.15
	/// Colour blended into the planet's own daylight colour, null for none
	var/tint
	/// How far the daylight colour is blended towards the tint, 0 to 1
	var/tint_strength = 0

/datum/time_of_day/day

/datum/time_of_day/dawn
	name = "dawn"
	power_multiplier = 0.65
	tint = "#ffae7a"
	tint_strength = 0.3

/datum/time_of_day/dusk
	name = "dusk"
	power_multiplier = 0.5
	tint = "#ff7f50"
	tint_strength = 0.4

/datum/time_of_day/night
	name = "night"
	power_multiplier = 0.25
	tint = "#2b3a78"
	tint_strength = 0.55

// much darker than night, bring a light
/datum/time_of_day/eclipse
	name = "eclipse"
	power_multiplier = 0.08
	min_power = 0.05
	tint = "#1a1f3d"
	tint_strength = 0.65

// for when the weather is manually set by VV
/datum/time_of_day/anomalous
	name = "anomalous"

/proc/time_of_day_power(datum/time_of_day/time_of_day, light_power)
	if(!time_of_day || !light_power)
		return light_power
	return max(light_power * initial(time_of_day.power_multiplier), min(light_power, initial(time_of_day.min_power)))

/proc/time_of_day_color(datum/time_of_day/time_of_day, light_color)
	if(!time_of_day || !initial(time_of_day.tint))
		return light_color
	return BlendRGB(light_color, initial(time_of_day.tint), initial(time_of_day.tint_strength))

/proc/planet_daylight_strength(light_range)
	var/static/list/strength_by_range = list()
	var/cached_strength = strength_by_range["[light_range]"]
	if(!isnull(cached_strength))
		return cached_strength
	var/range_divisor = max(1, light_range)
	var/reach = ceil(light_range) + 1
	var/strength = 0
	// corners sit half a tile from every source around them.
	for(var/tile_x in -reach to reach - 1)
		for(var/tile_y in -reach to reach - 1)
			var/corner_x = tile_x + 0.5
			var/corner_y = tile_y + 0.5
			strength += max(0, 1 - sqrt(corner_x ** 2 + corner_y ** 2 + LIGHTING_HEIGHT) / range_divisor)
	strength_by_range["[light_range]"] = strength
	return strength

/proc/planet_daylight_base_color(light_color, light_power, light_range)
	var/list/channels = rgb2num(light_color)
	var/strength = planet_daylight_strength(light_range) * light_power
	var/brightest = max(channels[1], channels[2], channels[3]) * strength / 255
	var/scale = strength / max(1, brightest)
	return rgb(min(255, channels[1] * scale), min(255, channels[2] * scale), min(255, channels[3] * scale))

// get from traits, or clear if none
/area/proc/set_planet_daylight(list/lighting_traits)
	if(!use_ztrait_lighting)
		return
	if(!lighting_traits || !lighting_traits[ZTRAIT_LIGHT_RANGE] || !lighting_traits[ZTRAIT_LIGHT_POWER])
		planet_daylight = null
		base_lighting_is_daylight = FALSE
		base_lighting_channels = null
		set_base_lighting(new_alpha = 0)
		return
	planet_daylight = lighting_traits.Copy()
	base_lighting_is_daylight = TRUE
	var/daylight_color = planet_daylight_base_color(lighting_traits[ZTRAIT_LIGHT_COLOR], lighting_traits[ZTRAIT_LIGHT_POWER], lighting_traits[ZTRAIT_LIGHT_RANGE])
	var/list/daylight_channels = rgb2num(daylight_color)
	base_lighting_channels = list(daylight_channels[1] / 255, daylight_channels[2] / 255, daylight_channels[3] / 255)
	set_base_lighting(daylight_color, 255)

/datum/virtual_level/proc/apply_planetary_lighting()
	var/list/lighting_traits = get_trait(ZTRAIT_PLANETARY_LIGHTING)
	// can't use GLOB.sortedAreas since it won't be there until template loads
	var/list/area/daylit_areas = list()
	var/list/turf/break_lights = list()
	for(var/turf/level_turf as anything in get_block())
		if(level_turf.is_daylight_break_light())
			break_lights += level_turf
		var/area/level_area = level_turf.loc
		if(daylit_areas[level_area] || !level_area.use_ztrait_lighting)
			continue
		daylit_areas[level_area] = TRUE
	for(var/area/daylit_area as anything in daylit_areas)
		daylit_area.set_planet_daylight(lighting_traits)
	// marks the turfs before placing light sources
	var/darkness_reach = lighting_traits ? ceil(lighting_traits[ZTRAIT_LIGHT_RANGE]) : 0
	for(var/area/daylit_area as anything in daylit_areas)
		for(var/turf/area_turf in daylit_area)
			area_turf.set_planet_daylight_exact(darkness_reach && area_turf.is_near_daylight_darkness(darkness_reach))
			area_turf.queue_lighting_object_update()
			CHECK_TICK
	// coloured lights mark turfs around them rather than other way around
	if(lighting_traits)
		for(var/turf/break_light as anything in break_lights)
			for(var/turf/nearby_turf as anything in RANGE_TURFS(min(ceil(break_light.light_range), DAYLIGHT_BREAK_LIGHT_REACH), break_light))
				var/area/nearby_area = nearby_turf.loc
				if(nearby_area.planet_daylight && nearby_turf.virtual_z == break_light.virtual_z)
					nearby_turf.set_planet_daylight_exact(TRUE)
			CHECK_TICK
	for(var/area/daylit_area as anything in daylit_areas)
		for(var/turf/area_turf in daylit_area)
			area_turf.update_planet_daylight_source()
			CHECK_TICK

/datum/virtual_level/proc/set_planetary_lighting(light_range, light_power, light_color)
	traits = traits.Copy()
	if(light_range && light_power)
		traits[ZTRAIT_PLANETARY_LIGHTING] = list(
			ZTRAIT_LIGHT_RANGE = light_range,
			ZTRAIT_LIGHT_POWER = light_power,
			ZTRAIT_LIGHT_COLOR = light_color,
		)
	else
		traits -= ZTRAIT_PLANETARY_LIGHTING
	apply_planetary_lighting()

/turf/proc/update_planet_daylight()
	update_planet_daylight_exact()
	update_planet_daylight_source()
	var/area/turf_area = loc
	var/list/daylight = turf_area.planet_daylight
	if(!daylight)
		return
	var/daylight_reach = ceil(daylight[ZTRAIT_LIGHT_RANGE])
	// New coloured light makes the turfs around it exact, and those need their sources.
	if(is_daylight_break_light())
		var/light_reach = min(ceil(light_range), DAYLIGHT_BREAK_LIGHT_REACH)
		for(var/turf/nearby_turf as anything in RANGE_TURFS(light_reach, src))
			nearby_turf.update_planet_daylight_exact()
		for(var/turf/nearby_turf as anything in RANGE_TURFS(light_reach + daylight_reach, src))
			nearby_turf.update_planet_daylight_source()
		return
	if(!planet_daylight_exact)
		return
	for(var/turf/nearby_turf as anything in RANGE_TURFS(daylight_reach, src))
		if(nearby_turf.can_emit_planet_daylight && !nearby_turf.light)
			nearby_turf.update_planet_daylight_source()

// mark a turf as exact so its shows its real corner lighting
/turf/proc/update_planet_daylight_exact()
	var/area/turf_area = loc
	var/list/daylight = turf_area.planet_daylight
	set_planet_daylight_exact(daylight && (is_near_daylight_darkness(ceil(daylight[ZTRAIT_LIGHT_RANGE])) || is_near_daylight_break_light()))

/turf/proc/set_planet_daylight_exact(new_exact)
	new_exact = !!new_exact
	if(new_exact == planet_daylight_exact)
		return
	planet_daylight_exact = new_exact
	for(var/turf/sharing_turf as anything in RANGE_TURFS(1, src))
		sharing_turf.queue_lighting_object_update()

// whether a turf touching this corner is exact, so the corner shows its own light
/datum/lighting_corner/proc/touches_exact_daylight()
	return master_NE?.planet_daylight_exact || master_SE?.planet_daylight_exact || master_SW?.planet_daylight_exact || master_NW?.planet_daylight_exact

// re-check daylight around a turf that joined or left a daylit area, like a docking ship
/turf/proc/refresh_planet_daylight_around(list/daylight)
	var/daylight_reach = ceil(daylight[ZTRAIT_LIGHT_RANGE])
	var/near_daylight = FALSE
	for(var/turf/nearby_turf as anything in RANGE_TURFS(daylight_reach, src))
		var/area/nearby_area = nearby_turf.loc
		if(nearby_area.planet_daylight)
			near_daylight = TRUE
			break
	if(!near_daylight)
		return
	for(var/turf/nearby_turf as anything in RANGE_TURFS(daylight_reach, src))
		nearby_turf.update_planet_daylight_exact()
	for(var/turf/nearby_turf as anything in RANGE_TURFS(daylight_reach * 2, src))
		if(nearby_turf.can_emit_planet_daylight)
			nearby_turf.update_planet_daylight_source()

// one refresh for many area changes, so overlapping parts are only checked once
/proc/refresh_planet_daylight_for_turfs(list/turf/changed_turfs)
	var/list/turf/exact_turfs = list()
	var/list/turf/source_turfs = list()
	for(var/turf/changed_turf as anything in changed_turfs)
		var/list/daylight = changed_turf.virtual_level_trait(ZTRAIT_PLANETARY_LIGHTING)
		if(!daylight || !daylight[ZTRAIT_LIGHT_RANGE])
			continue
		var/daylight_reach = ceil(daylight[ZTRAIT_LIGHT_RANGE])
		for(var/turf/nearby_turf as anything in RANGE_TURFS(daylight_reach, changed_turf))
			exact_turfs[nearby_turf] = TRUE
		for(var/turf/nearby_turf as anything in RANGE_TURFS(daylight_reach * 2, changed_turf))
			if(nearby_turf.can_emit_planet_daylight)
				source_turfs[nearby_turf] = TRUE
		CHECK_TICK
	for(var/turf/exact_turf as anything in exact_turfs)
		exact_turf.update_planet_daylight_exact()
		CHECK_TICK
	for(var/turf/source_turf as anything in source_turfs)
		source_turf.update_planet_daylight_source()
		CHECK_TICK

/turf/proc/queue_lighting_object_update()
	if(lighting_object && !lighting_object.needs_update)
		lighting_object.needs_update = TRUE
		SSlighting.objects_queue += lighting_object

/turf/proc/queue_daylight_opacity_redraw()
	var/area/turf_area = loc
	if(turf_area.base_lighting_is_daylight)
		queue_lighting_object_update()

// space lit turfs stay fullbright under planet daylight
/proc/area_lights_space_turfs(area/turf_area)
	return turf_area.area_has_base_lighting && !turf_area.base_lighting_is_daylight

// lights this turf with daylight only where exact turfs need it; without daylight it uses its own light
/turf/proc/update_planet_daylight_source()
	var/area/turf_area = loc
	var/list/daylight = turf_area.planet_daylight
	if(!can_emit_planet_daylight || !(daylight || istype(turf_area, /area/overmap_encounter)))
		if(can_emit_planet_daylight && (light_range != initial(light_range) || light_power != initial(light_power) || light_color != initial(light_color)))
			set_light(initial(light_range), initial(light_power), initial(light_color))
		else if(light_power && light_range)
			update_light()
		return
	if(daylight && is_near_exact_daylight(daylight[ZTRAIT_LIGHT_RANGE]))
		set_light(daylight[ZTRAIT_LIGHT_RANGE], daylight[ZTRAIT_LIGHT_POWER], daylight[ZTRAIT_LIGHT_COLOR])
	else if(light_range)
		set_light(0)

// whether this turf has a light of its own that isn't daylight, like plasma
/turf/proc/is_daylight_break_light()
	return light_range && light_power && !can_emit_planet_daylight

/turf/proc/is_near_daylight_darkness(darkness_reach)
	for(var/turf/nearby_turf as anything in RANGE_TURFS(darkness_reach, src))
		var/area/nearby_area = nearby_turf.loc
		if(nearby_area.planet_daylight)
			continue
		// Nobody sees past the map's edge, so it needs no light.
		if(nearby_turf.virtual_z != virtual_z || istype(nearby_turf, /turf/closed/indestructible/edge))
			continue
		return TRUE
	return FALSE

/turf/proc/is_near_daylight_break_light()
	for(var/turf/nearby_turf as anything in RANGE_TURFS(DAYLIGHT_BREAK_LIGHT_REACH, src))
		if(nearby_turf.is_daylight_break_light() && get_dist(src, nearby_turf) <= ceil(nearby_turf.light_range) && nearby_turf.virtual_z == virtual_z)
			return TRUE
	return FALSE

// whether an exact turf is within daylight's reach, so it needs our light
/turf/proc/is_near_exact_daylight(daylight_range)
	for(var/turf/nearby_turf as anything in RANGE_TURFS(ceil(daylight_range), src))
		if(nearby_turf.planet_daylight_exact && nearby_turf.virtual_z == virtual_z)
			return TRUE
	return FALSE

/proc/set_mapzone_planetary_lighting(datum/map_zone/mapzone, light_range, light_power, light_color)
	for(var/datum/virtual_level/zone_level as anything in mapzone.virtual_levels)
		zone_level.set_planetary_lighting(light_range, light_power, light_color)

/*
* For use when needing to update a planet's lighting. This does nothing on non-dockable overmap objects.
*/
/datum/overmap/proc/update_planet_lighting_gui()
	var/new_light_range
	var/new_light_power
	var/new_light_color
	var/datum/time_of_day/new_time_of_day

	var/datum/overmap/dynamic/dynamic_planet = src
	var/datum/planet_type/planet = istype(dynamic_planet) ? dynamic_planet.planet : null
	// fixed lighting planets, like wastes, never show a time of day
	var/has_time_of_day = length(planet?.time_of_day_weights)
	var/mode = "Custom"
	if(planet)
		var/prompt = has_time_of_day \
			? "Preset picks a time of day or the planet's original roll, Custom sets it by hand and shows as anomalous to players." \
			: "This planet has fixed lighting. Preset returns it to its planet type's lighting, Custom sets it by hand."
		mode = tgui_alert(usr, prompt, "Update planet lighting", list("Preset", "Custom"))
		if(!mode)
			return

	var/mode_text = ""
	var/result
	if(mode == "Preset")
		var/list/presets = list()
		if(has_time_of_day)
			var/datum/time_of_day/rolled = dynamic_planet.rolled_time_of_day
			presets["original roll ([initial(rolled.name)])"] = rolled
			for(var/datum/time_of_day/preset as anything in subtypesof(/datum/time_of_day) - /datum/time_of_day/anomalous)
				// midday leaves the planet type's lighting untouched, say so
				var/preset_name = (preset == /datum/time_of_day/day) ? "[initial(preset.name)] (base lighting)" : initial(preset.name)
				presets[preset_name] = preset
		else
			// fixed planets have no times of day, only their planet type's lighting
			presets["base lighting"] = null
		var/picked = tgui_input_list(usr, "Pick a preset", "Update planet lighting", presets)
		if(!picked)
			return
		new_time_of_day = presets[picked]
		mode_text = " ([picked] preset)"
		result = dynamic_planet.set_time_of_day_lighting(new_time_of_day)
		new_light_range = dynamic_planet.light_range
		new_light_power = dynamic_planet.light_power
		new_light_color = dynamic_planet.light_color
	else
		new_light_range = input(usr, "Enter light range", "Update planet lighting", 2) as num|null
		if(isnull(new_light_range))
			return
		new_light_power = input(usr, "Enter light power", "Update planet lighting", 0.8) as num|null
		if(isnull(new_light_power))
			return
		new_light_color = input(usr, "Enter hex color:", "Update planet lighting", COLOR_WHITE) as color|null
		if(isnull(new_light_color))
			return
		if(has_time_of_day)
			new_time_of_day = /datum/time_of_day/anomalous
		result = update_planet_lighting(new_light_range, new_light_power, new_light_color, new_time_of_day)

	if(result == PLANET_LIGHTING_FAILED)
		to_chat(usr, span_warning("You can only use this on a loaded outpost, or a planet or static object."), confidential = TRUE)
		return
	var/pending_text = (result == PLANET_LIGHTING_PENDING) ? " It will apply when the level loads." : ""
	message_admins("[key_name_admin(usr)] set the lighting of [src] to range [new_light_range], power [new_light_power], colour [new_light_color][mode_text].[pending_text]")
	log_admin("[key_name(usr)] set the lighting of [src] to range [new_light_range], power [new_light_power], colour [new_light_color][mode_text].")

/datum/overmap/proc/update_planet_lighting(new_light_range, new_light_power, new_light_color, datum/time_of_day/new_time_of_day)
	return PLANET_LIGHTING_FAILED

/datum/overmap/dynamic/update_planet_lighting(new_light_range, new_light_power, new_light_color, datum/time_of_day/new_time_of_day)
	light_range = new_light_range
	light_power = new_light_power
	light_color = new_light_color
	if(new_time_of_day)
		time_of_day = new_time_of_day
		alter_token_appearance()
	if(!mapzone)
		return PLANET_LIGHTING_PENDING
	set_mapzone_planetary_lighting(mapzone, new_light_range, new_light_power, new_light_color)
	return PLANET_LIGHTING_APPLIED

/datum/overmap/dynamic/proc/set_time_of_day_lighting(datum/time_of_day/new_time_of_day)
	if(!planet)
		return PLANET_LIGHTING_FAILED
	return update_planet_lighting(
		planet.light_range,
		time_of_day_power(new_time_of_day, planet.light_power),
		time_of_day_color(new_time_of_day, planet.light_color),
		new_time_of_day,
	)

/datum/overmap/static_object/update_planet_lighting(new_light_range, new_light_power, new_light_color, datum/time_of_day/new_time_of_day)
	light_range = new_light_range
	light_power = new_light_power
	light_color = new_light_color
	if(!mapzone)
		return PLANET_LIGHTING_PENDING
	set_mapzone_planetary_lighting(mapzone, new_light_range, new_light_power, new_light_color)
	return PLANET_LIGHTING_APPLIED

/datum/overmap/outpost/update_planet_lighting(new_light_range, new_light_power, new_light_color, datum/time_of_day/new_time_of_day)
	if(!mapzone)
		return PLANET_LIGHTING_FAILED
	set_mapzone_planetary_lighting(mapzone, new_light_range, new_light_power, new_light_color)
	return PLANET_LIGHTING_APPLIED

#undef DAYLIGHT_BREAK_LIGHT_REACH
