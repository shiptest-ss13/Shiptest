// timed_action_flags parameter for 'proc/do_after'
#define IGNORE_TARGET_IN_DOAFTERS (1<<0)
// The user can move freely without canceling the do_after
#define IGNORE_USER_LOC_CHANGE (1<<1)
// The target can move freely without canceling the do_after
#define IGNORE_TARGET_LOC_CHANGE (1<<2)
/// Can do the action even if the item is no longer being held
#define IGNORE_HELD_ITEM (1<<3)
/// Can do the action even if the mob is incapacitated
#define IGNORE_INCAPACITATED (1<<4)
/// Must be adjacent
#define REQUIRE_ADJACENCY (1<<5)
/// Can do the action even if the mob is handcuffed
#define IGNORE_RESTRAINED (1<<6)

// Combined parameters for ease of use
#define UNINTERRUPTIBLE IGNORE_TARGET_IN_DOAFTERS|IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE|IGNORE_HELD_ITEM|IGNORE_INCAPACITATED
#define UNINTERRUPTIBLE_CONSCIOUS IGNORE_TARGET_IN_DOAFTERS|IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE|IGNORE_HELD_ITEM
