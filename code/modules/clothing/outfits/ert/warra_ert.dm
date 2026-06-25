/datum/outfit/job/warra/ert
	name = "ERT - Makosso-Warra Vigilitas Security Officer"
	jobtype = /datum/job/ert/sec
	job_icon = "securityofficer"

	wallet = null

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/warra/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/warra/cap/security
	suit = /obj/item/clothing/suit/armor/warra
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

/datum/outfit/job/warra/ert/inspector
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

	backpack_contents = list(/obj/item/stamp/warra/central, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler)

/datum/outfit/job/warra/ert/leader
	name = "ERT - Makosso-Warra Vigilitas Security Corporal"
	jobtype = /datum/job/ert/commander
	job_icon = "lieutenant"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/warra/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/warra/beret/security
	suit = /obj/item/clothing/suit/armor/warra/slim
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = null

// VI Crisis Response Units

/datum/outfit/job/warra/ert/emergency/leader
	name = "ERT - Vigilitas CRU Lieutenant"
	jobtype = /datum/job/ert/commander
	job_icon = "lieutenant"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/warra/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/space/hardsuit/security/hos
	suit = /obj/item/clothing/suit/space/hardsuit/security/hos
	suit_store = /obj/item/gun/ballistic/automatic/smg/resolution
	belt = /obj/item/storage/belt/military/warra/resolution
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	backpack_contents = null

/datum/outfit/job/warra/ert/emergency/rifle
	name = "ERT - Vigilitas CRU Rifleman"
	jobtype = /datum/job/ert/sec
	job_icon = "securityofficer"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/warra/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/space/hardsuit/security
	suit = /obj/item/clothing/suit/space/hardsuit/security
	suit_store = /obj/item/gun/energy/sharplite/hades
	belt = /obj/item/storage/belt/military/warra/sharplite
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	backpack_contents = null

/datum/outfit/job/warra/ert/emergency/sniper
	name = "ERT - Vigilitas CRU Marksman"
	jobtype = /datum/job/ert/sec
	job_icon = "securityofficer"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/warra/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/space/hardsuit/security
	suit = /obj/item/clothing/suit/space/hardsuit/security
	suit_store = /obj/item/gun/energy/sharplite/sarissa
	belt = /obj/item/storage/belt/military/warra/sharplite
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	backpack_contents = null

/datum/outfit/job/warra/ert/emergency/lifesaver
	name = "ERT - Vigilitas CRU Combat Lifesaver"
	jobtype = /datum/job/ert/med
	job_icon = "paramedic"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/warra/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/space/hardsuit/security
	suit = /obj/item/clothing/suit/space/hardsuit/security
	suit_store = /obj/item/gun/ballistic/automatic/smg/resolution
	belt = /obj/item/storage/belt/military/warra/resolution
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	backpack_contents = list(/obj/item/storage/firstaid/tactical)

// Makosso-Warra Medical Response Team

/datum/outfit/job/warra/ert/emergency/medical/leader
	name = "ERT - Makosso-Warra Medical Response Team Leader"
	jobtype = /datum/job/ert/commander
	job_icon = "chiefmedicalofficer"

	belt = /obj/item/defibrillator/compact
	ears = /obj/item/radio/headset/headset_med
	glasses = /obj/item/clothing/glasses/hud/health
	head = /obj/item/clothing/head/warra/surgical
	uniform = /obj/item/clothing/under/warra/medical
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/warra/medical_smock
	alt_suit = /obj/item/clothing/suit/toggle/labcoat/warra
	suit_store = /obj/item/gun/energy/sharplite/revolver
	l_hand = /obj/item/clipboard
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(/obj/item/storage/firstaid/tactical)

/datum/outfit/job/warra/ert/emergency/medical
	name = "ERT - Makosso-Warra Medical Response Staff"
	jobtype = /datum/job/ert/med
	job_icon = "medicaldoctor"

	belt = /obj/item/pda/medical
	glasses = /obj/item/clothing/glasses/hud/health
	ears = /obj/item/radio/headset/headset_med
	head = /obj/item/clothing/head/warra/surgical
	uniform = /obj/item/clothing/under/warra/medical
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/warra/medical_smock
	suit_store = /obj/item/gun/energy/sharplite/revolver
	l_hand = /obj/item/roller
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(/obj/item/storage/firstaid/medical)

// N+S Disaster Recovery Team

/datum/outfit/job/warra/ert/ns/leader
	name = "ERT - N+S Disaster Recovery Team Leader"
	jobtype = /datum/job/ert/commander
	job_icon = "chiefengineer"

	belt = /obj/item/storage/belt/utility/full/ert
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/warra/supply/miner
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/space/hardsuit/engine/elite
	suit = /obj/item/clothing/suit/space/hardsuit/engine/elite
	suit_store = /obj/item/gun/energy/sharplite/revolver
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	backpack_contents = list(/obj/item/tank/internals/emergency_oxygen/double, /obj/item/clothing/mask/gas)

/datum/outfit/job/warra/ert/ns/engineer
	name = "ERT - N+S DRT Technical Rescue Specialist"
	jobtype = /datum/job/ert/engi
	job_icon = "atmospherictechnician"

	belt = /obj/item/storage/belt/utility/full/ert
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/warra/supply/miner
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/space/hardsuit/mining/heavy/ns
	suit = /obj/item/clothing/suit/space/hardsuit/mining/heavy/ns
	back =  /obj/item/melee/axe/fire
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	backpack_contents = null

	box = null
	backpack = null
	courierbag = null
	satchel = null
	duffelbag = null

/datum/outfit/job/warra/ert/ns/hazmat
	name = "ERT - N+S DRT HazMat Specialist"
	jobtype = /datum/job/ert/med
	job_icon = "paramedic"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/warra/supply/miner
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/space/hardsuit/mining/heavy/ns
	suit = /obj/item/clothing/suit/space/hardsuit/mining/heavy/ns
	suit_store = /obj/item/sensor_device
	l_hand = /obj/item/extinguisher/advanced
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	backpack_contents = list(/obj/item/storage/firstaid/medical, /obj/item/storage/firstaid/radiation, /obj/item/tank/internals/emergency_oxygen/double, /obj/item/clothing/mask/gas)
