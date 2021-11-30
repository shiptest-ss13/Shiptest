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

/proc/convert_damage_types_to_readable_string(list/damage_types)
	var/ret = "("
	for(var/d_type in damage_types)
		ret += "[d_type],"
	ret = copytext(ret, 1, length(ret))
	ret += ")"
	return ret

#define IS_DAMAGE_TYPE(t1, t2) (islist(t1) ? (t2 in t1) : t1 == t2)

// Ship COMSIGs
#define COMSIG_SHIP_DAMAGE "ship-damage"
#define COMSIG_SHIP_THRUST "ship-thrust"
#define COMSIG_SHIP_MOVE "ship-move"
#define COMSIG_SHIP_DOCK "ship-dock"
#define COMSIG_SHIP_UNDOCK "ship-undock"
#define COMSIG_SHIP_BLOCKED_MOVE "ship-blocked-move"

// Allow the ship to perform this action
#define SHIP_ALLOW (1<<0)
// Do not allow the ship to perform this action
#define SHIP_BLOCK (1<<1)
// Always allow the ship to perform this action
#define SHIP_FORCE_ALLOW (1<<2)
// This overrides SHIP_FORCE_ALLOW
#define SHIP_FORCE_BLOCK (1<<3)

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

// Ship Module stuff
#define SHIP_SLOT_NONE "None"
#define SHIP_SLOT_SHIELD "Shield"
#define SHIP_SLOT_WEAPON "Weapon"
#define SHIP_SLOT_AUXILLARY "Auxillary"
#define SHIP_SLOT_UTILITY "Utility"
#define SHIP_MODULE_UNIQUE (1<<0)

GLOBAL_LIST_EMPTY_TYPED(ship_modules, /datum/ship_module)

/proc/populate_ship_modules()
	var/list/ret = new
	for(var/path in subtypesof(/datum/ship_module))
		var/datum/ship_module/m_path = path
		if(initial(m_path.abstract) == path)
			continue
		ret[path] = new path
	GLOB.ship_modules = ret

// Ship Weapon Defines
#define WEAPON_RICHOCHET 1
#define WEAPON_HIT 2
#define WEAPON_MISS 3
#define WEAPON_RICHOCHET_SELF 4
#define WEAPON_RELOADING 5
#define WEAPON_EMPTY 6
#define WEAPON_BROKEN 7
