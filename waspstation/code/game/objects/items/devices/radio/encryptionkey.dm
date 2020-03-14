
/obj/item/encryptionkey/headset_medsec
	name = "medical-security encryption key"
	icon = 'waspstation/icons/obj/radio.dmi'
	icon_state = "medsec_cypherkey"
	channels = list(RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SECURITY = 1)

/obj/item/encryptionkey/heads/lieutenant
	name = "\proper the lieutenant's encryption key"
	desc = "An encryption key for a radio headset.  Channels are as follows: :c - command."
	icon_state = "com_cypherkey"
	channels = list(RADIO_CHANNEL_COMMAND = 1)
