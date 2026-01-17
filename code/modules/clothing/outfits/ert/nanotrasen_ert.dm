/datum/outfit/job/makossowarra/ert
	name = "ERT - Makosso-Warra Vigilitas Security Officer"
	jobtype = /datum/job/ert/sec
	job_icon = "securityofficer"

	wallet = null

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/makossowarra/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/makossowarra/cap/security
	suit = /obj/item/clothing/suit/armor/makossowarra
	suit_store = /obj/item/gun/ballistic/automatic/pistol/challenger
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	shoes = /obj/item/clothing/shoes/jackboots

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/security

	backpack_contents = list(/obj/item/ammo_box/magazine/co9mm = 3)

	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/job/makossowarra/ert/inspector
	name = "ERT - Makosso-Warra CentCom Inspector"
	id_assignment = "Inspector"
	job_icon = "centcom"
	jobtype = /datum/job/ert/commander

	head = null
	uniform = /obj/item/clothing/under/rank/centcom/official
	shoes = /obj/item/clothing/shoes/sneakers/black
	gloves = /obj/item/clothing/gloves/color/black
	suit = null
	suit_store = null
	ears = /obj/item/radio/headset/headset_cent
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/clipboard
	id = /obj/item/card/id/centcom

	l_pocket = /obj/item/pen
	r_pocket = /obj/item/pda/heads

	backpack_contents = list(/obj/item/stamp/makossowarra/central, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler)

// /datum/outfit/job/makossowarra/ert/emergency
// 	name = "ERT - Vigilitas Emergency Response Officer"

/datum/outfit/job/makossowarra/ert/leader
	name = "ERT - Makosso-Warra Vigilitas Security Corporal"
	jobtype = /datum/job/ert/commander
	job_icon = "lieutenant"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/makossowarra/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/makossowarra/beret/security
	suit = /obj/item/clothing/suit/armor/makossowarra/slim
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = null

// /datum/outfit/job/makossowarra/ert/leader/emergency
// 	name = "ERT - Vigilitas Emergency Response Lieutenant"

// /datum/outfit/job/makossowarra/ert/emergency/medic
// 	name = "ERT - Vigilitas Emergency Response Medic"

// /datum/outfit/job/makossowarra/ert/emergency/engineer
// 	name = "ERT - Vigilitas Emergency Response Engineer"
