/datum/outfit/job/inteq/ert
	name = "ERT - Inteq Rifleman"
	id_assignment = "Enforcer"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	wallet = null

	head = /obj/item/clothing/head/helmet/inteq
	mask = /obj/item/clothing/mask/balaclava/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	uniform = /obj/item/clothing/under/syndicate/inteq
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/automatic/assault/skm/inteq
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/inteq/alt
	id = /obj/item/card/id
	belt = /obj/item/storage/belt/security/webbing/inteq/skm

	l_pocket = /obj/item/melee/knife/combat
	r_pocket = /obj/item/flashlight/seclite

/datum/outfit/job/inteq/ert/eva
	name = "ERT - Inteq Rifleman (EVA)"

	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/inteq
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi


/datum/outfit/job/inteq/ert/shotgun
	name = "ERT - Inteq Shotgunner"

	suit_store = /obj/item/gun/ballistic/shotgun/automatic/bulldog/inteq
	belt = /obj/item/storage/belt/security/webbing/inteq/alt/bulldog

/datum/outfit/job/inteq/ert/shotgun/eva
	name = "ERT - Inteq Shotgunner (EVA)"

	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/inteq
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi

/datum/outfit/job/inteq/ert/engineer
	name = "ERT - Inteq Artificer"
	id_assignment = "Artificer"
	jobtype = /datum/job/engineer
	job_icon = "stationengineer"

	head = /obj/item/clothing/head/soft/inteq
	uniform = /obj/item/clothing/under/syndicate/inteq/artificer
	belt = /obj/item/storage/belt/utility/full/engi
	gloves = /obj/item/clothing/gloves/color/yellow
	suit_store = /obj/item/gun/ballistic/automatic/pistol/commander/inteq

	backpack_contents = list(/obj/item/ammo_box/magazine/co9mm=2)

/datum/outfit/job/inteq/ert/engineer/eva
	name = "ERT - Inteq Artificer (EVA)"
	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/inteq
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi

/datum/outfit/job/inteq/ert/medic
	name = "ERT - Inteq Corpsman"
	id_assignment = "Corpsman"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	head = /obj/item/clothing/head/soft/inteq/corpsman
	uniform = /obj/item/clothing/under/syndicate/inteq/corpsman
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	suit = /obj/item/clothing/suit/armor/inteq/corpsman
	suit_store = /obj/item/healthanalyzer

	backpack_contents = list(/obj/item/storage/firstaid/medical=1)

/datum/outfit/job/inteq/ert/medic/eva
	name = "ERT - Inteq Corpsman (EVA)"

	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/inteq
	suit_store = null
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi

/datum/outfit/job/inteq/ert/leader
	name = "ERT - Inteq Vanguard"
	id_assignment = "Vanguard"
	jobtype = /datum/job/hos
	job_icon = "headofsecurity"

	head = /obj/item/clothing/head/helmet/inteq
	ears = /obj/item/radio/headset/inteq/alt/captain
	back = /obj/item/storage/backpack/messenger/inteq
	belt = /obj/item/storage/belt/security/webbing/inteq/skm_carabine
	suit = /obj/item/clothing/suit/armor/hos/inteq
	suit_store = /obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq
	id = /obj/item/card/id/gold

	backpack_contents = list(/obj/item/megaphone/sec)

/datum/outfit/job/inteq/ert/leader/eva
	name = "ERT - Inteq Vanguard (EVA)"

	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/inteq
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi

/datum/outfit/job/inteq/ert/honor_guard
	name = "ERT - Inteq Honor Guard"
	id_assignment = "Guardsman"
	jobtype = /datum/job/officer
	job_icon = "inteq"

	uniform = /obj/item/clothing/under/syndicate/inteq
	suit = /obj/item/clothing/suit/armor/vest/marine
	belt = /obj/item/storage/belt/military/assault/commander
	gloves = /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/beret/sec/hos/inteq/honorable
	mask = /obj/item/clothing/mask/balaclava/inteq
	ears = /obj/item/radio/headset/inteq/captain
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	r_pocket = /obj/item/restraints/handcuffs
	suit_store = /obj/item/gun/ballistic/automatic/pistol/commander/inteq

	backpack_contents = list(/obj/item/gun/energy/taser)


/datum/outfit/job/inteq/ert/inspector
	name = "ERT - Inteq Mothership Investigator"
	id_assignment = "Investigator"
	jobtype = /datum/job/head_of_personnel
	job_icon = "inteq"

	uniform = /obj/item/clothing/under/syndicate/inteq
	suit = null
	suit_store = null
	belt = /obj/item/clipboard
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/beret/sec/inteq
	mask = null
	ears = /obj/item/radio/headset/inteq/captain
	glasses = null

	r_pocket = /obj/item/pen/fourcolor
	l_pocket = /obj/item/taperecorder

	backpack_contents = list(/obj/item/stamp/inteq, /obj/item/folder, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler)
