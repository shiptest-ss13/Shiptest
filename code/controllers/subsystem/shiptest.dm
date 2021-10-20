SUBSYSTEM_DEF(shipbot)
	name = "ShipBot Controller"
	init_order = INIT_ORDER_TICKER
	flags = SS_NO_FIRE

	var/enabled = FALSE
	var/export_address
	var/pinging = FALSE
	var/ping_fails = 0
	var/static/list/reserved_keys = list("commkey", "command", "args")
	/// KEEP THIS UP TO DATE. IF YOU ADD NEW ONES ADD IT HERE
	var/static/list/channel_keys = list(
		"admin",
		"admin-round",
		"admin-ban",
		"admin-permission",
		"admin-server",
		"admin-fax",
		"round",
	)

/datum/controller/subsystem/shipbot/stat_entry(msg)
	if(pinging)
		return "Initializing (Pinging)"
	return enabled ? "Ready" : "Disabled ([ping_fails] Ping Fails)"

/datum/controller/subsystem/shipbot/proc/shipbot_encode(message)
	return url_encode(message)

/datum/controller/subsystem/shipbot/proc/shipbot_decode(message)
	return url_decode(message)

/datum/config_entry/string/shipbot_address
/datum/config_entry/string/shipbot_commkey
/datum/config_entry/string/shipbot_botkey

/datum/controller/subsystem/shipbot/Initialize(start_timeofday)
	. = ..()
	var/address = CONFIG_GET(string/shipbot_address)
	var/comms_key = CONFIG_GET(string/shipbot_commkey)
	if(!address || !comms_key)
		return
	export_address = "http://[address]/?commkey=[comms_key]"
	addtimer(CALLBACK(src, .proc/do_ping), 0)

/datum/controller/subsystem/shipbot/proc/do_ping()
	if(!export_address)
		enabled = FALSE
		return

	if(pinging)
		return

	pinging = world.timeofday
	enabled = do_export_get("ping") == "pong"
	if(!enabled)
		ping_fails++
		if(ping_fails < 3)
			addtimer(CALLBACK(src, .proc/do_ping), 2 SECONDS)
	pinging = FALSE

	if(do_export_get("check") == "kill")
		del world

/datum/controller/subsystem/shipbot/proc/do_topic(topic)
	stack_trace("topic")
	if(!enabled)
		return
	if(findtext(topic, "SHIPBOT-") != 1)
		return
	var/list/split = splittext(topic, "-")
	var/botkey = split[2]
	var/expected = CONFIG_GET(string/shipbot_botkey)
	if(botkey != expected)
		CRASH("Invalid Botkey!")
	var/command = split[3]
	var/list/_args = split.Copy(4)
	var/list/parameters = new
	for(var/arg in _args)
		parameters += shipbot_decode(arg)
	to_chat(world, "Shipbot Topic ran with: [command] and [length(parameters)] args")

	. = SHIPBOT_TOPIC_RESPONSE_BAD_COMMAND

	if(command == SHIPBOT_TOPIC_PING)
		return "PONG"

	if(command == SHIPBOT_TOPIC_RELAY_OOC)
		for(var/client/client in GLOB.clients)
			if(!(client.prefs.chat_toggles & CHAT_OOC))
				continue
			to_chat(client, "<span class='ooc'><span class='prefix'>RELAY:</span> <EM>[parameters[1]]:</EM> <span class='message linkify'>[parameters[2]]</span></span>")
		return SHIPBOT_TOPIC_RESPONSE_GOOD

	if(command == SHIPBOT_TOPIC_RELAY_ADMIN_SAY)
		to_chat(GLOB.admins, "<span class='adminsay'>ASAY-RELAY: [parameters[1]]: [parameters[2]]</span>")
		return SHIPBOT_TOPIC_RESPONSE_GOOD

	if(command == SHIPBOT_TOPIC_RELAY_ADMIN_PM)
		var/client/target = get_mob_by_ckey(lowertext(parameters[3]))
		if(!target)
			return SHIPBOT_TOPIC_RESPONSE_FAIL
		to_chat(target, "<span class='adminhelp'>Admin PM from '[parameters[1]]': [parameters[2]]</span>")
		return SHIPBOT_TOPIC_RESPONSE_GOOD

	if(command == SHIPBOT_TOPIC_RELAY_MENTOR_SAY)
		to_chat(GLOB.mentors, "<span class='mentor'>MSAY-RELAY: [parameters[1]]: [parameters[2]]</span>")
		return SHIPBOT_TOPIC_RESPONSE_GOOD

	if(command == SHIPBOT_TOPIC_RELAY_MENTOR_PM)
		var/client/target = get_mob_by_ckey(lowertext(parameters[3]))
		if(!target)
			return SHIPBOT_TOPIC_RESPONSE_FAIL
		to_chat(target, "<span class='mentor'>Mentor PM from '[parameters[1]]': [parameters[2]]</span>")
		return SHIPBOT_TOPIC_RESPONSE_GOOD

	if(command == SHIPBOT_TOPIC_RELAY_CHANNEL_LIST)
		var/message = channel_keys[1]
		for(var/channel in _list_copy(channel_keys, 2))
			message += "|[channel]"
		return message

/// Send a GET request to the shipbot daemon with the given command and data.
/datum/controller/subsystem/shipbot/proc/do_export_get(command, list/data)
	if(!enabled && !pinging)
		return FALSE

	var/data_string
	if(islist(data))
		for(var/entry in data)
			if(!data[entry])
				stack_trace("Attempt to run DoExport with a non-assosciative data list")
				return FALSE
			if(text_in_list(entry, reserved_keys))
				stack_trace("Attempt to run DoExport with a reserved key '[entry]'")
				return FALSE
			var/data_entry = data[entry]
			entry = shipbot_encode(entry)
			data_entry = shipbot_encode(data_entry)
			if(data_string)
				data_string = "[data_string]&[entry]=[data_entry]"
			else
				data_string = "&[entry]=[data_entry]"

	var query = "[export_address]&command=[command][data_string]"
	var response = world.Export(query)
	if("CONTENT" in response)
		return file2text(response["CONTENT"])
	return

/datum/controller/subsystem/shipbot/proc/relay_ooc(client, message)
	if(!enabled)
		return
	do_export_get("relay_ooc", list(
		"client" = client,
		"message" = message,
	))

/datum/controller/subsystem/shipbot/proc/relay_admin_say(client, message)
	if(!enabled)
		return
	do_export_get("relay_admin_say", list(
		"client" = client,
		"message" = message,
	))

/datum/controller/subsystem/shipbot/proc/relay_mentor_say(client, message)
	if(!enabled)
		return
	do_export_get("relay_mentor_say", list(
		"client" = client,
		"message" = message
	))

/datum/controller/subsystem/shipbot/proc/relay_admin_help(datum/admin_help/ahelp, message)
	if(!enabled)
		return
	do_export_get("relay_admin_help", list(
		"client" = ahelp.initiator.key,
		"message" = message,
	))

/datum/controller/subsystem/shipbot/proc/relay_mentor_help(client, message)
	if(!enabled)
		return
	do_export_get("relay_mentor_help", list(
		"client" = client,
		"message" = message,
	))

/// Used to send miscellaneous stuff that doesnt make sense to have a dedicated proc
/datum/controller/subsystem/shipbot/proc/relay_channel(channel_key, message)
	if(!enabled)
		return
	do_export_get("relay_channel", list(
		"channel" = channel_key,
		"message" = "[channel_key]: [message]",
	))

/// Set the state of a flag, :shrug:
/datum/controller/subsystem/shipbot/proc/relay_flag(flag_key, state)
	if(!enabled)
		return
	// We use !!state here to prevent some chucklefuck sending a non boolean number
	do_export_get("relay_flag", list(
		"flag" = flag_key,
		"state" = !!state,
	))
