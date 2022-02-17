#define QDEL_IN(item, time) addtimer(CALLBACK(item, /datum/proc/qdel_self), time, TIMER_STOPPABLE)
#define QDEL_IN_CLIENT_TIME(item, time) CALLBACK(item, /datum/proc/qdel_self), time, TIMER_STOPPABLE | TIMER_CLIENT_TIME)
#define QDEL_NULL(item) qdel(item); item = null
#define QDEL_LIST(L) if(L) { for(var/I in L) qdel(I); L.Cut(); }
#define QDEL_LIST_IN(L, time) addtimer(CALLBACK(GLOBAL_PROC, .proc/______qdel_list_wrapper, L), time, TIMER_STOPPABLE)
#define QDEL_LIST_ASSOC(L) if(L) { for(var/I in L) { qdel(L[I]); qdel(I); } L.Cut(); }
#define QDEL_LIST_ASSOC_VAL(L) if(L) { for(var/I in L) qdel(L[I]); L.Cut(); }

/proc/______qdel_list_wrapper(list/L) //the underscores are to encourage people not to use this directly.
	QDEL_LIST(L)

// Sometimes you just want to end yourself
// Used to prevent harddels due to a reference in a callback's arguments, in QDEL_IN
/datum/proc/qdel_self()
	qdel(src)
