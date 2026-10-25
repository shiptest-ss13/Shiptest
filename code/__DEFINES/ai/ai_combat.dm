// Defines for how AI-controlled basic mobs fight

// The start and end every human NPC's plan shares, so a subtree that needs all of them goes in once
///Getting out of bad air, heading home, calling out what we've seen, and falling back when our nerve's gone, before anything else. Then a grenade, for those who carry them
#define AI_HUMAN_PLANNING_OPENING \
	/datum/ai_planning_subtree/flee_explosives, \
	/datum/ai_planning_subtree/seek_safe_environment, \
	/datum/ai_planning_subtree/put_out_fire, \
	/datum/ai_planning_subtree/pat_out_burning_ally, \
	/datum/ai_planning_subtree/clear_friendly_fire, \
	/datum/ai_planning_subtree/investigate_noise, \
	/datum/ai_planning_subtree/investigate_box, \
	/datum/ai_planning_subtree/return_home/human, \
	/datum/ai_planning_subtree/call_allies, \
	/datum/ai_planning_subtree/order_push, \
	/datum/ai_planning_subtree/broken_fall_back/human, \
	/datum/ai_planning_subtree/throw_grenade
///For those with guns: reloading, taunting, moving about at range, smashing out of corners, hitting whoever's up close, then shooting, and chatter between fights. First, waiting out or shooting through to anyone they can see but can't shoot
#define AI_HUMAN_RANGED_PLANNING_CLOSING \
	/datum/ai_planning_subtree/wait_out_unreachable/ranged, \
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

// How a mob looks for a target it's lost sight of
///Walk to where we last saw them
#define AI_SEARCH_STYLE_INVESTIGATE "investigate"
///Stay put and watch where we last saw them
#define AI_SEARCH_STYLE_HOLD "hold"
///Stay put and fire at where we last saw them
#define AI_SEARCH_STYLE_SUPPRESS "suppress"

// What a mob sees and hears, and how long it keeps someone in mind
///How long after losing sight of whoever we were fighting we still count as mid-fight, so someone ducking behind cover isn't a stranger again
#define AI_FIGHT_MEMORY (10 SECONDS)
///Whether controller's mob had eyes on someone it was fighting within memory
#define AI_RECENTLY_SAW_ENEMY(controller, memory) (!isnull(controller.blackboard[BB_BASIC_MOB_LAST_SAW_ENEMY_TIME]) && world.time - controller.blackboard[BB_BASIC_MOB_LAST_SAW_ENEMY_TIME] < (memory))
// The least of its usual range a sound carries for AI, even with no air
#define AI_MINIMUM_SOUND_FACTOR 0.1
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

// How AI learnt about a target it can't see yet
///An ally called them out to us
#define AI_LEARNED_TOLD "told"
///We heard them shooting
#define AI_LEARNED_HEARD "heard"
///They shot us
#define AI_LEARNED_SHOT "shot"

// Fighting at range: how far, how well aimed, and how many shots
// The range a mob fights at from range, unless it or its controller sets its own
#define AI_DEFAULT_RETREAT_DISTANCE 3
#define AI_DEFAULT_ENGAGE_DISTANCE 6
// How long after last firing at someone a mob's aim on them stays settled, after which its next volley at them counts as first contact again
#define AI_AIM_SETTLED_MEMORY (8 SECONDS)
// How many shots an AI with an automatic gun fires in a volley, if its type doesn't ask for more
#define AI_AUTOMATIC_BURST_SHOTS 4
// How many shots an AI with a single-shot handgun, like a pistol or revolver, fires in a volley
#define AI_HANDGUN_VOLLEY_SHOTS 2
// How much more to reduce the firerate of AI, and it's minimum interval
#define AI_VOLLEY_INTERVAL_MULTIPLIER 1.10
#define AI_MINIMUM_VOLLEY_INTERVAL (0.10 SECONDS)
///What AI assumes other people's shots get through, when working out if it's safe somewhere. Lasers that pass glass are the worst case, so glass is never cover.
#define AI_THREAT_SHOT_PASS_FLAGS (PASSTABLE | PASSGLASS | PASSGRILLE)
// The most shots a mob will put into something in its way, like a window, to shoot through it
#define AI_MAX_SHOTS_THROUGH_COVER 10

// How much a mob moves about in a fight
///Holds its ground, like someone lugging a machine gun or lining up a sniper shot, or wearing heavy gear
#define AI_MOBILITY_LOW 1
#define AI_MOBILITY_NORMAL 2
///Always on the move, darting about and jinking out of the way
#define AI_MOBILITY_HIGH 3
// How fast melee mobs move, whatever they're wearing, a touch slower than a running player, see RUN_DELAY
#define AI_MELEE_MOVE_DELAY 1.8

// Up close: pressing in, shoves, staggers and getting back up
///How long AI rushes in when one of its side's stingbangs or flashbangs put down everyone it was fighting, or one of its own is being used as a shield
#define AI_PRESS_TIME (6 SECONDS)
///How long one of its own can be in the way of its shots before AI closes in instead, like someone dragging one about as a shield
#define AI_SHIELDED_PUSH_TIME (4 SECONDS)
///How long a helpless one of its own can be kept in the way of its shots, like stunned over and over and dragged about as a shield, before AI shoots anyway
#define AI_SHIELDED_FIRE_TIME (10 SECONDS)
// How long AI shoved away is off balance and can't swing, and how long after that before another shove can put it off balance again
#define AI_SHOVE_OFF_BALANCE_TIME (1.5 SECONDS)
#define AI_SHOVE_OFF_BALANCE_IMMUNITY (2 SECONDS)
// The longest AI that only staggers, rather than being knocked down, stays slowed
#define AI_STAGGER_MAX_TIME (5 SECONDS)
// How long AI takes after getting up from a knockdown before it can fire again, getting its gun back on target
#define AI_GET_UP_FIRE_DELAY (0.5 SECONDS)

// Getting at someone past something in the way
// The most shots a mob will put into something in its way to break through to someone it can't otherwise get at, up to two of its magazines
#define AI_MAX_SHOTS_TO_BREACH 30
// Something in the way of someone a mob can't get at this quick to smash, like a bare grille, it always smashes rather than waiting
#define AI_CHEAP_BREACH_HITS 4
// How near someone we gave up on getting to has to be for us to check if there's a straight way to them now
#define AI_IGNORE_RECHECK_RANGE 8

// Explosives and grenades
// The least fuse a grenade can have left for AI to try throwing it back, rather than it going off in their hand
#define AI_THROW_BACK_MINIMUM_FUSE (1.5 SECONDS)
// How far from AI a live grenade can land for it to go and throw it back,
#define AI_THROW_BACK_REACH 2
// Extra fuse time it needs for each step to it on top of AI_THROW_BACK_MINIMUM_FUSE
#define AI_THROW_BACK_STEP_TIME (0.2 SECONDS)
// How long AI takes to react to a grenade landing by them before it can grab it to throw back
#define AI_THROW_BACK_REACTION_TIME (1 SECONDS)
// How close a live explosive has to be for AI to notice it without seeing it, like an IED in a sack or something landing by them in the dark
#define AI_EXPLOSIVE_NOTICE_RANGE 3
// How much further than an explosive's blast AI gets clear by, and keeps clear of until it goes off
#define AI_EXPLOSIVE_SAFETY_MARGIN 2

// How a mob's feeling about a fight, for morale
///An ally just died nearby, so it digs in rather than pushing into whatever got them
#define AI_MORALE_WARY "wary"
///Its side just put someone down and has the numbers, so it presses the attack
#define AI_MORALE_EMBOLDENED "emboldened"
///Too many allies dead, or too badly outnumbered, so it falls back until it can pull itself together
#define AI_MORALE_BROKEN "broken"
///Whether controller's mob is feeling morale, one of the AI_MORALE_ defines
#define AI_MORALE_IS(controller, morale) (controller.blackboard[BB_BASIC_MOB_MORALE] == morale && controller.blackboard[BB_BASIC_MOB_MORALE_UNTIL] > world.time)

// Working together: raising the alarm, hotheads and commanders
///How long after last seeing whoever it was fighting AI still brings allies it comes across into it, as long as track_target keeps them in mind, so running a long way to its friends still raises the alarm
#define AI_REALERT_MEMORY (20 SECONDS)
///The chance a mob that fights up close is reckless, unless its type or a mapper says, charging rather than lying in wait for those with guns, see /mob/living/basic/human/var/melee_reckless
#define AI_MELEE_RECKLESS_CHANCE 25
///How recently one of its side has to have fired on whoever it's after, with a clear line, for AI that fights up close to go in under that covering fire rather than lie in wait
#define AI_COVERING_FIRE_TIME (3 SECONDS)
///How far a commander with a gun keeps from anyone closing in, at the least, so it isn't stood in the front line
#define AI_COMMANDER_RETREAT_DISTANCE 5
///How long after its side turned on whoever attacked a commander before they will again
#define AI_COMMANDER_GUARD_COOLDOWN (10 SECONDS)
///How long after its side saw one of theirs get shot before they'll react to seeing it shot again, see ai_witness_shooting()
#define AI_WITNESS_COOLDOWN (5 SECONDS)
///Cooldown until the next time a commander can sound the alarm with a callout that has an alarm range
#define AI_COMMANDER_ALARM_COOLDOWN (60 SECONDS)

// Making the most of someone reloading
///How long after AI notices someone reloading or out of ammo it treats them as unable to shoot back, see ai_note_enemy_reloading()
#define AI_ENEMY_RELOAD_WINDOW (4 SECONDS)
///How far AI hears a gun dry firing, a quiet click
#define AI_DRY_FIRE_HEARING_RANGE 5
///How long before AI will take notice of the same someone reloading again, so it isn't a push every magazine
#define AI_ENEMY_RELOAD_NOTICE_COOLDOWN (10 SECONDS)
///The chance AI near someone reloading takes notice at all
#define AI_ENEMY_RELOAD_NOTICE_CHANCE 75
///Someone armed of theirs within this of whoever's reloading covers them, so those who'd rush in don't, see ai_reloader_covered()
#define AI_ENEMY_RELOAD_COVER_RANGE 5
///Whether who controller's mob is fighting is reloading or out of ammo, as far as it knows
#define AI_TARGET_RELOADING(controller) (world.time < controller.blackboard[BB_BASIC_MOB_TARGET_RELOADING_UNTIL])

// Cardboard boxes, see /datum/ai_planning_subtree/investigate_box
///The chance, each step a cardboard box with someone in it takes, that AI that can see it and isn't fighting anyone notices, from further than AI_BOX_NOTICE_NEAR_RANGE
#define AI_BOX_NOTICE_CHANCE 20
///Within this of AI, a moving box is noticed at AI_BOX_NOTICE_NEAR_CHANCE instead, and within AI_BOX_NOTICE_CLOSE_RANGE always, as there's no missing a box shuffling past your nose
#define AI_BOX_NOTICE_NEAR_RANGE 4
#define AI_BOX_NOTICE_NEAR_CHANCE 50
#define AI_BOX_NOTICE_CLOSE_RANGE 2
///Group boxes moving together as a single group
#define AI_BOX_GROUP_RANGE 3

///How long AI holding a post stays off it after breaking from it, for someone right on top of it or coming round where it can't cover from, kept up for as long as that lasts
#define AI_POST_BREAK_TIME (8 SECONDS)
///How much further than its post_radius AI that's broken from its post can go
#define AI_POST_BREAK_EXTRA_RADIUS 3
///Whether controller's mob has broken from the post it holds, for now
#define AI_POST_BROKEN(controller) (world.time < controller.blackboard[BB_BASIC_MOB_POST_BROKEN_UNTIL])

// Fire
///The cooldown for how often a mob tries to set someone else on fire
#define AI_FIRE_SPREAD_COOLDOWN (3 SECONDS)

// Picking somewhere to hide or fight from
///The nearest spot out of their sight that'll do
#define AI_HIDE_NEAREST "nearest"
///The spot that'll do nearest to the enemy, like lying in wait to jump them when they come out
#define AI_HIDE_NEAR_THREAT "near threat"
///The spot that'll do furthest from them, like falling back
#define AI_HIDE_FAR_FROM_THREAT "far from threat"
///Penalise cover if it knows it's exposed to threats
#define AI_COVER_EXPOSED_PENALTY 3
#define AI_COVER_ENEMY_MEMORY (5 SECONDS)
///How much worse cover is for each tile outside the range it fights at
#define AI_COVER_OUT_OF_RANGE_PENALTY 2

// What can be wrong with where a mob is stood
///The air's no good, or there's next to none of it
#define AI_ENVIRONMENT_UNBREATHABLE "unbreathable"
///Hot enough to hurt us
#define AI_ENVIRONMENT_TOO_HOT "too hot"
///Cold enough to hurt us
#define AI_ENVIRONMENT_TOO_COLD "too cold"

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
///Throwing a grenade of its own
#define AI_CALLOUT_GRENADE_OUT "grenade_out"
///One of its side's stingbangs or flashbangs put down someone they were fighting
#define AI_CALLOUT_TARGETS_STUNNED "targets_stunned"
///Someone it's fighting was seen changing magazines or heard dry firing, so its side can make the most of it
#define AI_CALLOUT_ENEMY_RELOADING "enemy_reloading"
///Enough of its side are lying in wait for the same someone, so they all go for them at once
#define AI_CALLOUT_CHARGE "charge"
///A commander ordering those of its side fighting with it to push up, see /datum/ai_planning_subtree/order_push
#define AI_CALLOUT_ORDER_PUSH "order push"
///One of its side who gives orders was attacked, so the rest turn on whoever did it, see ai_commander_attacked()
#define AI_CALLOUT_PROTECT_COMMANDER "protect commander"
///One of its side who gave orders has died, in place of AI_CALLOUT_ALLY_DOWN
#define AI_CALLOUT_COMMANDER_DOWN "commander down"
///A commander that's turned wary telling those of its side fighting with it to hold with it, see /datum/component/ai_morale/proc/order_squad()
#define AI_CALLOUT_ORDER_HOLD "order hold"
///A commander whose nerve's gone telling those of its side fighting with it to fall back with it
#define AI_CALLOUT_ORDER_RETREAT "order retreat"
///A cardboard box it can see just moved, see /datum/ai_planning_subtree/investigate_box
#define AI_CALLOUT_SUSPICIOUS "suspicious"
///It looked into something suspicious, like a box that moved, and decided it was nothing
#define AI_CALLOUT_LOST_INTEREST "lost interest"
///It's found someone hiding, like in a cardboard box that moved once too often
#define AI_CALLOUT_FOUND_HIDING "found hiding"
///Shooting anyway, past one of its own being used as a shield
#define AI_CALLOUT_SHOOTING_THROUGH_ALLY "shooting_through_ally"
///Throwing a grenade back where it came from
#define AI_CALLOUT_THROW_BACK "throw_back"
///Chatting to pass the time, with nobody to fight
#define AI_CALLOUT_IDLE "idle"
///Knocked flat
#define AI_CALLOUT_KNOCKED_DOWN "knocked_down"
///Blinded by a flash
#define AI_CALLOUT_FLASHED "flashed"
///Caught in tear gas or pepper spray
#define AI_CALLOUT_GASSED "gassed"
///Slowdown instead of knockdown, for mobs that we set to not get knocked down
#define AI_CALLOUT_STAGGERED "staggered"
///Pulled itself together after breaking
#define AI_CALLOUT_RALLIED "rallied"
///Whispered with its last breath
#define AI_CALLOUT_DEATH_RATTLE "death rattle"
///Just turned wary, as an ally died nearby
#define AI_CALLOUT_WARY "wary"
///Just turned emboldened, as its side put someone down and has the numbers
#define AI_CALLOUT_EMBOLDENED "emboldened"
///Shot at with nowhere to take cover, so staying put looks like the choice it is
#define AI_CALLOUT_NO_COVER "no cover"
///An ally just died, and there's nobody else of ours left in earshot
#define AI_CALLOUT_LAST_STANDING "last standing"
///Can see someone it has no way to get to
#define AI_CALLOUT_CANT_REACH "cant reach"
///Its kill left nobody for it or its allies in earshot to fight, so as far as they know, they've won
#define AI_CALLOUT_ALL_CLEAR "all clear"
///Gave up on someone who got away, and nobody in earshot has anyone else to fight
#define AI_CALLOUT_GOT_AWAY "got away"
///Breaking through to someone it can see but can't get at, like smashing or shooting out the window between them
#define AI_CALLOUT_BREACHING "breaching"
///Bringing allies it's come across into a fight they weren't in yet, like running past them
#define AI_CALLOUT_RAISING_ALARM "raising alarm"
///Someone it put down is back on their feet
#define AI_CALLOUT_GETTING_UP "getting up"
///It's caught fire
#define AI_CALLOUT_ON_FIRE "on fire"
///It's patting out one of its own who's on fire
#define AI_CALLOUT_PUTTING_OUT "putting out"
///It's burning, and walking into who it's fighting to set them alight too
#define AI_CALLOUT_SPREADING_FIRE "spreading fire"
///One of its own just shot it
#define AI_CALLOUT_FRIENDLY_FIRE "friendly fire"

// Answers, said by an ally a moment after the line they answer, so it's a conversation rather than one voice
///Asking an ally who just got hurt how they're doing, answered with AI_CALLOUT_STATUS_OK or AI_CALLOUT_STATUS_BAD
#define AI_CALLOUT_CHECK_IN "check in"
///Answering AI_CALLOUT_CHECK_IN, with more than half our health left
#define AI_CALLOUT_STATUS_OK "status ok"
///Answering AI_CALLOUT_CHECK_IN, with half our health or less
#define AI_CALLOUT_STATUS_BAD "status bad"
///Answering AI_CALLOUT_LOST_THEM with which way we last saw them, put in the line where it says %DIRECTION
#define AI_CALLOUT_LAST_SEEN "last seen"
///Answering AI_CALLOUT_LOST_THEM with nothing new
#define AI_CALLOUT_NO_SIGN "no sign"
///Answering AI_CALLOUT_RELOADING, as one who can see who we're fighting
#define AI_CALLOUT_COVERING "covering"

// How often a mob talks, and how long it waits to
///How long after one urgent callout, said over everything else, before another can be
#define AI_CALLOUT_INTERRUPT_GAP (2 SECONDS)
///How long after the fight seems over we check it still is, before saying so
#define AI_CALLOUT_FIGHT_OVER_DELAY (3 SECONDS)
///How long after one of a group speaks the rest in earshot stay quiet, so they talk one at a time. Urgent lines, answers and last words still cut in.
#define AI_CALLOUT_TURN_GAP (1.5 SECONDS)
///The most chatter (non action/urgent lines) a group says in one AI_CALLOUT_TURN_GAP.
#define AI_CALLOUT_CHATTER_PER_TURN 2
///How long after a line an ally answers it
#define AI_CALLOUT_ANSWER_DELAY rand(1 SECONDS, 1.5 SECONDS)
