// Helpers for AI working out what it can see, in the light and the dark

/proc/ai_can_see(atom/viewer, atom/target, range = AI_DEFAULT_VISION_RANGE)
	var/turf/viewer_turf = get_turf(viewer)
	var/turf/target_turf = get_turf(target)
	if(!viewer_turf || !target_turf || viewer_turf.z != target_turf.z)
		return FALSE
	var/distance = get_dist(viewer_turf, target_turf)
	if(distance > range)
		return FALSE
	if(viewer_turf == target_turf)
		return TRUE
	if(ai_too_dark_to_see(viewer, target, target_turf, distance, range))
		return FALSE
	return viewer in ai_cached_hearers(target, range)

// whether it's too dark for viewer to make out target from distance tiles off, for when we already know there's a line of sight, like from hearers()
/proc/ai_too_dark_to_see(atom/viewer, atom/target, turf/target_turf, distance, range)
	if(distance <= max(2, round(range / 3)) || !ai_is_dark(target_turf) || is_ai_revealed_in_dark(target))
		return FALSE
	// humans only, others can see in dark mostly i guess
	var/mob/living/basic/human/human_viewer = viewer
	return istype(human_viewer) && human_viewer.see_in_dark < AI_NIGHT_VISION

// hearers(range, target), worked out once a tick for each target and range, as several AI looking at the same someone in the same tick would otherwise each work out the same thing
/proc/ai_cached_hearers(atom/target, range)
	var/static/list/hearers_cache = list()
	var/static/cache_time = -1
	if(cache_time != world.time)
		hearers_cache.Cut()
		cache_time = world.time
	var/key = "[REF(target)]-[range]"
	var/list/cached = hearers_cache[key]
	if(cached && cached[1] == target.loc)
		return cached[2]
	var/list/heard_by = hearers(range, target)
	hearers_cache[key] = list(target.loc, heard_by)
	return heard_by

GLOBAL_LIST_EMPTY(ai_revealed_in_dark)

/proc/ai_mark_revealed_in_dark(atom/thing, duration)
	if(length(GLOB.ai_revealed_in_dark) > 200) // forget those long since hidden again, so this doesn't grow forever
		for(var/old_ref in GLOB.ai_revealed_in_dark)
			if(GLOB.ai_revealed_in_dark[old_ref] < world.time)
				GLOB.ai_revealed_in_dark -= old_ref
	GLOB.ai_revealed_in_dark[REF(thing)] = world.time + duration

/proc/is_ai_revealed_in_dark(atom/thing)
	return GLOB.ai_revealed_in_dark[REF(thing)] > world.time

// whether spot is dark enough that AI only makes out what's there up close
/proc/ai_is_dark(turf/spot)
	return isturf(spot) && spot.get_lumcount() < AI_DARKNESS_THRESHOLD
