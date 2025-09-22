// /datum/overmap signals

/// From overmap Move(): (old_x, old_y)
#define COMSIG_OVERMAP_MOVED "overmap_moved"
/// From overmap move_overmaps(): (datum/overmap, old_x, old_y)
#define COMSIG_OVERMAP_MOVE_SYSTEMS "overmap_moved_systems"
/// From overmap Dock(): (datum/overmap)
#define COMSIG_OVERMAP_DOCK "overmap_dock"
/// From overmap Undock(): (datum/overmap)
#define COMSIG_OVERMAP_UNDOCK "overmap_undock"
/// From load_level() of when a dynamic, outpost or static datum
#define COMSIG_OVERMAP_LOADED "overmap_loaded"

/// From overmap jump points: (/datum/overmap_star_system, new_x, new_y)
#define COMSIG_OVERMAP_CALIBRATE_JUMP "overmap_calibrate_jump"
/// From overmap jump points
#define COMSIG_OVERMAP_CANCEL_JUMP "overmap_cancel_jump"


///Sent when a shuttle finishes loading to allow for any machinery that requires a late connection to fire that connection
#define COMSIG_SHIP_DONE_CONNECTING "late_connect"
