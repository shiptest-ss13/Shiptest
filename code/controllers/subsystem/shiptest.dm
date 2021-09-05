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
		"/" = "%2F",
		"=" = "%3D",
		"!" = "%21",
	)

/datum/config_entry/string/shiptest_address
/datum/config_entry/string/shiptest_commkey

/datum/controller/subsystem/shiptest/Initialize(start_timeofday)
	. = ..()
	var/address = CONFIG_GET(string/shiptest_address)
	var/comms_key = CONFIG_GET(string/shiptest_commkey)
	if(!address || !comms_key)
		return
	export_address = "http://[address]/?commkey=[comms_key]"
	do_ping()

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

	to_chat(world, "Shiptest Topic ran with: [command] and [length(_args)] args")


	if(command == SHIPTEST_TOPIC_PING)
		return SHIPTEST_TOPIC_PING

	if(command == SHIPTEST_TOPIC_OOC_RELAY)
		for(var/client/client in GLOB.clients)
			if(!(client.prefs.chat_toggles & CHAT_OOC))
				continue
			to_chat(client, "<font color='["#9e7b2f"]'><b><span class='prefix'>RELAY:</span> <EM>[_args[1]]:</EM> <span class='message linkify'>[_args[2]]</span></b></font>")
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
			for(var/reserved_char in reserved_chars)
				var/replacing = reserved_chars[reserved_char]
				if(findtext_char(entry, reserved_char))
					entry = replacetext_char(entry, reserved_char, replacing)
				if(findtext_char(data_entry, reserved_char))
					data_entry = replacetext_char(data_entry, reserved_char, replacing)
			if(data_string)
				data_string = "[data_string]&[entry]=[data_entry]"
			else
				data_string = "&[entry]=[data_entry]"

	var query = "[export_address]&command=[command][data_string]"
	var response = world.Export(query)
	var content = file2text(response["CONTENT"])
	return content

/datum/controller/subsystem/shiptest/proc/_export_get(command, list/data)

/datum/controller/subsystem/shiptest/proc/ooc_relay(client/client, message)
	set waitfor = FALSE
	if(!enabled)
		return
	do_export_get("occ-relay", list(
		"client" = client.key,
		"message" = message,
	))
