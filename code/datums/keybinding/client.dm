/datum/keybinding/client
	category = CATEGORY_CLIENT
	weight = WEIGHT_HIGHEST


/datum/keybinding/client/admin_help
	hotkey_keys = list("F1")
	name = "admin_help"
	full_name = "Admin Help"
	description = "Ask an admin for help."
	keybind_signal = COMSIG_KB_CLIENT_GETHELP_DOWN

/datum/keybinding/client/admin_help/down(client/user)
	. = ..()
	if(.)
		return
	user.get_adminhelp()
	return TRUE


/datum/keybinding/client/screenshot
	hotkey_keys = list("F2")
	name = "screenshot"
	full_name = "Screenshot"
	description = "Take a screenshot."
	keybind_signal = COMSIG_KB_CLIENT_SCREENSHOT_DOWN

/datum/keybinding/client/screenshot/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=.screenshot [!user.keys_held["shift"] ? "auto" : ""]")
	return TRUE

/datum/keybinding/client/minimal_hud
	hotkey_keys = list("F12")
	name = "minimal_hud"
	full_name = "Minimal HUD"
	description = "Hide most HUD features"
	keybind_signal = COMSIG_KB_CLIENT_MINIMALHUD_DOWN

/datum/keybinding/client/minimal_hud/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.button_pressed_F12()
	return TRUE

/client
	var/fullscreen = FALSE
/datum/keybinding/client/t_fullscreen
	hotkey_keys = list("F11")
	name = "change_fullscreen"
	full_name = "Toggle Fullscreen"
	description = "Change window to Fullscreen or back"
	keybind_signal = COMSIG_KB_CLIENT_FULLSCREEN_DOWN

/datum/keybinding/client/t_fullscreen/down(client/C)
	. = ..()
	C.toggle_fullscreen()


/client/verb/toggle_fullscreen()
	set name = "Toggle Fullscreen"
	set category = "OOC"

	fullscreen = !fullscreen

	if (fullscreen)
		winset(usr, "mainwindow", "on-size=")
		winset(usr, "mainwindow", "titlebar=false")
		winset(usr, "mainwindow", "can-resize=false")
		winset(usr, "mainwindow", "menu=")
		winset(usr, "mainwindow", "is-maximized=false")
		winset(usr, "mainwindow", "is-maximized=true")
	else
		winset(usr, "mainwindow", "titlebar=true")
		winset(usr, "mainwindow", "can-resize=true")
		winset(usr, "mainwindow", "menu=menu")
		winset(usr, "mainwindow", "is-maximized=false")
		winset(usr, "mainwindow", "on-size=fitviewport")

	fit_viewport()
