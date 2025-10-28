
///if it allows multiple instances of the effect
#define STATUS_EFFECT_MULTIPLE 0
///if it allows only one, preventing new instances
#define STATUS_EFFECT_UNIQUE 1
///if it allows only one, but new instances replace
#define STATUS_EFFECT_REPLACE 2
/// if it only allows one, and new instances just instead refresh the timer
#define STATUS_EFFECT_REFRESH 3

/// Use in status effect "duration" to make it last forever
#define STATUS_EFFECT_PERMANENT -1
/// Use in status effect "tick_interval" to prevent it from calling tick()
#define STATUS_EFFECT_NO_TICK -1
/// Use in status effect "tick_interval" to guarantee that tick() gets called on every process()
#define STATUS_EFFECT_AUTO_TICK 0

/// Indicates this status effect is an abstract type, ie not instantiated
/// Doesn't actually do anything in practice, primarily just a marker / used in unit tests,
/// so don't worry if your abstract status effect doesn't actually set this
#define STATUS_EFFECT_ID_ABSTRACT "abstract"

///Processing flags - used to define the speed at which the status will work
/// This is fast - 0.2s between ticks (I believe!)
#define STATUS_EFFECT_FAST_PROCESS 0
/// This is slower and better for more intensive status effects - 1s between ticks
#define STATUS_EFFECT_NORMAL_PROCESS 1
/// Similar speed to STATUS_EFFECT_FAST_PROCESS, but uses a high priority subsystem (SSpriority_effects)
#define STATUS_EFFECT_PRIORITY 2

///////////
// BUFFS //
///////////

#define STATUS_EFFECT_SHADOW_MEND /datum/status_effect/shadow_mend //Quick, powerful heal that deals damage afterwards. Heals 15 brute/burn every second for 3 seconds.
#define STATUS_EFFECT_VOID_PRICE /datum/status_effect/void_price //The price of healing yourself with void energy. Deals 3 brute damage every 3 seconds for 30 seconds.

#define STATUS_EFFECT_POWERREGEN /datum/status_effect/cyborg_power_regen //Regenerates power on a given cyborg over time

#define STATUS_EFFECT_WISH_GRANTERS_GIFT /datum/status_effect/wish_granters_gift //If you're currently resurrecting with the Wish Granter

#define STATUS_EFFECT_BLOODDRUNK /datum/status_effect/blooddrunk //Stun immunity and greatly reduced damage taken

#define STATUS_EFFECT_FLESHMEND /datum/status_effect/fleshmend //Very fast healing; suppressed by fire, and heals less fire damage

#define STATUS_EFFECT_EXERCISED /datum/status_effect/exercised //Prevents heart disease

#define STATUS_EFFECT_HIPPOCRATIC_OATH /datum/status_effect/hippocraticOath //Gives you an aura of healing as well as regrowing the Rod of Asclepius if lost

#define STATUS_EFFECT_GOOD_MUSIC /datum/status_effect/good_music

#define STATUS_EFFECT_REGENERATIVE_CORE /datum/status_effect/regenerative_core

#define STATUS_EFFECT_ANTIMAGIC /datum/status_effect/antimagic //grants antimagic (and reapplies if lost) for the duration

#define STATUS_EFFECT_DETERMINED /datum/status_effect/determined //currently in a combat high from being seriously wounded

/////////////
// DEBUFFS //
/////////////

#define STATUS_EFFECT_STUN /datum/status_effect/incapacitating/stun //the affected is unable to move or use items

#define STATUS_EFFECT_KNOCKDOWN /datum/status_effect/incapacitating/knockdown //the affected is unable to stand up

#define STATUS_EFFECT_IMMOBILIZED /datum/status_effect/incapacitating/immobilized //the affected is unable to move

#define STATUS_EFFECT_PARALYZED /datum/status_effect/incapacitating/paralyzed //the affected is unable to move, use items, or stand up.

#define STATUS_EFFECT_UNCONSCIOUS /datum/status_effect/incapacitating/unconscious //the affected is unconscious

#define STATUS_EFFECT_SLEEPING /datum/status_effect/incapacitating/sleeping //the affected is asleep

#define STATUS_EFFECT_PACIFY /datum/status_effect/pacify //the affected is pacified, preventing direct hostile actions

#define STATUS_EFFECT_BELLIGERENT /datum/status_effect/belligerent //forces the affected to walk, doing damage if they try to run

#define STATUS_EFFECT_GEISTRACKER /datum/status_effect/geis_tracker //if you're using geis, this tracks that and keeps you from using scripture

#define STATUS_EFFECT_MANIAMOTOR /datum/status_effect/maniamotor //disrupts, damages, and confuses the affected as long as they're in range of the motor
#define MAX_MANIA_SEVERITY 100 //how high the mania severity can go
#define MANIA_DAMAGE_TO_CONVERT 90 //how much damage is required before it'll convert affected targets

#define STATUS_EFFECT_CHOKINGSTRAND /datum/status_effect/strandling //Choking Strand

#define STATUS_EFFECT_HISWRATH /datum/status_effect/his_wrath //His Wrath.

#define STATUS_EFFECT_CRUSHERMARK /datum/status_effect/crusher_mark //if struck with a proto-kinetic crusher, takes a ton of damage

#define STATUS_EFFECT_SAWBLEED /datum/status_effect/stacking/saw_bleed //if the bleed builds up enough, takes a ton of damage

#define STATUS_EFFECT_NECKSLICE /datum/status_effect/neck_slice //Creates the flavor messages for the neck-slice

#define STATUS_EFFECT_CONVULSING /datum/status_effect/convulsing

#define STATUS_EFFECT_NECROPOLIS_CURSE /datum/status_effect/necropolis_curse
#define STATUS_EFFECT_HIVEMIND_CURSE /datum/status_effect/necropolis_curse/hivemind
#define CURSE_BLINDING 1 //makes the edges of the target's screen obscured
#define CURSE_SPAWNING 2 //spawns creatures that attack the target only
#define CURSE_WASTING 4 //causes gradual damage
#define CURSE_GRASPING 8 //hands reach out from the sides of the screen, doing damage and stunning if they hit the target

#define STATUS_EFFECT_KINDLE /datum/status_effect/kindle //A knockdown reduced by 1 second for every 3 points of damage the target takes.

#define STATUS_EFFECT_ICHORIAL_STAIN /datum/status_effect/ichorial_stain //Prevents a servant from being revived by vitality matrices for one minute.

#define STATUS_EFFECT_GONBOLAPACIFY /datum/status_effect/gonbolaPacify //Gives the user gondola traits while the gonbola is attached to them.

#define STATUS_EFFECT_SPASMS /datum/status_effect/spasms //causes random muscle spasms

#define STATUS_EFFECT_DNA_MELT /datum/status_effect/dna_melt //usually does something horrible to you when you hit 100 genetic instability

#define STATUS_EFFECT_GO_AWAY /datum/status_effect/go_away //makes you launch through walls in a single direction for a while

#define STATUS_EFFECT_STASIS /datum/status_effect/grouped/stasis //Halts biological functions like bleeding, chemical processing, blood regeneration, walking, etc

#define STATUS_EFFECT_FAKE_VIRUS /datum/status_effect/fake_virus //gives you fluff messages for cough, sneeze, headache, etc but without an actual virus

#define STATUS_EFFECT_LIMP /datum/status_effect/limp //For when you have a busted leg (or two!) and want additional slowdown when walking on that leg

#define STATUS_EFFECT_METAB_FROZEN /datum/status_effect/metab_frozen // Affected cannot process chems

//Incapacitated status effect flags
/// If the incapacitated status effect will ignore a mob in restraints (handcuffs)
#define IGNORE_RESTRAINTS (1<<0)
/// If the incapacitated status effect will ignore a mob in stasis (stasis beds)
#define IGNORE_STASIS (1<<1)
/// If the incapacitated status effect will ignore a mob being agressively grabbed
#define IGNORE_GRAB (1<<2)

/////////////
// NEUTRAL //
/////////////

#define STATUS_EFFECT_SIGILMARK /datum/status_effect/sigil_mark

#define STATUS_EFFECT_CRUSHERDAMAGETRACKING /datum/status_effect/crusher_damage //tracks total kinetic crusher damage on a target

#define STATUS_EFFECT_SYPHONMARK /datum/status_effect/syphon_mark //tracks kills for the KA death syphon module

#define STATUS_EFFECT_INLOVE /datum/status_effect/in_love //Displays you as being in love with someone else, and makes hearts appear around them.

#define STATUS_EFFECT_BUGGED /datum/status_effect/bugged //Lets other mobs listen in on what it hears

#define STATUS_EFFECT_BOUNTY /datum/status_effect/bounty //rewards the person who added this to the target with refreshed spells and a fair heal

#define STATUS_EFFECT_HELDUP /datum/status_effect/heldup // someone is currently pointing a gun at you

#define STATUS_EFFECT_HOLDUP /datum/status_effect/holdup // you are currently pointing a gun at someone

#define STATUS_EFFECT_OFFERING /datum/status_effect/offering // you are offering up an item to people

#define STATUS_EFFECT_SURRENDER /datum/status_effect/surrender // gives an alert to quickly surrender
/////////////
//  SLIME  //
/////////////

#define STATUS_EFFECT_RAINBOWPROTECTION /datum/status_effect/rainbow_protection //Invulnerable and pacifistic
#define STATUS_EFFECT_SLIMESKIN /datum/status_effect/slimeskin //Increased armor

// Grouped effect sources, see also code/__DEFINES/traits.dm

#define STASIS_MACHINE_EFFECT "stasis_machine"
#define STASIS_DRUG_EFFECT "stasis_drug"

// Stasis helpers

#define IS_IN_STASIS(mob) (mob.has_status_effect(STATUS_EFFECT_STASIS))
