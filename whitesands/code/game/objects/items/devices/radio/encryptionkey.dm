/obj/item/encryptionkey/headset_medsec
	name = "medical-security encryption key"
	icon = 'whitesands/icons/obj/radio.dmi'
	icon_state = "medsec_cypherkey"
	channels = list(RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SECURITY = 1)

/obj/item/encryptionkey/solgov
	name = "\proper solgov encryption key"
	icon = 'whitesands/icons/obj/radio.dmi'
	icon_state = "solgov_cypherkey"
	independent = TRUE
	channels = list(RADIO_CHANNEL_COMMAND = 1, RADIO_CHANNEL_SOLGOV = 1)

/obj/item/encryptionkey/wideband
	name = "wideband encryption key"
	icon = 'whitesands/icons/obj/radio.dmi'
	icon_state = "wideband_cypherkey"
	channels = list(RADIO_CHANNEL_WIDEBAND = 1)
