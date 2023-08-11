/datum/job/roboticist
	name = "Roboticist"
	total_positions = 2
	spawn_positions = 2
	wiki_page = "Guide_to_Robotics"

	outfit = /datum/outfit/job/roboticist

	access = list(ACCESS_ROBOTICS, ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_TECH_STORAGE, ACCESS_MORGUE, ACCESS_MECH_SCIENCE, ACCESS_RESEARCH, ACCESS_MINERAL_STOREROOM, ACCESS_XENOBIOLOGY) //WS edit - Gen/Sci Split
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_TECH_STORAGE, ACCESS_MORGUE, ACCESS_RESEARCH, ACCESS_MECH_SCIENCE, ACCESS_MINERAL_STOREROOM)

	display_order = JOB_DISPLAY_ORDER_ROBOTICIST

/datum/outfit/job/roboticist
	name = "Roboticist"
	job_icon = "roboticist"
	jobtype = /datum/job/roboticist

	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/pda/roboticist
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/rnd/roboticist
	suit = /obj/item/clothing/suit/toggle/labcoat
	alt_suit = /obj/item/clothing/suit/toggle/suspenders/gray
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

	pda_slot = ITEM_SLOT_LPOCKET

/datum/outfit/job/roboticist/technician/minutemen
	name = "Mech Technician (Minutemen)"

	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/minutemen
	suit = /obj/item/clothing/suit/toggle/labcoat/science

