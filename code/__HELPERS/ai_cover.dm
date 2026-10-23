// Helpers for AI working out where's safe from someone shooting at it, and where it can shoot from

// find if a shot will hit something
/proc/get_shot_blocker(turf/start, turf/finish, x_offset = 0, y_offset = 0, pass_flags = AI_THREAT_SHOT_PASS_FLAGS)
	if(start.z != finish.z)
		return finish
	var/start_x = start.x * world.icon_size + world.icon_size / 2
	var/start_y = start.y * world.icon_size + world.icon_size / 2
	var/end_x = finish.x * world.icon_size + world.icon_size / 2 + x_offset
	var/end_y = finish.y * world.icon_size + world.icon_size / 2 + y_offset
	var/steps = max(1, round(sqrt((end_x - start_x) ** 2 + (end_y - start_y) ** 2) / 8))
	var/turf/previous = start
	for(var/step in 1 to steps)
		var/fraction = step / steps
		var/turf/sample = locate(round((start_x + (end_x - start_x) * fraction) / world.icon_size), round((start_y + (end_y - start_y) * fraction) / world.icon_size), start.z)
		if(!sample || sample == previous)
			continue
		if(sample.x != previous.x && sample.y != previous.y)
			// cutting diagonally between tiles, so it's only blocked if both sides of the gap are
			var/atom/first_side = get_tile_shot_blocker(locate(sample.x, previous.y, start.z), pass_flags)
			var/atom/second_side = get_tile_shot_blocker(locate(previous.x, sample.y, start.z), pass_flags)
			if(first_side && second_side)
				return first_side
			var/atom/corner_edge = get_edge_shot_blocker(previous, sample, pass_flags)
			if(corner_edge)
				return corner_edge // a directional window on the corner we're cutting
		else
			var/atom/edge_blocker = get_edge_shot_blocker(previous, sample, pass_flags)
			if(edge_blocker)
				return edge_blocker
		previous = sample
		if(sample == start || sample == finish)
			continue
		var/atom/blocker = get_tile_shot_blocker(sample, pass_flags)
		if(blocker)
			return blocker
	return null

// what on spot would stop a shot with pass_flags passing through it, if anything. the turf itself, or something solid on it?
/proc/get_tile_shot_blocker(turf/spot, pass_flags = AI_THREAT_SHOT_PASS_FLAGS)
	if(!spot)
		return null
	if(spot.density)
		return spot
	for(var/obj/thing in spot)
		if(blocks_shot_on_tile(thing, pass_flags))
			return thing
	return null

// whether thing stops a shot with pass_flags
/proc/blocks_shot_on_tile(obj/thing, pass_flags)
	if(!thing.density || (thing.flags_1 & ON_BORDER_1) || (thing.pass_flags_self & pass_flags) || ai_is_cover(thing))
		return FALSE
	// a door you can see through lets through shots that pass glass, as /obj/machinery/door/CanAllowThrough() does, so a glass airlock's no cover from lasers
	return !(istype(thing, /obj/machinery/door) && !thing.opacity && (pass_flags & PASSGLASS))

// more edge blocker handling
/proc/get_edge_shot_blocker(turf/from_turf, turf/to_turf, pass_flags)
	var/crossing = get_dir(from_turf, to_turf)
	var/reverse = REVERSE_DIR(crossing)
	for(var/obj/thing in from_turf)
		if(edge_stops_shot(thing, crossing, pass_flags))
			return thing
	for(var/obj/thing in to_turf)
		if(edge_stops_shot(thing, reverse, pass_flags))
			return thing
	return null

/proc/edge_stops_shot(obj/thing, edge_dir, pass_flags)
	if(!thing.density || !(thing.flags_1 & ON_BORDER_1) || !(thing.dir & edge_dir))
		return FALSE
	if(istype(thing, /obj/machinery/door))
		return thing.opacity || !(pass_flags & PASSGLASS)
	if(istype(thing, /obj/structure/window))
		return !(pass_flags & PASSGLASS)
	return FALSE

/proc/is_spot_safe_from(turf/spot, turf/danger)
	if(!get_shot_blocker(danger, spot))
		return FALSE
	// only aiming across the line of fire changes what a shot clips, so check the two corners furthest to either side of it, or the middle of each side straight along a row or column
	var/across_x = SIGN(danger.y - spot.y) * 12
	var/across_y = SIGN(spot.x - danger.x) * 12
	return get_shot_blocker(danger, spot, across_x, across_y) && get_shot_blocker(danger, spot, -across_x, -across_y)

// whether this is cover that blocks most shots from anyone not right behind it, like sandbags or barricades
/proc/ai_is_cover(atom/thing)
	if(!isobj(thing))
		return FALSE
	var/obj/cover = thing
	return cover.density && cover.anchored && cover.GetComponent(/datum/component/cover)

/proc/can_walk_straight_to(atom/movable/mover, turf/destination)
	var/turf/start = get_turf(mover)
	var/access = mover.ai_controller?.get_access()
	var/turf/previous = start
	for(var/turf/line_turf as anything in get_line(start, destination))
		if(line_turf == start)
			continue
		if(line_turf.is_blocked_turf(TRUE, mover))
			return FALSE
		// edges count too, like a directional window or a railing, the way our pathfinding judges them
		if(previous.LinkBlockedWithAccess(line_turf, mover, access))
			return FALSE
		previous = line_turf
	return TRUE

// the turfs within range of center, instead of range() which gives everything including the turf
/proc/ai_turfs_in_range(turf/center, range)
	return block(
		locate(max(center.x - range, 1), max(center.y - range, 1), center.z),
		locate(min(center.x + range, world.maxx), min(center.y + range, world.maxy), center.z)
	)

/proc/find_hiding_spot(atom/movable/mover, turf/danger, range = 3, turf/exclude)
	var/turf/our_turf = get_turf(mover)
	if(!our_turf)
		return null
	var/turf/best_turf
	var/best_distance = INFINITY
	for(var/turf/open/candidate in ai_turfs_in_range(our_turf, range))
		var/candidate_distance = get_dist(our_turf, candidate)
		if(candidate == exclude || candidate_distance >= best_distance || !ai_can_take_spot(mover, candidate))
			continue
		if(!is_spot_safe_from(candidate, danger) || !can_walk_straight_to(mover, candidate))
			continue
		best_turf = candidate
		best_distance = candidate_distance
	return best_turf

/proc/ally_in_line_of_fire(mob/living/shooter, turf/start, turf/finish)
	for(var/turf/line_turf as anything in get_line(start, finish))
		for(var/mob/living/maybe_ally in line_turf)
			if(maybe_ally != shooter && !ai_shot_passes_over(maybe_ally) && shooter.faction_check_mob(maybe_ally))
				return TRUE
	return FALSE

// whether a shot not aimed at someone flies over them
/proc/ai_shot_passes_over(mob/living/someone)
	return someone.stat != CONSCIOUS || (HAS_TRAIT(someone, TRAIT_IMMOBILIZED) && HAS_TRAIT(someone, TRAIT_FLOORED) && HAS_TRAIT(someone, TRAIT_HANDS_BLOCKED))

/proc/target_can_shoot_back(atom/target)
	if(!ismob(target))
		return TRUE // turrets and mechs
	var/mob/target_mob = target
	if(!isturf(target_mob.loc))
		return FALSE
	return target_mob.is_holding_item_of_type(/obj/item/gun) || target_mob.GetComponent(/datum/component/ranged_attacks)

/proc/get_ai_shot_pass_flags(mob/living/shooter)
	var/datum/component/ranged_attacks/ranged_attack = shooter.GetComponent(/datum/component/ranged_attacks)
	return ranged_attack ? ranged_attack.get_pass_flags() : PASSTABLE

/proc/ai_is_door(atom/thing)
	return istype(thing, /obj/machinery/door) || istype(thing, /obj/structure/mineral_door) || istype(thing, /obj/structure/fence/door)

// so it avoids standing in doorways
/proc/ai_is_doorway(turf/spot)
	for(var/atom/thing as anything in spot)
		if(ai_is_door(thing))
			return TRUE
	return FALSE

// whether mob could go stand on spot, not blocked, not in a doorway, nothing there that'd hurt it, and not off the post it's holding, if it is
/proc/ai_can_take_spot(mob/living/mover, turf/spot)
	if(is_ai_swimming_water(spot) && !(mover.movement_type & FLYING))
		return FALSE // no swimming in the pool!!!!
	var/post_radius = mover.ai_controller?.blackboard[BB_BASIC_MOB_POST_RADIUS]
	if(!isnull(post_radius))
		var/turf/post = mover.ai_controller.blackboard[BB_BASIC_MOB_HOME_TURF]
		if(post && get_dist(post, spot) > post_radius)
			return FALSE
	return !spot.is_blocked_turf(TRUE, mover) && !ai_is_doorway(spot) && ai_can_stand_on(mover, spot)

/proc/get_ai_fight_range(datum/ai_controller/controller)
	if(world.time < controller.blackboard[BB_BASIC_MOB_PRESSING_UNTIL])
		return list(1, 2) // everyone we're fighting is down, so we rush them while it lasts
	var/retreat_distance = controller.blackboard[BB_BASIC_MOB_RETREAT_DISTANCE]
	var/engage_distance = controller.blackboard[BB_BASIC_MOB_ENGAGE_DISTANCE]
	var/closest = isnull(retreat_distance) ? AI_DEFAULT_RETREAT_DISTANCE : retreat_distance
	return list(closest, max(closest, isnull(engage_distance) ? AI_DEFAULT_ENGAGE_DISTANCE : engage_distance))

// only shoot at something that blocks but it can destroy quickly, max_shots and magazines are how far we'll go for intentional breakage
/proc/worth_shooting_through(mob/living/shooter, atom/blocker, obj/projectile/projectile_type, max_shots = AI_MAX_SHOTS_THROUGH_COVER, magazines = 1)
	if(!isobj(blocker) || !projectile_type)
		return FALSE // walls and the like, or we're not firing anything that'd break it
	if(breaking_would_vent(shooter, blocker))
		return FALSE // dont vent if we cant survive it!!!
	var/shots_needed = shots_to_break(blocker, projectile_type, shooter)
	if(isnull(shots_needed))
		return FALSE
	var/pass_flags = initial(projectile_type.pass_flags)
	for(var/obj/thing in get_turf(blocker))
		if(thing == blocker || !blocks_shot_on_tile(thing, pass_flags))
			continue
		var/more_shots = shots_to_break(thing, projectile_type, shooter)
		if(isnull(more_shots))
			return FALSE
		shots_needed += more_shots
	var/datum/component/ai_magazine/magazine = shooter.GetComponent(/datum/component/ai_magazine)
	return shots_needed <= min(max_shots, magazine?.magazine_size ? magazine.magazine_size * magazines : max_shots)

// how many shots it'd take to break thing as it is now, after its armour, the way /obj/bullet_act() does it. Null if we can't or shouldn't
/proc/shots_to_break(obj/thing, obj/projectile/projectile_type, mob/living/shooter)
	if(ai_is_door(thing) && (!shooter || thing.CanAStarPass(shooter.ai_controller?.get_access(), get_dir(shooter, thing), shooter)))
		return null // there's a quicker way through a door we can open than shooting it down, but not one that's locked to us
	if(thing.resistance_flags & INDESTRUCTIBLE)
		return null
	var/damage_type = initial(projectile_type.damage_type)
	if(damage_type != BRUTE && damage_type != BURN)
		return null
	var/armor_protection = thing.get_armor_rating(initial(projectile_type.flag))
	if(armor_protection)
		armor_protection = clamp(PENETRATE_ARMOUR(armor_protection, initial(projectile_type.armour_penetration)), min(armor_protection, 0), 100)
	var/damage_per_shot = initial(projectile_type.damage) * initial(projectile_type.demolition_mod) * (100 - armor_protection) / 100
	if(damage_per_shot <= 0)
		return null
	return CEILING(thing.atom_integrity / damage_per_shot, 1)

// wheter a cover is facing/still between the mob and target
/proc/cover_facing(turf/spot, atom/threat)
	var/turf/threat_turf = get_turf(threat)
	if(!spot || !threat_turf || spot == threat_turf || spot.z != threat_turf.z)
		return FALSE
	var/towards = get_dir(spot, threat_turf)
	var/list/facing_dirs = list(towards, turn(towards, 45), turn(towards, -45))
	for(var/obj/thing in spot)
		if((thing.flags_1 & ON_BORDER_1) && ai_is_cover(thing) && (thing.dir & towards))
			return TRUE
	for(var/facing_dir in facing_dirs)
		var/turf/beside = get_step(spot, facing_dir)
		if(!beside || beside == threat_turf)
			continue
		for(var/obj/thing in beside)
			if(!ai_is_cover(thing))
				continue
			// a flipped table only covers us if its raised edge is between us
			if(!(thing.flags_1 & ON_BORDER_1) || (thing.dir & REVERSE_DIR(get_dir(spot, beside))))
				return TRUE
	return FALSE

// whether the mob's stood on the fighting cover it picked, and that cover still faces threat
/proc/ai_holding_cover_against(datum/ai_controller/controller, atom/threat)
	var/turf/fighting_spot = controller.blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF]
	return fighting_spot && get_turf(controller.pawn) == fighting_spot && cover_facing(fighting_spot, threat)

// check if shield is "facing" somewhere on a cone, so AI know what to do about it
/proc/ai_shield_facing(atom/target, turf/spot)
	var/mob/living/carbon/human/shield_bearer = target
	if(!istype(shield_bearer) || !spot)
		return FALSE
	var/turf/their_turf = get_turf(shield_bearer)
	if(!their_turf || their_turf == spot)
		return FALSE
	var/holding_shield = FALSE
	for(var/obj/item/shield/shield in shield_bearer.held_items)
		if(!shield.broken)
			holding_shield = TRUE
			break
	if(!holding_shield)
		return FALSE
	var/angle_off_facing = abs(dir2angle(shield_bearer.dir) - dir2angle(get_dir(their_turf, spot)))
	if(angle_off_facing > 180)
		angle_off_facing = 360 - angle_off_facing
	return angle_off_facing <= 45

// the cover between spot and threat, if there is any, so threat's shots at spot would mostly hit it, while ours from spot go over it. for sandbags and flipped tables and such
/proc/cover_between(turf/spot, atom/threat)
	var/turf/threat_turf = get_turf(threat)
	var/list/line = get_line(spot, threat_turf)
	if(length(line) < 3)
		return null // they're right next to it, so cover's no use
	var/towards = get_dir(spot, threat_turf)
	for(var/obj/thing in spot)
		if((thing.flags_1 & ON_BORDER_1) && (thing.dir & towards) && ai_is_cover(thing))
			return thing
	var/turf/in_front = line[2]
	for(var/obj/thing in in_front)
		if(!ai_is_cover(thing))
			continue
		// a flipped table only stops shots crossing its raised edge
		if(!(thing.flags_1 & ON_BORDER_1) || (thing.dir & (towards | REVERSE_DIR(towards))))
			return thing
	return null

/proc/find_fighting_cover_spot(mob/living/fighter, atom/threat, range, pass_flags, turf/exclude)
	var/turf/our_turf = get_turf(fighter)
	var/turf/their_turf = get_turf(threat)
	if(!our_turf)
		return null
	// where our allies are, or are heading to fight from, so we don't pile up behind each other or shoot through them
	var/list/ally_turfs = list()
	for(var/mob/living/ally in hearers(range * 3, our_turf))
		if(ally == fighter || ally.stat == DEAD || !fighter.faction_check_mob(ally))
			continue
		ally_turfs[get_turf(ally)] = TRUE
		var/datum/ai_controller/ally_controller = ally.ai_controller
		var/turf/ally_cover = istype(ally_controller) ? ally_controller.blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF] : null
		if(ally_cover)
			ally_turfs[ally_cover] = TRUE
	var/turf/best_turf
	var/best_distance = INFINITY
	for(var/turf/open/candidate in ai_turfs_in_range(our_turf, range))
		var/candidate_distance = get_dist(our_turf, candidate)
		if(candidate == exclude || candidate_distance >= best_distance || ally_turfs[candidate] || !cover_between(candidate, threat) || !ai_can_take_spot(fighter, candidate))
			continue
		if(!can_walk_straight_to(fighter, candidate))
			continue
		if(get_shot_blocker(candidate, their_turf, pass_flags = pass_flags))
			continue
		var/shooting_through_ally = FALSE
		for(var/turf/line_turf as anything in get_line(candidate, their_turf))
			if(line_turf != candidate && ally_turfs[line_turf])
				shooting_through_ally = TRUE // we'd be shooting through one of ours
				break
		if(shooting_through_ally)
			continue
		best_turf = candidate
		best_distance = candidate_distance
	return best_turf

// breaching is whether we're shooting our way through to them on purpose, which lets us put a lot more into it. Null to go by our blackboard
/proc/has_clear_shot(mob/living/shooter, atom/target, breaching)
	var/turf/start = get_turf(shooter)
	var/turf/finish = get_turf(target)
	if(!start || !finish)
		return FALSE
	var/atom/blocker = get_cached_shot_blocker(shooter, target)
	if(!blocker)
		return TRUE
	var/datum/component/ranged_attacks/ranged_attack = shooter.GetComponent(/datum/component/ranged_attacks)
	if(!ranged_attack)
		return FALSE
	if(isnull(breaching))
		var/datum/ai_controller/controller = shooter.ai_controller
		breaching = controller && controller.blackboard[BB_BASIC_MOB_BREACHING] && controller.blackboard[BB_BASIC_MOB_BREACH_ROLLED_FOR] == target
	if(breaching)
		return worth_shooting_through(shooter, blocker, ranged_attack.get_projectile_type(), AI_MAX_SHOTS_TO_BREACH, 2)
	return worth_shooting_through(shooter, blocker, ranged_attack.get_projectile_type())

// use this instead of get_shot_blocker() to cache the answer for a shooter, so it doesn't have to recalc every shot
/proc/get_cached_shot_blocker(mob/living/shooter, atom/target)
	// each shooter's last answer, as list(when, from, to, weakref to what's in the way or null)
	var/static/list/blockers_by_shooter = list()
	var/turf/start = get_turf(shooter)
	var/turf/finish = get_turf(target)
	if(!start || !finish)
		return null
	var/shooter_ref = REF(shooter)
	var/list/last_answer = blockers_by_shooter[shooter_ref]
	if(last_answer && last_answer[1] == world.time && last_answer[2] == start && last_answer[3] == finish)
		var/datum/weakref/blocker_ref = last_answer[4]
		return blocker_ref?.resolve()
	if(length(blockers_by_shooter) > 200) // forget answers for anyone who's not asked lately, so this doesn't grow forever
		for(var/old_ref in blockers_by_shooter)
			var/list/old_answer = blockers_by_shooter[old_ref]
			if(old_answer[1] != world.time)
				blockers_by_shooter -= old_ref
	var/atom/blocker = get_shot_blocker(start, finish, pass_flags = get_ai_shot_pass_flags(shooter))
	blockers_by_shooter[shooter_ref] = list(world.time, start, finish, blocker ? WEAKREF(blocker) : null)
	return blocker
