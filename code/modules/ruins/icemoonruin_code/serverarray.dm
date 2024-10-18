///////////	things made for the server array icemoon ruin

/obj/item/paper/crumpled/bloody/fluff/ruins/serverarray
	default_raw_text = "my last words<BR><BR>ive killed<BR>i can still hear them even without tongues<BR>im so sorry,,, i have one bullet left<BR>they wont have my body too"
	name = "bloody note"

/datum/outfit/laborer
	name = "Laborer"

	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/nanotrasen
	suit = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/hardhat
	r_pocket = /obj/item/t_scanner
	back = /obj/item/storage/backpack/industrial
	id = /obj/item/card/id

/obj/effect/mob_spawn/human/laborer
	name = "Laborer"
	outfit = /datum/outfit/laborer
	icon_state = "corpseengineer"
