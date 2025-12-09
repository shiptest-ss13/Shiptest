
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

// ~wound severities
#define WOUND_SEVERITY_TRIVIAL 0
#define WOUND_SEVERITY_MODERATE 1
#define WOUND_SEVERITY_SEVERE 2
#define WOUND_SEVERITY_CRITICAL 3
/// outright dismemberment of limb
#define WOUND_SEVERITY_LOSS 4


// ~wound categories
/// any brute weapon/attack that doesn't have sharpness. rolls for blunt bone wounds
#define WOUND_BLUNT "blunt"
/// any brute weapon/attack with sharpness = SHARP_EDGED. rolls for slash wounds
#define WOUND_SLASH "slash"
/// any brute weapon/attack with sharpness = SHARP_POINTY. rolls for piercing wounds
#define WOUND_PIERCE "pierce"
/// any concentrated burn attack (lasers really). rolls for burning wounds
#define WOUND_BURN "burn"
/// any brute attacks, rolled on a chance
#define WOUND_MUSCLE "muscle"
/// brute attacks vs. robotic limbs, more likely with sharpness = SHARP_NONE
#define WOUND_BUCKLING "buckling"
/// brute attacks vs. robotic limbs, more common with sharpness = SHARP_POINTY as well as bullets
#define WOUND_ELECTRIC "electric"
/// burn attacks and heat vs. robotic limbs
#define WOUND_WARP "warp"

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
/// Chance to roll a muscle wound from brute damage
#define MUSCLE_WOUND_CHANCE 20

// ~biology defines
// What kind of biology we have, and what wounds we can suffer, relies on the biological_state var on bodyparts.
/// can only suffer bone wounds, only needs mangled bone to be able to dismember
#define BIO_BONE (1<<0)
/// can suffer slashing, piercing, and burn wounds
#define BIO_FLESH (1<<1)
/// can suffer buckling, heat-warping, and electrical wounds
#define BIO_METAL (1<<2)

// ~wound flag defines
/// If having this wound mangles a limb enough for dismemberment
#define MANGLES_LIMB (1<<0)
/// If this wound marks the limb as being allowed to have gauze applied
#define ACCEPTS_GAUZE (1<<1)
/// If this wound marks the limb as being allowed to have splints applied
#define ACCEPTS_SPLINT (1<<2)
/// Whether this wound is fixed when replacing the external plating
#define PLATING_DAMAGE (1<<3)

/// When a wound is staining the gauze with blood
#define GAUZE_STAIN_BLOOD 1
/// When a wound is staining the gauze with pus
#define GAUZE_STAIN_PUS 2

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
