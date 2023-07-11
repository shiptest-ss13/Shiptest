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

//Alt Jobs

/datum/outfit/job/scientist/xenobiologist
	name = "Scientist (Xenobiologist)"

	uniform = /obj/item/clothing/under/rank/rnd/scientist/xenobiologist
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/sneakers/green

/datum/outfit/job/scientist/xenobiologist/fauna
	name = "Scientist (Fauna Researcher)"

	belt = /obj/item/melee/curator_whip
	suit = /obj/item/clothing/suit/armor/curator
	head = /obj/item/clothing/head/fedora

	pda_slot = ITEM_SLOT_LPOCKET

/datum/outfit/job/scientist/naniteresearcher
	name = "Scientist (Nanite Researcher)"

	uniform = /obj/item/clothing/under/rank/rnd/scientist/nanite
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/sneakers/black
	suit = null
	alt_suit = null

/datum/outfit/job/scientist/juniorscientist
	name = "Scientist (Junior Scientist)"

	uniform = /obj/item/clothing/under/rank/rnd/scientist/junior
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = null
	alt_suit = null

/datum/outfit/job/scientist/seniorscientist
	name = "Scientist (Senior Scientist)"

	uniform = /obj/item/clothing/under/suit/senior_scientist
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/toggle/lawyer/science
	alt_suit = /obj/item/clothing/suit/toggle/labcoat/science
	dcoat = null
	neck = /obj/item/clothing/neck/tie/purple

/datum/outfit/job/scientist/minutemen
	name = "Scientist (Minutemen)"

	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	backpack = /obj/item/storage/backpack/security/cmm
