/datum/ai_behavior/find_and_set/hive_partner

/datum/ai_behavior/find_and_set/hive_partner/search_tactic(datum/ai_controller/controller, locate_path, search_range)
	var/mob/living/living_pawn = controller.pawn
	var/list/hive_partners = list()
	for(var/mob/living/target in oview(10, living_pawn))
		if(!istype(target, locate_path))
			continue
		if(target.stat == DEAD)
			continue
		hive_partners += target

	if(length(hive_partners))
		return pick(hive_partners)

/// behavior that allow us to go communicate with other hivebots
/datum/ai_behavior/relay_message
	///length of the message we will relay
	var/length_of_message = 4
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT| AI_BEHAVIOR_REQUIRE_REACH | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION


/datum/ai_behavior/relay_message/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/mob/living/target = controller.blackboard[target_key]
	// It stopped existing
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, target)


/datum/ai_behavior/relay_message/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	. = ..()

	var/mob/living/target = controller.blackboard[target_key]
	var/mob/living/living_pawn = controller.pawn

	if(QDELETED(target))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	var/message_relayed = ""
	for(var/i in 1 to length_of_message)
		message_relayed += prob(50) ? "1" : "0"
	living_pawn.say(message_relayed, forced = "AI Controller")
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/relay_message/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	controller.clear_blackboard_key(target_key)

/datum/ai_behavior/find_hunt_target/repair_machines

/datum/ai_behavior/find_hunt_target/repair_machines/valid_dinner(mob/living/source, obj/machinery/repair_target, radius)
	if(repair_target.atom_integrity >= repair_target.max_integrity)
		return FALSE

	return can_see(source, repair_target, radius)

/datum/ai_behavior/hunt_target/repair_machines
	always_reset_target = TRUE

/datum/ai_behavior/hunt_target/repair_machines/target_caught(mob/living/basic/hivebot/mechanic/hunter, obj/machinery/repair_target)
	hunter.repair_machine(repair_target)

/datum/ai_behavior/find_hunt_target/scrap_machines

/datum/ai_behavior/find_hunt_target/scrap_machines/valid_dinner(mob/living/source, obj/structure/salvageable/yummers, radius)
	if(length(yummers.salvageable_parts))
		return TRUE

/datum/ai_behavior/hunt_target/scrap_machines
	always_reset_target = TRUE

/datum/ai_behavior/hunt_target/scrap_machines/target_caught(mob/living/basic/hivebot/hunter, obj/structure/salvageable/scrapping_target)
	hunter.salvage_machine(scrapping_target)

/datum/ai_behavior/basic_ranged_attack/hivebot
	required_distance = 6
	action_cooldown = 3 SECONDS
	avoid_friendly_fire = TRUE

/datum/ai_behavior/basic_ranged_attack/hivebot_rapid
	required_distance = 6
	action_cooldown = 4 SECONDS
	shots = 3
	burst_interval = 0.2 SECONDS
	avoid_friendly_fire = TRUE

/datum/ai_behavior/basic_ranged_attack/hivebot_core
	required_distance = 5
	action_cooldown = 4 SECONDS
	shots = 3
	burst_interval = 0.3 SECONDS
	avoid_friendly_fire = TRUE

/datum/ai_behavior/basic_ranged_attack/hivebot_core/frontier
	required_distance = 6
	action_cooldown = 4 SECONDS
	shots = 25
	burst_interval = 0.07 SECONDS
	avoid_friendly_fire = TRUE

/datum/ai_behavior/basic_ranged_attack/hivebot_frontier
	required_distance = 6
	action_cooldown = 2 SECONDS
	shots = 6
	burst_interval = 0.09 SECONDS
	avoid_friendly_fire = TRUE

/datum/ai_behavior/attack_obstructions/hivebot
	can_attack_dense_objects = TRUE
	action_cooldown = 1 SECONDS
