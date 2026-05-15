// -- Defines for the pain system. --

/// Pained Limp status effect
#define STATUS_EFFECT_LIMP_PAIN /datum/status_effect/limp/pain
/// Low blood pressure
#define STATUS_EFFECT_LOWBLOODPRESSURE /datum/status_effect/low_blood_pressure

/// Sent when a carbon gains pain. (obj/item/bodypart/affected_bodypart, amount, type)
#define COMSIG_CARBON_PAIN_GAINED "pain_gain"
/// Sent when a carbon loses pain. (obj/item/bodypart/affected_bodypart, amount, type)
#define COMSIG_CARBON_PAIN_LOST "pain_loss"

/// Various lists of body zones affected by pain.
#define BODY_ZONES_ALL list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
#define BODY_ZONES_MINUS_HEAD list(BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
#define BODY_ZONES_LIMBS list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

/// List of some emotes that convey pain.
#define PAIN_EMOTES list("wince", "gasp", "grimace", "shiver", "sway", "twitch_s", "whimper", "inhale_s", "exhale_s", "groan", "moan")

/// Amount of pain gained from dismembered limb
#define PAIN_LIMB_DISMEMBERED 65
/// Amount of pain gained from surgically removed limb (given to the chest)
#define PAIN_LIMB_REMOVED 20

/// Max pains for bodyparts
#define PAIN_LIMB_MAX 70
#define PAIN_CHEST_MAX 120
#define PAIN_HEAD_MAX 100

/// Keys for pain modifiers
#define PAIN_MOD_CHEMS "chems"
#define PAIN_MOD_DRUNK "drunk"
#define PAIN_MOD_SLEEP "asleep"
#define PAIN_MOD_STASIS "stasis"
#define PAIN_MOD_DROWSY "drowsy"
#define PAIN_MOD_NEAR_DEATH "near-death"
#define PAIN_MOD_RECENT_SHOCK "recently-shocked"
#define PAIN_MOD_YOUTH "youth"
#define PAIN_MOD_TENACITY "tenacity"
#define PAIN_MOD_QUIRK "quirk"
#define PAIN_MOD_SPECIES "species"

/// ID for traits and modifiers gained by pain
#define PAIN_LIMB_PARALYSIS "pain_paralysis"
#define MOVESPEED_ID_PAIN "pain_movespeed"
#define ACTIONSPEED_ID_PAIN "pain_actionspeed"
#define TRAIT_EXTRA_PAIN "extra_pain"
