#define MECHA_INT_FIRE (1<<0)
#define MECHA_INT_TEMP_CONTROL (1<<1)
#define MECHA_INT_SHORT_CIRCUIT (1<<2)
#define MECHA_INT_TANK_BREACH (1<<3)
#define MECHA_INT_CONTROL_LOST (1<<4)

#define MECHA_MELEE (1 << 0)
#define MECHA_RANGED (1 << 1)

#define MECHA_FRONT_ARMOUR 1
#define MECHA_SIDE_ARMOUR 2
#define MECHA_BACK_ARMOUR 3

#define MECHA_LOCKED 0
#define MECHA_SECURE_BOLTS 1
#define MECHA_LOOSE_BOLTS 2
#define MECHA_OPEN_HATCH 3

/// Minimum overheat to show an alert to the pilot
#define OVERHEAT_WARNING 50
/// Minimum overheat required to cause slowdown
#define OVERHEAT_THRESHOLD 100
/// Maximum overheat caused by EMPs, prevents permanent lockdown from ion rifles
#define OVERHEAT_EMP_MAX 130
/// Maximum overheat level possible, causes total immobilization
#define OVERHEAT_MAXIMUM 150
/// Amount of overheat reduced every process
#define PASSIVE_COOLING -5
/// Amount of cooling per decisecond-tick while stationary
#define STATIONARY_COOLING -0.1
/// Maximum cooling per second-tick from being stationary
#define STATIONARY_COOLING_MAXIMUM -10
/// Maximum heating from being in a hot environment
#define ENVIRONMENT_HEATING 5
/// Overheating per tile moved when overload is active
#define OVERLOAD_HEAT_COST 5

/// This trait is caused by overheating
#define OVERHEAT_TRAIT "overheating"
