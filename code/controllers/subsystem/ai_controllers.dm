/// The subsystem used to tick [/datum/ai_controllers] instances. Handling the re-checking of plans.
SUBSYSTEM_DEF(ai_controllers)
	name = "AI Controller Ticker"
	flags = SS_POST_FIRE_TIMING|SS_BACKGROUND
	priority = FIRE_PRIORITY_NPC
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	init_order = INIT_ORDER_AI_CONTROLLERS
	wait = 0.5 SECONDS //Plan every half second if required, not great not terrible.

	///List of all ai_subtree singletons, key is the typepath while assigned value is a newly created instance of the typepath. See setup_subtrees()
	var/list/ai_subtrees = list()
	///List of all ai_sensor singletons, as list(typepath = instance)
	var/list/ai_sensors = list()
	///List of all ai controllers currently running
	var/list/active_ai_controllers = list()
	///AI controllers that are asleep because nobody's around, as list("virtual z" = list(controllers))
	var/list/list/sleeping_ai_by_virtual_level = list()
	///If FALSE, AI that nobody alive can see thinks just as often as AI that someone can
	var/low_priority_enabled = TRUE

/datum/controller/subsystem/ai_controllers/Initialize(timeofday)
	setup_subtrees()
	return ..()

/datum/controller/subsystem/ai_controllers/proc/setup_subtrees()
	ai_subtrees = list()
	for(var/subtree_type in subtypesof(/datum/ai_planning_subtree))
		var/datum/ai_planning_subtree/subtree = new subtree_type
		ai_subtrees[subtree_type] = subtree
	ai_sensors = list()
	for(var/sensor_type in subtypesof(/datum/ai_sensor))
		ai_sensors[sensor_type] = new sensor_type

/datum/controller/subsystem/ai_controllers/fire(resumed)
	var/list/watched_levels = list() // whether there's anyone alive on each virtual z-level, worked out once each fire
	for(var/datum/ai_controller/ai_controller as anything in active_ai_controllers)
		var/virtual_level = "[ai_controller.pawn?.virtual_z()]"
		if(isnull(watched_levels[virtual_level]))
			watched_levels[virtual_level] = length(LAZYACCESS(SSmobs.players_by_virtual_z, virtual_level)) > 0
		ai_controller.low_priority = low_priority_enabled && !watched_levels[virtual_level]
		if(ai_controller.low_priority)
			if(world.time < ai_controller.next_low_priority_plan)
				continue
			ai_controller.next_low_priority_plan = world.time + AI_LOW_PRIORITY_INTERVAL
		if(!COOLDOWN_FINISHED(ai_controller, failed_planning_cooldown))
			continue

		if(ai_controller.able_to_plan())
			ai_controller.SelectBehaviors(wait * 0.1)
			if(!LAZYLEN(ai_controller.current_behaviors)) //Still no plan
				COOLDOWN_START(ai_controller, failed_planning_cooldown, AI_FAILED_PLANNING_COOLDOWN)
				ai_controller.check_should_sleep() // nothing to do, so if nobody's around, sleep until someone is

/// Wakes up the AI asleep on a virtual z-level, as a player's arrived there.
/datum/controller/subsystem/ai_controllers/proc/wake_virtual_level(virtual_level)
	for(var/datum/ai_controller/sleeping_controller as anything in LAZYACCESS(sleeping_ai_by_virtual_level, "[virtual_level]"))
		sleeping_controller.check_should_sleep()
