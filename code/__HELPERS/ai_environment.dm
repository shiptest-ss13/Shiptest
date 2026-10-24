// Helpers for AI working out where it can stand without the air, heat or cold hurting it

/proc/is_environment_safe_for(mob/living/basic/basic_mob, turf/spot)
	return isnull(get_environment_hazard(basic_mob, spot))

/proc/get_environment_hazard(mob/living/basic/basic_mob, turf/spot)
	if(!isopenturf(spot))
		return AI_ENVIRONMENT_UNBREATHABLE
	var/turf/open/open_spot = spot
	var/datum/gas_mixture/air = open_spot.air
	var/mob/living/basic/human/human_mob = basic_mob
	if(istype(human_mob) && !human_mob.pressure_sealed && (air ? air.return_pressure() : 0) < HAZARD_LOW_PRESSURE)
		return AI_ENVIRONMENT_UNBREATHABLE
	var/list/needs = basic_mob.habitable_atmos
	if(basic_mob.unsuitable_atmos_damage && length(needs))
		if(!air)
			if(ai_needs_to_breathe(basic_mob))
				return AI_ENVIRONMENT_UNBREATHABLE
		else
			// only check a few gases that are the most relevant, probably
			var/static/list/gas_needs = list(
				list("min_oxy", "max_oxy", GAS_O2),
				list("min_plas", "max_plas", GAS_PLASMA),
				list("min_n2", "max_n2", GAS_N2),
				list("min_co2", "max_co2", GAS_CO2),
			)
			for(var/list/gas_need as anything in gas_needs)
				var/minimum = needs[gas_need[1]]
				var/maximum = needs[gas_need[2]]
				if(!minimum && !maximum)
					continue // we don't care how much, just if we hit thresholds
				var/moles = air.get_moles(gas_need[3])
				if((minimum && moles < minimum) || (maximum && moles > maximum))
					return AI_ENVIRONMENT_UNBREATHABLE
	var/temperature = air ? air.return_temperature() : TCMB // no air at all is vacuum, as cold as space
	if(basic_mob.unsuitable_cold_damage && temperature < basic_mob.minimum_survivable_temperature)
		return AI_ENVIRONMENT_TOO_COLD
	if(basic_mob.unsuitable_heat_damage && temperature > basic_mob.maximum_survivable_temperature)
		return AI_ENVIRONMENT_TOO_HOT
	return null

// whether basic_mob needs some gas or other in the air, so no air at all hurts it
/proc/ai_needs_to_breathe(mob/living/basic/basic_mob)
	var/list/needs = basic_mob.habitable_atmos
	return basic_mob.unsuitable_atmos_damage && length(needs) && (needs["min_oxy"] || needs["min_tox"] || needs["min_plas"] || needs["min_n2"] || needs["min_co2"])

/proc/ai_can_stand_on(mob/living/mover, turf/spot)
	if(is_bare_space(spot) && !mover.ai_controller?.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE])
		return FALSE
	if(is_ai_hazard_turf(spot, mover))
		return FALSE
	var/mob/living/basic/basic_mover = mover
	return !istype(basic_mover) || is_environment_safe_for(basic_mover, spot)

// pick a spot to path to on the way to destination, as far as we can get to in this pathfinding hop, or null if we can't get anywhere useful
/proc/ai_pick_waypoint(mob/living/mover, turf/start, turf/destination, hop_distance, search_radius = 3)
	var/list/line = get_line(start, destination)
	var/turf/along = line[clamp(hop_distance + 1, 1, length(line))]
	var/turf/best_turf
	var/best_distance = INFINITY
	for(var/turf/open/candidate in ai_turfs_in_range(along, search_radius))
		var/candidate_distance = get_dist(along, candidate)
		if(candidate_distance >= best_distance || !ai_can_stand_on(mover, candidate))
			continue
		best_turf = candidate
		best_distance = candidate_distance
	return best_turf

/proc/is_bare_space(turf/spot)
	return isspaceturf(spot) && !(locate(/obj/structure/lattice) in spot)

// do hazard check on diagonal steps too, as its actually two steps
/proc/ai_diagonal_crosses_hazard(turf/start, turf/finish)
	if(!start || !finish || start.x == finish.x || start.y == finish.y)
		return FALSE
	return is_ai_hazard_turf(locate(finish.x, start.y, start.z)) || is_ai_hazard_turf(locate(start.x, finish.y, start.z))

/proc/ai_immune_to_tear_gas(mob/living/victim)
	var/mob/living/basic/human/basic_human = victim
	return !istype(basic_human) || basic_human.pepper_proof

// whether smoke will irritate eyes, like tear gas
/proc/is_ai_irritant_smoke(turf/spot)
	if(!spot || !(locate(/obj/effect/particle_effect/smoke/chem) in spot))
		return FALSE // short circuit so we dont check a billion turfs
	for(var/obj/effect/particle_effect/smoke/chem/smoke in spot)
		if(smoke.reagents?.has_reagent(/datum/reagent/consumable/condensedcapsaicin))
			return TRUE
	return FALSE

// whether stepping from start to finish would take mover from clear air into tear gas that'd get to them, which we keep out of once we're out
/proc/ai_steps_into_tear_gas(atom/movable/mover, turf/start, turf/finish)
	var/mob/living/living_mover = mover
	if(!istype(living_mover) || ai_immune_to_tear_gas(living_mover))
		return FALSE
	return !is_ai_irritant_smoke(start) && is_ai_irritant_smoke(finish)

// whether spot is water deep enough to swim in
/proc/is_ai_swimming_water(turf/spot)
	var/turf/open/water/water = spot
	return istype(water) && water.is_swimming_tile

// mover is who it might hurt, as some, like those in fire suits, can walk through fire
/proc/is_ai_hazard_turf(turf/spot, atom/movable/mover)
	if(HAS_TRAIT(spot, TRAIT_AI_AVOID))
		return TRUE // a mapper wants us kept off it
	if(istype(spot, /turf/open/chasm))
		return !HAS_TRAIT(spot, TRAIT_CHASM_STOPPED)
	if(istype(spot, /turf/open/lava))
		var/turf/open/lava/lava_spot = spot
		return !lava_spot.is_safe()
	if(istype(spot, /turf/open/water/acid))
		var/turf/open/water/acid/acid_spot = spot
		return !acid_spot.is_safe_to_cross() && !ai_is_acidproof(mover)
	for(var/obj/structure/hazard/hazard in spot)
		if(ai_harmful_hazard(hazard))
			return TRUE
	if(((locate(/obj/effect/hotspot) in spot) || (locate(/obj/effect/abstract/turf_fire) in spot)) && !ai_is_fireproof(mover))
		return TRUE
	for(var/mob/living/burning in spot)
		if(burning != mover && burning.on_fire && !ai_is_fireproof(mover))
			return TRUE // for burning objects or bodies
	for(var/obj/item/mine/mine in spot)
		if(mine.armed && !mine.invisibility)
			return TRUE
	return FALSE

/proc/ai_is_fireproof(atom/movable/mover)
	var/mob/living/basic/human/basic_human = mover
	if(istype(basic_human))
		return basic_human.get_outfit_thermal_protection() >= FIRE_SUIT_MAX_TEMP_PROTECT
	return isliving(mover) && HAS_TRAIT(mover, TRAIT_RESISTHEAT)

/proc/ai_is_acidproof(atom/movable/mover)
	var/mob/living/living_mover = mover
	if(!istype(living_mover))
		return FALSE
	if((living_mover.movement_type & FLYING) || ("acid" in living_mover.weather_immunities))
		return TRUE
	var/mob/living/basic/human/basic_human = mover
	return istype(basic_human) && basic_human.has_acidproof_outfit()

// special cases for ruin hazards
/proc/ai_harmful_hazard(obj/structure/hazard/hazard)
	if(hazard.disabled)
		return FALSE
	if(istype(hazard, /obj/structure/hazard/fire))
		return TRUE
	var/obj/structure/hazard/electrical/electrical_hazard = hazard
	if(istype(electrical_hazard))
		return electrical_hazard.contact_damage > 1
	var/obj/structure/hazard/floor/floor_hazard = hazard
	if(istype(floor_hazard))
		return floor_hazard.contact_damage > 1
	return FALSE

// whether breaking blocker would make our environment unsafe
/proc/breaking_would_vent(mob/living/basic/basic_mob, atom/blocker)
	var/turf/blocker_turf = get_turf(blocker)
	if(!blocker_turf || !is_environment_safe_for(basic_mob, get_turf(basic_mob)))
		return FALSE
	var/list/sides = list()
	if(blocker.flags_1 & ON_BORDER_1)
		var/turf/across = get_step(blocker_turf, blocker.dir)
		if(!across || blocker.CanAtmosPass(across))
			return FALSE // it's not holding back any air
		sides += blocker_turf
		sides += across
	else
		for(var/direction in GLOB.cardinals)
			var/turf/beside = get_step(blocker_turf, direction)
			if(isopenturf(beside) && !blocker.CanAtmosPass(beside))
				sides += beside
	for(var/turf/side as anything in sides)
		if(isopenturf(side) && !is_environment_safe_for(basic_mob, side))
			return TRUE
	return FALSE

// whether vacuum can't hurt us
/proc/ai_unbothered_by_vacuum(atom/movable/mover)
	var/mob/living/basic/basic_mob = mover
	if(!istype(basic_mob))
		return FALSE
	var/mob/living/basic/human/human_mob = basic_mob
	if(istype(human_mob) && !human_mob.pressure_sealed)
		return FALSE
	if(ai_needs_to_breathe(basic_mob))
		return FALSE // needs something to breathe
	return !basic_mob.unsuitable_cold_damage || basic_mob.minimum_survivable_temperature <= TCMB

// whether mover can let the air out, for prying airlocks
/proc/ai_safe_to_vent(atom/movable/mover, atom/vent_point, range = 7)
	if(!ai_unbothered_by_vacuum(mover))
		return FALSE
	var/mob/living/living_mover = mover
	if(!istype(living_mover))
		return TRUE
	// only those who'd be caught in it, in sight of where the air gets out, not anyone of ours behind another wall or door
	for(var/mob/living/ally in hearers(range, vent_point || mover))
		if(ally != mover && ally.stat == CONSCIOUS && !ally.client && istype(ally.ai_controller, /datum/ai_controller) && living_mover.faction_check_mob(ally) && !ai_unbothered_by_vacuum(ally))
			return FALSE
	return TRUE

// cursed edge blockers
/proc/get_edge_movement_blocker(atom/movable/mover, direction)
	var/turf/our_turf = get_turf(mover)
	for(var/obj/thing in our_turf)
		if(!(thing.flags_1 & ON_BORDER_1) || !thing.density || !(thing.dir & direction))
			continue
		if(!thing.CanAStarPass(null, direction, mover))
			return thing
	return null

// flipped tables still inherit the climbable = TRUE var for some reason, so we exclude that from the AI's climbing logic.
/proc/ai_can_climb(atom/thing)
	return HAS_TRAIT(thing, TRAIT_CLIMBABLE) && !istype(thing, /obj/structure/barricade/directional/flippedtable)

/proc/ai_can_push_aside(atom/movable/mover, obj/thing, push_dir)
	var/mob/living/basic/human/pusher = mover
	if(!istype(pusher) || pusher.client || !pusher.ai_controller || ISDIAGONALDIR(push_dir))
		return FALSE // no pushing on a diagonal
	if(thing.anchored || !thing.density || (thing.flags_1 & ON_BORDER_1) || pusher.move_force < thing.move_resist * MOVE_FORCE_PUSH_RATIO)
		return FALSE
	var/turf/beyond = get_step(thing, push_dir)
	if(!beyond || beyond.is_blocked_turf(FALSE, thing) || ai_is_doorway(beyond))
		return FALSE // nowhere for it to go, or it'd jam the way through
	// check for room, don't jam it!
	var/turf/one_side = get_step(beyond, turn(push_dir, 90))
	var/turf/other_side = get_step(beyond, turn(push_dir, -90))
	return (one_side && !one_side.is_blocked_turf(TRUE)) || (other_side && !other_side.is_blocked_turf(TRUE))

/proc/ai_can_open_closet(atom/movable/mover, obj/structure/closet/closet)
	var/mob/living/basic/human/opener = mover
	if(!istype(opener) || opener.client || !opener.ai_controller || istype(closet, /obj/structure/closet/cardboard))
		return FALSE // boxes are for investigate_box to find
	return closet.density && !closet.opened && !closet.dense_when_open && !closet.wall_mounted && !closet.welded && !closet.locked
