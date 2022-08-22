/proc/______qdel_list_wrapper(list/L) //the underscores are to encourage people not to use this directly.
	QDEL_LIST(L)

// Sometimes you just want to end yourself
// Used to prevent harddels due to a reference in a callback's arguments, in QDEL_IN
/datum/proc/qdel_self()
	qdel(src)
