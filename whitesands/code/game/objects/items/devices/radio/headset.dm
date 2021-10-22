//solgov
/obj/item/radio/headset/solgov
	name = "\improper SolGov Offical's headset"
	desc = "A SolGov Official's headset."
	icon = 'whitesands/icons/obj/radio.dmi'
	icon_state = "solgov_headset"
	keyslot = new /obj/item/encryptionkey/solgov

/obj/item/radio/headset/solgov/alt
	name = "\improper SolGov Officer's bowman headset"
	desc = "A SolGov Officer's headset. Protects ears from flashbangs."
	icon_state = "solgov_headset_alt"

/obj/item/radio/headset/solgov/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

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
	icon = 'whitesands/icons/obj/radio.dmi'
	icon_state = "medsec_headset"
	keyslot = new /obj/item/encryptionkey/headset_medsec

/obj/item/radio/headset/headset_medsec/alt
	name = "medical-security bowman headset"
	desc = "Used to hear how many security officers need to be stiched back together. Protects ears from flashbangs."
	icon = 'whitesands/icons/obj/radio.dmi'
	icon_state = "medsec_headset_alt"
	keyslot = new /obj/item/encryptionkey/headset_medsec

/obj/item/radio/headset/headset_medsec/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))
