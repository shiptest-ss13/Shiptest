//psychologist back :)
/datum/job/psychologist
	name = "Psychologist"
	total_positions = 1
	spawn_positions = 1

	outfit = /datum/outfit/job/psychologist

	access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY)
	minimal_access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY)

	display_order = JOB_DISPLAY_ORDER_PSYCHOLOGIST

/datum/outfit/job/psychologist
	name = "Psychologist"
	jobtype = /datum/job/psychologist

	ears = /obj/item/radio/headset/headset_srvmed
	uniform = /obj/item/clothing/under/suit/black
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id
	belt = /obj/item/pda/medical
	pda_slot = ITEM_SLOT_BELT
	l_hand = /obj/item/clipboard

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med

//Shiptest Outfits

/datum/outfit/job/psychologist/syndicate/nsv
	name = "Ship Psychologist"
	id = /obj/item/card/id/syndicate_command/crew_id
	uniform = /obj/item/clothing/under/rank/medical/psychiatrist
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	alt_uniform = null
	l_hand = /obj/item/clipboard
