/datum/element/turf_z_transparency
	element_flags = ELEMENT_DETACH //Important so it is properly cleared out on turf qdel.

///This proc sets up the signals to handle updating viscontents when turfs above/below update. Handle plane and layer here too so that they don't cover other obs/turfs in Dream Maker
/datum/element/turf_z_transparency/Attach(turf/our_turf, show_bottom_level = TRUE)
	. = ..()
	if(!isturf(our_turf))
		return ELEMENT_INCOMPATIBLE

	our_turf.plane = OPENSPACE_PLANE
	our_turf.layer = OPENSPACE_LAYER

	RegisterSignal(our_turf, COMSIG_TURF_MULTIZ_DEL, PROC_REF(on_multiz_turf_del), TRUE)
	RegisterSignal(our_turf, COMSIG_TURF_MULTIZ_NEW, PROC_REF(on_multiz_turf_new), TRUE)
	RegisterSignal(our_turf, COMSIG_TURF_INITIALIZE_TRANSPARENCY, PROC_REF(initilize_turf_transparency), TRUE)

	ADD_TRAIT(our_turf, TURF_Z_TRANSPARENT_TRAIT, TURF_TRAIT)
	if(show_bottom_level) //Sets up the trait to check when initializing the turf elsewhere.
		ADD_TRAIT(our_turf, TURF_Z_SHOW_BOTTOM_TRAIT, TURF_TRAIT)

/datum/element/turf_z_transparency/Detach(datum/source, force)
	. = ..()
	var/turf/our_turf = source
	our_turf.vis_contents.len = 0 //vis_contents are handled by Destroy() when a turf is qdel'd, but you could also call Detach from elsewhere.
	UnregisterSignal(our_turf, COMSIG_TURF_MULTIZ_DEL)
	UnregisterSignal(our_turf, COMSIG_TURF_MULTIZ_NEW)
	UnregisterSignal(our_turf, COMSIG_TURF_INITIALIZE_TRANSPARENCY)
	REMOVE_TRAIT(our_turf, TURF_Z_TRANSPARENT_TRAIT, TURF_TRAIT)
	REMOVE_TRAIT(our_turf, TURF_Z_SHOW_BOTTOM_TRAIT, TURF_TRAIT)

///Updates the viscontents or underlays below this tile.
/datum/element/turf_z_transparency/proc/update_multiz(turf/our_turf, prune_on_fail = FALSE, init = FALSE)
	var/turf/below_turf = our_turf.below()
	if(!below_turf)
		our_turf.vis_contents.len = 0
		if(!show_bottom_level(our_turf) && prune_on_fail) //If we cant show whats below, and we prune on fail, change the turf to plating as a fallback
			our_turf.ChangeTurf(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			return FALSE
	else
		if(init)
			our_turf.vis_contents += below_turf
		if(isclosedturf(our_turf)) //Show girders below closed turfs
			var/mutable_appearance/girder_underlay = mutable_appearance('icons/obj/structures.dmi', "girder", layer = TURF_LAYER-0.01)
			girder_underlay.appearance_flags = RESET_ALPHA | RESET_COLOR
			our_turf.underlays += girder_underlay
			var/mutable_appearance/plating_underlay = mutable_appearance('icons/turf/floors.dmi', "plating", layer = TURF_LAYER-0.02)
			plating_underlay = RESET_ALPHA | RESET_COLOR
			our_turf.underlays += plating_underlay
	return TRUE

/datum/element/turf_z_transparency/proc/on_multiz_turf_del(turf/our_turf, turf/T, dir)
	SIGNAL_HANDLER
	if(dir != DOWN)
		return
	update_multiz(our_turf)

/datum/element/turf_z_transparency/proc/on_multiz_turf_new(turf/our_turf, turf/T, dir)
	SIGNAL_HANDLER
	if(dir != DOWN)
		return
	update_multiz(our_turf)

/**
 * Initializes, or actually gives appearance to, transparent tiles.
 *
 * Called via COMSIG_TURF_INITIALIZE_TRANSPARENCY from:
 * ChangeTurf() - generic case for glass floors, initialized when plating turns into glass floor.
 * on_applied_turf() - material application, special case. You can make transparent tiled floor, so it's initialized here as the proc calls are different.
 * onShuttleMove() is a case for both glass and material floors, as it's called only when the shuttle moves.
 *
 * We do these calls as late as possible to get a full baseturfs list to later pass to show_bottom_level().
 * This should have no effect on multi-z performance, but I have not tested it.
 *
 * Arguments:
 * * our_turf - turf being passed to initialize transparency. Only tested on open turfs.
 */
/datum/element/turf_z_transparency/proc/initilize_turf_transparency(turf/our_turf)
	SIGNAL_HANDLER
	update_multiz(our_turf, TRUE, TRUE)

///Called when there is no real turf below this turf
/datum/element/turf_z_transparency/proc/show_bottom_level(turf/our_turf)
	if(!HAS_TRAIT(our_turf, TURF_Z_SHOW_BOTTOM_TRAIT))
		return FALSE

	var/turf/path
	if(our_turf.baseturfs && length(our_turf.baseturfs) > 1)
		path = our_turf.baseturfs[2] //Why 2? It's usually a better indicator of what we landed on.
		if(ispath(path, /turf/closed)) //Do not want to show walls, looks strange.
			path = our_turf.baseturfs[1] //The first element is going to be a floor of some kind.

	if(!path) //Fallback to the regular, bland, method of determining a level baseturf.
		path = our_turf.get_z_base_turf()

	//PLANE_SPACE to show the parallax if it's a space tile.
	var/mutable_appearance/underlay_appearance = mutable_appearance(initial(path.icon), initial(path.icon_state), layer = TURF_LAYER-0.02, plane = (ispath(path, /turf/open/space) ? PLANE_SPACE : null))
	underlay_appearance.appearance_flags = RESET_ALPHA | RESET_COLOR
	our_turf.underlays += underlay_appearance
	return TRUE
