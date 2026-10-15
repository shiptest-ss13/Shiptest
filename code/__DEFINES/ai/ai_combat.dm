// Defines for how AI-controlled basic mobs fight:

// How a mob looks for a target it's lost sight of
///Walk to where we last saw them
#define SEARCH_STYLE_INVESTIGATE "investigate"
///Stay put and watch where we last saw them
#define SEARCH_STYLE_HOLD "hold"
///Stay put and fire at where we last saw them
#define SEARCH_STYLE_SUPPRESS "suppress"

// The start and end every human NPC's plan shares, so a subtree all of them need goes in once
///Getting out of bad air, heading home, calling out what we've seen, and falling back when our nerve's gone, before anything else
#define AI_HUMAN_PLANNING_OPENING \
	/datum/ai_planning_subtree/seek_safe_environment, \
	/datum/ai_planning_subtree/return_home/human, \
	/datum/ai_planning_subtree/call_allies, \
	/datum/ai_planning_subtree/broken_fall_back/human
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

// The range a mob fights at from range, unless it or its controller sets its own
#define AI_DEFAULT_RETREAT_DISTANCE 3
#define AI_DEFAULT_ENGAGE_DISTANCE 6

// How much a mob moves about in a fight
///Holds its ground, like someone lugging a machine gun or lining up a sniper shot
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
///Getting out of air it can't breathe, or heat or cold that's hurting it
#define AI_CALLOUT_UNSAFE_ENVIRONMENT "unsafe environment"
///Now and then while fighting someone it can see
#define AI_CALLOUT_TAUNT "taunt"
///Now and then as it lands a blow on someone, who's still standing
#define AI_CALLOUT_MELEE "melee"
///Lost its nerve and is falling back, see AI_MORALE_BROKEN
#define AI_CALLOUT_BROKEN "broken"
///Pulled itself together after breaking
#define AI_CALLOUT_RALLIED "rallied"
///Whispered with its last breath
#define AI_CALLOUT_DEATH_RATTLE "death rattle"
///Just turned wary, as an ally died nearby
#define AI_CALLOUT_WARY "wary"
///Just turned emboldened, as its side put someone down and has the numbers
#define AI_CALLOUT_EMBOLDENED "emboldened"

// How far AI with /datum/element/ai_hears_gunfire hears gunshots, in tiles, before walls muffle them. Guns can set their own, see gunfire_hearing_range and suppressed_gunfire_hearing_range
#define GUNFIRE_HEARING_RANGE 12
///Lasers are quieter than an unsuppressed gunshot
#define LASER_HEARING_RANGE 7
///Suppressed shots carry this many times less far
#define SUPPRESSED_HEARING_REDUCTION 3
///A shooter firing from the same spot, no louder, alerts mobs at most this often, so automatic fire isn't a scan per shot
#define GUNFIRE_ALERT_COOLDOWN (2 SECONDS)
///Each wall between an AI mob and something it's trying to hear counts as this many more tiles of distance
#define AI_HEARING_WALL_PENALTY 3

///What AI assumes other people's shots get through, when working out if it's safe somewhere. Lasers that pass glass are the worst case, so glass is never cover. See is_spot_safe_from()
#define AI_THREAT_SHOT_PASS_FLAGS (PASSTABLE | PASSGLASS | PASSGRILLE)

// How AI learnt about a target it can't see yet
///An ally called them out to us
#define AI_LEARNED_TOLD "told"
///We heard them shooting
#define AI_LEARNED_HEARD "heard"
///They shot us
#define AI_LEARNED_SHOT "shot"
