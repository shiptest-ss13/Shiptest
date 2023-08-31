/datum/job/scientist
	name = "Scientist"
	total_positions = 5
	spawn_positions = 3
	wiki_page = "Scientist" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/scientist

	access = list(ACCESS_ROBOTICS, ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY, ACCESS_MECH_SCIENCE, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE) //WS edit - Gen/Sci Split
	minimal_access = list(ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY, ACCESS_MECH_SCIENCE, ACCESS_MINERAL_STOREROOM)

	display_order = JOB_DISPLAY_ORDER_SCIENTIST

/datum/outfit/job/scientist
	name = "Scientist"
	job_icon = "scientist"
	jobtype = /datum/job/scientist

	belt = /obj/item/pda/toxins
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	alt_uniform = /obj/item/clothing/under/rank/rnd/roboticist //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	alt_suit = /obj/item/clothing/suit/toggle/suspenders/blue
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science //WS Edit - Alt Uniforms

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

/datum/outfit/job/scientist/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(0.4))
		neck = /obj/item/clothing/neck/tie/horrible

/datum/outfit/job/scientist/minutemen
	name = "Scientist (Minutemen)"

	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	backpack = /obj/item/storage/backpack/security/cmm
