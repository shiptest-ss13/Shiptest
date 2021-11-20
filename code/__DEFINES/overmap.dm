#define OVERMAP_GENERATOR_SOLAR "solar_system"
#define OVERMAP_GENERATOR_RANDOM "random"

//Add new star types here
#define SMALLSTAR 1
#define TWOSTAR 2
#define MEDSTAR 3
#define BIGSTAR 4

// Ship Damage Types
/// This only exists for use in overmap armor lists. Dealing damage with this 'type' is not supported
#define DAMAGE_ALL "All"
#define DAMAGE_EMP "EMP"
#define DAMAGE_TESLA "Tesla"
#define DAMAGE_PLASMA "Plasma"
#define DAMAGE_PHOTON "Photon"
#define DAMAGE_PHYSICAL "Physical"
#define DAMAGE_EXPLOSIVE "Explosive"
#define DAMAGE_BLOCKED_MOVE "ship-blocked-move.name" // classical localization joke, given this should NEVER BE USED AS OUTPUT

//Star classes
#define STARO 1 //Extremely bright blue main sequence star or (super)giant
#define STARB 2 //Bright blue main sequence star or (super)giant
#define STARA 3 //Light blue main sequence star
#define STARF 4 //White main sequence star
#define STARG 5 //Yellow main sequence star or supergiant
#define STARK 6 //Orange dwarf, main sequence star, or hypergiant
#define STARM 7 //Red dwarf or red (super)giant
#define STARL 8 //Cool red dwarf
#define START 9 //Methane dwarf
#define STARY 10 //Sad lame brown dwarf
#define STARD 11 //White dwarf

// Bluespace Jump states
#define JUMP_STATE_OFF 0
#define JUMP_STATE_CHARGING 1
#define JUMP_STATE_IONIZING 2
#define JUMP_STATE_FIRING 3
#define JUMP_STATE_FINALIZED 4
// Bluespace Jump numbers
#define JUMP_CHARGE_DELAY (20 SECONDS)
#define JUMP_CHARGEUP_TIME (3 MINUTES)
