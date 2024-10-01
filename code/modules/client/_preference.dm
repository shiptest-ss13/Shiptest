/datum/preference
	var/abstract_type = /datum/preference

	// the name shown in the prefs menu to identify this option, if applicable. technically need not be unique
	var/name = "TEST PREF"

	#warn due to being relatively unimplemented, this has been temporarily removed.
	/*
	//#warn all this code needs to throw errors depending on pref_type -- if pref_type is PREFERENCE_ACCOUNT, random deps and children are disallowed!!!!
	//var/pref_type
	*/

	// name used in savefiles and various parts of UI code to identify the preference.
	// once this is set for a preference, you probably shouldn't change it.
	var/external_key
	/// Controls the order with which the preference is applied to characters; higher priority datums are applied first.
	/// The order in which preferences with the same application priority are applied is undefined.
	var/application_priority = 0

	// ! comment - make clear that this should ALWAYS be valid. should absolutely be implemented
	var/default_value

	var/list/dependencies = list()
	var/list/datum/preference/dep_children = list()

	// ! should these be subtyped out to an IC category?
	var/list/rand_dependencies = list()
	var/list/datum/preference/rand_children = list()

	var/can_be_randomized = TRUE

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


	GLOB.pref_datums += src
	GLOB.pref_type_lookup[type] = src
	GLOB.pref_ext_key_lookup[external_key] = src


	if((length(dependencies) + length(rand_dependencies)) == 0)
		GLOB.no_dependency_prefs += src

#warn note that all these procs which take dependency_data (as code currently stands) may be passed "null" instead of a list if they have no dependencies.
#warn this should be coded around, and heavily documented (as should the idea of a "pref data list")


// ! a preference becoming unavailable needs to trigger a character update, as there might be leftover data.
// ! for OOC preferences, however, this might be impossible; you can't really regenerate somebody's client vars. hm
// ! maybe a var like "requires_deapplication"?
#warn need to enforce that no-dependency prefs are always available. additionally, this setup is insufficient to deal with admin prefs, which should be unavailable depending on non-pref info (admin status)
#warn maybe a subtype of prefs that aren't loaded from the file, have no dependencies, are always available, and have free reign to determine their data?
#warn another thing that should be enforced: a preference with no available dependencies is itself always unavailable.
/datum/preference/proc/is_available(list/dependency_data)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!length(dependencies)) // no dependencies, so it is always available
		return TRUE
	if(!length(dependency_data)) // it has dependencies, but none of them are available, so it is unavailable
		return FALSE
	return _is_available(dependency_data)

#warn all of the _-prepended protected internal procs need to throw "unimplemented" runtimes. however, many of those runtimes should be able to be recovered from gracefully.
/datum/preference/proc/_is_available(list/dependency_data)
	PROTECTED_PROC(TRUE)

// ! note that behavior when passed a dependency_data list which implies unavailability is undefined
// returns false if valid, and a truthy "error" (should be a string) when invalid
/datum/preference/proc/is_invalid(data, list/dependency_data)
	SHOULD_NOT_OVERRIDE(TRUE)
	// in order to ensure correctness, the "default" value MUST ALWAYS BE VALID.
	// otherwise, it would be difficult to "fill in" preferences after they are reset due to dependency changes, or load incorrectly
	if(data == default_value)
		return FALSE
	return _is_invalid(data, dependency_data)

/datum/preference/proc/_is_invalid(data, list/dependency_data)
	PROTECTED_PROC(TRUE)
	// check if current data together with dependencies represents a valid value for this pref
	// return FALSE if is is valid, and a truthy "error" value if it is not.


/datum/preference/proc/apply_to_human(mob/living/carbon/human/target, data)
	SHOULD_NOT_SLEEP(TRUE) // really, none of these fucking procs should sleep, but here is where it's actually likely
	SHOULD_CALL_PARENT(FALSE)
	return

#warn make sure that expected behavior here wrt. PREFERENCE_ENTRY_UNAVAILABLE is consistent with the serialization/deserialization code, and document.
/datum/preference/proc/serialize(data)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(data == PREFERENCE_ENTRY_UNAVAILABLE)
		// ! maybe this should be a special case that means "ignore me and move on"? i'm not sure.
		return "[data]"
	return _serialize(data)

/datum/preference/proc/_serialize(data)
	PROTECTED_PROC(TRUE)
	return

#warn note that this proc need not reject "invalid" values, so long as is_invalid does.
// note that a null or falsey result from this proc is allowed and expected -- available prefs may have null data!
/datum/preference/proc/deserialize(serialized_data)


/datum/preference/proc/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	// mob sent href_list containing our pref and an action.
	// using the action, current data, and the dependency data, handle the input, eventually returning a new valid value for the pref.
	// return values are not assumed to be correct, but it's still important that the "default" case (such as when cancelling) returns something valid.

/datum/preference/proc/randomize(list/dependency_data, list/rand_dependency_data)

