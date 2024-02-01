#define PREFERENCE_ACCOUNT "preference_account"
#define PREFERENCE_CHARACTER "preference_character"

// ! document

// ! move somewhere better, slim down some of these lists? pref_datums is kind of unnecessary
GLOBAL_LIST_EMPTY_TYPED(pref_datums, /datum/preference)
GLOBAL_LIST_EMPTY_TYPED(pref_type_lookup, /datum/preference)
GLOBAL_LIST_EMPTY_TYPED(pref_ext_key_lookup, /datum/preference)
GLOBAL_LIST_EMPTY_TYPED(no_dependency_prefs, /datum/preference)

GLOBAL_LIST_EMPTY_TYPED(pref_topo_order, /datum/preference)
GLOBAL_LIST_EMPTY_TYPED(pref_application_order, /datum/preference)

// ! this is stupid; just make it a static var
GLOBAL_VAR_INIT(preference_traverse_key, 0)

// ! this is REALLY stupid
/world/New(...)
	. = ..()
	init_pref_datums()

/proc/init_pref_datums()
	var/list/preference_types = subtypesof(/datum/preference)

	for(var/datum/preference/pref_type as anything in preference_types)
		if(initial(pref_type.abstract_type) == pref_type)
			continue
		// It adds itself to pref_datums, pref_lookup, and no_dependency_prefs automatically.
		new pref_type()

	// hook the prefs up into graphs
	create_pref_graph(GLOB.pref_datums)

	// create a topological order on the preferences
	GLOB.pref_topo_order = create_topological_order(GLOB.no_dependency_prefs)
	// sortList returns a duplicate, it's fine.
	GLOB.pref_application_order = sortList(GLOB.pref_datums, /proc/cmp_pref_priority_dsc)

	// informs the prefs of their index in the topological order
	for(var/i in 1 to length(GLOB.pref_topo_order))
		var/datum/preference/index_pref = GLOB.pref_topo_order[i]
		index_pref.topo_index = i

// ! make sure this is actually descending
/proc/cmp_pref_priority_dsc(datum/preference/a, datum/preference/b)
	return b.application_priority - a.application_priority

/proc/create_pref_graph(list/datum/preference/prefs)
	SHOULD_NOT_SLEEP(TRUE)

	// To make use of the dependency graph, we need to be able to access from a preference the other preferences
	// which have it as a dependency. That graph needs to be constructed: this is where that's done.
	// Additionally, we need to verify that the graph is cycle-free. This can be done with a depth-first search.
	// In a sense, we're traversing the graph "backwards" (from child->parent instead of parent->child), but that doesn't
	// make a difference for cycle-checking.

	// One of the complications is that we don't know how many isolated subgraphs there will be.
	// Thus, we just iterate through all the instanced preference datums, marking the ones that have
	// already been processed, to avoid repeats. This way, we know that all preferences have had their
	// children filled in without needing to know anything about the shape of the graph beforehand.
	for(var/datum/preference/pref_datum as anything in prefs)
		if(pref_datum.graph_verify_finished == TRUE) // already been processed
			continue

		// The list contains the previously-traversed vertices, in order.
		// The stored number corresponds to the index of the first dependency which has yet to be processed,
		// if the list of dependencies and the list of randomization dependencies were to be combined.
		// Once all of a vertex's dependencies have been processed, it is removed from the list; this will
		// only ever happen to the vertex which is currently at the top of the list.
		var/list/datum/preference/previous_verts = list(pref_datum)
		previous_verts[pref_datum] = 1

		// The "current" preference datum / graph vertex
		var/datum/preference/current_vert
		while(length(previous_verts))
			// This is a depth-first traversal: we're picking the deepest vertex off the list and going from there.
			current_vert = previous_verts[length(previous_verts)]

			var/dep_length = length(current_vert.dependencies)
			var/total_length = dep_length + length(current_vert.rand_dependencies)
			var/current_index = previous_verts[current_vert]

			if(current_index > total_length)
				// All of the current vertex's dependencies have been processed.
				// Back up to the previous vertex.
				previous_verts.len--
				current_vert.graph_verify_finished = TRUE
				continue

			// There must be dependencies which have not yet been processed.
			var/is_norm_dependency = (current_index <= dep_length)
			var/datum/preference/next_vert
			var/next_vert_type
			if(is_norm_dependency)
				next_vert_type = current_vert.dependencies[current_index]
			else
				next_vert_type = current_vert.rand_dependencies[current_index - dep_length]
			next_vert = GLOB.pref_type_lookup[next_vert_type]

			if(next_vert in previous_verts)
				// The current vertex has a dependency which directly or indirectly depends on the current vertex, creating a cycle.
				// This is very bad, and makes it impossible to correctly validate changes or randomize preferences.
				// ! improve this message
				stack_trace("uh oh!! cycle found!!!!")
				// We sever the link at which we found the cycle, severing it.
				if(is_norm_dependency)
					current_vert.dependencies -= next_vert_type
				else
					current_vert.rand_dependencies -= next_vert_type
				// Now, note that the step at which a cycle is found may change depending on the order
				// that preferences are processed in, which ultimately depends on the order given subtypesof().
				// Additionally, we're altering the dependency graph, when the code was presumably written with the assumption that would stay constant.
				// Thus, we can't expect "correct" behavior. To prevent saving invalid savefiles, we disable saving preferences.
				// ! set some global variable forbidding preference saving
				continue

			// Add the current preference to the children of the dependency we are processing.
			if(is_norm_dependency)
				next_vert.dep_children |= current_vert
			else
				next_vert.rand_children |= current_vert
			// Next time we look at the current vertex, process its next dependency.
			previous_verts[current_vert] += 1

			// If this is TRUE, then we've already processed the next vertex's dependency subgraph,
			// so we don't need to descend into it and repeat what we've already done.
			if(!next_vert.graph_verify_finished)
				previous_verts += next_vert // ! can this and the next line be merged?
				previous_verts[next_vert] = 1

// ! compare iterative performance (here) to recursive performance
/proc/create_topological_order(list/datum/preference/head_prefs, respect_rand)
	SHOULD_NOT_SLEEP(TRUE)

	var/list/working_list = head_prefs.Copy()
	var/list/reverse_topo_order = list()

	var/vertex_saw_children = GLOB.preference_traverse_key + 1
	var/vertex_added_to_order = GLOB.preference_traverse_key + 2
	GLOB.preference_traverse_key += 2

	while(length(working_list))
		var/datum/preference/current_vert = working_list[length(working_list)]
		if(current_vert.traverse_key == vertex_added_to_order) // if true, it's already been added to the order
			working_list.len-- // pops off the top
			continue

		if(current_vert.traverse_key != vertex_saw_children)
			// its children haven't been added yet: add them
			working_list += (respect_rand) ? (current_vert.rand_children + current_vert.dep_children) : (current_vert.dep_children)
			current_vert.traverse_key = vertex_saw_children
		else
			// we've added its children to the list: because it wasn't added then, and we reached it, we must add it
			current_vert.traverse_key = vertex_added_to_order
			reverse_topo_order += current_vert
			working_list.len-- // pops off the top

	return reverseRange(reverse_topo_order)

/datum/preference
	var/abstract_type = /datum/preference

	// the name shown in the prefs menu to identify this option, if applicable. technically need not be unique
	var/name = "TEST PREF"

	#warn all this code needs to throw errors depending on pref_type -- if pref_type is PREFERENCE_ACCOUNT, random deps and children are disallowed!!!!
	var/pref_type

	// ! make sure a runtime is thrown if it's invalid or has any duplicates. this HAS to be unique, again for correctness
	// name used in the savefile and various parts of UI code to identify the preference
	var/external_key
	/// Controls the order with which the preference is applied to characters; higher priority datums are applied first.
	/// The order in which preferences with the same application priority are applied is undefined.
	var/application_priority = 1

	// ! comment - make clear that this should ALWAYS be valid. should absolutely be implemented
	var/default_value

	var/list/dependencies = list()
	var/list/datum/preference/dep_children = list()

	// ! should these be subtyped out to an IC category?
	var/list/rand_dependencies = list()
	// ! important to ensure no overlap with dep_children.
	var/list/datum/preference/rand_children = list()

	/// The index of this pref in the global list that is a topological order of all preference datums.
	var/topo_index

	var/graph_verify_finished = FALSE
	var/traverse_key = 0

// ! this, uh, this should be a unit test.
/datum/preference/New()
	SHOULD_CALL_PARENT(TRUE)

	. = ..()

	if(abstract_type == type)
		CRASH("Attempted to instance an abstract preference! Don't do this!")

	var/list/overlapping_deps = dependencies & rand_dependencies
	if(length(overlapping_deps) != 0)
		stack_trace("[type] has overlap between its \"dependencies\" and \"rand_dependencies\" lists! This is redundant, as standard dependencies are considered during randomization.")
		rand_dependencies -= dependencies // i love list ops

	// used to check if prefs appear multiple times in either list
	var/list/checked_deps = list()
	var/list/checked_rand = list()

	// now we inspect each list individually
	for(var/datum/preference/dep_pref_type as anything in dependencies)
		// checking for duplicates
		if(dep_pref_type in checked_deps)
			stack_trace("Preference [dep_pref_type] appears in [type]'s dependencies multiple times!")
			dependencies -= dep_pref_type
		else
			checked_deps += dep_pref_type

		if(dep_pref_type == type)
			stack_trace("Preference [type] listed itself as a dependency!")
			dependencies -= dep_pref_type
		else if(initial(dep_pref_type.abstract_type) == dep_pref_type)
			stack_trace("Abstract preference [dep_pref_type] found in dependencies of [type]!")
			dependencies -= dep_pref_type

	for(var/datum/preference/rand_pref_type as anything in rand_dependencies)
		if(rand_pref_type in checked_rand)
			stack_trace("Preference [rand_pref_type] appears in [type]'s dependencies multiple times!")
			rand_dependencies -= rand_pref_type
		else
			checked_rand += rand_pref_type

		if(rand_pref_type == type)
			stack_trace("Preference [type] listed itself as a randomization dependency!")
			rand_dependencies -= rand_pref_type
		else if(initial(rand_pref_type.abstract_type) == rand_pref_type)
			stack_trace("Abstract preference [rand_pref_type] found in randomization dependencies of [type]!")
			rand_dependencies -= rand_pref_type

	// ! better error messages?
	if(external_key in GLOB.pref_ext_key_lookup)
		stack_trace("Duplicate external key \"[external_key]\" for preference [type]!")
		return // again, no duplicates

	if(src in GLOB.pref_datums)
		stack_trace("Preference [type] was instanced twice!")
		return // we don't want any duplicates


	// ! need to actually declare these
	GLOB.pref_datums += src
	GLOB.pref_type_lookup[type] = src
	GLOB.pref_ext_key_lookup[external_key] = src


	if((length(dependencies) + length(rand_dependencies)) == 0)
		GLOB.no_dependency_prefs += src

#warn note that all these procs (as code currently stands) may be passed "null" as a list if they have no dependencies.


// ! a preference is either "available" in which case it has a value and will be applied, or "unavailable" in which case it has none and will not be.
// ! if a preference has a value but is unavailable, it will not be applied.
// ! if none of a preference's (non-randomization) dependencies are available, it is unavailable by default.

// ! however, leftover values should usually be culled when a preference becomes unavailable; this should fire a warning.
// ! additionally, a preference becoming unavailable needs to trigger a character update, as there might be leftover data.
// ! for OOC preferences, however, this might be impossible; you can't really regenerate somebody's client vars. hm
// ! maybe a var like "requires_deapplication"?
#warn need to enforce that no-dependency prefs are always available. additionally, this setup is insufficient to deal with admin prefs, which should be unavailable depending on non-pref info (admin status)
#warn maybe a subtype of prefs that aren't loaded from the file, have no dependencies, are always available, and have free reign to determine their data?
#warn another thing that should be enforced: a preference with no available dependencies is itself always unavailable.
/datum/preference/proc/is_available(list/dependency_data)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!length(dependencies))
		return TRUE
	if(!length(dependency_data)) // it has dependencies, but none of them are available, so it is unavailable
		return FALSE
	return _is_available(dependency_data)

/datum/preference/proc/_is_available(list/dependency_data)
	PROTECTED_PROC(TRUE)

// ! note that behavior when passed a dependency_data list which implies unavailability is undefined
// returns false if valid, and a truthy "error" (should be a string) when invalid
/datum/preference/proc/is_invalid(data, list/dependency_data)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(data == default_value) // we assume that the default value is always valid
		return FALSE
	return _is_invalid(data, dependency_data)

/datum/preference/proc/_is_invalid(data, list/dependency_data)
	PROTECTED_PROC(TRUE)
	// check if current data together with dependencies represents a valid value for this pref
	// return FALSE if is is valid, and a truthy "error" value if it is not.


// ! most of these procs are copied from the /tg/ file of the same name
/datum/preference/proc/apply_to_human(mob/living/carbon/human/target, value)
	SHOULD_NOT_SLEEP(TRUE)
	SHOULD_CALL_PARENT(FALSE)
	// ! error goes here probably
	return

// ! this should be called as well
/datum/preference/proc/serialize(data)

// note that a null or falsey result from this proc is allowed and expected -- available prefs may have null data!
/datum/preference/proc/deserialize_validate(serialized_data, list/dependency_data, list/errors)
	// transform into the right format
	// check if option is viable
	// return viable option

/datum/preference/proc/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	// mob sent href_list containing our pref and an action.
	// using the action, current data, and the dependency data, handle the input, eventually returning a new valid value for the pref.
	// return values are not assumed to be correct, but it's still important that the "default" case (such as when cancelling) returns something valid.

// ! wrapper proc? maybe?
/datum/preference/proc/is_randomizable()
