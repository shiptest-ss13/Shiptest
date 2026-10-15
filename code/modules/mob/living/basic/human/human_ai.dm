// basic mob, usually for basic melee human mobs
/datum/ai_controller/basic_controller/human
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
	)
	// plan again straight away when who we're fighting changes, they come into or out of sight, we're shot at, or our nerve goes or comes back
	interrupt_keys = list(
		BB_BASIC_MOB_CURRENT_TARGET,
		BB_BASIC_MOB_TARGET_IN_SIGHT,
		BB_BASIC_MOB_LAST_SHOT_TIME,
		BB_BASIC_MOB_MORALE,
	)
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/idle_random_walk
	// who we're fighting, then whether we can see them, before we plan anything
	sensors = list(
		/datum/ai_sensor/update_combat_targets,
		/datum/ai_sensor/track_target,
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/sequence/melee_approach,
		AI_HUMAN_MELEE_PLANNING_CLOSING,
	)

/datum/ai_controller/basic_controller/human/ranged
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/flank,
		/datum/ai_planning_subtree/fighting_cover,
		/datum/ai_planning_subtree/search_lost_target/human,
		AI_HUMAN_RANGED_PLANNING_CLOSING,
	)

/datum/ai_controller/basic_controller/human/noncombatant
	planning_subtrees = list(
		/datum/ai_planning_subtree/seek_safe_environment,
		/datum/ai_planning_subtree/return_home/human,
		/datum/ai_planning_subtree/call_allies/shout_for_help,
		/datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/idle_chatter,
	)

/datum/ai_planning_subtree/call_allies/shout_for_help
	alert_behavior = /datum/ai_behavior/alert_allies/shout_for_help

/datum/ai_behavior/alert_allies/shout_for_help
	alert_range = 15

// stick around someone they took down while they're in view, rather than heading straight home
/datum/ai_planning_subtree/return_home/human
	linger_duration = INFINITY

/datum/ai_planning_subtree/broken_fall_back/human
	cover_fire_behavior = /datum/ai_behavior/basic_ranged_attack/human

/datum/ai_planning_subtree/search_lost_target/human
	cautious_health_fraction = 0.4
	splits_search_roles = TRUE

/datum/ai_planning_subtree/basic_ranged_attack_subtree/human
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/human

/datum/ai_behavior/basic_ranged_attack/human
	moves_into_range = FALSE
	required_distance = 9
	holds_fire_when_blocked = TRUE

// Those who don't fight say little, beyond shouting for help.
/datum/ai_callout_set/noncombatant
	lines = list(
		AI_CALLOUT_MELEE = list("Get away from me!", "Back off!", "Leave me alone!"),
		AI_CALLOUT_HURT = list("Help!", "Stop! Please!"),
		AI_CALLOUT_DEATH_RATTLE = list("I didn't... even...", "Why..."),
	)
	chances = list(
		AI_CALLOUT_MELEE = 50, // they're not ones for fighting, so it's worth a word when they do
	)

// Callout lines any human might say in a fight. Factions can extend or replace them
/datum/ai_callout_set/human
	lines = list(
		AI_CALLOUT_SPOTTED = list("Contact!", "We've got company!", "Intruders!"),
		AI_CALLOUT_TAKING_FIRE = list("Taking fire!", "Where's that coming from?!"),
		AI_CALLOUT_HURT = list("Argh!", "I'm hit!"),
		AI_CALLOUT_TARGET_DOWN = list("They're down!", "Got one!", "I think I got 'em!"),
		AI_CALLOUT_TARGET_KILLED = list("Scratch one.", "That's one less.", "They're dead."),
		AI_CALLOUT_ALLY_DOWN = list("Ally down!", "They got one of ours!"),
		AI_CALLOUT_LOST_THEM = list("Where'd they go?", "Lost sight of them!"),
		AI_CALLOUT_FLANKING = list("Going around!", "Flanking!"),
		AI_CALLOUT_HOLDING = list("Hold here!", "Stay in cover!"),
		AI_CALLOUT_SUPPRESSING = list("Suppressing fire!", "Keeping them pinned!"),
		AI_CALLOUT_DEATH_RATTLE = list("Not... like this...", "Tell the crew... I...", "Damn... it..."),
		AI_CALLOUT_RELOADING = list("Reloading!", "Cover me, reloading!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots fired, I'll check it out!", "Did you hear that?", "Gunfire! Moving to check it."),
		AI_CALLOUT_PUSHING = list("Moving up!", "Pushing in!"),
		AI_CALLOUT_FALLING_BACK = list("Falling back!", "Too close, backing off!"),
		AI_CALLOUT_WARY = list("Stay down, they're good!", "Careful, keep your heads down!"),
		AI_CALLOUT_EMBOLDENED = list("We've got them!", "Press the attack!"),
		AI_CALLOUT_TAUNT = list("Come on, then!", "Nowhere to run!"),
		AI_CALLOUT_MELEE = list("Take this!", "Hold still!", "Come here!", "Hah!"),
		AI_CALLOUT_UNSAFE_ENVIRONMENT = list("We're venting! Get out of here!", "Can't stay here, move!", "Find some air!"),
		AI_CALLOUT_BROKEN = list("Fall back! Fall back!", "We can't hold them!", "There's too many of them!", "Pull back, pull back!"),
		AI_CALLOUT_RALLIED = list("Okay... okay. Regroup!", "Pull it together, we're not done yet!", "Form up, we hold here!"),
	)
	morale_lines = list(
		AI_MORALE_BROKEN = list(
			AI_CALLOUT_HURT = list("I'm hit! Get me out of here!", "Help me!"),
			AI_CALLOUT_RELOADING = list("I'm out, I'm out!"),
			AI_CALLOUT_ALLY_DOWN = list("They're dropping like flies!", "Another one down! Go, go!"),
			AI_CALLOUT_MELEE = list("Get away from me!", "Back off!"),
		),
		AI_MORALE_WARY = list(
			AI_CALLOUT_RELOADING = list("Reloading, keep me covered!"),
		),
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("Who's next?!", "You're all going down!"),
			AI_CALLOUT_RELOADING = list("Reloading, keep pushing!"),
		),
	)
