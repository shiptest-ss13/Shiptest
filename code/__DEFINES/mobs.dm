/*ALL MOB-RELATED DEFINES THAT DON'T BELONG IN ANOTHER FILE GO HERE*/

//Misc mob defines

//Ready states at roundstart for mob/dead/new_player
#define PLAYER_NOT_READY 0
#define PLAYER_READY_TO_PLAY 1
#define PLAYER_READY_TO_OBSERVE 2

//Game mode list indexes
#define CURRENT_LIVING_PLAYERS "living_players_list"
#define CURRENT_LIVING_ANTAGS "living_antags_list"
#define CURRENT_DEAD_PLAYERS "dead_players_list"
#define CURRENT_OBSERVERS "current_observers_list"

//movement intent defines for the m_intent var
#define MOVE_INTENT_WALK "walk"
#define MOVE_INTENT_RUN "run"

//Blood levels
#define BLOOD_VOLUME_MAX_LETHAL 2150
#define BLOOD_VOLUME_EXCESS 2100
#define BLOOD_VOLUME_MAXIMUM 2000
#define BLOOD_VOLUME_SLIME_SPLIT 1120
#define BLOOD_VOLUME_NORMAL 560
#define BLOOD_VOLUME_SAFE 475
#define BLOOD_VOLUME_OKAY 336
#define BLOOD_VOLUME_BAD 224
#define BLOOD_VOLUME_SURVIVE 122

//Sizes of mobs, used by mob/living/var/mob_size
#define MOB_SIZE_TINY 0
#define MOB_SIZE_SMALL 1
#define MOB_SIZE_HUMAN 2
#define MOB_SIZE_LARGE 3
#define MOB_SIZE_HUGE 4 // Use this for things you don't want bluespace body-bagged

//Ventcrawling defines
#define VENTCRAWLER_NONE 0
#define VENTCRAWLER_NUDE 1
#define VENTCRAWLER_ALWAYS 2

//Bloodcrawling defines
#define BLOODCRAWL 1 /// bloodcrawling, see: [/mob/living/var/bloodcrawl]
#define BLOODCRAWL_EAT 2 /// crawling+mob devour

//Mob bio-types flags
///The mob is organic, can heal from medical sutures.
#define MOB_ORGANIC (1 << 0)
///The mob is of a rocky make, most likely a golem. Iron within, iron without!
#define MOB_MINERAL (1 << 1)
///The mob is a synthetic lifeform, like station borgs.
#define MOB_ROBOTIC (1 << 2)
///The mob is an shambling undead corpse. Or a halloween species. Pick your poison.
#define MOB_UNDEAD (1 << 3)
///The mob is a human-sized human-like human-creature.
#define MOB_HUMANOID (1 << 4)
///The mob is a bug/insect/arachnid/some other kind of scuttly thing.
#define MOB_BUG (1 << 5)
///The mob is a wild animal. Domestication may apply.
#define MOB_BEAST (1 << 6)
///The mob is some kind of a creature that should be exempt from certain **fun** interactions for balance reasons, i.e. megafauna or a headslug.
#define MOB_SPECIAL (1 << 7)
///The mob is some kind of a scaly reptile creature
#define MOB_REPTILE (1 << 8)
///The mob is a spooky phantasm or an evil ghast of such nature.
#define MOB_SPIRIT (1 << 9)
///The mob is a plant-based species, benefitting from light but suffering from darkness and plantkillers.
#define MOB_PLANT (1 << 10)
///The mob is fish or water-related.
#define MOB_AQUATIC (1 << 11)
///The mob is a crustacean. Like crabs. Or lobsters.
#define MOB_CRUSTACEAN (1 << 12)

//Organ defines for carbon mobs
#define ORGAN_ORGANIC 1
#define ORGAN_ROBOTIC 2

#define BODYPART_ORGANIC 1
#define BODYPART_ROBOTIC 2

#define DEFAULT_BODYPART_ICON_ORGANIC 'icons/mob/human_parts_greyscale.dmi'
#define DEFAULT_BODYPART_ICON_ROBOTIC 'icons/mob/augmentation/augments.dmi'

#define MONKEY_BODYPART "monkey"
#define ALIEN_BODYPART "alien"
#define LARVA_BODYPART "larva"

//Defines for Species IDs
#define SPECIES_ABDUCTOR "abductor"
#define SPECIES_ANDROID "android"
#define SPECIES_CORPORATE "corporate"
#define SPECIES_DULLAHAN "dullahan"
#define SPECIES_ELZUOSE "elzuose"
#define SPECIES_FLYPERSON "fly"
#define SPECIES_HUMAN "human"
#define SPECIES_IPC "ipc"
#define SPECIES_JELLYPERSON "jelly"
#define SPECIES_SLIMEPERSON "slime_person"
#define SPECIES_LUMINESCENT "luminescent"
#define SPECIES_STARGAZER "stargazer"
#define SPECIES_SARATHI "sarathi"
#define SPECIES_ASHWALKER "ashwalker"
#define SPECIES_KOBOLD "kobold"
#define SPECIES_MONKEY "monkey"
#define SPECIES_MOTH "moth"
#define SPECIES_PLASMAMAN "plasmaman"
#define SPECIES_POD "pod"
#define SPECIES_SHADOW "shadow"
#define SPECIES_SKELETON "skeleton"
#define SPECIES_SNAIL "snail"
#define SPECIES_RACHNID "rachnid"
#define SPECIES_KEPORI "kepori"
#define SPECIES_VAMPIRE "vampire"
#define SPECIES_VOX "vox"
#define SPECIES_ZOMBIE "zombie"
#define SPECIES_XENOMORPH "xenomorph"

#define DIGITIGRADE_NEVER 0
#define DIGITIGRADE_OPTIONAL 1
#define DIGITIGRADE_FORCED 2

//Reagent Metabolization flags, defines the type of reagents that affect this mob
#define PROCESS_ORGANIC 1 //Only processes reagents with "ORGANIC" or "ORGANIC | SYNTHETIC"
#define PROCESS_SYNTHETIC 2 //Only processes reagents with "SYNTHETIC" or "ORGANIC | SYNTHETIC"

// Reagent type flags, defines the types of mobs this reagent will affect
#define ORGANIC 1
#define SYNTHETIC 2

//Species bitflags for sprite sheets. If this somehow ever gets above 23 we have larger problems.
#define FLAG_HUMAN (1<<0)
#define FLAG_IPC (1<<1)
#define FLAG_ELZUOSE (1<<2)
#define FLAG_PLASMAMAN (1<<3)
#define FLAG_MOTH (1<<4)
#define FLAG_LIZARD (1<<5)
#define FLAG_FLY (1<<6)
#define FLAG_MONKEY (1<<7)

//Bodytype defines for how things can be worn.
#define BODYTYPE_ORGANIC (1<<0)
#define BODYTYPE_ROBOTIC (1<<1)
#define BODYTYPE_HUMANOID (1<<2) //Everything
#define BODYTYPE_SNOUT (1<<3) //Snouts
#define BODYTYPE_SNOUT_SMALL (1<<4) //Elzuose snouts
#define BODYTYPE_BOXHEAD (1<<5) //TV Head
#define BODYTYPE_DIGITIGRADE (1<<6) //Lizard legs
#define BODYTYPE_KEPORI (1<<7) //Just Kepori
#define BODYTYPE_VOX (1<<8) //Big Vox

// Health/damage defines
#define MAX_LIVING_HEALTH 100

#define HUMAN_MAX_OXYLOSS 3
#define HUMAN_CRIT_MAX_OXYLOSS (SSmobs.wait/30)

#define STAMINA_REGEN_BLOCK_TIME (10 SECONDS)

#define HEAT_DAMAGE_LEVEL_1 2 //Amount of damage applied when your body temperature just passes the 360.15k safety point
#define HEAT_DAMAGE_LEVEL_2 3 //Amount of damage applied when your body temperature passes the 400K point
#define HEAT_DAMAGE_LEVEL_3 8 //Amount of damage applied when your body temperature passes the 460K point and you are on fire

#define COLD_DAMAGE_LEVEL_1 0.5 //Amount of damage applied when your body temperature just passes the 260.15k safety point
#define COLD_DAMAGE_LEVEL_2 1.5 //Amount of damage applied when your body temperature passes the 200K point
#define COLD_DAMAGE_LEVEL_3 3 //Amount of damage applied when your body temperature passes the 120K point

//Note that gas heat damage is only applied once every FOUR ticks.
#define HEAT_GAS_DAMAGE_LEVEL_1 2 //Amount of damage applied when the current breath's temperature just passes the 360.15k safety point
#define HEAT_GAS_DAMAGE_LEVEL_2 4 //Amount of damage applied when the current breath's temperature passes the 400K point
#define HEAT_GAS_DAMAGE_LEVEL_3 8 //Amount of damage applied when the current breath's temperature passes the 1000K point

#define COLD_GAS_DAMAGE_LEVEL_1 0.5 //Amount of damage applied when the current breath's temperature just passes the 260.15k safety point
#define COLD_GAS_DAMAGE_LEVEL_2 1.5 //Amount of damage applied when the current breath's temperature passes the 200K point
#define COLD_GAS_DAMAGE_LEVEL_3 3 //Amount of damage applied when the current breath's temperature passes the 120K point

//Brain Damage defines
#define BRAIN_DAMAGE_MILD 20
#define BRAIN_DAMAGE_SEVERE 100
#define BRAIN_DAMAGE_DEATH 200

#define BRAIN_TRAUMA_MILD /datum/brain_trauma/mild
#define BRAIN_TRAUMA_SEVERE /datum/brain_trauma/severe
#define BRAIN_TRAUMA_SPECIAL /datum/brain_trauma/special
#define BRAIN_TRAUMA_MAGIC /datum/brain_trauma/magic

#define TRAUMA_RESILIENCE_BASIC 1 //Curable with chems
#define TRAUMA_RESILIENCE_SURGERY 2 //Curable with brain surgery
#define TRAUMA_RESILIENCE_LOBOTOMY 3 //Curable with lobotomy
#define TRAUMA_RESILIENCE_WOUND 4 //Curable by healing the head wound
#define TRAUMA_RESILIENCE_MAGIC 5 //Curable only with magic
#define TRAUMA_RESILIENCE_ABSOLUTE 6 //This is here to stay

//Limit of traumas for each resilience tier
#define TRAUMA_LIMIT_BASIC 3
#define TRAUMA_LIMIT_SURGERY 2
#define TRAUMA_LIMIT_LOBOTOMY 3
#define TRAUMA_LIMIT_MAGIC 3
#define TRAUMA_LIMIT_WOUND 2
#define TRAUMA_LIMIT_ABSOLUTE INFINITY

#define BRAIN_DAMAGE_INTEGRITY_MULTIPLIER 0.5

//Surgery Defines
#define BIOWARE_GENERIC "generic"
#define BIOWARE_NERVES "nerves"
#define BIOWARE_CIRCULATION "circulation"
#define BIOWARE_LIGAMENTS "ligaments"
#define BIOWARE_CORTEX "cortex"

//Health hud screws for carbon mobs
#define SCREWYHUD_NONE 0
#define SCREWYHUD_CRIT 1
#define SCREWYHUD_DEAD 2
#define SCREWYHUD_HEALTHY 3

//Threshold levels for beauty for humans
#define BEAUTY_LEVEL_HORRID -66
#define BEAUTY_LEVEL_BAD -33
#define BEAUTY_LEVEL_DECENT 33
#define BEAUTY_LEVEL_GOOD 66
#define BEAUTY_LEVEL_GREAT 100

//Moods levels for humans
#define MOOD_LEVEL_HAPPY4 15
#define MOOD_LEVEL_HAPPY3 10
#define MOOD_LEVEL_HAPPY2 6
#define MOOD_LEVEL_HAPPY1 2
#define MOOD_LEVEL_NEUTRAL 0
#define MOOD_LEVEL_SAD1 -3
#define MOOD_LEVEL_SAD2 -7
#define MOOD_LEVEL_SAD3 -15
#define MOOD_LEVEL_SAD4 -20

//Sanity levels for humans
#define SANITY_MAXIMUM 150
#define SANITY_GREAT 125
#define SANITY_NEUTRAL 100
#define SANITY_DISTURBED 75
#define SANITY_UNSTABLE 50
#define SANITY_CRAZY 25
#define SANITY_INSANE 0

//Nutrition levels for humans
#define NUTRITION_LEVEL_FULL 550
#define NUTRITION_LEVEL_WELL_FED 450
#define NUTRITION_LEVEL_FED 350
#define NUTRITION_LEVEL_HUNGRY 250
#define NUTRITION_LEVEL_STARVING 150

#define NUTRITION_LEVEL_START_MIN 250
#define NUTRITION_LEVEL_START_MAX 400

//Disgust levels for humans
#define DISGUST_LEVEL_MAXEDOUT 200
#define DISGUST_LEVEL_DISGUSTED 100
#define DISGUST_LEVEL_VERYGROSS 50
#define DISGUST_LEVEL_GROSS 25

//Used as an upper limit for species that continuously gain nutriment
#define NUTRITION_LEVEL_ALMOST_FULL 535

//Charge levels for Ethereals
//WS Begin -- Ethereal Charge Scaling
#define ELZUOSE_CHARGE_SCALING_MULTIPLIER 20
#define ELZUOSE_CHARGE_NONE (0 * ELZUOSE_CHARGE_SCALING_MULTIPLIER)
#define ELZUOSE_CHARGE_LOWPOWER (20 * ELZUOSE_CHARGE_SCALING_MULTIPLIER)
#define ELZUOSE_CHARGE_NORMAL (50 * ELZUOSE_CHARGE_SCALING_MULTIPLIER)
#define ELZUOSE_CHARGE_ALMOSTFULL (75 * ELZUOSE_CHARGE_SCALING_MULTIPLIER)
#define ELZUOSE_CHARGE_FULL (100 * ELZUOSE_CHARGE_SCALING_MULTIPLIER)
#define ELZUOSE_CHARGE_OVERLOAD (125 * ELZUOSE_CHARGE_SCALING_MULTIPLIER)
#define ELZUOSE_CHARGE_DANGEROUS (150 * ELZUOSE_CHARGE_SCALING_MULTIPLIER)
//WS End

//Slime evolution threshold. Controls how fast slimes can split/grow
#define SLIME_EVOLUTION_THRESHOLD 10

//Slime extract crossing. Controls how many extracts is required to feed to a slime to core-cross.
#define SLIME_EXTRACT_CROSSING_REQUIRED 10

//Slime commands defines
#define SLIME_FRIENDSHIP_FOLLOW 3 //Min friendship to order it to follow
#define SLIME_FRIENDSHIP_STOPEAT 5 //Min friendship to order it to stop eating someone
#define SLIME_FRIENDSHIP_STOPEAT_NOANGRY 7 //Min friendship to order it to stop eating someone without it losing friendship
#define SLIME_FRIENDSHIP_STOPCHASE 4 //Min friendship to order it to stop chasing someone (their target)
#define SLIME_FRIENDSHIP_STOPCHASE_NOANGRY 6 //Min friendship to order it to stop chasing someone (their target) without it losing friendship
#define SLIME_FRIENDSHIP_STAY 3 //Min friendship to order it to stay
#define SLIME_FRIENDSHIP_ATTACK 8 //Min friendship to order it to attack

//Sentience types, to prevent things like sentience potions from giving bosses sentience
#define SENTIENCE_ORGANIC 1
#define SENTIENCE_ARTIFICIAL 2
// #define SENTIENCE_OTHER 3 unused
#define SENTIENCE_MINEBOT 4
#define SENTIENCE_BOSS 5

//Mob AI Status
#define POWER_RESTORATION_OFF 0
#define POWER_RESTORATION_START 1
#define POWER_RESTORATION_SEARCH_APC 2
#define POWER_RESTORATION_APC_FOUND 3

//Hostile simple animals
//If you add a new status, be sure to add a list for it to the simple_animals global in _globalvars/lists/mobs.dm
#define AI_ON 1
#define AI_IDLE 2
#define AI_OFF 3
#define AI_Z_OFF 4

//The range at which a mob should wake up if you spawn into the z level near it
#define MAX_SIMPLEMOB_WAKEUP_RANGE 5

//determines if a mob can smash through it
#define ENVIRONMENT_SMASH_NONE 0
#define ENVIRONMENT_SMASH_STRUCTURES (1<<0) //crates, lockers, ect
#define ENVIRONMENT_SMASH_MINERALS (1<<1) //minable walls
#define ENVIRONMENT_SMASH_WALLS (1<<2) //walls
#define ENVIRONMENT_SMASH_RWALLS (1<<3) //rwalls

#define NO_SLIP_WHEN_WALKING (1<<0)
#define SLIDE (1<<1)
#define GALOSHES_DONT_HELP (1<<2)
#define SLIDE_ICE (1<<3)
#define SLIP_WHEN_CRAWLING (1<<4)

#define MAX_CHICKENS 50

///Flags used by the flags parameter of electrocute act.

///Makes it so that the shock doesn't take gloves into account.
#define SHOCK_NOGLOVES (1 << 0)
///Used when the shock is from a tesla bolt.
#define SHOCK_TESLA (1 << 1)
///Used when an illusion shocks something. Makes the shock deal stamina damage and not trigger certain secondary effects.
#define SHOCK_ILLUSION (1 << 2)
///The shock doesn't stun.
#define SHOCK_NOSTUN (1 << 3)
/// No default message is sent from the shock
#define SHOCK_SUPPRESS_MESSAGE (1 << 4)

#define INCORPOREAL_MOVE_BASIC 1 /// normal movement, see: [/mob/living/var/incorporeal_move]
#define INCORPOREAL_MOVE_SHADOW 2 /// leaves a trail of shadows
#define INCORPOREAL_MOVE_JAUNT 3 /// is blocked by holy water/salt

//Secbot and ED209 judgement criteria bitflag values
#define JUDGE_EMAGGED (1<<0)
#define JUDGE_IDCHECK (1<<1)
#define JUDGE_WEAPONCHECK (1<<2)
#define JUDGE_RECORDCHECK (1<<3)
//ED209's ignore monkeys
#define JUDGE_IGNOREMONKEYS (1<<4)

#define MEGAFAUNA_DEFAULT_RECOVERY_TIME 5

#define SHADOW_SPECIES_LIGHT_THRESHOLD 0.2

//MINOR TWEAKS/MISC
#define AGE_MIN 18 //youngest a character can be
#define AGE_MAX 85 //oldest a character can be
#define AGE_MINOR 20 //legal age of space drinking and smoking
#define WIZARD_AGE_MIN 30 //youngest a wizard can be
#define APPRENTICE_AGE_MIN 29 //youngest an apprentice can be
#define SHOES_SLOWDOWN 0 //How much shoes slow you down by default. Negative values speed you up
#define POCKET_STRIP_DELAY 40 //time taken (in deciseconds) to search somebody's pockets
#define DOOR_CRUSH_DAMAGE 15 //the amount of damage that airlocks deal when they crush you

#define HUNGER_FACTOR 0.1 //factor at which mob nutrition decreases
#define ELZUOSE_CHARGE_FACTOR (0.05 * ELZUOSE_CHARGE_SCALING_MULTIPLIER) //factor at which ethereal's charge decreases
#define REAGENTS_METABOLISM 0.4 //How many units of reagent are consumed per tick, by default.
#define REAGENTS_EFFECT_MULTIPLIER (REAGENTS_METABOLISM / 0.4) // By defining the effect multiplier this way, it'll exactly adjust all effects according to how they originally were with the 0.4 metabolism
///Greater numbers mean that less alcohol has greater intoxication potential
#define ALCOHOL_THRESHOLD_MODIFIER 1
///The rate at which alcohol affects you
#define ALCOHOL_RATE 0.005
///The exponent applied to boozepwr to make higher volume alcohol at least a little bit damaging to the liver
#define ALCOHOL_EXPONENT 1.6
#define ETHANOL_METABOLISM 0.5 * REAGENTS_METABOLISM

// Eye protection
#define FLASH_PROTECTION_SENSITIVE -1
#define FLASH_PROTECTION_NONE 0
#define FLASH_PROTECTION_FLASH 1
#define FLASH_PROTECTION_WELDER 2

// Roundstart trait system

#define MAX_QUIRKS 4 //The maximum amount of quirks one character can have at roundstart

// AI Toggles
#define AI_CAMERA_LUMINOSITY 5
#define AI_VOX // Comment out if you don't want VOX to be enabled and have players download the voice sounds.

// /obj/item/bodypart on_mob_life() retval flag
#define BODYPART_LIFE_UPDATE_HEALTH (1<<0)

#define MAX_REVIVE_FIRE_DAMAGE 180
#define MAX_REVIVE_BRUTE_DAMAGE 180

#define HUMAN_FIRE_STACK_ICON_NUM 3

#define GRAB_PIXEL_SHIFT_PASSIVE 6
#define GRAB_PIXEL_SHIFT_AGGRESSIVE 12
#define GRAB_PIXEL_SHIFT_NECK 16

#define PULL_PRONE_SLOWDOWN 1.5
#define HUMAN_CARRY_SLOWDOWN 0.35

//Flags that control what things can spawn species (whitelist)
//Badmin magic mirror
#define MIRROR_BADMIN (1<<0)
//Standard magic mirror (wizard)
#define MIRROR_MAGIC (1<<1)
//Pride ruin mirror
#define MIRROR_PRIDE (1<<2)
//Race swap wizard event
#define RACE_SWAP (1<<3)
//ERT spawn template (avoid races that don't function without correct gear)
#define ERT_SPAWN (1<<4)
//Wabbacjack staff projectiles
#define WABBAJACK (1<<5)

#define SLEEP_CHECK_DEATH(X) sleep(X); if(QDELETED(src) || stat == DEAD) return;

#define DOING_INTERACTION(user, interaction_key) (LAZYACCESS(user.do_afters, interaction_key))
#define DOING_INTERACTION_LIMIT(user, interaction_key, max_interaction_count) ((LAZYACCESS(user.do_afters, interaction_key) || 0) >= max_interaction_count)
#define DOING_INTERACTION_WITH_TARGET(user, target) (LAZYACCESS(user.do_afters, target))
#define DOING_INTERACTION_WITH_TARGET_LIMIT(user, target, max_interaction_count) ((LAZYACCESS(user.do_afters, target) || 0) >= max_interaction_count)

/// If you examine the same atom twice in this timeframe, we call examine_more() instead of examine()
#define EXAMINE_MORE_TIME 1 SECONDS
/// How far away you can be to make eye contact with someone while examining
#define EYE_CONTACT_RANGE 5

#define SILENCE_RANGED_MESSAGE (1<<0)

/// Returns whether or not the given mob can succumb
#define CAN_SUCCUMB(target) (HAS_TRAIT(target, TRAIT_CRITICAL_CONDITION) && !HAS_TRAIT(target, TRAIT_NODEATH))

// Body position defines.
/// Mob is standing up, usually associated with lying_angle value of 0.
#define STANDING_UP 0
/// Mob is lying down, usually associated with lying_angle values of 90 or 270.
#define LYING_DOWN 1

///How much a mob's sprite should be moved when they're lying down
#define PIXEL_Y_OFFSET_LYING -6

/// Breathing types. Lungs can access either by these or by a string, which will be considered a gas ID.
#define BREATH_OXY /datum/breathing_class/oxygen
#define BREATH_PLASMA /datum/breathing_class/plasma

/// Throw modes, defines whether or not to turn off throw mode after
#define THROW_MODE_DISABLED 0
#define THROW_MODE_TOGGLE 1
#define THROW_MODE_HOLD 2

//Saves a proc call, life is suffering. If who has no targets_from var, we assume it's just who
#define GET_TARGETS_FROM(who) (who.targets_from ? who.get_targets_from() : who)

///Squash flags. For squashable component
///Whether or not the squashing requires the squashed mob to be lying down
#define SQUASHED_SHOULD_BE_DOWN (1<<0)
///Whether or not to gib when the squashed mob is moved over
#define SQUASHED_SHOULD_BE_GIBBED (1<<0)

/// Default minimum body temperature mobs can exist in before taking damage
#define NPC_DEFAULT_MIN_TEMP 250
/// Default maximum body temperature mobs can exist in before taking damage
#define NPC_DEFAULT_MAX_TEMP 350

/// In dynamic human icon gen we don't replace the held item.
#define NO_REPLACE 0
