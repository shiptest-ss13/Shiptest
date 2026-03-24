/*
 * OUTFIT DATUMS THAT NEED MAKING:
 * Research Director
 * Medical Director
*/

/datum/outfit/job/warra
	name = "Makosso-Warra - Base Outfit"
	faction = FACTION_PLAYER_WARRA
	faction_icon = "bg_warra"

	box = /obj/item/storage/box/survival
	id = /obj/item/card/id

// Command //

// Captain
/datum/outfit/job/warra/captain
	name = "Makosso-Warra - Captain"
	job_icon = "captain"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/color/captain/warra
	ears = /obj/item/radio/headset/warra/captain
	uniform = /obj/item/clothing/under/warra/captain
	alt_uniform = /obj/item/clothing/under/warra/captain/skirt
	suit = /obj/item/clothing/suit/armor/warra/captain
	alt_suit = /obj/item/clothing/suit/armor/warra/captain/parade
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain
	shoes = /obj/item/clothing/shoes/laceup
	neck = /obj/item/clothing/neck/cloak/warra
	head = /obj/item/clothing/head/warra/captain/peaked
	box = /obj/item/storage/box/survival/command
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	chameleon_extras = list(/obj/item/gun/energy/sharplite/x12, /obj/item/stamp/captain)


/datum/outfit/job/warra/captain/ns
	name = "Makosso-Warra - Captain (N+S Logistics)"

	head = /obj/item/clothing/head/warra/cap/supply
	uniform = /obj/item/clothing/under/warra/supply/qm
	suit = null
	alt_suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo
	shoes = /obj/item/clothing/shoes/sneakers/brown
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = null
	neck = null
	l_hand = /obj/item/clipboard

	chameleon_extras = /obj/item/stamp/qm

/datum/outfit/job/warra/captain/empty
	name = "Makosso-Warra - Captain (Naked)"

	head = null
	suit = null
	alt_suit = null
	glasses = null
	gloves = null
	neck = null
	l_hand = null
	belt = null
	backpack_contents = null

/datum/outfit/job/warra/captain/ns/empty
	name = "Makosso-Warra - Captain (N+S Logistics) (Naked)"

	head = null
	uniform = /obj/item/clothing/under/warra/supply/qm
	suit = null
	alt_suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo
	shoes = /obj/item/clothing/shoes/sneakers/brown
	glasses = null
	gloves = null
	neck = null
	l_hand = null
	belt = null

	chameleon_extras = /obj/item/stamp/qm

/datum/outfit/job/warra/captain/vi
	name = "Makosso-Warra - Captain (Vigilitas Interstellar)"

	id = /obj/item/card/id/gold
	head = /obj/item/clothing/head/warra/beret/security/command
	uniform = /obj/item/clothing/under/warra/security/director
	suit = /obj/item/clothing/suit/armor/warra/sec_director
	alt_suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/warra/alt/captain
	neck = null
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/vi/command

	chameleon_extras = /obj/item/stamp/warra/vigilitas/captain

/datum/outfit/job/warra/captain/vi/empty
	name = "Makosso-Warra - Captain (Vigilitas Interstellar) (Naked)"

	head = null
	suit = null
	ears = null
	alt_suit = null
	glasses = null
	gloves = null
	neck = null
	belt = null
	backpack_contents = null

/datum/outfit/job/warra/captain/centcom
	name = "Makosso-Warra - Captain (Central Command)"

	uniform = /obj/item/clothing/under/rank/centcom/officer
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/centhat

// Head of Personnel
/datum/outfit/job/warra/hop
	name = "Makosso-Warra - Head of Personnel"
	job_icon = "headofpersonnel"
	jobtype = /datum/job/head_of_personnel

	belt = /obj/item/pda/heads/head_of_personnel
	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/warra/officer
	alt_uniform = /obj/item/clothing/under/warra/officer/skirt
	suit = /obj/item/clothing/suit/toggle/warra
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/warra/officer

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
						/obj/item/gun/energy/sharplite/x12,
						/obj/item/stamp/warra/officer,
						)

/datum/outfit/job/warra/hop/empty
	name = "Makosso-Warra - Head of Personnel (Naked)"

	belt = null
	suit = null
	head = null

	backpack_contents = null

// Head of Security
/datum/outfit/job/warra/hos
	name = "Makosso-Warra - Head of Security"
	job_icon = "headofsecurity"
	jobtype = /datum/job/hos

	id = /obj/item/card/id/silver
	belt = /obj/item/pda/heads/hos
	ears = /obj/item/radio/headset/warra/alt
	uniform = /obj/item/clothing/under/warra/security/director
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/warra/slim
	alt_suit = /obj/item/clothing/suit/armor/warra/sec_director
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/warra/beret/security/command
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

	chameleon_extras = list(/obj/item/gun/energy/sharplite/x01, /obj/item/stamp/hos)

/datum/outfit/job/warra/hos/vi
	name = "Makosso-Warra - Vigilitas Sergeant"

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/warra/alt
	uniform = /obj/item/clothing/under/warra/security/director
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/combat
	suit = null
	alt_suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/warra/beret/security/command
	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(/obj/item/melee/classic_baton=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/vi

	chameleon_extras = /obj/item/stamp/warra/vigilitas/security

/datum/outfit/job/warra/hos/vi/empty
	name = "Makosso-Warra - Vigilitas Sergeant (Naked)"

	head = null
	suit = null
	ears = null
	alt_suit = null
	glasses = null
	gloves = null
	neck = null
	r_pocket = null
	l_pocket = null
	belt = null
	backpack_contents = null

// Security Officer
/datum/outfit/job/warra/security
	name = "Makosso-Warra - Security Officer"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	ears = /obj/item/radio/headset/alt
	uniform = /obj/item/clothing/under/warra/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/warra/cap/security
	suit = /obj/item/clothing/suit/armor/warra
	alt_suit = /obj/item/clothing/suit/armor/warra/slim
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

	chameleon_extras = list(/obj/item/gun/energy/disabler, /obj/item/clothing/glasses/hud/security/sunglasses)

/datum/outfit/job/warra/security/vi
	name = "Makosso-Warra - Security Officer (Vigilatis Interstellar)"
	job_icon = "securityofficer"

	ears = /obj/item/radio/headset/alt
	uniform = /obj/item/clothing/under/warra/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/warra/cap/security
	suit = null
	alt_suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/restraints/handcuffs

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/vi

	chameleon_extras = null

/datum/outfit/job/warra/security/disarmed
	name = "Makosso-Warra - Security Officer (Disarmed)"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	suit = null
	chameleon_extras = null

/datum/outfit/job/warra/security/empty
	name = "Makosso-Warra - Security Officer (Naked)"

	gloves = null
	head = null
	suit = null
	alt_suit = null
	l_pocket = null
	r_pocket = null
	backpack_contents = null

// Warden
/datum/outfit/job/warra/warden
	name = "Makosso-Warra - Warden"
	job_icon = "warden"
	jobtype = /datum/job/warden

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/warden/warra
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/security/warden/alt/warra
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
/datum/outfit/job/warra/engineer
	name = "Makosso-Warra - Engineer"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	belt = /obj/item/storage/belt/utility/full/engi
	l_pocket = /obj/item/pda/engineering
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/warra/engineering
	head = /obj/item/clothing/head/hardhat/warra
	suit = /obj/item/clothing/suit/warra/vest
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/workboots
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

/datum/outfit/job/warra/engineer/empty
	name = "Makosso-Warra - Engineer (Naked)"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	belt = null
	l_pocket = null
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/warra/engineering
	head = null
	suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/workboots
	r_pocket = null

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

// Chief Engineer
/datum/outfit/job/warra/ce
	name = "Makosso-Warra - Chief Engineer"
	jobtype = /datum/job/chief_engineer
	job_icon = "chiefengineer"

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/chief/full
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/warra/engineering/director
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hardhat/warra/white
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
/datum/outfit/job/warra/atmos
	name = "Makosso-Warra - Atmos Tech"
	jobtype = /datum/job/atmos
	job_icon = "atmospherictechnician"

	belt = /obj/item/storage/belt/utility/atmostech
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/warra/engineering/atmos
	head = /obj/item/clothing/head/hardhat/warra/blue
	suit = /obj/item/clothing/suit/warra/vest/blue
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi
	box = /obj/item/storage/box/survival/engineer
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

// Brig Physician

/datum/outfit/job/warra/brig_phys
	name = "Makosso-Warra - Brig Physician"
	jobtype = /datum/job/brig_phys
	job_icon = "brigphysician"

	ears = /obj/item/radio/headset/headset_medsec/alt
	uniform = /obj/item/clothing/under/rank/security/brig_phys/warra
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	suit = /obj/item/clothing/suit/toggle/labcoat/brig_phys
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	head = /obj/item/clothing/head/soft/sec/brig_phys
	implants = list(/obj/item/implant/mindshield)

// Supply //

// Quartermaster
/datum/outfit/job/warra/quartermaster
	name = "Makosso-Warra - Quartermaster"
	jobtype = /datum/job/qm
	job_icon = "quartermaster"

	ears = /obj/item/radio/headset/headset_cargo
	head = /obj/item/clothing/head/warra/cap/supply
	uniform = /obj/item/clothing/under/warra/supply/qm
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo
	shoes = /obj/item/clothing/shoes/sneakers/brown
	glasses = /obj/item/clothing/glasses/sunglasses
	l_hand = /obj/item/clipboard
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1)

	chameleon_extras = /obj/item/stamp/qm

//Lead Miner

/datum/outfit/job/warra/quartermaster/leadminer
	name = "Makosso-Warra - Lead Miner"
	jobtype = /datum/job/qm
	job_icon = "shaftminer"

	ears = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	head = /obj/item/clothing/head/hardhat/warra/white
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/warra/supply/miner
	suit = /obj/item/clothing/suit/warra/vest/blue
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/miner
	r_pocket = /obj/item/storage/bag/ore
	glasses = null
	l_hand = null

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

/datum/outfit/job/warra/quartermaster/leadminer/empty
	name = "Makosso-Warra - Lead Miner (Naked)"
	jobtype = /datum/job/qm
	job_icon = "shaftminer"

	ears = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	head = null
	gloves = null
	uniform = /obj/item/clothing/under/warra/supply/miner
	suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/miner
	r_pocket = null
	glasses = null
	l_hand = null

	backpack_contents = null

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag
	box = /obj/item/storage/box/survival/mining

	chameleon_extras = /obj/item/gun/energy/kinetic_accelerator

//Miner
/datum/outfit/job/warra/miner
	name = "Makosso-Warra - Miner"
	jobtype = /datum/job/mining
	job_icon = "shaftminer"

	ears = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	head = /obj/item/clothing/head/hardhat/warra
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/warra/supply/miner
	suit = /obj/item/clothing/suit/warra/vest
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

/datum/outfit/job/warra/miner/empty
	name = "Makosso-Warra - Miner (Naked)"

	head = null
	gloves = null
	suit = null
	r_pocket = null
	backpack_contents = null

/datum/outfit/job/warra/miner/no_equipment
	name = "Makosso-Warra - Miner (No Equipment)"

	r_pocket = null
	backpack_contents = null

// Cargo Tech
/datum/outfit/job/warra/cargo_tech
	name = "Makosso-Warra - Cargo Tech"
	jobtype = /datum/job/cargo_tech
	job_icon = "cargotechnician"

	belt = /obj/item/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	head = /obj/item/clothing/head/warra/cap/supply
	uniform = /obj/item/clothing/under/warra/supply
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1)

/datum/outfit/job/warra/cargo_tech/empty
	name = "Makosso-Warra - Cargo Tech (Naked)"
	jobtype = /datum/job/cargo_tech
	job_icon = "cargotechnician"

	belt = null
	ears = /obj/item/radio/headset/headset_cargo
	head = null
	uniform = /obj/item/clothing/under/warra/supply
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo
	backpack_contents = null

// Medical //

// Medical Doctor
/datum/outfit/job/warra/doctor
	name = "Makosso-Warra - Medical Doctor"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor

	belt = /obj/item/pda/medical
	ears = /obj/item/radio/headset/headset_med
	head = /obj/item/clothing/head/warra/surgical
	uniform = /obj/item/clothing/under/warra/medical
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/warra/medical_smock
	alt_suit = /obj/item/clothing/suit/toggle/labcoat/warra
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

/datum/outfit/job/warra/doctor/empty
	name = "Makosso-Warra - Medical Doctor (Naked)"

	belt = null
	head = null
	suit =  null
	alt_suit = null

// Paramedic
/datum/outfit/job/warra/paramedic
	name = "Makosso-Warra - Paramedic"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/warra/medical/paramedic
	head = /obj/item/clothing/head/warra/cap/medical
	shoes = /obj/item/clothing/shoes/sneakers/blue
	suit =  /obj/item/clothing/suit/toggle/labcoat/warra/paramedic
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

/datum/outfit/job/warra/paramedic/empty
	name = "Makosso-Warra - Paramedic (Naked)"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/warra/medical/paramedic
	head = null
	shoes = /obj/item/clothing/shoes/sneakers/blue
	suit =  null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical/paramedic
	gloves = null
	id = /obj/item/card/id

	backpack_contents = null

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

// Civilian //

// Assistant
/datum/outfit/job/warra/assistant
	name = "Makosso-Warra - Assistant"
	jobtype = /datum/job/assistant
	job_icon = "assistant"

	uniform = /obj/item/clothing/under/warra
	shoes = /obj/item/clothing/shoes/sneakers/black
	belt = /obj/item/pda

/datum/outfit/job/warra/assistant/empty
	name = "Makosso-Warra - Assistant (Naked)"
	jobtype = /datum/job/assistant
	job_icon = "assistant"

	uniform = /obj/item/clothing/under/warra
	shoes = /obj/item/clothing/shoes/sneakers/black
	belt = null

// Janitor
/datum/outfit/job/warra/janitor
	name = "Makosso-Warra - Janitor"
	jobtype = /datum/job/janitor
	job_icon = "janitor"

	uniform = /obj/item/clothing/under/warra/janitor
	head = /obj/item/clothing/head/warra/cap/janitor

// Lawyer
/datum/outfit/job/warra/lawyer
	name = "Makosso-Warra - Lawyer"
	job_icon = "lawyer"
	jobtype = /datum/job/lawyer

	ears = /obj/item/radio/headset/headset_srvsec
	uniform = /obj/item/clothing/under/warra/affairs
	suit = /obj/item/clothing/suit/warra/suitjacket
	shoes = /obj/item/clothing/shoes/laceup
	l_hand = /obj/item/storage/briefcase/lawyer
	l_pocket = /obj/item/laser_pointer
	r_pocket = /obj/item/clothing/accessory/lawyers_badge

// Corp. Rep
/datum/outfit/job/warra/lawyer/corporaterepresentative
	name = "Makosso-Warra - Corporate Representative"
	id_assignment = "Corporate Representative"
	job_icon = "warra"

	ears = /obj/item/radio/headset/headset_cent
	l_hand = /obj/item/clipboard
	r_pocket = /obj/item/pen/fountain

// Science //

// Scientist
/datum/outfit/job/warra/scientist
	name = "Makosso-Warra - Scientist"
	jobtype = /datum/job/scientist
	job_icon = "scientist"

	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/warra/science
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/warra
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

// Roboticist
/datum/outfit/job/warra/roboticist
	name = "Makosso-Warra - Roboticist"
	id_assignment = "Roboticist"
	job_icon = "roboticist"
	jobtype = /datum/job/roboticist

	uniform = /obj/item/clothing/under/warra/science/robotics
	suit = /obj/item/clothing/suit/toggle/labcoat/warra
	ears = /obj/item/radio/headset/warra
	glasses = /obj/item/clothing/glasses/welding

	backpack_contents = list(/obj/item/weldingtool/hugetank)

// Pilot. idk
/datum/outfit/job/warra/pilot
	name = "Makosso-Warra - Pilot"
	id_assignment = "Pilot"
	jobtype = /datum/job/head_of_personnel


	uniform = /obj/item/clothing/under/rank/security/officer/military
	suit = /obj/item/clothing/suit/jacket/leather/duster
	glasses = /obj/item/clothing/glasses/hud/spacecop
	accessory = /obj/item/clothing/accessory/holster
	head = /obj/item/clothing/head/beret/command

// Exosuit Pilot
/datum/outfit/job/warra/security/mech_pilot
	name = "Makosso-Warra - Exosuit Pilot"
	id_assignment = "Exosuit Pilot"

	uniform = /obj/item/clothing/under/rank/security/officer/military/eng
	head = /obj/item/clothing/head/beret/sec/officer
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)

// LP - for Ranger ship //

/datum/outfit/job/warra/captain/lp
	name = "Makosso-Warra - Loss Prevention Lieutenant"
	id_assignment = "Lieutenant"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/warra/alt/captain
	id = /obj/item/card/id/lplieu
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/security/head_of_security/alt/lp
	alt_uniform = /obj/item/clothing/under/rank/security/head_of_security/alt/skirt/lp
	dcoat = /obj/item/clothing/suit/armor/warra/sec_director
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/command

	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

/datum/outfit/job/warra/security/lp
	name = "Makosso-Warra - LP Security Specialist"
	id_assignment = "Security Specialist"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/warra/alt/captain
	id = /obj/item/card/id/lpsec
	belt = /obj/item/pda/security
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/security/head_of_security/warra/lp
	alt_uniform = /obj/item/clothing/under/rank/security/head_of_security/warra/skirt/lp
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/sec

	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec

/datum/outfit/job/warra/engineer/lp
	name = "Makosso-Warra - LP Engineering Specialist"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/warra/alt/captain
	id = /obj/item/card/id/lpengie
	gloves = /obj/item/clothing/gloves/color/yellow
	uniform = /obj/item/clothing/under/rank/engineering/engineer/warra/lp
	alt_uniform = /obj/item/clothing/under/rank/engineering/engineer/warra/skirt/lp
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/eng

	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

/datum/outfit/job/warra/doctor/lp
	name = "Makosso-Warra - LP Medical Specialist"
	id_assignment = "Medical Specialist"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/warra/alt/captain
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

/datum/outfit/job/warra/security/ert
	name = "Makosso-Warra - ERT Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/camo
	head = null
	backpack = /obj/item/storage/backpack/ert/security
	belt = /obj/item/storage/belt/military
	id = /obj/item/card/id/ert/security
	r_pocket = /obj/item/melee/knife/survival
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)

/datum/outfit/job/warra/security/ert/engi
	name = "Makosso-Warra - ERT Engineering Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/camo
	head = null
	backpack = /obj/item/storage/backpack/ert/engineer
	belt = /obj/item/storage/belt/utility/full/ert
	id = /obj/item/card/id/ert/security
	r_pocket = /obj/item/melee/knife/survival
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)
	accessory = /obj/item/clothing/accessory/armband/engine
	glasses = /obj/item/clothing/glasses/hud/diagnostic/sunglasses

/datum/outfit/job/warra/security/ert/med
	name = "Makosso-Warra - ERT Medical Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/camo
	head = /obj/item/clothing/head/beret/med
	backpack = /obj/item/storage/backpack/ert/medical
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	id = /obj/item/card/id/ert/security
	r_pocket = /obj/item/melee/knife/survival
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)
	accessory = /obj/item/clothing/accessory/armband/med
	glasses = /obj/item/clothing/glasses/hud/health/night
