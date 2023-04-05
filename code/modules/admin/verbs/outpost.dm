/client/proc/set_next_outpost()
	set category = "Server"
	set name = "Set Next Outpost"

	var/list/choices = list()
	for(var/name in SSmapping.outpost_templates)
		var/datum/map_template/outpost/option = SSmapping.outpost_templates[name]
		if(!istype(option))
			continue
		choices += name

	var/chosen = input("Select the outpost map to use next", "Select Outpost") as null|anything in choices
	if(!chosen)
		return
	var/datum/map_template/outpost/chosen_datum = SSmapping.outpost_templates[chosen]

	message_admins("[key_name_admin(usr)] is changing the outpost to [chosen]")
	log_admin("[key_name(usr)] is changing the outpost to [chosen]")

	var/write_string = chosen_datum.get_json_string()
	if(fexists(OUTPOST_OVERRIDE_FILEPATH))
		fdel(OUTPOST_OVERRIDE_FILEPATH)
	var/result = text2file(write_string, OUTPOST_OVERRIDE_FILEPATH)

	if(result)
		message_admins("[key_name_admin(usr)] has changed the outpost to [chosen]")
