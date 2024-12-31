/datum/outfit/job/independent/ert
	name = "ERT - Independent Security Officer"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	wallet = null

	head = /obj/item/clothing/head/helmet/sec
	ears = /obj/item/radio/headset/alt
	uniform = /obj/item/clothing/under/rank/security/officer
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/color/black
	suit = /obj/item/clothing/suit/armor/vest
	back = /obj/item/storage/backpack/security
	belt = /obj/item/storage/belt/security/full
	id = /obj/item/card/id

/datum/outfit/job/independent/ert/emt
	name = "ERT - Independent Paramedic"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	head = /obj/item/clothing/head/soft/paramedic
	mask = null
	uniform = /obj/item/clothing/under/rank/medical/paramedic
	shoes = /obj/item/clothing/shoes/sneakers/white
	gloves = /obj/item/clothing/gloves/color/latex
	ears = /obj/item/radio/headset
	suit = /obj/item/clothing/suit/toggle/labcoat/paramedic
	back = /obj/item/storage/backpack/medic
	belt = /obj/item/storage/belt/medical/webbing/paramedic

	backpack_contents = list(/obj/item/storage/firstaid/medical)

/datum/outfit/job/independent/ert/emt/eva
	name = "ERT - Independent Paramedic (EVA)"

	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/medical
	suit_store = /obj/item/tank/internals/oxygen

/datum/outfit/job/independent/ert/firefighter
	name = "ERT - Independent Firefighter (Standard)"
	jobtype = /datum/job/atmos
	job_icon = "atmospherictechnician"

	head = /obj/item/clothing/head/hardhat/red
	uniform = /obj/item/clothing/under/utility
	suit = /obj/item/clothing/suit/fire/atmos
	suit_store = /obj/item/extinguisher
	glasses = /obj/item/clothing/glasses/heat
	belt = null
	mask = /obj/item/clothing/mask/gas/atmos
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/color/black
	back = /obj/item/tank/internals/oxygen/red

	backpack = /obj/item/storage/backpack/fireproof
	courierbag = /obj/item/storage/backpack/fireproof
	duffelbag = /obj/item/storage/backpack/fireproof
	satchel = /obj/item/storage/backpack/fireproof

	l_pocket = /obj/item/crowbar/red
	r_pocket = /obj/item/radio

/datum/outfit/job/independent/ert/firefighter/medic
	name = "ERT - Independent Firefighter (Medic)"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	mask = /obj/item/clothing/mask/breath/medical
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/evil
	glasses = /obj/item/clothing/glasses/hud/health
	suit_store = /obj/item/tank/internals/emergency_oxygen

	l_pocket = /obj/item/extinguisher/mini

	backpack_contents = list(/obj/item/storage/firstaid/fire=1, /obj/item/storage/firstaid/o2=1)

/datum/outfit/job/independent/ert/firefighter/leader
	name = "ERT - Independent Firefighter (Group Captain)"
	jobtype = /datum/job/chief_engineer
	job_icon = "chiefengineer"

	suit = /obj/item/clothing/suit/space/hardsuit/engine
	suit_store = /obj/item/tank/internals/oxygen/red
	head = null
	belt = /obj/item/storage/belt/utility/atmostech
	gloves = /obj/item/clothing/gloves/color/yellow

	backpack_contents = null
	box = null

	backpack = /obj/item/melee/axe/fire
	courierbag = /obj/item/melee/axe/fire
	duffelbag = /obj/item/melee/axe/fire
	satchel = /obj/item/melee/axe/fire

/datum/outfit/job/independent/ert/technician
	name = "ERT - Independent Technician"
	jobtype = /datum/job/engineer
	job_icon = "stationengineer"

	head = /obj/item/clothing/head/hardhat
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	belt = /obj/item/storage/belt/utility/full/engi
	gloves = /obj/item/clothing/gloves/color/yellow
	suit = /obj/item/clothing/suit/toggle/hazard
	shoes = /obj/item/clothing/shoes/workboots
	back = /obj/item/storage/backpack/industrial
	l_pocket = /obj/item/radio
	r_pocket = /obj/item/analyzer

	box = /obj/item/storage/box/survival/engineer

/datum/outfit/job/independent/ert/pizza
	name = "ERT - Independent Pizza Delivery Worker"

	uniform = /obj/item/clothing/under/suit/burgundy
	neck = /obj/item/clothing/neck/tie/red
	shoes = /obj/item/clothing/shoes/sneakers/black
	head = /obj/item/clothing/head/soft/mime
	suit = null
	ears = null
	belt = null
	gloves = null


/datum/outfit/job/independent/ert/janitor
	name = "ERT - Independent Sanitation Technician"
	jobtype = /datum/job/janitor
	job_icon = "janitor"

	uniform = /obj/item/clothing/under/rank/civilian/janitor
	head = /obj/item/clothing/head/soft/purple
	ears = /obj/item/radio/headset
	mask = null
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/color/purple
	suit = null
	belt = /obj/item/storage/belt/janitor/full

/datum/outfit/job/independent/ert/deathsquad
	name = "ERT - Death Commando"
	job_icon = "deathsquad"
	faction_icon = null
	id_assignment = "Commando" // i mean. if you have enough time to look at a dsquaddie's id card. why not

	head = null
	uniform = /obj/item/clothing/under/rank/security/officer/military
	id = /obj/item/card/id/ert/deathsquad
	suit = /obj/item/clothing/suit/space/hardsuit/deathsquad
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	glasses = /obj/item/clothing/glasses/hud/toggle/thermal
	back = /obj/item/storage/backpack/security
	suit_store = /obj/item/tank/internals/emergency_oxygen/double
	belt = /obj/item/gun/ballistic/revolver/mateba
	ears = /obj/item/radio/headset/alt
	r_hand = /obj/item/gun/energy/pulse

	l_pocket = /obj/item/melee/energy/sword/saber
	r_pocket = /obj/item/shield/energy


	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/ammo_box/a357=1,\
		/obj/item/storage/firstaid/regular=1,\
		/obj/item/storage/box/flashbangs=1,\
		/obj/item/flashlight=1,\
		/obj/item/grenade/c4/x4=1)
