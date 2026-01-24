///from base of atom/Entered(): (atom/movable/entering, /atom)
#define COMSIG_ATOM_ENTERED "atom_entered"
///from base of atom/movable/Moved(): (atom/movable/arrived, atom/old_loc, list/atom/old_locs)
#define COMSIG_ATOM_ABSTRACT_ENTERED "atom_abstract_entered"
///from base of atom/Exit(): (/atom/movable/exiting, /atom/newloc)
#define COMSIG_ATOM_EXIT "atom_exit"
	#define COMPONENT_ATOM_BLOCK_EXIT (1<<0)
///from base of atom/Exited(): (atom/movable/exiting, atom/newloc)
#define COMSIG_ATOM_EXITED "atom_exited"
///from base of atom/movable/Moved(): (atom/movable/gone, direction)
#define COMSIG_ATOM_ABSTRACT_EXITED "atom_abstract_exited"

//from SSatoms InitAtom - Only if the  atom was not deleted or failed initialization and has a loc
#define COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON "atom_init_success_on"


/// Called on [/atom/SpinAnimation()] : (speed, loops, segments, angle)
#define COMSIG_ATOM_SPIN_ANIMATION "atom_spin_animation"
