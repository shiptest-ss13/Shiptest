/datum/outfit/centcom/ert/independent
	name = "ERT - Independent Security Officer"

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

	id_role = "Security Officer"

/datum/outfit/centcom/ert/independent/emt
	name = "ERT - Independent Paramedic"

	head = /obj/item/clothing/head/soft/paramedic
	mask = null
	uniform = /obj/item/clothing/under/rank/medical/paramedic
	shoes = /obj/item/clothing/shoes/sneakers/white
	gloves = /obj/item/clothing/gloves/color/latex
	ears = /obj/item/radio/headset
	suit = /obj/item/clothing/suit/toggle/labcoat/paramedic
	back = /obj/item/storage/backpack/medic
	belt = /obj/item/storage/belt/medical/webbing/paramedic

	id_role = "Emergency Medical Technician"

/datum/outfit/centcom/ert/independent/firefighter
	name = "ERT - Independent Firefighter (Standard)"

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

	id_role = "Firefighter"

/datum/outfit/centcom/ert/independent/firefighter/medic
	name = "ERT - Independent Firefighter (Medic)"

	mask = /obj/item/clothing/mask/breath/medical
	back = /obj/item/storage/backpack/fireproof
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/evil
	glasses = /obj/item/clothing/glasses/hud/health
	suit_store = /obj/item/tank/internals/emergency_oxygen

	l_pocket = /obj/item/extinguisher/mini

	backpack_contents = list(/obj/item/storage/firstaid/fire=1, /obj/item/storage/firstaid/o2=1, /obj/item/radio=1)

	id_role = "Emergency Medical Technician"

/datum/outfit/centcom/ert/independent/firefighter/leader
	name = "ERT - Independent Firefighter (Group Captain)"

	back = /obj/item/fireaxe
	suit = /obj/item/clothing/suit/space/hardsuit/engine
	suit_store = /obj/item/tank/internals/oxygen/red
	head = null
	belt = /obj/item/storage/belt/utility/atmostech
	gloves = /obj/item/clothing/gloves/color/yellow

	id_role = "Group Captain"

/datum/outfit/centcom/ert/independent/technician
	name = "ERT - Independent Technician"

	head = /obj/item/clothing/head/hardhat
	belt = /obj/item/storage/belt/utility/full/engi
	suit = /obj/item/clothing/suit/toggle/hazard
	shoes = /obj/item/clothing/shoes/workboots
	back = /obj/item/storage/backpack/industrial
	l_pocket = /obj/item/radio
	r_pocket = /obj/item/analyzer

	box = /obj/item/storage/box/survival/engineer
