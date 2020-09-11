/datum/job/chemist
	title = "Chemist"
	department_head = list("Chief Medical Officer")
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"
	exp_type = EXP_TYPE_CREW
	exp_requirements = 60
	wiki_page = "Guide_to_Chemistry" //WaspStation Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/chemist

	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CHEMISTRY, ACCESS_PHARMACY, ACCESS_VIROLOGY, ACCESS_GENETICS, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_EVA) //WaspStation Edit - Gen/Sci Split
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_CHEMISTRY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_PHARMACY)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_CHEMIST

/datum/outfit/job/chemist
	name = "Chemist"
	jobtype = /datum/job/chemist

	glasses = /obj/item/clothing/glasses/science
	belt = /obj/item/pda/chemist
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/chemist
	alt_uniform = /obj/item/clothing/under/rank/medical/chemist //Wasp Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat/chemist
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical //Wasp Edit - Alt Uniforms
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

	uniform = /obj/item/clothing/under/rank/medical/chemist/pharmacist
	alt_uniform = null

	backpack_contents = list(/obj/item/clothing/glasses/science=1)

/datum/outfit/job/chemist/pharmacologist
	name = "Chemist (Pharmacologist)"

	glasses = null
	uniform = /obj/item/clothing/under/rank/medical/chemist/pharmacologist
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/labcoat/chemist/side

	backpack_contents = list(/obj/item/clothing/glasses/science=1)

/datum/outfit/job/chemist/juniorchemist
	name = "Chemist (Junior Chemist)"

	glasses = null
	uniform = /obj/item/clothing/under/rank/medical/chemist/junior_chemist
	alt_uniform = null
	suit = null
	alt_suit = null

	backpack_contents = list(/obj/item/clothing/glasses/science=1)

/datum/outfit/job/chemist/seniorchemist
	name = "Chemist (Senior Chemist)"

	glasses = null
	uniform = /obj/item/clothing/under/suit/senior_chemist
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/toggle/lawyer/orange
	alt_suit = /obj/item/clothing/suit/toggle/labcoat/chemist
	dcoat = null
	l_hand = null
	suit_store = null
	neck = /obj/item/clothing/neck/tie/orange

	backpack_contents = list(/obj/item/clothing/glasses/science=1)
