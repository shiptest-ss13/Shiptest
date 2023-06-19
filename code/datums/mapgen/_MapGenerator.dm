/// Management type used by SSmap_gen to queue map generation jobs.
/datum/map_generator
	/// If FALSE, the MAPGEN_PHASE_POPULATE phase will be skipped; populate_turf will not be called on turfs in the turfs list.
	/// Please ensure this is set correctly.
	var/do_populate

	/// The list of turfs, passed in New(), that this map generator was created to modify.
	/// Should not be modified while the map generator is in the SSmap_gen queue, as this can
	/// cause errors and incomplete generation.
	var/list/turfs

	/// A map_template datum instance to be placed as a ruin on the given turf.
	/// The template is placed after the turf generation phase and before the turf population phase.
	var/datum/map_template/template
	/// The template var is placed with as its bottom-left turf.
	var/turf/template_turf

	// Vars below are managed by SSmap_gen and should not be touched directly.

	/// The map generator's current "phase", used my SSmap_gen to determine which operations it should run.
	/// As it is a numeric value, it is also used to determine the map generator's progress towards completion.
	var/phase = MAPGEN_PHASE_GENERATE
	/// The current
	var/phase_index = 1
	/// The "priority" of the datum in the SSmap_gen job queue,
	var/priority

/datum/map_generator/New(list/_turfs, datum/map_template/_template = null, turf/_template_turf = null)
	turfs = _turfs
	template = _template
	template_turf = _template_turf
	return ..()

/datum/map_generator/Destroy(...)
	if(phase == MAPGEN_PHASE_GENERATE && phase_index == 1)
		stack_trace("map_generator datum ([REF(src)], [type]) told to qdelete without having started generation!")
	else if(phase != MAPGEN_PHASE_FINISHED)
		stack_trace("map_generator datum ([REF(src)], [type]) told to qdelete while unfinished!")
	SSmap_gen.jobs -= src
	return ..()

/// This proc is called by SSmap_gen during the MAPGEN_PHASE_GENERATE phase, on a turf passed to the map_generator
/// datum in New(). It should respect the changeturf_flags argument in any call to ChangeTurf or a derived proc.
/// The ruin will not be placed until after all turfs have generated, and as such, this proc should not
/// create objects which might overlap with an instanced map template.
/// Should not sleep.
/datum/map_generator/proc/generate_turf(turf/gen_turf, changeturf_flags)
	SHOULD_NOT_SLEEP(TRUE)
	return

/// This proc is called by SSmap_gen during the MAPGEN_PHASE_POPULATE phase, on a turf passed to the map_generator
/// datum in New(). As this is done AFTER ruin placement, it is able to check the area / area flags to ensure that
/// objects are not placed inside the ruin.
/// Should not sleep.
/datum/map_generator/proc/populate_turf(turf/gen_turf)
	SHOULD_NOT_SLEEP(TRUE)
	return
