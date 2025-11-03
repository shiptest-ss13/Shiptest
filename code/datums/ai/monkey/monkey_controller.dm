/*
AI controllers are a datumized form of AI that simulates the input a player would otherwise give to a mob. What this means is that these datums
have ways of interacting with a specific mob and control it.
*/
///OOK OOK OOK

/datum/ai_controller/monkey
	movement_delay = 0.4 SECONDS
	planning_subtrees = list(/datum/ai_planning_subtree/monkey_tree)
	blackboard = list(
		BB_MONKEY_AGRESSIVE = FALSE,
		BB_MONKEY_BEST_FORCE_FOUND = 0,
		BB_MONKEY_ENEMIES = list(),
		BB_MONKEY_BLACKLISTITEMS = list(),
		BB_MONKEY_PICKUPTARGET = null,
		BB_MONKEY_PICKPOCKETING = FALSE,
		BB_MONKEY_DISPOSING = FALSE,
		BB_MONKEY_TARGET_DISPOSAL = null,
		BB_MONKEY_CURRENT_ATTACK_TARGET = null,
		BB_MONKEY_GUN_NEURONS_ACTIVATED = FALSE,
		BB_MONKEY_GUN_WORKED = TRUE,
		BB_MONKEY_NEXT_HUNGRY = 0
	)
	idle_behavior = /datum/idle_behavior/idle_monkey

/datum/ai_controller/monkey/angry

/datum/ai_controller/monkey/angry/TryPossessPawn(atom/new_pawn)
	. = ..()
	if(. & AI_CONTROLLER_INCOMPATIBLE)
		return
	set_blackboard_key(BB_MONKEY_AGRESSIVE, TRUE) //Angry cunt

/datum/ai_controller/monkey/TryPossessPawn(atom/new_pawn)
	if(!isliving(new_pawn))
		return AI_CONTROLLER_INCOMPATIBLE

	blackboard[BB_MONKEY_NEXT_HUNGRY] = world.time + rand(0, 300)

	var/mob/living/living_pawn = new_pawn
	living_pawn.AddElement(/datum/element/relay_attackers)
	RegisterSignal(new_pawn, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(on_attacked))
	RegisterSignal(new_pawn, COMSIG_LIVING_START_PULL, PROC_REF(on_startpulling))
	RegisterSignal(new_pawn, COMSIG_LIVING_TRY_SYRINGE, PROC_REF(on_try_syringe))
	RegisterSignal(new_pawn, COMSIG_CARBON_CUFF_ATTEMPTED, PROC_REF(on_attempt_cuff))
	RegisterSignal(new_pawn, COMSIG_MOB_MOVESPEED_UPDATED, PROC_REF(update_movespeed))

	movement_delay = living_pawn.cached_multiplicative_slowdown
	return ..() //Run parent at end

/datum/ai_controller/monkey/UnpossessPawn(destroy)
	UnregisterSignal(pawn, list(
		COMSIG_ATOM_WAS_ATTACKED,
		COMSIG_LIVING_START_PULL,
		COMSIG_LIVING_TRY_SYRINGE,
		COMSIG_CARBON_CUFF_ATTEMPTED,
		COMSIG_MOB_MOVESPEED_UPDATED,
	))
	return ..() //Run parent at end

/datum/ai_controller/monkey/able_to_run()
	. = ..()
	var/mob/living/living_pawn = pawn

	if(IS_DEAD_OR_INCAP(living_pawn))
		return FALSE

///re-used behavior pattern by monkeys for finding a weapon
/datum/ai_controller/monkey/proc/TryFindWeapon()
	var/mob/living/living_pawn = pawn

	if(!(locate(/obj/item) in living_pawn.held_items))
		set_blackboard_key(BB_MONKEY_BEST_FORCE_FOUND, 0)

	if(blackboard[BB_MONKEY_GUN_NEURONS_ACTIVATED] && (locate(/obj/item/gun) in living_pawn.held_items))
		// We have a gun, what could we possibly want?
		return FALSE

	var/obj/item/weapon
	var/list/nearby_items = list()
	for(var/obj/item/item in oview(2, living_pawn))
		nearby_items += item

	weapon = GetBestWeapon(nearby_items, living_pawn.held_items)

	var/pickpocket = FALSE
	for(var/mob/living/carbon/human/human in oview(5, living_pawn))
		var/obj/item/held_weapon = GetBestWeapon(human.held_items + weapon, living_pawn.held_items)
		if(held_weapon == weapon) // It's just the same one, not a held one
			continue
		pickpocket = TRUE
		weapon = held_weapon

	if(!weapon || (weapon in living_pawn.held_items))
		return FALSE

	set_blackboard_key(BB_MONKEY_PICKUPTARGET, weapon)
	current_movement_target = weapon
	if(pickpocket)
		LAZYADD(current_behaviors, GET_AI_BEHAVIOR(/datum/ai_behavior/monkey_equip/pickpocket))
	else
		LAZYADD(current_behaviors, GET_AI_BEHAVIOR(/datum/ai_behavior/monkey_equip/ground))
	return TRUE

/// Returns either the best weapon from the given choices or null if held weapons are better
/datum/ai_controller/monkey/proc/GetBestWeapon(list/choices, list/held_weapons)
	var/gun_neurons_activated = blackboard[BB_MONKEY_GUN_NEURONS_ACTIVATED]
	var/top_force = 0
	var/obj/item/top_force_item
	for(var/obj/item/item as anything in held_weapons)
		if(!item)
			continue
		if(blackboard[BB_MONKEY_BLACKLISTITEMS][item])
			continue
		if(gun_neurons_activated && istype(item, /obj/item/gun))
			// We have a gun, why bother looking for something inferior
			// Also yes it is intentional that monkeys dont know how to pick the best gun
			return item
		if(item.force > top_force)
			top_force = item.force
			top_force_item = item

	for(var/obj/item/item as anything in choices)
		if(!item)
			continue
		if(blackboard[BB_MONKEY_BLACKLISTITEMS][item])
			continue
		if(gun_neurons_activated && istype(item, /obj/item/gun))
			return item
		if(item.force <= top_force)
			continue
		top_force_item = item
		top_force = item.force

	return top_force_item

/datum/ai_controller/monkey/proc/TryFindFood()
	. = FALSE
	var/mob/living/living_pawn = pawn

	// Held items

	var/list/food_candidates = list()
	for(var/obj/item as anything in living_pawn.held_items)
		if(!item || !IsEdible(item))
			continue
		food_candidates += item

	for(var/obj/item/candidate in oview(2, living_pawn))
		if(!IsEdible(candidate))
			continue
		food_candidates += candidate

	if(length(food_candidates))
		var/obj/item/best_held = GetBestWeapon(null, living_pawn.held_items)
		for(var/obj/item/held as anything in living_pawn.held_items)
			if(!held || held == best_held)
				continue
			living_pawn.dropItemToGround(held)

		queue_behavior(/datum/ai_behavior/consume, pick(food_candidates))
		return TRUE

/datum/ai_controller/monkey/proc/IsEdible(obj/item/thing)
	if(IS_EDIBLE(thing))
		return TRUE
	if(istype(thing, /obj/item/reagent_containers/food/drinks/drinkingglass))
		var/obj/item/reagent_containers/food/drinks/drinkingglass/glass = thing
		if(glass.reagents.total_volume) // The glass has something in it, time to drink the mystery liquid!
			return TRUE
	return FALSE

///Reactive events to being hit
/datum/ai_controller/monkey/proc/retaliate(mob/living/L)
	var/list/enemies = blackboard[BB_MONKEY_ENEMIES]
	enemies[L] += MONKEY_HATRED_AMOUNT

/datum/ai_controller/monkey/proc/on_attacked(datum/source, mob/attacker)
	SIGNAL_HANDLER
	if(prob(MONKEY_RETALIATE_PROB))
		retaliate(attacker)

/datum/ai_controller/monkey/proc/on_startpulling(datum/source, atom/movable/puller, state, force)
	SIGNAL_HANDLER
	var/mob/living/living_pawn = pawn
	if(!IS_DEAD_OR_INCAP(living_pawn) && prob(MONKEY_PULL_AGGRO_PROB)) // nuh uh you don't pull me!
		retaliate(living_pawn.pulledby)
		return TRUE

/datum/ai_controller/monkey/proc/on_try_syringe(datum/source, mob/user)
	SIGNAL_HANDLER
	// chance of monkey retaliation
	if(prob(MONKEY_SYRINGE_RETALIATION_PROB))
		retaliate(user)

/datum/ai_controller/monkey/proc/on_attempt_cuff(datum/source, mob/user)
	SIGNAL_HANDLER
	// chance of monkey retaliation
	if(prob(MONKEY_CUFF_RETALIATION_PROB))
		retaliate(user)

/datum/ai_controller/monkey/proc/update_movespeed(mob/living/pawn)
	SIGNAL_HANDLER
	movement_delay = pawn.cached_multiplicative_slowdown

/datum/ai_controller/monkey/proc/target_del(target)
	SIGNAL_HANDLER
	blackboard[BB_MONKEY_BLACKLISTITEMS] -= target

/datum/ai_controller/monkey/proc/on_eat(mob/living/pawn)
	SIGNAL_HANDLER
	blackboard[BB_MONKEY_NEXT_HUNGRY] = world.time + rand(120, 600) SECONDS
