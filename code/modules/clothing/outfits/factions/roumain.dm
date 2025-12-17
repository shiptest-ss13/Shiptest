/datum/outfit/job/roumain
	name = "Saint-Roumain Militia - Base Outfit"
	faction = FACTION_PLAYER_ROUMAIN
	uniform = /obj/item/clothing/under/suit/roumain
	alt_uniform = /obj/item/clothing/under/suit/roumain/alt
	faction_icon = "bg_srm"


/datum/outfit/job/roumain/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	var/list/crafting_recipe_types = list(
		/datum/crafting_recipe/bonespear,
		/datum/crafting_recipe/boneaxe
	)
	if(H.mind)
		for(var/crafting_recipe_type in crafting_recipe_types)
			H.mind.teach_crafting_recipe(crafting_recipe_type)

// Assistant

/datum/outfit/job/roumain/assistant
	name = "Saint-Roumain Militia - Shadow"
	id_assignment = "Shadow"
	jobtype = /datum/job/assistant
	job_icon = "srm_shadow"

	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/shadow

	head = /obj/item/clothing/head/cowboy/sec/roumain/shadow

/datum/outfit/job/roumain/assistant/empty
	name = "Saint-Roumain Militia - Shadow (Naked)"

	suit = null
	head = null


// Captain

/datum/outfit/job/roumain/captain
	name = "Saint-Roumain Militia - Hunter Montagne"
	id_assignment = "Hunter Montagne"
	job_icon = "srm_montagne"
	jobtype = /datum/job/captain

	uniform = /obj/item/clothing/under/suit/roumain/montagne
	ears = /obj/item/radio/headset/headset_com/alt
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/montagne
	head = /obj/item/clothing/head/cowboy/sec/roumain/montagne
	id = /obj/item/card/id/gold

	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

	backpack_contents = null

/datum/outfit/job/roumain/captain/empty
	name = "Saint-Roumain Militia - Hunter Montagne (Naked)"

	ears = null
	suit = null
	head = null

// Second-In-Command

/datum/outfit/job/roumain/hop
	name = "Saint-Roumain Militia - Hunter Colligne"
	id_assignment = "Hunter Colligne"
	job_icon = "srm_colligne"
	jobtype = /datum/job/head_of_personnel

	ears = /obj/item/radio/headset/headset_com
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/colligne
	head = /obj/item/clothing/head/cowboy/sec/roumain/colligne
	id = /obj/item/card/id/silver

	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

	backpack_contents = null

/datum/outfit/job/roumain/hop/empty
	name = "Saint-Roumain Militia - Hunter Colligne (Naked)"

	ears = null
	suit = null
	head = null

/datum/outfit/job/roumain/security
	name = "Saint-Roumain Militia - Hunter"
	id_assignment = "Hunter"
	jobtype = /datum/job/officer
	job_icon = "srm_hunter"

	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain
	head = /obj/item/clothing/head/cowboy/sec/roumain
	gloves = null

	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

	backpack_contents = null

/datum/outfit/job/roumain/security/empty
	name = "Saint-Roumain Militia - Hunter (naked)"

	suit = null
	head = null

// engineer

/datum/outfit/job/roumain/engineer
	name = "Saint-Roumain Militia - Machinist"
	id_assignment = "Machinist"
	job_icon = "srm_machinist"
	jobtype = /datum/job/engineer

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

/datum/outfit/job/roumain/engineer/empty
	name = "Saint-Roumain Militia - Machinist (Naked)"

	belt = null
	suit = null
	head = null
	accessory = null

// Medical Doctor

/datum/outfit/job/roumain/doctor
	name = "Saint-Roumain Militia - Hunter Doctor"
	id_assignment = "Hunter Doctor"
	job_icon = "srm_doctor"
	jobtype = /datum/job/doctor

	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/toggle/labcoat/roumain_med
	head = /obj/item/clothing/head/cowboy/sec/roumain/med
	mask = /obj/item/clothing/mask/gas/plaguedoctor
	gloves = null

	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

/datum/outfit/job/roumain/doctor/empty
	name = "Saint-Roumain Militia - Hunter Doctor (Naked)"

	suit = null
	head = null
	mask = null

// Chaplain

/datum/outfit/job/roumain/flamebearer
	name = "Saint-Roumain Militia - Flamebearer"
	id_assignment = "Flamebearer"
	job_icon = "srm_flamebearer"
	jobtype = /datum/job/chaplain

	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/flamebearer
	head = /obj/item/clothing/head/cowboy/sec/roumain/flamebearer
	gloves = null

	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

	backpack_contents = null

/datum/outfit/job/roumain/flamebearer/empty
	name = "Saint-Roumain Militia - Flamebearer (Naked)"

	suit = null
	head = null
