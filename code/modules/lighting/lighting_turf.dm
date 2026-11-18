// Causes any affecting light sources to be queued for a visibility update, for example a door got opened.
/turf/proc/reconsider_lights()
	lighting_corner_NE?.vis_update()
	lighting_corner_SE?.vis_update()
	lighting_corner_SW?.vis_update()
	lighting_corner_NW?.vis_update()

/turf/proc/lighting_clear_overlay()
	if (lighting_object)
		qdel(lighting_object, force=TRUE)

// Builds a lighting object for us, but only if our area is dynamic.
/turf/proc/lighting_build_overlay()
	if (lighting_object)
		qdel(lighting_object, force=TRUE) //Shitty fix for lighting objects persisting after death

	var/area/turf_area = loc
	if (!turf_area.static_lighting && !light_sources)
		return

	new/atom/movable/lighting_object(src)

// Used to get a scaled lumcount.
/turf/proc/get_lumcount(minlum = 0, maxlum = 1)
	if (!lighting_object)
		return 1

	var/totallums = 0
	var/datum/lighting_corner/L
	L = lighting_corner_NE
	if (L)
		totallums += L.lum_r + L.lum_b + L.lum_g
	L = lighting_corner_SE
	if (L)
		totallums += L.lum_r + L.lum_b + L.lum_g
	L = lighting_corner_SW
	if (L)
		totallums += L.lum_r + L.lum_b + L.lum_g
	L = lighting_corner_NW
	if (L)
		totallums += L.lum_r + L.lum_b + L.lum_g


	totallums /= 12 // 4 corners, each with 3 channels, get the average.

	// Base lighting is an overlay, not corners, so add it in.
	var/area/turf_area = loc
	if(turf_area.base_lighting_is_daylight)
		if(!planet_daylight_exact || IS_OPAQUE_TURF(src) || !totallums)
			totallums = max(totallums, turf_area.base_lighting_lumcount)
	else
		totallums += turf_area.base_lighting_lumcount

	totallums = (totallums - minlum) / (maxlum - minlum)

	totallums += dynamic_lumcount

	return CLAMP01(totallums)

// Returns a boolean whether the turf is on soft lighting.
// Soft lighting being the threshold at which point the overlay considers
// itself as too dark to allow sight and see_in_dark becomes useful.
// So basically if this returns true the tile is unlit black.
/turf/proc/is_softly_lit()
	if (!lighting_object)
		return FALSE

	var/area/turf_area = loc
	return !(turf_area.area_has_base_lighting || lighting_object.luminosity || dynamic_lumcount)


///Proc to add movable sources of opacity on the turf and let it handle lighting code.
/turf/proc/add_opacity_source(atom/movable/new_source)
	LAZYADD(opacity_sources, new_source)
	if(opacity)
		return
	recalculate_directional_opacity()


///Proc to remove movable sources of opacity on the turf and let it handle lighting code.
/turf/proc/remove_opacity_source(atom/movable/old_source)
	LAZYREMOVE(opacity_sources, old_source)
	if(opacity) //Still opaque, no need to worry on updating.
		return
	recalculate_directional_opacity()


///Calculate on which directions this turfs block view.
/turf/proc/recalculate_directional_opacity()
	. = directional_opacity
	if(opacity)
		directional_opacity = ALL_CARDINALS
		if(. != directional_opacity)
			reconsider_lights()
			queue_daylight_opacity_redraw()
		return
	directional_opacity = NONE
	for(var/am in opacity_sources)
		var/atom/movable/opacity_source = am
		if(opacity_source.flags_1 & ON_BORDER_1)
			directional_opacity |= opacity_source.dir
		else //If fulltile and opaque, then the whole tile blocks view, no need to continue checking.
			directional_opacity = ALL_CARDINALS
			break
	if(. != directional_opacity && (. == ALL_CARDINALS || directional_opacity == ALL_CARDINALS))
		reconsider_lights() //The lighting system only cares whether the tile is fully concealed from all directions or not.
		queue_daylight_opacity_redraw()


/turf/proc/change_area(area/old_area, area/new_area)
	if(SSlighting.initialized && !space_lit)
		if (new_area.static_lighting != old_area.static_lighting)
			if (new_area.static_lighting)
				lighting_build_overlay()
			else
				lighting_clear_overlay()

	// Manage removing/adding starlight overlays, we'll inherit from the area so we can drop it if the area has it already
	if(space_lit)
		if(!area_lights_space_turfs(new_area) && area_lights_space_turfs(old_area))
			add_overlay(/obj/effect/fullbright)
		else if (area_lights_space_turfs(new_area) && !area_lights_space_turfs(old_area))
			cut_overlay(/obj/effect/fullbright)

	// Only touch visibility when base lighting is gained or lost.
	if(new_area.area_has_base_lighting)
		luminosity = 1
	else if(old_area.area_has_base_lighting && lighting_object)
		luminosity = 0
