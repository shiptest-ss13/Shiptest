//Generic BB keys
#define BB_CURRENT_MIN_MOVE_DISTANCE "min_move_distance"



///Hostile AI controller blackboard keys
#define BB_HOSTILE_ORDER_MODE "BB_HOSTILE_ORDER_MODE"
#define BB_HOSTILE_FRIEND "BB_HOSTILE_FRIEND"
#define BB_HOSTILE_ATTACK_WORD "BB_HOSTILE_ATTACK_WORD"
#define BB_FOLLOW_TARGET "BB_FOLLOW_TARGET"
#define BB_ATTACK_TARGET "BB_ATTACK_TARGET"
#define BB_VISION_RANGE "BB_VISION_RANGE"

/// Basically, what is our vision/hearing range.
#define BB_HOSTILE_VISION_RANGE 10

///Dog AI controller blackboard keys

#define BB_SIMPLE_CARRY_ITEM "BB_SIMPLE_CARRY_ITEM"
#define BB_FETCH_TARGET "BB_FETCH_TARGET"
#define BB_FETCH_IGNORE_LIST "BB_FETCH_IGNORE_LISTlist"
#define BB_FETCH_DELIVER_TO "BB_FETCH_DELIVER_TO"
#define BB_DOG_FRIENDS "BB_DOG_FRIENDS"
#define BB_DOG_ORDER_MODE "BB_DOG_ORDER_MODE"
#define BB_DOG_PLAYING_DEAD "BB_DOG_PLAYING_DEAD"
#define BB_DOG_HARASS_TARGET "BB_DOG_HARASS_TARGET"


///list of foods this mob likes
#define BB_BASIC_FOODS "BB_basic_foods"

///key holding any food we've found
#define BB_TARGET_FOOD "BB_TARGET_FOOD"

///key holding emotes we play after eating
#define BB_EAT_EMOTES "BB_eat_emotes"

///key holding the next time we eat
#define BB_NEXT_FOOD_EAT "BB_next_food_eat"

///key holding our eating cooldown
#define BB_EAT_FOOD_COOLDOWN "BB_eat_food_cooldown"

///key holding a range to look for stuff in
#define BB_SEARCH_RANGE "BB_search_range"

///Tipped blackboards
///Bool that means a basic mob will start reacting to being tipped in its planning
#define BB_BASIC_MOB_TIP_REACTING "BB_basic_tip_reacting"
///the motherfucker who tipped us
#define BB_BASIC_MOB_TIPPER "BB_basic_tip_tipper"

///Hunting BB keys
#define BB_CURRENT_HUNTING_TARGET "BB_current_hunting_target"
#define BB_LOW_PRIORITY_HUNTING_TARGET "BB_low_priority_hunting_target"
#define BB_HUNTING_COOLDOWN "BB_HUNTING_COOLDOWN"

///Basic Mob Keys

///Targetting subtrees
#define BB_BASIC_MOB_CURRENT_TARGET "BB_basic_current_target"
///Where we think our current target is: where we last saw them, or were told, heard or guessed they are
#define BB_BASIC_MOB_LAST_KNOWN_TURF "BB_basic_last_known_turf"
///When we last had word of where our current target is, either first or secondhand, as a world.time. We give up on them once it's too long ago
#define BB_BASIC_MOB_LAST_KNOWN_TIME "BB_basic_last_known_time"
///When we last actually had eyes on whoever we were fighting, as a world.time. Unlike BB_BASIC_MOB_LAST_KNOWN_TIME, being told or hearing about them doesn't count, and it outlasts switching targets.
#define BB_BASIC_MOB_LAST_SAW_ENEMY_TIME "BB_basic_last_saw_enemy_time"
///Each enemy we've had eyes on, and when we last did, as list(enemy = world.time), so someone ducking in and out of cover isn't news each time
#define BB_BASIC_MOB_SEEN_ENEMIES "BB_basic_seen_enemies"
///Until when we hold off attacking, having only just spotted someone new, so we don't open up the instant they come into view
#define BB_BASIC_MOB_HOLD_FIRE_UNTIL "BB_basic_hold_fire_until"
///TRUE while we can see our current target, FALSE while they're out of sight, null when we're not tracking them, like with no target
#define BB_BASIC_MOB_TARGET_IN_SIGHT "BB_basic_target_in_sight"
///Who BB_BASIC_MOB_LAST_KNOWN_TURF and BB_BASIC_MOB_LAST_KNOWN_TIME are about, so switching targets starts fresh
#define BB_BASIC_MOB_LAST_KNOWN_TARGET "BB_basic_last_known_target"
///Where we live and go back to once there's nothing to do
#define BB_BASIC_MOB_HOME_TURF "BB_basic_home_turf"
///TRUE while all we know about our target is what an ally told us, so we don't pass it on and set off a chain of alerts. Cleared once we see them ourselves
#define BB_BASIC_MOB_TOLD_ABOUT_TARGET "BB_basic_told_about_target"
///Who we've already told our allies about, so we only call it out once per target
#define BB_BASIC_MOB_ALERTED_ABOUT "BB_basic_alerted_about"
///When we were last shot at, as a world.time
#define BB_BASIC_MOB_LAST_SHOT_TIME "BB_basic_last_shot_time"
///When anything last hurt us, shots, blows, bites or otherwise, as a world.time
#define BB_BASIC_MOB_LAST_HURT_TIME "BB_basic_last_hurt_time"
///TRUE if we can get about in open space, like with a jetpack, so our pathfinding takes us across it
#define BB_BASIC_MOB_CAN_CROSS_SPACE "BB_basic_can_cross_space"
///Where the last shot at us came from
#define BB_BASIC_MOB_SHOT_FROM "BB_basic_shot_from"
///Where we're taking cover. While set, the cover subtree is in charge of where we stand
#define BB_BASIC_MOB_TAKING_COVER_TURF "BB_basic_taking_cover_turf"
///Where we're stepping out of cover to fire from, while we do
#define BB_BASIC_MOB_PEEK_TURF "BB_basic_peek_turf"
///When we'll top up our magazine, now that the fighting's died down
#define BB_BASIC_MOB_TACTICAL_RELOAD_AT "BB_basic_tactical_reload_at"
///TRUE once we've called out searching for our target, so we only say it once each time we lose them
#define BB_BASIC_MOB_SEARCH_CALLED_OUT "BB_basic_search_called_out"
///When we'll next try a taunt
#define BB_BASIC_MOB_NEXT_TAUNT "BB_basic_next_taunt"
///The last closing in or backing off callout we made, as an AI_CALLOUT_ define, so we only call it out when that changes
#define BB_BASIC_MOB_LAST_RANGE_CALLOUT "BB_basic_last_range_callout"
///TRUE while all we know about our target is gunfire we heard
#define BB_BASIC_MOB_HEARD_TARGET "BB_basic_heard_target"
///Where we're sweeping around while looking for someone we only heard, how far out, how many more spots we'll check, and when we stop looking around the current one.
#define BB_BASIC_MOB_SWEEP_CENTER "BB_basic_sweep_center"
#define BB_BASIC_MOB_SWEEP_RADIUS "BB_basic_sweep_radius"
#define BB_BASIC_MOB_SWEEP_SPOTS_LEFT "BB_basic_sweep_spots_left"
#define BB_BASIC_MOB_SWEEP_PAUSE_UNTIL "BB_basic_sweep_pause_until"
///Whether we decided to go around what's blocking our shot at our target, and when we'll think again. Null while our line's clear
#define BB_BASIC_MOB_FLANKING "BB_basic_flanking"
#define BB_BASIC_MOB_NEXT_FLANK_DECISION "BB_basic_next_flank_decision"
///Where we're going around to, to get an angle on someone dug in behind cover
#define BB_BASIC_MOB_FLANK_TURF "BB_basic_flank_turf"
///What we say and emote now and then while there's nobody to fight, as lists, and the chance each 2 seconds
#define BB_BASIC_MOB_IDLE_LINES "BB_basic_idle_lines"
#define BB_BASIC_MOB_IDLE_EMOTES "BB_basic_idle_emotes"
#define BB_BASIC_MOB_IDLE_CHATTER_CHANCE "BB_basic_idle_chatter_chance"
///How far we can be heard calling allies to a fight, overriding the behaviour's own
#define BB_BASIC_MOB_ALERT_RANGE "BB_basic_alert_range"
///If TRUE, we make a show of calling allies to a fight, with a "!" over our head and a chime
#define BB_BASIC_MOB_SUMMONS_BACKUP "BB_basic_summons_backup"
///What we last fired at, a mob or a spot we fired at blind, and when, so we keep facing it as we move between shots
#define BB_BASIC_MOB_LAST_FIRED_AT "BB_basic_last_fired_at"
#define BB_BASIC_MOB_LAST_FIRED_TIME "BB_basic_last_fired_time"
///Where we're falling back to while our nerve's gone
#define BB_BASIC_MOB_FALLBACK_TURF "BB_basic_fallback_turf"
///Where we're working our way in to next, out of their line of fire, and when we'll next look for one with nowhere to go. Usually for melee mobs
#define BB_BASIC_MOB_APPROACH_TURF "BB_basic_approach_turf"
#define BB_BASIC_MOB_NEXT_APPROACH_SEARCH "BB_basic_next_approach_search"
///When we can next take a swing at whoever's cornered us while we're running from them
#define BB_BASIC_MOB_NEXT_LASH_OUT "BB_basic_next_lash_out"
///Who we're lashing out at, our target or anyone else of theirs right on top of us
#define BB_BASIC_MOB_LASH_OUT_TARGET "BB_basic_lash_out_target"
///Since when our target's been within reach. Null while they're not, so reactions to them getting close can wait a moment
#define BB_BASIC_MOB_TARGET_ADJACENT_SINCE "BB_basic_target_adjacent_since"
///When a gunner next thinks about shoving whoever's right next to us away, to get room to shoot
#define BB_BASIC_MOB_NEXT_SHOVE_CHECK "BB_basic_next_shove_check"
///If TRUE, we've nothing in our hands, so we shove whoever's cornered us out of the way rather than swinging at them
#define BB_BASIC_MOB_SHOVES_WHEN_CORNERED "BB_basic_shoves_when_cornered"
///How we're feeling about the fight, an AI_MORALE_ define, and until when.
#define BB_BASIC_MOB_MORALE "BB_basic_morale"
#define BB_BASIC_MOB_MORALE_UNTIL "BB_basic_morale_until"
///Who last shot at us
#define BB_BASIC_MOB_SHOT_BY "BB_basic_shot_by"
///When we last decided how to react to being shot, so we decide once per shot
#define BB_BASIC_MOB_LAST_HANDLED_SHOT_TIME "BB_basic_last_handled_shot_time"
///Until when we're standing our ground and firing back rather than taking cover
#define BB_BASIC_MOB_TRADING_FIRE_UNTIL "BB_basic_trading_fire_until"
///Somewhere we thought was cover, until we got shot there, so we don't go back to it
#define BB_BASIC_MOB_BAD_COVER_TURF "BB_basic_bad_cover_turf"
///When we last checked our cover was still safe, and from where, so we don't trace every shot line every time we plan
#define BB_BASIC_MOB_COVER_CHECKED_AT "BB_basic_cover_checked_at"
#define BB_BASIC_MOB_COVER_CHECKED_FROM "BB_basic_cover_checked_from"
///When we next look around for who we should be fighting
#define BB_BASIC_MOB_NEXT_TARGET_SEARCH "BB_basic_next_target_search"
///Where we're fighting from, behind cover like sandbags or out of sight of a target dug in behind theirs
#define BB_BASIC_MOB_FIGHTING_COVER_TURF "BB_basic_fighting_cover_turf"
///Until when we're keeping out of sight of a target dug in behind cover we can't match, rather than walking back into their line of fire
#define BB_BASIC_MOB_HIDING_FROM_ENTRENCHED_UNTIL "BB_basic_hiding_from_entrenched_until"
///When we next look for somewhere to fight from
#define BB_BASIC_MOB_NEXT_COVER_SEARCH "BB_basic_next_cover_search"
///When we next look for somewhere to hide, after looking and finding nowhere
#define BB_BASIC_MOB_NEXT_HIDE_SEARCH "BB_basic_next_hide_search"
///Where we wait out of sight of someone we can't get to, like out in open space
#define BB_BASIC_MOB_WAIT_TURF "BB_basic_wait_turf"
///When we next look for somewhere to wait out of sight of someone we can't get to
#define BB_BASIC_MOB_NEXT_WAIT_SEARCH "BB_basic_next_wait_search"
///What we're breaking through to get at someone we've no other way to, like a window
#define BB_BASIC_MOB_SMASH_TARGET "BB_basic_smash_target"
///Where we're waiting out of sight of someone dug in, and until when
#define BB_BASIC_MOB_AMBUSH_TURF "BB_basic_ambush_turf"
#define BB_BASIC_MOB_AMBUSH_UNTIL "BB_basic_ambush_until"
///When we'd next set an ambush, after the last
#define BB_BASIC_MOB_NEXT_AMBUSH "BB_basic_next_ambush"
///If TRUE, we climb over things in our way, like sandbags and tables, when there's no way round
#define BB_BASIC_MOB_CAN_CLIMB "BB_basic_can_climb"
///How keen we are to be the one who flanks, higher goes first
#define BB_BASIC_MOB_FLANK_PRIORITY "BB_basic_flank_priority"
///TRUE if the last shot at us went close by rather than hitting
#define BB_BASIC_MOB_SHOT_NEAR_MISS "BB_basic_shot_near_miss"
///If TRUE, we stay put while we've a clear shot, rather than moving about between shots
#define BB_BASIC_MOB_HOLDS_POSITION "BB_basic_holds_position"
///What we last started climbing, and when, so we give up on a climb that isn't working
#define BB_BASIC_MOB_CLIMBING "BB_basic_climbing"
#define BB_BASIC_MOB_CLIMBING_SINCE "BB_basic_climbing_since"
///When we started waiting on someone we've no way to
#define BB_BASIC_MOB_UNREACHABLE_SINCE "BB_basic_unreachable_since"
///Those we gave up on getting to, as list(target = until when we leave them be)
#define BB_BASIC_MOB_IGNORED_TARGETS "BB_basic_ignored_targets"
///What our movement last gave up on finding a way to
#define BB_BASIC_MOB_NO_PATH_TO "BB_basic_no_path_to"
///When our movement gave up on finding a way to BB_BASIC_MOB_NO_PATH_TO, as a world.time
#define BB_BASIC_MOB_NO_PATH_SINCE "BB_basic_no_path_since"
///A safe spot we couldn't find our way to, so we don't keep picking it
#define BB_BASIC_MOB_BAD_SAFE_TURF "BB_basic_bad_safe_turf"
///How many times in a row we've looked for a safe spot and found none, giving up for a while once it's too many
#define BB_BASIC_MOB_SAFETY_FAILURES "BB_basic_safety_failures"
///How many shots we've fired, ever, so subtrees can count how many since something happened
#define BB_BASIC_MOB_SHOTS_FIRED "BB_basic_shots_fired"
///When we last hit someone in melee
#define BB_BASIC_MOB_LAST_MELEE_HIT_TIME "BB_basic_last_melee_hit_time"
///With hit and run, BB_BASIC_MOB_SHOTS_FIRED when we got in close, and until when we're backing off again
#define BB_BASIC_MOB_SHOTS_AT_CLOSE_IN "BB_basic_shots_at_close_in"
#define BB_BASIC_MOB_BACKING_OFF_UNTIL "BB_basic_backing_off_until"
///The search style we picked when we lost sight of our target, kept until we find them or give up
#define BB_BASIC_MOB_PICKED_SEARCH_STYLE "BB_basic_picked_search_style"
///How we're searching right now, after anything that changes our mind, so allies can tell who's already gone after them
#define BB_BASIC_MOB_ACTIVE_SEARCH_STYLE "BB_basic_active_search_style"
///Someone we fought who's gone down, and when, so we can stick around a while before heading home
#define BB_BASIC_MOB_DOWNED_TARGET "BB_basic_downed_target"
#define BB_BASIC_MOB_DOWNED_AT "BB_basic_downed_at"
///A mob's own range to fight at, overriding /datum/ai_planning_subtree/maintain_distance's
#define BB_BASIC_MOB_RETREAT_DISTANCE "BB_basic_retreat_distance"
#define BB_BASIC_MOB_ENGAGE_DISTANCE "BB_basic_engage_distance"
///How many times we hit in each melee attack, spread over its cooldown. Null for once
#define BB_BASIC_MOB_MELEE_HITS "BB_basic_melee_hits"
///How far a mob sees targets, overriding what its subtrees and behaviours would use, like for sentries with a scope
#define BB_BASIC_MOB_VISION_RANGE "BB_basic_vision_range"
///If TRUE, the mob holds its fire when one of its own is in the way
#define BB_BASIC_MOB_AVOID_FRIENDLY_FIRE "BB_basic_avoid_friendly_fire"
///If TRUE, a mob with a ranged attack would rather hit someone right next to it than shoot them, like with a knife in its other hand
#define BB_BASIC_MOB_PREFERS_MELEE "BB_basic_prefers_melee"
///Since when we've had nowhere to go but through something, and where we're trying to get
#define BB_BASIC_MOB_STUCK_SINCE "BB_basic_stuck_since"
#define BB_BASIC_MOB_STUCK_GOING_TO "BB_basic_stuck_going_to"
///Somewhere nearby that's safe for us to stand, while where we are isn't, and when we'll next look for one
#define BB_BASIC_MOB_SAFE_TURF "BB_basic_safe_turf"
#define BB_BASIC_MOB_NEXT_SAFETY_SEARCH "BB_basic_next_safety_search"
///Where we're moving to between shots, and when we'll next move
#define BB_BASIC_MOB_REPOSITION_TURF "BB_basic_reposition_turf"
#define BB_BASIC_MOB_NEXT_REPOSITION "BB_basic_next_reposition"
///Until when we don't hurry to look for somewhere to shoot from again, after looking and finding nowhere
#define BB_BASIC_MOB_REPOSITION_FAILED_UNTIL "BB_basic_reposition_failed_until"
///When we give up getting to BB_BASIC_MOB_REPOSITION_TURF, like if there's no way there after all
#define BB_BASIC_MOB_REPOSITION_GIVE_UP_AT "BB_basic_reposition_give_up_at"
///How much we move about in a fight, an AI_MOBILITY_ define. Null for normal
#define BB_BASIC_MOB_MOBILITY "BB_basic_mobility"
///If TRUE, we dart in for a few shots then back off for a moment, whatever our maintain_distance subtree says
#define BB_BASIC_MOB_HIT_AND_RUN "BB_basic_hit_and_run"
#define BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION "BB_basic_current_target_hiding_location"
#define BB_TARGETTING_DATUM "targetting_datum"

///some behaviors that check current_target also set this on deep crit mobs
#define BB_BASIC_MOB_EXECUTION_TARGET "BB_basic_execution_target"
///Blackboard key for a whitelist typecache of "things we can target while trying to move"
#define BB_OBSTACLE_TARGETING_WHITELIST "BB_targeting_whitelist"
/// Key for the minimum status at which we want to target mobs (does not need to be specified if CONSCIOUS)
#define BB_TARGET_MINIMUM_STAT "BB_target_minimum_stat"
/// Flag for whether to target only wounded mobs
#define BB_TARGET_WOUNDED_ONLY "BB_target_wounded_only"
/// What typepath the holding object targeting strategy should look for
#define BB_TARGET_HELD_ITEM "BB_target_held_item"
/// How likely is this mob to move when idle per tick?
#define BB_BASIC_MOB_IDLE_WALK_CHANCE "BB_basic_idle_walk_chance"

///List of mobs who have damaged us
#define BB_BASIC_MOB_RETALIATE_LIST "BB_basic_mob_shitlist"

///bear keys
///the hive with honey that we will steal from
#define BB_FOUND_HONEY "BB_found_honey"
///the tree that we will climb
#define BB_CLIMBED_TREE "BB_climbed_tree"

///hivebot keys
///the machine we must go to repair
#define BB_REPAIR_TARGET "BB_repair_target"
///the machine we must go to repair
#define BB_SALVAGE_TARGET "BB_salvage_target"
///the hivebot partner we will go communicate with
#define BB_HIVE_PARTNER "BB_hive_partner"
///Our source hive. We try to defend this.
#define BB_HIVE_SOURCE "BB_hive_source"
