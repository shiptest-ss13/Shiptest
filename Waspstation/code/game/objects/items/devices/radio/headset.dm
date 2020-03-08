//Lieutenant
/obj/item/radio/headset/heads/lieutenant
	name = "\proper the lieutenant's headset"
	desc = "The headset of the Lieutenant."
	icon_state = "com_headset"
	keyslot = new /obj/item/encryptionkey/heads/lieutenant

/obj/item/radio/headset/heads/lieutenant/alt
	name = "\proper the lieutenant's bowman headset"
	desc = "The headset of the Lieutenant. Protects ears from flashbangs."
	icon_state = "com_headset_alt"
	keyslot = new /obj/item/encryptionkey/heads/lieutenant

/obj/item/radio/headset/heads/lieutenant/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

//Brig Phys
/obj/item/radio/headset/headset_medsec
	name = "medical-security radio headset"
	desc = "Used to hear how many security officers need to be stiched back together."
	icon = 'waspstation/icons/obj/radio.dmi'
	icon_state = "medsec_headset"
	keyslot = new /obj/item/encryptionkey/headset_medsec

/obj/item/radio/headset/headset_medsec/alt
	name = "medical-security bowman headset"
	desc = "Used to hear how many security officers need to be stiched back together. Protects ears from flashbangs."
	icon = 'waspstation/icons/obj/radio.dmi'
	icon_state = "medsec_headset_alt"
	keyslot = new /obj/item/encryptionkey/headset_medsec

/obj/item/radio/headset/headset_medsec/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

//Paramedic
/obj/item/radio/headset/headset_med/alt
	name = "medical bowman headset"
	desc = "A headset for the trained staff of the medbay. Protects ears from flashbangs."
	icon_state = "med_headset_alt"
	keyslot = new /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/headset_med/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))
