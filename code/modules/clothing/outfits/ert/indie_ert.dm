/datum/outfit/job/independent/ert
	name = "ERT - Independent Security Officer"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	head = /obj/item/clothing/head/helmet/sec
	ears = /obj/item/radio/headset/alt
	mask = null
	uniform = /obj/item/clothing/under/rank/security/officer
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/color/black
	suit = /obj/item/clothing/suit/armor/vest
	back = /obj/item/storage/backpack/security
	belt = /obj/item/storage/belt/security/full
	id = /obj/item/card/id

/datum/outfit/job/independent/ert/post_equip(mob/living/carbon/human/H, visualsOnly, client/preference_source)
	. = ..()
	if(visualsOnly)
		return

	var/obj/item/card/id/W = H.wear_id
	W.access += list(ACCESS_CENT_GENERAL)

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

/datum/outfit/job/independent/ert/firefighter
	name = "ERT - Independent Firefighter (Standard)"
	jobtype = /datum/job/atmos
	job_icon = "atmospherictechnician"

	head = /obj/item/clothing/head/hardhat/red
	uniform = /obj/item/clothing/under/utility
	suit = /obj/item/clothing/suit/fire/firefighter
	suit_store = /obj/item/extinguisher
	glasses = /obj/item/clothing/glasses/heat
	mask = /obj/item/clothing/mask/breath
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/color/black
	back = /obj/item/tank/internals/oxygen/red

	l_pocket = /obj/item/crowbar/red
	r_pocket = /obj/item/radio

/datum/outfit/job/independent/ert/firefighter/medic
	name = "ERT - Independent Firefighter (Medic)"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	mask = /obj/item/clothing/mask/breath/medical
	back = /obj/item/storage/backpack/fireproof
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/evil
	glasses = /obj/item/clothing/glasses/hud/health
	suit_store = /obj/item/tank/internals/emergency_oxygen

	l_pocket = /obj/item/extinguisher/mini

	backpack_contents = list(/obj/item/storage/firstaid/fire=1, /obj/item/storage/firstaid/o2=1, /obj/item/radio=1)

/datum/outfit/job/independent/ert/firefighter/leader
	name = "ERT - Independent Firefighter (Group Captain)"
	jobtype = /datum/job/chief_engineer
	job_icon = "chiefengineer"

	back = /obj/item/melee/axe/fire
	suit = /obj/item/clothing/suit/space/hardsuit/engine
	suit_store = /obj/item/tank/internals/oxygen/red
	head = null
	belt = /obj/item/storage/belt/utility/atmostech
	gloves = /obj/item/clothing/gloves/color/yellow

/datum/outfit/job/independent/ert/technician
	name = "ERT - Independent Technician"
	jobtype = /datum/job/engineer
	job_icon = "stationengineer"

	head = /obj/item/clothing/head/hardhat
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	belt = /obj/item/storage/belt/utility/full/engi
	suit = /obj/item/clothing/suit/toggle/hazard
	shoes = /obj/item/clothing/shoes/workboots
	back = /obj/item/storage/backpack/industrial
	l_pocket = /obj/item/radio
	r_pocket = /obj/item/analyzer

	box = /obj/item/storage/box/survival/engineer
