/client/verb/testpreferences()
	set category = "Preferences"
	set name = "Test Menu"
	set desc = "Test the fucking menu idiot!"

	usr.client.prefs.ui_interact(usr)

/datum/preferences/ui_state(mob/user)
	return GLOB.always_state

/datum/preferences/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PreferencesUI")
		ui.open()

/datum/preferences/ui_data(mob/user)
	var/list/data = list()
	data["hair"] = user?.client?.prefs.hairstyle
	data["color"] = user?.client?.prefs.hair_color
	return data

/datum/preferences/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("test")
			usr?.client?.prefs.hair_color = random_short_color()
			. = TRUE
