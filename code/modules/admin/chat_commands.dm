#define TGS_STATUS_THROTTLE 5

/datum/tgs_chat_command/restart
	name = "restart"
	help_text = "Restarts the server if there are no active admins on."

/datum/tgs_chat_command/restart/Run(datum/tgs_chat_user/sender, params)
	var/active_admins = FALSE
	for(var/client/C in GLOB.admins)
		if(!C.is_afk() && check_rights_for(C, R_SERVER))
			active_admins = TRUE
			break
	if(!active_admins)
		SSticker.Reboot("Restart requested from the discord.", "discord")
		return new /datum/tgs_message_content("Rebooting...")
	else
		return new /datum/tgs_message_content("There are active admins on the server! Ask them to restart.")

/datum/tgs_chat_command/join
	name = "join"
	help_text = "Sends a join link."

/datum/tgs_chat_command/join/Run(datum/tgs_chat_user/sender, params)
	var/datum/tgs_chat_embed/structure/embed = new()
	embed.title = "Join Server"
	embed.colour = COLOR_DARK_CYAN
	embed.description = "Enter this URL into the BYOND pager to join the server: byond://[world.internet_address]:[world.port]"

	var/datum/tgs_message_content/join = new()
	join.embed = embed

	return join

/datum/tgs_chat_command/tgsstatus
	name = "status"
	help_text = "Gets the admincount, playercount, gamemode, and true game mode of the server"
	admin_only = TRUE
	var/last_tgs_status = 0

/datum/tgs_chat_command/tgsstatus/Run(datum/tgs_chat_user/sender, params)
	var/rtod = REALTIMEOFDAY
	if(rtod - last_tgs_status < TGS_STATUS_THROTTLE)
		return new /datum/tgs_message_content("Please wait a few seconds before using this command again.")
	last_tgs_status = rtod

	var/datum/tgs_chat_embed/structure/embed = new()
	embed.title = "Server Admin Status"
	embed.colour = COLOR_DARK_CYAN

	embed.fields = list()
	embed.fields += new /datum/tgs_chat_embed/field("Round", "[GLOB.round_id ? "Round #[GLOB.round_id]" : "Not started"]\n[station_name()]\n[length(SSovermap.controlled_ships)] ships")
	embed.fields += new /datum/tgs_chat_embed/field("Admins", tgsadminwho())
	embed.fields += new /datum/tgs_chat_embed/field("Players", "Total: [length(GLOB.clients)]\nActive: [get_active_player_count(FALSE, TRUE, FALSE)]\nAlive: [get_active_player_count(TRUE, TRUE, TRUE)]")

	embed.fields += new /datum/tgs_chat_embed/field("Tickets", "Active: [length(GLOB.ahelp_tickets.active_tickets)]\nResolved: [length(GLOB.ahelp_tickets.resolved_tickets)]\nClosed: [length(GLOB.ahelp_tickets.closed_tickets)]")
	embed.fields += new /datum/tgs_chat_embed/field("Interviews", "Open: [length(GLOB.interviews.open_interviews) - length(GLOB.interviews.interview_queue)]\nSubmitted: [length(GLOB.interviews.interview_queue)]\nClosed: [length(GLOB.interviews.closed_interviews)]")

	embed.fields += new /datum/tgs_chat_embed/field("Mode", "[SSticker.mode ? SSticker.mode.name : "Not started"]")
	embed.fields += new /datum/tgs_chat_embed/field("Round Time", ROUND_TIME)
	embed.fields += new /datum/tgs_chat_embed/field("Time Dilation", "[round(SStime_track.time_dilation_current, 0.1)]% ([round(SStime_track.time_dilation_avg, 0.1)]% avg)")

	for(var/datum/tgs_chat_embed/field/field as anything in embed.fields)
		field.is_inline = TRUE

	var/datum/tgs_message_content/status = new()
	status.embed = embed

	return status

/datum/tgs_chat_command/subsystems
	name = "subsystems"
	help_text = "Gets the status of the server subsystems"
	admin_only = TRUE
	var/last_tgs_subsystems = 0

/datum/tgs_chat_command/subsystems/Run(datum/tgs_chat_user/sender, params)
	var/rtod = REALTIMEOFDAY
	if(rtod - last_tgs_subsystems < TGS_STATUS_THROTTLE)
		return new /datum/tgs_message_content("Please wait a few seconds before using this command again.")
	last_tgs_subsystems = rtod

	var/datum/tgs_chat_embed/structure/embed = new()
	embed.title = "Server Subsystems"
	embed.colour = COLOR_DARK_CYAN

	embed.description = Master.stat_entry()

	embed.fields = list()
	for(var/datum/controller/subsystem/sub_system as anything in Master.subsystems)
		if(params && !findtext(sub_system.name, params))
			continue
		var/datum/tgs_chat_embed/field/sub_system_entry = new ("\[[sub_system.state_letter()]] [sub_system.name]", sub_system.stat_entry())
		sub_system_entry.is_inline = TRUE
		embed.fields += sub_system_entry

	var/datum/tgs_message_content/subsystems = new()
	subsystems.embed = embed

	return subsystems

/datum/tgs_chat_command/tgscheck
	name = "check"
	help_text = "Gets the playercount, gamemode, and address of the server"
	var/last_tgs_check = 0

/datum/tgs_chat_command/tgscheck/Run(datum/tgs_chat_user/sender, params)
	var/rtod = REALTIMEOFDAY
	if(rtod - last_tgs_check < TGS_STATUS_THROTTLE)
		return new /datum/tgs_message_content("Please wait a few seconds before using this command again.")
	last_tgs_check = rtod

	var/datum/tgs_chat_embed/structure/embed = new()
	embed.title = "Server Status"
	embed.colour = COLOR_DARK_CYAN

	embed.fields = list()
	embed.fields += new /datum/tgs_chat_embed/field("Round", "[GLOB.round_id ? "Round #[GLOB.round_id]" : "Not started"]")
	embed.fields += new /datum/tgs_chat_embed/field("Players", "[length(GLOB.player_list) || "No players"]")
	embed.fields += new /datum/tgs_chat_embed/field("Admins", "[length(GLOB.admins) || "No admins"]")
	embed.fields += new /datum/tgs_chat_embed/field("Round Time", ROUND_TIME)
	embed.fields += new /datum/tgs_chat_embed/field("Time Dilation", "[round(SStime_track.time_dilation_current, 0.1)]% ([round(SStime_track.time_dilation_avg, 0.1)]% avg)")

	for(var/datum/tgs_chat_embed/field/field as anything in embed.fields)
		field.is_inline = TRUE

	var/datum/tgs_message_content/status = new()
	status.embed = embed

	return status

/datum/tgs_chat_command/ahelp
	name = "ahelp"
	help_text = "<ckey|ticket #> <message|ticket <close|resolve|icissue|reject|reopen <ticket #>|list>>"
	admin_only = TRUE

/datum/tgs_chat_command/ahelp/Run(datum/tgs_chat_user/sender, params)
	var/list/all_params = splittext(params, " ")
	if(all_params.len < 2)
		return new /datum/tgs_message_content("Insufficient parameters")
	var/target = all_params[1]
	all_params.Cut(1, 2)
	var/id = text2num(target)
	if(id != null)
		var/datum/admin_help/AH = GLOB.ahelp_tickets.ticket_by_id(id)
		if(AH)
			target = AH.initiator_ckey
		else
			return new /datum/tgs_message_content("Ticket #[id] not found.")
	var/res = TgsPm(target, all_params.Join(" "), sender.friendly_name)
	if(res != "Message Successful")
		return new /datum/tgs_message_content(res)

/datum/tgs_chat_command/namecheck
	name = "namecheck"
	help_text = "Returns info on the specified target"
	admin_only = TRUE

/datum/tgs_chat_command/namecheck/Run(datum/tgs_chat_user/sender, params)
	params = trim(params)
	if(!params)
		return new /datum/tgs_message_content("Please specify a target.")
	log_admin("Chat Name Check: [sender.friendly_name] on [params]")
	message_admins("Name checking [params] from [sender.friendly_name]")
	return new /datum/tgs_message_content(keywords_lookup(params, TRUE))

/datum/tgs_chat_command/adminwho
	name = "adminwho"
	help_text = "Lists administrators currently on the server"
	admin_only = TRUE

/datum/tgs_chat_command/adminwho/Run(datum/tgs_chat_user/sender, params)
	var/datum/tgs_chat_embed/structure/embed = new()
	embed.title = "Admins"
	embed.colour = COLOR_DARK_CYAN
	embed.description = tgsadminwho() || "No admins online."

	var/datum/tgs_message_content/adminwho = new()
	adminwho.embed = embed

	return adminwho

GLOBAL_LIST(round_end_notifiees)

/datum/tgs_chat_command/endnotify
	name = "endnotify"
	help_text = "Pings the invoker when the round ends"
	admin_only = TRUE

/datum/tgs_chat_command/endnotify/Run(datum/tgs_chat_user/sender, params)
	if(!SSticker.IsRoundInProgress() && SSticker.HasRoundStarted())
		return "[sender.mention], the round has already ended!"
	LAZYSET(GLOB.round_end_notifiees, sender.mention, TRUE)
	return new /datum/tgs_message_content( "I will notify [sender.mention] when the round ends.")

/datum/tgs_chat_command/sdql
	name = "sdql"
	help_text = "Runs an SDQL query"
	admin_only = TRUE

/datum/tgs_chat_command/sdql/Run(datum/tgs_chat_user/sender, params)
	if(GLOB.AdminProcCaller)
		return new /datum/tgs_message_content("Unable to run query, another admin proc call is in progress. Try again later.")
	GLOB.AdminProcCaller = "CHAT_[sender.friendly_name]"	//_ won't show up in ckeys so it'll never match with a real admin
	var/list/results = world.SDQL2_query(params, GLOB.AdminProcCaller, GLOB.AdminProcCaller)
	GLOB.AdminProcCaller = null
	if(!results)
		return new /datum/tgs_message_content("Query produced no output.")
	var/list/text_res = results.Copy(1, 3)
	var/list/refs = results.len > 3 ? results.Copy(4) : null

	var/datum/tgs_chat_embed/structure/embed = new()
	embed.title = "SDQL Query Results"
	embed.colour = COLOR_DARK_CYAN
	embed.description = text_res.Join("\n") || "No results."
	embed.fields = list()
	embed.fields += new /datum/tgs_chat_embed/field("Refs", refs ? refs.Join("\n") : "None")

	var/datum/tgs_message_content/sdql = new()
	sdql.embed = embed

	return sdql

/datum/tgs_chat_command/reload_admins
	name = "reload_admins"
	help_text = "Forces the server to reload admins."
	admin_only = TRUE

/datum/tgs_chat_command/reload_admins/Run(datum/tgs_chat_user/sender, params)
	ReloadAsync()
	log_admin("[sender.friendly_name] reloaded admins via chat command.")
	return new /datum/tgs_message_content("Admins reloaded.")

/datum/tgs_chat_command/reload_admins/proc/ReloadAsync()
	set waitfor = FALSE
	load_admins()

/datum/tgs_chat_command/manifest
	name = "manifest"
	help_text = "Displays the current crew manifest"

/datum/tgs_chat_command/manifest/Run(datum/tgs_chat_user/sender, params)
	var/list/manifest = SSovermap.get_manifest()

	var/datum/tgs_chat_embed/structure/embed = new()
	embed.title = "__Crew Manifest:__"
	embed.colour = COLOR_DARK_CYAN

	if(!length(manifest))
		embed.description = "No crew manifest available."
	else
		embed.fields = list()
		for(var/ship in manifest)
			var/list/entries = manifest[ship]
			var/list/ship_entries = list()
			for(var/entry in entries)
				var/list/entry_list = entry
				ship_entries += "[entry_list["name"]]: [entry_list["rank"]]"

			var/datum/tgs_chat_embed/field/ship_field = new(ship, ship_entries.Join("\n"))
			ship_field.is_inline = TRUE
			embed.fields += ship_field

	var/datum/tgs_message_content/manifest_content = new()
	manifest_content.embed = embed

	return manifest_content

/datum/tgs_chat_command/who
	name = "who"
	help_text = "Displays the current player list"

/datum/tgs_chat_command/who/Run(datum/tgs_chat_user/sender, params)
	var/datum/tgs_chat_embed/structure/embed = new()
	embed.colour = COLOR_DARK_CYAN

	if(!length(GLOB.clients))
		embed.title = "__Players:__"
		embed.description = "No players online."
	else
		embed.title = "__Players ([length(GLOB.clients)]):__"
		for(var/client/player as anything in GLOB.clients)
			embed.description += "[player.ckey]\n"

	var/datum/tgs_message_content/who = new()
	who.embed = embed

	return who
