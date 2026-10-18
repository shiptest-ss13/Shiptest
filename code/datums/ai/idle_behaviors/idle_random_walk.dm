/datum/idle_behavior/idle_random_walk
	///Chance that the mob random walks per second
	var/walk_chance = 25

/datum/idle_behavior/idle_random_walk/perform_idle_behavior(seconds_per_tick, datum/ai_controller/controller)
	. = ..()
	var/mob/living/living_pawn = controller.pawn

	if(SPT_PROB(walk_chance, seconds_per_tick) && (living_pawn.mobility_flags & MOBILITY_MOVE) && isturf(living_pawn.loc) && !living_pawn.pulledby && !LAZYLEN(living_pawn.do_afters))
		var/move_dir = pick(GLOB.alldirs)
		var/turf/destination = get_step(living_pawn, move_dir)
		if(destination && (is_ai_hazard_turf(destination) || ai_diagonal_crosses_hazard(get_turf(living_pawn), destination)))
			return // don't wander off into a chasm or lava
		living_pawn.Move(destination, move_dir)

// human NPCs mill about less, so they're not forever shuffling round their posts
/datum/idle_behavior/idle_random_walk/human
	walk_chance = 10
