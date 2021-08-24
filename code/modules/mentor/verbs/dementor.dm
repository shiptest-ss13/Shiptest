/client/proc/cmd_mentor_dementor()
	set category = "Mentor"
	set name = "Dementor"
	if(!check_mentor())
		return
	var/datum/mentors/mentor = GLOB.mentor_datums[ckey]
	mentor.disassociate()
	add_verb(src, /client/proc/cmd_mentor_rementor)

/client/proc/cmd_mentor_rementor()
	set category = "Mentor"
	set name = "Rementor"
	if(!check_mentor())
		return
	remove_verb(src, /client/proc/cmd_mentor_rementor)
	var/datum/mentors/mentor = GLOB.mentor_datums[ckey]
	mentor.associate(src)
