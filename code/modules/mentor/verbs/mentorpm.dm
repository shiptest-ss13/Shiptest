//shows a list of clients we could send PMs to, then forwards our choice to cmd_Mentor_pm
/client/proc/cmd_mentor_pm_panel()
	set category = "Mentor"
	set name = "Mentor PM"
	if(!holder)
		to_chat(src, "<span class='warning'>Error: Mentor-PM-Panel: Only Mentors may use this command.</span>")
		return
	var/list/client/targets[0]
	for(var/client/T)
		if(T.mob)
			if(isnewplayer(T.mob))
				targets["(New Player) - [T]"] = T
			else if(isobserver(T.mob))
				targets["[T.mob.name](Ghost) - [T]"] = T
			else
				targets["[T.mob.real_name](as [T.mob.name]) - [T]"] = T
		else
			targets["(No Mob) - [T]"] = T
	var/target = input(src,"To whom shall we send a message?","Mentor PM",null) as null|anything in sortList(targets)
	cmd_mentor_pm(targets[target],null)
	SSblackbox.record_feedback("tally", "mentor_verb", 1, "Mentor PM") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


//takes input from cmd_mentor_pm_context, cmd_Mentor_pm_panel or /client/Topic and sends them a PM.
//Fetching a message if needed. src is the sender and C is the target client
/client/proc/cmd_mentor_pm(whom, msg)
	var/client/C
	if(ismob(whom))
		var/mob/M = whom
		C = M.client
	else if(istext(whom))
		C = GLOB.directory[whom]
	else if(istype(whom,/client))
		C = whom
	if(!C)
		if(holder)
			to_chat(src, "<span class='warning'>Error: Mentor-PM: Client not found.</span>")
		else
			mentorhelp(msg)	//Mentor we are replying to left. Mentorhelp instead
		return

	to_chat(GLOB.admins | GLOB.mentors, "<font color='notice'>[src] has started replying to [whom]'s mhelp.</font>")

	//get message text, limit its length.and clean/escape html
	if(!msg)
		msg = input(src,"Message:", "Private message") as text|null

		if(!msg)
			to_chat(GLOB.admins | GLOB.mentors, "<span class='notice'>[src] has stopped their reply to [whom]'s mhelp.</span>")
			return

		if(!C)
			if(holder)
				to_chat(src, "<span class='warning'>Error: Mentor-PM: Client not found.</span>")
			else
				mentorhelp(msg)	//Mentor we are replying to has vanished, Mentorhelp instead
			return

	msg = sanitize(copytext(msg,1,MAX_MESSAGE_LEN))
	if(!msg)
		return

	log_mentor("Mentor PM: [key_name(src)]->[key_name(C)]: [msg]")

	msg = emoji_parse(msg)
	C << 'sound/items/bikehorn.ogg'
	var/show_char = CONFIG_GET(flag/mentors_mobname_only)
	if(check_mentor_other(C))
		if(check_mentor())	//both are mentors
			to_chat(C, "<span class='notice'>Mentor PM from-<b>[key_name_mentor(src, C, 1, 0, 0)]</b>: [msg]</span>")
			to_chat(src, "<span class='green'>Mentor PM to-<b>[key_name_mentor(C, C, 1, 0, 0)]</b>: [msg]</span>")

		else		//recipient is an mentor but sender is not
			to_chat(C, "<span class='notice'>Reply PM from-<b>[key_name_mentor(src, C, 1, 0, show_char)]</b>: [msg]</span>")
			to_chat(src, "<span class='green'>Mentor PM to-<b>[key_name_mentor(C, C, 1, 0, 0)]</b>: [msg]</span>")

	else
		if(check_mentor())	//sender is an mentor but recipient is not.
			to_chat(C, "<span class='notice'>Mentor PM from-<b>[key_name_mentor(src, C, 1, 0, 0)]</b>: [msg]</span>")
			to_chat(src, "<span class='green'>Mentor PM to-<b>[key_name_mentor(C, C, 1, 0, show_char)]</b>: [msg]</span>")

	//we don't use message_Mentors here because the sender/receiver might get it too
	for(var/client/X in GLOB.mentors)
		if(X.key!=key && X.key!=C.key)	//check client/X is an Mentor and isn't the sender or recipient
			to_chat(X, "<span class='mentornotice'><B>Mentor PM: [key_name(src, X, 0)]-&gt;[key_name(C, X, 0)]:</B> [msg]</span>") //inform X
