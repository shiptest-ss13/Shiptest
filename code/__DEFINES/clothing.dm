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
//Whitelist for the suit storage slot on medical suits
GLOBAL_LIST_INIT(medical_suit_allowed, typecacheof(list(
    /obj/item/scalpel, \
    /obj/item/cautery, \
    /obj/item/hemostat, \
    /obj/item/retractor, \
    /obj/item/surgicaldrill, \
    /obj/item/circular_saw, \
    /obj/item/analyzer, \
    /obj/item/sensor_device, \
    /obj/item/stack/medical, \
    /obj/item/dnainjector, \
    /obj/item/reagent_containers/dropper, \
    /obj/item/reagent_containers/syringe, \
    /obj/item/reagent_containers/hypospray, \
    /obj/item/healthanalyzer, \
    /obj/item/flashlight/pen, \
    /obj/item/reagent_containers/glass/bottle, \
    /obj/item/reagent_containers/glass/beaker, \
    /obj/item/reagent_containers/pill, \
    /obj/item/storage/pill_bottle, \
    /obj/item/paper, \
    /obj/item/melee/classic_baton/telescopic, \
    /obj/item/toy, \
    /obj/item/storage/fancy/cigarettes, \
    /obj/item/lighter, \
    /obj/item/tank/internals/emergency_oxygen, \
    /obj/item/tank/internals/plasmaman \
)))
