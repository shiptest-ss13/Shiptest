// Used for translating channels to tokens on examination
GLOBAL_LIST_INIT(channel_tokens, list(
	RADIO_CHANNEL_COMMON = RADIO_KEY_COMMON,
	RADIO_CHANNEL_COMMAND = RADIO_TOKEN_COMMAND,
	RADIO_CHANNEL_CENTCOM = RADIO_TOKEN_CENTCOM,
	RADIO_CHANNEL_SOLGOV = RADIO_TOKEN_SOLGOV,		//WS Edit - SolGov Rep
	RADIO_CHANNEL_SYNDICATE = RADIO_TOKEN_SYNDICATE,
	RADIO_CHANNEL_NANOTRASEN = RADIO_TOKEN_NANOTRASEN, //Shiptest edits - faction channels, removed department channels
	RADIO_CHANNEL_MINUTEMEN = RADIO_TOKEN_MINUTEMEN,
	RADIO_CHANNEL_INTEQ = RADIO_TOKEN_INTEQ,
	RADIO_CHANNEL_PIRATE = RADIO_TOKEN_PIRATE,
	MODE_BINARY = MODE_TOKEN_BINARY,
	RADIO_CHANNEL_AI_PRIVATE = RADIO_TOKEN_AI_PRIVATE
))

/obj/item/radio/headset
	name = "radio headset"
	desc = "An updated, modular intercom that fits over the head. Takes encryption keys."
	icon_state = "headset"
	item_state = "headset"
	custom_materials = list(/datum/material/iron=75)
	subspace_transmission = TRUE
	headset = TRUE
	canhear_range = 0 // can't hear headsets from very far away

	slot_flags = ITEM_SLOT_EARS
	var/obj/item/encryptionkey/keyslot2 = null
	dog_fashion = null
	supports_variations = VOX_VARIATION

/obj/item/radio/headset/examine(mob/user)
	. = ..()

	if(item_flags & IN_INVENTORY && loc == user)
		// construction of frequency description
		var/list/avail_chans = list("Use [RADIO_KEY_COMMON] for the currently tuned frequency")
		if(translate_binary)
			avail_chans += "use [MODE_TOKEN_BINARY] for [MODE_BINARY]"
		if(length(channels))
			for(var/i in 1 to length(channels))
				if(i == 1)
					avail_chans += "use [MODE_TOKEN_DEPARTMENT] or [GLOB.channel_tokens[channels[i]]] for [lowertext(channels[i])]"
				else
					avail_chans += "use [GLOB.channel_tokens[channels[i]]] for [lowertext(channels[i])]"
		. += "<span class='notice'>A small screen on the headset displays the following available frequencies:\n[english_list(avail_chans)].</span>"

		if(command)
			. += "<span class='info'>Alt-click to toggle the high-volume mode.</span>"
	else
		. += "<span class='notice'>A small screen on the headset flashes, it's too small to read without holding or wearing the headset.</span>"

/obj/item/radio/headset/Initialize()
	. = ..()
	recalculateChannels()

/obj/item/radio/headset/Destroy()
	QDEL_NULL(keyslot2)
	return ..()

/obj/item/radio/headset/talk_into(mob/living/M, message, channel, list/spans, datum/language/language, list/message_mods)
	if (!listening)
		return ITALICS | REDUCE_RANGE
	return ..()

/obj/item/radio/headset/can_receive(freq, map_zones, AIuser)
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		if(H.ears == src)
			return ..(freq, map_zones)
	else if(AIuser)
		return ..(freq, map_zones)
	return FALSE

/obj/item/radio/headset/ui_data(mob/user)
	. = ..()
	.["headset"] = TRUE

/obj/item/radio/headset/alt
	name = "bowman headset"
	desc = "An updated, modular intercom that fits over the head. Protects ears from flashbangs."
	icon_state = "headset_alt"
	item_state = "headset_alt"

/obj/item/radio/headset/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

//syndicate
/obj/item/radio/headset/syndicate
	name = "syndicate headset"
	desc = "A headset worn by members of the various Syndicate splinters on the frontier."
	icon_state = "syndie_headset"
	item_state = "syndie_headset"
	keyslot = new /obj/item/encryptionkey/syndicate

/obj/item/radio/headset/syndicate/captain
	name = "syndicate leader headset"
	desc = "A headset worn by officers of the various Syndicate splinters on the frontier."
	command = TRUE
	keyslot2 = new /obj/item/encryptionkey/heads/captain

/obj/item/radio/headset/syndicate/alt
	name = "syndicate bowman headset"
	desc = "A headset worn by members of the various Syndicate splinters on the frontier. Protects ears from flashbangs."
	icon_state = "syndie_headset_alt"
	item_state = "syndie_headset_alt"

/obj/item/radio/headset/syndicate/alt/captain
	name = "syndicate leader bowman headset"
	desc = "A headset worn by officers of the various Syndicate splinters on the frontier. Protects ears from flashbangs."
	command = TRUE
	keyslot2 = new /obj/item/encryptionkey/heads/captain

/obj/item/radio/headset/syndicate/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/syndicate/alt/leader
	name = "team leader headset"
	command = TRUE

//nanotrasen
/obj/item/radio/headset/nanotrasen
	name = "nanotrasen radio headset"
	desc = "Worn proudly by the battered remnants of Nanotrasen's frontier holdings."
	icon_state = "nanotrasen_headset"
	keyslot = new /obj/item/encryptionkey/nanotrasen

/obj/item/radio/headset/nanotrasen/captain
	name = "nanotrasen captain's radio headset"
	desc = "Worn proudly by Nanotrasen's remaining captains on the frontier."
	keyslot2 = new /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/nanotrasen/alt
	name = "nanotrasen bowman headset"
	desc = "Worn proudly by the battered remnants of Nanotrasen's frontier holdings. Protects ears from flashbangs."
	icon_state = "nanotrasen_headset_alt"
	item_state = "nanotrasen_headset_alt"

/obj/item/radio/headset/nanotrasen/alt/captain
	name = "nanotrasen captain's bowman headset"
	desc = "Worn proudly by Nanotrasen's remaining captains on the frontier. Protects ears from flashbangs."
	keyslot2 = new /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/nanotrasen/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

//minutemen
/obj/item/radio/headset/minutemen
	name = "minutemen radio headset"
	desc = "Used by militias flying the five stars of the Colonial Minutemen."
	icon_state = "cmm_headset"
	keyslot = new /obj/item/encryptionkey/minutemen

/obj/item/radio/headset/minutemen/captain
	name = "minuteman officer radio headset"
	desc = "Used by the Colonial Minutemen's enlisted officers."
	keyslot2 = new /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/minutemen/alt
	name = "minutemen bowman headset"
	desc = "Used by militias flying the five stars of the Colonial Minutemen. Protects ears from flashbangs."
	icon_state = "cmm_headset_alt"
	item_state = "cmm_headset_alt"

/obj/item/radio/headset/minutemen/alt/captain
	name = "minuteman officer bowman headset"
	desc = "Used by the Colonial Minutemen's enlisted officers. Protects ears from flashbangs."
	keyslot2 = new /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/minutemen/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

//inteq
/obj/item/radio/headset/inteq
	name = "inteq radio headset"
	desc = "This is used by Inteq Risk Management Group's mercenaries."
	icon_state = "inteq_headset"
	keyslot = new /obj/item/encryptionkey/inteq

/obj/item/radio/headset/inteq/captain
	name = "vanguard radio headset"
	desc = "Used by Inteq Risk Management Group's elite vanguards."
	keyslot2 = new /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/inteq/alt
	name = "inteq bowman headset"
	desc = "This is used by Inteq Risk Management Group's mercenaries. Protects ears from flashbangs."
	icon_state = "inteq_headset_alt"
	item_state = "inteq_headset_alt"

/obj/item/radio/headset/inteq/alt/captain
	name = "vanguard bowman headset"
	desc = "Used by Inteq Risk Management Group's elite vanguards. Protects ears from flashbangs."
	keyslot2 = new /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/inteq/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

//pirate
/obj/item/radio/headset/pirate
	name = "pirate radio headset"
	desc = "Used to sing shanties across the vast emptiness of space, and complain about Minuteman patrols."
	icon_state = "pirate_headset"
	keyslot = new /obj/item/encryptionkey/pirate

/obj/item/radio/headset/pirate/captain
	name = "pirate captain radio headset"
	desc = "The headset of a bloodthirsty pirate captain."
	keyslot2 = new /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/pirate/alt
	name = "pirate bowman headset"
	desc = "Used to sing shanties across the vast emptiness of space, and complain about Minuteman patrols. Protects ears from flashbangs."
	icon_state = "pirate_headset_alt"
	item_state = "pirate_headset_alt"

/obj/item/radio/headset/pirate/alt/captain
	name = "pirate captain bowman headset"
	desc = "The headset of a bloodthirsty pirate captain. Protects ears from flashbangs."
	keyslot2 = new /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/pirate/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

//solgov
/obj/item/radio/headset/solgov
	name = "\improper SolGov headset"
	desc = "Worn by bureaucrats and, occasionally, Sonnensoldneren."
	icon_state = "solgov_headset"
	keyslot = new /obj/item/encryptionkey/solgov

/obj/item/radio/headset/solgov/captain
	name = "\improper SolGov official radio headset"
	desc = "Worn by various officials and leaders from SolGov. Fancy hat not included."
	keyslot2 = new /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/solgov/alt
	name = "\improper SolGov bowman headset"
	desc = "Worn by bureaucrats and, occasionally, Sonnensoldneren. Protects ears from flashbangs."
	icon_state = "solgov_headset_alt"

/obj/item/radio/headset/solgov/alt/captain
	name = "\improper SolGov official bowman headset"
	desc = "Worn by various officials and leaders from SolGov. Fancy hat not included. Protects ears from flashbangs."
	keyslot2 = new /obj/item/encryptionkey/heads/captain
	command = TRUE

/obj/item/radio/headset/solgov/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

//independent
/obj/item/radio/headset/headset_com
	name = "command radio headset"
	desc = "An officer's headset."
	icon_state = "com_headset"
	keyslot = new /obj/item/encryptionkey/headset_com

/obj/item/radio/headset/headset_com/alt
	name = "command bowman headset"
	desc = "An officer's headset. Protects ears from flashbangs."
	icon_state = "com_headset_alt"
	item_state = "com_headset_alt"

/obj/item/radio/headset/headset_com/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/heads
	command = TRUE
	keyslot = new /obj/item/encryptionkey/headset_com

/obj/item/radio/headset/heads/captain
	name = "captain's headset"
	desc = "Dresses the ears of independent ship captains across the frontier."
	icon_state = "com_headset"
	keyslot = new /obj/item/encryptionkey/heads/captain

/obj/item/radio/headset/heads/captain/alt
	name = "captain's bowman headset"
	desc = "Dresses the ears of independent ship captains across the frontier. Protects ears from flashbangs."
	icon_state = "com_headset_alt"
	item_state = "com_headset_alt"

/obj/item/radio/headset/heads/captain/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

//special headsets
/obj/item/radio/headset/binary
/obj/item/radio/headset/binary/Initialize()
	. = ..()
	qdel(keyslot)
	keyslot = new /obj/item/encryptionkey/binary
	recalculateChannels()

/obj/item/radio/headset/headset_cent
	name = "\improper CentCom headset"
	desc = "A headset used by representatives and agents of Central Command."
	icon_state = "cent_headset"
	keyslot = new /obj/item/encryptionkey/headset_com
	keyslot2 = new /obj/item/encryptionkey/headset_cent

/obj/item/radio/headset/headset_cent/empty
	keyslot = null
	keyslot2 = null

/obj/item/radio/headset/headset_cent/commander
	keyslot = new /obj/item/encryptionkey/heads/captain

/obj/item/radio/headset/headset_cent/alt
	name = "\improper CentCom bowman headset"
	desc = "A headset especially for emergency response personnel. Protects ears from flashbangs."
	icon_state = "cent_headset_alt"
	item_state = "cent_headset_alt"
	keyslot = null

/obj/item/radio/headset/headset_cent/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/silicon/pai
	name = "\proper mini Integrated Subspace Transceiver "
	subspace_transmission = FALSE


/obj/item/radio/headset/silicon/ai
	name = "\proper Integrated Subspace Transceiver "
	keyslot2 = new /obj/item/encryptionkey/ai
	command = TRUE

/obj/item/radio/headset/silicon/can_receive(freq, map_zones)
	return ..(freq, map_zones, TRUE)

//normal headsets below. encryption keys removed, so these are obsolete.
/obj/item/radio/headset/headset_sec
	name = "security radio headset"
	desc = "This is used by your elite security force."
	icon_state = "sec_headset"

/obj/item/radio/headset/headset_sec/alt
	name = "security bowman headset"
	desc = "This is used by your elite security force. Protects ears from flashbangs."
	icon_state = "sec_headset_alt"
	item_state = "sec_headset_alt"

/obj/item/radio/headset/headset_sec/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/headset_medsec
	name = "medical-security radio headset"
	desc = "Used to hear how many security officers need to be stitched back together."
	icon_state = "medsec_headset"

/obj/item/radio/headset/headset_medsec/alt
	name = "medical-security bowman headset"
	desc = "Used to hear how many security officers need to be stiched back together. Protects ears from flashbangs."
	icon_state = "medsec_headset_alt"

/obj/item/radio/headset/headset_medsec/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/headset_eng
	name = "engineering radio headset"
	desc = "When the engineers wish to chat like girls."
	icon_state = "eng_headset"

/obj/item/radio/headset/headset_rob
	name = "robotics radio headset"
	desc = "Made specifically for the roboticists, who cannot decide between departments."
	icon_state = "rob_headset"

/obj/item/radio/headset/headset_med
	name = "medical radio headset"
	desc = "A headset for the trained staff of the medbay."
	icon_state = "med_headset"

/obj/item/radio/headset/headset_sci
	name = "science radio headset"
	desc = "A sciency headset. Like usual."
	icon_state = "sci_headset"

/obj/item/radio/headset/headset_medsci
	name = "medical research radio headset"
	desc = "A headset that is a result of the mating between medical and science."
	icon_state = "medsci_headset"

/obj/item/radio/headset/headset_srvsec
	name = "law and order headset"
	desc = "In the criminal justice headset, the encryption key represents two separate but equally important groups. Sec, who investigate crime, and Service, who provide services. These are their comms."
	icon_state = "srvsec_headset"

/obj/item/radio/headset/headset_srvmed
	name = "psychology headset"
	desc = "A headset allowing the wearer to communicate with medbay and service."
	icon_state = "med_headset"

/obj/item/radio/headset/heads/lieutenant
	name = "lieutenant's headset"
	desc = "A lieutenant's headset."
	icon_state = "com_headset"

/obj/item/radio/headset/heads/lieutenant/alt
	name = "lieutenant's bowman headset"
	desc = "A lieutenant's headset. Protects ears from flashbangs."
	icon_state = "com_headset_alt"

/obj/item/radio/headset/heads/lieutenant/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/heads/rd
	name = "\proper the research director's headset"
	desc = "Headset of the fellow who keeps society marching towards technological singularity."
	icon_state = "com_headset"

/obj/item/radio/headset/heads/hos
	name = "\proper the head of security's headset"
	desc = "The headset of the man in charge of keeping order and protecting the innocent."
	icon_state = "com_headset"

/obj/item/radio/headset/heads/hos/alt
	name = "\proper the head of security's bowman headset"
	desc = "The headset of the man in charge of keeping order and protecting the innocent. Protects ears from flashbangs."
	icon_state = "com_headset_alt"
	item_state = "com_headset_alt"

/obj/item/radio/headset/heads/hos/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/heads/ce
	name = "\proper the chief engineer's headset"
	desc = "The headset of the guy in charge of keeping essential systems powered and undamaged."
	icon_state = "com_headset"

/obj/item/radio/headset/heads/cmo
	name = "\proper the chief medical officer's headset"
	desc = "The headset of a highly trained medical chief."
	icon_state = "com_headset"

/obj/item/radio/headset/heads/head_of_personnel
	name = "\proper the head of personnel's headset"
	desc = "The headset of the guy who will one day be captain."
	icon_state = "com_headset"

/obj/item/radio/headset/headset_cargo
	name = "supply radio headset"
	desc = "A headset used by the QM and his slaves."
	icon_state = "cargo_headset"

/obj/item/radio/headset/headset_cargo/mining
	name = "mining radio headset"
	desc = "Headset used by shaft miners."
	icon_state = "mine_headset"

/obj/item/radio/headset/headset_srv
	name = "service radio headset"
	desc = "Headset used by the service staff, tasked with keeping the endless workforces of the galaxy full, happy and clean."
	icon_state = "srv_headset"

//interactions

/obj/item/radio/headset/attackby(obj/item/W, mob/user, params)
	user.set_machine(src)

	if(W.tool_behaviour == TOOL_SCREWDRIVER)
		if(keyslot || keyslot2)
			for(var/ch_name in channels)
				SSradio.remove_object(src, GLOB.radiochannels[ch_name])
				secure_radio_connections[ch_name] = null

			if(keyslot)
				user.put_in_hands(keyslot)
				keyslot = null
			if(keyslot2)
				user.put_in_hands(keyslot2)
				keyslot2 = null

			recalculateChannels()
			to_chat(user, "<span class='notice'>You pop out the encryption keys in the headset.</span>")

		else
			to_chat(user, "<span class='warning'>This headset doesn't have any unique encryption keys! How useless...</span>")

	else if(istype(W, /obj/item/encryptionkey))
		if(keyslot && keyslot2)
			to_chat(user, "<span class='warning'>The headset can't hold another key!</span>")
			return

		if(!keyslot)
			if(!user.transferItemToLoc(W, src))
				return
			keyslot = W

		else
			if(!user.transferItemToLoc(W, src))
				return
			keyslot2 = W


		recalculateChannels()
	else
		return ..()


/obj/item/radio/headset/recalculateChannels()
	..()
	if(keyslot2)
		for(var/ch_name in keyslot2.channels)
			if(!(ch_name in src.channels))
				channels[ch_name] = keyslot2.channels[ch_name]

		if(keyslot2.translate_binary)
			translate_binary = TRUE
		if (keyslot2.independent)
			independent = TRUE

	for(var/ch_name in channels)
		secure_radio_connections[ch_name] = add_radio(src, GLOB.radiochannels[ch_name])

/obj/item/radio/headset/AltClick(mob/living/user)
	if(!istype(user) || !Adjacent(user) || user.incapacitated())
		return
	if (command)
		use_command = !use_command
		to_chat(user, "<span class='notice'>You toggle high-volume mode [use_command ? "on" : "off"].</span>")
