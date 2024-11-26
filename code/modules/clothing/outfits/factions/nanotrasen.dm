/*
 * OUTFIT DATUMS THAT NEED MAKING:
 * Research Director
 * Medical Director
*/

/datum/outfit/job/nanotrasen
	name = "Nanotrasen - Base Outfit"
	faction_icon = "bg_nanotrasen"

	box = /obj/item/storage/box/survival
	id = /obj/item/card/id

/datum/outfit/job/nanotrasen/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_PLAYER_NANOTRASEN)

// Command //

// Captain
/datum/outfit/job/nanotrasen/captain
	name = "Nanotrasen - Captain"
	job_icon = "captain"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/color/captain/nt
	ears = /obj/item/radio/headset/nanotrasen/captain
	uniform = /obj/item/clothing/under/nanotrasen/captain
	alt_uniform = /obj/item/clothing/under/nanotrasen/captain/skirt
	suit = /obj/item/clothing/suit/armor/nanotrasen/captain
	alt_suit = /obj/item/clothing/suit/armor/nanotrasen/captain/parade
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain
	shoes = /obj/item/clothing/shoes/laceup
	neck = /obj/item/clothing/neck/cloak/nanotrasen
	head = /obj/item/clothing/head/nanotrasen/captain/peaked
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/captain)

/datum/outfit/job/nanotrasen/captain/ns
	name = "Nanotrasen - Captain (N+S Logistics)"

	head = /obj/item/clothing/head/nanotrasen/cap/supply
	uniform = /obj/item/clothing/under/nanotrasen/supply/qm
	suit = null
	alt_suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo
	shoes = /obj/item/clothing/shoes/sneakers/brown
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = null
	neck = null
	l_hand = /obj/item/clipboard

	chameleon_extras = /obj/item/stamp/qm

/datum/outfit/job/nanotrasen/captain/centcom
	name = "Nanotrasen - Captain (Central Command)"

	uniform = /obj/item/clothing/under/rank/centcom/officer
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/centhat

// Head of Personnel
/datum/outfit/job/nanotrasen/hop
	name = "Nanotrasen - Head of Personnel"
	job_icon = "headofpersonnel"
	jobtype = /datum/job/head_of_personnel

	belt = /obj/item/pda/heads/head_of_personnel
	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/nanotrasen/officer
	alt_uniform = /obj/item/clothing/under/nanotrasen/officer/skirt
	suit = /obj/item/clothing/suit/toggle/nanotrasen
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/nanotrasen/officer

	backpack_contents = list(
						/obj/item/storage/box/ids=1,
						/obj/item/melee/classic_baton/telescopic=1,
						/obj/item/modular_computer/tablet/preset/advanced = 1,
						)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	chameleon_extras = list(
						/obj/item/gun/energy/e_gun,
						/obj/item/stamp/head_of_personnel,
						)

// Head of Security
/datum/outfit/job/nanotrasen/hos
	name = "Nanotrasen - Head of Security"
	job_icon = "headofsecurity"
	jobtype = /datum/job/hos

	id = /obj/item/card/id/silver
	belt = /obj/item/pda/heads/hos
	ears = /obj/item/radio/headset/nanotrasen/alt
	uniform = /obj/item/clothing/under/nanotrasen/security/director
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/nanotrasen/slim
	alt_suit = /obj/item/clothing/suit/armor/nanotrasen/sec_director
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/nanotrasen/beret/security/command
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	suit_store = null
	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(/obj/item/melee/classic_baton=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	chameleon_extras = list(/obj/item/gun/energy/e_gun/hos, /obj/item/stamp/hos)

// Security Officer
/datum/outfit/job/nanotrasen/security
	name = "Nanotrasen - Security Officer"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	ears = /obj/item/radio/headset/alt
	uniform = /obj/item/clothing/under/nanotrasen/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/nanotrasen/cap/security
	suit = /obj/item/clothing/suit/armor/nanotrasen
	alt_suit = /obj/item/clothing/suit/armor/nanotrasen/slim
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = null

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/security

	chameleon_extras = list(/obj/item/gun/energy/disabler, /obj/item/clothing/glasses/hud/security/sunglasses, /obj/item/clothing/head/helmet)
	//The helmet is necessary because /obj/item/clothing/head/helmet/sec is overwritten in the chameleon list by the standard helmet, which has the same name and icon state

// Warden
/datum/outfit/job/nanotrasen/warden
	name = "Nanotrasen - Warden"
	job_icon = "warden"
	jobtype = /datum/job/warden

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/warden/nt
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/security/warden/alt/nt
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/warden/red
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs
	suit_store = null
	backpack_contents = list(/obj/item/melee/classic_baton)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/security

	chameleon_extras = /obj/item/gun/ballistic/shotgun/automatic/m11

// Engineering //

// Engineer
/datum/outfit/job/nanotrasen/engineer
	name = "Nanotrasen - Engineer"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	belt = /obj/item/storage/belt/utility/full/engi
	l_pocket = /obj/item/pda/engineering
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/nanotrasen/engineering
	head = /obj/item/clothing/head/hardhat/nanotrasen
	suit = /obj/item/clothing/suit/nanotrasen/vest
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/workboots
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

// Chief Engineer
/datum/outfit/job/nanotrasen/ce
	name = "Nanotrasen - Chief Engineer"
	jobtype = /datum/job/chief_engineer
	job_icon = "chiefengineer"

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/chief/full
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/nanotrasen/engineering/director
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hardhat/nanotrasen/white
	gloves = /obj/item/clothing/gloves/color/black

	backpack_contents = list(
						/obj/item/melee/classic_baton/telescopic=1,
						/obj/item/modular_computer/tablet/preset/advanced=1,
						)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer
	chameleon_extras = /obj/item/stamp/ce

// Atmos Tech
/datum/outfit/job/nanotrasen/atmos
	name = "Nanotrasen - Atmos Tech"
	jobtype = /datum/job/atmos
	job_icon = "atmospherictechnician"

	belt = /obj/item/storage/belt/utility/atmostech
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/nanotrasen/engineering/atmos
	head = /obj/item/clothing/head/hardhat/nanotrasen/blue
	suit = /obj/item/clothing/suit/nanotrasen/vest/blue
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi
	box = /obj/item/storage/box/survival/engineer
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

// Brig Physician

/datum/outfit/job/nanotrasen/brig_phys
	name = "Nanotrasen - Brig Physician"
	jobtype = /datum/job/brig_phys
	job_icon = "brigphysician"

	ears = /obj/item/radio/headset/headset_medsec/alt
	uniform = /obj/item/clothing/under/rank/security/brig_phys/nt
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	suit = /obj/item/clothing/suit/toggle/labcoat/brig_phys
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	head = /obj/item/clothing/head/soft/sec/brig_phys
	implants = list(/obj/item/implant/mindshield)

// Supply //

// Quartermaster
/datum/outfit/job/nanotrasen/quartermaster
	name = "Nanotrasen - Quartermaster"
	jobtype = /datum/job/qm
	job_icon = "quartermaster"

	ears = /obj/item/radio/headset/headset_cargo
	head = /obj/item/clothing/head/nanotrasen/cap/supply
	uniform = /obj/item/clothing/under/nanotrasen/supply/qm
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo
	shoes = /obj/item/clothing/shoes/sneakers/brown
	glasses = /obj/item/clothing/glasses/sunglasses
	l_hand = /obj/item/clipboard
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1)

	chameleon_extras = /obj/item/stamp/qm

//Miner
/datum/outfit/job/nanotrasen/miner
	name = "Nanotrasen - Miner"
	jobtype = /datum/job/mining
	job_icon = "shaftminer"

	ears = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	head = /obj/item/clothing/head/hardhat/nanotrasen
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/nanotrasen/supply/miner
	suit = /obj/item/clothing/suit/nanotrasen/vest
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/miner
	r_pocket = /obj/item/storage/bag/ore

	backpack_contents = list(
						/obj/item/flashlight/seclite=1,
						/obj/item/melee/knife/survival=1,
						/obj/item/stack/marker_beacon/ten=1,
						/obj/item/radio/weather_monitor=1,
						)

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag
	box = /obj/item/storage/box/survival/mining

	chameleon_extras = /obj/item/gun/energy/kinetic_accelerator

// Cargo Tech
/datum/outfit/job/nanotrasen/cargo_tech
	name = "Nanotrasen - Cargo Tech"
	jobtype = /datum/job/cargo_tech
	job_icon = "cargotechnician"

	belt = /obj/item/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	head = /obj/item/clothing/head/nanotrasen/cap/supply
	uniform = /obj/item/clothing/under/nanotrasen/supply
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1)

// Medical //

// Medical Doctor
/datum/outfit/job/nanotrasen/doctor
	name = "Nanotrasen - Medical Doctor"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor

	belt = /obj/item/pda/medical
	ears = /obj/item/radio/headset/headset_med
	head = /obj/item/clothing/head/nanotrasen/surgical
	uniform = /obj/item/clothing/under/nanotrasen/medical
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/nanotrasen/medical_smock
	alt_suit = /obj/item/clothing/suit/toggle/labcoat/nanotrasen
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

// Paramedic
/datum/outfit/job/nanotrasen/paramedic
	name = "Nanotrasen - Paramedic"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/nanotrasen/medical/paramedic
	head = /obj/item/clothing/head/nanotrasen/cap/medical
	shoes = /obj/item/clothing/shoes/sneakers/blue
	suit =  /obj/item/clothing/suit/toggle/labcoat/nanotrasen/paramedic
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical/paramedic
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	id = /obj/item/card/id

	backpack_contents = list(/obj/item/roller=1)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

// Civilian //

// Assistant
/datum/outfit/job/nanotrasen/assistant
	name = "Nanotrasen - Assistant"
	jobtype = /datum/job/assistant
	job_icon = "assistant"

	uniform = /obj/item/clothing/under/nanotrasen
	shoes = /obj/item/clothing/shoes/sneakers/black
	belt = /obj/item/pda

// Janitor
/datum/outfit/job/nanotrasen/janitor
	name = "Nanotrasen - Janitor"
	jobtype = /datum/job/janitor
	job_icon = "janitor"

	uniform = /obj/item/clothing/under/nanotrasen/janitor
	head = /obj/item/clothing/head/nanotrasen/cap/janitor

// Lawyer
/datum/outfit/job/nanotrasen/lawyer
	name = "Nanotrasen - Lawyer"
	job_icon = "lawyer"
	jobtype = /datum/job/lawyer

	ears = /obj/item/radio/headset/headset_srvsec
	uniform = /obj/item/clothing/under/nanotrasen/affairs
	suit = /obj/item/clothing/suit/nanotrasen/suitjacket
	shoes = /obj/item/clothing/shoes/laceup
	l_hand = /obj/item/storage/briefcase/lawyer
	l_pocket = /obj/item/laser_pointer
	r_pocket = /obj/item/clothing/accessory/lawyers_badge

	chameleon_extras = /obj/item/stamp/law

// Corp. Rep
/datum/outfit/job/nanotrasen/lawyer/corporaterepresentative
	name = "Nanotrasen - Corporate Representative"
	id_assignment = "Corporate Representative"
	job_icon = "nanotrasen"

	ears = /obj/item/radio/headset/headset_cent
	l_hand = /obj/item/clipboard
	r_pocket = /obj/item/pen/fountain

// Science //

// Scientist
/datum/outfit/job/nanotrasen/scientist
	name = "Nanotrasen - Scientist"
	jobtype = /datum/job/scientist
	job_icon = "scientist"

	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/nanotrasen/science
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/nanotrasen
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

// Roboticist
/datum/outfit/job/nanotrasen/roboticist
	name = "Nanotrasen - Roboticist"
	id_assignment = "Roboticist"
	job_icon = "roboticist"
	jobtype = /datum/job/roboticist

	uniform = /obj/item/clothing/under/nanotrasen/science/robotics
	suit = /obj/item/clothing/suit/toggle/labcoat/nanotrasen
	ears = /obj/item/radio/headset/nanotrasen
	glasses = /obj/item/clothing/glasses/welding

	backpack_contents = list(/obj/item/weldingtool/hugetank)

// Pilot. idk
/datum/outfit/job/nanotrasen/pilot
	name = "Nanotrasen - Pilot"
	id_assignment = "Pilot"

	uniform = /obj/item/clothing/under/rank/security/officer/military
	suit = /obj/item/clothing/suit/jacket/leather/duster
	glasses = /obj/item/clothing/glasses/hud/spacecop
	accessory = /obj/item/clothing/accessory/holster
	head = /obj/item/clothing/head/beret/command

// Exosuit Pilot
/datum/outfit/job/nanotrasen/security/mech_pilot
	name = "Nanotrasen - Exosuit Pilot"
	id_assignment = "Exosuit Pilot"

	uniform = /obj/item/clothing/under/rank/security/officer/military/eng
	head = /obj/item/clothing/head/beret/sec/officer
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)

// LP - for Ranger ship //

/datum/outfit/job/nanotrasen/captain/lp
	name = "Nanotrasen - Loss Prevention Lieutenant"
	id_assignment = "Lieutenant"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lplieu
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/security/head_of_security/alt/lp
	alt_uniform = /obj/item/clothing/under/rank/security/head_of_security/alt/skirt/lp
	dcoat = /obj/item/clothing/suit/armor/nanotrasen/sec_director
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/command

	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

/datum/outfit/job/nanotrasen/security/lp
	name = "Nanotrasen - LP Security Specialist"
	id_assignment = "Security Specialist"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lpsec
	belt = /obj/item/pda/security
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/security/head_of_security/nt/lp
	alt_uniform = /obj/item/clothing/under/rank/security/head_of_security/nt/skirt/lp
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/sec

	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec

/datum/outfit/job/nanotrasen/engineer/lp
	name = "Nanotrasen - LP Engineering Specialist"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lpengie
	gloves = /obj/item/clothing/gloves/color/yellow
	uniform = /obj/item/clothing/under/rank/engineering/engineer/nt/lp
	alt_uniform = /obj/item/clothing/under/rank/engineering/engineer/nt/skirt/lp
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/eng

	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

/datum/outfit/job/nanotrasen/doctor/lp
	name = "Nanotrasen - LP Medical Specialist"
	id_assignment = "Medical Specialist"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lpmed
	belt = /obj/item/pda/medical
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	uniform = /obj/item/clothing/under/rank/medical/paramedic/lp
	alt_uniform = /obj/item/clothing/under/rank/medical/paramedic/skirt/lp
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical
	shoes = /obj/item/clothing/shoes/sneakers/white
	head = /obj/item/clothing/head/beret/med

	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

// ERT //

/datum/outfit/job/nanotrasen/security/ert
	name = "Nanotrasen - ERT Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/camo
	head = null
	backpack = /obj/item/storage/backpack/ert/security
	belt = /obj/item/storage/belt/military
	id = /obj/item/card/id/ert/security
	r_pocket = /obj/item/melee/knife/survival
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)

/datum/outfit/job/nanotrasen/security/ert/engi
	name = "Nanotrasen - ERT Engineering Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/camo
	head = null
	backpack = /obj/item/storage/backpack/ert/engineer
	belt = /obj/item/storage/belt/utility/full/ert
	id = /obj/item/card/id/ert/security
	r_pocket = /obj/item/melee/knife/survival
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)
	accessory = /obj/item/clothing/accessory/armband/engine
	glasses = /obj/item/clothing/glasses/hud/diagnostic/sunglasses

/datum/outfit/job/nanotrasen/security/ert/med
	name = "Nanotrasen - ERT Medical Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/camo
	head = /obj/item/clothing/head/beret/med
	backpack = /obj/item/storage/backpack/ert/medical
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	id = /obj/item/card/id/ert/security
	r_pocket = /obj/item/melee/knife/survival
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)
	accessory = /obj/item/clothing/accessory/armband/med
	glasses = /obj/item/clothing/glasses/hud/health/night
