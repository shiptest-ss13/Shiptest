// Defines for how AI-controlled basic mobs fight

// How a mob looks for a target it's lost sight of
///Walk to where we last saw them
#define AI_SEARCH_STYLE_INVESTIGATE "investigate"
///Stay put and watch where we last saw them
#define AI_SEARCH_STYLE_HOLD "hold"
///Stay put and fire at where we last saw them
#define AI_SEARCH_STYLE_SUPPRESS "suppress"

// The start and end every human NPC's plan shares, so a subtree all of them need goes in once
///Getting out of bad air, heading home, calling out what we've seen, and falling back when our nerve's gone, before anything else
#define AI_HUMAN_PLANNING_OPENING \
	/datum/ai_planning_subtree/flee_explosives, \
	/datum/ai_planning_subtree/seek_safe_environment, \
	/datum/ai_planning_subtree/investigate_noise, \
	/datum/ai_planning_subtree/return_home/human, \
	/datum/ai_planning_subtree/call_allies, \
	/datum/ai_planning_subtree/broken_fall_back/human, \
	/datum/ai_planning_subtree/unseal_door
///For those with guns: reloading, taunting, moving about at range, smashing out of corners, hitting whoever's up close, then shooting, and chatter between fights
#define AI_HUMAN_RANGED_PLANNING_CLOSING \
	/datum/ai_planning_subtree/tactical_reload, \
	/datum/ai_planning_subtree/taunt, \
	/datum/ai_planning_subtree/group/positioning, \
	/datum/ai_planning_subtree/smash_when_stuck, \
	/datum/ai_planning_subtree/melee_when_adjacent, \
	/datum/ai_planning_subtree/basic_ranged_attack_subtree/human, \
	/datum/ai_planning_subtree/idle_chatter

///For those who fight up close: looking for whoever got away, taunting, smashing out of corners, going for them, then chatter between fights
#define AI_HUMAN_MELEE_PLANNING_CLOSING \
	/datum/ai_planning_subtree/search_lost_target/human, \
	/datum/ai_planning_subtree/taunt, \
	/datum/ai_planning_subtree/smash_when_stuck, \
	/datum/ai_planning_subtree/basic_melee_attack_subtree, \
	/datum/ai_planning_subtree/idle_chatter

// The most shots a mob will put into something in its way, like a window, to shoot through it
#define AI_MAX_SHOTS_THROUGH_COVER 10

// How near someone we gave up on getting to has to be for us to check if there's a straight way to them now
#define AI_IGNORE_RECHECK_RANGE 8

// The least of its usual range a sound carries for AI, even with no air
#define AI_MINIMUM_SOUND_FACTOR 0.1

// How long after last firing at someone a mob's aim on them stays settled, after which its next volley at them counts as first contact again
#define AI_AIM_SETTLED_MEMORY (8 SECONDS)

// The range a mob fights at from range, unless it or its controller sets its own
#define AI_DEFAULT_RETREAT_DISTANCE 3
#define AI_DEFAULT_ENGAGE_DISTANCE 6

// How much a mob moves about in a fight
///Holds its ground, like someone lugging a machine gun or lining up a sniper shot, or wearing heavy gear
#define AI_MOBILITY_LOW 1
#define AI_MOBILITY_NORMAL 2
///Always on the move, darting about and jinking out of the way
#define AI_MOBILITY_HIGH 3

// How a mob's feeling about a fight, for morale
///An ally just died nearby, so it digs in rather than pushing into whatever got them
#define AI_MORALE_WARY "wary"
///Its side just put someone down and has the numbers, so it presses the attack
#define AI_MORALE_EMBOLDENED "emboldened"
///Too many allies dead, or too badly outnumbered, so it falls back until it can pull itself together
#define AI_MORALE_BROKEN "broken"
///Whether controller's mob is feeling morale, one of the AI_MORALE_ defines
#define AI_MORALE_IS(controller, morale) (controller.blackboard[BB_BASIC_MOB_MORALE] == morale && controller.blackboard[BB_BASIC_MOB_MORALE_UNTIL] > world.time)

///How long after losing sight of whoever we were fighting we still count as mid-fight, so someone ducking behind cover isn't a stranger again
#define AI_FIGHT_MEMORY (10 SECONDS)
///Whether controller's mob had eyes on someone it was fighting within memory
#define AI_RECENTLY_SAW_ENEMY(controller, memory) (!isnull(controller.blackboard[BB_BASIC_MOB_LAST_SAW_ENEMY_TIME]) && world.time - controller.blackboard[BB_BASIC_MOB_LAST_SAW_ENEMY_TIME] < (memory))

// Things a mob can call out in a fight
///Spotted someone for itself, rather than being told about them
#define AI_CALLOUT_SPOTTED "spotted"
///Shot by someone it can't see
#define AI_CALLOUT_TAKING_FIRE "taking fire"
///Hurt while fighting someone it can see
#define AI_CALLOUT_HURT "hurt"
///Its shot or blow put someone down, but they aren't dead
#define AI_CALLOUT_TARGET_DOWN "target down"
///Its shot or blow killed someone
#define AI_CALLOUT_TARGET_KILLED "target killed"
///An ally in earshot died
#define AI_CALLOUT_ALLY_DOWN "ally down"
///Lost sight of its target and is going to look for them
#define AI_CALLOUT_LOST_THEM "lost them"
///Lost sight of its target and is staying put
#define AI_CALLOUT_HOLDING "holding"
///Firing blind at where it last saw its target
#define AI_CALLOUT_SUPPRESSING "suppressing"
///Out of ammo and reloading
#define AI_CALLOUT_RELOADING "reloading"
///Closing in on someone it can see
#define AI_CALLOUT_PUSHING "pushing"
///Backing off from someone who's got too close, without running away
#define AI_CALLOUT_FALLING_BACK "falling back"
///Heard enemy gunfire it can't see, and is going to check it out
#define AI_CALLOUT_HEARD_GUNFIRE "heard gunfire"
///Going around something between it and its target
#define AI_CALLOUT_FLANKING "flanking"
///Getting out of air we can't breathe, or vacuum and too little air without a sealed suit
#define AI_CALLOUT_BAD_AIR "bad air"
///Getting out of somewhere too hot for us
#define AI_CALLOUT_TOO_HOT "too hot"
///Getting out of somewhere too cold for us
#define AI_CALLOUT_TOO_COLD "too cold"
///Now and then while fighting someone it can see
#define AI_CALLOUT_TAUNT "taunt"
///Now and then as it lands a blow on someone, who's still standing
#define AI_CALLOUT_MELEE "melee"
///Lost its nerve and is falling back
#define AI_CALLOUT_BROKEN "broken"
///Saw an explosive about to go off nearby, and is getting clear
#define AI_CALLOUT_GRENADE "grenade"
///Throwing a grenade back where it came from
#define AI_CALLOUT_THROW_BACK "throw_back"
///Knocked flat
#define AI_CALLOUT_KNOCKED_DOWN "knocked_down"
///Blinded by a flash
#define AI_CALLOUT_FLASHED "flashed"
///Caught in tear gas or pepper spray
#define AI_CALLOUT_GASSED "gassed"
///Slowdown instead of knockdown, for mobs that we set to not get knocked down
#define AI_CALLOUT_STAGGERED "staggered"
///How long after one urgent callout, said over everything else, before another can be
#define AI_CALLOUT_INTERRUPT_GAP (2 SECONDS)
///Pulled itself together after breaking
#define AI_CALLOUT_RALLIED "rallied"
///Whispered with its last breath
#define AI_CALLOUT_DEATH_RATTLE "death rattle"
///Just turned wary, as an ally died nearby
#define AI_CALLOUT_WARY "wary"
///Just turned emboldened, as its side put someone down and has the numbers
#define AI_CALLOUT_EMBOLDENED "emboldened"

///The air's no good, or there's next to none of it
#define AI_ENVIRONMENT_UNBREATHABLE "unbreathable"
///Hot enough to hurt us
#define AI_ENVIRONMENT_TOO_HOT "too hot"
///Cold enough to hurt us
#define AI_ENVIRONMENT_TOO_COLD "too cold"

// How far AI with /datum/element/ai_hears_gunfire hears gunshots, in tiles. Walls can muffle sounds. Guns can set their own, see gunfire_hearing_range and suppressed_gunfire_hearing_range
#define AI_GUNFIRE_HEARING_RANGE 12
///Lasers are quieter than an unsuppressed gunshot
#define AI_LASER_HEARING_RANGE 8
///Suppressed shots carry this many times less far, as a divisor
#define AI_SUPPRESSED_HEARING_REDUCTION 3
///A shooter firing from the same spot, no louder, alerts mobs at most this often, so automatic fire isn't a scan per shot
#define AI_GUNFIRE_ALERT_COOLDOWN (2 SECONDS)
///Each wall between an AI mob and something it's trying to hear counts as this many more tiles of distance
#define AI_HEARING_WALL_PENALTY 3
// How many shots an AI with an automatic gun fires in a volley, if its type doesn't ask for more
#define AI_AUTOMATIC_BURST_SHOTS 4
// How many shots an AI with a single-shot handgun, like a pistol or revolver, fires in a volley
#define AI_HANDGUN_VOLLEY_SHOTS 2
// How much more to reduce the firerate of AI, and it's minimum interval
#define AI_VOLLEY_INTERVAL_MULTIPLIER 1.10
#define AI_MINIMUM_VOLLEY_INTERVAL (0.10 SECONDS)
// How fast melee mobs move, whatever they're wearing, a touch slower than a running player, see RUN_DELAY
#define AI_MELEE_MOVE_DELAY 1.8
// The least fuse a grenade can have left for AI to try throwing it back, rather than it going off in their hand
#define AI_THROW_BACK_MINIMUM_FUSE (1.5 SECONDS)
// How close a live explosive has to be for AI to notice it without seeing it, like an IED in a sack or something landing by them in the dark
#define AI_EXPLOSIVE_NOTICE_RANGE 3
// How much further than an explosive's blast AI gets clear by, and keeps clear of until it goes off
#define AI_EXPLOSIVE_SAFETY_MARGIN 2
// How long AI leaves a sealed door alone after giving up on getting the seal off it
#define AI_UNSEAL_RETRY_TIME (60 SECONDS)
// How long AI takes after getting up from a knockdown before it can fire again, getting its gun back on target
#define AI_GET_UP_FIRE_DELAY (1.5 SECONDS)
// How long AI shoved away is off balance and can't swing, and how long after that before another shove can put it off balance again
#define AI_SHOVE_OFF_BALANCE_TIME (1.5 SECONDS)
#define AI_SHOVE_OFF_BALANCE_IMMUNITY (2 SECONDS)
// The longest AI that only staggers, rather than being knocked down, stays slowed
#define AI_STAGGER_MAX_TIME (5 SECONDS)
// How long AI takes to react to a grenade landing by them before it can grab it to throw back
#define AI_THROW_BACK_REACTION_TIME (1 SECONDS)
// How far AI hears an explosion, in tiles, before adding twice its biggest blast range
#define AI_EXPLOSION_HEARING_RANGE 12
// How long AI goes looking for a noise it heard before giving up, and how far from home it'll go to, unless it has a leash of its own
#define AI_NOISE_MEMORY (20 SECONDS)
#define AI_NOISE_LEASH_DISTANCE 15

///Below this much light, as from /turf/proc/get_lumcount(), AI only makes someone out up close, see ai_can_see()
#define AI_DARKNESS_THRESHOLD SHADOW_SPECIES_LIGHT_THRESHOLD
///With at least this see_in_dark, AI sees in the dark as well as the light
#define AI_NIGHT_VISION 8
///How far AI sees, unless its sensor or BB_BASIC_MOB_VISION_RANGE says otherwise
#define AI_DEFAULT_VISION_RANGE 9

///What AI assumes other people's shots get through, when working out if it's safe somewhere. Lasers that pass glass are the worst case, so glass is never cover.
#define AI_THREAT_SHOT_PASS_FLAGS (PASSTABLE | PASSGLASS | PASSGRILLE)

// How AI learnt about a target it can't see yet
///An ally called them out to us
#define AI_LEARNED_TOLD "told"
///We heard them shooting
#define AI_LEARNED_HEARD "heard"
///They shot us
#define AI_LEARNED_SHOT "shot"
