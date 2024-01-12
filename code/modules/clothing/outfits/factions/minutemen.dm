//top outfit of everything Minuteman. Touch at own risk.

/datum/outfit/job/minutemen
	name = "Minutemen - Base Outfit"

	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	alt_uniform = null

	faction_icon = "bg_minutemen"

	backpack = /obj/item/storage/backpack/security/cmm
	satchel = /obj/item/storage/backpack/satchel/sec/cmm
	duffelbag = /obj/item/storage/backpack/duffelbag //to-do: bug rye for cmm duffles // rye. rye. give me 20 pound bag of ice
	satchel = /obj/item/storage/backpack/messenger //and these

	box = /obj/item/storage/box/survival

/datum/outfit/job/minutemen/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_PLAYER_MINUTEMAN)

///assistant

/datum/outfit/job/minutemen/assistant
	name = "Minutemen - Volunteer"
	job_icon = "assistant"
	jobtype = /datum/job/assistant

	r_pocket = /obj/item/radio

///captains

/datum/outfit/job/minutemen/captain
	name = "Minutemen - Captain"
	job_icon = "captain"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	gloves = /obj/item/clothing/gloves/color/captain


	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	ears = /obj/item/radio/headset/minutemen/alt/captain
	uniform = /obj/item/clothing/under/rank/command/minutemen
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/minutemen
	alt_suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain

	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/cowboy/sec/minutemen
	backpack = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

/datum/outfit/job/minutemen/captain/general
	name = "Minutemen - General"

	head = /obj/item/clothing/head/caphat/minutemen
	ears = /obj/item/radio/headset/minutemen/alt/captain
	uniform = /obj/item/clothing/under/rank/command/minutemen
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/minutemen
	shoes = /obj/item/clothing/shoes/combat

	box = /obj/item/storage/box/survival/engineer/radio
	backpack = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/gun/ballistic/revolver/mateba=1)

///chemist

/datum/outfit/job/minutemen/chemist
	name = "Minutemen - Chemical Scientist"
	job_icon = "chemist"
	jobtype = /datum/job/chemist

	glasses = /obj/item/clothing/glasses/science
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat/chemist

	backpack = /obj/item/storage/backpack/chemistry
	satchel = /obj/item/storage/backpack/satchel/chem
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/chem

	box = /obj/item/storage/box/survival/medical
	chameleon_extras = /obj/item/gun/syringe

///Chief Engineer

/datum/outfit/job/minutemen/ce
	name = "Minutemen - Foreman"
	job_icon = "chiefengineer"
	jobtype = /datum/job/chief_engineer

	id = /obj/item/card/id/silver

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer

	chameleon_extras = /obj/item/stamp/ce


	ears = /obj/item/radio/headset/minutemen/alt
	uniform = /obj/item/clothing/under/rank/command/minutemen
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/minutemen
	alt_suit = null
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/cowboy/sec/minutemen
	backpack = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic=1,
		/obj/item/modular_computer/tablet/preset/advanced = 1
	)

/// Head Of Personnel

/datum/outfit/job/minutemen/head_of_personnel
	name = "Minutemen - Bridge Officer"
	job_icon = "headofpersonnel"
	jobtype = /datum/job/head_of_personnel

	id = /obj/item/card/id/silver

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/head_of_personnel)

	ears = /obj/item/radio/headset/minutemen/alt
	uniform = /obj/item/clothing/under/rank/command/minutemen
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/minutemen
	alt_suit = null

	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/cowboy/sec/minutemen
	backpack = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

/// Medical Doctor
/datum/outfit/job/minutemen/doctor
	name = "Minutemen - Field Medic"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor

	l_hand = /obj/item/storage/firstaid/medical
	suit_store = /obj/item/flashlight/pen

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	accessory = /obj/item/clothing/accessory/armband/medblue
	shoes = /obj/item/clothing/shoes/sneakers/white
	head = /obj/item/clothing/head/beret/med
	suit = null
	suit_store = null

///paramedic
/datum/outfit/job/minutemen/paramedic
	name = "Minutemen - BARD Combat Medic"
	job_icon = "paramedic"
	jobtype = /datum/job/paramedic


	uniform = /obj/item/clothing/under/rank/medical/paramedic/emt
	head = /obj/item/clothing/head/soft/paramedic
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/sneakers/blue
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/storage/belt/medical/paramedic
	suit_store = /obj/item/flashlight/pen
	backpack_contents = list(/obj/item/roller=1)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para

	box = /obj/item/storage/box/survival/medical

///roboticist
/datum/outfit/job/minutemen/roboticist
	name = "Minutemen - Mech Technician"
	job_icon = "roboticist"
	jobtype = /datum/job/roboticist

	belt = /obj/item/storage/belt/utility/full

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox


	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/minutemen
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	alt_suit = /obj/item/clothing/suit/toggle/suspenders/gray

///scientist
/datum/outfit/job/minutemen/scientist
	name = "Minutemen - Scientist"
	job_icon = "scientist"
	jobtype = /datum/job/scientist

	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	backpack = /obj/item/storage/backpack/security/cmm

	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	alt_suit = /obj/item/clothing/suit/toggle/suspenders/blue

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

//security officers

/datum/outfit/job/minutemen/security
	name = "Minutemen - Minuteman"
	job_icon = "securityofficer"
	jobtype = /datum/job/officer

	head = /obj/item/clothing/head/helmet/bulletproof/minutemen
	mask = /obj/item/clothing/mask/gas/sechailer/minutemen
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	alt_suit = null
	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/alt

	belt = /obj/item/storage/belt/military/minutemen

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	box = /obj/item/storage/box/survival/engineer/radio
	backpack_contents = null

/datum/outfit/job/minutemen/security/armed
	name = "Minutemen - Minuteman (Armed)"

	suit_store = /obj/item/gun/ballistic/automatic/assault/p16/minutemen
	belt = /obj/item/storage/belt/military/minutemen/p16

/datum/outfit/job/minutemen/security/mech_pilot
	name = "Minutemen - Mech Pilot"

	suit = /obj/item/clothing/suit/armor/vest/alt
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	glasses = /obj/item/clothing/glasses/hud/diagnostic

///miners

/datum/outfit/job/minutemen/miner
	name = "Minutemen - Industrial Miner"
	job_icon = "shaftminer"
	jobtype = /datum/job/mining

	l_pocket = /obj/item/reagent_containers/hypospray/medipen/survival
	uniform = /obj/item/clothing/under/rank/cargo/miner/hazard
	alt_uniform = null
	alt_suit = /obj/item/clothing/suit/toggle/hazard

	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/combat
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,
		/obj/item/stack/marker_beacon/ten=1,
		/obj/item/weldingtool=1
		)

///engineers

/datum/outfit/job/minutemen/engineer
	name = "Minutemen - Mechanic"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	belt = /obj/item/storage/belt/utility/full/engi
	shoes = /obj/item/clothing/shoes/workboots
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	accessory = /obj/item/clothing/accessory/armband/engine
	head = /obj/item/clothing/head/hardhat/dblue
	suit =  /obj/item/clothing/suit/hazardvest

	box = /obj/item/storage/box/survival/engineer
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)


///warden

/datum/outfit/job/minutemen/warden
	name = "Minutemen - Field Commander"
	job_icon = "warden"
	jobtype = /datum/job/warden

	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/minutemen/alt
	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	accessory = /obj/item/clothing/accessory/armband
	head = /obj/item/clothing/head/cowboy/sec/minutemen
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	belt = /obj/item/storage/belt/military/minutemen
	shoes = /obj/item/clothing/shoes/combat

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	box = /obj/item/storage/box/survival/engineer/radio
	backpack = /obj/item/storage/backpack
	backpack_contents = null

/datum/outfit/job/minutemen/warden/armed
	name = "Minutemen - Field Commander (Armed)"

	suit_store = /obj/item/gun/ballistic/automatic/assault/p16/minutemen
	belt = /obj/item/storage/belt/military/minutemen/p16

	backpack_contents = list(/obj/item/melee/classic_baton=1, /obj/item/gun/ballistic/automatic/pistol/commander=1, /obj/item/restraints/handcuffs=1, /obj/item/gun/energy/e_gun/advtaser=1)
