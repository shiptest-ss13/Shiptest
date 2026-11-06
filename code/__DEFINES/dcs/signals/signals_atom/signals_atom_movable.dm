/// From /datum/element/immerse/proc/add_immerse_overlay(): (atom/movable/immerse_mask/effect_relay)
#define COMSIG_MOVABLE_EDIT_UNIQUE_IMMERSE_OVERLAY "movable_edit_unique_submerge_overlay"

///from base of atom/movable/newtonian_move(): (inertia_direction, start_delay)
#define COMSIG_MOVABLE_NEWTONIAN_MOVE "movable_newtonian_move"
	#define COMPONENT_MOVABLE_NEWTONIAN_BLOCK (1<<0)

///from datum/component/drift/apply_initial_visuals(): ()
#define COMSIG_MOVABLE_DRIFT_VISUAL_ATTEMPT "movable_drift_visual_attempt"
	#define DRIFT_VISUAL_FAILED (1<<0)
///from datum/component/drift/allow_final_movement(): ()
#define COMSIG_MOVABLE_DRIFT_BLOCK_INPUT "movable_drift_block_input"
	#define DRIFT_ALLOW_INPUT (1<<0)

///called when the movable's glide size is updated: (new_glide_size)
#define COMSIG_MOVABLE_UPDATE_GLIDE_SIZE "movable_glide_size"

///signal sent out by an atom when it is no longer being pulled by something else
#define COMSIG_ATOM_NO_LONGER_PULLED "movable_no_longer_pulled"
///signal sent out by an atom when it is no longer pulling something : (atom/pulling)
#define COMSIG_ATOM_NO_LONGER_PULLING "movable_no_longer_pulling"

