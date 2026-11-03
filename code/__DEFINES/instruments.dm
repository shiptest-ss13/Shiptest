#define INSTRUMENT_MIN_OCTAVE 1
#define INSTRUMENT_MAX_OCTAVE 9
#define INSTRUMENT_MIN_KEY 0
#define INSTRUMENT_MAX_KEY 127

/// Max number of playing notes per instrument.
#define CHANNELS_PER_INSTRUMENT 128

/// Most ticks a song catches up on after the server lags, one chord a tick at most. Longer lags pause the song instead.
#define INSTRUMENT_MAX_CATCHUP_TICKS 3

/// Chord delays within this many ticks of a whole tick are snapped to it, as rounded /x values come out a hair off.
#define INSTRUMENT_DELAY_SNAP_TICKS 0.05
/// Or within this fraction of the delay, for longer chords.
#define INSTRUMENT_DELAY_SNAP_FRACTION 0.01
/// Leeway when checking if a chord is due, so float rounding can't push it a tick late.
#define INSTRUMENT_DELAY_EPSILON 0.001

/// Maximum length a note should ever go for
#define INSTRUMENT_MAX_TOTAL_SUSTAIN (5 SECONDS)

/// These are per decisecond.
#define INSTRUMENT_EXP_FALLOFF_MIN 1.025 //100/(1.025^50) calculated for [INSTRUMENT_MIN_SUSTAIN_DROPOFF] to be 30.
#define INSTRUMENT_EXP_FALLOFF_MAX 10

/// Minimum volume for when the sound is considered dead.
#define INSTRUMENT_MIN_SUSTAIN_DROPOFF 1

#define SUSTAIN_LINEAR 1
#define SUSTAIN_EXPONENTIAL 2

// /datum/instrument instrument_flags
#define INSTRUMENT_LEGACY (1<<0) //Legacy instrument. Implies INSTRUMENT_DO_NOT_AUTOSAMPLE
#define INSTRUMENT_DO_NOT_AUTOSAMPLE (1<<1) //Do not automatically sample
