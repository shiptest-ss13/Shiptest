//#define TESTING //By using the testing("message") proc you can create debug-feedback for people with this
								//uncommented, but not visible in the release version)

//#define DATUMVAR_DEBUGGING_MODE //Enables the ability to cache datum vars and retrieve later for debugging which vars changed.

// Comment this out if you are debugging problems that might be obscured by custom error handling in world/Error
#ifdef DEBUG
#define USE_CUSTOM_ERROR_HANDLER
#endif

#if defined(OPENDREAM) && !defined(SPACEMAN_DMM) && !defined(CIBUILDING)
// The code is being compiled for OpenDream, and not just for the CI linting.
#define OPENDREAM_REAL
#endif

#ifdef TESTING
#define DATUMVAR_DEBUGGING_MODE

///Used to find the sources of harddels, quite laggy, don't be surpised if it freezes your client for a good while
//#define REFERENCE_TRACKING
#ifdef REFERENCE_TRACKING

///Used for doing dry runs of the reference finder, to test for feature completeness
///Slightly slower, higher in memory. Just not optimal
//#define REFERENCE_TRACKING_DEBUG

///Run a lookup on things hard deleting by default.
//#define GC_FAILURE_HARD_LOOKUP
#ifdef GC_FAILURE_HARD_LOOKUP
///Don't stop when searching, go till you're totally done
#define FIND_REF_NO_CHECK_TICK
#endif //ifdef GC_FAILURE_HARD_LOOKUP

#endif //ifdef REFERENCE_TRACKING

//#define VISUALIZE_ACTIVE_TURFS //Highlights atmos active turfs in green
#endif //ifdef TESTING

/// If this is uncommented, we set up the ref tracker to be used in a live environment
/// And to log events to [log_dir]/harddels.log
//#define REFERENCE_DOING_IT_LIVE
#ifdef REFERENCE_DOING_IT_LIVE
// compile the backend
#define REFERENCE_TRACKING
// actually look for refs
#define GC_FAILURE_HARD_LOOKUP
#endif // REFERENCE_DOING_IT_LIVE

//#define UNIT_TESTS //Enables unit tests via TEST_RUN_PARAMETER
//#define ALL_TESTS //Enables all tests, including the ones that take a long time to run

#ifndef PRELOAD_RSC				//set to:
#define PRELOAD_RSC 2			//	0 to allow using external resources or on-demand behaviour;
#endif							//	1 to use the default behaviour;
								//	2 for preloading absolutely everything;

/// If this is uncommented, Autowiki will generate edits and shut down the server.
/// Prefer the autowiki build target instead.
// #define AUTOWIKI

//Log the full sendmaps profile on 514.1556+, any earlier and we get bugs or it not existing
#if DM_VERSION >= 514 && DM_BUILD >= 1556
#define SENDMAPS_PROFILE
#endif

//Additional code for the above flags.
#ifdef TESTING
#warn compiling in TESTING mode. testing() debug messages will be visible.
#endif

#if defined(CIBUILDING) && !defined(OPENDREAM)
#define UNIT_TESTS
#endif

#ifdef CITESTING
#define TESTING
#endif

#ifdef UNIT_TESTS
//Hard del testing defines
#define REFERENCE_TRACKING
#define REFERENCE_TRACKING_DEBUG
#define FIND_REF_NO_CHECK_TICK
#define GC_FAILURE_HARD_LOOKUP
#endif

#ifdef ALL_TESTS
#define BASIC_TESTS
#define CREATE_AND_DESTROY_TEST
#define PLANET_GEN_TEST
#define RUIN_PLACEMENT_TEST
#define SHIP_PLACEMENT_TEST
#endif

#if defined(OPENDREAM)
	#if !defined(CIBUILDING)
		#warn You are building with OpenDream. Remember to build TGUI manually.
		#warn You can do this by running tgui-build.cmd from the bin directory.
	#endif
#else
	#if !defined(CBT) && !defined(SPACEMAN_DMM)
		#warn Building with Dream Maker is no longer supported and will result in errors.
		#warn In order to build, run BUILD.cmd in the root directory.
		#warn Consider switching to VSCode editor instead, where you can press Ctrl+Shift+B to build.
	#endif
#endif
