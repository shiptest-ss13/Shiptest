/datum/outfit/job/solgov/ert
	name = "ERT - SolGov Sonnensöldner"
	id_assignment = "Sonnensöldner"
	jobtype = /datum/job/officer
	job_icon = "sonnensoldner"

	wallet = null

	id = /obj/item/card/id/solgov
	uniform = /obj/item/clothing/under/solgov
	suit = /obj/item/clothing/suit/armor/vest/solgov
	mask = null
	ears = /obj/item/radio/headset/solgov/alt
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/solgov/sonnensoldner
	shoes = /obj/item/clothing/shoes/combat

	box = /obj/item/storage/box/survival
	l_hand = /obj/item/energyhalberd


/datum/outfit/job/solgov/ert/inspector
	name = "ERT - SolGov Inspector"
	id_assignment = "Inspector"
	jobtype = /datum/job/head_of_personnel
	job_icon = "solgovrepresentative"

	uniform = /obj/item/clothing/under/solgov/formal
	neck = /obj/item/clothing/neck/cloak/solgov
	belt = /obj/item/clipboard
	ears = /obj/item/radio/headset/solgov/captain
	back = /obj/item/storage/backpack/satchel/leather
	head = /obj/item/clothing/head/solgov
	gloves = /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/laceup
	suit = null
	suit_store = null
	mask = null
	glasses = null
	l_hand = null

	r_pocket = /obj/item/pen/fourcolor
	l_pocket = /obj/item/taperecorder

	backpack_contents = list(/obj/item/folder/solgov, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler)
