/*ALL DEFINES RELATED TO COMBAT GO HERE*/

//Damage and status effect defines

/// Physical fracturing and warping of the material.
#define BRUTE "brute"
/// Scorching and charring of the material.
#define BURN "fire"
/// Poisoning. Mostly caused by reagents.
#define TOX "toxin"
/// Suffocation.
#define OXY "oxygen"
#define CLONE "clone"
/// Exhaustion and nonlethal damage.
#define STAMINA "stamina"
/// Brain damage. Should probably be decommissioned and replaced with proper organ damage.
#define BRAIN "brain"


//Damage flag defines //

/// Involves corrosive substances.
#define ACID "acid"
/// Involved in checking whether a disease can infect or spread. Also involved in xeno neurotoxin.
#define BIO "bio"
/// Involves a shockwave, usually from an explosion.
#define BOMB "bomb"
/// Involves a solid projectile.
#define BULLET "bullet"
/// Involves being eaten
#define CONSUME "consume"
/// Involves an EMP or energy-based projectile.
#define ENERGY "energy"
/// Involves fire or temperature extremes.
#define FIRE "fire"
/// Involves a laser.
#define LASER "laser"
/// Involves a melee attack or a thrown object.
#define MELEE "melee"
//someone should really port wounds...
//so be it
/// Involved in checking the likelihood of applying a wound to a mob.
#define WOUND "wound"

#define ARMOR_ALL "all_damage_types"

#define EFFECT_STUN "stun"
#define EFFECT_KNOCKDOWN "knockdown"
#define EFFECT_UNCONSCIOUS "unconscious"
#define EFFECT_PARALYZE "paralyze"
#define EFFECT_IMMOBILIZE "immobilize"
#define EFFECT_IRRADIATE "irradiate"
#define EFFECT_STUTTER "stutter"
#define EFFECT_SLUR "slur"
#define EFFECT_EYE_BLUR "eye_blur"
#define EFFECT_DROWSY "drowsy"

//Bitflags defining which status effects could be or are inflicted on a mob
#define CANSTUN (1<<0)
#define CANKNOCKDOWN (1<<1)
#define CANUNCONSCIOUS (1<<2)
#define CANPUSH (1<<3)
#define GODMODE (1<<4)

//Health Defines
#define HEALTH_THRESHOLD_CRIT 0
#define HEALTH_THRESHOLD_FULLCRIT -30
#define HEALTH_THRESHOLD_DEAD -100

#define HEALTH_THRESHOLD_NEARDEATH -90 //Not used mechanically, but to determine if someone is so close to death they hear the other side

//Actual combat defines

//click cooldowns, in tenths of a second, used for various combat actions
#define HEAVY_WEAPON_CD 10
#define CLICK_CD_BLOCKED 10
#define CLICK_CD_MELEE 8
#define LIGHT_WEAPON_CD 6
#define CLICK_CD_RANGE 4
#define CLICK_CD_RAPID 2
#define CLICK_CD_CLICK_ABILITY 6
#define CLICK_CD_BREAKOUT 100
#define CLICK_CD_HANDCUFFED 10
#define CLICK_CD_RESIST 20
#define CLICK_CD_GRABBING 10
#define CLICK_CD_LOOK_UP 5

//Cuff resist speeds
#define FAST_CUFFBREAK 1
#define INSTANT_CUFFBREAK 2

//Grab levels
#define GRAB_PASSIVE 0
#define GRAB_AGGRESSIVE 1
#define GRAB_NECK 2
#define GRAB_KILL 3

//Grab breakout odds
#define BASE_GRAB_RESIST_CHANCE 30

//slowdown when in softcrit. Note that crawling slowdown will also apply at the same time!
#define SOFTCRIT_ADD_SLOWDOWN 2
//slowdown when crawling
#define CRAWLING_ADD_SLOWDOWN 4

//Attack types for checking shields/hit reactions
#define MELEE_ATTACK 1
#define UNARMED_ATTACK 2
#define PROJECTILE_ATTACK 3
#define THROWN_PROJECTILE_ATTACK 4
#define LEAP_ATTACK 5
#define ALL_ATTACK_TYPES list(MELEE_ATTACK, UNARMED_ATTACK, PROJECTILE_ATTACK, THROWN_PROJECTILE_ATTACK, LEAP_ATTACK)
#define NON_PROJECTILE_ATTACKS list(MELEE_ATTACK, UNARMED_ATTACK, LEAP_ATTACK)

//attack visual effects
#define ATTACK_EFFECT_PUNCH "punch"
#define ATTACK_EFFECT_KICK "kick"
#define ATTACK_EFFECT_SMASH "smash"
#define ATTACK_EFFECT_CLAW "claw"
#define ATTACK_EFFECT_SLASH "slash"
#define ATTACK_EFFECT_DISARM "disarm"
#define ATTACK_EFFECT_BITE "bite"
#define ATTACK_EFFECT_MECHFIRE "mech_fire"
#define ATTACK_EFFECT_MECHTOXIN "mech_toxin"
#define ATTACK_EFFECT_BOOP "boop" //Honk

//intent defines
#define INTENT_HELP "help"
#define INTENT_GRAB "grab"
#define INTENT_DISARM "disarm"
#define INTENT_HARM "harm"
//NOTE: INTENT_HOTKEY_* defines are not actual intents!
//they are here to support hotkeys
#define INTENT_HOTKEY_LEFT "left"
#define INTENT_HOTKEY_RIGHT "right"

//the define for visible message range in combat
#define COMBAT_MESSAGE_RANGE 3
#define DEFAULT_MESSAGE_RANGE 7

//Shove knockdown lengths (deciseconds)
#define SHOVE_KNOCKDOWN_SOLID 30
#define SHOVE_KNOCKDOWN_HUMAN 30
#define SHOVE_KNOCKDOWN_TABLE 30
#define SHOVE_KNOCKDOWN_COLLATERAL 10
#define SHOVE_CHAIN_PARALYZE 40
//Shove slowdown
#define SHOVE_SLOWDOWN_LENGTH 30
#define SHOVE_SLOWDOWN_STRENGTH 0.85 //multiplier
//Shove disarming item list
GLOBAL_LIST_INIT(shove_disarming_types, typecacheof(list(/obj/item/gun)))

//Combat object defines

//Embedded objects

///Chance for embedded objects to cause pain (damage user)
#define EMBEDDED_PAIN_CHANCE 15
///Chance for embedded object to fall out (causing pain but removing the object)
#define EMBEDDED_ITEM_FALLOUT 5
///Chance for an object to embed into somebody when thrown
#define EMBED_CHANCE 45
///Coefficient of multiplication for the damage the item does while embedded (this*item.w_class)
#define EMBEDDED_PAIN_MULTIPLIER 2
///Coefficient of multiplication for the damage the item does when it first embeds (this*item.w_class)
#define EMBEDDED_IMPACT_PAIN_MULTIPLIER 4
///The minimum value of an item's throw_speed for it to embed (Unless it has embedded_ignore_throwspeed_threshold set to 1)
#define EMBED_THROWSPEED_THRESHOLD 4
///Coefficient of multiplication for the damage the item does when it falls out or is removed without a surgery (this*item.w_class)
#define EMBEDDED_UNSAFE_REMOVAL_PAIN_MULTIPLIER 6
///A Time in ticks, total removal time = (this*item.w_class)
#define EMBEDDED_UNSAFE_REMOVAL_TIME 30
///Chance for embedded objects to cause pain every time they move (jostle)
#define EMBEDDED_JOSTLE_CHANCE 5
///Coefficient of multiplication for the damage the item does while
#define EMBEDDED_JOSTLE_PAIN_MULTIPLIER 1
///This percentage of all pain will be dealt as stam damage rather than brute (0-1)
#define EMBEDDED_PAIN_STAM_PCT 0.0
///For thrown weapons, every extra speed it's thrown at above its normal throwspeed will add this to the embed chance
#define EMBED_CHANCE_SPEED_BONUS 10

#define EMBED_HARMLESS list("pain_mult" = 0, "jostle_pain_mult" = 0, "ignore_throwspeed_threshold" = TRUE)
#define EMBED_HARMLESS_SUPERIOR list("pain_mult" = 0, "jostle_pain_mult" = 0, "ignore_throwspeed_threshold" = TRUE, "embed_chance" = 100, "fall_chance" = 0.1)
#define EMBED_POINTY list("ignore_throwspeed_threshold" = TRUE)
#define EMBED_POINTY_SUPERIOR list("embed_chance" = 100, "ignore_throwspeed_threshold" = TRUE)

//Object/Item sharpness
#define SHARP_NONE 0
#define SHARP_EDGED 1
#define SHARP_POINTY 2

#define EXPLODE_NONE 0 //Don't even ask me why we need this.
#define EXPLODE_DEVASTATE 1
#define EXPLODE_HEAVY 2
#define EXPLODE_LIGHT 3
#define EXPLODE_GIB_THRESHOLD 50 //ex_act() with EXPLODE_DEVASTATE severity will gib mobs with less than this much bomb armor

#define EMP_HEAVY 1
#define EMP_LIGHT 2

#define GRENADE_CLUMSY_FUMBLE 1
#define GRENADE_NONCLUMSY_FUMBLE 2
#define GRENADE_NO_FUMBLE 3

#define BODY_ZONE_HEAD "head"
#define BODY_ZONE_CHEST "chest"
#define BODY_ZONE_L_ARM "l_arm"
#define BODY_ZONE_R_ARM "r_arm"
#define BODY_ZONE_L_LEG "l_leg"
#define BODY_ZONE_R_LEG "r_leg"

#define BODY_ZONE_PRECISE_EYES "eyes"
#define BODY_ZONE_PRECISE_MOUTH "mouth"
#define BODY_ZONE_PRECISE_GROIN "groin"
#define BODY_ZONE_PRECISE_L_HAND "l_hand"
#define BODY_ZONE_PRECISE_R_HAND "r_hand"
#define BODY_ZONE_PRECISE_L_FOOT "l_foot"
#define BODY_ZONE_PRECISE_R_FOOT "r_foot"

//We will round to this value in damage calculations.
#define DAMAGE_PRECISION 0.1

/// Alternate attack defines. Return these at the end of procs like afterattack_secondary.
/// Calls the normal attack proc. For example, if returned in afterattack_secondary, will call afterattack.
/// Will continue the chain depending on the return value of the non-alternate proc, like with normal attacks.
#define SECONDARY_ATTACK_CALL_NORMAL 1

/// Cancels the attack chain entirely.
#define SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN 2

/// Proceed with the attack chain, but don't call the normal methods.
#define SECONDARY_ATTACK_CONTINUE_CHAIN 3

/// Calculates the new armour value after armour penetration. Can return negative values, and those must be caught.
#define PENETRATE_ARMOUR(armour, penetration) (penetration == 100 ? 0 : 100 * (armour - penetration) / (100 - penetration))
