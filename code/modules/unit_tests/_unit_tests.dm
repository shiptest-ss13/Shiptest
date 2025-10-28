//include unit test files in this module in this ifdef
//Keep this sorted alphabetically

#ifdef UNIT_TESTS

/// For advanced cases, fail unconditionally but don't return (so a test can return multiple results)
#define TEST_FAIL(reason) (Fail(reason || "No reason", __FILE__, __LINE__))

/// Asserts that a condition is true
/// If the condition is not true, fails the test
#define TEST_ASSERT(assertion, reason) if (!(assertion)) { return Fail("Assertion failed: [reason || "No reason"]", __FILE__, __LINE__) }

/// Asserts that a parameter is not null
#define TEST_ASSERT_NOTNULL(a, reason) if (isnull(a)) { return Fail("Expected non-null value: [reason || "No reason"]", __FILE__, __LINE__) }

/// Asserts that a parameter is null
#define TEST_ASSERT_NULL(a, reason) if (!isnull(a)) { return Fail("Expected null value but received [a]: [reason || "No reason"]", __FILE__, __LINE__) }

/// Asserts that the two parameters passed are equal, fails otherwise
/// Optionally allows an additional message in the case of a failure
#define TEST_ASSERT_EQUAL(a, b, message) do { \
	var/lhs = ##a; \
	var/rhs = ##b; \
	if (lhs != rhs) { \
		return Fail("Expected [isnull(lhs) ? "null" : lhs] to be equal to [isnull(rhs) ? "null" : rhs].[message ? " [message]" : ""]", __FILE__, __LINE__); \
	} \
} while (FALSE)

/// Asserts that the two parameters passed are not equal, fails otherwise
/// Optionally allows an additional message in the case of a failure
#define TEST_ASSERT_NOTEQUAL(a, b, message) do { \
	var/lhs = ##a; \
	var/rhs = ##b; \
	if (lhs == rhs) { \
		return Fail("Expected [isnull(lhs) ? "null" : lhs] to not be equal to [isnull(rhs) ? "null" : rhs].[message ? " [message]" : ""]", __FILE__, __LINE__); \
	} \
} while (FALSE)

/// *Only* run the test provided within the parentheses
/// This is useful for debugging when you want to reduce noise, but should never be pushed
/// Intended to be used in the manner of `TEST_FOCUS(/datum/unit_test/math)`
#define TEST_FOCUS(test_path) ##test_path { focus = TRUE; }

/// Logs a noticable message on GitHub, but will not mark as an error.
/// Use this when something shouldn't happen and is of note, but shouldn't block CI.
/// Does not mark the test as failed.
#define TEST_NOTICE(source, message) source.log_for_test((##message), "notice", __FILE__, __LINE__)
/// TEST_NOTICE but more important
#define TEST_WARNING(source, message) source.log_for_test((##message), "warning", __FILE__, __LINE__)

/// Constants indicating unit test completion status
#define UNIT_TEST_PASSED 0
#define UNIT_TEST_FAILED 1
#define UNIT_TEST_SKIPPED 2

#define TEST_DEFAULT 1
#define TEST_DEL_WORLD INFINITY

/// Change color to red on ANSI terminal output, if enabled with -DANSICOLORS.
#ifdef ANSICOLORS
#define TEST_OUTPUT_RED(text) "\x1B\x5B1;31m[text]\x1B\x5B0m"
#else
#define TEST_OUTPUT_RED(text) (text)
#endif
/// Change color to green on ANSI terminal output, if enabled with -DANSICOLORS.
#ifdef ANSICOLORS
#define TEST_OUTPUT_GREEN(text) "\x1B\x5B1;32m[text]\x1B\x5B0m"
#else
#define TEST_OUTPUT_GREEN(text) (text)
#endif

#ifdef BASIC_TESTS

#include "icons/inhands.dm"
#include "icons/missing_icons.dm"
#include "icons/spritesheets.dm"
#include "icons/worn_icons.dm"
#include "anchored_mobs.dm"
#include "atmospheres.dm"
#include "autowiki.dm"
#include "bespoke_id.dm"
#include "binary_insert.dm"
#include "combat.dm"
#include "component_tests.dm"
#include "connect_loc.dm"
#include "biome_lists.dm"
#include "emoting.dm"
#include "gun_sanity.dm"
#include "keybinding_init.dm"
#include "machine_disassembly.dm"
#include "medical_wounds.dm"
#include "open_air.dm"
#include "outfit_sanity.dm"
#include "overmap.dm"
#include "pills.dm"
#include "plantgrowth_tests.dm"
#include "projectiles.dm"
#include "quick_swap_sanity.dm"
#include "rcd.dm"
#include "reactions.dm"
#include "reagent_id_typos.dm"
#include "reagent_mod_expose.dm"
#include "reagent_mod_procs.dm"
#include "reagent_names.dm"
#include "reagent_recipe_collisions.dm"
#include "resist.dm"
#include "say.dm"
#include "serving_tray.dm"
#include "spawn_humans.dm"
#include "species_unique_id.dm"
#include "species_whitelists.dm"
#include "stack_singular_name.dm"
#include "subsystem_init.dm"
#include "subsystem_metric_sanity.dm"
#include "supply_pack.dm"
#include "teleporters.dm"
#include "timer_sanity.dm"

#ifdef REFERENCE_TRACKING_DEBUG //Don't try and parse this file if ref tracking isn't turned on. IE: don't parse ref tracking please mr linter
#include "find_reference_sanity.dm"
#endif

#endif //BASIC_TESTS

#ifdef CREATE_AND_DESTROY_TEST
#include "create_and_destroy.dm"
#endif //CREATE_AND_DESTROY_TEST

#ifdef PLANET_GEN_TEST
#include "planet_gen.dm"
#endif //PLANET_GEN

#ifdef RUIN_PLACEMENT_TEST
#include "ruin_placement.dm"
#endif //RUIN_PLACEMENT_TEST

#ifdef SHIP_PLACEMENT_TEST
#include "ship_placement.dm"
#endif //SHIP_PLACEMENT_TEST

#include "unit_test.dm"

#undef TEST_ASSERT
#undef TEST_ASSERT_EQUAL
#undef TEST_ASSERT_NOTEQUAL
//#undef TEST_FOCUS - This define is used by vscode unit test extension to pick specific unit tests to run and appended later so needs to be used out of scope here
#endif
