/**
 * tgui state: admin_state
 *
 * Checks that the user has R_ADMIN, end-of-story.
 *
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

GLOBAL_DATUM_INIT(admin_state, /datum/ui_state/admin_state, new)

/datum/ui_state/admin_state/can_use_topic(src_object, mob/user)
	if(check_rights_for(user.client, R_ADMIN))
		return UI_INTERACTIVE
	return UI_CLOSE

/**
 * tgui state: admin_debug_state
 *
 * Checks that the user has either R_ADMIN or R_DEBUG, this is nonsense related to the fact that R_ADMIN is bloated to shit.
 */

GLOBAL_DATUM_INIT(admin_debug_state, /datum/ui_state/admin_debug_state, new)

/datum/ui_state/admin_debug_state/can_use_topic(src_object, mob/user)
	if(check_rights_for(user.client, R_ADMIN|R_DEBUG))
		return UI_INTERACTIVE
	return UI_CLOSE
