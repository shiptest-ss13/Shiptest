#warn document

// ! move somewhere better, slim down some of these lists? pref_datums is kind of unnecessary
GLOBAL_LIST_EMPTY_TYPED(pref_datums, /datum/preference)
GLOBAL_LIST_EMPTY_TYPED(pref_type_lookup, /datum/preference)
GLOBAL_LIST_EMPTY_TYPED(pref_ext_key_lookup, /datum/preference)
GLOBAL_LIST_EMPTY_TYPED(no_dependency_prefs, /datum/preference)

GLOBAL_LIST_EMPTY_TYPED(pref_topo_order, /datum/preference)
GLOBAL_LIST_EMPTY_TYPED(pref_application_order, /datum/preference)

// ! this is stupid; just make it a static var
GLOBAL_VAR_INIT(preference_traverse_key, 0)

// ! this is REALLY stupid. make_datum_references lists SHOULD NOT BE HERE DAWG...
/datum/controller/global_vars/Initialize(...)
	. = ..()
	make_datum_references_lists()
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
				// We sever the link at which we found the cycle, ensuring the graph is acyclic.
				if(is_norm_dependency)
					current_vert.dependencies -= next_vert_type
				else
					current_vert.rand_dependencies -= next_vert_type
				// Now, note that the step at which a cycle is found may change depending on the order
				// that preferences are processed in, which ultimately depends on the order given by subtypesof().
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
				previous_verts += next_vert
				previous_verts[next_vert] = 1


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


#warn these might need to be... i don't know, reorganized or unified or something
/proc/assemble_pref_dep_list(datum/preference/pref, list/pref_data_list)
	if(!pref.dependencies || !length(pref.dependencies))
		return null
	var/dep_list = list()

	for(var/datum/preference/dep_type as anything in pref.dependencies)
		var/dep_data = pref_data_list[dep_type]
		#warn should note an explicit guarantee in _preference.dm about this list: it will ONLY contain dependencies, and does NOT contain unavailable dependencies.
		if(dep_data != PREFERENCE_ENTRY_UNAVAILABLE)
			dep_list[dep_type] = dep_data

	return dep_list

/proc/assemble_pref_rand_dep_list(datum/preference/pref, list/pref_data_list)
	if(!pref.rand_dependencies || !length(pref.rand_dependencies))
		return null
	var/dep_list = list()

	for(var/datum/preference/rand_dep_type as anything in pref.rand_dependencies)
		var/rand_dep_data = pref_data_list[rand_dep_type]
		#warn should note an explicit guarantee in _preference.dm about this list: it will ONLY contain dependencies, and does NOT contain unavailable dependencies.
		if(rand_dep_data != PREFERENCE_ENTRY_UNAVAILABLE)
			dep_list[rand_dep_type] = rand_dep_data

	return dep_list



#warn comment. note that errors here are runtimes! randomize() should always return a valid result.
/proc/get_randomized_pref_list(list/preset_list)
	var/output_list = list()

	for(var/datum/preference/pref as anything in GLOB.pref_application_order)
		#warn maybe convert to a global list
		if(!pref.can_be_randomized)
			continue
		var/list/pref_deps = assemble_pref_dep_list(pref)
		var/is_avail = pref.is_available(pref_deps)
		// unavailable; mark it as such and continue
		if(!is_avail)
			if(pref.type in preset_list && preset_list[pref.type] != PREFERENCE_ENTRY_UNAVAILABLE)
				stack_trace("Preference randomization was given preset data [pref.type] = [preset_list[pref.type]], but it was unavailable when it was reached!")
			output_list[pref.type] = PREFERENCE_ENTRY_UNAVAILABLE
			continue

		var/rand_data
		if(pref.type in preset_list)
			rand_data = preset_list[pref.type]
		else
			var/list/pref_rand_deps = assemble_pref_rand_dep_list(pref)
			rand_data = pref.randomize(pref_deps, pref_rand_deps)

		var/invalid_check = pref.is_invalid(rand_data, pref_deps)
		if(invalid_check)
			stack_trace("Preference [pref.type] was randomized to value [rand_data], but this value is invalid: [invalid_check]")
			output_list[pref.type] = pref.default_value
		else
			output_list[pref.type] = rand_data

	return output_list


/proc/apply_prefs_list_to_human(mob/living/carbon/human/H, list/prefs_data_list)
	for(var/datum/preference/pref as anything in GLOB.pref_application_order)
		var/pref_data = prefs_data_list[pref]
		if(pref_data == PREFERENCE_ENTRY_UNAVAILABLE)
			continue
		pref.apply_to_human(H, pref_data)


#warn remgove
// #warn note that this cannot "fail": if it does not return PREFERENCE_ENTRY_UNAVAILABLE, then the pref is assumed to be available and the entry is assumed to be valid
// /datum/preferences/proc/get_pref_data(pref_type)
// 	// ! not super efficient
// 	if(pref_type in pref_cache)
// 		return pref_cache[pref_type]
// 	return pref_values[pref_type]


// /datum/preferences/proc/assemble_pref_dep_list(datum/preference/pref)
// 	if(!pref.dependencies || !length(pref.dependencies))
// 		return null
// 	var/dep_list = list()

// 	for(var/datum/preference/dep_type as anything in pref.dependencies)
// 		var/dep_data = get_pref_data(dep_type)

// 		#warn should note an explicit guarantee in _preference.dm about this list: it will ONLY contain dependencies, and does NOT contain unavailable dependencies.
// 		if(dep_data != PREFERENCE_ENTRY_UNAVAILABLE)
// 			dep_list[dep_type] = dep_data

// 	return dep_list

