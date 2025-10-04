#define NO_STUTTER (1<<0)
#define TONGUELESS_SPEECH (1<<1)
#define LANGUAGE_HIDE_ICON_IF_UNDERSTOOD (1<<2)
#define LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD (1<<3)
/// This language can be selected in preferences.
#define ROUNDSTART_LANGUAGE (1<<4)
/// This language is signed, not spoken.
#define SIGNED_LANGUAGE (1<<5)
/// Sarathi do not "sss" when speaking this language
#define NO_HISS (1<<6)

// LANGUAGE SOURCE DEFINES
/// For use in full removal only.
#define LANGUAGE_ALL "all"

// Generic language sources.
/// Language is linked to the movable directly.
#define LANGUAGE_ATOM "atom"
/// Language is linked to the mob's mind.
/// If a mind transfer happens, language follows.
#define LANGUAGE_MIND "mind"
/// Language is linked to the mob's species.
/// If a species change happens, language goes away.
/// If applied to a non-human (no species) atom, this is effectively the same as [LANGUAGE_ATOM].
#define LANGUAGE_SPECIES "species"

// More specific language sources.
// Only ever goes away when dismissed directly.

#define LANGUAGE_ABSORB "absorb"
#define LANGUAGE_APHASIA "aphasia"
#define LANGUAGE_CULTIST "cultist"
#define LANGUAGE_CURATOR "curator"
#define LANGUAGE_GLAND "gland"
#define LANGUAGE_HAT "hat"
#define LANGUAGE_HIGH "high"
#define LANGUAGE_MALF "malf"
#define LANGUAGE_MASTER "master"
#define LANGUAGE_SOFTWARE "software"
#define LANGUAGE_STONER "stoner"
#define LANGUAGE_VOICECHANGE "voicechange"

// Language flags. Used in granting and removing languages.
/// This language can be spoken.
#define SPOKEN_LANGUAGE (1<<0)
/// This language can be understood.
#define UNDERSTOOD_LANGUAGE (1<<1)
