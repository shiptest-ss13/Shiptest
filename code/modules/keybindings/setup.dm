// Set a client's focus to an object and override these procs on that object to let it handle keypresses

/datum/proc/key_down(key, client/user) // Called when a key is pressed down initially
	return
/datum/proc/key_up(key, client/user) // Called when a key is released
	return
/datum/proc/keyLoop(client/user) // Called once every frame
	set waitfor = FALSE
	return

// removes all the existing macros
/client/proc/erase_all_macros()
	var/list/macro_sets = params2list(winget(src, null, "macros"))
	var/erase_output = ""
	for(var/setname in macro_sets)
		if(copytext(setname, 1, 9) == "persist_") // Don't remove macro sets not handled by input. Used in input_box.dm by create_input_window
			continue
		var/list/macro_set = params2list(winget(src, "[setname].*", "command")) // The third arg doesnt matter here as we're just removing them all
		for(var/k in 1 to macro_set.len)
			var/list/split_name = splittext(macro_set[k], ".")
			var/macro_name = "[split_name[1]].[split_name[2]]" // [3] is "command"
			erase_output = "[erase_output];[macro_name].parent=null"
	winset(src, null, erase_output)

/client/proc/set_macros()
	set waitfor = FALSE

	//Reset the buffer
	reset_held_keys()

	erase_all_macros()

	var/list/macro_sets = SSinput.macro_sets
	for(var/setname in macro_sets)
		if(setname != "default")
			winclone(src, "default", setname)
		var/list/macro_set = macro_sets[setname]
		for(var/key in macro_set)
			var/command = macro_set[key]
			winset(src, "[setname]-[REF(key)]", "parent=[setname];name=[key];command=[command]")

	//Reactivate any active tgui windows mouse passthroughs macros
	for(var/datum/tgui_window/window in tgui_windows)
		if(window.mouse_event_macro_set)
			window.mouse_event_macro_set = FALSE
			window.set_mouse_macro()

	if(prefs?.hotkeys)//tg put hotkeys at the client level, idk why, we still have it on prefs so I'm just gonna nullcheck this.
		winset(src, null, "map.focus=true mainwindow.macro=default")
	else
		winset(src, null, "input.focus=true mainwindow.macro=old_default")

	update_special_keybinds()
