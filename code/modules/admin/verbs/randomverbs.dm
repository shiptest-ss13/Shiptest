/client/proc/cmd_admin_drop_everything(mob/M in GLOB.mob_list)
	set category = null
	set name = "Drop Everything"
	if(!check_rights(R_ADMIN))
		return

	var/confirm = alert(src, "Make [M] drop everything?", "Message", "Yes", "No")
	if(confirm != "Yes")
		return

	for(var/obj/item/W in M)
		if(!M.dropItemToGround(W))
			qdel(W)
			M.regenerate_icons()

	log_admin("[key_name(usr)] made [key_name(M)] drop everything!")
	var/msg = "[key_name_admin(usr)] made [ADMIN_LOOKUPFLW(M)] drop everything!"
	message_admins(msg)
	admin_ticket_log(M, msg)
	BLACKBOX_LOG_ADMIN_VERB("Drop Everything")

/client/proc/cmd_admin_subtle_message(mob/M in GLOB.mob_list)
	set category = "Event"
	set name = "Subtle Message"

	if(!ismob(M))
		return
	if(!check_rights(R_ADMIN))
		return

	message_admins("[key_name_admin(src)] has started answering [ADMIN_LOOKUPFLW(M)]'s prayer.")
	var/msg = input("Message:", text("Subtle PM to [M.key]")) as text|null

	if(!msg)
		message_admins("[key_name_admin(src)] decided not to answer [ADMIN_LOOKUPFLW(M)]'s prayer")
		return
	if(usr)
		if (usr.client)
			if(usr.client.holder)
				to_chat(M, "<i>You hear a voice in your head... <b>[msg]</i></b>", confidential = TRUE)

	log_admin("SubtlePM: [key_name(usr)] -> [key_name(M)] : [msg]")
	msg = span_adminnotice("<b> SubtleMessage: [key_name_admin(usr)] -> [key_name_admin(M)] :</b> [msg]")
	message_admins(msg)
	admin_ticket_log(M, msg)
	BLACKBOX_LOG_ADMIN_VERB("Subtle Message")

/client/proc/cmd_admin_headset_message(mob/M in GLOB.mob_list)
	set category = "Event"
	set name = "Headset Message"

	admin_headset_message(M)

/client/proc/admin_headset_message(mob/M in GLOB.mob_list, sender = null)
	var/mob/living/carbon/human/H = M

	if(!check_rights(R_ADMIN))
		return

	if(!istype(H))
		to_chat(usr, "This can only be used on instances of type /mob/living/carbon/human", confidential = TRUE)
		return
	if(!istype(H.ears, /obj/item/radio/headset))
		to_chat(usr, "The person you are trying to contact is not wearing a headset.", confidential = TRUE)
		return

	if (!sender)
		sender = input("Who is the message from?", "Sender") as null|anything in list(RADIO_CHANNEL_CENTCOM, RADIO_CHANNEL_SYNDICATE, RADIO_CHANNEL_SOLGOV, RADIO_CHANNEL_INTEQ, RADIO_CHANNEL_MINUTEMEN, "Outpost")		//WS Edit - SolGov Rep
		if(!sender)
			return
		switch(sender)
			if (RADIO_CHANNEL_SYNDICATE)
				sender = input("From what faction?", "Syndicate") as null|anything in list("Liberation Front Leadership", "Gorlex Republic Military Command", "Cybersun Industries", "the Student-Union of Naturalistic Sciences")
			if (RADIO_CHANNEL_MINUTEMEN)
				sender = input("From what division?", "Minutemen") as null|anything in list("the Confederated League", "the Galactic Optium Labor Divison", "the Biohazard Assesment and Removal Division")
			if (RADIO_CHANNEL_INTEQ)
				sender = "Inteq Risk Management"
			if ("Outpost")
				sender = "Outpost Authority"
		if(!sender)
			return
	message_admins("[key_name_admin(src)] has started answering [key_name_admin(H)]'s [sender] request.")
	var/input = input("Please enter a message to reply to [key_name(H)] via their headset.","Outgoing message from [sender]", "") as text|null
	if(!input)
		message_admins("[key_name_admin(src)] decided not to answer [key_name_admin(H)]'s [sender] request.")
		return

	log_directed_talk(mob, H, input, LOG_ADMIN, "reply")
	message_admins("[key_name_admin(src)] replied to [key_name_admin(H)]'s [sender] message with: \"[input]\"")
	to_chat(H, span_hear("You hear something crackle in your ears for a moment before a voice speaks. \"Please stand by for a message from [sender]. Message as follows: <b>[input].</b> Message ends.\""), confidential = TRUE)		//WS Edit - SolGov Rep

	BLACKBOX_LOG_ADMIN_VERB("Headset Message")

/client/proc/cmd_admin_world_narrate()
	set category = "Event"
	set name = "Global Narrate"

	if(!check_rights(R_ADMIN))
		return

	var/msg = input("Message:", text("Enter the text you wish to appear to everyone:")) as text|null

	if (!msg)
		return
	to_chat(world, "[msg]", confidential = TRUE)
	log_admin("GlobalNarrate: [key_name(usr)] : [msg]")
	message_admins(span_adminnotice("[key_name_admin(usr)] Sent a global narrate"))
	BLACKBOX_LOG_ADMIN_VERB("Global Narrate")

/client/proc/cmd_admin_direct_narrate(mob/M)
	set category = "Event"
	set name = "Direct Narrate"

	if(!check_rights(R_ADMIN))
		return

	if(!M)
		M = input("Direct narrate to whom?", "Active Players") as null|anything in GLOB.player_list

	if(!M)
		return

	var/msg = input("Message:", text("Enter the text you wish to appear to your target:")) as text|null

	if(!msg)
		return

	to_chat(M, msg, confidential = TRUE)
	log_admin("DirectNarrate: [key_name(usr)] to ([M.name]/[M.key]): [msg]")
	msg = span_adminnotice("<b> DirectNarrate: [key_name(usr)] to ([M.name]/[M.key]):</b> [msg]<BR>")
	message_admins(msg)
	admin_ticket_log(M, msg)
	BLACKBOX_LOG_ADMIN_VERB("Direct Narrate")

/client/proc/cmd_admin_local_narrate(atom/A)
	set category = "Event"
	set name = "Local Narrate"

	if(!check_rights(R_ADMIN))
		return
	if(!A)
		return
	var/range = input("Range:", "Narrate to mobs within how many tiles:", 7) as num|null
	if(!range)
		return
	var/msg = input("Message:", text("Enter the text you wish to appear to everyone within view:")) as text|null
	if (!msg)
		return
	for(var/mob/M in view(range,A))
		to_chat(M, msg, confidential = TRUE)

	log_admin("LocalNarrate: [key_name(usr)] at [AREACOORD(A)]: [msg]")
	message_admins(span_adminnotice("<b> LocalNarrate: [key_name_admin(usr)] at [ADMIN_VERBOSEJMP(A)]:</b> [msg]<BR>"))
	BLACKBOX_LOG_ADMIN_VERB("Local Narrate")

/client/proc/cmd_admin_godmode(mob/M in GLOB.mob_list)
	set category = "Admin.Game"
	set name = "Godmode"
	if(!check_rights(R_ADMIN))
		return

	M.status_flags ^= GODMODE
	to_chat(usr, span_adminnotice("Toggled [(M.status_flags & GODMODE) ? "ON" : "OFF"]"), confidential = TRUE)

	log_admin("[key_name(usr)] has toggled [key_name(M)]'s nodamage to [(M.status_flags & GODMODE) ? "On" : "Off"]")
	var/msg = "[key_name_admin(usr)] has toggled [ADMIN_LOOKUPFLW(M)]'s nodamage to [(M.status_flags & GODMODE) ? "On" : "Off"]"
	message_admins(msg)
	admin_ticket_log(M, msg)
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Godmode", "[M.status_flags & GODMODE ? "Enabled" : "Disabled"]"))


/proc/cmd_admin_mute(whom, mute_type, automute = 0)
	if(!whom)
		return

	var/muteunmute
	var/mute_string
	var/feedback_string
	switch(mute_type)
		if(MUTE_IC)
			mute_string = "IC (say and emote)"
			feedback_string = "IC"
		if(MUTE_OOC)
			mute_string = "OOC"
			feedback_string = "OOC"
		if(MUTE_PRAY)
			mute_string = "pray"
			feedback_string = "Pray"
		if(MUTE_ADMINHELP)
			mute_string = "adminhelp, admin PM and ASAY"
			feedback_string = "Adminhelp"
		if(MUTE_MENTORHELP)
			mute_string = "mentorhelp"
			feedback_string = "Mentorhelp"
		if(MUTE_DEADCHAT)
			mute_string = "deadchat and DSAY"
			feedback_string = "Deadchat"
		if(MUTE_ALL)
			mute_string = "everything"
			feedback_string = "Everything"
		else
			return

	var/client/C
	if(istype(whom, /client))
		C = whom
	else if(istext(whom))
		C = GLOB.directory[whom]
	else
		return

	var/datum/preferences/P
	if(C)
		P = C.prefs
	else
		P = GLOB.preferences_datums[whom]
	if(!P)
		return

	if(automute)
		if(!CONFIG_GET(flag/automute_on))
			return
	else
		if(!check_rights())
			return

	if(automute)
		muteunmute = "auto-muted"
		P.muted |= mute_type
		log_admin("SPAM AUTOMUTE: [muteunmute] [key_name(whom)] from [mute_string]")
		message_admins("SPAM AUTOMUTE: [muteunmute] [key_name_admin(whom)] from [mute_string].")
		if(C)
			to_chat(C, "You have been [muteunmute] from [mute_string] by the SPAM AUTOMUTE system. Contact an admin.", confidential = TRUE)
		SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Auto Mute [feedback_string]", "1"))
		return

	if(P.muted & mute_type)
		muteunmute = "unmuted"
		P.muted &= ~mute_type
	else
		muteunmute = "muted"
		P.muted |= mute_type

	log_admin("[key_name(usr)] has [muteunmute] [key_name(whom)] from [mute_string]")
	message_admins("[key_name_admin(usr)] has [muteunmute] [key_name_admin(whom)] from [mute_string].")
	if(C)
		to_chat(C, "You have been [muteunmute] from [mute_string] by [key_name(usr, include_name = FALSE)].", confidential = TRUE)
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Mute [feedback_string]", "[P.muted & mute_type]"))


//I use this proc for respawn character too. /N
/proc/create_xeno(ckey)
	if(!ckey)
		var/list/candidates = list()
		for(var/mob/M in GLOB.player_list)
			if(M.stat != DEAD)
				continue	//we are not dead!
			if(!(ROLE_ALIEN in M.client.prefs.be_special))
				continue	//we don't want to be an alium
			if(M.client.is_afk())
				continue	//we are afk
			if(M.mind && M.mind.current && M.mind.current.stat != DEAD)
				continue	//we have a live body we are tied to
			candidates += M.ckey
		if(candidates.len)
			ckey = input("Pick the player you want to respawn as a xeno.", "Suitable Candidates") as null|anything in sortKey(candidates)
		else
			to_chat(usr, span_danger("Error: create_xeno(): no suitable candidates."), confidential = TRUE)
	if(!istext(ckey))
		return 0

	var/alien_caste = input(usr, "Please choose which caste to spawn.","Pick a caste",null) as null|anything in list("Queen","Praetorian","Hunter","Sentinel","Drone","Larva")
	var/obj/effect/landmark/spawn_here = pick(GLOB.xeno_spawn)
	var/mob/living/carbon/alien/new_xeno
	switch(alien_caste)
		if("Queen")
			new_xeno = new /mob/living/carbon/alien/humanoid/royal/queen(spawn_here)
		if("Praetorian")
			new_xeno = new /mob/living/carbon/alien/humanoid/royal/praetorian(spawn_here)
		if("Hunter")
			new_xeno = new /mob/living/carbon/alien/humanoid/hunter(spawn_here)
		if("Sentinel")
			new_xeno = new /mob/living/carbon/alien/humanoid/sentinel(spawn_here)
		if("Drone")
			new_xeno = new /mob/living/carbon/alien/humanoid/drone(spawn_here)
		if("Larva")
			new_xeno = new /mob/living/carbon/alien/larva(spawn_here)
		else
			return 0

	new_xeno.ckey = ckey
	var/msg = span_notice("[key_name_admin(usr)] has spawned [ckey] as a filthy xeno [alien_caste].")
	message_admins(msg)
	admin_ticket_log(new_xeno, msg)
	return 1

/client/proc/cmd_admin_add_freeform_ai_law()
	set category = "Event"
	set name = "Add Custom AI law"

	if(!check_rights(R_ADMIN))
		return

	var/input = input(usr, "Please enter anything you want the AI to do. Anything. Serious.", "What?", "") as text|null
	if(!input)
		return

	log_admin("Admin [key_name(usr)] has added a new AI law - [input]")
	message_admins("Admin [key_name_admin(usr)] has added a new AI law - [input]")

	var/show_log = alert(src, "Show ion message?", "Message", "Yes", "No")
	var/announce_ion_laws = (show_log == "Yes" ? 100 : 0)

	var/datum/round_event/ion_storm/add_law_only/ion = new()
	ion.announce_chance = announce_ion_laws
	ion.ionMessage = input

	BLACKBOX_LOG_ADMIN_VERB("Add Custom AI Law")

/client/proc/cmd_admin_create_centcom_report()
	set category = "Event"
	set name = "Create Command Report"

	if(!check_rights(R_FUN))
		return

	var/input = input(usr, "Enter a Command Report. Ensure it makes sense IC. Command's name is currently set to [command_name()].", "What?", "") as message|null
	if(!input)
		return

	var/confirm = alert(src, "Do you want to announce the contents of the report to the crew?", "Announce", "Yes", "No", "Cancel")

	var/level = input(usr, "Enter the (virtual) z-level you want to announce to. Specifying zero sends to all levels.", "Announce", 0) as num

	var/announce_command_report = TRUE
	switch(confirm)
		if("Yes")
			priority_announce(input, null, 'sound/ai/commandreport.ogg', zlevel = level)
			announce_command_report = FALSE
		if("Cancel")
			return

	print_command_report(input, "[announce_command_report ? "Classified " : ""][command_name()] Update", announce_command_report)

	log_admin("[key_name(src)] has created a command report: [input]")
	message_admins("[key_name_admin(src)] has created a command report")
	BLACKBOX_LOG_ADMIN_VERB("Create Command Report")

/client/proc/cmd_change_command_name()
	set category = "Event"
	set name = "Change Command Name"

	if(!check_rights(R_FUN))
		return

	var/input = input(usr, "Please input a new name for Central Command.", "What?", "") as text|null
	if(!input)
		return
	change_command_name(input)
	message_admins("[key_name_admin(src)] has changed Central Command's name to [input]")
	log_admin("[key_name(src)] has changed the Central Command name to: [input]")

/client/proc/cmd_admin_distress_signal()
	set category = "Event.Overmap"
	set name = "Create Distress Signal"

	var/datum/overmap/overmap_location = tgui_input_list(
		src,
		"Select a location to launch a distress signal from.",
		"Signal Location",
		SSovermap.overmap_objects
	)

	if(!istype(overmap_location)) // Sanity check
		return
	var/confirm = alert(src, "Do you want to create a distress signal for [overmap_location.name] [overmap_location.docked_to ? "docked to [overmap_location.docked_to]" : "at ([overmap_location.x], [overmap_location.y])"]?", "Distress Signal", "Yes", "No")

	switch(confirm)
		if("Yes")
			var/distress_message = input(src, "Input any information you'd like attached with the distress signal.", "Distress Signal Message")
			if(distress_message)
				create_distress_beacon(overmap_location, distress_message)
			else
				create_distress_beacon(overmap_location)
		if("No")
			return

/client/proc/cmd_admin_distress_signal_here()
	set category = "Event.Overmap"
	set name = "Create Distress Signal Here"

	var/mob/self_mob = src.mob
	var/datum/overmap/overmap_location
	if(!istype(self_mob))
		return

	var/datum/overmap/ship/controlled/ship = SSshuttle.get_ship(self_mob)
	if(istype(ship))
		overmap_location = ship

	if(!overmap_location)
		overmap_location = self_mob.get_overmap_location()

	if(!overmap_location && !istype(overmap_location))
		return

	var/confirm = alert(src, "Do you want to create a distress signal for [overmap_location.name] [overmap_location.docked_to ? "docked to [overmap_location.docked_to]" : "at ([overmap_location.x], [overmap_location.y])"]?", "Distress Signal", "Yes", "No")

	switch(confirm)
		if("Yes")
			var/distress_message = input(src, "Input any information you'd like attached with the distress signal.", "Distress Signal Message")
			if(distress_message)
				create_distress_beacon(overmap_location, distress_message)
			else
				create_distress_beacon(overmap_location)
		if("No")
			return

/client/proc/cmd_admin_delete(atom/A as obj|mob|turf in world)
	set category = "Debug"
	set name = "Delete"

	if(!check_rights(R_SPAWN|R_DEBUG))
		return

	admin_delete(A)

/client/proc/cmd_admin_explosion(atom/O as obj|mob|turf in world)
	set category = "Event.Fun"
	set name = "Explosion"

	if(!check_rights(R_ADMIN))
		return

	var/devastation = input("Range of total devastation. -1 to none", text("Input"))  as num|null
	if(devastation == null)
		return
	var/heavy = input("Range of heavy impact. -1 to none", text("Input"))  as num|null
	if(heavy == null)
		return
	var/light = input("Range of light impact. -1 to none", text("Input"))  as num|null
	if(light == null)
		return
	var/flash = input("Range of flash. -1 to none", text("Input"))  as num|null
	if(flash == null)
		return
	var/flames = input("Range of flames. -1 to none", text("Input"))  as num|null
	if(flames == null)
		return

	if ((devastation != -1) || (heavy != -1) || (light != -1) || (flash != -1) || (flames != -1))
		if ((devastation > 20) || (heavy > 20) || (light > 20) || (flames > 20))
			if (alert(src, "Are you sure you want to do this? It will laaag.", "Confirmation", "Yes", "No") == "No")
				return

		explosion(O, devastation, heavy, light, flash, null, null,flames)
		log_admin("[key_name(usr)] created an explosion ([devastation],[heavy],[light],[flames]) at [AREACOORD(O)]")
		message_admins("[key_name_admin(usr)] created an explosion ([devastation],[heavy],[light],[flames]) at [AREACOORD(O)]")
		BLACKBOX_LOG_ADMIN_VERB("Explosion")
		return
	else
		return

/client/proc/cmd_admin_emp(atom/O as obj|mob|turf in world)
	set category = "Event.Fun"
	set name = "EM Pulse"

	if(!check_rights(R_ADMIN))
		return

	var/heavy = input("Range of heavy pulse.", text("Input"))  as num|null
	if(heavy == null)
		return
	var/light = input("Range of light pulse.", text("Input"))  as num|null
	if(light == null)
		return

	if (heavy || light)

		empulse(O, heavy, light)
		log_admin("[key_name(usr)] created an EM Pulse ([heavy],[light]) at [AREACOORD(O)]")
		message_admins("[key_name_admin(usr)] created an EM Pulse ([heavy],[light]) at [AREACOORD(O)]")
		BLACKBOX_LOG_ADMIN_VERB("EM Pulse")

		return
	else
		return

/client/proc/cmd_admin_gib(mob/M in GLOB.mob_list)
	set category = "Event.Fun"
	set name = "Gib"

	if(!check_rights(R_ADMIN))
		return

	var/confirm = alert(src, "Drop a brain?", "Confirm", "Yes", "No","Cancel")
	if(confirm == "Cancel")
		return
	//Due to the delay here its easy for something to have happened to the mob
	if(!M)
		return

	log_admin("[key_name(usr)] has gibbed [key_name(M)]")
	message_admins("[key_name_admin(usr)] has gibbed [key_name_admin(M)]")

	if(isobserver(M))
		new /obj/effect/gibspawner/generic(get_turf(M))
		return
	if(confirm == "Yes")
		M.gib()
	else
		M.gib(1)
	BLACKBOX_LOG_ADMIN_VERB("Gib")

/client/proc/cmd_admin_gib_self()
	set name = "Gibself"
	set category = "Event.Fun"

	var/confirm = alert(src, "You sure?", "Confirm", "Yes", "No")
	if(confirm == "Yes")
		log_admin("[key_name(usr)] used gibself.")
		message_admins(span_adminnotice("[key_name_admin(usr)] used gibself."))
		BLACKBOX_LOG_ADMIN_VERB("Gib Self")
		mob.gib(1, 1, 1)

/client/proc/cmd_admin_check_contents(mob/living/M in GLOB.mob_list)
	set category = "Debug"
	set name = "Check Contents"

	var/list/L = M.get_contents()
	for(var/atom/t in L)
		to_chat(usr, "[t]", confidential = TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Check Contents")

/client/proc/toggle_view_range()
	set category = "Admin.Game"
	set name = "Change View Range"
	set desc = "switches between 1x and custom views"

	if(view_size.getView() == view_size.default)
		view_size.setTo(input("Select view range:", "FUCK YE", 7) in list(1,2,3,4,5,6,7,8,9,10,11,12,13,14,128) - 7)
	else
		view_size.resetToDefault(getScreenSize(prefs.widescreenpref))

	log_admin("[key_name(usr)] changed their view range to [view].")
	//message_admins("\blue [key_name_admin(usr)] changed their view range to [view].")	//why? removed by order of XSI

	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Change View Range", "[view]"))

/client/proc/admin_initiate_jump()
	set category = "Event"
	set name = "Initiate Jump"
	if(!check_rights(R_ADMIN))
		return

	var/confirm = tgui_alert(src, "Are you sure you want to initiate a bluespace jump?", "Bluespace Jump", list("Yes", "No"))
	if(confirm != "Yes")
		return

	if(SSshuttle.jump_mode > BS_JUMP_IDLE)
		return

	SSshuttle.request_jump()
	BLACKBOX_LOG_ADMIN_VERB("Call Shuttle")
	log_admin("[key_name(usr)] admin-initiated a bluespace jump.")
	message_admins(span_adminnotice("[key_name_admin(usr)] admin-initiated a bluespace jump."))

/client/proc/admin_cancel_jump()
	set category = "Event"
	set name = "Cancel Jump"
	if(!check_rights(0))
		return

	var/confirm = tgui_alert(src, "Are you sure you want to cancel the bluespace jump?", "Bluespace Jump", list("Yes", "No"))
	if(confirm != "Yes")
		return

	if(SSshuttle.jump_mode != BS_JUMP_CALLED)
		return

	SSshuttle.cancel_jump()
	BLACKBOX_LOG_ADMIN_VERB("Cancel Shuttle")
	log_admin("[key_name(usr)] admin-cancelled a bluespace jump.")
	message_admins(span_adminnotice("[key_name_admin(usr)] admin-cancelled a bluespace jump."))

/client/proc/everyone_random()
	set category = "Event.Fun"
	set name = "Make Everyone Random"
	set desc = "Make everyone have a random appearance. You can only use this before rounds!"

	if(SSticker.HasRoundStarted())
		to_chat(usr, "Nope you can't do this, the game's already started. This only works before rounds!", confidential = TRUE)
		return

	var/frn = CONFIG_GET(flag/force_random_names)
	if(frn)
		CONFIG_SET(flag/force_random_names, FALSE)
		message_admins("Admin [key_name_admin(usr)] has disabled \"Everyone is Special\" mode.")
		to_chat(usr, "Disabled.", confidential = TRUE)
		return


	var/notifyplayers = alert(src, "Do you want to notify the players?", "Options", "Yes", "No", "Cancel")
	if(notifyplayers == "Cancel")
		return

	log_admin("Admin [key_name(src)] has forced the players to have random appearances.")
	message_admins("Admin [key_name_admin(usr)] has forced the players to have random appearances.")

	if(notifyplayers == "Yes")
		to_chat(world, span_adminnotice("Admin [usr.key] has forced the players to have completely random identities!"), confidential = TRUE)

	to_chat(usr, "<i>Remember: you can always disable the randomness by using the verb again, assuming the round hasn't started yet</i>.", confidential = TRUE)

	CONFIG_SET(flag/force_random_names, TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Make Everyone Random")


/client/proc/toggle_random_events()
	set category = "Server"
	set name = "Toggle random events on/off"
	set desc = "Toggles random events such as meteors, black holes, blob (but not space dust) on/off"
	var/new_are = !CONFIG_GET(flag/allow_random_events)
	CONFIG_SET(flag/allow_random_events, new_are)
	if(new_are)
		to_chat(usr, "Random events enabled", confidential = TRUE)
		message_admins("Admin [key_name_admin(usr)] has enabled random events.")
	else
		to_chat(usr, "Random events disabled", confidential = TRUE)
		message_admins("Admin [key_name_admin(usr)] has disabled random events.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Random Events", "[new_are ? "Enabled" : "Disabled"]"))


/client/proc/admin_change_sec_level()
	set category = "Event"
	set name = "Set Security Level"
	set desc = "Changes the security level. Announcement only, i.e. setting to Delta won't activate nuke"

	if(!check_rights(R_ADMIN))
		return

	var/level = input("Select security level to change to","Set Security Level") as null|anything in list("green","blue","red","delta")
	if(level)
		set_security_level(level)

		log_admin("[key_name(usr)] changed the security level to [level]")
		message_admins("[key_name_admin(usr)] changed the security level to [level]")
		BLACKBOX_LOG_ADMIN_VERB("Set Security Level [capitalize(level)]")

/client/proc/toggle_nuke(obj/machinery/nuclearbomb/N in GLOB.nuke_list)
	set name = "Toggle Nuke"
	set category = "Event"
	set popup_menu = 0
	if(!check_rights(R_DEBUG))
		return

	if(!N.timing)
		var/newtime = input(usr, "Set activation timer.", "Activate Nuke", "[N.timer_set]") as num|null
		if(!newtime)
			return
		N.timer_set = newtime
	N.set_safety()
	N.set_active()

	log_admin("[key_name(usr)] [N.timing ? "activated" : "deactivated"] a nuke at [AREACOORD(N)].")
	message_admins("[ADMIN_LOOKUPFLW(usr)] [N.timing ? "activated" : "deactivated"] a nuke at [ADMIN_VERBOSEJMP(N)].")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Nuke", "[N.timing]"))

/client/proc/toggle_combo_hud()
	set category = "Admin.Game"
	set name = "Toggle Combo HUD"
	set desc = "Toggles the Admin Combo HUD (antag, sci, med, eng)"

	if(!check_rights(R_ADMIN))
		return

	var/adding_hud = !has_antag_hud()

	for(var/hudtype in list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC_ADVANCED)) // add data huds
		var/datum/atom_hud/H = GLOB.huds[hudtype]
		(adding_hud) ? H.add_hud_to(usr) : H.remove_hud_from(usr)
	for(var/datum/atom_hud/antag/H in GLOB.huds) // add antag huds
		(adding_hud) ? H.add_hud_to(usr) : H.remove_hud_from(usr)

	if(prefs.toggles & COMBOHUD_LIGHTING)
		if(adding_hud)
			mob.lighting_alpha = LIGHTING_PLANE_ALPHA_INVISIBLE
		else
			mob.lighting_alpha = initial(mob.lighting_alpha)

	mob.update_sight()

	to_chat(usr, "You toggled your admin combo HUD [adding_hud ? "ON" : "OFF"].", confidential = TRUE)
	message_admins("[key_name_admin(usr)] toggled their admin combo HUD [adding_hud ? "ON" : "OFF"].")
	log_admin("[key_name(usr)] toggled their admin combo HUD [adding_hud ? "ON" : "OFF"].")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Combo HUD", "[adding_hud ? "Enabled" : "Disabled"]"))


/client/proc/has_antag_hud()
	var/datum/atom_hud/A = GLOB.huds[ANTAG_HUD_TRAITOR]
	return A.hudusers[mob]


/client/proc/run_weather()
	set category = "Event"
	set name = "Run Weather"
	set desc = "Triggers a weather on the z-level you choose."

	if(!holder)
		return

	var/weather_type = input("Choose a weather", "Weather")  as null|anything in sortList(subtypesof(/datum/weather), /proc/cmp_typepaths_asc)
	if(!weather_type)
		return

	var/datum/map_zone/mapzone = input("Map Zone to target?", "Map Zone") as null|anything in SSmapping.map_zones
	if(!mapzone)
		return
	mapzone.assert_weather_controller()
	var/datum/weather_controller/weather_controller = mapzone.weather_controller
	weather_controller.run_weather(weather_type)

	message_admins("[key_name_admin(usr)] started weather of type [weather_type] on the map-zone [mapzone].")
	log_admin("[key_name(usr)] started weather of type [weather_type] on the map-zone [mapzone].")
	BLACKBOX_LOG_ADMIN_VERB("Run Weather")

/client/proc/mass_zombie_infection()
	set category = "Event.Fun"
	set name = "Mass Zombie Infection"
	set desc = "Infects all humans with a latent organ that will zombify \
		them on death."

	if(!check_rights(R_ADMIN))
		return

	var/confirm = alert(src, "Please confirm you want to add latent zombie organs in all humans?", "Confirm Zombies", "Yes", "No")
	if(confirm != "Yes")
		return

	for(var/i in GLOB.human_list)
		var/mob/living/carbon/human/H = i
		new /obj/item/organ/zombie_infection/nodamage(H)

	message_admins("[key_name_admin(usr)] added a latent zombie infection to all humans.")
	log_admin("[key_name(usr)] added a latent zombie infection to all humans.")
	BLACKBOX_LOG_ADMIN_VERB("Mass Zombie Infection")

/client/proc/mass_zombie_cure()
	set category = "Event.Fun"
	set name = "Mass Zombie Cure"
	set desc = "Removes the zombie infection from all humans, returning them to normal."
	if(!check_rights(R_ADMIN))
		return

	var/confirm = alert(src, "Please confirm you want to cure all zombies?", "Confirm Zombie Cure", "Yes", "No")
	if(confirm != "Yes")
		return

	for(var/obj/item/organ/zombie_infection/nodamage/I in GLOB.zombie_infection_list)
		qdel(I)

	message_admins("[key_name_admin(usr)] cured all zombies.")
	log_admin("[key_name(usr)] cured all zombies.")
	BLACKBOX_LOG_ADMIN_VERB("Mass Zombie Cure")

/client/proc/polymorph_all()
	set category = "Event.Fun"
	set name = "Polymorph All"
	set desc = "Applies the effects of the bolt of change to every single mob."

	if(!check_rights(R_ADMIN))
		return

	var/confirm = alert(src, "Please confirm you want polymorph all mobs?", "Confirm Polymorph", "Yes", "No")
	if(confirm != "Yes")
		return

	var/list/mobs = shuffle(GLOB.alive_mob_list.Copy()) // might change while iterating
	var/who_did_it = key_name_admin(usr)

	message_admins("[key_name_admin(usr)] started polymorphed all living mobs.")
	log_admin("[key_name(usr)] polymorphed all living mobs.")
	BLACKBOX_LOG_ADMIN_VERB("Polymorph All")

	for(var/mob/living/M in mobs)
		CHECK_TICK

		if(!M)
			continue

		M.audible_message(span_hear("...wabbajack...wabbajack..."))
		playsound(M.loc, 'sound/magic/staff_change.ogg', 50, TRUE, -1)

	message_admins("Mass polymorph started by [who_did_it] is complete.")


/client/proc/show_tip()
	set category = "Admin"
	set name = "Show Tip"
	set desc = "Sends a tip (that you specify) to all players. After all \
		you're the experienced player here."

	if(!check_rights(R_ADMIN))
		return

	var/input = input(usr, "Please specify your tip that you want to send to the players.", "Tip", "") as message|null
	if(!input)
		return

	if(!SSticker)
		return

	SSticker.selected_tip = input

	// If we've already tipped, then send it straight away.
	if(SSticker.tipped)
		SSticker.send_tip_of_the_round()


	message_admins("[key_name_admin(usr)] sent a tip of the round.")
	log_admin("[key_name(usr)] sent \"[input]\" as the Tip of the Round.")
	BLACKBOX_LOG_ADMIN_VERB("Show Tip")

/client/proc/modify_goals()
	set category = "Debug"
	set name = "Modify goals"

	if(!check_rights(R_ADMIN))
		return

	holder.modify_goals()

/datum/admins/proc/modify_goals()
	var/dat = ""
	for(var/datum/station_goal/S in SSticker.mode.station_goals)
		dat += "[S.name] - <a href='byond://?src=[REF(S)];[HrefToken()];announce=1'>Announce</a> | <a href='byond://?src=[REF(S)];[HrefToken()];remove=1'>Remove</a><br>"
	dat += "<br><a href='byond://?src=[REF(src)];[HrefToken()];add_station_goal=1'>Add New Goal</a>"
	usr << browse(dat, "window=goals;size=400x400")

/proc/immerse_player(mob/living/carbon/target, toggle=TRUE, remove=FALSE)
	var/list/immersion_components = list(/datum/component/manual_breathing, /datum/component/manual_blinking)

	for(var/immersies in immersion_components)
		var/has_component = target.GetComponent(immersies)

		if(has_component && (toggle || remove))
			qdel(has_component)
		else if(toggle || !remove)
			target.AddComponent(immersies)

/proc/mass_immerse(remove=FALSE)
	for(var/mob/living/carbon/M in GLOB.mob_list)
		immerse_player(M, toggle=FALSE, remove=remove)

/client/proc/toggle_hub()
	set category = "Server"
	set name = "Toggle Hub"

	world.update_hub_visibility(!GLOB.hub_visibility)

	log_admin("[key_name(usr)] has toggled the server's hub status for the round, it is now [(GLOB.hub_visibility?"on":"off")] the hub.")
	message_admins("[key_name_admin(usr)] has toggled the server's hub status for the round, it is now [(GLOB.hub_visibility?"on":"off")] the hub.")
	if (GLOB.hub_visibility && !world.reachable)
		message_admins("WARNING: The server will not show up on the hub because byond is detecting that a filewall is blocking incoming connections.")

	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggled Hub Visibility", "[GLOB.hub_visibility ? "Enabled" : "Disabled"]"))

/client/proc/spawn_ruin()
	set name = "Spawn Planet/Ruin"
	set category = "Event.Overmap"
	if(!check_rights(R_ADMIN) || !check_rights(R_SPAWN))
		return

	var/planet_type = tgui_input_list(usr, "What type of planet?", "Spawn Ruin", subtypesof(/datum/planet_type/), 60 SECONDS)
	if(!planet_type)
		return

	var/ruintype = tgui_input_list(usr, "What type of ruin?", "Spawn Ruin", RUINTYPE_LIST_ALL, 60 SECONDS)
	if(!ruintype)
		if(tgui_alert(usr, "Did you mean to not have a ruin?", "Spawn Planet/Ruin", list("Yes", "No"), 10 SECONDS) != "Yes")
			return

	var/datum/map_template/ruin/ruin_target
	if(ruintype)
		var/list/select_from = ruintype_to_list(ruintype)
		var/ruin_force = tgui_alert(usr, "Random Ruin or Forced?", "Spawn Planet/Ruin", list("Random", "Forced"))
		if(!ruin_force)
			return

		switch(ruin_force)
			if("Random")
				//Can't use pick_weight as it might be from "everything"
				ruin_target = select_from[pick(select_from)]
			else
				var/selected_ruin = tgui_input_list(usr, "Which ruin?", "Spawn Ruin", select_from, 60 SECONDS)
				if(!selected_ruin)
					if(tgui_alert(usr, "Did you mean to not have a ruin?", "Spawn Planet/Ruin", list("Yes", "No"), 10 SECONDS) != "Yes")
						return
				else
					ruin_target = select_from[selected_ruin]

	var/list/position = list()
	var/datum/overmap_star_system/selected_system //the star system we are

	if(length(SSovermap.tracked_star_systems) > 1)
		selected_system = tgui_input_list(usr, "Which star system do you want to spawn it in?", "Spawn Planet/Ruin", SSovermap.tracked_star_systems)
	else
		selected_system = SSovermap.tracked_star_systems[1]
	if(!selected_system)
		return //if selected_system didnt get selected, we nope out, this is very bad

	if(tgui_alert(usr, "Where do you want to spawn your Planet/Ruin?", "Spawn Planet/Ruin", list("Pick a location", "Random")) == "Pick a location")
		position["x"] = input(usr, "Choose your X coordinate", "Pick a location", rand(1,selected_system.size)) as num
		position["y"] = input(usr, "Choose your Y coordinate", "Pick a location", rand(1,selected_system.size)) as num
		if(locate(/datum/overmap) in selected_system.overmap_container[position["x"]][position["y"]] && tgui_alert(usr, "There is already an overmap object in that location! Continue anyway?","Pick a location", list("Yes","No"), 10 SECONDS) != "Yes")
			return
	else
		position = selected_system.get_unused_overmap_square()

	var/admin_load_instant = FALSE
	if(tgui_alert(usr, "Instant admin load?", "Spawn Planet/Ruin", list("Yes", "No"), 10 SECONDS) == "Yes")
		admin_load_instant = TRUE

	message_admins("Creating a new Planet with ruin: [ruin_target].")
	if(!position && tgui_alert(usr, "Failed to spawn in an empty overmap space! Continue?", "Spawn Planet/Ruin", list("Yes","No"), 10 SECONDS) != "Yes")
		return
	var/datum/overmap/dynamic/encounter = new(position, selected_system, FALSE)

	encounter.force_encounter = planet_type
	encounter.template = ruin_target
	encounter.choose_level_type(FALSE)
	if(!ruin_target)
		encounter.ruin_type = null
		encounter.selected_ruin  = null
	if(admin_load_instant)
		encounter.admin_load()
		message_admins("Click here to jump to the overmap token: [ADMIN_JMP(encounter.token)], and here to go to the dock: [ADMIN_JMP(encounter.reserve_docks[1])]")
	else
		message_admins("Click here to jump to the overmap token: [ADMIN_JMP(encounter.token)]")
	BLACKBOX_LOG_ADMIN_VERB("Spawn Planet/Ruin")

/client/proc/spawn_overmap()
	set name = "Spawn Overmap"
	set category = "Event.Spawning"
	if(!check_rights(R_ADMIN) || !check_rights(R_SPAWN))
		return

	var/overmap_type = tgui_input_list(usr, "What type of Star System?", "Spawn Overmap", typesof(/datum/overmap_star_system/), 60 SECONDS)
	var/datum/overmap_star_system/nova
	if(!overmap_type)
		return

	if(tgui_alert(usr, "Edit spawn parameters?", "Spawn Overmap", list("Yes", "No"), 10 SECONDS) == "Yes")
		var/inputed
		nova = new overmap_type(FALSE)

		inputed = input(usr, "Choose sector size", "Spawn Overmap", nova.size) as num
		if(!inputed)
			QDEL_NULL(nova)
			return
		nova.size = inputed

		inputed = input(usr, "Choose Maximum amount of Dynamic Events", "Spawn Overmap", nova.max_overmap_dynamic_events) as num
		if(isnull(inputed))
			QDEL_NULL(nova)
			return
		nova.max_overmap_dynamic_events = inputed

		inputed = tgui_input_list(usr, "Choose Map Generator", "Spawn Overmap", list(OVERMAP_GENERATOR_SOLAR, OVERMAP_GENERATOR_RANDOM, OVERMAP_GENERATOR_NONE))
		if(!inputed)
			QDEL_NULL(nova)
			return
		nova.generator_type = inputed

		inputed = tgui_alert(usr, "Have an outpost generate immediatey in this sector?", "Spawn Overmap", list("Yes", "No"))
		if(!inputed)
			QDEL_NULL(nova)
			return
		switch(inputed)
			if("Yes")
				nova.has_outpost = TRUE
			if("No")
				nova.has_outpost = FALSE

		inputed = tgui_alert(usr, "Should players be able to jump to this sector?", "Spawn Overmap", list("Yes", "No"))
		if(!inputed)
			QDEL_NULL(nova)
			return
		switch(inputed)
			if("Yes")
				nova.can_jump_to = TRUE
			if("No")
				nova.can_jump_to = FALSE

	if(tgui_alert(usr, "Edit Overmap Colors?", "Spawn Overmap", list("Yes", "No"), 10 SECONDS) == "Yes")
		if(!nova)
			nova = new overmap_type(FALSE)

		nova.override_object_colors = TRUE
		var/inputed
		inputed = input(usr, "Set Primary Color (Planets):", nova.primary_color) as color|null
		if(inputed)
			nova.primary_color = inputed
		inputed = input(usr, "Set Secondary Color (Background):", nova.secondary_color) as color|null
		if(inputed)
			nova.secondary_color = inputed


		inputed = tgui_alert(usr, "Set a primary hazard color (Dangerous Hazards)? If no then primary hazard color will be set to the color of the sun.", "Spawn Overmap", list("Yes", "No"), 10 SECONDS)
		switch(inputed)
			if("Yes")
				inputed = input(usr, "Set Primary Hazard Color (Dangerous Hazards):", nova.hazard_primary_color) as color|null
				if(inputed)
					nova.hazard_primary_color = inputed
			if("No")
				nova.hazard_primary_color = null
		inputed = input(usr, "Set Secondary Hazard Color (Less Dangerous Hazards):", nova.secondary_color) as color|null
		if(inputed)
			nova.hazard_secondary_color = inputed

		inputed = input(usr, "Set Primary Structure Color (Ships):", nova.primary_structure_color) as color|null
		if(inputed)
			nova.primary_structure_color = inputed

		inputed = input(usr, "Set Secondary Structure Color (Outposts):", nova.secondary_structure_color) as color|null
		if(inputed)
			nova.secondary_structure_color = inputed

		inputed = tgui_input_list(usr, "Choose Background sprite", "Spawn Overmap", list("overmap", "overmap_dark", "overmap_black_bg"))
		if(inputed)
			nova.overmap_icon_state = inputed

	if(tgui_alert(usr, "Give sector custom name? If no inherits from basetype or picks randomly", "Spawn Overmap", list("Yes", "No"), 10 SECONDS) == "Yes")
		nova.name = input(usr, "Set Sector name:", "Spawn Overmap") as text|null

	message_admins("Generating Star System type: [overmap_type], this may take some time!")
	if(nova)
		nova.setup_system()
		nova = SSovermap.spawn_new_star_system(nova)
	else
		nova = SSovermap.spawn_new_star_system(overmap_type)
	if(!nova)
		message_admins("Failed to generate Star System [overmap_type]!")
		return
	message_admins(span_big("Overmap [nova.name] successfully generated!"))
	BLACKBOX_LOG_ADMIN_VERB("Spawn Overmap")

/client/proc/spawn_jump_point()
	set name = "Spawn Overmap Jump Point"
	set category = "Event.Spawning"
	if(!check_rights(R_ADMIN) || !check_rights(R_SPAWN))
		return

	var/datum/overmap_star_system/selected_system //the star system we are in
	var/datum/overmap_star_system/selected_system_2 //the star system we are in
	var/text_directions = list("NORTH", "NORTHEAST", "EAST", "SOUTHEAST", "SOUTH", "SOUTHWEST", "WEST", "NORTHWEST")
	var/selected_dir
	if(length(SSovermap.tracked_star_systems) > 1)
		selected_system = tgui_input_list(usr, "Which star system should point A be in?", "Creating Jump Point", SSovermap.tracked_star_systems)
	else
		to_chat(usr, span_danger("There is only one overmap!"), confidential = TRUE)
		return // if there's only one star system, ignore
	if(!selected_system)
		return //if selected_system didnt get selected, we nope out

	selected_system_2 = tgui_input_list(usr, "Which star system should point B be in?", "Creating Jump Point", SSovermap.tracked_star_systems)
	if(!selected_system_2)
		return //if selected_system_2 didnt get selected, we nope out

	selected_dir = tgui_input_list(usr, "Which direction should the jump point be (relative to point A)", "Creating Jump Point", text_directions)
	if(!selected_dir)
		return

	var/datum/overmap/jump_point/point =selected_system.create_jump_point_link(selected_system_2, text2dir(selected_dir))
	if(!point)
		message_admins("Failed to generate jump point!")

	message_admins(span_big("Click here to jump to the overmap Jump point: " + ADMIN_JMP(point.token)))
	BLACKBOX_LOG_ADMIN_VERB("Spawn Overmap Jump Point")

/client/proc/smite(mob/living/target as mob)
	set name = "Smite"
	set category = "Event.Fun"
	if(!check_rights(R_ADMIN) || !check_rights(R_FUN))
		return

	var/list/punishment_list = list(
		ADMIN_PUNISHMENT_LIGHTNING,
		ADMIN_PUNISHMENT_BRAINDAMAGE,
		ADMIN_PUNISHMENT_GIB,
		ADMIN_PUNISHMENT_BSA,
		ADMIN_PUNISHMENT_FIREBALL,
		ADMIN_PUNISHMENT_SUPPLYPOD_QUICK,
		ADMIN_PUNISHMENT_SUPPLYPOD,
		ADMIN_PUNISHMENT_MAZING,
		ADMIN_PUNISHMENT_CRACK,
		ADMIN_PUNISHMENT_BLEED,
		ADMIN_PUNISHMENT_PERFORATE,
	)

	var/punishment = input("Choose a punishment", "mods kill this guy") as null|anything in sortList(punishment_list)

	if(QDELETED(target) || !punishment)
		return

	switch(punishment)
		if(ADMIN_PUNISHMENT_LIGHTNING)
			var/turf/T = get_step(get_step(target, NORTH), NORTH)
			T.Beam(target, icon_state="lightning[rand(1,12)]", time = 5)
			target.adjustFireLoss(75)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				H.electrocution_animation(40)
			to_chat(target, span_userdanger("The gods have punished you for your sins!"), confidential = TRUE)

		if(ADMIN_PUNISHMENT_BRAINDAMAGE)
			target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 199, 199)

		if(ADMIN_PUNISHMENT_GIB)
			target.gib(FALSE)

		if(ADMIN_PUNISHMENT_BSA)
			bluespace_artillery(target)

		if(ADMIN_PUNISHMENT_FIREBALL)
			new /obj/effect/temp_visual/target(get_turf(target))

		if(ADMIN_PUNISHMENT_SUPPLYPOD_QUICK)
			var/target_path = input(usr,"Enter typepath of an atom you'd like to send with the pod (type \"empty\" to send an empty pod):" ,"Typepath","/obj/item/food/grown/harebell") as null|text
			var/obj/structure/closet/supplypod/centcompod/pod = new()
			pod.damage = 40
			pod.explosionSize = list(0,0,0,2)
			pod.effectStun = TRUE
			if(isnull(target_path)) //The user pressed "Cancel"
				return
			if(target_path != "empty")//if you didn't type empty, we want to load the pod with a delivery
				var/delivery = text2path(target_path)
				if(!ispath(delivery))
					delivery = pick_closest_path(target_path)
					if(!delivery)
						alert("ERROR: Incorrect / improper path given.")
						return
				new delivery(pod)
			new /obj/effect/pod_landingzone(get_turf(target), pod)

		if(ADMIN_PUNISHMENT_SUPPLYPOD)
			var/datum/centcom_podlauncher/plaunch  = new(usr)
			if(!holder)
				return
			plaunch.specificTarget = target
			plaunch.launchChoice = 0
			plaunch.damageChoice = 1
			plaunch.explosionChoice = 1
			plaunch.temp_pod.damage = 40//bring the mother fuckin ruckus
			plaunch.temp_pod.explosionSize = list(0,0,0,2)
			plaunch.temp_pod.effectStun = TRUE
			plaunch.ui_interact(usr)
			return //We return here because punish_log() is handled by the centcom_podlauncher datum

		if(ADMIN_PUNISHMENT_MAZING)
			if(!puzzle_imprison(target))
				to_chat(usr,span_warning("Imprisonment failed!"), confidential = TRUE)
				return

		if(ADMIN_PUNISHMENT_CRACK)
			if(!iscarbon(target))
				to_chat(usr, span_warning("This must be used on a carbon mob."), confidential = TRUE)
				return
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/squish_part
			for(var/zone in C.bodyparts)
				squish_part = C.bodyparts[zone]
				if(!squish_part)
					continue
				var/severity = pick(list(
					"[WOUND_SEVERITY_MODERATE]",
					"[WOUND_SEVERITY_SEVERE]",
					"[WOUND_SEVERITY_SEVERE]",
					"[WOUND_SEVERITY_CRITICAL]",
					"[WOUND_SEVERITY_CRITICAL]",
				))
				C.cause_wound_of_type_and_severity(WOUND_BLUNT, squish_part, severity)

		if(ADMIN_PUNISHMENT_BLEED)
			if(!iscarbon(target))
				to_chat(usr, span_warning("This must be used on a carbon mob."), confidential = TRUE)
				return
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/slice_part
			for(var/zone in C.bodyparts)
				slice_part = C.bodyparts[zone]
				if(!slice_part)
					continue
				var/type_wound = pick(list(/datum/wound/slash/flesh/critical, /datum/wound/slash/flesh/moderate))
				slice_part.force_wound_upwards(type_wound, smited=TRUE)
				type_wound = pick(list(/datum/wound/slash/flesh/critical, /datum/wound/slash/flesh/moderate))
				slice_part.force_wound_upwards(type_wound, smited=TRUE)
				type_wound = pick(list(/datum/wound/slash/flesh/critical, /datum/wound/slash/flesh/moderate))
				slice_part.force_wound_upwards(type_wound, smited=TRUE)

		if(ADMIN_PUNISHMENT_PERFORATE)
			if(!iscarbon(target))
				to_chat(usr, span_warning("This must be used on a carbon mob."), confidential = TRUE)
				return

			var/list/how_fucked_is_this_dude = list("A little", "A lot", "So fucking much", "FUCK THIS DUDE")
			var/hatred = input("How much do you hate this guy?") in how_fucked_is_this_dude
			var/repetitions
			var/shots_per_limb_per_rep = 2
			var/damage
			switch(hatred)
				if("A little")
					repetitions = 1
					damage = 5
				if("A lot")
					repetitions = 2
					damage = 8
				if("So fucking much")
					repetitions = 3
					damage = 10
				if("FUCK THIS DUDE")
					repetitions = 4
					damage = 10

			var/mob/living/carbon/dude = target
			var/list/open_adj_turfs = get_adjacent_open_turfs(dude)
			var/list/wound_bonuses = list(15, 70, 110, 250)

			var/delay_per_shot = 1
			var/delay_counter = 1

			dude.Immobilize(5 SECONDS)
			for(var/wound_bonus_rep in 1 to repetitions)
				var/obj/item/bodypart/slice_part
				for(var/zone in dude.bodyparts)
					slice_part = dude.bodyparts[zone]
					if(!slice_part)
						continue
					var/shots_this_limb = 0
					for(var/t in shuffle(open_adj_turfs))
						var/turf/iter_turf = t
						addtimer(CALLBACK(GLOBAL_PROC, PROC_REF(firing_squad), dude, iter_turf, slice_part.body_zone, wound_bonuses[wound_bonus_rep], damage), delay_counter)
						delay_counter += delay_per_shot
						shots_this_limb++
						if(shots_this_limb > shots_per_limb_per_rep)
							break

	punish_log(target, punishment)

/**
 * firing_squad is a proc for the :B:erforate smite to shoot each individual bullet at them, so that we can add actual delays without sleep() nonsense
 *
 * Hilariously, if you drag someone away mid smite, the bullets will still chase after them from the original spot, possibly hitting other people. Too funny to fix imo
 *
 * Arguments:
 * * target- guy we're shooting obviously
 * * source_turf- where the bullet begins, preferably on a turf next to the target
 * * body_zone- which bodypart we're aiming for, if there is one there
 * * wound_bonus- the wounding power we're assigning to the bullet, since we don't care about the base one
 * * damage- the damage we're assigning to the bullet, since we don't care about the base one
 */
/proc/firing_squad(mob/living/carbon/target, turf/source_turf, body_zone, wound_bonus, damage)
	if(!target.get_bodypart(body_zone))
		return
	playsound(target, 'sound/weapons/gun/revolver/shot.ogg', 100)
	var/obj/projectile/bullet/smite/divine_wrath = new(source_turf)
	divine_wrath.damage = damage
	divine_wrath.wound_bonus = wound_bonus
	divine_wrath.original = target
	divine_wrath.def_zone = body_zone
	divine_wrath.spread = 0
	divine_wrath.preparePixelProjectile(target, source_turf)
	divine_wrath.fire()

/client/proc/punish_log(whom, punishment)
	var/msg = "[key_name_admin(usr)] punished [key_name_admin(whom)] with [punishment]."
	message_admins(msg)
	admin_ticket_log(whom, msg)
	log_admin("[key_name(usr)] punished [key_name(whom)] with [punishment].")

/client/proc/cmd_admin_check_player_exp() //Allows admins to determine who the newer players are.
	set category = "Admin"
	set name = "Player Playtime"
	if(!check_rights(R_ADMIN))
		return

	if(!CONFIG_GET(flag/use_exp_tracking))
		to_chat(usr, span_warning("Tracking is disabled in the server configuration file."), confidential = TRUE)
		return

	var/list/msg = list()
	msg += "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>Playtime Report</title></head><body>Playtime:<BR><UL>"
	for(var/client/C in GLOB.clients)
		msg += "<LI> - [key_name_admin(C)]: <A href='byond://?_src_=holder;[HrefToken()];getplaytimewindow=[REF(C.mob)]'>" + C.get_exp_living() + "</a></LI>"
	msg += "</UL></BODY></HTML>"
	src << browse(msg.Join(), "window=Player_playtime_check")

/datum/admins/proc/cmd_show_exp_panel(client/client_to_check)
	if(!check_rights(R_ADMIN))
		return
	if(!client_to_check)
		to_chat(usr, span_danger("ERROR: Client not found."), confidential = TRUE)
		return
	if(!CONFIG_GET(flag/use_exp_tracking))
		to_chat(usr, span_warning("Tracking is disabled in the server configuration file."), confidential = TRUE)
		return

	new /datum/job_report_menu(client_to_check, usr)

/datum/admins/proc/toggle_exempt_status(client/C)
	if(!check_rights(R_ADMIN))
		return
	if(!C)
		to_chat(usr, span_danger("ERROR: Client not found."), confidential = TRUE)
		return

	if(!C.set_db_player_flags())
		to_chat(usr, span_danger("ERROR: Unable read player flags from database. Please check logs."), confidential = TRUE)
	var/dbflags = C.prefs.db_flags
	var/newstate = FALSE
	if(dbflags & DB_FLAG_EXEMPT)
		newstate = FALSE
	else
		newstate = TRUE

	if(C.update_flag_db(DB_FLAG_EXEMPT, newstate))
		to_chat(usr, span_danger("ERROR: Unable to update player flags. Please check logs."), confidential = TRUE)
	else
		message_admins("[key_name_admin(usr)] has [newstate ? "activated" : "deactivated"] job exp exempt status on [key_name_admin(C)]")
		log_admin("[key_name(usr)] has [newstate ? "activated" : "deactivated"] job exp exempt status on [key_name(C)]")

/// Allow admin to add or remove traits of datum
/datum/admins/proc/modify_traits(datum/D)
	if(!D)
		return

	var/add_or_remove = input("Remove/Add?", "Trait Remove/Add") as null|anything in list("Add","Remove")
	if(!add_or_remove)
		return
	var/list/availible_traits = list()

	switch(add_or_remove)
		if("Add")
			for(var/key in GLOB.traits_by_type)
				if(istype(D,key))
					availible_traits += GLOB.traits_by_type[key]
		if("Remove")
			if(!GLOB.trait_name_map)
				GLOB.trait_name_map = generate_trait_name_map()
			for(var/trait in D.status_traits)
				var/name = GLOB.trait_name_map[trait] || trait
				availible_traits[name] = trait

	var/chosen_trait = input("Select trait to modify", "Trait") as null|anything in sortList(availible_traits)
	if(!chosen_trait)
		return
	chosen_trait = availible_traits[chosen_trait]

	var/source = "adminabuse"
	switch(add_or_remove)
		if("Add") //Not doing source choosing here intentionally to make this bit faster to use, you can always vv it.
			if(GLOB.movement_type_trait_to_flag[chosen_trait]) //include the required element.
				D.AddElement(/datum/element/movetype_handler)
			ADD_TRAIT(D,chosen_trait,source)
		if("Remove")
			var/specific = input("All or specific source ?", "Trait Remove/Add") as null|anything in list("All","Specific")
			if(!specific)
				return
			switch(specific)
				if("All")
					source = null
				if("Specific")
					source = input("Source to be removed","Trait Remove/Add") as null|anything in sortList(D.status_traits[chosen_trait])
					if(!source)
						return
			REMOVE_TRAIT(D,chosen_trait,source)

/datum/admins/proc/gift(mob/living/carbon/human/target as mob, object as text)
	set name = "Gift a mob"
	set category = "Event.Spawning"
	set desc = "Give a mob an item directly."
	if(!check_rights(R_ADMIN) || !check_rights(R_FUN))
		return

	var/obj/item/chosen = pick_closest_path(object, make_types_fancy(subtypesof(/obj/item)))
	if(!chosen || QDELETED(target))
		return

	if(!ishuman(target))
		to_chat(usr, "This can only be used on instances of type /mob/living/carbon/human.", confidential = TRUE)
		return
	var/mob/living/carbon/human/H = target
	if(H.recieve_gift(chosen))
		log_admin("[key_name(H)] got their [initial(chosen.name)], spawned by [key_name(usr)].")
		message_admins("[key_name(H)] got their [initial(chosen.name)], spawned by [key_name_admin(usr)].")
	else
		log_admin("[key_name(H)] has their hands full, so they did not receive their [initial(chosen.name)], spawned by [key_name(usr)].")
		message_admins("[key_name(H)] has their hands full, so they did not receive their [initial(chosen.name)], spawned by [key_name_admin(usr)].")

/mob/living/carbon/human/proc/recieve_gift(obj/item/present, prompted = TRUE)
	var/obj/item/I = new present(src)
	if(put_in_hands(I))
		update_inv_hands()
		if(prompted)
			to_chat(src, span_adminnotice("Your prayers have been answered!! You received the <b>best [I.name]!</b>"), confidential = TRUE)
			SEND_SOUND(src, sound('sound/effects/pray_chaplain.ogg'))
		return TRUE
	else
		qdel(I)
		return FALSE
