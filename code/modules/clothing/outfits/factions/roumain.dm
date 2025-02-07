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
	job_icon = "srm_shadow"

	uniform = /obj/item/clothing/under/suit/roumain
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/shadow

	head = /obj/item/clothing/head/cowboy/sec/roumain/shadow

// Captain

/datum/outfit/job/roumain/captain
	name = "Saint-Roumain Militia - Hunter Montagne"
	id_assignment = "Hunter Montagne"
	job_icon = "srm_montagne"
	jobtype = /datum/job/captain

	ears = /obj/item/radio/headset/headset_com/alt
	uniform = /obj/item/clothing/under/suit/roumain
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/montagne
	head = /obj/item/clothing/head/cowboy/sec/roumain/montagne
	id = /obj/item/card/id/gold

	duffelbag = /obj/item/storage/backpack/cultpack
	courierbag = /obj/item/storage/backpack/cultpack
	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack

	backpack_contents = list(/obj/item/book/manual/srmlore=1,
		/obj/item/stamp/chap = 1,
		/obj/item/melee/classic_baton/telescopic=1,
	)
	chameleon_extras = null

// Second-In-Command

/datum/outfit/job/roumain/hop
	name = "Saint-Roumain Militia - Hunter Colligne"
	id_assignment = "Hunter Colligne"
	job_icon = "srm_colligne"
	jobtype = /datum/job/head_of_personnel

	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/suit/roumain
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/colligne
	head = /obj/item/clothing/head/cowboy/sec/roumain/colligne
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
	job_icon = "srm_hunter"

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

// engineer

/datum/outfit/job/roumain/engineer
	name = "Saint-Roumain Militia - Machinist"
	id_assignment = "Machinist"
	job_icon = "srm_machinist"
	jobtype = /datum/job/engineer

	uniform = /obj/item/clothing/under/suit/roumain
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/workboots/mining
	belt = /obj/item/storage/belt/utility/full/engi
	suit = /obj/item/clothing/suit/hazardvest/roumain
	head = /obj/item/clothing/head/cowboy/sec/roumain/machinist
	accessory = /obj/item/clothing/accessory/waistcoat/roumain
	gloves = null

	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

// Medical Doctor

/datum/outfit/job/roumain/doctor
	name = "Saint-Roumain Militia - Hunter Doctor"
	id_assignment = "Hunter Doctor"
	job_icon = "srm_doctor"
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

// Chaplain

/datum/outfit/job/roumain/flamebearer
	name = "Saint-Roumain Militia - Flamebearer"
	id_assignment = "Flamebearer"
	job_icon = "srm_flamebearer"
	jobtype = /datum/job/chaplain

	uniform = /obj/item/clothing/under/suit/roumain
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/flamebearer
	head = /obj/item/clothing/head/cowboy/sec/roumain/flamebearer
	gloves = null

	duffelbag = /obj/item/storage/backpack/cultpack
	courierbag = /obj/item/storage/backpack/cultpack
	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack

	backpack_contents = list(/obj/item/book/manual/srmlore=1,
		/obj/item/stamp/chap = 1,
	)
