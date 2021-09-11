SUBSYSTEM_DEF(shiptest)
	name = "Shiptest Bot"
	init_order = INIT_ORDER_TICKER
	flags = SS_NO_FIRE

	var/enabled = FALSE
	var/export_address
	var/pinging = FALSE
	var/static/list/reserved_keys = list("commkey", "command", "args")
	var/static/list/reserved_chars = list(
		"?" = "%3F",
		"&" = "%26",
		"#" = "%23",
		"%" = "%25",
		"|" = "%7C",
		"/" = "%2F",
		"=" = "%3D",
		"<" = "%3C",
		">" = "%3E",
		"\"" = "%22",
		"!" = "%21",
		" " = "%20",
	)

/proc/shipbot_encode(message)
	for(var/reserved in reserved_chars)
		if(findtext_char(message, reserved))
			if(!reserved_chars[reserved])
				stack_trace("Removing illegal topic splitter from message.")
			message = replacetext_char(message, reserved, reserved_chars[reserved])
	return message

/proc/shipbot_decode(message)
	for(var/reserved in reserved_chars)
		var/looking = reserved_chars[reserved]
		if(findtext_char(message, looking))
			message = replacetext_char(message, looking, reserved)
	return message

/datum/config_entry/string/shiptest_address
/datum/config_entry/string/shiptest_commkey

/datum/controller/subsystem/shiptest/Initialize(start_timeofday)
	. = ..()
	var/address = CONFIG_GET(string/shiptest_address)
	var/comms_key = CONFIG_GET(string/shiptest_commkey)
	if(!address || !comms_key)
		return
	export_address = "http://[address]/?commkey=[comms_key]"
	addtimer(CALLBACK(src, .proc/do_ping), 0)

/datum/controller/subsystem/shiptest/proc/do_ping()
	if(!export_address)
		enabled = FALSE
		return

	if(pinging)
		return

	pinging = world.timeofday
	enabled = do_export_get("ping") == "pong"
	pinging = FALSE

	if(do_export_get("check") == "kill")
		del world


/datum/controller/subsystem/shiptest/proc/do_topic(topic)
	if(!enabled)
		return
	if(findtext(topic, "SHIPTEST-") != 1)
		return
	var/list/split = splittext(topic, "-")
	var/command = split[2]
	var/list/_args = split.Copy(3)
	var/list/parameters = new
	for(var/arg in _args)
		parameters += shipbot_decode(arg)
	to_chat(world, "Shiptest Topic ran with: [command] and [length(parameters)] args")


	if(command == SHIPTEST_TOPIC_PING)
		return "PONG"

	if(command == SHIPTEST_TOPIC_OOC_RELAY)
		ooc_relay_get(parameters[0], parameters[1])
		return SHIPTEST_TOPIC_RESPONSE_GOOD

	return SHIPTEST_TOPIC_RESPONSE_BAD_COMMAND

/// Send a GET request to the shiptest bot with the given command and data.
/datum/controller/subsystem/shiptest/proc/do_export_get(command, list/data)
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

/datum/controller/subsystem/shiptest/proc/ooc_relay_send(client/client, message)
	if(!enabled)
		return
	do_export_get("ooc-relay", list(
		"client" = client.key,
		"message" = message,
	))

/datum/controller/subsystem/shiptest/proc/ooc_relay_get(name, message)
	for(var/client/client in GLOB.clients)
		if(!(client.prefs.chat_toggles & CHAT_OOC))
			continue
		to_chat(client, "<span class='ooc'><span class='prefix'>RELAY:</span> <EM>[name]:</EM> <span class='message linkify'>[message]</span></span>")
