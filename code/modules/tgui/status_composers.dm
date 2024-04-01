/// Returns a UI status such that users with debilitating conditions, such as
/// being dead or not having power for silicons, will not be able to interact.
/// Being dead will disable UI, being incapacitated will continue updating it,
/// and anything else will make it interactive.
/proc/ui_status_user_is_abled(mob/user, atom/source)
	return user.shared_ui_interaction(source)

/// Returns a UI status such that those without blocked hands will be able to interact,
/// but everyone else can only watch.
/proc/ui_status_user_has_free_hands(mob/user, atom/source)
	return HAS_TRAIT(user, TRAIT_HANDS_BLOCKED) ? UI_UPDATE : UI_INTERACTIVE

/*
/// Returns a UI status such that advanced tool users will be able to interact,
/// but everyone else can only watch.
/proc/ui_status_user_is_advanced_tool_user(mob/user)
	return ISADVANCEDTOOLUSER(user) ? UI_INTERACTIVE : UI_UPDATE
*/

/// Returns a UI status such that silicons will be able to interact with whatever
/// they would have access to if this was a machine. For example, AIs can
/// interact if there's cameras with wireless control is enabled.
/proc/ui_status_silicon_has_access(mob/user, atom/source)
	if (!issilicon(user))
		return UI_CLOSE
	var/mob/living/silicon/silicon_user = user
	return silicon_user.get_ui_access(source)

/// Returns a UI status representing this silicon's capability to access
/// the given source. Called by `ui_status_silicon_has_access`.
/mob/living/silicon/proc/get_ui_access(atom/source)
	return UI_CLOSE

/mob/living/silicon/robot/get_ui_access(atom/source)
	// Robots can interact with anything they can see.
	var/list/clientviewlist = getviewsize(client.view)
	if(get_dist(src, source) <= min(clientviewlist[1],clientviewlist[2]))
		return UI_INTERACTIVE
	return UI_DISABLED // Otherwise they can keep the UI open.

/mob/living/silicon/ai/get_ui_access(atom/source)
	// The AI can interact with anything it can see nearby, or with cameras while wireless control is enabled.
	if(!control_disabled && can_see(source))
		return UI_INTERACTIVE
	return UI_CLOSE

/mob/living/silicon/pai/get_ui_access(atom/source)
	// pAIs can only use themselves and the owner's radio.
	if((source == src || source == radio) && !stat)
		return UI_INTERACTIVE
	else
		return UI_CLOSE

/// Returns UI_INTERACTIVE if the user is conscious and lying down.
/// Returns UI_UPDATE otherwise.
/proc/ui_status_user_is_conscious_and_lying_down(mob/user)
	if (!isliving(user))
		return UI_UPDATE

	var/mob/living/living_user = user
	return (living_user.body_position == LYING_DOWN && living_user.stat == CONSCIOUS) \
		? UI_INTERACTIVE \
		: UI_UPDATE

/// Return UI_INTERACTIVE if the user is strictly adjacent to the target atom, whether they can see it or not.
/// Return UI_CLOSE otherwise.
/proc/ui_status_user_strictly_adjacent(mob/user, atom/target)
	if(get_dist(target, user) > 1)
		return UI_CLOSE

	return UI_INTERACTIVE
