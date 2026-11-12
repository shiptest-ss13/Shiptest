/datum/idle_behavior/idle_random_walk
	///Chance that the mob random walks per second
	var/walk_chance = 25

/datum/idle_behavior/idle_random_walk/perform_idle_behavior(seconds_per_tick, datum/ai_controller/controller)
	. = ..()
	var/mob/living/living_pawn = controller.pawn

	if(SPT_PROB(walk_chance, seconds_per_tick) && (living_pawn.mobility_flags & MOBILITY_MOVE) && isturf(living_pawn.loc) && !living_pawn.pulledby && !LAZYLEN(living_pawn.do_afters))
		var/move_dir = pick(GLOB.alldirs)
		var/turf/destination = get_step(living_pawn, move_dir)
		if(destination && (is_ai_hazard_turf(destination, living_pawn) || ai_diagonal_crosses_hazard(get_turf(living_pawn), destination, living_pawn)))
			return // don't wander off into a chasm or lava
		if(destination && is_ai_swimming_water(destination) && !is_ai_swimming_water(get_turf(living_pawn)))
			return // or off for a swim, like into a moat we'd struggle to climb back out of
		if(destination && !can_wander_to(controller, destination))
			return
		living_pawn.Move(destination, move_dir)

// whether we'd wander onto destination, past the hazards we always keep off
/datum/idle_behavior/idle_random_walk/proc/can_wander_to(datum/ai_controller/controller, turf/destination)
	return TRUE

// human NPCs mill about less, so they're not forever shuffling round their posts
/datum/idle_behavior/idle_random_walk/human
	walk_chance = 5
	//while we're standing over someone we downed, how close to them we keep, unless we're already further off, in which case no further
	var/guard_wander_range = 3

// standing over someone we downed, we only mill about where we can still see them
/datum/idle_behavior/idle_random_walk/human/can_wander_to(datum/ai_controller/controller, turf/destination)
	var/mob/living/downed = controller.blackboard[BB_BASIC_MOB_DOWNED_TARGET]
	var/turf/their_turf = get_turf(downed)
	if(QDELETED(downed) || !their_turf)
		return TRUE
	var/distance = get_dist(destination, their_turf)
	if(distance > max(guard_wander_range, get_dist(controller.pawn, their_turf)))
		return FALSE
	if(ai_too_dark_to_see(controller.pawn, downed, their_turf, distance, AI_DEFAULT_VISION_RANGE))
		return FALSE
	return downed in hearers(distance, destination)
