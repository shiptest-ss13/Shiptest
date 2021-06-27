/proc/priority_announce(text, title = "", sound = 'sound/ai/attention.ogg', type, sender_override, auth_id, zlevel)            //WS Edit - Make cap's announcement use logged-in name
	if(!text)
		return

	var/announcement

	if(type == "Priority")
		announcement += "<h1 class='alert'>Priority Announcement</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[html_encode(title)]</h2>"
	else if(type == "Captain")
		announcement += "<h1 class='alert'>Captain Announces</h1>"
		GLOB.news_network.SubmitArticle(html_encode(text), "Captain's Announcement", "Station Announcements", null)

	else
		if(!sender_override)
			announcement += "<h1 class='alert'>[command_name()] Update</h1>"
		else
			announcement += "<h1 class='alert'>[sender_override]</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[html_encode(title)]</h2>"

		if(!sender_override)
			if(title == "")
				GLOB.news_network.SubmitArticle(text, "Central Command Update", "Station Announcements", null)
			else
				GLOB.news_network.SubmitArticle(title + "<br><br>" + text, "Central Command", "Station Announcements", null)

	announcement += "<br><span class='alert'>[html_encode(text)]</span><br>"
	announcement += "<br>"
	if(auth_id)															//WS Edit - Make cap's announcement use logged-in name
		announcement += "<span class='alert'>-[auth_id]</span><br>"		//WS Edit - Make cap's announcement use logged-in name

	var/sound/S = sound(sound)
	S.environment = SOUND_ENVIRONMENT_CONCERT_HALL
	for(var/mob/M in GLOB.player_list)
		if(isnewplayer(M) || !M.can_hear())
			continue

		if(zlevel && (M.get_virtual_z_level() != zlevel)) // If a z-level is specified and the mob's z does not equal it
			continue

		to_chat(M, announcement)
		if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
			SEND_SOUND(M, S)

/proc/print_command_report(text = "", title = null, announce=TRUE)
	if(!title)
		title = "Classified [command_name()] Update"

	if(announce)
		priority_announce("A report has been downloaded and printed out at all communications consoles.", "Incoming Classified Message", 'sound/ai/commandreport.ogg')

	var/datum/comm_message/M  = new
	M.title = title
	M.content =  text

	SScommunications.send_message(M)

/proc/minor_announce(message, title = "Attention:", alert, mob/from, zlevel)
	if(!message)
		return

	var/sound/S = sound(alert ? 'sound/misc/notice1.ogg' : 'sound/misc/notice2.ogg')
	S.environment = SOUND_ENVIRONMENT_CONCERT_HALL
	for(var/mob/M in GLOB.player_list)
		if(isnewplayer(M) || !M.can_hear())
			continue

		if(zlevel && (M.get_virtual_z_level() != zlevel)) // If a z-level is specified and the mob's z does not equal it
			continue

		to_chat(M, "<span class='minorannounce'><font color = red>[title]</font color><BR>[message]</span><BR>[from ? "<span class='alert'>-[from.name] ([from.job])</span>" : null]")
		if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
			SEND_SOUND(M, S)
