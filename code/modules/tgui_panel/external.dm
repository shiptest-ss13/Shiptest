/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/client/var/datum/tgui_panel/tgui_panel

/**
 * tgui panel / chat troubleshooting verb
 */
/client/verb/fix_tgui_panel()
	set name = "Fix chat"
	set category = "OOC"
	
	nuke_chat()

/client/proc/nuke_chat()
	var/action

	// Catch all solution (kick the whole thing in the pants)
	log_tgui(src, "Started fixing.",
		context = "verb/fix_tgui_panel")
	// Not ready
	if(!tgui_panel?.is_ready())
		log_tgui(src, "Panel is not ready",
			context = "verb/fix_tgui_panel")
		tgui_panel.window.send_message("ping", force = TRUE)
		action = alert(src, "Method: Pinging the panel.\nWait a bit and tell me if it's fixed", "", "Fixed", "Nope")
		if(action == "Fixed")
			log_tgui(src, "Fixed by sending a ping",
				context = "verb/fix_tgui_panel")
			return
	// Catch all solution
	if(!tgui_panel || !istype(tgui_panel))
		log_tgui(src, "tgui_panel datum is missing",
			context = "verb/fix_tgui_panel")
		tgui_panel = new(src)
	tgui_panel.initialize(force = TRUE)
	// Force show the panel to see if there are any errors
	winset(src, "output", "is-disabled=1&is-visible=0")
	winset(src, "browseroutput", "is-disabled=0;is-visible=1")
	action = alert(src, "Method: Reinitializing the panel.\nWait a bit and tell me if it's fixed", "", "Fixed", "Nope")
	if(action == "Fixed")
		log_tgui(src, "Fixed by calling 'initialize'",
			context = "verb/fix_tgui_panel")
		return
	// Failed to fix
	action = alert(src, "Welp, I'm all out of ideas. Try closing BYOND and reconnecting.\nWe could also disable tgui_panel and re-enable the old UI", "", "Thanks anyways", "Switch to old UI")
	if (action == "Switch to old UI")
		winset(src, "output", "on-show=&is-disabled=0&is-visible=1")
		winset(src, "browseroutput", "is-disabled=1;is-visible=0")
	log_tgui(src, "Failed to fix.",
		context = "verb/fix_tgui_panel")

/client/verb/refresh_tgui()
	set name = "Refresh TGUI"
	set category = "OOC"

	for(var/window_id in tgui_windows)
		var/datum/tgui_window/window = tgui_windows[window_id]
		window.reinitialize()
