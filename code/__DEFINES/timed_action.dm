// timed_action_flags parameter for 'proc/do_after'

// The user can move freely without canceling the do_after
#define IGNORE_USER_LOC_CHANGE (1<<0)
// The target can move freely without canceling the do_after
#define IGNORE_TARGET_LOC_CHANGE (1<<1)
/// Can do the action even if the item is no longer being held
#define IGNORE_HELD_ITEM (1<<2)
/// Can do the action even if the mob is incapacitated
#define IGNORE_INCAPACITATED (1<<3)
/// Can do the action even if the mob changes active hand
#define IGNORE_HAND_CHANGE (1<<4)
