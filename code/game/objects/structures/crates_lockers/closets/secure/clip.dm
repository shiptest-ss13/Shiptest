/obj/structure/closet/secure_closet/clip
	name = "CLIP storage"
	desc = "dont use this type stinky"

/obj/structure/closet/secure_closet/clip/minutemen/armor
	name = "minuteman personal equipment locker"
	desc = "A locker to safeguard your armor and vests."
	req_access = list(ACCESS_ARMORY)
	var/armor_sets = 5

/obj/structure/closet/secure_closet/clip/minutemen/armor/PopulateContents()
	. = ..()
	for(var/i in 1 to armor_sets)
		new /obj/item/clothing/head/helmet/bulletproof/x11/clip(src)
		new /obj/item/clothing/suit/armor/vest/bulletproof(src)
		new /obj/item/clothing/mask/gas/clip(src)
		new /obj/item/storage/belt/military/clip(src)
	return

/obj/structure/closet/secure_closet/clip/minutemen/captain
	name = "captain locker"
	desc = "This locker contains all (most of what) a cunning captain needs for day to day leadership."
	req_access = list(ACCESS_CAPTAIN)
	icon_state = "cap"

/obj/structure/closet/secure_closet/clip/minutemen/captain/PopulateContents()
	new /obj/item/clothing/head/clip/slouch/officer(src)
	new /obj/item/clothing/under/clip/officer(src)
	new /obj/item/clothing/under/clip/officer/alt(src)
	new /obj/item/clothing/suit/armor/clip_capcoat(src)
	new /obj/item/storage/belt/military/clip(src) // you know, just in case
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/gloves/color/captain(src)
	new /obj/item/storage/backpack/security/clip(src)
	new /obj/item/storage/backpack/satchel/sec/clip(src)
	new /obj/item/binoculars(src)
	new /obj/item/clipboard(src)
	new /obj/item/megaphone(src)
	return

/obj/structure/closet/secure_closet/clip/minutemen/bridge_officer
	name = "bridge officer locker"
	desc = "This locker contains all (most of what) a responsible bridge officer needs for keeping the ship efficient."
	req_access = list(ACCESS_HOP)
	icon_state = "hop"

/obj/structure/closet/secure_closet/clip/minutemen/bridge_officer/PopulateContents()
	new /obj/item/clothing/head/clip/slouch(src)
	new /obj/item/clothing/under/clip/officer(src)
	new /obj/item/clothing/under/clip/officer/alt(src)
	new /obj/item/clothing/suit/toggle/lawyer/clip(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/storage/belt/military/clip(src) // you know, just in case
	new /obj/item/binoculars(src)
	new /obj/item/clipboard(src)
	return

/obj/structure/closet/secure_closet/clip/minutemen/lead
	name = "team sergeant locker"
	desc = "This locker contains all (most of what) a bold team sergeant needs for keeping the frontier safe."
	req_access = list(ACCESS_ARMORY)
	icon_state = "blueshield"

/obj/structure/closet/secure_closet/clip/minutemen/lead/PopulateContents()
	new /obj/item/clothing/under/clip/minutemen(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/head/soft/utility_navy(src)
	new /obj/item/storage/belt/military/clip(src)
	new /obj/item/storage/pouch/squad(src)
	new /obj/item/megaphone(src)
	new /obj/item/binoculars(src)
	new /obj/item/clipboard(src)

/obj/structure/closet/secure_closet/clip/minutemen/combat_medic
	name = "combat medic locker"
	desc = "This locker contains all (most of what) a clever combat medic needs to keep the Minutemen fighting."
	req_access = list(ACCESS_MEDICAL)
	icon_state = "med_secure"

/obj/structure/closet/secure_closet/clip/minutemen/combat_medic/PopulateContents()
	new /obj/item/clothing/head/clip/corpsman(src)
	new /obj/item/clothing/accessory/armband/medblue(src)
	new /obj/item/clothing/under/clip/minutemen(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/storage/belt/medical/webbing/clip(src)
	new /obj/item/storage/pouch/medical(src)


/obj/structure/closet/secure_closet/clip/minutemen/engineer
	name = "naval engineer locker"
	desc = "This locker contains all (most of what) a cunning engineer needs for ship maintenance."
	req_access = list(ACCESS_ENGINE)
	icon_state = "eng_secure"

/obj/structure/closet/secure_closet/clip/minutemen/engineer/PopulateContents()
	new /obj/item/clothing/under/clip(src)
	new /obj/item/clothing/shoes/workboots(src)
	new /obj/item/storage/belt/utility/full/engi(src)
	new /obj/item/clothing/gloves/color/yellow(src)
	new /obj/item/clothing/gloves/color/yellow(src)
	new /obj/item/clothing/suit/hazardvest(src)
	new /obj/item/storage/backpack/satchel/eng(src)
	new /obj/item/clothing/head/soft/utility_navy(src)
	new /obj/item/clothing/head/hardhat/dblue(src)
	new /obj/item/clothing/glasses/welding(src)
	new /obj/item/storage/box/emptysandbags(src)
	new /obj/item/shovel(src)
	new /obj/item/holosign_creator/engineering(src)

/obj/structure/closet/secure_closet/clip/minutemen/correspondent
	name = "military correspondent locker"
	desc = "This locker contains all (most of what) a curious correspondent needs for informing the frontier."
	req_access = list(ACCESS_LIBRARY)

/obj/structure/closet/secure_closet/clip/minutemen/correspondent/PopulateContents()
	new /obj/item/clothing/under/clip/formal(src)
	new /obj/item/clothing/shoes/workboots(src)
	new /obj/item/clothing/head/helmet/m10/clip_correspondent(src)
	new /obj/item/clothing/suit/armor/vest/clip_correspondent(src)
	new /obj/item/bodycamera/broadcast_camera(src)
	new /obj/item/binoculars(src)
	new /obj/item/clipboard(src)
	new /obj/item/storage/photo_album/correspondent(src)
