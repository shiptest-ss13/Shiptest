// /datum/overmap signals
///Send when a dynamic datum completes load level.
#define COMSIG_OVERMAP_LOADED "overmap_loaded"
/// From overmap Move(): (old_x, old_y)
#define COMSIG_OVERMAP_MOVED "overmap_moved"
/// From overmap Dock(): (datum/overmap)
#define COMSIG_OVERMAP_DOCK "overmap_dock"
/// From overmap Undock(): (datum/overmap)
#define COMSIG_OVERMAP_UNDOCK "overmap_undock"

///Sent when a shuttle finishes loading to allow for any machinery that requires a late connection to fire that connection
#define COMSIG_SHIP_DONE_CONNECTING "late_connect"
