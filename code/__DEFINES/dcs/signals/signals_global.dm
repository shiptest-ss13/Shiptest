/// Random event is trying to roll. (/datum/round_event_control/random_event)
/// Called by (/datum/round_event_control/prerun_event).
#define COMSIG_GLOB_PRE_RANDOM_EVENT "!pre_random_event"
	/// Do not allow this random event to continue.
	#define CANCEL_PRE_RANDOM_EVENT (1<<0)
/// Called by (/datum/round_event_control/run_event).
#define COMSIG_GLOB_RANDOM_EVENT "!random_event"
	/// Do not allow this random event to continue.
	#define CANCEL_RANDOM_EVENT (1<<0)
