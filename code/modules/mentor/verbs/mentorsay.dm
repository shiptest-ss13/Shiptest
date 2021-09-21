/client/proc/cmd_mentor_say(msg as text)
	set category = "Mentor"
	set name = "Msay"
	set hidden = 1
	if(!check_mentor())
		return

	msg = emoji_parse(copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN))
	if(!msg)
		return

	mob.log_talk(msg, LOG_MSAY)
	SSshipbot.relay_mentor_say(ckey, msg)

	msg = "<span class='[check_rights(R_ADMIN, 0) ? "mentoradmin" : "mentor"]'><span class='boldnotice'>MENTOR:</span> <EM>[key_name(usr, 0, 0)]</EM>: <span class='message'>[msg]</span></span>"
	to_chat(GLOB.mentors,
		type = MESSAGE_TYPE_MODCHAT,
		html = msg,
		confidential = TRUE)

	SSblackbox.record_feedback("tally", "mentor_verb", 1, "Msay") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/get_mentor_say()
	var/msg = input(src, null, "msay \"text\"") as text|null
	cmd_mentor_say(msg)
