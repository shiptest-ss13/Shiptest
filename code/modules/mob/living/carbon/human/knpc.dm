#define AI_TRAIT_BRAWLER 1 //The "marines". These guys will attempt to stand and fight
#define AI_TRAIT_SUPPORT 2 //The "medics", civvies, etc. These lads will call for backup

//KNPC flags
#define KNPC_IS_MARTIAL_ARTIST 1<<0		//Does the KNPC combo you right into the next round?
#define KNPC_IS_DODGER 1<<1				//Does the KNPC become like the wind in CQC?
#define KNPC_IS_MERCIFUL 1<<2			//Does the KNPC consider mobs in crit to be valid?
#define KNPC_IS_AREA_SPECIFIC 1<<3		//Does the KNPC scream out the area when calling for backup?
#define KNPC_IS_DOOR_BASHER 1<<4		//Does the KNPC kick the door off its hinges if it doesn't have a valid ID?
#define KNPC_IS_DOOR_HACKER 1<<5		//Does the KNPC hack the door open if it doesn't have a valid ID?
#define KNPC_STEAL_ID 1<<5				//Do we steal IDs? used to prevent a bug

//Knpc pathfinding return values
#define KNPC_PATHFIND_SUCCESS 0 //Path successfully generated
#define KNPC_PATHFIND_SKIP 1 //Regenerating of path isn't needed, incapable of moving, etc
#define KNPC_PATHFIND_TIMEOUT 2 //Pathfinding is currently in timeout due to having failed previously.
#define KNPC_PATHFIND_FAIL 3 //No path found

//Knpc pathfinding timeout defines
#define KNPC_TIMEOUT_BASE (3 SECONDS) //The base timeout applied if an knpc's pathfinding fails.
#define KNPC_TIMEOUT_STACK_CAP 9 //Every consecutive pathfinding fail adds a stacks; Timeout applied uses them as multiplier up to a cap of this value.

//AI behaviour
#define AI_AGGRESSIVE 1
#define AI_PASSIVE 2
#define AI_RETALIATE 3
#define AI_GUARD 4

DEFINE_BITFIELD(knpc_traits, list(
	"KNPC_IS_MARTIAL_ARTIST" = KNPC_IS_MARTIAL_ARTIST,
	"KNPC_IS_DODGER" = KNPC_IS_DODGER,
	"KNPC_IS_MERCIFUL" = KNPC_IS_MERCIFUL,
	"KNPC_IS_AREA_SPECIFIC" = KNPC_IS_AREA_SPECIFIC,
	"KNPC_IS_DOOR_BASHER" = KNPC_IS_DOOR_BASHER,
	"KNPC_IS_DOOR_HACKER" = KNPC_IS_DOOR_HACKER,
	"KNPC_STEAL_ID" = KNPC_STEAL_ID,
))

//AI score defines
#define AI_SCORE_MAXIMUM 1000 //No goal combination should ever exceed this.
#define AI_SCORE_SUPERCRITICAL 500
#define AI_SCORE_CRITICAL 100
#define AI_SCORE_SUPERPRIORITY 75
#define AI_SCORE_HIGH_PRIORITY 60
#define AI_SCORE_PRIORITY 50
#define AI_SCORE_DEFAULT 25
#define AI_SCORE_LOW_PRIORITY 15
#define AI_SCORE_VERY_LOW_PRIORITY 5 //Very low priority, acts as a failsafe to ensure that the AI always picks _something_ to do.

#define KNPC_DIFFICULTY_EASY 1 //The "marines". These guys will attempt to stand and fight
#define KNPC_DIFFICULTY_HARD 2 //The "marines". These guys will attempt to stand and fight

///This proc takes a dir and turns it into a list of its cardinal dirs. Useful for, say, handling things on multiple cardinals, and only cardinals, in case of diagonal positioning.
/proc/dir_to_cardinal_dirs(input_dir)
	if(input_dir in list(NORTH, EAST, SOUTH, WEST))
		return list(input_dir)
	switch(input_dir)
		if(NORTHEAST)
			return list(NORTH, EAST)
		if(NORTHWEST)
			return list(NORTH, WEST)
		if(SOUTHEAST)
			return list(SOUTH, EAST)
		if(SOUTHWEST)
			return list(SOUTH, WEST)

//heap.dm
//////////////////////
//datum/heap object
//////////////////////

/datum/heap
	var/list/L
	var/cmp

/datum/heap/New(compare)
	L = new()
	cmp = compare

/datum/heap/Destroy(force, ...)
	for(var/i in L) // because this is before the list helpers are loaded
		qdel(i)
	L = null
	return ..()

/datum/heap/proc/is_empty()
	return !length(L)

//insert and place at its position a new node in the heap
/datum/heap/proc/insert(atom/A)

	L.Add(A)
	swim(length(L))

//removes and returns the first element of the heap
//(i.e the max or the min dependant on the comparison function)
/datum/heap/proc/pop()
	if(!length(L))
		return 0
	. = L[1]

	L[1] = L[length(L)]
	L.Cut(length(L))
	if(length(L))
		sink(1)

//Get a node up to its right position in the heap
/datum/heap/proc/swim(index)
	var/parent = round(index * 0.5)

	while(parent > 0 && (call(cmp)(L[index],L[parent]) > 0))
		L.Swap(index,parent)
		index = parent
		parent = round(index * 0.5)

//Get a node down to its right position in the heap
/datum/heap/proc/sink(index)
	var/g_child = get_greater_child(index)

	while(g_child > 0 && (call(cmp)(L[index],L[g_child]) < 0))
		L.Swap(index,g_child)
		index = g_child
		g_child = get_greater_child(index)

//Returns the greater (relative to the comparison proc) of a node children
//or 0 if there's no child
/datum/heap/proc/get_greater_child(index)
	if(index * 2 > length(L))
		return 0

	if(index * 2 + 1 > length(L))
		return index * 2

	if(call(cmp)(L[index * 2],L[index * 2 + 1]) < 0)
		return index * 2 + 1
	else
		return index * 2

//Replaces a given node so it verify the heap condition
/datum/heap/proc/resort(atom/A)
	var/index = L.Find(A)

	swim(index)
	sink(index)

/datum/heap/proc/List()
	. = L.Copy()
//heap.dm end

//path.dm
/**
 * This file contains the stuff you need for using JPS (Jump Point Search) pathing, an alternative to A* that skips
 * over large numbers of uninteresting tiles resulting in much quicker pathfinding solutions. Mind that diagonals
 * cost the same as cardinal moves currently, so paths may look a bit strange, but should still be optimal.
 */

/**
 * This is the proc you use whenever you want to have pathfinding more complex than "try stepping towards the thing".
 * If no path was found, returns an empty list, which is important for bots like medibots who expect an empty list rather than nothing.
 *
 * Arguments:
 * * caller: The movable atom that's trying to find the path
 * * end: What we're trying to path to. It doesn't matter if this is a turf or some other atom, we're gonna just path to the turf it's on anyway
 * * max_distance: The maximum number of steps we can take in a given path to search (default: 30, 0 = infinite)
 * * mintargetdistance: Minimum distance to the target before path returns, could be used to get near a target, but not right to it - for an AI mob with a gun, for example.
 * * id: An ID card representing what access we have and what doors we can open. Its location relative to the pathing atom is irrelevant
 * * simulated_only: Whether we consider turfs without atmos simulation (AKA do we want to ignore space)
 * * exclude: If we want to avoid a specific turf, like if we're a mulebot who already got blocked by some turf
 * * skip_first: Whether or not to delete the first item in the path. This would be done because the first item is the starting tile, which can break movement for some creatures.
 */
/proc/jps_get_path_to(caller, end, max_distance = 30, mintargetdist, id=null, simulated_only = TRUE, turf/exclude, skip_first = TRUE)
	if(!caller || !get_turf(end))
		return

	var/l = SSpathfinder.mobs.getfree(caller)
	while(!l)
		stoplag(3)
		l = SSpathfinder.mobs.getfree(caller)

	var/list/path
	var/datum/pathfind/pathfind_datum = new(caller, end, id, max_distance, mintargetdist, simulated_only, exclude)
	path = pathfind_datum.search()
	qdel(pathfind_datum)

	SSpathfinder.mobs.found(l)
	if(!path)
		path = list()
	if(length(path) > 0 && skip_first)
		path.Cut(1,2)
	return path

/**
 * A helper macro to see if it's possible to step from the first turf into the second one, minding things like door access and directional windows.
 * Note that this can only be used inside the [datum/pathfind][pathfind datum] since it uses variables from said datum.
 * If you really want to optimize things, optimize this, cuz this gets called a lot.
 */
#define CAN_STEP(cur_turf, next) (next && !next.density && cur_turf.Adjacent(next) && !(simulated_only && SSpathfinder.space_type_cache[next.type]) && !cur_turf.jps_LinkBlockedWithAccess(next,caller, id) && (next != avoid))
/// Another helper macro for JPS, for telling when a node has forced neighbors that need expanding
#define STEP_NOT_HERE_BUT_THERE(cur_turf, dirA, dirB) ((!CAN_STEP(cur_turf, get_step(cur_turf, dirA)) && CAN_STEP(cur_turf, get_step(cur_turf, dirB))))

/// The JPS Node datum represents a turf that we find interesting enough to add to the open list and possibly search for new tiles from
/datum/jps_node
	/// The turf associated with this node
	var/turf/tile
	/// The node we just came from
	var/datum/jps_node/previous_node
	/// The A* node weight (f_value = number_of_tiles + heuristic)
	var/f_value
	/// The A* node heuristic (a rough estimate of how far we are from the goal)
	var/heuristic
	/// How many steps it's taken to get here from the start (currently pulling double duty as steps taken & cost to get here, since all moves incl diagonals cost 1 rn)
	var/number_tiles
	/// How many steps it took to get here from the last node
	var/jumps
	/// Nodes store the endgoal so they can process their heuristic without a reference to the pathfind datum
	var/turf/node_goal

/datum/jps_node/New(turf/our_tile, datum/jps_node/incoming_previous_node, jumps_taken, turf/incoming_goal)
	tile = our_tile
	jumps = jumps_taken
	if(incoming_goal) // if we have the goal argument, this must be the first/starting node
		node_goal = incoming_goal
	else if(incoming_previous_node) // if we have the parent, this is from a direct lateral/diagonal scan, we can fill it all out now
		previous_node = incoming_previous_node
		number_tiles = previous_node.number_tiles + jumps
		node_goal = previous_node.node_goal
		heuristic = get_dist(tile, node_goal)
		f_value = number_tiles + heuristic
	// otherwise, no parent node means this is from a subscan lateral scan, so we just need the tile for now until we call [datum/jps/proc/update_parent] on it

/datum/jps_node/Destroy(force, ...)
	previous_node = null
	return ..()

/datum/jps_node/proc/update_parent(datum/jps_node/new_parent)
	previous_node = new_parent
	node_goal = previous_node.node_goal
	jumps = get_dist(tile, previous_node.tile)
	number_tiles = previous_node.number_tiles + jumps
	heuristic = get_dist(tile, node_goal)
	f_value = number_tiles + heuristic

/// TODO: Macro this to reduce proc overhead
/proc/jps_HeapPathWeightCompare(datum/jps_node/a, datum/jps_node/b)
	return b.f_value - a.f_value

/// The datum used to handle the JPS pathfinding, completely self-contained
/datum/pathfind
	/// The thing that we're actually trying to path for
	var/atom/movable/caller
	/// The turf where we started at
	var/turf/start
	/// The turf we're trying to path to (note that this won't track a moving target)
	var/turf/end
	/// The open list/stack we pop nodes out from (TODO: make this a normal list and macro-ize the heap operations to reduce proc overhead)
	var/datum/heap/open
	///An assoc list that serves as the closed list & tracks what turfs came from where. Key is the turf, and the value is what turf it came from
	var/list/sources
	/// The list we compile at the end if successful to pass back
	var/list/path

	// general pathfinding vars/args
	/// An ID card representing what access we have and what doors we can open. Its location relative to the pathing atom is irrelevant
	var/obj/item/card/id/id
	/// How far away we have to get to the end target before we can call it quits
	var/mintargetdist = 0
	/// I don't know what this does vs , but they limit how far we can search before giving up on a path
	var/max_distance = 30
	/// Space is big and empty, if this is TRUE then we ignore pathing through unsimulated tiles
	var/simulated_only
	/// A specific turf we're avoiding, like if a mulebot is being blocked by someone t-posing in a doorway we're trying to get through
	var/turf/avoid
	/// A specific turf we're avoiding, like if a mulebot is being blocked by someone t-posing in a doorway we're trying to get through
	var/list/turfs_to_avoid = list(/turf/open/water/acid,/turf/open/lava)

/datum/pathfind/New(atom/movable/caller, atom/goal, id, max_distance, mintargetdist, simulated_only, avoid, avoid_mobs)
	src.caller = caller
	end = get_turf(goal)
	open = new /datum/heap(GLOBAL_PROC_REF(jps_HeapPathWeightCompare))
	sources = new()
	src.id = id
	src.max_distance = max_distance
	src.mintargetdist = mintargetdist
	src.simulated_only = simulated_only
	src.avoid = avoid

/**
 * search() is the proc you call to kick off and handle the actual pathfinding, and kills the pathfind datum instance when it's done.
 *
 * If a valid path was found, it's returned as a list. If invalid or cross-z-level params are entered, or if there's no valid path found, we
 * return null, which [/proc/jps_get_path_to] translates to an empty list (notable for simple bots, who need empty lists)
 */
/datum/pathfind/proc/search()
	start = get_turf(caller)
	if(!start || !end)
		stack_trace("Invalid A* start or destination")
		return
	if(start.z != end.z || start == end ) //no pathfinding between z levels
		return
	if(max_distance && (max_distance < get_dist(start, end))) //if start turf is farther than max_distance from end turf, no need to do anything
		return

	//initialization
	var/datum/jps_node/current_processed_node = new (start, -1, 0, end)
	open.insert(current_processed_node)
	sources[start] = start // i'm sure this is fine

	//then run the main loop
	while(!open.is_empty() && !path)
		if(!caller)
			return
		current_processed_node = open.pop() //get the lower f_value turf in the open list
		if(max_distance && (current_processed_node.number_tiles > max_distance))//if too many steps, don't process that path
			continue

		var/turf/current_turf = current_processed_node.tile
		for(var/scan_direction in list(EAST, WEST, NORTH, SOUTH))
			lateral_scan_spec(current_turf, scan_direction, current_processed_node)

		for(var/scan_direction in list(NORTHEAST, SOUTHEAST, NORTHWEST, SOUTHWEST))
			diag_scan_spec(current_turf, scan_direction, current_processed_node)

		CHECK_TICK

	//we're done! reverse the path to get it from start to finish
	if(path)
		for(var/i = 1 to round(0.5 * length(path)))
			path.Swap(i, length(path) - i + 1)

	sources = null
	qdel(open)
	return path

/// Called when we've hit the goal with the node that represents the last tile, then sets the path var to that path so it can be returned by [datum/pathfind/proc/search]
/datum/pathfind/proc/unwind_path(datum/jps_node/unwind_node)
	path = new()
	var/turf/iter_turf = unwind_node.tile
	path.Add(iter_turf)

	while(unwind_node.previous_node)
		var/dir_goal = get_dir(iter_turf, unwind_node.previous_node.tile)
		for(var/i = 1 to unwind_node.jumps)
			iter_turf = get_step(iter_turf,dir_goal)
			path.Add(iter_turf)
		unwind_node = unwind_node.previous_node

/**
 * For performing lateral scans from a given starting turf.
 *
 * These scans are called from both the main search loop, as well as subscans for diagonal scans, and they treat finding interesting turfs slightly differently.
 * If we're doing a normal lateral scan, we already have a parent node supplied, so we just create the new node and immediately insert it into the heap, ezpz.
 * If we're part of a subscan, we still need for the diagonal scan to generate a parent node, so we return a node datum with just the turf and let the diag scan
 * proc handle transferring the values and inserting them into the heap.
 *
 * Arguments:
 * * original_turf: What turf did we start this scan at?
 * * heading: What direction are we going in? Obviously, should be cardinal
 * * parent_node: Only given for normal lateral scans, if we don't have one, we're a diagonal subscan.
*/
/datum/pathfind/proc/lateral_scan_spec(turf/original_turf, heading, datum/jps_node/parent_node)
	var/steps_taken = 0

	var/turf/current_turf = original_turf
	var/turf/lag_turf = original_turf

	while(TRUE)
		if(path)
			return
		lag_turf = current_turf
		current_turf = get_step(current_turf, heading)
		steps_taken++
		if(!CAN_STEP(lag_turf, current_turf))
			return
		for(var/turf/checked_turf as anything in turfs_to_avoid)
			if(istype(current_turf,checked_turf))
				return

		if(current_turf == end || (mintargetdist && (get_dist(current_turf, end) <= mintargetdist)))
			var/datum/jps_node/final_node = new(current_turf, parent_node, steps_taken)
			sources[current_turf] = original_turf
			if(parent_node) // if this is a direct lateral scan we can wrap up, if it's a subscan from a diag, we need to let the diag make their node first, then finish
				unwind_path(final_node)
			return final_node
		else if(sources[current_turf]) // already visited, essentially in the closed list
			return
		else
			sources[current_turf] = original_turf

		if(parent_node && parent_node.number_tiles + steps_taken > max_distance)
			return

		var/interesting = FALSE // have we found a forced neighbor that would make us add this turf to the open list?

		switch(heading)
			if(NORTH)
				if(STEP_NOT_HERE_BUT_THERE(current_turf, WEST, NORTHWEST) || STEP_NOT_HERE_BUT_THERE(current_turf, EAST, NORTHEAST))
					interesting = TRUE
			if(SOUTH)
				if(STEP_NOT_HERE_BUT_THERE(current_turf, WEST, SOUTHWEST) || STEP_NOT_HERE_BUT_THERE(current_turf, EAST, SOUTHEAST))
					interesting = TRUE
			if(EAST)
				if(STEP_NOT_HERE_BUT_THERE(current_turf, NORTH, NORTHEAST) || STEP_NOT_HERE_BUT_THERE(current_turf, SOUTH, SOUTHEAST))
					interesting = TRUE
			if(WEST)
				if(STEP_NOT_HERE_BUT_THERE(current_turf, NORTH, NORTHWEST) || STEP_NOT_HERE_BUT_THERE(current_turf, SOUTH, SOUTHWEST))
					interesting = TRUE

		if(interesting)
			var/datum/jps_node/newnode = new(current_turf, parent_node, steps_taken)
			if(parent_node) // if we're a diagonal subscan, we'll handle adding ourselves to the heap in the diag
				open.insert(newnode)
			return newnode

/**
 * For performing diagonal scans from a given starting turf.
 *
 * Unlike lateral scans, these only are called from the main search loop, so we don't need to worry about returning anything,
 * though we do need to handle the return values of our lateral subscans of course.
 *
 * Arguments:
 * * original_turf: What turf did we start this scan at?
 * * heading: What direction are we going in? Obviously, should be diagonal
 * * parent_node: We should always have a parent node for diagonals
*/
/datum/pathfind/proc/diag_scan_spec(turf/original_turf, heading, datum/jps_node/parent_node)
	var/steps_taken = 0
	var/turf/current_turf = original_turf
	var/turf/lag_turf = original_turf

	while(TRUE)
		if(path)
			return
		lag_turf = current_turf
		current_turf = get_step(current_turf, heading)
		steps_taken++
		if(!CAN_STEP(lag_turf, current_turf))
			return
		for(var/turf/checked_turf as anything in turfs_to_avoid)
			if(istype(current_turf,checked_turf))
				return

		if(current_turf == end || (mintargetdist && (get_dist(current_turf, end) <= mintargetdist)))
			var/datum/jps_node/final_node = new(current_turf, parent_node, steps_taken)
			sources[current_turf] = original_turf
			unwind_path(final_node)
			return
		else if(sources[current_turf]) // already visited, essentially in the closed list
			return
		else
			sources[current_turf] = original_turf

		if(parent_node.number_tiles + steps_taken > max_distance)
			return

		var/interesting = FALSE // have we found a forced neighbor that would make us add this turf to the open list?
		var/datum/jps_node/possible_child_node // otherwise, did one of our lateral subscans turn up something?

		switch(heading)
			if(NORTHWEST)
				if(STEP_NOT_HERE_BUT_THERE(current_turf, EAST, NORTHEAST) || STEP_NOT_HERE_BUT_THERE(current_turf, SOUTH, SOUTHWEST))
					interesting = TRUE
				else
					possible_child_node = (lateral_scan_spec(current_turf, WEST) || lateral_scan_spec(current_turf, NORTH))
			if(NORTHEAST)
				if(STEP_NOT_HERE_BUT_THERE(current_turf, WEST, NORTHWEST) || STEP_NOT_HERE_BUT_THERE(current_turf, SOUTH, SOUTHEAST))
					interesting = TRUE
				else
					possible_child_node = (lateral_scan_spec(current_turf, EAST) || lateral_scan_spec(current_turf, NORTH))
			if(SOUTHWEST)
				if(STEP_NOT_HERE_BUT_THERE(current_turf, EAST, SOUTHEAST) || STEP_NOT_HERE_BUT_THERE(current_turf, NORTH, NORTHWEST))
					interesting = TRUE
				else
					possible_child_node = (lateral_scan_spec(current_turf, SOUTH) || lateral_scan_spec(current_turf, WEST))
			if(SOUTHEAST)
				if(STEP_NOT_HERE_BUT_THERE(current_turf, WEST, SOUTHWEST) || STEP_NOT_HERE_BUT_THERE(current_turf, NORTH, NORTHEAST))
					interesting = TRUE
				else
					possible_child_node = (lateral_scan_spec(current_turf, SOUTH) || lateral_scan_spec(current_turf, EAST))

		if(interesting || possible_child_node)
			var/datum/jps_node/newnode = new(current_turf, parent_node, steps_taken)
			open.insert(newnode)
			if(possible_child_node)
				possible_child_node.update_parent(newnode)
				open.insert(possible_child_node)
				if(possible_child_node.tile == end || (mintargetdist && (get_dist(possible_child_node.tile, end) <= mintargetdist)))
					unwind_path(possible_child_node)
			return

/**
 * For seeing if we can actually move between 2 given turfs while accounting for our access and the caller's pass_flags
 *
 * Arguments:
 * * caller: The movable, if one exists, being used for mobility checks to see what tiles it can reach
 * * ID: An ID card that decides if we can gain access to doors that would otherwise block a turf
 * * simulated_only: Do we only worry about turfs with simulated atmos, most notably things that aren't space?
*/
/turf/proc/jps_LinkBlockedWithAccess(turf/destination_turf, caller, ID)
	var/actual_dir = get_dir(src, destination_turf)

	for(var/obj/structure/window/iter_window in src)
		if(!iter_window.CanAStarPass(ID, actual_dir))
			return TRUE

	for(var/obj/machinery/door/window/iter_windoor in src)
		if(!iter_windoor.CanAStarPass(ID, actual_dir))
			return TRUE

	var/reverse_dir = get_dir(destination_turf, src)
	for(var/obj/iter_object in destination_turf)
		if(!iter_object.CanAStarPass(ID, reverse_dir, caller))
			return TRUE

	return FALSE

#undef CAN_STEP
#undef STEP_NOT_HERE_BUT_THERE
//end path.dm

GLOBAL_LIST_EMPTY(knpcs)

/datum/component/knpc
	var/ai_trait = AI_AGGRESSIVE
	var/static/list/ai_goals = null
	var/datum/ai_goal/human/current_goal = null
	var/view_range = 8 //How good is this mob's "eyes"?
	var/guess_range = 12 //How far away will we assume they're still there after seeing them?
	var/list/last_aggressors = list()
	var/next_backup_call = 0 //Delay for calling for backup to avoid spam.
	var/list/path = list()
	var/turf/dest = null
	var/tries = 0 //How quickly do we give up on following a path? To avoid lag...
	var/max_tries = 10
	var/next_action = 0
	var/next_move = 0
	var/obj/effect/landmark/patrol_node/last_node = null //What was the last patrol node we visited?
	var/stealing_id = FALSE
	var/next_internals_attempt = 0
	var/static/list/climbable = typecacheof(list(/obj/structure/table, /obj/structure/railing)) // climbable structures
	var/pathfind_timeout = 0 //If pathfinding fails, it is püt in timeout for a while to avoid spamming the server with pathfinding calls.
	var/timeout_stacks = 0 //Consecutive pathfind fails add additional delay stacks to further counteract the effects of knpcs in unreachable locations.
	var/list/turfs_to_avoid = list(/turf/open/water/acid,/turf/open/lava)

/mob/living/carbon/human/ai_boarder
	faction = list("neutral")
	var/move_delay = 4 //How quickly do the boys travel?
	var/action_delay = 6 //How long we delay between actions
	var/knpc_traits = KNPC_IS_DODGER | KNPC_IS_MERCIFUL | KNPC_IS_AREA_SPECIFIC
	var/difficulty = KNPC_DIFFICULTY_HARD //Whether to ignore overmap difficulty or not
	var/list/outfit = list (
		/datum/outfit/job/assistant
	)
	var/list/taunts = list("Engaging the enemy!")
	var/list/call_lines = list("Enemy spotted!")
	var/list/response_lines = list("On my way!")

	var/shut_up = TRUE

/mob/living/carbon/human/ai_boarder/Initialize(mapload)
	. = ..()
	randomize_human(src)
	var/outfit_path = pick(outfit)
	var/datum/outfit/O = new outfit_path
	O.equip(src)
	AddComponent(/datum/component/knpc)

/mob/living/carbon/human/ai_boarder/frontier
	faction = list("frontier")
	outfit = list (/datum/outfit/frontier)

/mob/living/carbon/human/ai_boarder/hermit
	faction = list("hermit")
	taunts = list("...")
	call_lines = list("...!!!")
	response_lines = list("!")

	knpc_traits = KNPC_IS_DODGER | KNPC_IS_MERCIFUL

	outfit = list (/datum/outfit/whitesands)

	var/survivor_type

/mob/living/carbon/human/ai_boarder/hermit/survivor
	survivor_type = "survivor"

/mob/living/carbon/human/ai_boarder/hermit/hunter
	survivor_type = "hunter"

/mob/living/carbon/human/ai_boarder/hermit/gunslinger
	survivor_type = "gunslinger"

/mob/living/carbon/human/ai_boarder/hermit/commando
	survivor_type = "commando"

/mob/living/carbon/human/ai_boarder/hermit/Initialize(mapload)
	if(!survivor_type)
		survivor_type = pick("survivor","hunter","gunslinger")
	..()
	for(var/obj/item/gun/searching as obj in contents)
		if(istype(searching, /obj/item/gun))
			searching.safety = FALSE

	var/mob_species = pickweight(list(
			/datum/species/human = 50,
			/datum/species/lizard = 25,
			/datum/species/elzuose = 10,
			/datum/species/moth = 10,
			/datum/species/spider = 3,
			/datum/species/fly = 2
			)
		)
	INVOKE_ASYNC(src, PROC_REF(set_species), mob_species)

	var/obj/item/clothing/suit/hooded/survivor_hood = wear_suit
	if(survivor_hood)
		survivor_hood.ToggleHood()

/datum/outfit/whitesands/pre_equip(mob/living/carbon/human/H, visualsOnly)
	var/mob/living/carbon/human/ai_boarder/hermit/hermit = H
	var/survivor_type = hermit.survivor_type
	var/picked
	//to-do: learn how to make mobsprites for other survivors
		//w_uniforms are random to show varied backgrounds, but similar goal
	if(survivor_type == "survivor")
		picked = pickweight(list(
			/obj/item/clothing/under/color/random = 65,
			/obj/item/clothing/under/rank/cargo/miner/lavaland = 10,
			/obj/item/clothing/under/rank/prisoner = 10,
			/obj/item/clothing/under/rank/cargo/miner/lavaland/old = 5,
			/obj/item/clothing/under/color/khaki/buster = 5,
			/obj/item/clothing/under/rank/cargo/miner = 5
			)
		)
	else if (survivor_type == "hunter")
		picked = pickweight(list(
			/obj/item/clothing/under/color/random = 50,
			/obj/item/clothing/under/rank/cargo/miner/lavaland = 25,
			/obj/item/clothing/under/rank/cargo/miner/lavaland/old = 15,
			/obj/item/clothing/under/rank/security/officer/camo = 5,
			/obj/item/clothing/under/utility = 5
			)
		)
	else if (survivor_type == "gunslinger" || survivor_type == "commando")
		picked = pickweight(list(
			/obj/item/clothing/under/rank/cargo/miner/lavaland = 35,
			/obj/item/clothing/under/color/random = 25,
			/obj/item/clothing/under/rank/cargo/miner/lavaland/old = 15,
			/obj/item/clothing/under/rank/security/officer/camo = 10,
			/obj/item/clothing/under/syndicate/camo = 10,
			/obj/item/clothing/under/syndicate/combat = 5
			)
		)
	else
		picked = /obj/item/clothing/under/color/random

	uniform = picked

	//storage is semi-randomized, giving some variety
	if(survivor_type == "survivor")
		picked = 	pickweight(list(
			/obj/item/storage/belt/fannypack = 40,
			/obj/item/storage/belt/mining = 20,
			/obj/item/storage/belt/mining/alt = 15,
			/obj/item/storage/belt/utility = 10,
			/obj/item/storage/belt/bandolier = 9,
			/obj/item/storage/belt/utility/full = 5,
			/obj/item/storage/belt/chameleon= 1,
			)
		)
	else if(survivor_type == "hunter")
		picked = 	pickweight(list(
			/obj/item/storage/belt/mining = 30,
			/obj/item/storage/belt/fannypack = 20,
			/obj/item/storage/belt/mining/alt = 15,
			/obj/item/storage/belt/mining/primitive = 15,
			/obj/item/storage/belt/bandolier = 10,
			/obj/item/storage/belt/military = 7,
			/obj/item/storage/belt/mining/vendor = 3,
			)
		)
	else if(survivor_type == "gunslinger" || survivor_type == "commando")
		picked = pickweight(list(
			/obj/item/storage/belt/mining = 30,
			/obj/item/storage/belt/bandolier = 30,
			/obj/item/storage/belt/military = 20,
			/obj/item/storage/belt/fannypack = 15,
			/obj/item/storage/belt/mining/alt = 5,
			/obj/item/storage/belt/mining/primitive = 5
			)
		)
	else
		picked = /obj/item/storage/belt/fannypack

	belt = picked

	//everyone wears the same suit
	suit = /obj/item/clothing/suit/hooded/survivor

	if (survivor_type == "gunslinger" || survivor_type == "commando")
		if(prob(30))
			picked = /obj/item/clothing/shoes/combat //but sometimes there are nicer shoes
		else
			picked = /obj/item/clothing/shoes/workboots/mining
	else
		picked = /obj/item/clothing/shoes/workboots/mining

	shoes = picked

	//gloves are a tossup
	picked = pickweight(list(
			/obj/item/clothing/gloves/color/black = 60,
			/obj/item/clothing/gloves/explorer = 30,
			/obj/item/clothing/gloves/explorer/old = 10
			)
		)

	gloves = picked

	//bags are semi-random.
	picked = pickweight(list(
			/obj/item/storage/backpack = 20,
			/obj/item/storage/backpack/explorer = 20,
			/obj/item/storage/backpack/satchel = 20,
			/obj/item/storage/backpack/satchel/explorer = 20,
			/obj/item/storage/backpack/messenger = 20
			)
		)

	back = picked

	//as are bag contents

	backpack_contents = list()
	backpack_contents += pickweight(list( //fallback in case of no weapons
		/obj/item/wrench = 10,
		/obj/item/crowbar = 15,
		/obj/item/screwdriver = 5,
		/obj/item/wirecutters = 10,
		/obj/item/scalpel = 5,
		/obj/item/flashlight/seclite = 10,
		))
	if(prob(70))
		backpack_contents += pickweight(list( //these could stand to be expanded, right now they're just mildly modified miner ones, and I don't know how to plus that up.
			/obj/item/soap = 10,
			/obj/item/stack/marker_beacon/ten = 15,
			/obj/item/mining_scanner = 5,
			/obj/item/extinguisher/mini = 10,
			/obj/item/kitchen/knife/combat = 5,
			/obj/item/flashlight/seclite = 10,
			/obj/item/stack/sheet/sinew = 10,
			/obj/item/stack/sheet/bone = 5,
			/obj/item/stack/sheet/animalhide/goliath_hide = 10,
			/obj/item/stack/sheet/bone = 8,
			/obj/item/reagent_containers/food/drinks/waterbottle = 10,
			/obj/item/reagent_containers/food/drinks/waterbottle/empty = 2,
			)
		)
	if(prob(70))
		backpack_contents += pickweight(list(
			/obj/item/stack/sheet/animalhide/goliath_hide = 20,
			/obj/item/stack/marker_beacon/ten = 10,
			/obj/item/mining_scanner = 20,
			/obj/item/extinguisher/mini = 10,
			/obj/item/kitchen/knife/combat/survival = 10,
			/obj/item/flashlight/seclite = 10,
			/obj/item/stack/sheet/sinew = 10,
			/obj/item/stack/sheet/bone = 10
			)
		)
	if(prob(70))
		backpack_contents += pickweight(list(
			/obj/item/stack/sheet/animalhide/goliath_hide = 5,
			/obj/item/stack/marker_beacon/ten = 5,
			/obj/item/mining_scanner = 5,
			/obj/item/extinguisher/mini = 10,
			/obj/item/kitchen/knife/combat/survival = 12,
			/obj/item/flashlight/seclite = 10,
			/obj/item/stack/sheet/sinew = 5,
			/obj/item/stack/sheet/bone = 5,
			/obj/item/kitchen/knife/combat = 3,
			/obj/item/reagent_containers/food/snacks/rationpack = 30
			)
		)
	if (prob(25)) //mayhaps a medkit
		backpack_contents += pickweight(list(
			/obj/item/storage/firstaid/regular = 50,
			/obj/item/storage/firstaid/brute = 15,
			/obj/item/storage/firstaid/medical = 15,
			/obj/item/storage/firstaid/fire = 10,
			/obj/item/storage/firstaid/advanced = 5,
			/obj/item/storage/firstaid/ancient = 5
			)
		)
	if(prob(30)) //some pens maybe?
		backpack_contents += /obj/item/reagent_containers/hypospray/medipen/survival
	if(prob(5))
		backpack_contents += /obj/item/reagent_containers/hypospray/medipen/survival

	//pockets
	if(survivor_type == "survivor") //could also use fleshing out
		if(prob(30))
			l_pocket = /obj/item/reagent_containers/food/snacks/meat/steak/goliath
		else
			l_pocket = /obj/item/tank/internals/emergency_oxygen/engi

	if(survivor_type == "hunter")
		l_pocket = /obj/item/tank/internals/emergency_oxygen/double
		if (prob(20))
			l_pocket = /obj/item/reagent_containers/food/snacks/meat/steak/goliath

	if(survivor_type == "gunslinger" || survivor_type == "commando")
		if(prob(50))
			l_pocket = /obj/item/ammo_box/magazine/skm_545_39
		r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	else
		r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
		l_pocket = /obj/item/radio

	//masks
	picked = pickweight(list(
		/obj/item/clothing/mask/gas = 40,
		/obj/item/clothing/mask/gas/explorer = 20,
		/obj/item/clothing/mask/gas/explorer/old = 20,
		/obj/item/clothing/mask/gas/syndicate = 20,
		/obj/item/clothing/mask/breath = 5,
		/obj/item/clothing/mask/breath/medical = 5,
		/obj/item/clothing/mask/breath/suns = 5,
		/obj/item/clothing/mask/gas/sechailer = 10,
		/obj/item/clothing/mask/gas/sechailer/balaclava = 10,
		/obj/item/clothing/mask/gas/sechailer/balaclava/inteq = 10,
		/obj/item/clothing/mask/gas/sechailer/swat = 1,
		/obj/item/clothing/mask/gas/sechailer/swat/spacepol = 1,
		)
	)

	mask = picked

	//the eyes are the window into the soul. I don't think these things have souls but whatever.
	if(prob(70))
		picked = pickweight(list(
			/obj/item/clothing/glasses/heat = 20,
			/obj/item/clothing/glasses/cold = 20,
			/obj/item/clothing/glasses/meson = 40,
			/obj/item/clothing/glasses = 20
			)
		)
		glasses = picked
	else
		glasses = null

	//and of course, ears.
	if(prob(1)) //oh my god they can't hear the sandstorm coming they've got airpods in
		picked = /obj/item/instrument/piano_synth/headphones/spacepods
	else
		picked = pickweight(list(
			/obj/item/radio/headset = 50,
			/obj/item/radio/headset/alt = 50
			)
		)
	ears = picked

	//exosuit bits
	suit_store = null
	var/spare_ammo_count = rand(1,2)

	if (survivor_type == "hunter")
		r_hand = /obj/item/gun/ballistic/rifle/polymer
		spare_ammo_count = rand(2,5)
		for(var/i in 1 to spare_ammo_count)
			backpack_contents += /obj/item/ammo_box/a762_stripper

	if(survivor_type == "gunslinger" || survivor_type == "commando")
		if(prob(7) || survivor_type == "commando") //cause fuck you, thats why
			uniform = /obj/item/clothing/under/rank/security/officer/camo

			suit =	pickweight(list(
				/obj/item/clothing/suit/armor/vest/bulletproof = 35,
				/obj/item/clothing/suit/armor/vest/syndie = 20,
				/obj/item/clothing/suit/armor/gezena = 20,
				/obj/item/clothing/suit/armor/vest/marine = 1,
				/obj/item/clothing/suit/armor/vest/marine/heavy = 1,
				/obj/item/clothing/suit/armor/vest/marine = 1,
			))
			head =	pickweight(list(
				/obj/item/clothing/head/helmet/bulletproof/x11 = 40,
				/obj/item/clothing/head/helmet/bulletproof/m10 = 40,

				/obj/item/clothing/head/helmet/swat = 20,
				/obj/item/clothing/head/helmet/swat/nanotrasen = 20,
				/obj/item/clothing/head/helmet/gezena = 20,

				/obj/item/clothing/head/helmet/marine = 1,
				/obj/item/clothing/head/helmet/marine/security = 1,
			))
			spare_ammo_count = rand(2,3)
			if(prob(10))
				r_hand = /obj/item/gun/ballistic/automatic/hmg/skm_lmg/drum_mag //hell
			else
				r_hand = /obj/item/gun/ballistic/automatic/assault/skm/pirate
			for(var/i in 1 to spare_ammo_count)
				if(prob(5))
					backpack_contents += /obj/item/ammo_box/magazine/skm_762_40/drum //die.
				else if(prob(20))
					backpack_contents += /obj/item/ammo_box/magazine/skm_762_40/extended
				else
					backpack_contents += /obj/item/ammo_box/magazine/skm_762_40
		else
			picked = pickweight(list(
				/obj/item/gun/ballistic/automatic/smg/skm_carbine = 70,
				/obj/item/gun/ballistic/automatic/pistol/spitter = 20,
				/obj/item/gun/ballistic/automatic/smg/pounder = 4,
				/obj/item/gun/ballistic/automatic/smg/firestorm = 4,
				/obj/item/gun/ballistic/automatic/smg/vector = 4,
				/obj/item/gun/ballistic/automatic/smg/cm5 = 4,
				/obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq = 4,
				/obj/item/gun/ballistic/automatic/smg/c20r/cobra = 4,
				/obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq/proto = 4,
				/obj/item/gun/ballistic/automatic/pistol/APS = 4,
				/obj/item/gun/ballistic/automatic/pistol/mauler = 4,
				))
			r_hand = picked
			var/obj/item/gun/ballistic/current_gun = picked
			for(var/i in 1 to spare_ammo_count)
				backpack_contents += current_gun.mag_type

	internals_slot = ITEM_SLOT_RPOCKET

/datum/component/knpc/Initialize()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	if(!ai_goals)
		for(var/gtype in subtypesof(/datum/ai_goal/human))
			LAZYADD(ai_goals, new gtype)
	START_PROCESSING(SSfastprocess, src)
	//They're alive!
	GLOB.knpcs.Add(src)
	RegisterSignal(parent, COMSIG_LIVING_REVIVE, PROC_REF(restart))
	RegisterSignal(parent, COMSIG_ATOM_BULLET_ACT, PROC_REF(register_bullet))

//Swiper! no swiping
/datum/component/knpc/proc/steal_id(obj/item/card/id/their_id)
	//Time to teach them about IDs :)))
	stealing_id = FALSE
	var/mob/living/carbon/human/H = parent
	if(get_dist(H, their_id.loc) > 1)
		return FALSE
	var/obj/item/card/id/ID = H.get_idcard()
	if(ID)
		if(istype(ID, /obj/item/card/id/))
			their_id.forceMove(get_turf(H))
			H.visible_message("<span class='warning'>[H] snatches [their_id]. </span>")
			ID.access |= their_id.access
	else
		H.put_in_inactive_hand(their_id)
		if(H.equip_to_appropriate_slot(their_id))
			H.update_inv_hands()
			return TRUE

/datum/component/knpc/Destroy(force, silent)
	GLOB.knpcs -= src
	return ..()

/datum/component/knpc/proc/pathfind_to(atom/target, turf/avoid)
	if(pathfind_timeout > 0)
		return KNPC_PATHFIND_TIMEOUT
	var/mob/living/carbon/human/ai_boarder/H = parent
	if(target == null)
		path = list()
		dest = null
		return KNPC_PATHFIND_SKIP
	if((dest && dest == get_turf(target) && length(path)) || H.incapacitated())
		return KNPC_PATHFIND_SKIP //No need to recalculate this path.
	path = list()
	dest = null
	var/obj/item/card/id/access_card = H.wear_id
	if(target)
		dest = get_turf(target)
		path = jps_get_path_to(H, dest, 120, 0, access_card, !(H.wear_suit?.clothing_flags & STOPSPRESSUREDAMAGE && H.head?.clothing_flags & STOPSPRESSUREDAMAGE), avoid)
	//There's no valid path, try run against the wall.
	if(!length(path) && !H.incapacitated())
		pathfind_timeout += KNPC_TIMEOUT_BASE * (1 + timeout_stacks)
		timeout_stacks = min(timeout_stacks+1, KNPC_TIMEOUT_STACK_CAP)
		return KNPC_PATHFIND_FAIL
	timeout_stacks = 0
	return KNPC_PATHFIND_SUCCESS

/datum/component/knpc/proc/next_path_step()
	if(world.time < next_move)
		return FALSE
	var/mob/living/carbon/human/ai_boarder/H = parent
	next_move = world.time + H.move_delay
	if(H.incapacitated() || H.stat == DEAD)
		return FALSE
	if(pathfind_timeout > 0) //Pathfinding in timeout, move around aimlessly
		H.set_resting(FALSE, FALSE)
		var/turf/new_pos = get_step(H,pick(GLOB.cardinals))
		for(var/turf/checked_turf as anything in turfs_to_avoid)
			if(istype(new_pos,checked_turf))
				return FALSE
		H.Move(new_pos)
		return FALSE
	if(!path)
		return FALSE
	if(tries > 5)
		//Add a bit of randomness to their movement to reduce "traffic jams"
		var/turf/new_pos = get_step(H,pick(GLOB.cardinals))
		for(var/turf/checked_turf as anything in turfs_to_avoid)
			if(istype(new_pos,checked_turf))
				return FALSE
		H.Move(new_pos)
		if(prob(10))
			H.toggle_resting()
			return FALSE

	if(tries >= max_tries)
		tries = 0
		if(length(last_node?.next_nodes)) //Skip this one.
			pathfind_to(pick(last_node.next_nodes))
		else
			pathfind_to(null)
		last_node = null //Reset pathfinding fully.
		return FALSE
	if(length(path) > 1)
		var/turf/next_turf = get_step_towards(H, path[1])
		var/turf/this_turf = get_turf(H)
		//Walk when you see a wet floor
		if(next_turf.GetComponent(/datum/component/wet_floor))
			H.m_intent = MOVE_INTENT_WALK
		else
			H.m_intent = MOVE_INTENT_RUN

		for(var/obj/machinery/door/firedoor/blocking_firelock in next_turf)
			if((blocking_firelock.flags_1 & ON_BORDER_1) && !(blocking_firelock.dir in dir_to_cardinal_dirs(get_dir(next_turf, this_turf))))
				continue
			if(!blocking_firelock.density || blocking_firelock.operating)
				continue
			if(blocking_firelock.welded)
				break	//If at least one firedoor in our way is welded shut, welp!
			blocking_firelock.open()	//Open one firelock per tile per try.
			break
		for(var/obj/machinery/door/firedoor/blocking_firelock in this_turf)
			if(!((blocking_firelock.flags_1 & ON_BORDER_1) && (blocking_firelock.dir in dir_to_cardinal_dirs(get_dir(this_turf, next_turf))))) //Here, only firelocks on the border matter since fulltile firelocks let you exit.
				continue
			if(!blocking_firelock.density || blocking_firelock.operating)
				continue
			if(blocking_firelock.welded)
				break	//If at least one firedoor in our way is welded shut, welp!
			blocking_firelock.open()	//Open one firelock per tile per try.
			break
		for(var/obj/structure/possible_barrier in next_turf) //If we're stuck
			if(!climbable.Find(possible_barrier.type))
				continue
			H.forceMove(next_turf)
			H.visible_message("<span class='warning'>[H] climbs onto [possible_barrier]!</span>")
			H.Stun(2 SECONDS) //Table.
			if(get_turf(H) == path[1])
				increment_path()
			return TRUE
		step_towards(H, path[1])
		if(get_turf(H) == path[1]) //Successful move
			increment_path()
			tries = 0
			if(H.resting)
				//Gotta bypass the do-after here...
				H.set_resting(FALSE, FALSE)
		else
			tries++
			return FALSE
	else if(length(path) == 1)
		step_to(H, dest)
		pathfind_to(null)
	return TRUE

/datum/component/knpc/proc/increment_path()
	path.Cut(1, 2)

///Allows the AI humans to kite around
/datum/component/knpc/proc/kite(atom/movable/target)
	if(world.time < next_move)
		return
	var/mob/living/carbon/human/ai_boarder/H = parent
	next_move = world.time + (H.move_delay * 2)
	if(!target || !isturf(target.loc) || !isturf(H.loc) || H.stat == DEAD)
		return
	var/target_dir = get_dir(H,target)
	var/static/list/cardinal_sidestep_directions = list(-90,-45,0,45,90)
	var/static/list/diagonal_sidestep_directions = list(-45,0,45)
	var/chosen_dir = 0
	if (target_dir & (target_dir - 1))
		chosen_dir = pick(diagonal_sidestep_directions)
	else
		chosen_dir = pick(cardinal_sidestep_directions)
	if(chosen_dir)
		chosen_dir = turn(target_dir,chosen_dir)
		var/turf/new_pos = get_step(H,chosen_dir)
		for(var/turf/checked_turf as anything in turfs_to_avoid)
			if(istype(new_pos,checked_turf))
				return FALSE
		H.Move(new_pos)
		H.face_atom(target) //Looks better if they keep looking at you when dodging

///Allows the AI actor to be revived by a medic, and get straight back into the fight!
/datum/component/knpc/proc/restart()
	SIGNAL_HANDLER
	START_PROCESSING(SSfastprocess, src)

///Pick a goal from the available goals!
/datum/component/knpc/proc/pick_goal()
	var/best_score = -1000
	var/datum/ai_goal/chosen = null
	for(var/datum/ai_goal/human/H in ai_goals)
		var/this_score = H.check_score(src)
		if(this_score > best_score)
			chosen = H
			best_score = this_score
	if(chosen)
		chosen.assume(src)

///Add someone to our threat list when they shoot us. Shamelessly lifted from monkey AI code.
/datum/component/knpc/proc/register_bullet(datum/source, obj/projectile/Proj)
	SIGNAL_HANDLER
	if(istype(Proj , /obj/projectile/beam)||istype(Proj, /obj/projectile/bullet))
		if((Proj.damage_type == BURN) || (Proj.damage_type == BRUTE))
			if(!Proj.nodamage && isliving(Proj.firer))
				last_aggressors += Proj.firer

///Handles actioning on the goal every tick.
/datum/component/knpc/process()
	var/mob/living/carbon/human/ai_boarder/H = parent
	if(H.stat == DEAD)
		return PROCESS_KILL
	if(!H.can_resist())
		if(H.incapacitated()) //In crit or something....
			return
	if(world.time >= next_action)
		next_action = world.time + H.action_delay
		pick_goal()
		current_goal?.action(src)
	if(length(path))
		next_path_step()
	else //They should always be pathing somewhere...
		dest = null
		tries = 0
		path = list()
		last_node = null
		current_goal?.get_next_patrol_node(src)
	pathfind_timeout = max(0, pathfind_timeout - 1)

/datum/ai_goal
	var/name = "Placeholder goal" //Please keep these human readable for debugging!
	var/score = 0
	var/required_ai_flags = NONE //Set this if you want this task to only be achievable by certain types of ship. This is a bitfield.

//Method to get the score of a certain action. This can change the "base" score if the score of a specific action goes up, to encourage skynet to go for that one instead.
//@param OM - If you want this score to be affected by the stats of an overmap.
/datum/ai_goal/proc/check_score()
	return FALSE

//Delete the AI's last orders, tell the AI ship what to do.
/datum/ai_goal/proc/assume()
	return FALSE

/datum/ai_goal/proc/action()
	return FALSE

/datum/ai_goal/human
	name = "Placeholder goal" //Please keep these human readable for debugging!
	score = 0
	required_ai_flags = null //Set this if you want this task to only be achievable by certain types of ship.

/**
Method to get the score of a certain action. This can change the "base" score if the score
of a specific action goes up, to encourage skynet to go for that one instead.

@param OM - If you want this score to be affected by the stats of an overmap.
*/
/datum/ai_goal/check_score(datum/component/knpc/HA)
	if(!istype(HA)) // why is this here >:(
		return ..()
	if(required_ai_flags && !(HA.ai_trait & required_ai_flags))
		return 0
	var/mob/M = HA.parent
	if(M.client) //AI disabled...
		return 0
	return score //Children sometimes NEED this true value to run their own checks. We also cancel here if the mob has been overtaken by someone.

///Delete the AI's last orders, tell the AI ship what to do.
/datum/ai_goal/human/assume(datum/component/knpc/HA)
	//message_admins("Goal [src] chosen!")
	HA.current_goal = src

///Method that gets all the potential aggressors for this target.
/datum/ai_goal/proc/get_aggressors(datum/component/knpc/HA)
	. = list()
	var/mob/living/carbon/human/ai_boarder/H = HA.parent
	var/list/detected_objects = view(HA.view_range, HA.parent)
	var/list/guessed_objects = view(HA.guess_range, HA.parent)
	for(var/mob/living/M in guessed_objects)
		//Invis is a no go. Non-human, -cyborg or -hostile mobs are ignored.
		if(M.invisibility >= INVISIBILITY_ABSTRACT || M.alpha <= 0 || (!ishuman(M) && !iscyborg(M) && !ishostile(M)))
			continue
		// Dead mobs are ignored.
		if(H.knpc_traits & KNPC_IS_MERCIFUL && M.stat >= UNCONSCIOUS)
			continue
		else if(M.stat == DEAD)
			continue
		if(H.faction_check_mob(M))
			continue
		if(!(M in detected_objects) && !(M in HA.last_aggressors))
			continue
		. += M
	//Check for nearby mechas....
	if(length(GLOB.mechas_list))
		for(var/obj/mecha/OM as() in GLOB.mechas_list)
			if(OM.z != H.z)
				continue
			if(get_dist(H, OM) > HA.view_range || !can_see(H, OM, HA.view_range))
				continue
			if(OM.occupant && !H.faction_check_mob(OM.occupant))
				. += OM.occupant

///What happens when this action is selected? You'll override this and check_score mostly.
/datum/ai_goal/human/action(datum/component/knpc/HA)
	var/mob/living/carbon/human/H = HA.parent
	if(H.incapacitated() || H.client) //An admin overtook this mob or something, ignore.
		return FALSE

/datum/ai_goal/human/proc/can_action(datum/component/knpc/HA)
	var/mob/living/carbon/human/H = HA.parent
	return (!H.incapacitated() && !H.client) //An admin overtook this mob or something, ignore.

/**
Goal #1, get a weapon!
If we don't have a weapon, we really ought to grab one...
This is to account for sec Ju-Jitsuing boarding commandos.
*/
/datum/ai_goal/human/acquire_weapon
	name = "Acquire Weapon" //Please keep these human readable for debugging!
	score = AI_SCORE_PRIORITY //Fighting takes priority
	required_ai_flags = null //Set this if you want this task to only be achievable by certain types of ship.

/datum/ai_goal/human/acquire_weapon/check_score(datum/component/knpc/HA)
	if(!..())
		return 0
	var/mob/living/carbon/human/H = HA.parent
	var/obj/item/gun/G = H.get_active_held_item()
	//We already have a gun
	if(G && istype(G))
		return 0
	var/obj/item/gun/G_New = locate(/obj/item/gun) in oview(HA.view_range, H)
	if(G_New && gun_suitable(H, G_New))
		G_New.safety = FALSE
		return AI_SCORE_CRITICAL //There is a gun really obviously in the open....
	return score

/datum/ai_goal/human/proc/CheckFriendlyFire(mob/living/us, mob/living/them)
	for(var/turf/T as() in getline(us,them)) // Not 100% reliable but this is faster than simulating actual trajectory
		for(var/mob/living/L in T)
			if(L == us || L == them)
				continue
			if(us.faction_check_mob(L))
				return TRUE

/datum/ai_goal/human/acquire_weapon/action(datum/component/knpc/HA)
	if(!can_action(HA))
		return
	var/mob/living/carbon/human/H = HA.parent
	var/obj/item/storage/S = H.back
	var/obj/item/gun/target_item = null
	var/obj/item/A = H.get_active_held_item()
	//Okay first off, is the gun already on our person?
	if(S)
		var/list/expanded_contents = S.contents + H.contents
		target_item = locate(/obj/item/gun) in expanded_contents

		if(target_item)
			H.visible_message("<span class='notice'>[H] rummages around in their backpack...</span>")
			target_item.forceMove(get_turf(H)) //Put it on the floor so they can grab it
			if(A)
				if(!S)
					A.forceMove(get_turf(H))
				else
					A.forceMove(S)
			if(H.put_in_hands(target_item))
				return TRUE //We're done!
	//Now we run the more expensive check to find a gun laying on the ground.
	var/best_distance = world.maxx
	for(var/obj/O in oview(HA.view_range, H))
		var/dist = get_dist(O, H)
		if(istype(O, /obj/structure/closet) && dist <= best_distance)
			var/obj/structure/closet/C = O
			var/obj/item/gun/G = locate(/obj/item/gun) in C.contents
			if(G && C.allowed(H) && gun_suitable(H, G))
				target_item = G
				best_distance = dist
		if(istype(O, /obj/item/gun) && dist <= best_distance)
			var/obj/item/gun/G = O
			if(G && gun_suitable(H, G))
				target_item = O
				best_distance = dist
	if(target_item)
		var/dist = get_dist(H, target_item)
		if(dist > 1)
			HA.pathfind_to(target_item)
		else
			if(istype(target_item.loc, /obj/structure/closet))
				var/obj/structure/closet/C = target_item.loc
				if(C.open(H))
					H.visible_message("<span class='notice'>[H] pops open [C]...</span>")
			if(A)
				if(!S)
					A.forceMove(get_turf(H))
				else
					A.forceMove(S)
			if(istype(target_item, /obj/item/gun/ballistic))
				var/obj/item/gun/ballistic/B = target_item
				var/obj/item/ammo_box/magazine/M = locate(B.mag_type) in oview(3, target_item)
				if(M && S) //If they have a backpack, put the ammo in the backpack.
					H.put_in_hands(M)
					M.forceMove(S)

			if(H.put_in_hands(target_item))
				H.visible_message("<span class='warning'>[H] grabs [target_item]!</span>")

///Checks that G exists, has ammo and that H can fire it. Returns G if yes, FALSE otherwise.
/datum/ai_goal/human/acquire_weapon/proc/gun_suitable(mob/living/carbon/human/H, obj/item/gun/G)
	G.safety = FALSE
	return G.can_shoot() && G.can_trigger_gun(H)


/datum/ai_goal/human/engage_targets
	name = "Engage targets"
	score = AI_SCORE_SUPERPRIORITY //If we find a target, we want to engage!
	required_ai_flags = null

/datum/ai_goal/human/engage_targets/check_score(datum/component/knpc/HA)
	if(!..())
		return 0
	var/list/enemies = get_aggressors(HA)
	HA.last_aggressors = enemies
	//We have people to fight
	if(length(enemies) >= 1)
		return score
	return 0 //You can still fight with your bare hands...

/datum/ai_goal/human/proc/reload(datum/component/knpc/HA, obj/item/gun)
	var/mob/living/carbon/human/ai_boarder/H = HA.parent
	if(istype(gun, /obj/item/gun/energy))
		var/obj/item/gun/energy/E = gun
		if(E.selfcharge) //Okay good, it self charges we can just wait.
			return TRUE
		else //Discard it, we're not gonna teach them to use rechargers yet.
			E.forceMove(get_turf(H))
		return FALSE
	if(istype(gun, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/B = gun
		if(istype(B.mag_type, /obj/item/ammo_box/magazine/internal))
			if(!istype(B, /obj/item/gun/ballistic/rifle/polymer) || !istype(B, /obj/item/gun/ballistic/rifle/illestren))
				//Not dealing with this. They'll just ditch the revolver when they're done with it.
				B.forceMove(get_turf(H))
				return FALSE
		///message_admins("Issa gun")
		var/obj/item/storage/S = H.back
		//Okay first off, is the gun already on our person?
		var/list/expanded_contents = H.contents
		if(S)
			expanded_contents = S.contents + H.contents
		var/obj/item/ammo_box/target_mag = locate(B.mag_type) in expanded_contents
		if(istype(B, /obj/item/gun/ballistic/rifle/polymer))
			target_mag = locate(/obj/item/ammo_box/a762_stripper) in expanded_contents
		if(istype(B, /obj/item/gun/ballistic/rifle))
			if(!B.bolt_locked)
				B.rack(H)
				return TRUE
		//message_admins("Found [target_mag]")
		if(target_mag)
			if(istype(B, /obj/item/gun/ballistic/rifle/polymer))
				H.put_in_inactive_hand(target_mag)
				B.attackby(target_mag, H)
				target_mag.forceMove(get_turf(H))
				B.rack(H) //Rack the bolt.
			else
				//Dump that old mag
				H.put_in_inactive_hand(target_mag)
				B?.magazine?.forceMove(get_turf(H))
				B.attackby(target_mag, H)
				B.rack(H) //Rack the bolt.
//				addtimer(CALLBACK(B, PROC_REF(rack), H), 0.5 SECONDS, TIMER_UNIQUE)
		else
			if(!S)
				gun.forceMove(get_turf(H))
				return FALSE
			gun.forceMove(S)

/datum/ai_goal/human/engage_targets/proc/check_ammo(obj/item/gun/ballistic/B = null)
	if(!B)
		return FALSE
	if(!B.magazine)
		return FALSE
	if(!B.magazine.stored_ammo.len)
		return FALSE
	return TRUE


/datum/ai_goal/human/engage_targets/action(datum/component/knpc/HA)
	if(!can_action(HA))
		return
	HA.last_node = null //Reset their pathfinding
	var/mob/living/carbon/human/ai_boarder/H = HA.parent
	var/list/enemies = get_aggressors(HA)
	var/obj/item/A = H.get_active_held_item()
	var/closest_dist = 1000
	var/just_racked = FALSE
	var/mob/living/target = null
	for(var/mob/living/L as() in enemies)
		var/dist = get_dist(L, H)
		if(dist < closest_dist)
			closest_dist = dist
			target = L
	if(!target)
		return
	var/dist = get_dist(H, target)
	//We're holding a gun. See if we can shoot it....
	HA.pathfind_to(target) //Walk up close and YEET SLAM
	var/obj/item/gun/G = null
	if(istype(A, /obj/item/gun))
		G = A
	if(iscarbon(target) || !(G && get_dist(target, H) < 3))
		HA.pathfind_to(target) //Walk up close and YEET SLAM
	else
		HA.dest = null
	var/obj/item/gun/ballistic/B = null
	if(istype(A, /obj/item/gun/ballistic))
		B = A
	H.a_intent = (prob(65)) ? INTENT_HARM : INTENT_DISARM
	if(G)
		G.safety = FALSE
	if(G && dist > 0 && !istype(target, /mob/living/simple_animal/hostile/asteroid/basilisk/whitesands))
		if(!G.can_shoot() || !G?.chambered.BB)
			if(istype(B, /obj/item/gun/ballistic/rifle) && check_ammo(B))
				B.rack(H)
				just_racked = TRUE
			else
				G.safety = FALSE
				if(!G.can_shoot() || !G?.chambered.BB) //still cant shoot?
					//We need to reload first....
					reload(HA, G)
					just_racked = TRUE
		//Fire! If they're in a ship, we don't want to scrap them directly.
		if(!CheckFriendlyFire(H, target))
			//Okay, we have a line of sight, shoot!
			if(B && !(B.semi_auto) && !G.chambered)
				//Pump the shotty
				G.attack_self(H)
			//Let's help them use E-Guns....
			if(istype(G, /obj/item/gun/energy/e_gun))
				var/obj/item/gun/energy/e_gun/E = G
				if(prob(20))
					E.unique_action(H)

			if(isobj(target.loc))
				if(!just_racked)
					G.afterattack(target.loc, H)
			else
				if(!just_racked)
					G.afterattack(target, H)

//			if(istype(B, /obj/item/gun/ballistic/rifle))
//				B.rack(H) //Rack the bolt.
//				addtimer(CALLBACK(G, PROC_REF(rack), H), 0.5 SECONDS, TIMER_UNIQUE)
	//Call your friends to help :))
	just_racked = FALSE
	if(world.time >= HA.next_backup_call)
		call_backup(HA)

	if(dist <= 1)
		var/proc_fist = TRUE
		var/override_gun_instincts = FALSE
		if(istype(target, /mob/living/simple_animal/hostile/asteroid/basilisk/whitesands))
			override_gun_instincts = TRUE
		if((!istype(A, /obj/item/gun) || override_gun_instincts) && H.a_intent == INTENT_HARM)
			if(!override_gun_instincts)
				if(grab_melee(HA) )
					A = H.get_active_held_item()
					if(A)
						target.attackby(A, H)
						A.afterattack(target, H, TRUE)
						proc_fist = FALSE
			else
				target.attackby(A, H)
				A.afterattack(target, H, TRUE)
				proc_fist = FALSE

		if(proc_fist && !isanimal(target))
			H.dna.species.spec_attack_hand(H, target)

		if(target.incapacitated())
			//I know kung-fu.

			var/obj/item/card/id/their_id = target.get_idcard()
			if(their_id && !HA.stealing_id && H.knpc_traits & KNPC_STEAL_ID)
				H.visible_message("<span class='warning'>[H] starts to take [their_id] from [target]!</span>")
				HA.stealing_id = TRUE
				addtimer(CALLBACK(HA, TYPE_PROC_REF(/datum/component/knpc, steal_id), their_id), 5 SECONDS)

			if(istype(H) && H.knpc_traits & KNPC_IS_MARTIAL_ARTIST)
				switch(rand(0, 2))
					//Throw!
					if(0)
						H.start_pulling(target, supress_message = FALSE)
						H.setGrabState(GRAB_AGGRESSIVE)
						H.visible_message("<span class='warning'>[H] judo throws [target]!</span>")
//							playsound(get_turf(target), 'nsv13/sound/effects/judo_throw.ogg', 100, TRUE)
						target.shake_animation(10)
						target.throw_at(get_turf(get_step(H, pick(GLOB.cardinals))), 5, 5)
					if(1)
						H.do_attack_animation(target, ATTACK_EFFECT_PUNCH)
						target.visible_message("<span class='warning'>[H] grabs [target]'s wrist and wrenches it sideways!</span>", \
										"<span class='userdanger'>[H] grabs your wrist and violently wrenches it to the side!</span>")
						playsound(get_turf(H), 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
						target.emote("scream")
						target.dropItemToGround(target.get_active_held_item())
						target.apply_damage(5, BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
					if(2)
						H.do_attack_animation(target, ATTACK_EFFECT_KICK)
						target.visible_message("<span class='warning'>[H] knees [target] in the stomach!</span>", \
										"<span class='userdanger'>[H] winds you with a knee in the stomach!</span>")
						target.audible_message("<b>[target]</b> gags!")
						target.losebreath += 3

			else
				//So they actually execute the curbstomp.
				if(dist <= 1)
					H.forceMove(get_turf(target))
				H.zone_selected = BODY_ZONE_HEAD
				//Curbstomp!
				H.MouseDrop(target)
				return
		if(H.knpc_traits & KNPC_IS_DODGER)
			HA.kite(target)

/datum/ai_goal/human/proc/grab_melee(datum/component/knpc/HA)
	var/mob/living/carbon/human/ai_boarder/H = HA.parent
	var/obj/item/A = H.get_active_held_item()
	if(A && A.force > 10)
		return TRUE

	var/obj/item/storage/back_storage = H.back
	//Okay first off, is the gun already on our person?
	var/list/expanded_contents = H.contents
	if(back_storage)
		expanded_contents = back_storage.contents + H.contents
	var/obj/item/highest_force_score
	for(var/obj/item/item_to_check as anything in expanded_contents)
		if(!isobj(item_to_check))
			continue
		if(item_to_check.force < 5)
			continue
		if(!highest_force_score)
			highest_force_score = item_to_check
			continue
		if(item_to_check.force > highest_force_score.force)
			highest_force_score = item_to_check
			continue
	if(H.put_in_hands(highest_force_score))
		return TRUE
	return FALSE


/datum/ai_goal/human/proc/call_backup(datum/component/knpc/HA)
	HA.next_backup_call = world.time + 30 SECONDS //So it's not horribly spammy.
	var/mob/living/carbon/human/ai_boarder/H = HA.parent
	var/obj/item/radio/headset/radio = H.ears
	H.do_alert_animation(H)
	playsound(H, 'sound/machines/chime.ogg', 50, 1, -1)
	//Lets the AIs call for help over comms... This is quite deadly.
	var/support_text = (radio) ? "; " : ""
	if(H.knpc_traits & KNPC_IS_AREA_SPECIFIC)
		var/text = pick(H.call_lines)
		text += " [get_area(H)]!"
		support_text += text
	else
		support_text += pick(H.call_lines)
	if(!H.shut_up)
		H.say(support_text)

	// Call for other intelligent AIs
	for(var/datum/component/knpc/HH as() in GLOB.knpcs - HA)
		var/mob/living/carbon/human/ai_boarder/other = HH.parent
		var/obj/item/radio/headset/other_radio = other.ears
		if(other.z != H.z || !other.can_hear() || other.incapacitated())
			continue //Yeah no. Radio is good, but not THAT good....yet
		//They both have radios and can hear each other!
		if(H.shut_up)
			continue
		if((radio?.on && other_radio?.on) || get_dist(other, H) <= HA.view_range || H.faction_check_mob(other, TRUE))
			var/thetext = (other_radio) ? "; " : ""
			thetext += pick(H.response_lines)
			HH.pathfind_to(H)
			other.say(thetext)
	//Firstly! Call for the simplemobs..
	for(var/mob/living/simple_animal/hostile/M in oview(HA.view_range, HA.parent))
		if(H.faction_check_mob(M, TRUE))
			if(M.AIStatus == AI_OFF)
				return
			else
				M.Goto(HA.parent,M.move_to_delay,M.minimum_distance)

/datum/ai_goal/human/patrol
	name = "Patrol Nodes"
	score = AI_SCORE_LOW_PRIORITY //The default task for most AIs is to just patrol
	required_ai_flags = null //Set this if you want this task to only be achievable by certain types of ship.


/datum/ai_goal/human/patrol/action(datum/component/knpc/HA)
	if(!can_action(HA))
		return
	var/mob/living/carbon/human/ai_boarder/H = HA.parent
	if(HA.last_node && get_dist(HA.last_node, H) > 2)
		HA.pathfind_to(HA.last_node) //Restart pathfinding
		return FALSE
	get_next_patrol_node(HA)

/obj/effect/landmark/patrol_node
	name = "AI patrol node"
//	icon = 'nsv13/icons/effects/mapping_helpers.dmi'
	icon_state = "patrol_node"
	var/id = null
	var/next_id = null //id of the node that this one goes to. Alternatively, a list of ids which will all be possible next destinations.
	var/previous_id = null //id of the node that precedes this one
	var/obj/effect/landmark/patrol_node/previous //-- This isn't actually used anywhere.. - Delta
	var/list/next_nodes	= list() //List of possible followup nodes set by next_id. If multiple entities exist in the list, one will be chosen at random on every occasion.
	invisibility = INVISIBILITY_OBSERVER

/obj/effect/landmark/patrol_node/whitesands
	id = "whitesands"
	next_id = "whitesands"
	icon_state = "x"

/obj/effect/landmark/patrol_node/breach
	name = "AI hold here node"
	id = "hold"
	next_id = "hold"
	icon_state = "x4"

/obj/effect/landmark/patrol_node/breach
	name = "AI breach here node"
	id = "breach1"
	next_id = "breach2"
	icon_state = "x"

/obj/effect/landmark/patrol_node/breach/two
	name = "AI after breach, go here node"
	id = "breach2"
	next_id = "breach3"
	icon_state = "x2"

/obj/effect/landmark/patrol_node/breach/three
	name = "AI midway, go here node"
	id = "breach3"
	next_id = "breach4"
	icon_state = "x3"

/obj/effect/landmark/patrol_node/breach/four
	name = "AI after sweeping, hold here node"
	id = "breach4"
	next_id = "breach4"
	icon_state = "x4"

/obj/effect/landmark/patrol_node/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/patrol_node/LateInitialize()
	. = ..()
	for(var/obj/effect/landmark/patrol_node/node in GLOB.landmarks_list)
		if(!node.id)
			continue
		if(next_id)
			if(islist(next_id))
				var/list/next_id_list = next_id
				if(node.id in next_id_list)
					next_nodes += node
			else
				if(node.id == next_id)
					next_nodes += node
		if(previous_id && node.id == previous_id)
			previous = node
	if(next_id && !length(next_nodes))
		CRASH("WARNING: Patrol node in [get_area(src)] has no next node(s) despite set id(s).")
	if(previous_id && !previous)
		CRASH("WARNING: Patrol node in [get_area(src)] has no previous node despite a set id.")

/datum/ai_goal/human/proc/get_next_patrol_node(datum/component/knpc/HA)
	//Okay, we need to pick a starting point.
	var/mob/living/carbon/human/ai_boarder/H = HA.parent
	if(!HA.last_node)
		var/best_dist = 10000
		var/obj/effect/landmark/patrol_node/best
		for(var/obj/effect/landmark/patrol_node/node in GLOB.landmarks_list)
			var/dist = get_dist(H, node.loc)
			if(dist < best_dist && node.z == H.z)
				best_dist = dist
				best = node
		HA.last_node = best
		//Start the patrol.
		HA.pathfind_to(best)
		return

	var/obj/effect/landmark/patrol_node/next_node = pick(HA.last_node.next_nodes)
	if(HA.last_node.z != next_node.z)
		var/obj/structure/ladder/L = locate(/obj/structure/ladder) in get_turf(HA.last_node)
		if(!L)
			L = locate(/obj/structure/ladder) in orange(1, get_turf(HA.last_node))
		if(L)
			//Use the ladder....
			if(next_node.z > HA.last_node.z)
				L.travel(TRUE, H, FALSE, L.up, FALSE)
			else
				L.travel(FALSE, H, FALSE, L.down, FALSE)
		//No Ladder, lets check for stairs
		else if(!L && next_node.z > HA.last_node.z) //If going up a Z
			var/obj/structure/stairs/S = locate(/obj/structure/stairs) in orange(1, get_turf(HA.last_node))
			if(S)
				step_towards(H, S)
				step(H, S.dir)
		else //If down
			var/obj/structure/stairs/S = locate(/obj/structure/stairs) in orange(1, get_step_multiz(get_turf(HA.last_node), DOWN))
			if(S)
				step_towards(H, S)

	HA.last_node = next_node
	HA.pathfind_to(next_node)

/datum/ai_goal/human/set_internals
	name = "Set Internals"
	score = AI_SCORE_CRITICAL //The lads need to be able to breathe.
	required_ai_flags = null

/datum/ai_goal/human/set_internals/check_score(datum/component/knpc/HA)
	if(!..())
		return 0
	var/mob/living/carbon/human/H = HA.parent
	//We need to breathe....
	if(H.failed_last_breath && world.time >= HA.next_internals_attempt)
		HA.next_internals_attempt = world.time + 5 SECONDS
		var/obj/item/storage/S = H.back
		if(S && locate(/obj/item/tank/internals) in S.contents + H.contents)
			return score
	return 0

/datum/ai_goal/human/set_internals/action(datum/component/knpc/HA)
	if(!can_action(HA))
		return
	var/mob/living/carbon/human/ai_boarder/C = HA.parent

	if(C.incapacitated())
		return

	if(C.internal)
		C.internal = null
	else
		if(!C.getorganslot(ORGAN_SLOT_BREATHING_TUBE))
			if(!istype(C.wear_mask))
				return 1
			else
				var/obj/item/clothing/mask/M = C.wear_mask
				if(M.mask_adjusted) // if mask on face but pushed down
					M.adjustmask(C) // adjust it back
				if(!(M.clothing_flags & ALLOWINTERNALS))
					return

		var/obj/item/I = C.is_holding_item_of_type(/obj/item/tank)
		if(I)
			C.internal = I
		else if(ishuman(C))
			var/mob/living/carbon/human/H = C
			H.internal = locate(/obj/item/tank/internals) in H

		//Separate so CO2 jetpacks are a little less cumbersome.
		if(!C.internal && istype(C.back, /obj/item/tank))
			C.internal = C.back

/datum/ai_goal/human/stop_drop_n_roll
	name = "Stop drop & roll"
	score = AI_SCORE_HIGH_PRIORITY //Putting out fires is important, but not more important than killing the target setting us on fire
	required_ai_flags = null

/datum/ai_goal/human/stop_drop_n_roll/check_score(datum/component/knpc/HA)
	if(!..())
		return 0
	var/mob/living/carbon/human/H = HA.parent
	//We need to breathe....
	if(H.fire_stacks > 0)
		return score
	return 0

/datum/ai_goal/human/stop_drop_n_roll/action(datum/component/knpc/HA)
	var/mob/living/carbon/human/H = HA.parent
	if(!can_action(HA))
		return
	H.resist() //Stop drop and roll!

/datum/ai_goal/human/escape_custody
	name = "Escape Custody"
	score = AI_SCORE_CRITICAL //Not being contained is fairly important
	required_ai_flags = null

/datum/ai_goal/human/escape_custody/check_score(datum/component/knpc/HA)
	if(!..())
		return 0
	var/mob/living/carbon/human/H = HA.parent
	if(istype(H.loc, /obj/structure/closet)) //Check if we are in a closet
		return score
	if(H.handcuffed || H.buckled || H.legcuffed) //Or locked up somehow
		return score
	return 0

/datum/ai_goal/human/escape_custody/action(datum/component/knpc/HA)
	var/mob/living/carbon/human/H = HA.parent
	if(!H.can_resist()) //We use a different check here
		return

	if(istype(H.loc, /obj/structure/closet))
		var/obj/structure/closet/C = H.loc
		C.open() //Open that closet
	if(H.handcuffed || H.buckled || H.legcuffed)
		H.resist() //Trigger the universal escape button

/datum/ai_goal/human/heal_self
	name = "Heal Self"
	score = AI_SCORE_PRIORITY //Heal ourselves if outside of combat
	required_ai_flags = null

/datum/ai_goal/human/heal_self/check_score(datum/component/knpc/HA)
	if(!..())
		return 0
	var/mob/living/carbon/human/H = HA.parent
	if(H.health <= (H.maxHealth / 2)) //If half health
		if(locate(/obj/item/reagent_containers/hypospray/medipen/survival) in H.contents) //And has survival pen
			return score
	return 0

/datum/ai_goal/human/heal_self/action(datum/component/knpc/HA)
	if(!can_action(HA))
		return
	var/mob/living/carbon/human/H = HA.parent
	var/obj/item/storage/S = H.back
	var/list/expanded_contents = H.contents
	if(S) //Checking for a backpack
		expanded_contents += S.contents
		for(var/obj/item/I in H.held_items) //If we are holding anything
			I.forceMove(S) //Put it in our pack
	else
		for(var/obj/item/I in H.held_items) //If we are holding anything
			I.forceMove(get_turf(H)) //Drop it on the floor
	var/obj/item/reagent_containers/hypospray/medipen/survival/P = locate(/obj/item/reagent_containers/hypospray/medipen/survival) in expanded_contents
	if(P)
		H.put_in_active_hand(P) //Roll Up Your Sleeve
		P.attack(H, H) //Self Vax
		P.forceMove(get_turf(H)) //Litter because doing one good thing is enugh for today

#undef AI_TRAIT_BRAWLER
#undef AI_TRAIT_SUPPORT
