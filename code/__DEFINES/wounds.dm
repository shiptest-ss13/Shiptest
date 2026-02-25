
// ~wound damage/rolling defines
/// the cornerstone of the wound threshold system, your base wound roll for any attack is rand(1, damage^this), after armor reduces said damage. See [/obj/item/bodypart/proc/check_wounding]
#define WOUND_DAMAGE_EXPONENT 1.4
/// any damage dealt over this is ignored for damage rolls
#define WOUND_MAX_CONSIDERED_DAMAGE 35
/// an attack must do this much damage after armor in order to roll for being a wound (so pressure damage/being on fire doesn't proc it)
#define WOUND_MINIMUM_DAMAGE 5
/// an attack must do this much damage after armor in order to be eliigible to dismember a suitably mushed bodypart
#define DISMEMBER_MINIMUM_DAMAGE 10
/// If an attack rolls this high with their wound (including mods), we try to outright dismember the limb. Note 250 is high enough that with a perfect max roll of 145 (see max cons'd damage), you'd need +100 in mods to do this
#define WOUND_DISMEMBER_OUTRIGHT_THRESH 250
/// set wound_bonus on an item or attack to this to disable checking wounding for the attack
#define CANT_WOUND -100

/// If there are multiple possible and valid wounds for the same type and severity, weight will be used to pick among them. See _wound_pregen_data.dm for more details
/// This is used in pick_weight, so use integers
#define WOUND_DEFAULT_WEIGHT 50
/// Chance to roll a muscle wound from brute damage
#define WOUND_MUSCLE_WEIGHT 15

// ~wound severities
#define WOUND_SEVERITY_TRIVIAL 0
#define WOUND_SEVERITY_MODERATE 1
#define WOUND_SEVERITY_SEVERE 2
#define WOUND_SEVERITY_CRITICAL 3
/// outright dismemberment of limb
#define WOUND_SEVERITY_LOSS 4


// ~wound categories: wounding_types
/// any brute weapon/attack that doesn't have sharpness. rolls for blunt bone and metal buckling wounds
#define WOUND_BLUNT "wound_blunt"
/// any brute weapon/attack with sharpness = SHARP_EDGED. rolls for slash wounds
#define WOUND_SLASH "wound_slash"
/// any brute weapon/attack with sharpness = SHARP_POINTY. rolls for piercing and electrical wounds
#define WOUND_PIERCE "wound_pierce"
/// any concentrated burn attack (lasers really). rolls for burning, heat-warping, and electrical wounds
#define WOUND_BURN "wound_burn"

/// Mainly a define used for wound_pregen_data, if a pregen data instance expects this, it will accept any and all wound types, even none at all
#define WOUND_ALL "wound_all"

// ~determination second wind defines
// How much determination reagent to add each time someone gains a new wound in [/datum/wound/proc/second_wind]
#define WOUND_DETERMINATION_MODERATE 1
#define WOUND_DETERMINATION_SEVERE 2.5
#define WOUND_DETERMINATION_CRITICAL 5
#define WOUND_DETERMINATION_LOSS 7.5
/// the max amount of determination you can have
#define WOUND_DETERMINATION_MAX 10

/// While someone has determination in their system, their bleed rate is slightly reduced
#define WOUND_DETERMINATION_BLEED_MOD 0.85

/// Wounds using this competition mode will remove any wounds of a greater severity than itself in a random wound roll. In most cases, you dont want to use this.
#define WOUND_COMPETITION_OVERPOWER_GREATERS "wound_submit"
/// Wounds using this competition mode will remove any wounds of a lower severity than itself in a random wound roll. Used for ensuring the worse case scenario of a given injury_roll.
#define WOUND_COMPETITION_OVERPOWER_LESSERS "wound_dominate"

// ~burn wound infection defines
// Thresholds for infection for burn wounds, once infestation hits each threshold, things get steadily worse
/// below this has no ill effects from infection
#define WOUND_INFECTION_MODERATE 4
/// then below here, you ooze some pus and suffer minor tox damage, but nothing serious
#define WOUND_INFECTION_SEVERE 8
/// then below here, your limb occasionally locks up from damage and infection and briefly becomes disabled. Things are getting really bad
#define WOUND_INFECTION_CRITICAL 12
/// below here, your skin is almost entirely falling off and your limb locks up more frequently. You are within a stone's throw of septic paralysis and losing the limb
#define WOUND_INFECTION_SEPTIC 20
// above WOUND_INFECTION_SEPTIC, your limb is completely putrid and you start rolling to lose the entire limb by way of paralyzation. After 3 failed rolls (~4-5% each probably), the limb is paralyzed


// ~random wound balance defines
/// how quickly sanitization removes infestation and decays per tick
#define WOUND_BURN_SANITIZATION_RATE 0.30
/// how much blood you can lose per tick per slash max.
#define WOUND_SLASH_MAX_BLOODFLOW 6
/// dead people don't bleed, but they can clot! this is the minimum amount of clotting per tick on dead people, so even critical cuts will slowly clot in dead people
#define WOUND_SLASH_DEAD_CLOT_MIN 0.05
/// if we suffer a bone wound to the head that creates brain traumas, the timer for the trauma cycle is +/- by this percent (0-100)
#define WOUND_BONE_HEAD_TIME_VARIANCE 20
/// charge drain per severity level
#define WOUND_ELECTRIC_POWER_DRAIN 0.05

// ~biology defines
// What kind of biology we have, and what wounds we can suffer, relies on the biological_state var on bodyparts.
/// Has absolutely fucking nothing, no wounds
#define BIO_INORGANIC NONE
/// Has bone - allows the victim to suffer T2-T3 bone blunt wounds
#define BIO_BONE (1<<0)
/// Has flesh - allows the victim to suffer fleshy slash pierce and burn wounds
#define BIO_FLESH (1<<1)
/// Has metal - allows the victim to suffer buckling and heat-warping wounds
#define BIO_METAL (1<<2)
/// Is wired internally - allows the victim to suffer electrical wounds (robotic T1-T3 slash/pierce)
#define BIO_WIRED (1<<3)
/// Has bloodflow - can suffer bleeding wounds and can bleed
#define BIO_BLOODED (1<<4)
/// Is connected by a joint - can suffer T1 bone blunt wounds (dislocation)
#define BIO_JOINTED (1<<5)

/// Robotic - can suffer all metal/wired wounds, such as: UNIMPLEMENTED PLEASE UPDATE ONCE SYNTH WOUNDS 9/5/2023 ~Niko
#define BIO_ROBOTIC (BIO_METAL|BIO_WIRED)
/// Has flesh and bone - See BIO_BONE and BIO_FLESH
#define BIO_FLESH_BONE (BIO_BONE|BIO_FLESH)
/// Standard humanoid - can bleed and suffer all flesh/bone wounds, such as: T1-3 slash/pierce/burn/blunt, except dislocations. Think human heads/chests
#define BIO_STANDARD_UNJOINTED (BIO_FLESH_BONE|BIO_BLOODED)
/// Standard humanoid limbs - can bleed and suffer all flesh/bone wounds, such as: T1-3 slash/pierce/burn/blunt. Can also bleed, and be dislocated. Think human arms and legs
#define BIO_STANDARD_JOINTED (BIO_STANDARD_UNJOINTED|BIO_JOINTED)

// "Where" a specific biostate is within a given limb
// Interior is hard shit, the last line, shit like bones
// Exterior is soft shit, targetted by slashes and pierces (usually), protects exterior
// A limb needs both mangled interior and exterior to be dismembered, but slash/pierce must mangle exterior to attack the interior
// Not having exterior/interior counts as mangled exterior/interior for the purposes of dismemberment
/// The given biostate is on the "interior" of the limb - hard shit, protected by exterior
#define ANATOMY_INTERIOR (1<<0)
/// The given biostate is on the "exterior" of the limb - soft shit, protects interior
#define ANATOMY_EXTERIOR (1<<1)
#define ANATOMY_EXTERIOR_AND_INTERIOR (ANATOMY_EXTERIOR|ANATOMY_INTERIOR)

// Wound series
// A "wound series" is just a family of wounds that logically follow eachother
// Multiple wounds in a single series cannot be on a limb - the highest severity will always be prioritized, and lower ones will be skipped

/// T1-T3 Bleeding slash wounds. Requires flesh. Can cause bleeding, but doesn't require it. From: slash.dm
#define WOUND_SERIES_FLESH_SLASH_BLEED "wound_series_flesh_slash_bled"
/// T1-T3 Basic blunt wounds. T1 requires jointed, but 2-3 require bone. From: bone.dm
#define WOUND_SERIES_BONE_BLUNT_BASIC "wound_series_bone_blunt_basic"
/// T1-T3 Basic burn wounds. Requires flesh. From: burns.dm
#define WOUND_SERIES_FLESH_BURN_BASIC "wound_series_flesh_burn_basic"
/// T1-3 Bleeding puncture wounds. Requires flesh. Can cause bleeding, but doesn't require it. From: pierce.dm
#define WOUND_SERIES_FLESH_PUNCTURE_BLEED "wound_series_flesh_puncture_bleed"
/// T1-3 Buckling wounds. Requires metal. From: buckling.dm
#define WOUND_SERIES_METAL_BUCKLING "wound_series_metal_buckling"
/// T1-3 Heat-warping wounds. Requires metal. From: heat_warping.dm
#define WOUND_SERIES_METAL_HEAT_WARPING "wound_series_metal_heat_warping"
/// T1-3 Electrical wounds. Requires wired. From: electrical.dm
#define WOUND_SERIES_WIRED_ELECTRICAL "wound_series_wired_electrical"
/// T1-3 Muscle wounds. Requires flesh. From: muscle.dm
#define WOUND_SERIES_FLESH_MUSCLE "wound_series_flesh_muscle"
/// Generic loss wounds. See loss.dm
#define WOUND_SERIES_LOSS_BASIC "wound_series_loss_basic"

/// Used in get_corresponding_wound_type(): Will pick the highest severity wound out of severity_min and severity_max
#define WOUND_PICK_HIGHEST_SEVERITY 1
/// Used in get_corresponding_wound_type(): Will pick the lowest severity wound out of severity_min and severity_max
#define WOUND_PICK_LOWEST_SEVERITY 2

// With the wounds pt. 2 update, general dismemberment now requires 2 things for a limb to be dismemberable (exterior/bone only creatures just need the second):
// 1. Exterior is mangled: A critical slash or pierce wound on that limb
// 2. Interior is mangled: At least a severe bone wound on that limb
// Lack of exterior or interior count as mangled exterior/interior respectively
// see [/obj/item/bodypart/proc/get_mangled_state] for more information, as well as GLOB.bio_state_anatomy
#define BODYPART_MANGLED_NONE NONE
#define BODYPART_MANGLED_INTERIOR (1<<0)
#define BODYPART_MANGLED_EXTERIOR (1<<1)
#define BODYPART_MANGLED_BOTH (BODYPART_MANGLED_INTERIOR | BODYPART_MANGLED_EXTERIOR)

// ~wound flag defines
/// If having this wound counts as mangled exterior for dismemberment
#define MANGLES_EXTERIOR (1<<0)
/// If having this wound counts as mangled interior for dismemberment
#define MANGLES_INTERIOR (1<<1)
/// If this wound marks the limb as being allowed to have gauze applied
#define ACCEPTS_GAUZE (1<<2)
/// If this wound marks the limb as being allowed to have splints applied
#define ACCEPTS_SPLINT (1<<3)
/// Whether this wound is fixed when replacing the external plating
#define PLATING_DAMAGE (1<<4)
/// If this wound allows the victim to grasp it
#define CAN_BE_GRASPED (1<<5)
/// This causes the wound to numb the affected limb
#define NUMBS_BODYPART (1<<6)

/// When a wound is staining the gauze with blood
#define GAUZE_STAIN_BLOOD 1
/// When a wound is staining the gauze with pus
#define GAUZE_STAIN_PUS 2

/// Limb integrity is reduced to this before being used to calculate how much integrity loss it should have.
#define WOUND_MAX_INTEGRITY_CONSIDERED 50

// ~blood_flow rates of change, these are used by [/datum/wound/proc/get_bleed_rate_of_change] from [/mob/living/carbon/proc/bleed_warn] to let the player know if their bleeding is getting better/worse/the same
/// Our wound is clotting and will eventually stop bleeding if this continues
#define BLOOD_FLOW_DECREASING -1
/// Our wound is bleeding but is holding steady at the same rate.
#define BLOOD_FLOW_STEADY 0
/// Our wound is bleeding and actively getting worse, like if we're a critical slash or if we're afflicted with heparin
#define BLOOD_FLOW_INCREASING 1

/// How often can we annoy the player about their bleeding? This duration is extended if it's not serious bleeding
#define BLEEDING_MESSAGE_BASE_CD 10 SECONDS

/// Skeletons and other BIO_ONLY_BONE creatures respond much better to bone gel and can have severe and critical bone wounds healed by bone gel alone. The duration it takes to heal is also multiplied by this, lucky them!
#define WOUND_BONE_BIO_BONE_GEL_MULT 0.25
