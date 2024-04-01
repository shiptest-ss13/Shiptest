/datum/outfit/job/roumain
	name = "Saint-Roumain Militia - Base Outfit"

	uniform = /obj/item/clothing/under/suit/roumain
	id = /obj/item/card/id
	faction_icon = "bg_srm"

	box = null

/datum/outfit/job/roumain/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_PLAYER_ROUMAIN)

// Assistant

/datum/outfit/job/roumain/assistant
	name = "Saint-Roumain Militia - Shadow"
	id_assignment = "Shadow"
	jobtype = /datum/job/assistant
	job_icon = "assistant"

	uniform = /obj/item/clothing/under/suit/roumain
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/shadow

	head = /obj/item/clothing/head/cowboy/sec/roumain/shadow

// Captain

/datum/outfit/job/roumain/captain
	name = "Saint-Roumain Militia - Hunter Montagne"
	id_assignment = "Hunter Montagne"
	job_icon = "captain"
	jobtype = /datum/job/captain

	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/suit/roumain
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/hos/roumain/montagne
	head = /obj/item/clothing/head/HoS/cowboy/montagne
	id = /obj/item/card/id/silver

	duffelbag = /obj/item/storage/backpack/cultpack
	courierbag = /obj/item/storage/backpack/cultpack
	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack

	backpack_contents = list(/obj/item/book/manual/srmlore=1,
		/obj/item/stamp/chap = 1,
		/obj/item/melee/classic_baton/telescopic=1,
	)
	chameleon_extras = null

/datum/outfit/job/roumain/security
	name = "Saint-Roumain Militia - Hunter"
	id_assignment = "Hunter"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	uniform = /obj/item/clothing/under/suit/roumain
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain
	head = /obj/item/clothing/head/cowboy/sec/roumain
	gloves = null

	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

	backpack_contents = null

// Medical Doctor

/datum/outfit/job/roumain/doctor
	name = "Saint-Roumain Militia - Hunter Doctor"
	id_assignment = "Hunter Doctor"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor

	uniform = /obj/item/clothing/under/suit/roumain
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/toggle/labcoat/roumain_med
	head = /obj/item/clothing/head/cowboy/sec/roumain/med
	mask = /obj/item/clothing/mask/gas/plaguedoctor
	gloves = null

	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger
