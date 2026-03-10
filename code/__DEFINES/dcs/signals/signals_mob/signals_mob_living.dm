/// from base of [/mob/living/changeNext_Move()] (next_move)
#define COMSIG_LIVING_CHANGENEXT_MOVE "living_changenext_move"

///From living/Life(). (deltatime, times_fired)
#define COMSIG_LIVING_LIFE "living_life"
	/// Block the Life() proc from proceeding... this should really only be done in some really wacky situations.
	#define COMPONENT_LIVING_CANCEL_LIFE_PROCESSING (1<<0)

/// From /mob/living/befriend() : (mob/living/new_friend)
#define COMSIG_LIVING_BEFRIENDED "living_befriended"
/// From /mob/living/unfriend() : (mob/living/old_friend)
#define COMSIG_LIVING_UNFRIENDED "living_unfriended"

/// From /mob/living/update_offsets(animate) : (new_x, new_y, new_w, new_z, animate)
#define COMSIG_LIVING_UPDATE_OFFSETS "living_update_offsets"

/// From /datum/ai/behavior/climb_tree/perform() : (mob/living/basic/living_pawn)
#define COMSIG_LIVING_CLIMB_TREE "living_climb_tree"

///Called when living finish eat (/datum/component/edible/proc/On_Consume)
#define COMSIG_LIVING_FINISH_EAT "living_finish_eat"
/// From /datum/element/basic_eating/try_eating()
#define COMSIG_MOB_PRE_EAT "mob_pre_eat"
	///cancel eating attempt
	#define COMSIG_MOB_CANCEL_EAT (1<<0)
/// From /datum/element/basic_eating/finish_eating()
#define COMSIG_MOB_ATE "mob_ate"
	///cancel post eating
	#define COMSIG_MOB_TERMINATE_EAT (1<<0)

///from end of fully_heal():
#define COMSIG_LIVING_POST_FULLY_HEAL "living_post_fully_heal"
