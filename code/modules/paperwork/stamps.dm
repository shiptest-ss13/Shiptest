/obj/item/stamp
	name = "\improper GRANTED rubber stamp"
	desc = "A rubber stamp for stamping important documents."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "stamp-ok"
	item_state = "stamp"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=60)
	pressure_resistance = 2
	attack_verb = list("stamped")


/obj/item/stamp/get_writing_implement_details()
	var/datum/asset/spritesheet/sheet = get_asset_datum(/datum/asset/spritesheet/simple/paper)
	return list(
		interaction_mode = MODE_STAMPING,
		stamp_icon_state = icon_state,
		stamp_class = sheet.icon_class_name(icon_state)
	)

/obj/item/stamp/qm
	name = "quartermaster's rubber stamp"
	icon_state = "stamp-qm"
	dye_color = DYE_QM

/obj/item/stamp/law
	name = "law office's rubber stamp"
	icon_state = "stamp-law"
	dye_color = DYE_LAW

/obj/item/stamp/captain
	name = "captain's rubber stamp"
	icon_state = "stamp-cap"
	dye_color = DYE_CAPTAIN

/obj/item/stamp/head_of_personnel
	name = "head of personnel's rubber stamp"
	icon_state = "stamp-hop"
	dye_color = DYE_FO

/obj/item/stamp/hos
	name = "head of security's rubber stamp"
	icon_state = "stamp-hos"
	dye_color = DYE_HOS

/obj/item/stamp/ce
	name = "chief engineer's rubber stamp"
	icon_state = "stamp-ce"
	dye_color = DYE_CE

/obj/item/stamp/rd
	name = "research director's rubber stamp"
	icon_state = "stamp-rd"
	dye_color = DYE_RD

/obj/item/stamp/cmo
	name = "chief medical officer's rubber stamp"
	icon_state = "stamp-cmo"
	dye_color = DYE_CMO

/obj/item/stamp/denied
	name = "\improper DENIED rubber stamp"
	icon_state = "stamp-deny"
	dye_color = DYE_REDCOAT

/obj/item/stamp/clown
	name = "clown's rubber stamp"
	icon_state = "stamp-clown"
	dye_color = DYE_CLOWN

/obj/item/stamp/mime
	name = "mime's rubber stamp"
	icon_state = "stamp-mime"
	dye_color = DYE_MIME

/obj/item/stamp/chap
	name = "chaplain's rubber stamp"
	icon_state = "stamp-chap"
	dye_color = DYE_CHAP

/obj/item/stamp/centcom
	name = "CentCom rubber stamp"
	icon_state = "stamp-centcom"
	dye_color = DYE_CENTCOM

/obj/item/stamp/syndicate
	name = "Syndicate rubber stamp"
	icon_state = "stamp-syndicate"
	dye_color = DYE_SYNDICATE

/obj/item/stamp/donk
	name = "Donk! Co. rubber stamp"
	icon_state = "stamp-donk"
	dye_color = DYE_SYNDICATE

/obj/item/stamp/cybersun
	name = "Cybersun Virtual Solutions rubber stamp"
	icon_state = "stamp-cybersun"
	dye_color = DYE_SYNDICATE

/obj/item/stamp/cybersun/biodynamics
	name = "Cybersun Biodynamics rubber stamp"
	icon_state = "stamp-biodynamics"
	dye_color = DYE_CMO

/obj/item/stamp/ngr
	name = "New Gorlex Republic rubber stamp"
	icon_state = "stamp-ngr"
	dye_color = DYE_REDCOAT

/obj/item/stamp/ngr/captain
	name = "Captain's rubber stamp"
	icon_state = "stamp-ngr_cap"
	dye_color = DYE_QM

/obj/item/stamp/ngr/foreman
	name = "Foreman's rubber stamp"
	icon_state = "stamp-ngr_fore"
	dye_color = DYE_QM

/obj/item/stamp/ngr/lieutenant
	name = "Lieutenant's rubber stamp"
	icon_state = "stamp-ngr_lieu"
	dye_color = DYE_QM

/obj/item/stamp/ngr/ensign
	name = "Ensign's rubber stamp"
	icon_state = "stamp-ngr_ensign"
	dye_color = DYE_QM

/obj/item/stamp/solgov
	name = "SolGov rubber stamp"
	icon_state = "stamp-solgov"

/obj/item/stamp/inteq
	name = "Inteq rubber stamp"
	icon_state = "stamp-inteq"
	dye_color = DYE_QM

/obj/item/stamp/inteq/vanguard
	name = "Vanguard's rubber stamp"
	icon_state = "stamp-inteq_vanguard"

/obj/item/stamp/inteq/maa
	name = "Master at Arms' rubber stamp"
	icon_state = "stamp-inteq_maa"

/obj/item/stamp/inteq/artificer
	name = "Honorable Artificer's rubber stamp"
	icon_state = "stamp-inteq_artificer"

/obj/item/stamp/inteq/corpsman
	name = "Honorable Corpsman's rubber stamp"
	icon_state = "stamp-inteq_corpsman"

/obj/item/stamp/clip
	name = "CLIP Minutemen rubber stamp"
	icon_state = "stamp-cmm"
	dye_color = DYE_FO

/obj/item/stamp/clip/gold
	name = "GOLD rubber stamp"
	icon_state = "stamp-gold"
	dye_color = DYE_FO

/obj/item/stamp/clip/bard
	name = "BARD rubber stamp"
	icon_state = "stamp-bard"
	dye_color = DYE_FO

/obj/item/stamp/suns
	name = "SUNS rubber stamp"
	icon_state = "stamp-suns"
	dye_color = DYE_PURPLE

/obj/item/stamp/attack_paw(mob/user)
	return attack_hand(user)
