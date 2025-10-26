/**
 * Alt click
 * Unused except for AI
 */
/mob/proc/AltClickOn(atom/A)
	. = SEND_SIGNAL(src, COMSIG_MOB_ALTCLICKON, A)
	if(. & COMSIG_MOB_CANCEL_CLICKON)
		return
	A.AltClick(src)

/atom/proc/AltClick(mob/user)
	. = SEND_SIGNAL(src, COMSIG_CLICK_ALT, user)
	if(. & COMPONENT_CANCEL_CLICK_ALT)
		return
	var/turf/T = get_turf(src)
	if(T && (isturf(loc) || isturf(src)) && user.TurfAdjacent(T))
		user.set_listed_turf(T)

///The base proc of when something is right clicked on when alt is held - generally use alt_click_secondary instead
/atom/proc/alt_click_on_secondary(atom/A)
	. = SEND_SIGNAL(src, COMSIG_MOB_ALTCLICKON_SECONDARY, A)
	if(. & COMSIG_MOB_CANCEL_CLICKON)
		return
	A.alt_click_secondary(src)

///The base proc of when something is right clicked on when alt is held
/atom/proc/alt_click_secondary(mob/user)
	if(SEND_SIGNAL(src, COMSIG_CLICK_ALT_SECONDARY, user) & COMPONENT_CANCEL_CLICK_ALT_SECONDARY)
		return

/// Use this instead of [/mob/proc/AltClickOn] where you only want turf content listing without additional atom alt-click interaction
/atom/proc/AltClickNoInteract(mob/user, atom/A)
	var/turf/T = get_turf(A)
	if(T && user.TurfAdjacent(T))
		user.listed_turf = T
		user.client << output("[url_encode(json_encode(T.name))];", "statbrowser:create_listedturf")

/mob/proc/TurfAdjacent(turf/T)
	return T.Adjacent(src)
