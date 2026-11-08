// Helpers for AI working out where's safe from someone shooting at it, and where it can shoot from

// find if a shot will hit something.
/proc/get_shot_blocker(turf/start, turf/finish, x_offset = 0, y_offset = 0, pass_flags = AI_THREAT_SHOT_PASS_FLAGS, list/all_blockers)
	if(start.z != finish.z)
		all_blockers?.Add(finish)
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
			var/atom/first_side = get_tile_shot_blocker(DIAGONAL_CORNER_X(previous, sample), pass_flags)
			var/atom/second_side = get_tile_shot_blocker(DIAGONAL_CORNER_Y(previous, sample), pass_flags)
			if(first_side && second_side)
				if(!all_blockers)
					return first_side
				all_blockers |= first_side
			var/atom/corner_edge = get_edge_shot_blocker(previous, sample, pass_flags)
			if(corner_edge)
				if(!all_blockers)
					return corner_edge // a directional window on the corner we're cutting
				all_blockers |= corner_edge
		else
			var/atom/edge_blocker = get_edge_shot_blocker(previous, sample, pass_flags)
			if(edge_blocker)
				if(!all_blockers)
					return edge_blocker
				all_blockers |= edge_blocker
		previous = sample
		if(sample == start || sample == finish)
			continue
		var/atom/blocker = get_tile_shot_blocker(sample, pass_flags)
		if(blocker)
			if(!all_blockers)
				return blocker
			all_blockers |= blocker
	return length(all_blockers) ? all_blockers[1] : null

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
		// no cutting a corner
		if(previous.x != line_turf.x && previous.y != line_turf.y && !previous.Adjacent(line_turf))
			return FALSE
		previous = line_turf
	return TRUE

// the turfs within range of center, instead of range() which gives everything including the turf. RANGE_TURFS, for helpers that load before game.dm defines it
/proc/ai_turfs_in_range(turf/center, range)
	return block(
		locate(max(center.x - range, 1), max(center.y - range, 1), center.z),
		locate(min(center.x + range, world.maxx), min(center.y + range, world.maxy), center.z)
	)


// for radius search, search in rings so we get the closest first
/proc/ai_turfs_in_ring(turf/center, radius)
	if(radius <= 0)
		return list(center)
	. = list()
	for(var/ring_x in center.x - radius to center.x + radius)
		for(var/ring_y in list(center.y - radius, center.y + radius))
			var/turf/ring_turf = locate(ring_x, ring_y, center.z)
			if(ring_turf)
				. += ring_turf
	for(var/ring_y in center.y - radius + 1 to center.y + radius - 1)
		for(var/ring_x in list(center.x - radius, center.x + radius))
			var/turf/ring_turf = locate(ring_x, ring_y, center.z)
			if(ring_turf)
				. += ring_turf

// every turf within range of mover that it could get to, nearest first by how far it'd have to go, as list(turf = steps).
/proc/ai_reachable_turfs(atom/movable/mover, range)
	var/turf/start = get_turf(mover)
	if(!start)
		return list()
	var/datum/ai_controller/controller = mover.ai_controller
	var/access = controller?.get_access()
	var/can_climb = controller?.blackboard[BB_BASIC_MOB_CAN_CLIMB]
	var/can_cross_space = controller?.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE]
	// detours up to as long again as going straight there, and one climb on top
	var/max_cost = range * 2 + (can_climb ? AI_CLIMB_STEP_COST : 0)
	var/list/costs = list()
	costs[start] = 0
	// whether we could stand on each turf at all, worked out once for each rather than from every side we come at it
	var/list/passable = list()
	// a list of turfs for each cost, so we go out cheapest first
	var/list/buckets = new /list(max_cost + 1)
	buckets[1] = list(start)
	. = list()
	for(var/cost in 0 to max_cost)
		var/list/bucket = buckets[cost + 1]
		for(var/turf/current as anything in bucket)
			if(costs[current] != cost)
				continue // got to it cheaper another way
			.[current] = cost
			for(var/direction in GLOB.alldirs)
				var/turf/next = get_step(current, direction)
				if(!next || get_dist(start, next) > range)
					continue
				// a step costs at least 1, so if we've got there for that already, this way's no better.
				if(!isnull(costs[next]) && costs[next] <= cost + 1)
					continue
				if(isnull(passable[next]))
					passable[next] = !next.density && (can_cross_space || !is_bare_space(next)) && !is_ai_hazard_turf(next, mover)
				if(!passable[next])
					continue
				if(ISDIAGONALDIR(direction))
					var/turf/side_one = DIAGONAL_CORNER_Y(current, next)
					var/turf/side_two = DIAGONAL_CORNER_X(current, next)
					if(!side_one || !side_two || side_one.density || side_two.density)
						continue // no cutting round wall corners
				var/step_cost = 1
				if(current.LinkBlockedWithAccess(next, mover, access))
					if(!can_climb || current.LinkBlockedWithAccess(next, mover, access, climbing = TRUE))
						continue
					step_cost = AI_CLIMB_STEP_COST
				var/next_cost = cost + step_cost
				if(next_cost > max_cost || (!isnull(costs[next]) && costs[next] <= next_cost))
					continue
				costs[next] = next_cost
				if(!buckets[next_cost + 1])
					buckets[next_cost + 1] = list()
				buckets[next_cost + 1] += next

// out_of_sight for hiding where they can't see us too, not just shoot us, as some things stop shots but not vision
// prefer is one of AI_HIDE_, for which of the spots that'll do we'd rather have
/proc/find_hiding_spot(atom/movable/mover, turf/danger, range = 3, turf/exclude, out_of_sight = FALSE, prefer = AI_HIDE_NEAREST)
	var/turf/our_turf = get_turf(mover)
	if(!our_turf)
		return null
	// as a lookup, since view() gives every atom in sight and we'd otherwise scan all of them per candidate
	var/list/seen_from_danger
	if(out_of_sight)
		seen_from_danger = list()
		for(var/turf/seen_turf in view(get_dist(danger, our_turf) + range, danger))
			seen_from_danger[seen_turf] = TRUE
	// nearest first by how far we'd go to get there, round or over what's in the way, so we only look further when there's nowhere close
	var/list/reachable = ai_reachable_turfs(mover, range)
	var/list/candidates = list()
	var/last_cost = INFINITY
	for(var/turf/open/candidate in reachable)
		var/cost = reachable[candidate]
		if(cost > last_cost)
			break
		if(candidate == exclude || !ai_can_take_spot(mover, candidate))
			continue
		if(!is_spot_safe_from(candidate, danger) || (seen_from_danger && seen_from_danger[candidate]))
			continue
		if(prefer == AI_HIDE_NEAREST)
			return candidate
		candidates[candidate] = cost
		last_cost = min(last_cost, cost + 1) // and one further, in case it's somewhere better
	var/turf/best_turf
	var/best_score = INFINITY
	for(var/turf/candidate as anything in candidates)
		var/danger_distance = get_dist(candidate, danger)
		var/score = candidates[candidate] + (prefer == AI_HIDE_NEAR_THREAT ? danger_distance : -danger_distance) * 2
		if(score < best_score)
			best_turf = candidate
			best_score = score
	return best_turf

// whether shooter would have an open shot at target from spot, with nothing and no ally in the way
/proc/ai_shot_open_from(mob/living/shooter, turf/spot, atom/target, pass_flags)
	if(isnull(pass_flags))
		pass_flags = get_ai_shot_pass_flags(shooter)
	return !get_shot_blocker(spot, get_turf(target), pass_flags = pass_flags) && !ai_ally_in_lane(shooter, target, spot)

/proc/ally_in_line_of_fire(mob/living/shooter, turf/start, turf/finish)
	for(var/turf/line_turf as anything in get_line(start, finish))
		for(var/mob/living/maybe_ally in line_turf)
			if(maybe_ally != shooter && !ai_shot_passes_over(maybe_ally) && shooter.faction_check_mob(maybe_ally))
				return TRUE
	return FALSE

// get_splash_radius() for a type of projectile, before there's one to ask, worked out once for each type
/proc/ai_projectile_splash_radius(projectile_type)
	var/static/list/radius_by_type = list()
	if(!ispath(projectile_type, /obj/projectile))
		return 0
	if(isnull(radius_by_type[projectile_type]))
		var/obj/projectile/projectile = new projectile_type
		radius_by_type[projectile_type] = projectile.get_splash_radius()
		qdel(projectile)
	return radius_by_type[projectile_type]

// chance (0-1) a shot at aim hits an ally, as list(chance, ally most in the way), from how much of the spread cone each ally covers
// splash is how far round where it lands it hurts people, anyone of ours that close to aim counting as a sure hit
/proc/ai_friendly_fire_risk(mob/living/shooter, atom/aim, spread, reach, pass_flags, turf/from, splash = 0)
	var/turf/shooter_turf = get_turf(shooter)
	var/turf/start = from || shooter_turf
	var/turf/aim_turf = get_turf(aim)
	if(!start || !shooter_turf || !aim_turf || start == aim_turf)
		return list(0, null)
	reach = max(reach, sqrt((aim_turf.x - start.x) ** 2 + (aim_turf.y - start.y) ** 2))
	var/aim_angle = get_angle(start, aim_turf)
	var/chance_clear = 1
	var/mob/living/most_in_way
	var/most_in_way_chance = 0
	// same lookup targetting already caches each tick, so it's usually free. Includes player allies, unlike get_ai_allies_in_range()
	var/look_range = shooter.ai_controller?.blackboard[BB_BASIC_MOB_VISION_RANGE] || AI_DEFAULT_VISION_RANGE
	var/needed_range = CEILING(reach, 1) + get_dist(shooter_turf, start) + splash
	if(needed_range > look_range)
		look_range = max(needed_range, AI_FRIENDLY_FIRE_LONG_LOOK_RANGE)
	for(var/mob/living/ally in ai_cached_hearers(shooter, look_range))
		if(ally == shooter || ai_shot_passes_over(ally) || !shooter.faction_check_mob(ally))
			continue
		var/turf/ally_turf = get_turf(ally)
		if(!ally_turf || ally_turf == start)
			continue
		if(splash && get_dist(ally_turf, aim_turf) <= splash && ai_blast_reaches(aim_turf, ally_turf))
			return list(1, ally) // caught in it where it lands
		var/distance = sqrt((ally_turf.x - start.x) ** 2 + (ally_turf.y - start.y) ** 2)
		if(distance > reach + 0.5)
			continue // past the shot's reach
		var/ally_angle = get_angle(start, ally_turf)
		var/offset = ally_angle - aim_angle
		while(offset > 180)
			offset -= 360
		while(offset < -180)
			offset += 360
		// projectiles hit by tile, so the ally is as wide as their tile looks from here, wider on the diagonal
		var/half_extent = 0.5 * (abs(sin(ally_angle)) + abs(cos(ally_angle)))
		var/half_width = arctan(half_extent / distance)
		var/chance
		if(spread <= 0)
			chance = abs(offset) <= half_width ? 1 : 0 // dead straight every time
		else
			chance = clamp((min(offset + half_width, spread) - max(offset - half_width, -spread)) / (spread * 2), 0, 1)
		if(!chance)
			continue // well off to the side
		if(get_shot_blocker(start, ally_turf, pass_flags = pass_flags))
			continue
		chance_clear *= 1 - chance
		if(chance > most_in_way_chance)
			most_in_way_chance = chance
			most_in_way = ally
	return list(1 - chance_clear, most_in_way)

// highest chance of hitting an ally the mob will shoot at, or null if it doesn't care. Higher when broken, lower firing blind
/proc/ai_friendly_fire_tolerance(datum/ai_controller/controller, blind = FALSE)
	var/tolerance = controller?.blackboard[BB_BASIC_MOB_FRIENDLY_FIRE_TOLERANCE]
	if(isnull(tolerance))
		return null
	if(AI_MORALE_IS(controller, AI_MORALE_BROKEN))
		tolerance *= AI_BROKEN_FRIENDLY_FIRE_TOLERANCE_MULT
	if(blind)
		tolerance *= AI_BLIND_FRIENDLY_FIRE_TOLERANCE_MULT
	return tolerance

// an ally has been in the way of firing for at least this long
/proc/ai_held_by_ally_for(datum/ai_controller/controller, time)
	var/since = controller.blackboard[BB_BASIC_MOB_ALLY_IN_LANE_SINCE]
	var/last = controller.blackboard[BB_BASIC_MOB_ALLY_IN_LANE_LAST]
	if(isnull(since) || isnull(last))
		return FALSE
	return world.time - last <= 1 SECONDS && last - since >= time

// whether an ally in the way is being used as a shield, rather than just standing there
/proc/ai_used_as_shield(mob/living/in_the_way)
	return in_the_way.incapacitated() || in_the_way.buckled || in_the_way.pulledby

// whether shooting at target from from risks an ally more than the mob tolerates. Pass the target, not its turf, so aim settling counts
/proc/ai_ally_in_lane(mob/living/shooter, atom/target, turf/from)
	var/turf/start = from || get_turf(shooter)
	var/turf/their_turf = get_turf(target)
	if(!start || !their_turf)
		return FALSE
	var/tolerance = ai_friendly_fire_tolerance(shooter.ai_controller)
	if(isnull(tolerance))
		return ally_in_line_of_fire(shooter, start, their_turf)
	var/datum/component/ranged_attacks/ranged_attack = shooter.GetComponent(/datum/component/ranged_attacks)
	var/list/risk = ranged_attack ? ranged_attack.friendly_fire_risk(target, from = start) : ai_friendly_fire_risk(shooter, target, 0, 0, get_ai_shot_pass_flags(shooter), start)
	return risk[1] > tolerance

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

/proc/ai_is_doorway(turf/spot)
	for(var/atom/thing as anything in spot)
		if(ai_is_door(thing))
			return TRUE
	return FALSE

// whether mob could go stand on spot, not blocked, nothing there that'd hurt it, and not off the post it's holding, if it is
/proc/ai_can_take_spot(mob/living/mover, turf/spot)
	if(is_ai_swimming_water(spot) && !(mover.movement_type & FLYING))
		return FALSE // no swimming in the pool!!!!
	var/post_radius = ai_post_radius(mover.ai_controller)
	if(!isnull(post_radius))
		var/turf/post = mover.ai_controller.blackboard[BB_BASIC_MOB_HOME_TURF]
		if(post && get_dist(post, spot) > post_radius)
			return FALSE
	return !spot.is_blocked_turf(TRUE, mover) && ai_can_stand_on(mover, spot)

// the spots right round center that mover could go and stand on
/proc/ai_takeable_spots_around(mob/living/mover, atom/center)
	. = list()
	var/turf/center_turf = get_turf(center)
	if(!center_turf)
		return
	for(var/direction in GLOB.alldirs)
		var/turf/candidate = get_step(center_turf, direction)
		if(candidate && ai_can_take_spot(mover, candidate))
			. += candidate

// where those of source's side within range are stood, or have picked to go and stand, as list(turf = TRUE), so source doesn't pick the same spot or pile up behind them
/proc/get_ai_ally_claimed_turfs(mob/living/source, range)
	var/static/list/claim_keys = list(
		BB_BASIC_MOB_FIGHTING_COVER_TURF,
		BB_BASIC_MOB_TAKING_COVER_TURF,
		BB_BASIC_MOB_SAFE_TURF,
		BB_BASIC_MOB_REPOSITION_TURF,
		BB_BASIC_MOB_FLANK_TURF,
		BB_BASIC_MOB_GRENADE_SPOT,
	)
	. = list()
	for(var/mob/living/ally as anything in get_ai_allies_in_range(source, range))
		.[get_turf(ally)] = TRUE
		for(var/key in claim_keys)
			var/turf/claimed = ally.ai_controller.blackboard[key]
			if(isturf(claimed))
				.[claimed] = TRUE

// how far from a post a post holder can go
/proc/ai_post_radius(datum/ai_controller/controller)
	var/post_radius = controller?.blackboard[BB_BASIC_MOB_POST_RADIUS]
	if(isnull(post_radius) || !AI_POST_BROKEN(controller))
		return post_radius
	return post_radius + AI_POST_BREAK_EXTRA_RADIUS

/proc/get_ai_fight_range(datum/ai_controller/controller)
	if(world.time < controller.blackboard[BB_BASIC_MOB_PRESSING_UNTIL])
		return list(1, 2) // everyone we're fighting is down, so we rush them while it lasts
	var/retreat_distance = controller.blackboard[BB_BASIC_MOB_RETREAT_DISTANCE]
	var/engage_distance = controller.blackboard[BB_BASIC_MOB_ENGAGE_DISTANCE]
	var/closest = isnull(retreat_distance) ? AI_DEFAULT_RETREAT_DISTANCE : retreat_distance
	return list(closest, max(closest, isnull(engage_distance) ? AI_DEFAULT_ENGAGE_DISTANCE : engage_distance))

// only shoot at something that blocks but it can destroy quickly, max_shots and magazines are how far we'll go for intentional breakage
/proc/worth_shooting_through(mob/living/shooter, atom/blocker, obj/projectile/projectile_type, max_shots = AI_MAX_SHOTS_THROUGH_COVER, magazines = 1)
	var/shots_needed = shots_to_shoot_through(shooter, blocker, projectile_type)
	return !isnull(shots_needed) && shots_needed <= ai_max_shots_through(shooter, max_shots, magazines)

// the most shots we'll put into getting through, by max_shots and how many magazines' worth
/proc/ai_max_shots_through(mob/living/shooter, max_shots, magazines)
	var/datum/component/ai_magazine/magazine = shooter.GetComponent(/datum/component/ai_magazine)
	return min(max_shots, magazine?.magazine_size ? magazine.magazine_size * magazines : max_shots)

// how many shots it'd take to clear blocker and whatever else on its tile stops them, or null if we can't or shouldn't
/proc/shots_to_shoot_through(mob/living/shooter, atom/blocker, obj/projectile/projectile_type)
	if(!isobj(blocker) || !projectile_type)
		return null // walls and the like, or we're not firing anything that'd break it
	if(breaking_would_vent(shooter, blocker))
		return null // dont vent if we cant survive it!!!
	var/splash = ai_projectile_splash_radius(projectile_type)
	if(splash && get_dist(shooter, blocker) <= splash)
		return null // it'd go off on us
	var/shots_needed = shots_to_break(blocker, projectile_type, shooter)
	if(isnull(shots_needed))
		return null
	var/pass_flags = initial(projectile_type.pass_flags)
	for(var/obj/thing in get_turf(blocker))
		if(thing == blocker || !blocks_shot_on_tile(thing, pass_flags))
			continue
		var/more_shots = shots_to_break(thing, projectile_type, shooter)
		if(isnull(more_shots))
			return null
		shots_needed += more_shots
	return shots_needed

// how many shots it'd take to break thing as it is now, after its armour, the way /obj/bullet_act() does it. Null if we can't or shouldn't
/proc/shots_to_break(obj/thing, obj/projectile/projectile_type, mob/living/shooter)
	if(!(thing.flags_1 & INITIALIZED_1))
		return null // a ruin still loading in around us, no armour or integrity yet
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

// stop fighting from the fighting cover the mob picked, and hiding there from someone dug in if that's what it was, so nothing holds it back on account of it
/proc/ai_leave_fighting_cover(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_FIGHTING_COVER_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_HIDING_FROM_ENTRENCHED_UNTIL)

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
	if(!threat_turf || get_dist(spot, threat_turf) < 2)
		return null // they're right next to it, so cover's no use
	var/towards = get_dir(spot, threat_turf)
	for(var/obj/thing in spot)
		if((thing.flags_1 & ON_BORDER_1) && (thing.dir & towards) && ai_is_cover(thing))
			return thing
	var/list/line = get_line(spot, threat_turf) // only now, as it's the costly part
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
	var/list/ally_turfs = get_ai_ally_claimed_turfs(fighter, range * 3)
	// nearest first by how far we'd go to get there, round or over what's in the way, so we only look further when there's nowhere close
	var/list/reachable = ai_reachable_turfs(fighter, range)
	var/list/candidates = list()
	var/last_cost = INFINITY
	for(var/turf/open/candidate in reachable)
		if(reachable[candidate] > last_cost)
			break
		if(candidate == exclude || ally_turfs[candidate] || !cover_between(candidate, threat) || !ai_can_take_spot(fighter, candidate))
			continue
		if(!ai_shot_open_from(fighter, candidate, threat, pass_flags))
			continue // and none of ours in the way, like someone not under our control
		var/shooting_through_ally = FALSE
		for(var/turf/line_turf as anything in get_line(candidate, their_turf))
			if(line_turf != candidate && ally_turfs[line_turf])
				shooting_through_ally = TRUE // we'd be shooting through one of ours
				break
		if(shooting_through_ally)
			continue
		candidates += candidate
		last_cost = min(last_cost, reachable[candidate] + 1) // and one further, in case it's somewhere better
	if(length(candidates) <= 1)
		return length(candidates) ? candidates[1] : null
	return pick_best_fighting_cover(fighter, threat, candidates)

// the best of candidates to fight threat from: not open to the others we're fighting, in the range we fight at, and not too far away
/proc/pick_best_fighting_cover(mob/living/fighter, atom/threat, list/candidates)
	var/turf/our_turf = get_turf(fighter)
	var/turf/their_turf = get_turf(threat)
	var/datum/ai_controller/controller = fighter.ai_controller
	var/list/fight_range = controller ? get_ai_fight_range(controller) : null
	// other enemies we know about that could take a shot at us
	var/list/other_enemies = list()
	var/list/seen_enemies = controller?.blackboard[BB_BASIC_MOB_SEEN_ENEMIES]
	for(var/atom/enemy as anything in seen_enemies)
		if(enemy == threat || QDELETED(enemy) || enemy.z != our_turf.z || world.time - seen_enemies[enemy] > AI_COVER_ENEMY_MEMORY || ai_is_downed(enemy))
			continue
		other_enemies += enemy
		if(length(other_enemies) >= 4)
			break
	var/turf/best_turf
	var/best_score = INFINITY
	for(var/turf/candidate as anything in candidates)
		var/score = get_dist(our_turf, candidate)
		if(fight_range)
			var/threat_distance = get_dist(candidate, their_turf)
			score += max(fight_range[1] - threat_distance, threat_distance - fight_range[2], 0) * AI_COVER_OUT_OF_RANGE_PENALTY
		for(var/atom/enemy as anything in other_enemies)
			var/turf/enemy_turf = get_turf(enemy)
			if(!cover_between(candidate, enemy) && !get_shot_blocker(enemy_turf, candidate))
				score += AI_COVER_EXPOSED_PENALTY
		if(score < best_score)
			best_turf = candidate
			best_score = score
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
	var/obj/projectile/projectile_type = ranged_attack.get_projectile_type()
	var/max_shots = breaching ? ai_max_shots_through(shooter, AI_MAX_SHOTS_TO_BREACH, 2) : ai_max_shots_through(shooter, AI_MAX_SHOTS_THROUGH_COVER, 1)
	if(isnull(shots_to_shoot_through(shooter, blocker, projectile_type)))
		return FALSE // the first thing in the way's no good
	// and everything past it
	var/list/all_blockers = list()
	get_shot_blocker(start, finish, pass_flags = get_ai_shot_pass_flags(shooter), all_blockers = all_blockers)
	var/total_shots = 0
	for(var/atom/in_the_way as anything in all_blockers)
		var/shots = shots_to_shoot_through(shooter, in_the_way, projectile_type)
		if(isnull(shots))
			return FALSE
		total_shots += shots
	return total_shots <= max_shots

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
