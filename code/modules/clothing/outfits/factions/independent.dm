/datum/outfit/job/independent
	name = "Independent - Base Outfit"
	faction_icon = "bg_indie"

	uniform = /obj/item/clothing/under/utility
	box = /obj/item/storage/box/survival
	id = /obj/item/card/id

// Assistant

/datum/outfit/job/independent/assistant
	name = "Independent - Assistant"
	jobtype = /datum/job/assistant
	job_icon = "assistant"

	uniform = /obj/item/clothing/under/color/black
	shoes = /obj/item/clothing/shoes/sneakers/black

/datum/outfit/job/independent/assistant/waiter
	name = "Independent - Assistant (Waiter)"

	uniform = /obj/item/clothing/under/suit/waiter
	alt_uniform = /obj/item/clothing/under/suit/waiter/syndicate
	gloves = /obj/item/clothing/gloves/color/evening
	ears = /obj/item/radio/headset/headset_srv
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/lighter
	r_pocket = /obj/item/reagent_containers/glass/rag

/datum/outfit/job/independent/assistant/cheap //for Miskilamo ships
	name = "Independent - Assistant (Low Budget)"

	uniform = /obj/item/clothing/under/utility

/datum/outfit/job/independent/assistant/waiter/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	var/obj/item/card/id/W = H.get_idcard()
	W.access += list(ACCESS_KITCHEN)

/datum/outfit/job/independent/assistant/fancy //for ISF ships
	name = "Independent - Assistant (Fancy)"

	shoes = /obj/item/clothing/shoes/laceup
	uniform = /obj/item/clothing/under/suit/black_really

/datum/outfit/job/independent/assistant/pirate
	name = "Independent - Assistant (Pirate)"

	uniform = /obj/item/clothing/under/costume/pirate
	suit = /obj/item/clothing/suit/pirate
	head = /obj/item/clothing/head/bandana

/datum/outfit/job/independent/assistant/pirate/jupiter
	name = "Independent - Assistant (Nodesman)" // technically, this is part of SEC, but we have jackshit for SEC

	uniform = /obj/item/clothing/under/utility
	head = /obj/item/clothing/head/soft/black
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/melee/knife/survival
	gloves = /obj/item/clothing/gloves/combat
	implants = list(/obj/item/implant/radio)

/datum/outfit/job/independent/assistant/artist
	name = "Independent - Assistant (Artist)"

	uniform = /obj/item/clothing/under/suit/burgundy
	suit = /obj/item/clothing/suit/toggle/suspenders
	head = /obj/item/clothing/head/beret/black
	shoes = /obj/item/clothing/shoes/laceup
	gloves = /obj/item/clothing/gloves/color/white
	accessory = /obj/item/clothing/neck/scarf/darkblue

/datum/outfit/job/independent/assistant/pharma
	name = "Independent - Assistant (Pharmacology Student)"

	uniform = /obj/item/clothing/under/rank/medical/chemist
	shoes = /obj/item/clothing/shoes/sneakers/white
	accessory = /obj/item/clothing/neck/scarf/orange
	l_pocket = /obj/item/reagent_containers/pill/floorpill
	belt = /obj/item/reagent_scanner
	backpack_contents = list(/obj/item/book/manual/wiki/chemistry=1)

/datum/outfit/job/independent/assistant/gown
	name = "Independent - Assistant (Gown)"

	uniform = /obj/item/clothing/under/rank/medical/gown
	dcoat = null
	shoes = /obj/item/clothing/shoes/sandal/slippers

// Captain

/datum/outfit/job/independent/captain
	name = "Independent - Captain"
	job_icon = "captain"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	gloves = /obj/item/clothing/gloves/color/captain
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/rank/command/captain
	suit = /obj/item/clothing/suit/armor/captaincoat
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/caphat
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	chameleon_extras = list(/obj/item/gun/energy/sharplite/x12, /obj/item/stamp/captain)

/datum/outfit/job/independent/captain/empty
	name = "Independent - Captain (Naked)"
	job_icon = "captain"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	gloves = null
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/rank/command/captain
	suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/laceup
	head = null
	backpack_contents = null

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	chameleon_extras = list(/obj/item/gun/energy/sharplite/x12, /obj/item/stamp/captain)

/datum/outfit/job/independent/captain/cheap //for Miskilamo ships
	name = "Independent - Captain (Low Budget)"
	gloves = /obj/item/clothing/gloves/color/white //poverty gloves
	shoes = /obj/item/clothing/shoes/sneakers/brown

/datum/outfit/job/independent/captain/merc
	name = "Independent - Captain (Mercenary)"

	uniform = /obj/item/clothing/under/syndicate
	head = /obj/item/clothing/head/beret
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat
	suit = /obj/item/clothing/suit/armor/vest

	accessory = null

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec

/datum/outfit/job/independent/captain/western
	name = "Independent - Captain (Western)"
	head = /obj/item/clothing/head/caphat/cowboy
	shoes = /obj/item/clothing/shoes/cowboy/fancy
	glasses = /obj/item/clothing/glasses/sunglasses

/datum/outfit/job/independent/captain/masinyane
	name = "Independent - Captain (Masinyane)"
	uniform = /obj/item/clothing/under/suit/black
	head = null
	belt = null
	gloves = null
	shoes = /obj/item/clothing/shoes/laceup

	backpack_contents = list(/obj/item/clothing/accessory/medal/gold/captain=1, /obj/item/spacecash/bundle/c10000=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel/
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

/datum/outfit/job/independent/captain/pirate
	name = "Captain (Pirate)"

	ears = /obj/item/radio/headset/pirate/captain
	uniform = /obj/item/clothing/under/costume/pirate
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/pirate/captain
	suit = /obj/item/clothing/suit/pirate/captain

/datum/outfit/job/independent/captain/pirate/jupiter
	name = "Independent - Captain (Nodesman)" // technically, this is part of SEC, but we have jackshit for SEC

	uniform = /obj/item/clothing/under/utility
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/vest/marine/medium
	head = /obj/item/clothing/head/soft/black
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/melee/knife/combat
	implants = list(/obj/item/implant/radio)
	accessory = null

/datum/outfit/job/independent/captain/manager
	name = "Independent - Captain (Manager)"

	id = /obj/item/card/id
	gloves = /obj/item/clothing/gloves/color/white
	uniform = /obj/item/clothing/under/rank/security/detective/grey
	suit = /obj/item/clothing/suit/lawyer/charcoal
	neck = /obj/item/clothing/neck/tie/black
	dcoat = null
	glasses = /obj/item/clothing/glasses/sunglasses
	head = null
	accessory = null

/datum/outfit/job/independent/captain/gown
	name = "Independent - Captain (Gown)"

	gloves = null
	ears = null
	uniform = /obj/item/clothing/under/rank/medical/gown
	suit = null
	dcoat = null
	shoes = /obj/item/clothing/shoes/sandal/slippers
	head = null
	backpack_contents = null

	accessory = null

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

// Head of Personnel

/datum/outfit/job/independent/hop
	name = "Independent - Head of Personnel"
	job_icon = "headofpersonnel"
	jobtype = /datum/job/head_of_personnel

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/rank/command/head_of_personnel
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain
	shoes = /obj/item/clothing/shoes/sneakers/brown

	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	chameleon_extras = list(/obj/item/gun/energy/sharplite/x12, /obj/item/stamp/officer)

/datum/outfit/job/independent/hop/hunter
	name = "Independent - Head of Personnel (Hunter)"

	uniform = /obj/item/clothing/under/syndicate/camo
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/explorer
	glasses = /obj/item/clothing/glasses/sunglasses
	suit = /obj/item/clothing/suit/armor/vest/duster
	alt_suit = /obj/item/clothing/suit/armor/vest/alt

	backpack_contents = null

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

/datum/outfit/job/independent/hop/western
	name = "Independent - Head of Personnel (Western)"

	uniform = /obj/item/clothing/under/rank/security/detective/grey
	shoes = /obj/item/clothing/shoes/cowboy/black
	accessory = /obj/item/clothing/accessory/waistcoat
	head = /obj/item/clothing/head/cowboy

/datum/outfit/job/independent/hop/pirate
	name = "Independent - Head of Personnel (Pirate)"

	ears = /obj/item/radio/headset/pirate
	uniform = /obj/item/clothing/under/costume/pirate
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/pirate
	suit = /obj/item/clothing/suit/pirate

// Head of Security

/datum/outfit/job/independent/hos
	name = "Independent - Head of Security"
	job_icon = "headofsecurity"
	jobtype = /datum/job/hos

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/rank/security/head_of_security
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/hos/trenchcoat
	alt_suit = /obj/item/clothing/suit/armor/vest/security/hos
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/beret/sec/hos
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	suit_store = null
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(/obj/item/melee/classic_baton=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/security

	chameleon_extras = list(/obj/item/gun/energy/sharplite/x01, /obj/item/stamp/hos)

/datum/outfit/job/independent/hos/merc
	name = "Independent - Mercenary XO"
	id_assignment = "Lieutenant"

	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	suit = /obj/item/clothing/suit/armor/vest
	alt_suit = null
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/beret
	glasses = null
	l_pocket = null

// Roboticist

/datum/outfit/job/independent/roboticist
	name = "Independent - Roboticist"
	job_icon = "roboticist"
	jobtype = /datum/job/roboticist

	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/rnd/roboticist
	suit = /obj/item/clothing/suit/toggle/labcoat
	alt_suit = /obj/item/clothing/suit/toggle/suspenders/gray
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

// Security Officer

/datum/outfit/job/independent/security
	name = "Independent - Security Officer"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	ears = /obj/item/radio/headset/alt
	uniform = /obj/item/clothing/under/rank/security/officer
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/m10
	suit = /obj/item/clothing/suit/armor/vest/alt
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = null

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/security

	chameleon_extras = list(/obj/item/gun/energy/disabler, /obj/item/clothing/glasses/hud/security/sunglasses, /obj/item/clothing/head/helmet)
	//The helmet is necessary because /obj/item/clothing/head/helmet/m10 is overwritten in the chameleon list by the standard helmet, which has the same name and icon state

/datum/outfit/job/independent/security/disarmed //No armor, no pocket handcuffs.
	name = "Independent - Security Officer (Disarmed)"
	head = null
	suit = null
	l_pocket = null


/datum/outfit/job/independent/security/western
	name = "Independent - Security Officer (Western)"

	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/cowboy/sec

/datum/outfit/job/independent/security/merc
	name = "Independent - Security Officer (Mercenary)"
	id_assignment = "Trooper"

	uniform = /obj/item/clothing/under/rank/security/officer/camo
	gloves = /obj/item/clothing/gloves/fingerless
	head = null
	suit = null
	dcoat = null


/datum/outfit/job/independent/security/pirate
	name = "Independent - Security Officer (Pirate)"

	ears = /obj/item/radio/headset/pirate
	uniform = /obj/item/clothing/under/syndicate/camo
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/bandana
	suit = /obj/item/clothing/suit/armor/vest

/datum/outfit/job/independent/security/pirate/jupiter
	name = "Independent - Security Officer (Nodesman)" // technically, this is part of SEC, but we have jackshit for SEC

	uniform = /obj/item/clothing/under/utility
	head = /obj/item/clothing/head/soft/black
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/melee/knife/combat

	backpack_contents = list(/obj/item/melee/baton/loaded=1)

	implants = list(/obj/item/implant/radio)

// Engineer

/datum/outfit/job/independent/engineer
	name = "Independent - Engineer"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	belt = null
	gloves = null
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/overalls/olive
	alt_uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/workboots
	head = null

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

/datum/outfit/job/independent/engineer/salvage
	name = "Independent - Engineer (Salvager)"

	belt = null
	l_pocket = null

/datum/outfit/job/independent/engineer/pirate
	name = "Independent - Engineer (Pirate)"

	ears = /obj/item/radio/headset/pirate
	uniform = /obj/item/clothing/under/costume/sailor
	head = /obj/item/clothing/head/bandana
	shoes = /obj/item/clothing/shoes/jackboots

/datum/outfit/job/independent/engineer/pirate/jupiter
	name = "Independent - Engineer (Nodesman)" // technically, this is part of SEC, but we have jackshit for SEC

	uniform = /obj/item/clothing/under/utility
	head = /obj/item/clothing/head/soft/black
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/melee/knife/survival
	gloves = /obj/item/clothing/gloves/color/red/insulated

	implants = list(/obj/item/implant/radio)

/datum/outfit/job/independent/engineer/gown
	name = "Independent - Engineer (Gown)"

	gloves = null
	ears = null
	uniform = /obj/item/clothing/under/rank/medical/gown
	alt_uniform = null
	suit = null
	dcoat = null
	shoes = /obj/item/clothing/shoes/sandal/slippers
	head = null
	backpack_contents = null

// Warden

/datum/outfit/job/independent/warden
	name = "Independent - Warden"
	job_icon = "warden"
	jobtype = /datum/job/warden

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/warden
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/security/warden
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/warden
	glasses = /obj/item/clothing/glasses/hud/security
	l_pocket = /obj/item/restraints/handcuffs
	suit_store = null
	backpack_contents = list(/obj/item/melee/classic_baton)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/security

	chameleon_extras = /obj/item/gun/ballistic/shotgun/automatic/m11

// Chief Engineer

/datum/outfit/job/independent/ce
	name = "Independent - Chief Engineer"
	jobtype = /datum/job/chief_engineer
	job_icon = "chiefengineer"

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/chief/full
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/rank/engineering/chief_engineer
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hardhat/white
	gloves = /obj/item/clothing/gloves/color/black
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced=1)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer
	chameleon_extras = /obj/item/stamp/ce

// Medical Doctor

/datum/outfit/job/independent/doctor
	name = "Independent - Medical Doctor"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor

	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/doctor/blue
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/apron/surgical
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med

	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

/datum/outfit/job/independent/doctor/pirate
	name = "Independent - Medical Doctor (Pirate)"

	ears = /obj/item/radio/headset/pirate
	uniform = /obj/item/clothing/under/costume/sailor

// Cargo Tech

/datum/outfit/job/independent/cargo_tech
	name = "Independent - Cargo Tech"
	jobtype = /datum/job/cargo_tech
	job_icon = "cargotechnician"

	ears = /obj/item/radio/headset/headset_cargo
	uniform = /obj/item/clothing/under/color/lightbrown
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1)

// Atmos Tech

/datum/outfit/job/independent/atmos
	name = "Independent - Atmos Tech"
	jobtype = /datum/job/atmos
	job_icon = "atmospherictechnician"

	belt = /obj/item/storage/belt/utility/atmostech
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	l_pocket = /obj/item/analyzer

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer

	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

// Scientist

/datum/outfit/job/independent/scientist
	name = "Independent - Scientist"
	jobtype = /datum/job/scientist
	job_icon = "scientist"

	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	alt_suit = /obj/item/clothing/suit/toggle/suspenders/blue
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

// Brig Physician

/datum/outfit/job/independent/brig_phys
	name = "Independent - Brig Physician"
	jobtype = /datum/job/brig_phys
	job_icon = "brigphysician"

	ears = /obj/item/radio/headset/headset_medsec/alt
	uniform = /obj/item/clothing/under/rank/security/brig_phys
	shoes = /obj/item/clothing/shoes/sneakers/white
	glasses = /obj/item/clothing/glasses/hud/health
	suit = /obj/item/clothing/suit/toggle/labcoat/brig_phys
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	head = /obj/item/clothing/head/soft/sec/brig_phys

// Paramedic

/datum/outfit/job/independent/paramedic
	name = "Independent - Paramedic"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/paramedic/emt
	head = /obj/item/clothing/head/soft/paramedic
	shoes = /obj/item/clothing/shoes/sneakers/blue
	suit =  /obj/item/clothing/suit/toggle/labcoat/paramedic
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical/paramedic
	gloves = /obj/item/clothing/gloves/color/latex

	backpack_contents = list(/obj/item/roller=1)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para

	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

// Quartermaster

/datum/outfit/job/independent/quartermaster
	name = "Independent - Quartermaster"
	jobtype = /datum/job/qm
	job_icon = "quartermaster"

	ears = /obj/item/radio/headset/headset_cargo
	uniform = /obj/item/clothing/under/rank/security/detective
	head = /obj/item/clothing/head/hardhat/white
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo
	suit = /obj/item/clothing/suit/hazardvest
	shoes = /obj/item/clothing/shoes/workboots
	glasses = /obj/item/clothing/glasses/sunglasses
	r_pocket = /obj/item/clipboard
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	chameleon_extras = /obj/item/stamp/qm

/datum/outfit/job/independent/quartermaster/western
	name = "Independent - Quartermaster (Western)"

	suit = /obj/item/clothing/suit/jacket/leather/duster
	gloves = /obj/item/clothing/gloves/fingerless
	head = /obj/item/clothing/head/cowboy/sec

/datum/outfit/job/independent/miner
	name = "Independent - Miner"
	jobtype = /datum/job/mining
	job_icon = "shaftminer"

	ears = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/explorer
	uniform = /obj/item/clothing/under/rank/cargo/miner
	suit = /obj/item/clothing/suit/hazardvest
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/miner
	l_pocket = /obj/item/storage/bag/ore
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/melee/knife/survival=1,\
		/obj/item/stack/marker_beacon/ten=1,\
		/obj/item/radio/weather_monitor=1)

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag
	box = /obj/item/storage/box/survival/mining

	chameleon_extras = /obj/item/gun/energy/kinetic_accelerator

/datum/outfit/job/independent/miner/hazard
	name = "Independent - Miner (Hazard Uniform)"

	uniform = /obj/item/clothing/under/rank/cargo/miner/hazard
	alt_uniform = null
	alt_suit = /obj/item/clothing/suit/toggle/hazard

/datum/outfit/job/independent/miner/scientist
	name = "Independent - Miner (Minerologist)"

	uniform = /obj/item/clothing/under/rank/cargo/miner/hazard
	alt_uniform = /obj/item/clothing/under/rank/rnd/roboticist
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	alt_suit = /obj/item/clothing/suit/toggle/hazard
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

// Hunter

/datum/outfit/job/independent/hunter
	name = "Independent - Hunter"
	jobtype = /datum/job/mining
	job_icon = "securityofficer"

	ears = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/explorer
	uniform = /obj/item/clothing/under/syndicate/camo
	backpack_contents = list(
		/obj/item/melee/knife/survival=1,\
		/obj/item/radio/weather_monitor=1)

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer

// Cook

/datum/outfit/job/independent/cook
	name = "Independent - Cook"
	jobtype = /datum/job/cook
	job_icon = "cook"

	ears = /obj/item/radio/headset/headset_srv
	shoes = /obj/item/clothing/shoes/laceup
	uniform = /obj/item/clothing/under/rank/civilian/chef
	suit = /obj/item/clothing/suit/toggle/chef
	alt_suit = /obj/item/clothing/suit/apron/chef
	head = /obj/item/clothing/head/chefhat
	mask = /obj/item/clothing/mask/fakemoustache/italian
	backpack_contents = list(/obj/item/sharpener = 1)

/datum/outfit/job/independent/cook/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	var/list/possible_boxes = subtypesof(/obj/item/storage/box/ingredients)
	var/chosen_box = pick(possible_boxes)
	var/obj/item/storage/box/I = new chosen_box(src)
	H.equip_to_slot_or_del(I,ITEM_SLOT_BACKPACK)

// Bartender

/datum/outfit/job/independent/bartender
	name = "Independent - Bartender"
	job_icon = "bartender"
	jobtype = /datum/job/bartender


	glasses = /obj/item/clothing/glasses/sunglasses/reagent
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/bartender
	alt_uniform = /obj/item/clothing/under/rank/civilian/bartender/purple
	alt_suit = /obj/item/clothing/suit/apron/purple_bartender
	suit = /obj/item/clothing/suit/armor/vest
	backpack_contents = list(/obj/item/storage/box/beanbag=1)
	shoes = /obj/item/clothing/shoes/laceup
	accessory = /obj/item/clothing/accessory/waistcoat

/datum/outfit/job/independent/bartender/disarmed //No armor, no shotgun ammo.
	name = "Independent - Bartender (Disarmed)"

	suit = null
	alt_suit = null
	backpack_contents = null

/datum/outfit/job/independent/bartender/pharma
	name = "Independent - Bartender (Mixologist)"

	backpack_contents = list(/obj/item/storage/box/syringes=1, /obj/item/storage/box/drinkingglasses = 1)
	ears = /obj/item/radio/headset/headset_med
	suit = /obj/item/clothing/suit/toggle/labcoat
	l_pocket = /obj/item/reagent_containers/food/drinks/shaker
	belt = /obj/item/storage/belt
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	uniform = /obj/item/clothing/under/suit/black
	accessory = null

// Lawyer

/datum/outfit/job/independent/lawyer
	name = "Independent - Lawyer"
	job_icon = "lawyer"
	jobtype = /datum/job/lawyer

	ears = /obj/item/radio/headset/headset_srvsec
	uniform = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit
	suit = /obj/item/clothing/suit/toggle/lawyer
	shoes = /obj/item/clothing/shoes/laceup
	l_hand = /obj/item/storage/briefcase/lawyer
	l_pocket = /obj/item/clothing/accessory/lawyers_badge

// Curator

/datum/outfit/job/independent/curator
	name = "Independent - Curator"
	job_icon = "curator"
	jobtype = /datum/job/curator

	shoes = /obj/item/clothing/shoes/laceup
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/curator
	l_hand = /obj/item/storage/bag/books
	l_pocket = /obj/item/key/displaycase
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(
		/obj/item/choice_beacon/hero = 1,
		/obj/item/barcodescanner = 1
	)

/datum/outfit/job/independent/curator/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	H.grant_all_languages(TRUE, TRUE, TRUE, LANGUAGE_CURATOR)

/datum/outfit/job/independent/curator/dungeonmaster
	name = "Independent - Curator (Dungeon Master)"
	uniform = /obj/item/clothing/under/misc/pj/red
	suit = /obj/item/clothing/suit/nerdshirt
	backpack_contents = list(
		/obj/item/choice_beacon/hero = 1,
		/obj/item/tape = 1,
		/obj/item/storage/pill_bottle/dice = 1,
		/obj/item/toy/cards/deck/cas = 1,
		/obj/item/toy/cards/deck/cas/black = 1,
		/obj/item/hourglass = 1
	)

// Chaplain

/datum/outfit/job/independent/chaplain
	name = "Independent - Chaplain"
	job_icon = "chaplain"
	jobtype = /datum/job/chaplain

	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/chaplain
	backpack_contents = list(
		/obj/item/camera/spooky = 1
		)

	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack

// Chemist

/datum/outfit/job/independent/chemist
	name = "Independent - Chemist"
	job_icon = "chemist"
	jobtype = /datum/job/chemist

	glasses = /obj/item/clothing/glasses/science
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/chemist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat/chemist
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical

	backpack = /obj/item/storage/backpack/chemistry
	satchel = /obj/item/storage/backpack/satchel/chem
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/chem

	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

/datum/outfit/job/independent/chemist/pharma
	name = "Independent - Chemist (Pharmacology Student)"

	shoes = /obj/item/clothing/shoes/sneakers/white
	accessory = /obj/item/clothing/neck/scarf/orange
	l_pocket = /obj/item/pda/medical
	r_pocket = /obj/item/reagent_containers/pill/floorpill
	belt = /obj/item/reagent_scanner
	backpack_contents = list(/obj/item/book/manual/wiki/chemistry = 1)

// Janitor

/datum/outfit/job/independent/janitor
	name = "Independent - Janitor"
	job_icon = "janitor"
	jobtype = /datum/job/janitor

	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/janitor

	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

// Research Director

/datum/outfit/job/independent/rd
	name = "Independent - Research Director"
	job_icon = "researchdirector"
	jobtype = /datum/job/rd

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/heads/rd
	uniform = /obj/item/clothing/under/rank/rnd/research_director/turtleneck
	shoes = /obj/item/clothing/shoes/sneakers/brown
	suit = /obj/item/clothing/suit/toggle/labcoat
	alt_suit = /obj/item/clothing/suit/toggle/suspenders
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science //WS Edit - Alt Uniforms
	l_hand = /obj/item/clipboard
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced=1)

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

	chameleon_extras = /obj/item/stamp/rd

// Chief Medical Officer

/datum/outfit/job/independent/cmo
	name = "Independent - Chief Medical Officer"
	job_icon = "chiefmedicalofficer"
	jobtype = /datum/job/cmo

	id = /obj/item/card/id/silver
	l_pocket = /obj/item/pinpointer/crew
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/rank/medical/doctor/blue
	shoes = /obj/item/clothing/shoes/sneakers/brown
	suit = /obj/item/clothing/suit/toggle/labcoat/cmo
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med

	box = /obj/item/storage/box/survival/medical

	chameleon_extras = list(/obj/item/gun/syringe, /obj/item/stamp/cmo)

/datum/outfit/job/independent/cmo/pharma
	name = "Independent - Chief Pharmacist"

	glasses = /obj/item/clothing/glasses/science/prescription/fake //chief pharma is this kind of person
	neck = /obj/item/clothing/neck/tie/orange //the Horrible Tie was genuinely too hard to look at
	l_pocket = /obj/item/reagent_containers/glass/filter
	uniform = /obj/item/clothing/under/suit/tan
	alt_uniform = /obj/item/clothing/under/rank/medical/doctor/green
	shoes = /obj/item/clothing/shoes/sneakers/brown
	suit = /obj/item/clothing/suit/toggle/suspenders/gray

	l_hand = /obj/item/reagent_containers/glass/maunamug
	backpack = /obj/item/storage/backpack/chemistry
	satchel = /obj/item/storage/backpack/satchel/chem
	courierbag = /obj/item/storage/backpack/messenger/chem
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/storage/bag/chemistry=1)

// Detective

/datum/outfit/job/independent/detective
	name = "Independent - Detective"
	job_icon = "detective"
	jobtype = /datum/job/detective

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/detective
	neck = /obj/item/clothing/neck/tie/detective
	shoes = /obj/item/clothing/shoes/sneakers/brown
	suit = /obj/item/clothing/suit/det_suit
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/fedora/det_hat
	l_pocket = /obj/item/toy/crayon/white
	backpack_contents = list(/obj/item/storage/box/evidence=1,\
		/obj/item/detective_scanner=1,\
		/obj/item/melee/classic_baton=1)
	mask = /obj/item/clothing/mask/cigarette

	implants = list(/obj/item/implant/mindshield)

	chameleon_extras = list(/obj/item/gun/ballistic/revolver/detective, /obj/item/clothing/glasses/sunglasses)

/datum/outfit/job/independent/detective/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	var/obj/item/clothing/mask/cigarette/cig = H.wear_mask
	if(istype(cig)) //Some species specfic changes can mess this up (plasmamen)
		cig.light("")

	if(visualsOnly)
		return

// Botanist

/datum/outfit/job/independent/botanist
	name = "Independent - Botanist"
	job_icon = "botanist"
	jobtype = /datum/job/hydro

	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/overalls
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/hydro
	gloves  =/obj/item/clothing/gloves/botanic_leather
	belt = /obj/item/plant_analyzer

	backpack = /obj/item/storage/backpack/botany
	satchel = /obj/item/storage/backpack/satchel/hyd
	courierbag = /obj/item/storage/backpack/messenger/hyd

/datum/outfit/job/independent/botanist/pharma
	name = "Independent - Botanist (Herbalist)"

	ears = /obj/item/radio/headset/headset_med
	belt = /obj/item/storage/bag/plants
	uniform = /obj/item/clothing/under/utility
