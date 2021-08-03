/datum/world_topic/ooc_relay
	keyword = "ooc_send"
	require_comms_key = TRUE

/datum/world_topic/ooc_relay/Run(list/input)
	if(GLOB.say_disabled || !GLOB.ooc_allowed)	//This is here to try to identify lag problems
		return "OOC is currently disabled."

	var/message = input["message"]

	SSredbot.send_discord_message("ooc", "**[input["sender"]]:** [message]")

	message = copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN)

	message = emoji_parse(message)

	for(var/client/C in GLOB.clients)
		if(C.prefs.chat_toggles & CHAT_OOC)
			if(GLOB.OOC_COLOR)
				to_chat(C, "<font color='[GLOB.OOC_COLOR]'><b><span class='prefix'>OOC:</span> <EM>[input["sender"]]:</EM> <span class='message linkify'>[message]</span></b></font>")
			else
				to_chat(C, "<span class='ooc'><span class='prefix'>OOC:</span> <EM>[input["sender"]]:</EM> <span class='message linkify'>[message]</span></span>")

/datum/world_topic/asay_relay
	keyword = "asay_send"
	require_comms_key = TRUE

/datum/world_topic/asay_relay/Run(list/input)
	var/message = "<span class='adminsay'><span class='prefix'>ADMIN:</span> <EM>[input["sender"]]</EM>: <span class='message linkify'>[input["message"]]</span></span>"
	message = emoji_parse(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	message = keywords_lookup(message)
	to_chat(GLOB.admins, message)

/datum/world_topic/manifest //Inspired by SunsetStation
	keyword = "manifest"
	require_comms_key = TRUE //not really needed, but I don't think any bot besides ours would need it

/datum/world_topic/manifest/Run(list/input)
	. = list()
	var/list/manifest = SSjob.get_manifest()
	for(var/department in manifest)
		var/list/entries = manifest[department]
		var/list/dept_entries = list()
		for(var/entry in entries)
			var/list/entry_list = entry
			dept_entries += "[entry_list["name"]]: [entry_list["rank"]]"
		.[department] = dept_entries

	return list2params(.)

/datum/world_topic/reload_admins
	keyword = "reload_admins"
	require_comms_key = TRUE

/datum/world_topic/reload_admins/Run(list/input)
	ReloadAsync()
	log_admin("[input["sender"]] reloaded admins via chat command.")
	return "Admins reloaded."

/datum/world_topic/reload_admins/proc/ReloadAsync()
	set waitfor = FALSE
	load_admins()

/datum/world_topic/restart
	keyword = "restart"
	require_comms_key = TRUE

/datum/world_topic/restart/Run(list/input)
	var/active_admins = FALSE
	var/hard_reset = input["hard"]

	if (hard_reset && !world.TgsAvailable())
		hard_reset = FALSE

	for(var/client/C in GLOB.admins)
		if(!C.is_afk() && check_rights_for(C, R_SERVER))
			active_admins = TRUE
			break
	if(!active_admins)
		if(hard_reset)
			return world.Reboot(fast_track = TRUE)
		else
			return world.Reboot()
	else
		return "There are active admins on the server! Ask them to restart."
