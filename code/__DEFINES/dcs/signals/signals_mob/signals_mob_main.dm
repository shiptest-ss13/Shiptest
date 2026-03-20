/// From base of /client/proc/change_view() (mob/source, new_size)
#define COMSIG_MOB_CLIENT_CHANGE_VIEW "mob_client_change_view"
/// From base of /mob/proc/reset_perspective() (mob/source)
#define COMSIG_MOB_RESET_PERSPECTIVE "mob_reset_perspective"
/// From base of /mob/proc/has_ship_access() (mob/source, datum/overmap/ship/controlled/ship)
#define COMSIG_MOB_HAS_SHIP_ACCESS "mob_has_ship_access"
	/// Allows a mob access to a ship
	#define ALLOW_SHIP_ACCESS (1<<0)
	/// Denies a mob access to a ship
	#define DENY_SHIP_ACCESS (1<<1)
