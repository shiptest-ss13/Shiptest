
/**

	Here is the big, bad function that broadcasts a message given the appropriate
	parameters.

	@param M:
		Reference to the mob/speaker, stored in signal.data["mob"]

	@param vmask:
		Boolean value if the mob is "hiding" its identity via voice mask, stored in
		signal.data["vmask"]

	@param vmessage:
		If specified, will display this as the message; such as "chimpering"
		for monkeys if the mob is not understood. Stored in signal.data["vmessage"].

	@param radio:
		Reference to the radio broadcasting the message, stored in signal.data["radio"]

	@param message:
		The actual string message to display to mobs who understood mob M. Stored in
		signal.data["message"]

	@param name:
		The name to display when a mob receives the message. signal.data["name"]

	@param job:
		The name job to display for the AI when it receives the message. signal.data["job"]

	@param realname:
		The "real" name associated with the mob. signal.data["realname"]

	@param vname:
		If specified, will use this name when mob M is not understood. signal.data["vname"]

	@param data:
		If specified:
				1 -- Will only broadcast to intercoms
				2 -- Will only broadcast to intercoms and station-bounced radios
				3 -- Broadcast to syndicate frequency
				4 -- AI can't track down this person. Useful for imitation broadcasts where you can't find the actual mob

	@param compression:
		If 0, the signal is audible
		If nonzero, the signal may be partially inaudible or just complete gibberish.

	@param map_zones:
		The list of map zones that the sending radio is broadcasting to.

	@param freq
		The frequency of the signal

**/

// Subtype of /datum/signal with additional processing information.
/datum/signal/subspace
	transmission_method = TRANSMISSION_SUBSPACE
	var/server_type = /obj/machinery/telecomms/server
	var/datum/signal/subspace/original
	/// Map zones that this signal is reaching
	var/list/map_zones
	/// Whether it reaches all virtual levels
	var/wideband = FALSE

/datum/signal/subspace/New(data)
	src.data = data || list()

/datum/signal/subspace/proc/copy()
	var/datum/signal/subspace/copy = new
	copy.original = src
	copy.source = source
	copy.map_zones = map_zones
	copy.frequency = frequency
	copy.server_type = server_type
	copy.transmission_method = transmission_method
	copy.data = data.Copy()
	copy.wideband = wideband
	return copy

/datum/signal/subspace/proc/mark_done()
	var/datum/signal/subspace/current = src
	while (current)
		current.data["done"] = TRUE
		current = current.original

/datum/signal/subspace/proc/send_to_receivers()
	for(var/obj/machinery/telecomms/receiver/R in GLOB.telecomms_list)
		R.receive_signal(src)
	for(var/obj/machinery/telecomms/allinone/R in GLOB.telecomms_list)
		R.receive_signal(src)

/datum/signal/subspace/proc/broadcast()
	set waitfor = FALSE

// Vocal transmissions (i.e. using saycode).
// Despite "subspace" in the name, these transmissions can also be RADIO
// (intercoms and SBRs) or SUPERSPACE (CentCom).
/datum/signal/subspace/vocal
	var/atom/movable/virtualspeaker/virt
	var/datum/language/language

/datum/signal/subspace/vocal/New(
	obj/source,  // the originating radio
	frequency,  // the frequency the signal is taking place on
	atom/movable/virtualspeaker/speaker,  // representation of the method's speaker
	datum/language/language,  // the language of the message
	message,  // the text content of the message
	spans,  // the list of spans applied to the message
	list/message_mods // the list of modification applied to the message. Whispering, singing, ect
)
	src.source = source
	src.frequency = frequency
	src.language = language
	virt = speaker
	var/datum/language/lang_instance = GLOB.language_datum_instances[language]
	data = list(
		"name" = speaker.name,
		"message" = message,
		"compression" = rand(35, 65),
		"language" = lang_instance.name,
		"spans" = spans,
		"mods" = message_mods
	)
	var/turf/T = get_turf(source)
	var/datum/map_zone/mapzone = T.get_map_zone()
	map_zones = list(mapzone)

/datum/signal/subspace/vocal/copy()
	var/datum/signal/subspace/vocal/copy = new(source, frequency, virt, language)
	copy.original = src
	copy.data = data.Copy()
	copy.map_zones = map_zones
	copy.wideband = wideband
	return copy

// This is the meat function for making radios hear vocal transmissions.
/datum/signal/subspace/vocal/broadcast()
	set waitfor = FALSE

	// Perform final composition steps on the message.
	var/message = copytext_char(data["message"], 1, MAX_BROADCAST_LEN)
	if(!message)
		return
	var/compression = data["compression"]
	if(compression > 0)
		message = Gibberish(message, compression >= 30)

	// Assemble the list of radios
	var/list/radios = list()
	switch (transmission_method)
		if (TRANSMISSION_SUBSPACE)
			// Reaches any radios on the virtual levels
			for(var/obj/item/radio/R in GLOB.all_radios["[frequency]"])
				if(R.can_receive(frequency, map_zones))
					radios += R

		if (TRANSMISSION_RADIO)
			// Only radios not currently in subspace mode
			for(var/obj/item/radio/R in GLOB.all_radios["[frequency]"])
				if(!R.subspace_transmission && R.can_receive(frequency, map_zones))
					radios += R

		if (TRANSMISSION_SUPERSPACE)
			// Only radios which are independent
			for(var/obj/item/radio/R in GLOB.all_radios["[frequency]"])
				if(R.independent && R.can_receive(frequency, map_zones))
					radios += R

		if (TRANSMISSION_SECTOR)
			// Newscasting
			for(var/obj/item/radio/R in GLOB.all_radios["[frequency]"])
				if(R.can_receive(frequency, map_zones))
					radios += R

	// Sound thats played on radios
	var/radiosound

	// Next, we'll have each radio play a small sound effect except for the one that broadcasted it.
	for(var/obj/item/radio/radio in radios)
		var/interference_level
		if(transmission_method == TRANSMISSION_SUPERSPACE && !(radio == virt.radio))
			interference_level = SSovermap.get_overmap_interference(radio)

		if(data["interference"])
			interference_level += data["interference"]

		if(data["sfx"])
			if(interference_level >= INTERFERENCE_LEVEL_RADIO_STATIC_SOUND)
				radiosound = 'sound/effects/overmap/heavy_interference.ogg'
			else
				radiosound = data["sfx"]

		if(radio.log)
			var/name = data["name"]
			var/list/log_details = list()
			if(interference_level >= INTERFERENCE_LEVEL_RADIO_PREVENT_ID)
				log_details["name"] = "Unknown▸"
			else
				log_details["name"] = "[name]▸"
			if(interference_level)
				var/temp_message = Gibberish(message, TRUE, interference_level/2) //max interference level should have a 50% garble chance
				log_details["message"] = "\"[html_decode(temp_message)]\""
			else
				log_details["message"] = "\"[html_decode(message)]\""

			log_details["time"] = station_time_timestamp()
			radio.loglist.Insert(1, list(log_details))
			radio.log_trim()

	// From the list of radios, find all mobs who can hear those.
	var/list/receive = get_mobs_in_radio_ranges(radios)

	// Cut out mobs with clients who are admins and have radio chatter disabled.
	for(var/mob/R in receive)
		if (R.client && R.client.holder && !(R.client.prefs.chat_toggles & CHAT_RADIO))
			receive -= R

	// Add observers who have ghost radio enabled.
	for(var/mob/dead/observer/M in GLOB.player_list)
		if(M.client.prefs.chat_toggles & CHAT_GHOSTRADIO)
			receive |= M

	// Render the message and have everybody hear it.
	// Always call this on the virtualspeaker to avoid issues.
	var/spans = data["spans"]
	var/list/message_mods = data["mods"]
	var/rendered = virt.compose_message(virt, language, message, frequency, spans)
	for(var/atom/movable/hearer in receive)
		//very sorry, i can't think of a better way to do this without altering this code too much, please let me know if you do know a way
		var/interference_level
		if(transmission_method == TRANSMISSION_SUPERSPACE)
			interference_level = SSovermap.get_overmap_interference(hearer)

		if(data["interference"])
			interference_level += data["interference"]
			///If we are an observer, we get the unaltered messsage along with a % of how much of the message is corrupted to non-ghosts.
			if(isobserver(hearer))
				var/temp_message = message + " ([data["interference"]]% interference)"
				var/temp_rendered = virt.compose_message(virt, language, message, frequency, spans)
				hearer.Hear(temp_rendered, virt, language, temp_message, frequency, spans, message_mods, radiosound)
				continue

		//If not, we jumble the message
		if(interference_level && !isobserver(hearer))
			var/temp_message = Gibberish(message, TRUE, interference_level)
			var/temp_rendered = virt.compose_message(virt, language, message, frequency, spans)
			var/atom/movable/virtualspeaker/temp_virt = new(FALSE, virt.source, virt.radio)

			//IF the interference is too high then we won't be able to tell whos talking
			if(interference_level >= INTERFERENCE_LEVEL_RADIO_PREVENT_ID)
				temp_virt.name = "Unknown"

			hearer.Hear(temp_rendered, temp_virt, language, temp_message, frequency, spans, message_mods, radiosound)
		else
			hearer.Hear(rendered, virt, language, message, frequency, spans, message_mods, radiosound)


	// This following recording is intended for research and feedback in the use of department radio channels
	if(length(receive))
		SSblackbox.LogBroadcast(frequency)

	var/spans_part = ""
	if(length(spans))
		spans_part = "(spans:"
		for(var/S in spans)
			spans_part = "[spans_part] [S]"
		spans_part = "[spans_part] ) "

	var/lang_name = data["language"]
	var/log_text = "\[[get_radio_name(frequency)]\] [spans_part]\"[message]\" (language: [lang_name])"
	if(data["interference"])
		log_text += " ([data["interference"]]% interference)"

	var/mob/source_mob = virt.source
	if(istype(source_mob))
		source_mob.log_message(log_text, LOG_TELECOMMS)
	else
		log_telecomms("[virt.source] [log_text] [loc_name(get_turf(virt.source))]")

	QDEL_IN(virt, 50)  // Make extra sure the virtualspeaker gets qdeleted
