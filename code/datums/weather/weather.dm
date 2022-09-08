#define THUNDER_SOUND pick('sound/effects/thunder/thunder1.ogg', 'sound/effects/thunder/thunder2.ogg', 'sound/effects/thunder/thunder3.ogg', 'sound/effects/thunder/thunder4.ogg', \
			'sound/effects/thunder/thunder5.ogg', 'sound/effects/thunder/thunder6.ogg', 'sound/effects/thunder/thunder7.ogg', 'sound/effects/thunder/thunder8.ogg', 'sound/effects/thunder/thunder9.ogg', \
			'sound/effects/thunder/thunder10.ogg')

/**
 * Causes weather to occur on a z level in certain area types
 *
 * The effects of weather occur across an entire z-level. For instance, lavaland has periodic ash storms that scorch most unprotected creatures.
 * Weather always occurs on different z levels at different times, regardless of weather type.
 * Can have custom durations, targets, and can automatically protect indoor areas.
 *
 */

/datum/weather
	/// name of weather
	var/name = "space wind"
	/// description of weather
	var/desc = "Heavy gusts of wind blanket the area, periodically knocking down anyone caught in the open."
	/// The message displayed in chat to foreshadow the weather's beginning
	var/telegraph_message = "<span class='warning'>The wind begins to pick up.</span>"
	/// In deciseconds, how long from the beginning of the telegraph until the weather begins
	var/telegraph_duration = 300
	/// The sound file played to everyone on an affected z-level
	var/telegraph_sound
	/// The overlay applied to all tiles on the z-level
	var/telegraph_overlay

	/// Displayed in chat once the weather begins in earnest
	var/weather_message = "<span class='userdanger'>The wind begins to blow ferociously!</span>"
	/// In deciseconds, how long the weather lasts once it begins
	var/weather_duration = 1200
	/// See above - this is the lowest possible duration
	var/weather_duration_lower = 1200
	/// See above - this is the highest possible duration
	var/weather_duration_upper = 1500
	/// Looping sound while weather is occuring
	var/weather_sound
	/// Area overlay while the weather is occuring
	var/weather_overlay
	/// Color to apply to the area while weather is occuring
	var/weather_color = null

	/// Displayed once the weather is over
	var/end_message = "<span class='danger'>The wind relents its assault.</span>"
	/// In deciseconds, how long the "wind-down" graphic will appear before vanishing entirely
	var/end_duration = 300
	/// Sound that plays while weather is ending
	var/end_sound
	/// Area overlay while weather is ending
	var/end_overlay

	/// Types of area to affect
	var/area_type = /area/space
	/// TRUE value protects areas with outdoors marked as false, regardless of area type
	var/protect_indoors = FALSE
	/// Areas to be affected by the weather, calculated when the weather begins
	var/list/impacted_areas = list()
	/// Areas that were protected by either being outside or underground
	var/list/outside_areas = list()
	/// Areas that are protected and excluded from the affected areas.
	var/list/protected_areas = list()
	/// The list of z-levels that this weather is actively affecting
	var/impacted_z_levels

	/// Since it's above everything else, this is the layer used by default. TURF_LAYER is below mobs and walls if you need to use that.
	var/overlay_layer = AREA_LAYER
	/// Plane for the overlay
	var/overlay_plane = BLACKNESS_PLANE
	/// If the weather has no purpose other than looks
	var/aesthetic = FALSE
	/// Used by mobs to prevent them from being affected by the weather
	var/immunity_type = "storm"

	/// The stage of the weather, from 1-4
	var/stage = END_STAGE

	/// Whether a barometer can predict when the weather will happen
	var/barometer_predictable = FALSE
	/// Whether the weather affects underground areas
	var/affects_underground = TRUE
	/// Whether the weather affects above ground areas
	var/affects_aboveground = TRUE
	/// Reference to the weather controller
	var/datum/weather_controller/my_controller
	/// A type of looping sound to be played for people outside the active weather
	var/datum/looping_sound/sound_active_outside
	/// A type of looping sound to be played for people inside the active weather
	var/datum/looping_sound/sound_active_inside
	/// A type of looping sound to be played for people outside the winding up/ending weather
	var/datum/looping_sound/sound_weak_outside
	/// A type of looping sound to be played for people inside the winding up/ending weather
	var/datum/looping_sound/sound_weak_inside
	/// Whether the areas should use a blend multiplication during the main weather, for stuff like fulltile storms
	var/multiply_blend_on_main_stage = FALSE
	/// Chance for a thunder to happen.
	var/thunder_chance = 0
	/// Whether the main stage will block vision
	var/opacity_in_main_stage = FALSE

/datum/weather/New(datum/weather_controller/passed_controller)
	..()
	my_controller = passed_controller
	my_controller.current_weathers[type] = src
	if(sound_active_outside)
		sound_active_outside = new sound_active_outside(list(), FALSE, TRUE)
	if(sound_active_inside)
		sound_active_inside = new sound_active_inside(list(), FALSE, TRUE)
	if(sound_weak_outside)
		sound_weak_outside = new sound_weak_outside(list(), FALSE, TRUE)
	if(sound_weak_inside)
		sound_weak_inside = new sound_weak_inside(list(), FALSE, TRUE)

/datum/weather/Destroy()
	LAZYREMOVE(my_controller.current_weathers, type)
	my_controller = null
	return ..()

/datum/weather/process()
	if(aesthetic || stage != MAIN_STAGE)
		return
	if(prob(thunder_chance))
		do_thunder()
	for(var/i in GLOB.mob_living_list)
		var/mob/living/L = i
		if(can_weather_act(L))
			weather_act(L)

/**
 * Telegraphs the beginning of the weather on the impacted z levels
 *
 * Sends sounds and details to mobs in the area
 * Calculates duration and hit areas, and makes a callback for the actual weather to start
 *
 */
/datum/weather/proc/telegraph()
	if(stage == STARTUP_STAGE)
		return
	stage = STARTUP_STAGE
	var/list/affectareas = list()
	for(var/V in get_areas(area_type))
		affectareas += V
	for(var/V in protected_areas)
		affectareas -= get_areas(V)
	for(var/V in affectareas)
		var/area/A = V
		if(!(my_controller.mapzone.is_in_bounds(A)))
			continue
		if(protect_indoors && !A.allow_weather)
			outside_areas |= A
			continue
		if(A.underground && !affects_underground)
			outside_areas |= A
			continue
		if(!A.underground && !affects_aboveground)
			outside_areas |= A
			continue
		impacted_areas |= A
	weather_duration = rand(weather_duration_lower, weather_duration_upper)
	update_areas()
	for(var/M in GLOB.player_list)
		var/turf/mob_turf = get_turf(M)
		if(mob_turf && my_controller.mapzone.is_in_bounds(mob_turf))
			if(telegraph_message)
				to_chat(M, telegraph_message)
			if(telegraph_sound)
				SEND_SOUND(M, sound(telegraph_sound))
	addtimer(CALLBACK(src, .proc/start), telegraph_duration)

	if(sound_active_outside)
		sound_active_outside.output_atoms = outside_areas
	if(sound_active_inside)
		sound_active_inside.output_atoms = impacted_areas
	if(sound_weak_outside)
		sound_weak_outside.output_atoms = outside_areas
		sound_weak_outside.start()
	if(sound_weak_inside)
		sound_weak_inside.output_atoms = impacted_areas
		sound_weak_inside.start()

/**
 * Starts the actual weather and effects from it
 *
 * Updates area overlays and sends sounds and messages to mobs to notify them
 * Begins dealing effects from weather to mobs in the area
 *
 */
/datum/weather/proc/start()
	if(stage >= MAIN_STAGE)
		return
	stage = MAIN_STAGE
	update_areas()
	for(var/M in GLOB.player_list)
		var/turf/mob_turf = get_turf(M)
		if(mob_turf && my_controller.mapzone.is_in_bounds(mob_turf))
			if(weather_message)
				to_chat(M, weather_message)
			if(weather_sound)
				SEND_SOUND(M, sound(weather_sound))
	addtimer(CALLBACK(src, .proc/wind_down), weather_duration)

	if(sound_weak_outside)
		sound_weak_outside.stop()
	if(sound_weak_inside)
		sound_weak_inside.stop()
	if(sound_active_outside)
		sound_active_outside.start()
	if(sound_active_inside)
		sound_active_inside.start()

/**
 * Weather enters the winding down phase, stops effects
 *
 * Updates areas to be in the winding down phase
 * Sends sounds and messages to mobs to notify them
 *
 */
/datum/weather/proc/wind_down()
	if(stage >= WIND_DOWN_STAGE)
		return
	stage = WIND_DOWN_STAGE
	update_areas()
	for(var/M in GLOB.player_list)
		var/turf/mob_turf = get_turf(M)
		if(mob_turf && my_controller.mapzone.is_in_bounds(mob_turf))
			if(end_message)
				to_chat(M, end_message)
			if(end_sound)
				SEND_SOUND(M, sound(end_sound))
	addtimer(CALLBACK(src, .proc/end), end_duration)

	if(sound_active_outside)
		sound_active_outside.stop()
	if(sound_active_inside)
		sound_active_inside.stop()
	if(sound_weak_outside)
		sound_weak_outside.start()
	if(sound_weak_inside)
		sound_weak_inside.start()

/**
 * Fully ends the weather
 *
 * Effects no longer occur and area overlays are removed
 * Removes weather from processing completely
 *
 */
/datum/weather/proc/end()
	if(stage == END_STAGE)
		return 1
	stage = END_STAGE
	update_areas()
	if(sound_weak_outside)
		sound_weak_outside.start()
	if(sound_weak_inside)
		sound_weak_inside.start()
	if(sound_active_outside)
		qdel(sound_active_outside)
	if(sound_active_inside)
		qdel(sound_active_inside)
	if(sound_weak_outside)
		sound_weak_outside.stop()
		qdel(sound_weak_outside)
	if(sound_weak_inside)
		sound_weak_inside.stop()
		qdel(sound_weak_inside)
	qdel(src)

/**
 * Returns TRUE if the living mob can be affected by the weather
 *
 */
/datum/weather/proc/can_weather_act(mob/living/L)
	var/turf/mob_turf = get_turf(L)
	if(mob_turf && !my_controller.mapzone.is_in_bounds(mob_turf))
		return
	if(immunity_type in L.weather_immunities)
		return
	if(!(get_area(L) in impacted_areas))
		return
	return TRUE

/**
 * Affects the mob with whatever the weather does
 *
 */
/datum/weather/proc/weather_act(mob/living/L)
	return

/**
 * Updates the overlays on impacted areas
 *
 */
/datum/weather/proc/update_areas()
	for(var/area/N as anything in impacted_areas)
		if(stage == MAIN_STAGE && multiply_blend_on_main_stage)
			N.blend_mode = BLEND_MULTIPLY
		else
			N.blend_mode = BLEND_OVERLAY
		if(stage == MAIN_STAGE && opacity_in_main_stage)
			N.set_opacity(TRUE)
		else
			N.set_opacity(FALSE)
		N.layer = overlay_layer
		N.plane = overlay_plane
		N.icon = 'icons/effects/weather_effects.dmi'
		N.color = weather_color
		set_area_icon_state(N)
		if(stage == END_STAGE)
			N.color = null
			N.icon = 'icons/turf/areas.dmi'
			N.layer = initial(N.layer)
			N.plane = initial(N.plane)
			N.set_opacity(FALSE)

/datum/weather/proc/set_area_icon_state(area/Area)
	switch(stage)
		if(STARTUP_STAGE)
			Area.icon_state = telegraph_overlay
		if(MAIN_STAGE)
			Area.icon_state = weather_overlay
		if(WIND_DOWN_STAGE)
			Area.icon_state = end_overlay
		if(END_STAGE)
			Area.icon_state = ""

/datum/weather/proc/do_thunder()
	var/picked_sound = THUNDER_SOUND
	for(var/i in 1 to impacted_areas.len)
		var/atom/thing = impacted_areas[i]
		SEND_SOUND(thing, sound(picked_sound, volume = 65))
	for(var/i in 1 to outside_areas.len)
		var/atom/thing = outside_areas[i]
		SEND_SOUND(thing, sound(picked_sound, volume = 35))
