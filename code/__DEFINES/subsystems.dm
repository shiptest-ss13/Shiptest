//! Defines for subsystems and overlays
//!
//! Lots of important stuff in here, make sure you have your brain switched on
//! when editing this file

//! ## DB defines
/**
 * DB major schema version
 *
 * Update this whenever the db schema changes
 *
 * make sure you add an update to the schema_version stable in the db changelog
 */
#define DB_MAJOR_VERSION 5

/**
 * DB minor schema version
 *
 * Update this whenever the db schema changes
 *
 * make sure you add an update to the schema_version stable in the db changelog
 */
#define DB_MINOR_VERSION 13


//! ## Timing subsystem
/**
 * Don't run if there is an identical unique timer active
 *
 * if the arguments to addtimer are the same as an existing timer, it doesn't create a new timer,
 * and returns the id of the existing timer
 */
#define TIMER_UNIQUE (1<<0)

///For unique timers: Replace the old timer rather then not start this one
#define TIMER_OVERRIDE (1<<1)

/**
 * Timing should be based on how timing progresses on clients, not the server.
 *
 * Tracking this is more expensive,
 * should only be used in conjuction with things that have to progress client side, such as
 * animate() or sound()
 */
#define TIMER_CLIENT_TIME (1<<2)

///Timer can be stopped using deltimer()
#define TIMER_STOPPABLE (1<<3)

///prevents distinguishing identical timers with the wait variable
///
///To be used with TIMER_UNIQUE
#define TIMER_NO_HASH_WAIT (1<<4)

///Loops the timer repeatedly until qdeleted
///
///In most cases you want a subsystem instead, so don't use this unless you have a good reason
#define TIMER_LOOP (1<<5)

///Delete the timer on parent datum Destroy() and when deltimer'd
#define TIMER_DELETE_ME (1<<6)
///Empty ID define
#define TIMER_ID_NULL -1

//! ## Initialization subsystem

///New should not call Initialize
#define INITIALIZATION_INSSATOMS 0
///New should call Initialize(TRUE)
#define INITIALIZATION_INNEW_MAPLOAD 2
///New should call Initialize(FALSE)
#define INITIALIZATION_INNEW_REGULAR 1

//! ### Initialization hints

///Nothing happens
#define INITIALIZE_HINT_NORMAL 0
/**
 * call LateInitialize at the end of all atom Initalization
 *
 * The item will be added to the late_loaders list, this is iterated over after
 * initalization of subsystems is complete and calls LateInitalize on the atom
 * see [this file for the LateIntialize proc](atom.html#proc/LateInitialize)
 */
#define INITIALIZE_HINT_LATELOAD 1

///Call qdel on the atom after intialization
#define INITIALIZE_HINT_QDEL 2

///Call qdel with a force of TRUE after initialization
#define INITIALIZE_HINT_QDEL_FORCE 3

///type and all subtypes should always immediately call Initialize in New()
#define INITIALIZE_IMMEDIATE(X) ##X/New(loc, ...){ \
	..(); \
	if(!(flags_1 & INITIALIZED_1)) { \
		args[1] = TRUE; \
		SSatoms.InitAtom(src, args); \
	} \
}

// Subsystem init_order, from highest priority to lowest priority
// Subsystems shutdown in the reverse of the order they initialize in
// The numbers just define the ordering, they are meaningless otherwise.

#define INIT_ORDER_TEXT 103	//Should remain highest as other subsystems may throw runtimes if this did not init before them.
#define INIT_ORDER_PROFILER 101
#define INIT_ORDER_TITLE 100
#define INIT_ORDER_GARBAGE 99
#define INIT_ORDER_DBCORE 95
#define INIT_ORDER_BLACKBOX 94
#define INIT_ORDER_SERVER_MAINT 93
#define INIT_ORDER_SPEECH_CONTROLLER 92
#define INIT_ORDER_INPUT 85
#define INIT_ORDER_SOUND_CACHE 84
#define INIT_ORDER_SOUNDS 83
#define INIT_ORDER_INSTRUMENTS 82
#define INIT_ORDER_VIS 80
#define INIT_ORDER_ACHIEVEMENTS 77
#define INIT_ORDER_RESEARCH 75
#define INIT_ORDER_EVENTS 70
#define INIT_ORDER_JOBS 65
#define INIT_ORDER_QUIRKS 60
#define INIT_ORDER_AI_MOVEMENT 57 //We need the movement setup
#define INIT_ORDER_AI_CONTROLLERS 56 //So the controller can get the ref
#define INIT_ORDER_TICKER 55
#define INIT_ORDER_FACTION 53
#define INIT_ORDER_MAPPING 50
#define INIT_ORDER_TIMETRACK 47
#define INIT_ORDER_NETWORKS 45
#define INIT_ORDER_ECONOMY 40
#define INIT_ORDER_OUTPUTS 35
#define INIT_ORDER_ATOMS 30
#define INIT_ORDER_LANGUAGE 25
#define INIT_ORDER_MACHINES 20
#define INIT_ORDER_TURRETS 17
#define INIT_ORDER_SKILLS 15
#define INIT_ORDER_TIMER 1
#define INIT_ORDER_DEFAULT 0
#define INIT_ORDER_AIR -1
#define INIT_ORDER_ASSETS -4
#define INIT_ORDER_ICON_SMOOTHING -5
#define INIT_ORDER_OVERLAY -6
#define INIT_ORDER_XKEYSCORE -10
#define INIT_ORDER_STICKY_BAN -10
#define INIT_ORDER_LIGHTING -20
#define INIT_ORDER_SHUTTLE -21
#define INIT_ORDER_OVERMAP -25
#define INIT_ORDER_PATH -50
#define INIT_ORDER_DISCORD -60
#define INIT_ORDER_EXPLOSIONS -69
#define INIT_ORDER_PERSISTENCE -95
#define INIT_ORDER_STATPANELS -98
#define INIT_ORDER_DEMO -99 // o avoid a bunch of changes related to initialization being written, do this last
#define INIT_ORDER_CHAT -100 //Should be last to ensure chat remains smooth during init.

// Subsystem fire priority, from lowest to highest priority
// If the subsystem isn't listed here it's either DEFAULT or PROCESS (if it's a processing subsystem child)

#define FIRE_PRIORITY_PING 10
#define FIRE_PRIORITY_IDLE_NPC 10
#define FIRE_PRIORITY_SERVER_MAINT 10
#define FIRE_PRIORITY_VIS 10
#define FIRE_PRIORITY_AMBIENCE 10
#define FIRE_PRIORITY_MISSIONS 10
#define FIRE_PRIORITY_GARBAGE 15
#define FIRE_PRIORITY_WET_FLOORS 20
#define FIRE_PRIORITY_AIR 20
#define FIRE_PRIORITY_NPC 20
#define FIRE_PRIORITY_NPC_MOVEMENT 21
#define FIRE_PRIORITY_NPC_ACTIONS 22
#define FIRE_PRIORITY_PROCESS 25
#define FIRE_PRIORITY_THROWING 25
#define FIRE_PRIORITY_SPACEDRIFT 30
#define FIRE_PRIOTITY_SMOOTHING 35
#define FIRE_PRIORITY_NETWORKS 40
#define FIRE_PRIORITY_OBJ 40
#define FIRE_PRIORITY_ACID 40
#define FIRE_PRIOTITY_BURNING 40
#define FIRE_PRIORITY_DEFAULT 50
#define FIRE_PRIORITY_PARALLAX 65
#define FIRE_PRIORITY_INSTRUMENTS 80
#define FIRE_PRIORITY_MOBS 100
#define FIRE_PRIORITY_MOVABLE_PHYSICS 105
#define FIRE_PRIORITY_TGUI 110
#define FIRE_PRIORITY_TICKER 200
#define FIRE_PRIORITY_ATMOS_ADJACENCY 300
#define FIRE_PRIORITY_STATPANEL 390
#define FIRE_PRIORITY_CHAT 400
#define FIRE_PRIORITY_RUNECHAT 410
#define FIRE_PRIORITY_MOUSE_ENTERED 450
#define FIRE_PRIORITY_OVERLAYS 500
#define FIRE_PRIORITY_CALLBACKS 600
#define FIRE_PRIORITY_EXPLOSIONS 666
#define FIRE_PRIORITY_TIMER 700
#define FIRE_PRIORITY_SOUND_LOOPS 800
#define FIRE_PRIORITY_OVERMAP_MOVEMENT 850
#define FIRE_PRIORITY_SPEECH_CONTROLLER 900
#define FIRE_PRIORITY_DELAYED_VERBS 950
#define FIRE_PRIORITY_INPUT 1000 // This must always always be the max highest priority. Player input must never be lost.

//Pipeline rebuild helper defines, these suck but it'll do for now
#define SSAIR_REBUILD_PIPELINE 1
#define SSAIR_REBUILD_QUEUE 2

// SS runlevels

#define RUNLEVEL_INIT 0
#define RUNLEVEL_LOBBY 1
#define RUNLEVEL_SETUP 2
#define RUNLEVEL_GAME 4
#define RUNLEVEL_POSTGAME 8

#define RUNLEVELS_DEFAULT (RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME)

/**
	Create a new timer and add it to the queue.
	* Arguments:
	* * callback the callback to call on timer finish
	* * wait deciseconds to run the timer for
	* * flags flags for this timer, see: code\__DEFINES\subsystems.dm
*/
#define addtimer(args...) _addtimer(args, file = __FILE__, line = __LINE__)

// Air subsystem subtasks
#define SSAIR_PIPENETS 1
#define SSAIR_ATMOSMACHINERY 2
#define SSAIR_EXCITEDGROUPS 3
#define SSAIR_HIGHPRESSURE 4
#define SSAIR_HOTSPOTS 5
#define SSAIR_TURF_CONDUCTION 6
#define SSAIR_REBUILD_PIPENETS 7
#define SSAIR_EQUALIZE 8
#define SSAIR_ACTIVETURFS 9
#define SSAIR_TURF_POST_PROCESS 10
#define SSAIR_FINALIZE_TURFS 11
#define SSAIR_ATMOSMACHINERY_AIR 12
#define SSAIR_DEFERRED_AIRS 13

// Explosion Subsystem subtasks
#define SSEXPLOSIONS_MOVABLES 1
#define SSEXPLOSIONS_TURFS 2
#define SSEXPLOSIONS_THROWS 3

// Vote subsystem counting methods
/// First past the post. One selection per person, and the selection with the most votes wins.
#define VOTE_COUNT_METHOD_SINGLE 1
/// Approval voting. Any number of selections per person, and the selection with the most votes wins.
#define VOTE_COUNT_METHOD_MULTI 2

/// The choice with the most votes wins. Ties are broken by the first choice to reach that number of votes.
#define VOTE_WINNER_METHOD_SIMPLE "Simple"
/// The winning choice is selected randomly based on the number of votes each choice has.
#define VOTE_WINNER_METHOD_WEIGHTED_RANDOM "Weighted Random"
/// There is no winner for this vote.
#define VOTE_WINNER_METHOD_NONE "None"

// Subsystem delta times or tickrates, in seconds. I.e, how many seconds in between each process() call for objects being processed by that subsystem.
// Only use these defines if you want to access some other objects processing seconds_per_tick, otherwise use the seconds_per_tick that is sent as a parameter to process()
#define SSFLUIDS_DT (SSfluids.wait/10)
#define SSMACHINES_DT (SSmachines.wait/10)
#define SSMOBS_DT (SSmobs.wait/10)
#define SSOBJ_DT (SSobj.wait/10)
