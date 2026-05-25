// cybersun

/datum/outfit/job/syndicate/ert/cybersun
	name = "ERT - Cybersun Troubleshooter"
	id_assignment = "Troubleshooter"
	job_icon = "syndicate"

	uniform = /obj/item/clothing/under/cybersun/suit
	alt_uniform = /obj/item/clothing/under/cybersun/sneak

	head = /obj/item/clothing/head/helmet/bulletproof/x11/cybersun
	mask = /obj/item/clothing/mask/gas/cybersun

	belt = /obj/item/storage/belt/military/cybersun/sidewinder

	suit = /obj/item/clothing/suit/armor/vest/marine/cybersun
	suit_store = /obj/item/gun/ballistic/automatic/smg/sidewinder
	ears = /obj/item/radio/headset/syndicate/alt/cybersun
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/hardliners

	l_pocket = /obj/item/storage/pouch/medical
	r_pocket = /obj/item/tank/internals/emergency_oxygen

	backpack_contents = list(
		/obj/item/storage/box/ammo/c57x39 = 1,
		/obj/item/grenade/smokebomb = 2,
		/obj/item/grenade/frag = 1,
		/obj/item/melee/knife/combat = 1,
		/obj/item/radio = 1,
		/obj/item/bodycamera = 1
	)

/datum/outfit/job/syndicate/ert/cybersun/space
	name = "ERT - Cybersun Troubleshooter (Hardsuit)"

	head = null

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/cybersun

/datum/outfit/job/syndicate/ert/cybersun/marksman
	name = "ERT - Cybersun Troubleshooter (Sniper)"

	uniform = /obj/item/clothing/under/cybersun/sneak
	alt_uniform = /obj/item/clothing/under/cybersun/suit

	belt = /obj/item/storage/belt/military/cybersun/boomslang

	suit_store = /obj/item/gun/ballistic/automatic/marksman/boomslang

	l_pocket = /obj/item/storage/pouch/medical
	r_pocket = /obj/item/tank/internals/emergency_oxygen

	backpack_contents = list(
		/obj/item/storage/box/ammo/a65clip = 1,
		/obj/item/grenade/smokebomb = 4,
		/obj/item/melee/knife/combat = 1,
		/obj/item/radio = 1,
		/obj/item/bodycamera = 1
	)

/datum/outfit/job/syndicate/ert/cybersun/marksman/space
	name = "ERT - Cybersun Troubleshooter (Sniper + Hardsuit)"

	head = null

	suit = /obj/item/clothing/suit/space/hardsuit/stealth/cybersun


/datum/outfit/job/syndicate/ert/cybersun/pointman
	name = "ERT - Cybersun Troubleshooter (Pointman)"

	belt = /obj/item/storage/belt/military/cybersun/bulldog

	suit_store = /obj/item/gun/ballistic/shotgun/automatic/bulldog

	suit = /obj/item/clothing/suit/armor/vest/marine/medium/cybersun

	l_pocket = /obj/item/storage/pouch/medical
	r_pocket = /obj/item/tank/internals/emergency_oxygen

	backpack_contents = list(
		/obj/item/storage/box/ammo/a12g_buckshot = 1,
		/obj/item/grenade/smokebomb = 2,
		/obj/item/grenade/c4/x4 = 1,
		/obj/item/melee/knife/combat = 1,
		/obj/item/radio = 1,
		/obj/item/bodycamera = 1
	)

/datum/outfit/job/syndicate/ert/cybersun/pointman/space
	name = "ERT - Cybersun Troubleshooter (Pointman + Hardsuit)"

	head = null

	suit = /obj/item/clothing/suit/space/hardsuit/collapsar

/datum/outfit/job/syndicate/ert/cybersun/leader
	name = "ERT - Cybersun Troubleshooter Lead"
	id_assignment = "Troubleshooter Lead"
	jobtype = /datum/job/ert/commander

	ears = /obj/item/radio/headset/syndicate/alt/captain/cybersun
	glasses = /obj/item/clothing/glasses/hud/security/night

	belt = /obj/item/storage/belt/military/cybersun/hydra

	suit_store = /obj/item/gun/ballistic/automatic/assault/hydra

	backpack_contents = list(
		/obj/item/storage/box/ammo/c556mm = 1,
		/obj/item/grenade/smokebomb = 2,
		/obj/item/grenade/c4/x4 = 2,
		/obj/item/melee/knife/combat = 1,
		/obj/item/radio = 1,
		/obj/item/bodycamera = 1
	)

/datum/outfit/job/syndicate/ert/cybersun/leader/space
	name = "ERT - Cybersun Troubleshooter Lead (Hardsuit)"

	head = null

	suit = /obj/item/clothing/suit/space/hardsuit/collapsar

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

	backpack_contents = list(
		/obj/item/storage/firstaid/medical = 1,
		/obj/item/melee/knife/combat = 1,
		/obj/item/grenade/smokebomb = 2,
		/obj/item/grenade/flashbang = 1,
		/obj/item/radio = 1,
		/obj/item/crowbar/power = 1,
		/obj/item/bodycamera = 1
	)

/datum/outfit/job/syndicate/ert/cybersun/medic/space
	name = "ERT - Cybersun Trauma Team (Hardsuit)"
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/cybersun/paramed
	head = null

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

/datum/outfit/job/syndicate/ert/cybersun/medic/leader/space
	name = "ERT - Cybersun Trauma Team Lead (Hardsuit)"
	suit = /obj/item/clothing/suit/space/hardsuit/collapsar/paramed
	head = null

//executive

/datum/outfit/job/syndicate/ert/cybersun/inspector
	name = "ERT - Cybersun Executive"
	jobtype = /datum/job/ert/commander
	id_assignment = "Executive"

	uniform = /obj/item/clothing/under/cybersun/officer
	head = /obj/item/clothing/head/cybersun
	shoes = /obj/item/clothing/shoes/laceup
	glasses = null
	suit = /obj/item/clothing/suit/armor/cybersun
	suit_store = null
	belt = null
	glasses = null
	mask = null
	ears = /obj/item/radio/headset/syndicate/alt/captain/cybersun

	r_pocket = /obj/item/gun/ballistic/automatic/pistol/himehabu
	l_pocket = /obj/item/taperecorder

	backpack_contents = list(
		/obj/item/clipboard,
		/obj/item/pen/fourcolor,
		/obj/item/stamp/cybersun,
		/obj/item/folder/red,
		/obj/item/paper_bin/bundlenatural,
		/obj/item/hand_labeler,
		/obj/item/attachment/silencer,
		/obj/item/ammo_box/magazine/m22lr_himehabu = 2
	)

/datum/outfit/job/syndicate/ert/cybersun/cute_secretary
	name = "ERT - Cybersun Executive Aide"
	jobtype = /datum/job/ert
	id_assignment = "Executive Aide"

	uniform = /obj/item/clothing/under/suit/black_really/skirt
	accessory = /obj/item/clothing/accessory/waistcoat
	suit = /obj/item/clothing/suit/cybersun
	shoes = /obj/item/clothing/shoes/laceup
	glasses = /obj/item/clothing/glasses/regular/thin
	ears = /obj/item/radio/headset/syndicate/alt/captain/cybersun

	head = null
	suit_store = null
	belt = null
	mask = null

	r_pocket = /obj/item/gun/ballistic/automatic/pistol/himehabu
	l_pocket = /obj/item/taperecorder

	backpack_contents = list(
		/obj/item/clipboard,
		/obj/item/pen/fourcolor,
		/obj/item/stamp/cybersun,
		/obj/item/folder/red,
		/obj/item/paper_bin/bundlenatural,
		/obj/item/hand_labeler,
		/obj/item/attachment/silencer,
		/obj/item/ammo_box/magazine/m22lr_himehabu = 2
	)
