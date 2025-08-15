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
#define BB_HIVE_SOURCE "BB_hive_partner"
