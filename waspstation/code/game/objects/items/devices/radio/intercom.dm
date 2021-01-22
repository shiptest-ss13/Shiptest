/obj/item/radio/intercom/wideband
	name = "wideband relay"
	desc = "A low-gain reciever capable of sending and recieving wideband subspace messages."
	icon_state = "intercom-wideband"
	canhear_range = 3
	keyslot = new /obj/item/encryptionkey/wideband
	independent = TRUE

/obj/item/radio/intercom/wideband/unscrewed
	unscrewed = TRUE

/obj/item/radio/intercom/wideband/Initialize(mapload, ndir, building)
	. = ..()
	set_frequency(FREQ_WIDEBAND)
	freqlock = TRUE

/obj/item/radio/intercom/wideband/recalculateChannels()
	. = ..()
	independent = TRUE

/obj/item/wallframe/intercom/wideband
	name = "wideband relay frame"
	desc = "A detached wideband relay. Attach to a wall and screw it in to use."
	result_path = /obj/item/radio/intercom/wideband/unscrewed
