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

/obj/item/stamp/captain
	name = "captain's rubber stamp"
	icon_state = "stamp-cap"
	dye_color = DYE_CAPTAIN

/obj/item/stamp/officer
	name = "first officer's rubber stamp"
	icon_state = "stamp-fo"
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

/obj/item/stamp/roumain
	name = "chaplain's rubber stamp"
	icon_state = "stamp-chap"
	dye_color = DYE_CHAP

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

/obj/item/stamp/hardliners
	name = "Hardliners rubber stamp"
	icon_state = "stamp-hardliners"
	dye_color = DYE_SYNDICATE

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
	name = "CLIP rubber stamp"
	icon_state = "stamp-clip"
	dye_color = DYE_FO

/obj/item/stamp/clip/cmm
	name = "CLIP Minutemen rubber stamp"
	icon_state = "stamp-clip_cmm"
	dye_color = DYE_CAPTAIN

/obj/item/stamp/clip/gold
	name = "CLIP-GOLD rubber stamp"
	icon_state = "stamp-clip_gold"

/obj/item/stamp/clip/bard
	name = "CLIP-BARD rubber stamp"
	icon_state = "stamp-clip_bard"

/obj/item/stamp/clip/lord
	name = "CLIP-LORD rubber stamp"
	icon_state = "stamp-clip_lord"

/obj/item/stamp/clip/land
	name = "CLIP-LAND rubber stamp"
	icon_state = "stamp-clip_land"

/obj/item/stamp/clip/meld
	name = "CLIP-MELD rubber stamp"
	icon_state = "stamp-clip_meld"

/obj/item/stamp/clip/deed
	name = "CLIP-DEED rubber stamp"
	icon_state = "stamp-clip_deed"

/obj/item/stamp/suns
	name = "SUNS rubber stamp"
	icon_state = "stamp-suns"
	dye_color = DYE_PURPLE

/obj/item/stamp/nanotrasen
	name = "Nanotrasen rubber stamp"
	desc = "A small rubber stamp for stamping important documents."
	icon_state = "stamp-nt"
	dye_color = DYE_BLUE

/obj/item/stamp/nanotrasen/captain
	name = "NT Captain's rubber stamp"
	icon_state = "stamp-nt_cap"

/obj/item/stamp/nanotrasen/officer
	name = "NT Officer's rubber stamp"
	icon_state = "stamp-nt_fo"

/obj/item/stamp/nanotrasen/engineering
	name = "NT Engineering Director's rubber stamp"
	icon_state = "stamp-nt_engdir"

/obj/item/stamp/nanotrasen/medical
	name = "NT Medical Director's rubber stamp"
	icon_state = "stamp-nt_meddir"

/obj/item/stamp/nanotrasen/science
	name = "NT Science Director's rubber stamp"
	icon_state = "stamp-nt_scidir"

/obj/item/stamp/nanotrasen/ns
	name = "N+S Logistics rubber stamp"
	icon_state = "stamp-ns"
	dye_color = DYE_ORANGE

/obj/item/stamp/nanotrasen/ns/captain
	name = "N+S Captain's rubber stamp"
	icon_state = "stamp-ns_cap"

/obj/item/stamp/nanotrasen/ns/supply
	name = "N+S Supply Director's rubber stamp"
	icon_state = "stamp-ns_supdir"

/obj/item/stamp/nanotrasen/vigilitas
	name = "Vigilitas Interstellar rubber stamp"
	icon_state = "stamp-vi"
	dye_color = DYE_HOS

/obj/item/stamp/nanotrasen/vigilitas/captain
	name = "VI Captain's rubber stamp"
	icon_state = "stamp-vi_cap"

/obj/item/stamp/nanotrasen/vigilitas/security
	name = "VI Security Director's rubber stamp"
	icon_state = "stamp-vi_secdir"

/obj/item/stamp/nanotrasen/vigilitas/loss_prevention
	name = "VI Loss Prevention rubber stamp"
	icon_state = "stamp-vi_lp"

/obj/item/stamp/nanotrasen/central
	name = "NT Central Command rubber stamp"
	desc = "A rubber stamp for stamping important documents." // Needed, because base nt has "small" added.
	icon_state = "stamp-nt_central"

/obj/item/stamp/attack_paw(mob/user)
	return attack_hand(user)
