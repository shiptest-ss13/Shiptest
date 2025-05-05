/*
//stages of shoe tying-ness
/// Shoes are untied
#define SHOES_UNTIED 0
/// Shoes are tied normally
#define SHOES_TIED 1
/// Shoes have been tied in knots
#define SHOES_KNOTTED 2

//suit sensors: sensor_mode defines
/// Suit sensor is turned off
#define SENSOR_OFF 0
/// Suit sensor displays the mob as alive or dead
#define SENSOR_LIVING 1
/// Suit sensor displays the mob damage values
#define SENSOR_VITALS 2
/// Suit sensor displays the mob damage values and exact location
#define SENSOR_COORDS 3

//suit sensors: has_sensor defines
/// Suit sensor has been EMP'd and cannot display any information (can be fixed)
#define BROKEN_SENSORS -1
/// Suit sensor is not present and cannot display any information
#define NO_SENSORS 0
/// Suit sensor is present and can display information
#define HAS_SENSORS 1
/// Suit sensor is present and is forced to display information (used on prisoner jumpsuits)
#define LOCKED_SENSORS 2
*/

/// Wrapper for adding clothing based traits
#define ADD_CLOTHING_TRAIT(mob, trait) ADD_TRAIT(mob, trait, "[CLOTHING_TRAIT]_[REF(src)]")
/// Wrapper for removing clothing based traits
#define REMOVE_CLOTHING_TRAIT(mob, trait) REMOVE_TRAIT(mob, trait, "[CLOTHING_TRAIT]_[REF(src)]")

/*
/// How much integrity does a shirt lose every time we bite it?
#define MOTH_EATING_CLOTHING_DAMAGE 15
*/

// Base equipment delays
/// Delay base for full-body coverage suit slot items. (hardsuits, spacesuits, radsuits, etc.)
#define EQUIP_DELAY_OVERSUIT (6 SECONDS)

/// Delay base for suit slot items
#define EQUIP_DELAY_SUIT (4 SECONDS)

/// Delay base for hard-body shoes and boots.
#define EQUIP_DELAY_BOOTS (2 SECONDS)
/// Delay base for hard-body, strapped, or otherwise head-covering hats.
#define EQUIP_DELAY_HELMET (2 SECONDS)
/// Delay base for shoes.
#define EQUIP_DELAY_SHOES (2 SECONDS)
/// Delay base for suit and cloak slot items that are trivially removed or put on. (Coats, Jackets, Ponchos, etc.)
#define EQUIP_DELAY_COAT (2 SECONDS)
/// Delay base for Undersuits.
#define EQUIP_DELAY_UNDERSUIT (2 SECONDS)

/// Delay base for masks.
#define EQUIP_DELAY_MASK (1 SECONDS)
/// Delay base for back-worn objects.
#define EQUIP_DELAY_BACK (1 SECONDS)
/// Delay base for belts.
#define EQUIP_DELAY_BELT (1 SECONDS)
/// Delay base for hats.
#define EQUIP_DELAY_HAT (1 SECONDS)
/// Delay base for gloves.
#define EQUIP_DELAY_GLOVES (1 SECONDS)
/// Delay base for glasses.
#define EQUIP_DELAY_EYEWEAR (1 SECONDS)

// Flags for self equipping items
/// Allow movement during equip/unequip
#define EQUIP_ALLOW_MOVEMENT (1<<0)
/// Apply a slowdown when equipping or unequipping.
#define EQUIP_SLOWDOWN (1<<1)

//sound defines for equipping and unequipping
#define EQUIP_SOUND_VFAST_GENERIC 'sound/items/equip/equipping_vfast_generic.ogg'
#define UNEQUIP_SOUND_VFAST_GENERIC 'sound/items/equip/unequipping_vfast_generic.ogg'

#define EQUIP_SOUND_SHORT_GENERIC 'sound/items/equip/equipping_short_generic.ogg'
#define UNEQUIP_SOUND_SHORT_GENERIC 'sound/items/equip/unequipping_short_generic.ogg'

#define EQUIP_SOUND_MED_GENERIC 'sound/items/equip/equipping_med_generic.ogg'
#define UNEQUIP_SOUND_MED_GENERIC 'sound/items/equip/unequipping_med_generic.ogg'

#define EQUIP_SOUND_LONG_GENERIC 'sound/items/equip/equipping_long_generic.ogg'
#define UNEQUIP_SOUND_LONG_GENERIC 'sound/items/equip/unequipping_long_generic.ogg'
