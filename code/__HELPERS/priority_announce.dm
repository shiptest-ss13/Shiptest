/proc/priority_announce(text, title = "", sound = 'sound/ai/attention.ogg', type, sender_override, auth_id, zlevel)
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

	announcement += "<br>[span_alert("[html_encode(text)]")]<br>"
	announcement += "<br>"
	if(auth_id)															//WS Edit - Make cap's announcement use logged-in name
		announcement += "[span_alert("-[auth_id]")]<br>"		//WS Edit - Make cap's announcement use logged-in name

	var/sound/S = sound(sound)
	S.environment = SOUND_ENVIRONMENT_CONCERT_HALL
	for(var/mob/M in GLOB.player_list)
		if(isnewplayer(M) || !M.can_hear())
			continue

		if(zlevel && (M.virtual_z() != zlevel)) // If a z-level is specified and the mob's z does not equal it
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

		if(zlevel && (M.virtual_z() != zlevel)) // If a z-level is specified and the mob's z does not equal it
			continue

		to_chat(M, "[span_minorannounce("<font color = red>[title]</font color><BR>[message]")]<BR>[from ? "[span_alert("-[from.name] ([from.job])")]" : null]")
		if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
			SEND_SOUND(M, S)

/proc/create_distress_beacon(datum/overmap/location)
	var/message
	var/datum/overmap/ship/ship = location
	if(istype(ship))
		message = "A distress beacon has been launched by [ship.name], at local sector co-ordinates [ship.x || ship.docked_to.x]/[ship.y || ship.docked_to.y]. No further information available."
	else
		message = "A distress beacon has been activated from [location.name] at local sector co-ordinates [location.x]/[location.y]. No further information available."
	priority_announce(message, null, 'sound/effects/alert.ogg', sender_override = "Outpost Distress Beacon System", zlevel = 0)
