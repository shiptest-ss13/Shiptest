/client/proc/set_next_outpost()
	set category = "Server"
	set name = "Set Next Outpost Systems"

	var/list/choices = list()
	for(var/datum/overmap_star_system/potential_system as anything in subtypesof(/datum/overmap_star_system/safezone))
		choices["[potential_system.name] - [potential_system.default_outpost_type.outpost_name]"] = potential_system

	var/selected = tgui_input_list(usr, "Select the first outpost to use next round. Some systems may not be intended for regular play!", "Select Outpost", choices)
	var/datum/overmap_star_system/safezone/first_chosen = choices[selected]
	if(!first_chosen || !ispath(first_chosen, /datum/overmap_star_system/safezone))
		return

	choices -= selected

	selected = tgui_input_list(usr, "Select the second outpost to use next round. Some systems may not be intended for regular play!", "Select Outpost", choices)
	var/datum/overmap_star_system/safezone/second_chosen = choices[selected]
	if(!second_chosen)
		selected = pick(choices)
		second_chosen = choices[selected]

	if(!ispath(second_chosen, /datum/overmap_star_system/safezone))
		return

	log_admin("[key_name(usr)] is changing the outpost to [first_chosen.default_outpost_type.outpost_name] and [second_chosen.default_outpost_type.outpost_name]")

	if(fexists(SAFEZONE_OVERRIDE_FILEPATH))
		fdel(SAFEZONE_OVERRIDE_FILEPATH)
	var/result = text2file("[first_chosen]:[second_chosen]", SAFEZONE_OVERRIDE_FILEPATH)

	if(result)
		message_admins("[key_name_admin(usr)] has set next round's outposts to [first_chosen.name] and [second_chosen.name]")

/client/proc/set_next_wilderness()
	set category = "Server"
	set name = "Set Next Wilderness Systems"

	var/list/choices = list()
	for(var/datum/overmap_star_system/wilderness/potential_system as anything in typesof(/datum/overmap_star_system/wilderness))
		if(potential_system.unique_system)
			choices["[potential_system.starname] - [potential_system.startype.name]"] = potential_system
		else
			choices[potential_system] = potential_system

	var/selected = tgui_input_list(usr, "Select the first wilderness to use next round. Some systems may not be intended for regular play!", "Select Wilderness", choices)
	var/datum/overmap_star_system/wilderness/first_chosen = choices[selected]
	if(!first_chosen || !ispath(first_chosen, /datum/overmap_star_system/wilderness))
		return

	if(first_chosen.unique_system)
		choices =- selected

	selected = tgui_input_list(usr, "Select the second wilderness to use next round. Some systems may not be intended for regular play!", "Select Wilderness", choices)
	var/datum/overmap_star_system/wilderness/second_chosen = choices[selected]
	if(!second_chosen)
		second_chosen = pick(choices)

	if(!ispath(second_chosen, /datum/overmap_star_system/wilderness))
		return

	log_admin("[key_name(usr)] is changing the wilderness to [first_chosen] and [second_chosen]")

	if(fexists(WILDERNESS_OVERRIDE_FILEPATH))
		fdel(WILDERNESS_OVERRIDE_FILEPATH)
	var/result = text2file("[first_chosen]:[second_chosen]", WILDERNESS_OVERRIDE_FILEPATH)

	if(result)
		message_admins("[key_name_admin(usr)] has set next round's wilderness to [first_chosen] and [second_chosen]")

/client/proc/spawn_outpost()
	set name = "Spawn Outpost"
	set category = "Event.Overmap"
	set desc = "Spawns the selected /datum/overmap/outpost subtype."

	if(!holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	if(check_rights(R_DEBUG, 1))
		var/datum/overmap/outpost/outpost_type
		var/location

		outpost_type = input("Select the outpost type to use next. Some outposts may not be intended for regular play!", "Select Outpost") as null|anything in subtypesof(/datum/overmap/outpost)
		if(!outpost_type || !ispath(outpost_type, /datum/overmap/outpost))
			return

		var/list/choices = list("Random Overmap Square", "Specific Overmap Square")
		var/choice = input("Select a location for the outpost.", "Outpost Location") as null|anything in choices
		switch(choice)
			if(null)
				return
			if("Random Overmap Square")
				location = null
			if("Specific Overmap Square")
				var/loc_x = input(usr, "X overmap coordinate:") as num
				var/loc_y = input(usr, "Y overmap coordinate:") as num
				location = list("x" = loc_x, "y" = loc_y)

		var/datum/overmap_star_system/selected_system //the star system we are
		if(length(SSovermap.tracked_star_systems) > 1)
			selected_system = tgui_input_list(usr, "Which star system do you want to spawn it in?", "Spawn Planet/Ruin", SSovermap.tracked_star_systems)
		else
			selected_system = SSovermap.tracked_star_systems[1]
		if(!selected_system)
			return //if selected_system didnt get selected, we nope out, this is very bad

		message_admins("[key_name_admin(usr)] is spawning the outpost [outpost_type]!")
		log_admin("[key_name(usr)] is spawning the outpost [outpost_type]!")

		var/datum/overmap/outpost/created = new outpost_type(location, selected_system)

		message_admins("[key_name_admin(usr)] has spawned the outpost [created] ([REF(created)], [created.type])!")
		log_admin("[key_name(usr)] has spawned the outpost [created] ([REF(created)], [created.type])!")

