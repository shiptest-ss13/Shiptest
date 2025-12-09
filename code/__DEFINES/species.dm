// Pressure limits.
/// This determins at what pressure the ultra-high pressure red icon is displayed.
#define HAZARD_HIGH_PRESSURE 303
/// This determins when the orange pressure icon is displayed
#define WARNING_HIGH_PRESSURE 202
/// This is when the gray low pressure icon is displayed.
#define WARNING_LOW_PRESSURE 60
/// This is when the black ultra-low pressure icon is displayed.
#define HAZARD_LOW_PRESSURE 40

/// This is used in handle_temperature_damage() for humans, and in reagents that affect body temperature. Temperature damage is multiplied by this amount.
#define TEMPERATURE_DAMAGE_COEFFICIENT 1.5

/// The natural temperature for a body
#define HUMAN_BODYTEMP_NORMAL 310.15
/// The max temperature a body can get to
#define HUMAN_BODYTEMP_MAX HUMAN_BODYTEMP_NORMAL*2.5
/// This is the divisor which handles how much of the temperature difference between the current body temperature and 310.15K (optimal temperature) humans auto-regenerate each tick. The higher the number, the slower the recovery. This is applied each tick, so long as the mob is alive.
#define HUMAN_BODYTEMP_AUTORECOVERY_DIVISOR 11
/// Minimum amount of kelvin moved toward 310K per tick. So long as abs(310.15 - bodytemp) is more than 50.
#define HUMAN_BODYTEMP_AUTORECOVERY_MINIMUM 12
///Similar to the HUMAN_BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is lower than their body temperature. Make it lower to lose bodytemp faster.
#define HUMAN_BODYTEMP_COLD_DIVISOR 10
/// Similar to the HUMAN_BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is higher than their body temperature. Make it lower to gain bodytemp faster.
#define HUMAN_BODYTEMP_HEAT_DIVISOR 10
/// The maximum number of degrees that your body can cool in 1 tick, due to the environment, when in a cold area.
#define HUMAN_BODYTEMP_COOLING_MAX -20
/// The maximum number of degrees that your body can heat up in 1 tick, due to the environment, when in a hot area.
#define HUMAN_BODYTEMP_HEATING_MAX 10
/// The body temperature limit the human body can take before it starts taking damage from heat.
/// This also affects how fast the body normalises it's temperature when hot.
/// 340k is about 66c, and rather high for a human.
#define HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT (HUMAN_BODYTEMP_NORMAL + 30)
/// The body temperature limit the human body can take before it starts taking damage from cold.
/// This also affects how fast the body normalises it's temperature when cold.
/// 270k is about -3c, that is below freezing and would hurt over time.
#define HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT (HUMAN_BODYTEMP_NORMAL - 40)


//VOX DEFINES
#define VOX_BODYTEMP_HEAT_DIVISOR 10
#define VOX_BODYTEMP_COLD_DIVISOR 20
#define VOX_BODYTEMP_AUTORECOVERY_MIN 6
#define VOX_BODYTEMP_NORMAL 330.15 //CURRENTLY UNUSED
