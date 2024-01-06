/datum/job/doctor
	name = "Medical Doctor"
	wiki_page = "Guide_to_Medicine"

	outfit = /datum/outfit/job/doctor

	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_VIROLOGY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_EVA) //WS edit - Gen/Sci Split
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CLONING, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_PHARMACY)

	display_order = JOB_DISPLAY_ORDER_MEDICAL_DOCTOR

/datum/outfit/job/doctor
	name = "Medical Doctor"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor

	belt = /obj/item/pda/medical
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/doctor
	alt_uniform = /obj/item/clothing/under/rank/medical/doctor/blue //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat
	alt_suit = /obj/item/clothing/suit/apron/surgical
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical //WS Edit - Alt Uniforms
	l_hand = /obj/item/storage/firstaid/medical
	suit_store = /obj/item/flashlight/pen

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

/datum/outfit/job/doctor/surgeon
	name = "Medical Doctor (Surgeon)"

	uniform = /obj/item/clothing/under/rank/medical/doctor/blue
	suit = /obj/item/clothing/suit/apron/surgical
	mask = /obj/item/clothing/mask/surgical
	suit_store = null

/datum/outfit/job/doctor/nurse
	name = "Medical Doctor (Nurse)"

	head = /obj/item/clothing/head/nursehat
	suit = null
	suit_store = null
	alt_uniform = /obj/item/clothing/under/rank/medical/doctor/nurse
	accessory = /obj/item/clothing/accessory/armband/medblue

/datum/outfit/job/doctor/juniordoctor
	name = "Medical Doctor (Junior Doctor)"

	alt_uniform = null
	shoes = /obj/item/clothing/shoes/sneakers/blue
	suit =  null
	alt_suit = null
	l_hand = null
	suit_store = null

	backpack_contents = list(/obj/item/storage/firstaid/medical=1, /obj/item/flashlight/pen=1)

/datum/outfit/job/doctor/seniordoctor
	name = "Medical Doctor (Senior Doctor)"

	uniform = /obj/item/clothing/under/rank/medical/doctor
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/toggle/lawyer/medical
	alt_suit = /obj/item/clothing/suit/toggle/labcoat
	dcoat = null
	l_hand = null
	suit_store = null
	neck = /obj/item/clothing/neck/tie/blue

	backpack_contents = list(/obj/item/storage/firstaid/medical=1, /obj/item/flashlight/pen=1)

/datum/outfit/job/doctor/psychiatrist
	name = "Medical Doctor (Psychiatrist)"

	uniform = /obj/item/clothing/under/rank/medical/psychiatrist
	shoes = /obj/item/clothing/shoes/laceup
	suit =  null
	alt_suit = null
	l_hand = null
	suit_store = null

	backpack_contents = list(/obj/item/clipboard=1, /obj/item/folder/white=1, /obj/item/taperecorder=1)

//Shiptest outfits

/datum/outfit/job/doctor/pirate
	name = "Ship's Doctor (Pirate)"

	uniform = /obj/item/clothing/under/costume/sailor
	shoes = /obj/item/clothing/shoes/jackboots
