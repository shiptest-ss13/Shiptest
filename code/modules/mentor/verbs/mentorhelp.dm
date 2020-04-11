/client/verb/mentorhelp(msg as text)
	set category = "Mentor"
	set name = "Mentorhelp"

	//clean the input msg
	if(!msg)
		return
	msg = sanitize(copytext(msg,1,MAX_MESSAGE_LEN))
	if(!msg || !mob)
		return
	if(prefs.muted & MUTE_MENTORHELP)
		to_chat(src, "<span class='warning'>You are unable to use mentorhelp (muted).</span>")
		return
	var/show_char = CONFIG_GET(flag/mentors_mobname_only)
	var/mentor_msg = "<span class='mentornotice'><b><span class='info'>MENTORHELP:</b> <b>[key_name_mentor(src, 1, 0, 1, show_char)]</b>:</span> [msg]</span>"
	SSredbot.send_discord_message("mentor","Mentorhelp: [key_name_mentor(src, 0, 0, 0, 0)]: [msg]","mentor")
	log_mentor("MENTORHELP: [key_name_mentor(src, 0, 0, 0, 0)]: [msg]")

	for(var/client/X in GLOB.mentors)
		X << 'sound/items/bikehorn.ogg'
		to_chat(X, mentor_msg)

	for(var/client/A in GLOB.admins)
		A << 'sound/items/bikehorn.ogg'
		to_chat(A, mentor_msg)

	to_chat(src, "<span class='mentornotice'>PM to-<b>Mentors</b>: [msg]</span>")

	//spam prevention, 60 second delay
	src.verbs -= /client/verb/mentorhelp
	addtimer(CALLBACK(src, .proc/return_mhelp, src), 600, TIMER_STOPPABLE) //1 minute cooldown of mentor helps
	return

/client/proc/return_mhelp(var/client/C)
	C.verbs += /client/verb/mentorhelp
	return

/proc/get_mentor_counts()
	. = list("total" = 0, "afk" = 0, "present" = 0)
	for(var/client/X in GLOB.mentors)
		.["total"]++
		if(X.is_afk())
			.["afk"]++
		else
			.["present"]++

/proc/key_name_mentor(var/whom, var/include_link = null, var/include_name = 0, var/include_follow = 0, var/char_name_only = 0)
	var/mob/M
	var/client/C
	var/key
	var/ckey

	if(!whom)	return "*null*"
	if(istype(whom, /client))
		C = whom
		M = C.mob
		key = C.key
		ckey = C.ckey
	else if(ismob(whom))
		M = whom
		C = M.client
		key = M.key
		ckey = M.ckey
	else if(istext(whom))
		key = whom
		ckey = ckey(whom)
		C = GLOB.directory[ckey]
		if(C)
			M = C.mob
	else
		return "*invalid*"

	. = ""

	if(!ckey)
		include_link = 0

	if(key)
		if(include_link)
			if(CONFIG_GET(flag/mentors_mobname_only))
				. += "<a href='?mentor_msg=[REF(M)]'>"
			else
				. += "<a href='?mentor_msg=[ckey]'>"

		if(C && C.holder && C.holder.fakekey)
			. += "Administrator"
		else if (char_name_only && CONFIG_GET(flag/mentors_mobname_only))
			if(istype(C.mob,/mob/dead/new_player) || istype(C.mob, /mob/dead/observer)) //If they're in the lobby or observing, display their ckey
				. += key
			else if(C && C.mob) //If they're playing/in the round, only show the mob name
				. += C.mob.name
			else //If for some reason neither of those are applicable and they're mentorhelping, show ckey
				. += key
		else
			. += key
		if(!C)
			. += "\[DC\]"

		if(include_link)
			. += "</a>"
	else
		. += "*no key*"

	if(include_follow)
		. += " (<a href='?mentor_follow=[REF(M)]'>F</a>)"

	return .
