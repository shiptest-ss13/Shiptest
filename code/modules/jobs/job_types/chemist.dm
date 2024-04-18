/datum/job/chemist
	name = "Chemist"
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
