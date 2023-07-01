// DEBUG: test
/client/proc/set_next_outpost()
	set category = "Server"
	set name = "Set Next Outpost"

	var/list/choices = list()
	for(var/outpost_type in subtypesof(/datum/overmap/outpost))
		choices += outpost_type

	var/chosen = input("Select the outpost map to use next. Some outposts may not be intended for regular play!", "Select Outpost") as null|anything in choices
	if(!chosen || !ispath(chosen, /datum/overmap/outpost))
		return

	message_admins("[key_name_admin(usr)] is changing the outpost to [chosen]")
	log_admin("[key_name(usr)] is changing the outpost to [chosen]")

	if(fexists(OUTPOST_OVERRIDE_FILEPATH))
		fdel(OUTPOST_OVERRIDE_FILEPATH)
	var/result = text2file("[chosen]", OUTPOST_OVERRIDE_FILEPATH)

	if(result)
		message_admins("[key_name_admin(usr)] has changed the outpost to [chosen]")
