// Helpers for AI picking who to fight and how

/proc/ai_is_downed(atom/thing)
	if(!isliving(thing))
		return FALSE
	var/mob/living/living_thing = thing
	return living_thing.stat != CONSCIOUS

/proc/get_nearest_of(atom/source, list/candidates)
	var/nearest_distance = INFINITY
	var/list/nearest_targets = list()
	for(var/atom/possible_target as anything in candidates)
		var/distance = get_dist(source, possible_target)
		if(distance < nearest_distance)
			nearest_distance = distance
			nearest_targets = list(possible_target)
		else if(distance == nearest_distance)
			nearest_targets += possible_target
	return pick(nearest_targets)

/proc/holds_melee_weapon(mob/living/someone)
	for(var/obj/item/held in someone.held_items)
		if(!isgun(held) && held.force >= 10)
			return TRUE
	return FALSE

/proc/melee_hits_to_break(mob/living/basic/basic_mob, obj/thing)
	if(!basic_mob.obj_damage || !(isstructure(thing) || ismachinery(thing)) || !thing.uses_integrity || (thing.resistance_flags & INDESTRUCTIBLE))
		return null
	var/damage_per_hit = thing.run_atom_armor(basic_mob.obj_damage, basic_mob.melee_damage_type, MELEE, null, basic_mob.armour_penetration)
	if(damage_per_hit <= 0)
		return null
	var/obj/structure/barricade/sandbags/sandbags = thing
	if(istype(sandbags))
		var/hits_per_bag = CEILING(48 / damage_per_hit, 1)
		return max(sandbags.effective_bags * hits_per_bag - round(sandbags.bag_damage / damage_per_hit), 1)
	return CEILING(thing.atom_integrity / damage_per_hit, 1)

/proc/ai_lash_out(datum/ai_controller/controller, interval = 2 SECONDS)
	if(!isturf(controller.pawn.loc) || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_LASH_OUT])
		return FALSE
	var/atom/lash_target
	if(controller.get_conditions() & AI_CONDITION_TARGET_ADJACENT)
		if(!ai_target_adjacent_long_enough(controller, 1 SECONDS))
			return FALSE // give them a moment, so someone closing in with a melee weapon gets to use it
		lash_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	else
		// not who we're running from, but someone else of theirs right on top of us, so them
		var/datum/targetting_datum/targetting_datum = controller.blackboard[BB_TARGETTING_DATUM]
		for(var/mob/living/someone in orange(1, controller.pawn))
			if(someone.Adjacent(controller.pawn) && targetting_datum?.can_attack(controller.pawn, someone))
				lash_target = someone
				break
	if(!lash_target)
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_LASH_OUT_TARGET, lash_target)
	var/queued
	if(controller.blackboard[BB_BASIC_MOB_SHOVES_WHEN_CORNERED] && isliving(lash_target))
		queued = controller.queue_behavior(/datum/ai_behavior/shove_away, BB_BASIC_MOB_LASH_OUT_TARGET)
	else
		queued = controller.queue_behavior(/datum/ai_behavior/basic_melee_attack, BB_BASIC_MOB_LASH_OUT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	if(!queued)
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_LASH_OUT, world.time + interval)
	AI_LOG_DECISION(controller, "lashing out at [lash_target], who's right on top of us")
	return TRUE

/proc/ai_target_adjacent_long_enough(datum/ai_controller/controller, duration)
	var/adjacent_since = controller.blackboard[BB_BASIC_MOB_TARGET_ADJACENT_SINCE]
	if(isnull(adjacent_since))
		return TRUE
	return world.time - adjacent_since >= duration

/proc/forget_invalid_target(datum/ai_controller/controller, target_key, targetting_datum_key)
	var/atom/target = controller.blackboard[target_key]
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]
	if(QDELETED(target) || !targetting_datum || !targetting_datum.can_attack(controller.pawn, target))
		controller.clear_blackboard_key(target_key)

// so we don't try to shoot a grenade
/proc/ai_is_shooter(atom/firer)
	return ismob(firer) || ismecha(firer) || istype(firer, /obj/machinery/porta_turret)
