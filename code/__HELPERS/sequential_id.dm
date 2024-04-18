// Algorithm for allocating names for vents/scrubbers (you may use it for other purposes as long as it has same interface)
//
// By "name" here I mean sequential number of the scrubber/vent in the area
// I keep track of all used names in the area with an array `names`
// Array index means name, array value means id_tag
// If value is null, the name is not used
//
// # So for example area has vents #1, #2 and #4, then array of names looks like
// ["tag1", "tag2", null, "tag4"]
//
// When you allocate new name for id_tag, you scan array for free slot,
// assign id_tag to that slot and return its index
// if all slots occupied, you add value to the end of array
//
// When you deallocate name for id_tag, you find id_tag in the array
// and set value of that element to null (or to some other meaningless value for id_tag)

/**
	Make new sequential number for this id_tag or reuse one of the free ones
*/
/proc/allocate_nameid(list/names, id_tag)
	for (var/i in 1 to length(names))
		if (names[i] == id_tag)
			// this id_tag already has a name
			return i
		if (names[i] == null)
			// found empty slot in the array
			names[i] = id_tag
			return i
	// end of array, add new value to the end
	names += id_tag
	return length(names)

/**
	Free the previously used sequential number for vent/scrubber so it can be used again
*/
/proc/deallocate_nameid(list/names, id_tag)
	var/i = names.Find(id_tag)
	if (i == 0)
		// name for this tag was never allocated
		return FALSE
	// erase id_tag value
	names[i] = null
	return TRUE
