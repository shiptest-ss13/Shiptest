/obj/item/radio
	icon = 'icons/obj/radio.dmi'
	name = "shortwave radio"
	icon_state = "walkietalkie"
	item_state = "radio"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	desc = "A basic handheld radio that communicates with local telecommunication networks."
	pickup_sound =  'sound/items/handling/device_pickup.ogg'
	drop_sound = 'sound/items/handling/device_drop.ogg'
	dog_fashion = /datum/dog_fashion/back
	supports_variations = VOX_VARIATION

	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = 75, /datum/material/glass = 25)
	slot_flags = ITEM_SLOT_NECK //Allows to be worn on neck so it's not eating pocket slots.
	obj_flags = USES_TGUI

	var/on = TRUE
	var/frequency = FREQ_COMMON
	///The range around the radio in which mobs can hear what it receives.
	var/canhear_range = 3
	///Tracks the number of EMPs currently stacked.
	var/emped = 0
	///It can be used for hotkeys
	var/headset = FALSE
	///Whether the radio will transmit dialogue it hears nearby.
	var/broadcasting = FALSE
	///Whether the radio is currently receiving.
	var/listening = FALSE
	///If true, the transmit wire starts cut.
	var/prison_radio = FALSE
	///Whether wires are accessible. Toggleable by screwdrivering.
	var/unscrewed = FALSE
	///If true, the radio has access to the full spectrum.
	var/freerange = FALSE
	///If true, the radio transmits and receives on subspace exclusively.
	var/subspace_transmission = FALSE
	///If true, subspace_transmission can be toggled at will.
	var/subspace_switchable = FALSE
	///Frequency lock to stop the user from untuning specialist radios.
	var/freqlock = FALSE
	///If true, broadcasts will be large and BOLD.
	var/use_command = FALSE
	///If true, use_command can be toggled at will.
	var/command = FALSE
	///If true, the UI will display the voice log for the frequency
	var/log = FALSE
	///the voice log
	var/list/loglist = list()

	///Encryption key handling
	var/obj/item/encryptionkey/keyslot
	///If true, can hear the special binary channel.
	var/translate_binary = FALSE
	///If true, can say/hear on the special CentCom channel.
	var/independent = FALSE
	// If true, can broadcast across z-levels but not recieve across z-levels.
	var/sectorwide = FALSE
	///Map from name (see communications.dm) to on/off. First entry is current department (:h)
	var/list/channels = list()
	var/list/secure_radio_connections

	var/const/FREQ_LISTENING = 1
	//FREQ_BROADCASTING = 2

/obj/item/radio/proc/set_frequency(new_frequency)
	remove_radio(src, frequency)
	frequency = add_radio(src, new_frequency)
	SEND_SIGNAL(src, COMSIG_RADIO_NEW_FREQUENCY, args)

/obj/item/radio/proc/recalculateChannels()
	channels = list()
	translate_binary = FALSE
	independent = FALSE

	if(keyslot)
		for(var/ch_name in keyslot.channels)
			if(!(ch_name in channels))
				channels[ch_name] = keyslot.channels[ch_name]

		if(keyslot.translate_binary)
			translate_binary = TRUE
		if(keyslot.independent)
			independent = TRUE

	for(var/ch_name in channels)
		secure_radio_connections[ch_name] = add_radio(src, GLOB.radiochannels[ch_name])

/obj/item/radio/Destroy()
	remove_radio_all(src) //Just to be sure
	QDEL_NULL(wires)
	QDEL_NULL(keyslot)
	return ..()

/obj/item/radio/Initialize()
	wires = new /datum/wires/radio(src)
	if(prison_radio)
		wires.cut(WIRE_TX) // OH GOD WHY
	secure_radio_connections = new
	. = ..()
	frequency = sanitize_frequency(frequency, freerange)
	set_frequency(frequency)

	for(var/ch_name in channels)
		secure_radio_connections[ch_name] = add_radio(src, GLOB.radiochannels[ch_name])

	become_hearing_sensitive(ROUNDSTART_TRAIT)

/obj/item/radio/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/empprotection, EMP_PROTECT_WIRES)

/obj/item/radio/AltClick(mob/user)
	if(headset)
		. = ..()
	else if(sectorwide == TRUE) // prevents incompatibility with broadcast cameras
		return
	else if(user.canUseTopic(src, !issilicon(user), TRUE, FALSE))
		broadcasting = !broadcasting
		to_chat(user, span_notice("You toggle broadcasting [broadcasting ? "on" : "off"]."))

/obj/item/radio/CtrlShiftClick(mob/user)
	if(headset)
		. = ..()
	else if(sectorwide == TRUE) // prevents incompatibility with broadcast cameras
		return
	else if(user.canUseTopic(src, !issilicon(user), TRUE, FALSE))
		listening = !listening
		to_chat(user, span_notice("You toggle speaker [listening ? "on" : "off"]."))

/obj/item/radio/interact(mob/user)
	if(unscrewed && !isAI(user))
		wires.interact(user)
		add_fingerprint(user)
	else
		..()

/obj/item/radio/ui_state(mob/user)
	return GLOB.inventory_state

/obj/item/radio/ui_interact(mob/user, datum/tgui/ui, datum/ui_state/state)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Radio", name)
		if(state)
			ui.set_state(state)
		ui.open()

/obj/item/radio/ui_data(mob/user)
	var/list/data = list()

	data["broadcasting"] = broadcasting
	data["listening"] = listening
	data["frequency"] = frequency
	data["minFrequency"] = freerange ? MIN_FREE_FREQ : MIN_FREQ
	data["maxFrequency"] = freerange ? MAX_FREE_FREQ : MAX_FREQ
	data["freqlock"] = freqlock
	data["channels"] = list()
	for(var/channel in channels)
		data["channels"][channel] = channels[channel] & FREQ_LISTENING
	data["command"] = command
	data["useCommand"] = use_command
	data["subspace"] = subspace_transmission
	data["subspaceSwitchable"] = subspace_switchable
	data["chatlog"] = log
	data["chatloglist"] = loglist
	data["headset"] = FALSE

	return data

/obj/item/radio/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	if(isliving(usr) && in_range(src, usr))
		playsound(src, "button", 10)
	switch(action)
		if("frequency")
			if(freqlock)
				return
			var/tune = params["tune"]
			var/adjust = text2num(params["adjust"])
			if(adjust)
				tune = frequency + adjust * 10
				. = TRUE
			else if(text2num(tune) != null)
				tune = tune * 10
				. = TRUE
			if(.)
				set_frequency(sanitize_frequency(tune, freerange))
		if("listen")
			listening = !listening
			. = TRUE
		if("broadcast")
			broadcasting = !broadcasting
			. = TRUE
		if("channel")
			var/channel = params["channel"]
			if(!(channel in channels))
				return
			if(channels[channel] & FREQ_LISTENING)
				channels[channel] &= ~FREQ_LISTENING
			else
				channels[channel] |= FREQ_LISTENING
			. = TRUE
		if("command")
			use_command = !use_command
			. = TRUE
		if("subspace")
			if(subspace_switchable)
				subspace_transmission = !subspace_transmission
				if(!subspace_transmission)
					channels = list()
				else
					recalculateChannels()
				. = TRUE

/obj/item/radio/talk_into(atom/movable/M, message, channel, list/spans, datum/language/language, list/message_mods)
	if(SEND_SIGNAL(M, COMSIG_MOVABLE_USING_RADIO, src) & COMPONENT_CANNOT_USE_RADIO)
		return
	if(SEND_SIGNAL(src, COMSIG_RADIO_NEW_MESSAGE, M, message, channel) & COMPONENT_CANNOT_USE_RADIO)
		return
	if(!spans)
		spans = list(M.speech_span)
	if(!language)
		language = M.get_selected_language()
	if((initial(language?.flags) & SIGNED_LANGUAGE) && !HAS_TRAIT(M, TRAIT_CAN_SIGN_ON_COMMS))
		return
	INVOKE_ASYNC(src, PROC_REF(talk_into_impl), M, message, channel, spans.Copy(), language, message_mods)
	return ITALICS | REDUCE_RANGE

/obj/item/radio/proc/talk_into_impl(atom/movable/M, message, channel, list/spans, datum/language/language, list/message_mods)
	if(!on)
		return // the device has to be on
	if(!M || !message)
		return
	if(wires.is_cut(WIRE_TX))  // Permacell and otherwise tampered-with radios
		return
	if(!M.IsVocal())
		return

	if(use_command)
		spans |= SPAN_COMMAND

	/*
	Roughly speaking, radios attempt to make a subspace transmission (which
	is received, processed, and rebroadcast by the telecomms satellite) and
	if that fails, they send a mundane radio transmission.

	Headsets cannot send/receive mundane transmissions, only subspace.
	Syndicate radios can hear transmissions on all well-known frequencies.
	CentCom radios can hear the CentCom frequency no matter what.
	*/

	// From the channel, determine the frequency and get a reference to it.
	var/freq
	if(channel && channels && channels.len > 0)
		if(channel == MODE_DEPARTMENT)
			channel = channels[1]
		freq = secure_radio_connections[channel]
		if (!channels[channel]) // if the channel is turned off, don't broadcast
			return
	else
		freq = frequency
		channel = null

	// Nearby active jammers prevent the message from transmitting
	var/turf/position = get_turf(src)
	for(var/obj/item/jammer/jammer in GLOB.active_jammers)
		var/turf/jammer_turf = get_turf(jammer)
		if(position?.virtual_z() == jammer_turf.virtual_z() && (get_dist(position, jammer_turf) <= jammer.range))
			return

	// Determine the identity information which will be attached to the signal.
	var/atom/movable/virtualspeaker/speaker = new(null, M, src)

	// Check for the overmap's interference level
	var/interference_level = SSovermap.get_overmap_interference(src)

	// Construct the signal
	var/datum/signal/subspace/vocal/signal = new(src, freq, speaker, language, message, spans, message_mods)
	signal.data["interference"] = interference_level
	signal.data["sfx"] = 'sound/effects/radio_chatter.ogg'

	// Independent radios, on the CentCom frequency, reach all independent radios
	if (independent && (freq == FREQ_CENTCOM || freq == FREQ_WIDEBAND))
		signal.data["compression"] = 0
		signal.transmission_method = TRANSMISSION_SUPERSPACE
		signal.map_zones = list(0)  // reaches all Z-levels
		signal.data["sfx"] = 'sound/effects/overmap/wideband.ogg'
		signal.broadcast()
		return

	// News Broadcast Radios and Similar, for devices you want to transmit across z-levels but not recieve across.
	if (sectorwide)
		signal.data["compression"] = 0
		signal.transmission_method = TRANSMISSION_SECTOR
		signal.map_zones = list(0)  // reaches all Z-levels
		signal.broadcast()
		return

	// All radios make an attempt to use the subspace system first
	signal.send_to_receivers()

	// If the radio is subspace-only, that's all it can do
	if (subspace_transmission)
		return

	// Non-subspace radios will check in a couple of seconds, and if the signal
	// was never received, send a mundane broadcast (no headsets).
	addtimer(CALLBACK(src, PROC_REF(backup_transmission), signal), 20)

/obj/item/radio/proc/backup_transmission(datum/signal/subspace/vocal/signal)
	var/turf/T = get_turf(src)
	var/datum/map_zone/mapzone = T.get_map_zone()
	if (signal.data["done"] && (mapzone in signal.map_zones))
		return

	// Okay, the signal was never processed, send a mundane broadcast.
	signal.data["compression"] = 0
	signal.transmission_method = TRANSMISSION_RADIO
	signal.map_zones = list(mapzone)
	signal.broadcast()

/obj/item/radio/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list())
	. = ..()
	if(radio_freq || !broadcasting || get_dist(src, speaker) > canhear_range)
		return
	var/filtered_mods = list()
	if (message_mods[MODE_CUSTOM_SAY_EMOTE])
		filtered_mods[MODE_CUSTOM_SAY_EMOTE] = message_mods[MODE_CUSTOM_SAY_EMOTE]
		filtered_mods[MODE_CUSTOM_SAY_ERASE_INPUT] = message_mods[MODE_CUSTOM_SAY_ERASE_INPUT]

	if(message_mods[RADIO_EXTENSION] == MODE_L_HAND || message_mods[RADIO_EXTENSION] == MODE_R_HAND)
		// try to avoid being heard double
		if (loc == speaker && ismob(speaker))
			var/mob/M = speaker
			var/idx = M.get_held_index_of_item(src)
			// left hands are odd slots
			if (idx && (idx % 2) == (message_mods[RADIO_EXTENSION] == MODE_L_HAND))
				return

	talk_into(speaker, raw_message, , spans, language=message_language, message_mods = filtered_mods)

// Checks if this radio can receive on the given frequency.
/obj/item/radio/proc/can_receive(freq, map_zones)
	// deny checks
	if (!on || !listening || wires.is_cut(WIRE_RX))
		return FALSE
	if (freq == FREQ_CENTCOM)
		return independent  // hard-ignores the z-level check
	if (!(0 in map_zones))
		var/turf/position = get_turf(src)
		if(!position)
			return FALSE
		var/datum/map_zone/mapzone = position.get_map_zone()
		if(!(mapzone in map_zones))
			return FALSE

	// allow checks: are we listening on that frequency?
	if (freq == frequency)
		return TRUE
	for(var/ch_name in channels)
		if(channels[ch_name] & FREQ_LISTENING)
			//the GLOB.radiochannels list is located in communications.dm
			if(GLOB.radiochannels[ch_name] == text2num(freq))
				return TRUE
	return FALSE


/obj/item/radio/examine(mob/user)
	. = ..()
	if (frequency && in_range(src, user))
		. += span_notice("It is set to broadcast over the [frequency/10] frequency.")
	if (unscrewed)
		. += span_notice("It can be attached and modified.")
	else
		. += span_notice("It cannot be modified or attached.")
	if (in_range(src, user)&& !headset)
		. += span_info("Ctrl-Shift-click on the [name] to toggle speaker.<br/>Alt-click on the [name] to toggle broadcasting.")

/obj/item/radio/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if(W.tool_behaviour == TOOL_SCREWDRIVER)
		unscrewed = !unscrewed
		if(unscrewed)
			to_chat(user, span_notice("The radio can now be attached and modified!"))
		else
			to_chat(user, span_notice("The radio can no longer be modified or attached!"))
	else
		return ..()

/obj/item/radio/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	emped++ //There's been an EMP; better count it
	var/curremp = emped //Remember which EMP this was
	if (listening && ismob(loc))	// if the radio is turned on and on someone's person they notice
		to_chat(loc, span_warning("\The [src] overloads."))
	broadcasting = FALSE
	listening = FALSE
	for (var/ch_name in channels)
		channels[ch_name] = 0
	on = FALSE
	addtimer(CALLBACK(src, PROC_REF(end_emp_effect), curremp), 200)

/obj/item/radio/proc/end_emp_effect(curremp)
	if(emped != curremp) //Don't fix it if it's been EMP'd again
		return FALSE
	emped = FALSE
	on = TRUE
	return TRUE

/obj/item/radio/proc/log_trim()
	if(loglist.len <= 50)
		return
	loglist.Cut(51)

///////////////////////////////
//////////Borg Radios//////////
///////////////////////////////
//Giving borgs their own radio to have some more room to work with -Sieve

/obj/item/radio/borg
	name = "cyborg radio"
	subspace_switchable = TRUE
	dog_fashion = null

/obj/item/radio/borg/Initialize(mapload)
	. = ..()

/obj/item/radio/borg/syndicate
	keyslot = new /obj/item/encryptionkey/syndicate

/obj/item/radio/borg/syndicate/Initialize()
	. = ..()
	set_frequency(FREQ_SYNDICATE)

/obj/item/radio/borg/attackby(obj/item/W, mob/user, params)

	if(W.tool_behaviour == TOOL_SCREWDRIVER)
		if(keyslot)
			for(var/ch_name in channels)
				SSradio.remove_object(src, GLOB.radiochannels[ch_name])
				secure_radio_connections[ch_name] = null


			if(keyslot)
				var/turf/T = get_turf(user)
				if(T)
					keyslot.forceMove(T)
					keyslot = null

			recalculateChannels()
			to_chat(user, span_notice("You pop out the encryption key in the radio."))

		else
			to_chat(user, span_warning("This radio doesn't have any encryption keys!"))

	else if(istype(W, /obj/item/encryptionkey/))
		if(keyslot)
			to_chat(user, span_warning("The radio can't hold another key!"))
			return

		if(!keyslot)
			if(!user.transferItemToLoc(W, src))
				return
			keyslot = W

		recalculateChannels()

/obj/item/radio/old
	name = "old radio"
	icon_state = "radio"
	desc = "An old handheld radio. You could use it, if you really wanted to."
