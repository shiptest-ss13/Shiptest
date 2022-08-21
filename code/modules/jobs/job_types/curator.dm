/datum/job/curator
	name = "Curator"
	total_positions = 1
	spawn_positions = 1
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

/datum/outfit/job/curator/journalist
	name = "Curator (Journalist)"
	uniform = /obj/item/clothing/under/suit/checkered
	head = /obj/item/clothing/head/fedora
	neck = /obj/item/camera
	l_hand = /obj/item/taperecorder
	l_pocket = /obj/item/newspaper
	backpack_contents = list(
		/obj/item/choice_beacon/hero = 1,
		/obj/item/tape = 1
	)

/datum/outfit/job/curator/librarian
	name = "Curator (Librarian)"
	uniform = /obj/item/clothing/under/suit/tan
	neck = /obj/item/clothing/neck/tie/brown
	backpack_contents = list(
		/obj/item/choice_beacon/hero = 1,
		/obj/item/tape = 1,
		/obj/item/paper_bin/bundlenatural = 1,
		/obj/item/pen/fountain = 1
	)
/datum/outfit/job/curator/dungeonmaster
	name = "Dungeon Master"
	uniform = /obj/item/clothing/under/misc/pj/red
	suit = /obj/item/clothing/suit/nerdshirt
	backpack_contents = list(
		/obj/item/choice_beacon/hero = 1,
		/obj/item/tape = 1,
		/obj/item/storage/pill_bottle/dice = 1,
		/obj/item/toy/cards/deck/cas = 1,
		/obj/item/toy/cards/deck/cas/black = 1,
		/obj/item/hourglass = 1
	)
