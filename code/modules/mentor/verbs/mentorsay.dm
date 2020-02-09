/client/proc/cmd_mentor_say(msg as text)
	set category = "Mentor"
	set name = "Msay"
	set hidden = 1
	if(!check_mentor())	return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)	return

	msg = emoji_parse(msg)
	log_mentor("MSAY: [key_name(src)] : [msg]")


	if(check_rights(R_ADMIN,0))
		msg = "<span class='mentoradmin'><span class='boldnotice'>MENTOR:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></span>"
		to_chat(GLOB.mentors, msg)
		to_chat(GLOB.admins, msg)

	else
		msg = "<span class='mentor'><span class='boldnotice'>MENTOR:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></span>"
		to_chat(GLOB.mentors, msg)
		to_chat(GLOB.admins, msg)

/client/proc/get_mentor_say()
	var/msg = input(src, null, "msay \"text\"") as text|null
	cmd_mentor_say(msg)
