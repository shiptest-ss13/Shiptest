/client/proc/cmd_mentor_dementor()
	set category = "Mentor"
	set name = "Dementor"
	if(!check_mentor())
		return
	remove_mentor_verbs()
	if (/client/proc/mentor_unfollow in verbs)
		mentor_unfollow()
	GLOB.mentors -= src
	verbs += /client/proc/cmd_mentor_rementor

/client/proc/cmd_mentor_rementor()
	set category = "Mentor"
	set name = "Rementor"
	if(!check_mentor())
		return
	add_mentor_verbs()
	GLOB.mentors += src
	verbs -= /client/proc/cmd_mentor_rementor
