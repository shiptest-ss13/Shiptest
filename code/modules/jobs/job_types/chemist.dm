/datum/job/chemist
	name = "Chemist"
	total_positions = 2
	spawn_positions = 2
	wiki_page = "Guide_to_Chemistry" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/chemist

	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CHEMISTRY, ACCESS_PHARMACY, ACCESS_VIROLOGY, ACCESS_GENETICS, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_EVA) //WS Edit - Gen/Sci Split
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_CHEMISTRY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_PHARMACY)

	display_order = JOB_DISPLAY_ORDER_CHEMIST

/datum/outfit/job/chemist
	name = "Chemist"
	job_icon = "chemist"
	jobtype = /datum/job/chemist

	glasses = /obj/item/clothing/glasses/science
	belt = /obj/item/pda/chemist
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/chemist
	alt_uniform = /obj/item/clothing/under/rank/medical/chemist //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat/chemist
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical //WS Edit - Alt Uniforms
	backpack = /obj/item/storage/backpack/chemistry
	satchel = /obj/item/storage/backpack/satchel/chem
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/chem
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

//Alt jobs

/datum/outfit/job/chemist/pharmacist
	name = "Chemist (Pharmacist)"
	jobtype = /datum/job/chemist

	glasses = null
	alt_uniform = null

	backpack_contents = list(/obj/item/clothing/glasses/science=1)

/datum/outfit/job/chemist/pharmacologist
	name = "Chemist (Pharmacologist)"

	glasses = null
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/labcoat/chemist/side

	backpack_contents = list(/obj/item/clothing/glasses/science=1)

/datum/outfit/job/chemist/juniorchemist
	name = "Chemist (Junior Chemist)"

	glasses = null
	alt_uniform = null
	suit = null
	alt_suit = null

	backpack_contents = list(/obj/item/clothing/glasses/science=1)

/datum/outfit/job/chemist/seniorchemist
	name = "Chemist (Senior Chemist)"

	glasses = null
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/toggle/lawyer/orange
	alt_suit = /obj/item/clothing/suit/toggle/labcoat/chemist
	dcoat = null
	l_hand = null
	suit_store = null
	neck = /obj/item/clothing/neck/tie/orange

	backpack_contents = list(/obj/item/clothing/glasses/science=1)

//Shiptest
/datum/outfit/job/chemist/gec
	name = "Chemist (GEC)"

	uniform = /obj/item/clothing/under/syndicate/intern
	suit = /obj/item/clothing/suit/toggle/hazard
	head = /obj/item/clothing/head/hardhat
	belt = /obj/item/storage/belt/utility/full/engi
	id = /obj/item/card/id/syndicate_command/crew_id
	l_pocket =/obj/item/pda/chemist

/datum/outfit/job/chemist/pharma
	name = "Pharmacist"

	belt = /obj/item/storage/bag/chemistry
	l_pocket =/obj/item/pda/chemist
	r_pocket = /obj/item/storage/pill_bottle
	suit = /obj/item/clothing/suit/longcoat/chemist
	alt_suit = /obj/item/clothing/suit/toggle/labcoat/chemist/side
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical
	box = /obj/item/storage/box/survival/medical
	gloves = /obj/item/clothing/gloves/color/latex
	glasses = /obj/item/clothing/glasses/sunglasses

/datum/outfit/job/chemist/minutemen
	name = "Chemical Scientist(minutemen)"

	suit = /obj/item/clothing/suit/toggle/labcoat/chemist
	ears = /obj/item/radio/headset/minutemen

