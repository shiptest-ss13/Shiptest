/datum/ai_controller/basic_controller/snow_monkey

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk

	planning_subtrees = list(
		/datum/ai_planning_subtree/find_and_hunt_target/look_for_garden,
		/datum/ai_planning_subtree/random_speech/monkey,
	)

/datum/ai_planning_subtree/find_and_hunt_target/look_for_garden
	hunting_behavior = /datum/ai_behavior/hunt_target/unarmed_attack_target/snow_monkey
	finding_behavior = /datum/ai_behavior/find_hunt_target/harvest_garden
	hunt_targets = list(/obj/structure/flora/ash/garden)
	hunt_range = 5

/datum/ai_behavior/hunt_target/unarmed_attack_target/snow_monkey
	always_reset_target = TRUE
	hunt_cooldown = 20 SECONDS
