// cybersun

/datum/outfit/job/syndicate/ert/cybersun
	name = "ERT - Syndicate Cybersun Commando"
	job_icon = "syndicate"

	uniform = /obj/item/clothing/under/cybersun/suit
	alt_uniform = /obj/item/clothing/under/cybersun/sneak

	head = null
	mask = /obj/item/clothing/mask/gas/cybersun

	belt = /obj/item/storage/belt/military/boomslang

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/cybersun
	suit_store = /obj/item/gun/ballistic/automatic/marksman/boomslang
	ears = /obj/item/radio/headset/syndicate/alt/cybersun
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/hardliners

	implants = list(/obj/item/implant/adrenalin)
	backpack_contents = list(/obj/item/autosurgeon/syndicate/laser_arm, /obj/item/grenade/smokebomb)

/datum/outfit/job/syndicate/ert/cybersun/leader
	name = "ERT - Syndicate Cybersun Commando Leader"
	jobtype = /datum/job/ert/commander

	ears = /obj/item/radio/headset/syndicate/alt/captain/cybersun
	glasses = /obj/item/clothing/glasses/hud/security/night

	backpack_contents = list(/obj/item/autosurgeon/syndicate/laser_arm=1, /obj/item/antag_spawner/nuke_ops/borg_tele/medical/unlocked=1, /obj/item/grenade/smokebomb)

/datum/outfit/job/syndicate/ert/cybersun/inspector
	name = "ERT - Syndicate Cybersun Representative"
	jobtype = /datum/job/ert/commander

	uniform = /obj/item/clothing/under/cybersun/officer
	head = /obj/item/clothing/head/cybersun
	shoes = /obj/item/clothing/shoes/laceup
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	suit = null
	suit_store = null
	belt = /obj/item/clipboard
	glasses = null
	mask = null
	ears = /obj/item/radio/headset/syndicate/alt/captain/cybersun

	r_pocket = /obj/item/pen/fourcolor
	l_pocket = /obj/item/taperecorder

	backpack_contents = list(/obj/item/stamp/cybersun, /obj/item/folder/red, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler)

// Trauma Team

/datum/outfit/job/syndicate/ert/cybersun/medic
	name = "ERT - Cybersun Trauma Team"
	id_assignment = "Trauma Team"
	job_icon = "paramedic"
	jobtype = /datum/job/ert/med

	uniform = /obj/item/clothing/under/cybersun/medic
	accessory = /obj/item/clothing/accessory/holster/cybersun
	suit = /obj/item/clothing/suit/armor/vest/cybersun/trauma
	head = /obj/item/clothing/head/helmet/m10/cybersun/trauma/teal
	suit_store = /obj/item/gun/ballistic/automatic/smg/sidewinder
	mask = /obj/item/clothing/mask/gas/cybersun
	glasses = /obj/item/clothing/glasses/hud/health/night
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/evil

	belt = /obj/item/storage/belt/medical/webbing/traumateam
	back = /obj/item/storage/backpack/satchel/med

	l_pocket = /obj/item/storage/pouch/ammo/sidewinder
	r_pocket = /obj/item/tank/internals/emergency_oxygen

	backpack_contents = list(
		/obj/item/storage/firstaid/medical = 1,
		/obj/item/melee/knife/combat = 1,
		/obj/item/grenade/smokebomb = 2,
		/obj/item/grenade/flashbang = 1,
		/obj/item/radio = 1,
		/obj/item/crowbar/power = 1
		/obj/item/bodycamera = 1,
	)

/datum/outfit/job/syndicate/ert/cybersun/medic/leader
	name = "ERT - Cybersun Trauma Team Lead"
	id_assignment = "Trauma Team Lead"
	job_icon = "chiefmedicalofficer"
	jobtype = /datum/job/ert/commander

	uniform = /obj/item/clothing/under/cybersun/doctor
	glasses = /obj/item/clothing/glasses/hud/security/night
	ears = /obj/item/radio/headset/syndicate/alt/captain/cybersun

	backpack_contents = list(
		/obj/item/storage/firstaid/tactical = 1,
		/obj/item/autosurgeon/cmo = 1,
		/obj/item/radio = 1,
		/obj/item/grenade/smokebomb = 2,
		/obj/item/grenade/c4 = 2,
		/obj/item/megaphone/command = 1,
		/obj/item/bodycamera = 1
	)
