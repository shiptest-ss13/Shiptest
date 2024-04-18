/datum/job/curator
	name = "Curator"
	wiki_page = "Curator" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/curator

	access = list(ACCESS_LIBRARY, ACCESS_CONSTRUCTION, ACCESS_MINING_STATION)
	minimal_access = list(ACCESS_LIBRARY, ACCESS_CONSTRUCTION, ACCESS_MINING_STATION)

	display_order = JOB_DISPLAY_ORDER_CURATOR

/datum/outfit/job/curator
	name = "Curator"
	job_icon = "curator"
	jobtype = /datum/job/curator

	shoes = /obj/item/clothing/shoes/laceup
	belt = /obj/item/pda/curator
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/curator
	alt_uniform = /obj/item/clothing/under/suit/tan
	alt_suit = /obj/item/clothing/suit/armor/curator
	l_hand = /obj/item/storage/bag/books
	r_pocket = /obj/item/key/displaycase
	l_pocket = /obj/item/laser_pointer
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(
		/obj/item/choice_beacon/hero = 1,
		/obj/item/barcodescanner = 1
	)

/datum/outfit/job/curator/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	H.grant_all_languages(TRUE, TRUE, TRUE, LANGUAGE_CURATOR)
