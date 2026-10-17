/*
AI controllers are a datumized form of AI that simulates the input a player would otherwise give to a atom. What this means is that these datums
have ways of interacting with a specific atom and control it. They posses a blackboard with the information the AI knows and has, and will plan behaviors it will try to execute through
multiple modular subtrees with behaviors
*/

/datum/ai_controller
	///The atom this controller is controlling
	var/atom/pawn
	/**
	* This is a list of variables the AI uses and can be mutated by actions.
	*
	* When an action is performed you pass this list and any relevant keys for the variables it can mutate.
	*
	* DO NOT set values in the blackboard directly, and especially not if you're adding a datum reference to this!
	* Use the setters, this is important for reference handing.
	*/
	var/list/blackboard = list()

	///Bitfield of traits for this AI to handle extra behavior
	var/ai_traits = NONE
	///Current actions being performed by the AI.
	var/list/current_behaviors
	///Behaviors picked by the planning pass in progress, as list(behavior = TRUE), so ones that weren't picked again can be cancelled.
	var/list/planned_behaviors
	///Blackboard keys that make us plan again straight away when something changes them, rather than waiting until we'd next plan anyway
	var/list/interrupt_keys
	///TRUE while we're working out a plan, so what we change while planning doesn't interrupt it
	var/planning = FALSE
	///plan and act less often if no one is in the virtual z-level
	var/low_priority = FALSE
	///While low_priority, when we next get to plan, and to act
	var/next_low_priority_plan = 0
	var/next_low_priority_action = 0
	///If TRUE, we keep a log of what we decide, for admins working out what a mob's up to. Off unless an admin turns it on
	var/logging_decisions = FALSE
	///The last few things we decided, oldest first, while logging_decisions
	var/list/decision_log
	///What each subtree queued the last time we planned, and which one finished planning, while logging_decisions
	var/list/last_plan
	///The record of the plan we're working out right now, while logging_decisions, and how many groups deep we are
	var/list/current_plan_record
	var/plan_depth = 0
	///While we're asleep, the virtual z-level we're filed under to be woken when a player arrives
	var/sleeping_on_virtual_level
	///Access the AI's pawn can open doors with, like list(ACCESS_SYNDICATE). Null for none.
	var/list/door_access
	///The ID card holding door_access, kept in nullspace so it can never be dropped or looted, made the first time it's needed
	var/obj/item/card/id/door_access_card
	///Current actions and their respective last time ran as an assoc list.
	var/list/behavior_cooldowns = list()
	///Current status of AI (OFF/ON)
	var/ai_status
	///Current movement target of the AI, generally set by decision making.
	var/atom/current_movement_target
	///Identifier for what last touched our movement target, so it can be cleared conditionally
	var/movement_target_source
	///Stored arguments for behaviors given during their initial creation
	var/list/behavior_args = list()
	///For behaviors that move us to what's in their first blackboard key, what that held when they set up, so we set them up again if it changes for queue_behavior()
	var/list/behavior_setup_refs
	///How each behavior last ended on its own, as list(behavior type = TRUE if it succeeded, FALSE if it failed)
	var/list/behavior_outcomes
	///How many behaviors have refused to start this planning pass, so a subtree that finishes planning without managing to start anything lets the next one have a go
	var/refused_behaviors = 0
	///Tracks recent pathing attempts, if we fail too many in a row we fail our current plans.
	var/pathing_attempts
	///Can the AI remain in control if there is a client?
	var/continue_processing_when_client = FALSE
	///distance to give up on target
	var/max_target_distance = 14
	///Cooldown for new plans, to prevent AI from going nuts if it can't think of new plans and looping on end
	COOLDOWN_DECLARE(failed_planning_cooldown)
	///All subtrees this AI has available, will run them in order, so make sure they're in the order you want them to run. On initialization of this type, it will start as a typepath(s) and get converted to references of ai_subtrees found in SSai_controllers when init_subtrees() is called
	var/list/planning_subtrees
	///Senses that update what we know before each plan, in order, before any planning subtree
	var/list/sensors
	///The AI_CONDITION_* flags true for our mob itself this plan, rather than going by the blackboard, or null if we've not worked them out yet this plan
	var/pawn_conditions
	///All the AI_CONDITION_* flags true right now, as of the last time we worked them out
	var/conditions = NONE
	///TRUE when the blackboard's changed since we last worked out our conditions, so we work them out again before the next guard needs them
	var/conditions_stale = TRUE

	///The idle behavior this AI performs when it has no actions.
	var/datum/idle_behavior/idle_behavior = null

	// Movement related things here
	///Reference to the movement datum we use. Is a type on initialize but becomes a ref afterwards.
	var/datum/ai_movement/ai_movement = /datum/ai_movement/dumb
	///Cooldown until next movement
	COOLDOWN_DECLARE(movement_cooldown)
	///Delay between movements. This is on the controller so we can keep the movement datum singleton
	var/movement_delay = 0.1 SECONDS

	// The variables below are fucking stupid and should be put into the blackboard at some point.
	///A list for the path we're currently following, if we're using JPS pathing
	var/list/movement_path
	///TRUE while a path for us is being worked out in the background
	var/calculating_path = FALSE
	///Cooldown for JPS movement, how often we're allowed to try making a new path
	COOLDOWN_DECLARE(repath_cooldown)
	///AI paused time
	var/paused_until = 0

/datum/ai_controller/New(atom/new_pawn)
	change_ai_movement_type(ai_movement)
	init_subtrees()
	init_sensors()

	if(idle_behavior)
		idle_behavior = new idle_behavior()

	PossessPawn(new_pawn)

/datum/ai_controller/Destroy(force, ...)
	QDEL_NULL(door_access_card)
	set_ai_status(AI_STATUS_OFF)
	UnpossessPawn(FALSE)
	ai_movement.stop_moving_towards(src)
	return ..()

///Sets the current movement target, with an optional param to override the movement behavior
/datum/ai_controller/proc/set_movement_target(source, atom/target, datum/ai_movement/new_movement)
	movement_target_source = source
	current_movement_target = target
	if(new_movement)
		change_ai_movement_type(new_movement)

///Overrides the current ai_movement of this controller with a new one
/datum/ai_controller/proc/change_ai_movement_type(datum/ai_movement/new_movement)
	ai_movement = SSai_movement.movement_types[new_movement]

///Completely replaces the planning_subtrees with a new set based on argument provided, list provided must contain specifically typepaths
/datum/ai_controller/proc/replace_planning_subtrees(list/typepaths_of_new_subtrees)
	planning_subtrees = typepaths_of_new_subtrees
	init_subtrees()

///Loops over the subtrees in planning_subtrees and looks at the ai_controllers to grab a reference, ENSURE planning_subtrees ARE TYPEPATHS AND NOT INSTANCES/REFERENCES BEFORE EXECUTING THIS
/datum/ai_controller/proc/init_subtrees()
	if(!LAZYLEN(planning_subtrees))
		return
	var/list/temp_subtree_list = list()
	for(var/subtree in planning_subtrees)
		var/subtree_instance = SSai_controllers.ai_subtrees[subtree]
		temp_subtree_list += subtree_instance
	planning_subtrees = temp_subtree_list

/**
 * Lets each of subtrees plan in turn, as long as its guard passes, until one takes over planning
 * Returns SUBTREE_RETURN_FINISH_PLANNING if one did. Used for our own list, and for the subtrees in a group
 */
/datum/ai_controller/proc/run_subtrees(list/subtrees, seconds_per_tick)
	var/list/plan_record = current_plan_record
	var/indent = ""
	for(var/level in 1 to plan_depth)
		indent += "&nbsp;&nbsp;"
	for(var/datum/ai_planning_subtree/subtree as anything in subtrees)
		if(subtree.required_conditions || subtree.blocking_conditions)
			var/current_conditions = get_conditions()
			if(!subtree.guard_passes(current_conditions))
				subtree.on_skipped(src)
				if(plan_record)
					plan_record += "[indent][subtree.type]: skipped, [subtree.describe_failed_guard(current_conditions)]"
				continue
		var/planned_before = length(planned_behaviors)
		var/refused_before = refused_behaviors
		var/record_index = plan_record ? length(plan_record) + 1 : 0
		plan_depth++
		var/result = subtree.SelectBehaviors(src, seconds_per_tick)
		plan_depth--
		if(result == SUBTREE_RETURN_FINISH_PLANNING && refused_behaviors > refused_before && length(planned_behaviors) == planned_before)
			// it wanted to take over, but nothing it wanted would start, so let the next subtree have a go
			if(plan_record)
				plan_record += "[indent][subtree.type]: nothing it wanted would start, so falling through"
			continue
		if(plan_record && (length(planned_behaviors) > planned_before || result == SUBTREE_RETURN_FINISH_PLANNING))
			var/list/queued = list()
			for(var/index in planned_before + 1 to length(planned_behaviors))
				var/datum/ai_behavior/queued_behavior = planned_behaviors[index]
				queued += "[queued_behavior.type]"
			// above anything a group's own subtrees noted, so it reads top down
			plan_record.Insert(record_index, "[indent][subtree.type]: [length(queued) ? queued.Join(", ") : "nothing"][result == SUBTREE_RETURN_FINISH_PLANNING ? " <b>(finished planning)</b>" : ""]")
		if(result == SUBTREE_RETURN_FINISH_PLANNING)
			return SUBTREE_RETURN_FINISH_PLANNING

///Swaps the typepaths in sensors for the shared instances in SSai_controllers, like init_subtrees()
/datum/ai_controller/proc/init_sensors()
	if(!LAZYLEN(sensors))
		return
	var/list/sensor_instances = list()
	for(var/sensor_type in sensors)
		sensor_instances += SSai_controllers.ai_sensors[sensor_type]
	sensors = sensor_instances

///Proc to move from one pawn to another, this will destroy the target's existing controller.
/datum/ai_controller/proc/PossessPawn(atom/new_pawn)
	if(pawn) //Reset any old signals
		UnpossessPawn(FALSE)

	if(istype(new_pawn.ai_controller)) //Existing AI, kill it.
		QDEL_NULL(new_pawn.ai_controller)

	if(TryPossessPawn(new_pawn) & AI_CONTROLLER_INCOMPATIBLE)
		qdel(src)
		CRASH("[src] attached to [new_pawn] but these are not compatible!")

	pawn = new_pawn
	pawn.ai_controller = src

	if(!continue_processing_when_client && istype(new_pawn, /mob))
		var/mob/possible_client_holder = new_pawn
		if(possible_client_holder.client)
			set_ai_status(AI_STATUS_OFF)
		else
			set_ai_status(AI_STATUS_ON)
	else
		set_ai_status(AI_STATUS_ON)

	RegisterSignal(pawn, COMSIG_MOB_LOGIN, PROC_REF(on_sentience_gained))
	for(var/key in interrupt_keys)
		RegisterSignals(pawn, list(COMSIG_AI_BLACKBOARD_KEY_SET(key), COMSIG_AI_BLACKBOARD_KEY_CLEARED(key)), PROC_REF(on_interrupt_key_changed))

///Abstract proc for initializing the pawn to the new controller
/datum/ai_controller/proc/TryPossessPawn(atom/new_pawn)
	return

///Proc for deinitializing the pawn to the old controller
/datum/ai_controller/proc/UnpossessPawn(destroy)
	UnregisterSignal(pawn, list(COMSIG_MOB_LOGIN, COMSIG_MOB_LOGOUT))
	for(var/key in interrupt_keys)
		UnregisterSignal(pawn, list(COMSIG_AI_BLACKBOARD_KEY_SET(key), COMSIG_AI_BLACKBOARD_KEY_CLEARED(key)))
	pawn.ai_controller = null
	pawn = null
	if(destroy)
		qdel(src)
	return

///Returns TRUE if the ai controller can actually run at the moment.
/datum/ai_controller/proc/able_to_run()
	if(world.time < paused_until)
		return FALSE
	return TRUE

///Can this pawn interact with objects?
/datum/ai_controller/proc/ai_can_interact()
	SHOULD_CALL_PARENT(TRUE)
	return !QDELETED(pawn)

///Interact with objects
/datum/ai_controller/proc/ai_interact(target, desired_intent, list/modifiers)
	if(!ai_can_interact())
		return FALSE

	var/atom/final_target = isdatum(target) ? target : blackboard[target] //incase we got a blackboard key instead

	if(QDELETED(final_target))
		return FALSE
	var/params = list2params(modifiers)
	var/mob/living/living_pawn = pawn
	if(isnull(desired_intent))
		living_pawn.ClickOn(final_target, params)
		return TRUE

	var/old_intent = living_pawn.a_intent
	living_pawn.a_intent = desired_intent
	living_pawn.ClickOn(final_target, params)
	living_pawn.a_intent = old_intent
	return TRUE

///Runs any actions that are currently running
/datum/ai_controller/process(seconds_per_tick)
	if(low_priority)
		if(world.time < next_low_priority_action)
			return // nobody's watching, so we needn't be quick about it
		next_low_priority_action = world.time + AI_LOW_PRIORITY_INTERVAL
		seconds_per_tick = max(seconds_per_tick, AI_LOW_PRIORITY_INTERVAL * 0.1)
	if(!able_to_run())
		walk(pawn, 0) //stop moving
		ai_movement.stop_moving_towards(src) // and our ai_movement too, or it keeps moving us
		return //this should remove them from processing in the future through event-based stuff.
	if(!LAZYLEN(current_behaviors) && idle_behavior)
		idle_behavior.perform_idle_behavior(seconds_per_tick, src) //Do some stupid shit while we have nothing to do
		return

	if(current_movement_target && get_dist(pawn, current_movement_target) > max_target_distance) //The distance is out of range
		CancelActions()
		return

	// every behavior that's ready gets to go this tick, so we can do things like shoot while we move, rather than one thing at a time
	for(var/datum/ai_behavior/current_behavior as anything in current_behaviors.Copy())
		if(!(current_behavior in current_behaviors))
			continue // finished, or cancelled by another behavior, earlier this tick
		if(QDELETED(pawn))
			return

		// Convert the current behaviour action cooldown to realtime seconds from deciseconds.current_behavior
		// Then pick the max of this and the seconds_per_tick passed to ai_controller.process()
		// Action cooldowns cannot happen faster than seconds_per_tick, so seconds_per_tick should be the value used in this scenario.
		var/action_seconds_per_tick = max(current_behavior.get_cooldown(src) * 0.1, seconds_per_tick)

		if(current_behavior.behavior_flags & AI_BEHAVIOR_REQUIRE_MOVEMENT) //Might need to move closer
			if(!current_movement_target)
				// lost it somehow, so end it, rather than having it wait for a target forever
				finish_behavior(current_behavior)
				continue
			if(AI_IN_RANGE(pawn, current_movement_target, current_behavior.required_distance)) ///Are we close enough to engage?
				if(ai_movement.moving_controllers[src] == current_movement_target) //We are close enough, if we're moving stop.
					ai_movement.stop_moving_towards(src)

				if(behavior_cooldowns[current_behavior] > world.time) //Still on cooldown
					continue
				ProcessBehavior(action_seconds_per_tick, current_behavior)
				continue

			else if(ai_movement.moving_controllers[src] != current_movement_target) //We're too far, if we're not already moving start doing it.
				ai_movement.start_moving_towards(src, current_movement_target, current_behavior.required_distance) //Then start moving

			if(current_behavior.behavior_flags & AI_BEHAVIOR_MOVE_AND_PERFORM) //If we can move and perform then do so.
				if(behavior_cooldowns[current_behavior] > world.time) //Still on cooldown
					continue
				ProcessBehavior(action_seconds_per_tick, current_behavior)
		else //No movement required
			if(behavior_cooldowns[current_behavior] > world.time) //Still on cooldown
				continue
			ProcessBehavior(action_seconds_per_tick, current_behavior)

///Whether we can plan right now: when we've nothing to do, or what we're doing allows planning while it runs
/datum/ai_controller/proc/able_to_plan()
	if(QDELETED(pawn))
		return FALSE
	for(var/datum/ai_behavior/current_behavior as anything in current_behaviors)
		if(!(current_behavior.behavior_flags & AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION))
			return FALSE
	return TRUE

///This is where you decide what actions are taken by the AI.
/datum/ai_controller/proc/SelectBehaviors(seconds_per_tick)
	SHOULD_NOT_SLEEP(TRUE) //Fuck you don't sleep in procs like this.
	if(!COOLDOWN_FINISHED(src, failed_planning_cooldown))
		return FALSE

	LAZYINITLIST(current_behaviors)
	// what we were already doing, so anything the plan doesn't pick again can be cancelled
	var/list/previous_behaviors = current_behaviors.Copy()
	planned_behaviors = list()
	planning = TRUE
	var/list/plan_record = logging_decisions ? list() : null

	// bring what we know up to date first, so the guards below go by how things are now
	for(var/datum/ai_sensor/sensor as anything in sensors)
		sensor.sense(src, seconds_per_tick)
	pawn_conditions = null // worked out again the first time a guard needs them
	refused_behaviors = 0

	current_plan_record = plan_record
	plan_depth = 0 // in case a runtime cut the last plan short partway down a group
	run_subtrees(planning_subtrees, seconds_per_tick)
	current_plan_record = null

	planning = FALSE
	if(plan_record)
		last_plan = plan_record

	for(var/datum/ai_behavior/previous_behavior as anything in previous_behaviors)
		if(planned_behaviors[previous_behavior] || !(previous_behavior in current_behaviors))
			continue // still in the plan, or it finished on its own while we planned
		finish_behavior(previous_behavior)
	planned_behaviors = null

///This proc handles changing ai status, and starts/stops processing if required.
/datum/ai_controller/proc/set_ai_status(new_ai_status)
	if(ai_status == new_ai_status)
		return FALSE //no change

	ai_status = new_ai_status
	stop_sleeping()
	switch(ai_status)
		if(AI_STATUS_ON)
			SSai_controllers.active_ai_controllers += src
			START_PROCESSING(SSai_behaviors, src)
		if(AI_STATUS_OFF, AI_STATUS_IDLE)
			STOP_PROCESSING(SSai_behaviors, src)
			SSai_controllers.active_ai_controllers -= src
			CancelActions()
	if(ai_status == AI_STATUS_IDLE)
		sleeping_on_virtual_level = "[pawn.virtual_z()]"
		LAZYADDASSOCLIST(SSai_controllers.sleeping_ai_by_virtual_level, sleeping_on_virtual_level, src)

// starts processing again if we'd gone to sleep, but leaves us be if we've been switched off or a player's in control
/datum/ai_controller/proc/wake_up()
	if(ai_status == AI_STATUS_IDLE)
		set_ai_status(AI_STATUS_ON)

/**
 * Goes to sleep and stops processing if there's no players on our virtual z-level, or wakes up if there are.
 * Checked when we've nothing to do, and when our mob changes z-level
 */
/datum/ai_controller/proc/check_should_sleep()
	if(ai_status == AI_STATUS_OFF || QDELETED(pawn))
		return // a player's in control, or we've been switched off
	var/atom/target = blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target))
		wake_up()
		return // in the middle of a fight, so see it through even if there's nobody around to watch
	var/virtual_level = pawn.virtual_z()
	if(!virtual_level)
		return
	if(length(LAZYACCESS(SSmobs.players_by_virtual_z, "[virtual_level]")))
		set_ai_status(AI_STATUS_ON)
	else if(ai_status != AI_STATUS_IDLE)
		set_ai_status(AI_STATUS_IDLE)
	else if(sleeping_on_virtual_level != "[virtual_level]")
		// already asleep, but we've moved to another empty level, so be filed under that one instead
		stop_sleeping()
		sleeping_on_virtual_level = "[virtual_level]"
		LAZYADDASSOCLIST(SSai_controllers.sleeping_ai_by_virtual_level, sleeping_on_virtual_level, src)

/// Takes us off the list of sleeping AI for our virtual z-level
/datum/ai_controller/proc/stop_sleeping()
	if(!sleeping_on_virtual_level)
		return
	LAZYREMOVEASSOC(SSai_controllers.sleeping_ai_by_virtual_level, sleeping_on_virtual_level, src)
	sleeping_on_virtual_level = null

/datum/ai_controller/proc/PauseAi(time)
	paused_until = world.time + time

///Call this to add a behavior to the stack. Returns TRUE if it's going, or FALSE if it refused to start, like having nowhere to go
/datum/ai_controller/proc/queue_behavior(behavior_type, ...)
	var/datum/ai_behavior/behavior = GET_AI_BEHAVIOR(behavior_type)
	if(!behavior)
		CRASH("Behavior [behavior_type] not found.")
	if(LAZYACCESS(planned_behaviors, behavior))
		return TRUE // an earlier subtree this planning pass already wants it, and comes first
	if(behavior in current_behaviors)
		var/list/new_arguments = args.Copy(2)
		var/list/old_arguments = behavior_args[behavior_type] || list()
		if(new_arguments ~= old_arguments && !moving_to_stale(behavior, new_arguments))
			// already doing it, so keep it going rather than setting it up again, and don't let the planning pass cancel it
			LAZYSET(planned_behaviors, behavior, TRUE)
			return TRUE
		// doing it with something else, like walking somewhere else, so stop and start over
		finish_behavior(behavior)
	var/list/arguments = args.Copy()
	arguments[1] = src
	if(!behavior.setup(arglist(arguments)))
		refused_behaviors++
		return FALSE
	LAZYADD(current_behaviors, behavior)
	LAZYSET(planned_behaviors, behavior, TRUE)
	arguments.Cut(1, 2)
	if(length(arguments))
		behavior_args[behavior_type] = arguments
	else
		behavior_args -= behavior_type
	if((behavior.behavior_flags & AI_BEHAVIOR_REQUIRE_MOVEMENT) && length(arguments) && istext(arguments[1]))
		LAZYSET(behavior_setup_refs, behavior_type, REF(blackboard[arguments[1]]))
	return TRUE

/// Whether the blackboard key a movement behaviour got its target from has changed since it was set up, so queue_behavior() sets it up again
/datum/ai_controller/proc/moving_to_stale(datum/ai_behavior/behavior, list/arguments)
	if(!(behavior.behavior_flags & AI_BEHAVIOR_REQUIRE_MOVEMENT) || !length(arguments) || !istext(arguments[1]))
		return FALSE
	var/setup_ref = LAZYACCESS(behavior_setup_refs, behavior.type)
	return !isnull(setup_ref) && setup_ref != REF(blackboard[arguments[1]])

/datum/ai_controller/proc/ProcessBehavior(seconds_per_tick, datum/ai_behavior/behavior)
	var/list/arguments = list(seconds_per_tick, src)
	var/list/stored_arguments = behavior_args[behavior.type]
	if(stored_arguments)
		arguments += stored_arguments

	var/process_flags = behavior.perform(arglist(arguments))
	if(process_flags & AI_BEHAVIOR_DELAY)
		behavior_cooldowns[behavior] = world.time + behavior.get_cooldown(src)
	if(process_flags & AI_BEHAVIOR_FAILED)
		arguments[1] = src
		arguments[2] = FALSE
		LAZYSET(behavior_outcomes, behavior.type, FALSE)
		behavior.finish_action(arglist(arguments))
	else if (process_flags & AI_BEHAVIOR_SUCCEEDED)
		arguments[1] = src
		arguments[2] = TRUE
		LAZYSET(behavior_outcomes, behavior.type, TRUE)
		behavior.finish_action(arglist(arguments))

/// How behavior_type last ended on its own since we last forgot about it: TRUE if it succeeded, FALSE if it failed, or null if it hasn't
/datum/ai_controller/proc/get_behavior_outcome(behavior_type)
	return LAZYACCESS(behavior_outcomes, behavior_type)

/// Forgets how behavior_type last ended, so get_behavior_outcome() only tells us about the next time, like when a step in a sequence starts it
/datum/ai_controller/proc/forget_behavior_outcome(behavior_type)
	LAZYREMOVE(behavior_outcomes, behavior_type)

/datum/ai_controller/proc/CancelActions()
	if(!LAZYLEN(current_behaviors))
		return
	for(var/i in current_behaviors)
		var/datum/ai_behavior/current_behavior = i
		finish_behavior(current_behavior)

/// Ends behavior, passing along the arguments it was queued with, like if we've given up on it or are doing something else instead
/datum/ai_controller/proc/finish_behavior(datum/ai_behavior/behavior, succeeded = FALSE)
	var/list/arguments = list(src, succeeded)
	var/list/stored_arguments = behavior_args[behavior.type]
	if(stored_arguments)
		arguments += stored_arguments
	behavior.finish_action(arglist(arguments))

/datum/ai_controller/proc/on_sentience_gained()
	SIGNAL_HANDLER
	UnregisterSignal(pawn, COMSIG_MOB_LOGIN)
	if(!continue_processing_when_client)
		set_ai_status(AI_STATUS_OFF) //Can't do anything while player is connected
	RegisterSignal(pawn, COMSIG_MOB_LOGOUT, PROC_REF(on_sentience_lost))

/datum/ai_controller/proc/on_sentience_lost()
	SIGNAL_HANDLER
	UnregisterSignal(pawn, COMSIG_MOB_LOGOUT)
	set_ai_status(AI_STATUS_ON) //Can't do anything while player is connected
	check_should_sleep() // they might have left us somewhere nobody is
	RegisterSignal(pawn, COMSIG_MOB_LOGIN, PROC_REF(on_sentience_gained))

/// Use this proc to define how your controller defines what access the pawn has for the sake of pathfinding, likely pointing to whatever ID slot is relevant
/datum/ai_controller/proc/get_access()
	if(!length(door_access))
		return
	if(QDELETED(door_access_card))
		door_access_card = new // in nullspace, out of reach of anyone who'd want to take it
		door_access_card.access = door_access.Copy()
	return door_access_card

// whether we gave up on getting to them lately, unless they've just shot at us
/datum/ai_controller/proc/check_still_ignoring(atom/target)
	var/ignore_until = LAZYACCESS(blackboard[BB_BASIC_MOB_IGNORED_TARGETS], target)
	if(!ignore_until || world.time >= ignore_until)
		return FALSE
	if(blackboard[BB_BASIC_MOB_SHOT_BY] == target && world.time - blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < 2 SECONDS)
		return FALSE
	// a way's opened up, like the window's gone or they've come round it. Only the straight line, as pathing every look would cost too much
	var/turf/their_turf = get_turf(target)
	if(their_turf && their_turf.z == pawn.z && get_dist(pawn, their_turf) <= AI_IGNORE_RECHECK_RANGE && can_walk_straight_to(pawn, their_turf))
		remove_thing_from_blackboard_key(BB_BASIC_MOB_IGNORED_TARGETS, target)
		return FALSE
	return TRUE

// goes after target that mob learns about without direct confirmation
/datum/ai_controller/proc/learn_of_target(atom/target, turf/seen_at, how)
	if(how != AI_LEARNED_SHOT && check_still_ignoring(target))
		return FALSE // we know there's no getting to them
	set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)
	set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TARGET, target)
	if(how == AI_LEARNED_TOLD)
		set_blackboard_key(BB_BASIC_MOB_TOLD_ABOUT_TARGET, TRUE)
	else
		clear_blackboard_key(BB_BASIC_MOB_TOLD_ABOUT_TARGET) // we know it for ourselves
	if(how == AI_LEARNED_HEARD)
		set_blackboard_key(BB_BASIC_MOB_HEARD_TARGET, TRUE)
	else
		clear_blackboard_key(BB_BASIC_MOB_HEARD_TARGET)
	clear_blackboard_key(BB_BASIC_MOB_SEARCH_CALLED_OUT)
	wake_up()
	if(ai_can_see(pawn, target, blackboard[BB_BASIC_MOB_VISION_RANGE] || AI_DEFAULT_VISION_RANGE))
		clear_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME) // they're right there, so spot them the usual way
		clear_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF)
		return TRUE
	set_blackboard_key(BB_BASIC_MOB_TARGET_IN_SIGHT, FALSE)
	set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF, seen_at)
	set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time)
	return FALSE

///Returns the minimum required distance to preform one of our current behaviors. Honestly this should just be cached or something but fuck you
/datum/ai_controller/proc/get_minimum_distance()
	var/minimum_distance = max_target_distance
	// right now I'm just taking the shortest minimum distance of our current behaviors, at some point in the future
	// we should let whatever sets the current_movement_target also set the min distance and max path length
	// (or at least cache it on the controller)
	for(var/datum/ai_behavior/iter_behavior as anything in current_behaviors)
		if(iter_behavior.required_distance < minimum_distance)
			minimum_distance = iter_behavior.required_distance
	return minimum_distance

/// Returns true if we have a blackboard key with the provided key and it is not qdeleting
/datum/ai_controller/proc/blackboard_key_exists(key)
	var/datum/key_value = blackboard[key]
	if (isdatum(key_value))
		return !QDELETED(key_value)
	if (islist(key_value))
		return length(key_value) > 0
	return !!key_value

/**
 * Used to manage references to datum by AI controllers
 *
 * * tracked_datum - something being added to an ai blackboard
 * * key - the associated key
 */
#define TRACK_AI_DATUM_TARGET(tracked_datum, key) do { \
	if(isweakref(tracked_datum)) { \
		var/datum/weakref/_bad_weakref = tracked_datum; \
		stack_trace("Weakref (Actual datum: [_bad_weakref.resolve()]) found in ai datum blackboard! \
			This is an outdated method of ai reference handling, please remove it."); \
	}; \
	else if(isdatum(tracked_datum)) { \
		var/datum/_tracked_datum = tracked_datum; \
		if(!HAS_TRAIT_FROM(_tracked_datum, TRAIT_AI_TRACKING, "[REF(src)]_[key]")) { \
			RegisterSignal(_tracked_datum, COMSIG_QDELETING, PROC_REF(sig_remove_from_blackboard), override = TRUE); \
			ADD_TRAIT(_tracked_datum, TRAIT_AI_TRACKING, "[REF(src)]_[key]"); \
		}; \
	}; \
} while(FALSE)

/**
 * Used to clear previously set reference handing by AI controllers
 *
 * * tracked_datum - something being removed from an ai blackboard
 * * key - the associated key
 */
#define CLEAR_AI_DATUM_TARGET(tracked_datum, key) do { \
	if(isdatum(tracked_datum)) { \
		var/datum/_tracked_datum = tracked_datum; \
		REMOVE_TRAIT(_tracked_datum, TRAIT_AI_TRACKING, "[REF(src)]_[key]"); \
		if(!HAS_TRAIT(_tracked_datum, TRAIT_AI_TRACKING)) { \
			UnregisterSignal(_tracked_datum, COMSIG_QDELETING); \
		}; \
	}; \
} while(FALSE)

/// Used for above to track all the keys that have registered a signal
#define TRAIT_AI_TRACKING "tracked_by_ai"

/**
 * Sets the key to the passed "thing".
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/set_blackboard_key(key, thing)
	// Assume it is an error when trying to set a value overtop a list
	if(islist(blackboard[key]))
		CRASH("set_blackboard_key attempting to set a blackboard value to key [key] when it's a list!")
	// Don't do anything if it's already got this value
	if (blackboard[key] == thing)
		return

	// Clear existing values
	if(!isnull(blackboard[key]))
		clear_blackboard_key(key)

	TRACK_AI_DATUM_TARGET(thing, key)
	blackboard[key] = thing
	post_blackboard_key_set(key)

/**
 * Sets the key at index thing to the passed value
 *
 * Assumes the key value is already a list, if not throws an error.
 *
 * * key - A blackboard key, with its value set to a list
 * * thing - a value which becomes the inner list value's key
 * * value - what to set the inner list's value to
 */
/datum/ai_controller/proc/set_blackboard_key_assoc(key, thing, value)
	if(!islist(blackboard[key]))
		CRASH("set_blackboard_key_assoc called on non-list key [key]!")
	// Don't do anything if it's already got this value
	if (blackboard[key][thing] == value)
		return
	TRACK_AI_DATUM_TARGET(thing, key)
	TRACK_AI_DATUM_TARGET(value, key)
	blackboard[key][thing] = value
	post_blackboard_key_set(key)

/**
 * Similar to [proc/set_blackboard_key_assoc] but operates under the assumption the key is a lazylist (so it will create a list)
 * More dangerous / easier to override values, only use when you want to use a lazylist
 *
 * * key - A blackboard key, with its value set to a list
 * * thing - a value which becomes the inner list value's key
 * * value - what to set the inner list's value to
 */
/datum/ai_controller/proc/set_blackboard_key_assoc_lazylist(key, thing, value)
	LAZYINITLIST(blackboard[key])
	// Don't do anything if it's already got this value
	if (blackboard[key][thing] == value)
		return
	TRACK_AI_DATUM_TARGET(thing, key)
	TRACK_AI_DATUM_TARGET(value, key)
	blackboard[key][thing] = value
	post_blackboard_key_set(key)

/**
* Called after we set a blackboard key, forwards signal information.
*/
/datum/ai_controller/proc/post_blackboard_key_set(key)
	conditions_stale = TRUE
	if (isnull(pawn))
		return
	SEND_SIGNAL(pawn, COMSIG_AI_BLACKBOARD_KEY_SET(key))

/**
 * Adds the passed "thing" to the associated key
 *
 * Works with lists or numbers, but not lazylists.
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/add_blackboard_key(key, thing)
	TRACK_AI_DATUM_TARGET(thing, key)
	blackboard[key] += thing

/**
 * Similar to [proc/add_blackboard_key], but performs an insertion rather than an add
 * Throws an error if the key is not a list already, intended only for use with lists
 *
 * * key - A blackboard key, with its value set to a list
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/insert_blackboard_key(key, thing)
	if(!islist(blackboard[key]))
		CRASH("insert_blackboard_key called on non-list key [key]!")
	TRACK_AI_DATUM_TARGET(thing, key)
	blackboard[key] |= thing

/**
 * Adds the passed "thing" to the associated key, assuming key is intended to be a lazylist (so it will create a list)
 * More dangerous / easier to override values, only use when you want to use a lazylist
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/add_blackboard_key_lazylist(key, thing)
	LAZYINITLIST(blackboard[key])
	TRACK_AI_DATUM_TARGET(thing, key)
	blackboard[key] += thing

/**
 * Similar to [proc/insert_blackboard_key_lazylist], but performs an insertion / or rather than an add
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/insert_blackboard_key_lazylist(key, thing)
	LAZYINITLIST(blackboard[key])
	TRACK_AI_DATUM_TARGET(thing, key)
	blackboard[key] |= thing

/**
 * Adds the value to the inner list at key with the inner key set to "thing"
 * Throws an error if the key is not a list already, intended only for use with lists
 *
 * * key - A blackboard key, with its value set to a list
 * * thing - a value which becomes the inner list value's key
 * * value - what to set the inner list's value to
 */
/datum/ai_controller/proc/add_blackboard_key_assoc(key, thing, value)
	if(!islist(blackboard[key]))
		CRASH("add_blackboard_key_assoc called on non-list key [key]!")
	TRACK_AI_DATUM_TARGET(thing, key)
	TRACK_AI_DATUM_TARGET(value, key)
	blackboard[key][thing] += value


/**
 * Similar to [proc/add_blackboard_key_assoc], assuming key is intended to be a lazylist (so it will create a list)
 * More dangerous / easier to override values, only use when you want to use a lazylist
 *
 * * key - A blackboard key, with its value set to a list
 * * thing - a value which becomes the inner list value's key
 * * value - what to set the inner list's value to
 */
/datum/ai_controller/proc/add_blackboard_key_assoc_lazylist(key, thing, value)
	LAZYINITLIST(blackboard[key])
	TRACK_AI_DATUM_TARGET(thing, key)
	TRACK_AI_DATUM_TARGET(value, key)
	blackboard[key][thing] += value

/**
 * Clears the passed key, resetting it to null
 *
 * Not intended for use with list keys - use [proc/remove_thing_from_blackboard_key] if you are removing a value from a list at a key
 *
 * * key - A blackboard key
 */
/datum/ai_controller/proc/clear_blackboard_key(key)
	CLEAR_AI_DATUM_TARGET(blackboard[key], key)
	blackboard[key] = null
	conditions_stale = TRUE
	if(isnull(pawn))
		return
	SEND_SIGNAL(pawn, COMSIG_AI_BLACKBOARD_KEY_CLEARED(key))

/**
 * Remove the passed thing from the associated blackboard key
 *
 * Intended for use with lists, if you're just clearing a reference from a key use [proc/clear_blackboard_key]
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/remove_thing_from_blackboard_key(key, thing)
	var/associated_value = blackboard[key]
	if(thing == associated_value)
		stack_trace("remove_thing_from_blackboard_key was called un-necessarily in a situation where clear_blackboard_key would suffice. ")
		clear_blackboard_key(key)
		return

	if(!islist(associated_value))
		CRASH("remove_thing_from_blackboard_key called with an invalid \"thing\" argument ([thing]). \
			(The associated value of the passed key is not a list and is also not the passed thing, meaning it is clearing an unintended value.)")

	for(var/inner_key in associated_value)
		if(inner_key == thing)
			// flat list
			CLEAR_AI_DATUM_TARGET(thing, key)
			associated_value -= thing
			return
		else if(associated_value[inner_key] == thing)
			// assoc list
			CLEAR_AI_DATUM_TARGET(thing, key)
			associated_value -= inner_key
			return

	CRASH("remove_thing_from_blackboard_key called with an invalid \"thing\" argument ([thing]). \
		(The passed value is not tracked in the passed list.)")

/// Signal proc to go through every key and remove the datum from all keys it finds
/datum/ai_controller/proc/sig_remove_from_blackboard(datum/source)
	SIGNAL_HANDLER

	var/list/list/remove_queue = list(blackboard)
	var/index = 1
	while(index <= length(remove_queue))
		var/list/next_to_clear = remove_queue[index]
		for(var/inner_value in next_to_clear)
			var/associated_value = next_to_clear[inner_value]
			// We are a lists of lists, add the next value to the queue so we can handle references in there
			// (But we only need to bother checking the list if it's not empty.)
			if(islist(inner_value) && length(inner_value))
				UNTYPED_LIST_ADD(remove_queue, inner_value)

			// We found the value that's been deleted. Clear it out from this list
			else if(inner_value == source)
				next_to_clear -= inner_value

			// We are an assoc lists of lists, the list at the next value so we can handle references in there
			// (But again, we only need to bother checking the list if it's not empty.)
			if(islist(associated_value) && length(associated_value))
				UNTYPED_LIST_ADD(remove_queue, associated_value)

			// We found the value that's been deleted, it was an assoc value. Clear it out entirely
			else if(associated_value == source)
				next_to_clear -= inner_value

		index += 1

#undef TRACK_AI_DATUM_TARGET
#undef CLEAR_AI_DATUM_TARGET
#undef TRAIT_AI_TRACKING

/**
 * The AI_CONDITION_* flags true for us right now, for our planning subtrees' guards
 * Those about our mob are worked out once each plan, and those going by the blackboard again whenever it's changed, like when an earlier subtree takes cover
 */
/datum/ai_controller/proc/get_conditions()
	if(isnull(pawn_conditions))
		pawn_conditions = get_pawn_conditions()
		conditions_stale = TRUE
	if(conditions_stale)
		conditions = pawn_conditions | get_blackboard_conditions()
		conditions_stale = FALSE
	return conditions

/// The AI_CONDITION_* flags true for our mob itself
/datum/ai_controller/proc/get_pawn_conditions()
	. = NONE
	if(isbasicmob(pawn) && !is_environment_safe_for(pawn, get_turf(pawn)))
		. |= AI_CONDITION_UNSAFE_SPOT
	if(pawn.GetComponent(/datum/component/ranged_attacks))
		. |= AI_CONDITION_HAS_RANGED_ATTACK
	var/datum/component/ai_magazine/magazine = pawn.GetComponent(/datum/component/ai_magazine)
	if(magazine?.reloading)
		. |= AI_CONDITION_RELOADING

/// The AI_CONDITION_* flags true going by what's on our blackboard
/datum/ai_controller/proc/get_blackboard_conditions()
	. = NONE
	var/atom/target = blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target))
		. |= AI_CONDITION_HAS_TARGET
		var/in_sight = blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT]
		if(in_sight == TRUE)
			. |= AI_CONDITION_TARGET_SEEN
		else if(in_sight == FALSE)
			. |= AI_CONDITION_TARGET_LOST
		if(target.Adjacent(pawn))
			. |= AI_CONDITION_TARGET_ADJACENT
	if(blackboard[BB_BASIC_MOB_TAKING_COVER_TURF])
		. |= AI_CONDITION_TAKING_COVER
	if(blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF])
		. |= AI_CONDITION_FIGHTING_FROM_COVER
	if(blackboard[BB_BASIC_MOB_FLANKING])
		. |= AI_CONDITION_FLANKING
	if(blackboard[BB_BASIC_MOB_REPOSITION_TURF])
		. |= AI_CONDITION_REPOSITIONING
	if(world.time < blackboard[BB_BASIC_MOB_BACKING_OFF_UNTIL])
		. |= AI_CONDITION_BACKING_OFF
	if(blackboard[BB_BASIC_MOB_SAFE_TURF])
		. |= AI_CONDITION_SEEKING_SAFETY
	if(AI_MORALE_IS(src, AI_MORALE_BROKEN))
		. |= AI_CONDITION_BROKEN

/// Plans again straight away when one of our interrupt_keys changes, rather than waiting until we'd next plan anyway, so we react to things like a target turning up or getting shot at once
/datum/ai_controller/proc/on_interrupt_key_changed(datum/source)
	SIGNAL_HANDLER
	if(planning || ai_status != AI_STATUS_ON)
		return // we're planning already, so it's being taken into account
	addtimer(CALLBACK(src, PROC_REF(interrupt_planning)), 0, TIMER_UNIQUE) // once whatever changed it is done, and once for several changes at once

/**
 * Plans again now, because something important's changed. Plans even if what we're doing would normally keep us from planning,
 * so anything that no longer makes sense gets dropped, rather than carrying on until it finishes
 */
/datum/ai_controller/proc/interrupt_planning()
	if(QDELETED(pawn) || ai_status != AI_STATUS_ON || !able_to_run())
		return
	AI_LOG_DECISION(src, "something changed, so planning again now")
	COOLDOWN_RESET(src, failed_planning_cooldown)
	SelectBehaviors(SSai_controllers.wait * 0.1)
