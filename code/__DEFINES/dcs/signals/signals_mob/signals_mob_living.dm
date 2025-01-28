/// from base of [/mob/living/changeNext_Move()] (next_move)
#define COMSIG_LIVING_CHANGENEXT_MOVE "living_changenext_move"

///From living/Life(). (deltatime, times_fired)
#define COMSIG_LIVING_LIFE "living_life"
	/// Block the Life() proc from proceeding... this should really only be done in some really wacky situations.
	#define COMPONENT_LIVING_CANCEL_LIFE_PROCESSING (1<<0)
