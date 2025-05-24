// ! get rid of this file / rename it. probably move it to a _DEFINES file or something

#define PREFERENCE_ENTRY_UNAVAILABLE /datum/__pref_unavailable_dummy_type
/// A type that is only used for comparisons, chosen so that the an "unavailable" preference's data
/// is unlikely to overlap with any valid data (such as null or 0)
/datum/__pref_unavailable_dummy_type

#define PREF_RAND_FLAG_APPEARANCE (1 << 0)
#define PREF_RAND_FLAG_IDENTITY (1 << 1)
#define PREF_RAND_FLAG_SPAWN_HINTS (1 << 2)


/// The value used by /datum/preference/species for its application priority. Placed here for reference.
/// This really, really has to be above PREF_APPLICATION_PRIORITY_SPECIES_FINALIZE...
#define PREF_APPLICATION_PRIORITY_SPECIES_PRELIMINARY 10

/// Built-in value used to control when the character's body is "reset" after changing their species and limbs according to preferences.
/// /datum/preference::application_priority values higher than or equal to this are applied before; /datum/preference::application_priority values less than this are applied after.
#define PREF_APPLICATION_PRIORITY_SPECIES_FINALIZE 0


