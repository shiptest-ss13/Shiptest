/obj/item/encryptionkey
	name = "standard encryption key"
	desc = "An encryption key for a radio headset."
	icon = 'icons/obj/radio.dmi'
	icon_state = "cypherkey"
	w_class = WEIGHT_CLASS_TINY
	var/translate_binary = FALSE
	var/syndie = FALSE
	var/independent = FALSE
	var/list/channels = list()

/obj/item/encryptionkey/Initialize()
	. = ..()
	if(!channels.len)
		desc = "An encryption key for a radio headset.  Has no special codes in it. You should probably tell a coder!"

/obj/item/encryptionkey/examine(mob/user)
	. = ..()
	if(LAZYLEN(channels))
		var/list/examine_text_list = list()
		for(var/i in channels)
			examine_text_list += "[GLOB.channel_tokens[i]] - [lowertext(i)]"

		. += span_notice("It can access the following channels; [jointext(examine_text_list, ", ")].")

/obj/item/encryptionkey/syndicate
	name = "syndicate encryption key"
	icon_state = "syn_cypherkey"
	channels = list(RADIO_CHANNEL_SYNDICATE = 1)

/obj/item/encryptionkey/syndicate/cybersun
	name = "cybersun encryption key"
	channels = list(RADIO_CHANNEL_CYBERSUN = 1)

/obj/item/encryptionkey/syndicate/ngr
	name = "new gorlex encryption key"
	channels = list(RADIO_CHANNEL_NGR = 1)

/obj/item/encryptionkey/syndicate/suns
	name = "SUNS encryption key"
	icon_state = "suns_cypherkey"
	channels = list(RADIO_CHANNEL_SUNS = 1)

/obj/item/encryptionkey/binary
	name = "binary translator key"
	icon_state = "bin_cypherkey"
	translate_binary = TRUE

//Shiptest edits start

/obj/item/encryptionkey/nanotrasen
	name = "nanotrasen encryption key"
	icon_state = "hop_cypherkey"
	channels = list(RADIO_CHANNEL_NANOTRASEN = 1)

/obj/item/encryptionkey/minutemen
	name = "minutemen encryption key"
	icon_state = "cmm_cypherkey"
	channels = list(RADIO_CHANNEL_MINUTEMEN = 1)

/obj/item/encryptionkey/pgf
	name = "pgf encryption key"
	icon_state = "bin_cypherkey"
	channels = list(RADIO_CHANNEL_PGF = 1)

/obj/item/encryptionkey/inteq
	name = "inteq encryption key"
	icon_state = "irmg_cypherkey"
	channels = list(RADIO_CHANNEL_INTEQ = 1)

/obj/item/encryptionkey/pirate
	name = "pirate encryption key"
	icon_state = "pirate_cypherkey"
	channels = list(RADIO_CHANNEL_PIRATE = 1)

/obj/item/encryptionkey/headset_com
	name = "command radio encryption key"
	icon_state = "com_cypherkey"
	channels = list(RADIO_CHANNEL_EMERGENCY = 1)

/obj/item/encryptionkey/heads/captain
	name = "\proper the captain's encryption key"
	icon_state = "cap_cypherkey"
	channels = list(RADIO_CHANNEL_EMERGENCY = 1, RADIO_CHANNEL_WIDEBAND = 0) //WS edit - Wideband radio

/obj/item/encryptionkey/headset_cent
	name = "\improper CentCom radio encryption key"
	icon_state = "cent_cypherkey"
	independent = TRUE
	channels = list(RADIO_CHANNEL_CENTCOM = 1, RADIO_CHANNEL_WIDEBAND = 0) //WS edit- Wideband Radio

/obj/item/encryptionkey/ai //ported from NT, this goes 'inside' the AI.
	channels = list(RADIO_CHANNEL_EMERGENCY = 1)

/obj/item/encryptionkey/solgov
	name = "\improper SolGov encryption key"
	icon = 'icons/obj/radio.dmi'
	icon_state = "solgov_cypherkey"
	channels = list(RADIO_CHANNEL_SOLGOV = 1)

/obj/item/encryptionkey/wideband
	name = "wideband encryption key"
	icon = 'icons/obj/radio.dmi'
	icon_state = "wideband_cypherkey"
	channels = list(RADIO_CHANNEL_WIDEBAND = 1)
