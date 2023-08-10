GLOBAL_VAR_INIT(LOOC_COLOR, null)//If this is null, use the CSS for OOC. Otherwise, use a custom colour.
GLOBAL_VAR_INIT(normal_looc_colour, "#6699CC")

/client/verb/looc(msg as text)
	set name = "LOOC"
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled"))
		return

	if(!mob)
		return

	if(!holder)
		if(!GLOB.looc_allowed)
			to_chat(src, span_danger("LOOC is globally muted."))
			return
		if(prefs.muted & MUTE_OOC)
			to_chat(src, span_danger("You cannot use LOOC (muted)."))
			return
	if(is_banned_from(ckey, "OOC"))
		to_chat(src, span_danger("You have been banned from OOC."))
		return
	if(QDELETED(src))
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	var/raw_msg = msg

	if(!msg)
		return

	msg = emoji_parse(msg)

	if((msg[1] in list(".",";",":","#")) || findtext_char(msg, "say", 1, 5))
		if(alert("Your message \"[raw_msg]\" looks like it was meant for in game communication, say it in LOOC?", "Meant for LOOC?", "Yes", "No") != "Yes")
			return

	if(!holder)
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		if(findtext(msg, "byond://"))
			to_chat(src, span_bold("Advertising other servers is not allowed."))
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			message_admins("[key_name_admin(src)] has attempted to advertise in LOOC: [msg]")
			return
		if(mob.stat)
			to_chat(src, span_danger("You cannot use LOOC while unconscious or dead."))
			return
		if(istype(mob, /mob/dead))
			to_chat(src, span_danger("You cannot use LOOC while ghosting."))
			return

	if(!(prefs.chat_toggles & CHAT_LOOC))
		to_chat(src, span_danger("You have OOC muted."))
		return

	mob.log_talk(raw_msg, LOG_LOOC, tag = "(LOOC)")

	var/list/heard = get_hearers_in_view(7, get_top_level_mob(src.mob))
	for(var/mob/M in heard)
		if(!M.client)
			continue
		var/client/C = M.client

		if(key in C.prefs.ignoring)
			continue

		if(holder?.fakekey in C.prefs.ignoring)
			continue

		if(!(C.prefs.chat_toggles & CHAT_LOOC))
			continue

		//Handled before admins so that they see this if they're in range anyways
		if(C.prefs.chat_on_map && mob.invisibility <= M.see_invisible)
			M.create_chat_message(mob, null, "\[LOOC: [raw_msg]\]", null, LOOC_MESSAGE)

		if(C in GLOB.admins)
			continue //handled in the next loop

		if(GLOB.LOOC_COLOR)
			to_chat(C, "<span class='loocplain'><font color='[GLOB.LOOC_COLOR]'><b><span class='prefix'>LOOC:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg]</span></b></font></span>", MESSAGE_TYPE_LOOC)
		else
			to_chat(C, "<span class='looc'><span class='prefix'>LOOC:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg]</span></span>", MESSAGE_TYPE_LOOC)

	for(var/client/C in GLOB.admins)
		if(key in C.prefs.ignoring)
			continue

		if(holder?.fakekey in C.prefs.ignoring)
			continue

		if(!(C.prefs.chat_toggles & CHAT_LOOC))
			continue

		var/prefix = "(R)LOOC"
		if (C.mob in heard)
			prefix = "LOOC"
		if(GLOB.LOOC_COLOR)
			to_chat(C, "<span class='loocplain'><font color='[GLOB.LOOC_COLOR]'><b>[ADMIN_FLW(usr)] <span class='prefix'>[prefix]:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span></b></font></span>", MESSAGE_TYPE_LOOC)
		else
			to_chat(C, "<span class='looc'>[ADMIN_FLW(usr)] <span class='prefix'>[prefix]:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span></span>", MESSAGE_TYPE_LOOC)

/proc/toggle_looc(toggle = null)
	if(toggle == null)
		GLOB.looc_allowed = !GLOB.looc_allowed
		return
	if(toggle != GLOB.looc_allowed)
		GLOB.looc_allowed = toggle

/client/proc/set_looc(newColor as color)
	set name = "Set Player LOOC Color"
	set desc = "Modifies player LOOC Color"
	set category = "Server"
	GLOB.LOOC_COLOR = sanitize_ooccolor(newColor)
