/datum/job/doctor
	title = "Medical Doctor"
	flag = DOCTOR
	department_head = list("Chief Medical Officer")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"
	wiki_page = "Guide_to_Medicine"

	outfit = /datum/outfit/job/doctor

	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_VIROLOGY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM) //WaspStation edit - Gen/Sci Split
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CLONING, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_PHARMACY)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_MEDICAL_DOCTOR

/datum/outfit/job/doctor
	name = "Medical Doctor"
	jobtype = /datum/job/doctor

	belt = /obj/item/pda/medical
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/doctor
	alt_uniform = /obj/item/clothing/under/rank/medical/doctor/blue //Wasp Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat
	alt_suit = /obj/item/clothing/suit/apron/surgical
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical //Wasp Edit - Alt Uniforms
	l_hand = /obj/item/storage/firstaid/medical
	suit_store = /obj/item/flashlight/pen

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

// Wasp Edit Start - Alt-Job Titles
/datum/outfit/job/doctor/surgeon
	name = "Medical Doctor (Surgeon)"
	uniform = /obj/item/clothing/under/rank/medical/doctor/blue
	suit = /obj/item/clothing/suit/apron/surgical
	mask = /obj/item/clothing/mask/surgical

/datum/outfit/job/doctor/nurse
	name = "Medical Doctor (Nurse)"
	head = /obj/item/clothing/head/nursehat
	suit = null
	alt_uniform = /obj/item/clothing/under/rank/medical/doctor/nurse
	accessory = /obj/item/clothing/accessory/armband/medblue

/datum/outfit/job/doctor/psychiatrist
	name = "Medical Doctor (Psychiatrist)"
	uniform = /obj/item/clothing/under/suit/black
	suit = null
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id
	belt = /obj/item/pda/medical
	l_hand = /obj/item/clipboard
	backpack_contents = list(/obj/item/storage/pill_bottle/psicodine=1, /obj/item/storage/pill_bottle/happy=1, /obj/item/storage/pill_bottle/lsd=1)
// Wasp Edit End - Alt-Job Titles
