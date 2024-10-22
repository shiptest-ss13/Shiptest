/datum/outfit/job/roumain/ert
	name = "ERT - Saint-Roumain Hunter" // flaming arrow and shadow
	id_assignment = "Hunter"
	jobtype = /datum/job/officer
	job_icon = "srm_hunter"

	wallet = null

	uniform = /obj/item/clothing/under/suit/roumain
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain
	head = /obj/item/clothing/head/cowboy/sec/roumain
	belt = /obj/item/gun/ballistic/revolver/shadow
	suit_store = /obj/item/gun/ballistic/shotgun/flamingarrow/factory

	l_pocket = /obj/item/ammo_box/a44roum_speedloader
	r_pocket = /obj/item/flashlight/lantern

	duffelbag = /obj/item/storage/backpack/satchel/leather
	courierbag = /obj/item/storage/backpack/satchel/leather
	backpack = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather
	box = null

	backpack_contents = list(/obj/item/ammo_box/a44roum_speedloader = 2, /obj/item/storage/box/ammo/c38)

/datum/outfit/job/roumain/ert/firestorm
	name = "ERT - Saint-Roumain Hunter (Firestorm)" // firestorm and shadow

	belt = /obj/item/gun/ballistic/revolver/shadow
	suit_store = /obj/item/gun/ballistic/automatic/smg/firestorm/pan

	l_pocket = /obj/item/ammo_box/a44roum_speedloader

	backpack_contents = list(/obj/item/ammo_box/magazine/c45_firestorm_mag/pan = 3, /obj/item/ammo_box/a44roum_speedloader = 2, /obj/item/storage/box/ammo/a44roum)

/datum/outfit/job/roumain/ert/vickland
	name = "ERT - Saint-Roumain Hunter (Vickland)" // vickland and candor

	belt = /obj/item/gun/ballistic/automatic/pistol/candor/factory
	suit_store = /obj/item/gun/ballistic/automatic/marksman/vickland

	l_pocket = /obj/item/ammo_box/magazine/m45

	backpack_contents = list(/obj/item/ammo_box/vickland_a308 = 6, /obj/item/storage/box/ammo/a308, /obj/item/ammo_box/magazine/m45 = 2)

/datum/outfit/job/roumain/ert/scout
	name = "ERT - Saint-Roumain Hunter (Scout)" // scout and detective special

	belt = /obj/item/gun/ballistic/revolver/detective
	suit_store = /obj/item/gun/ballistic/rifle/scout

	backpack_contents = list(/obj/item/ammo_box/a300 = 5)

/datum/outfit/job/roumain/ert/medic
	name = "ERT - Saint-Roumain Hunter Doctor"
	id_assignment = "Hunter Doctor"
	job_icon = "srm_doctor"
	jobtype = /datum/job/doctor

	uniform = /obj/item/clothing/under/suit/roumain
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/toggle/labcoat/roumain_med
	suit_store = null
	head = /obj/item/clothing/head/cowboy/sec/roumain/med
	mask = /obj/item/clothing/mask/gas/plaguedoctor
	gloves = null

/datum/outfit/job/roumain/ert/engineer
	name = "ERT - Saint-Roumain Machinist"
	id_assignment = "Machinist"
	job_icon = "srm_machinist"
	jobtype = /datum/job/engineer

	uniform = /obj/item/clothing/under/suit/roumain
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/workboots/mining
	belt = /obj/item/storage/belt/utility/full/engi
	suit = /obj/item/clothing/suit/hazardvest/roumain
	suit_store = null
	head = /obj/item/clothing/head/cowboy/sec/roumain/machinist
	glasses = /obj/item/clothing/glasses/welding
	accessory = /obj/item/clothing/accessory/waistcoat/roumain
	gloves = /obj/item/clothing/gloves/color/yellow


/datum/outfit/job/roumain/ert/leader
	name = "ERT - Saint-Roumain Hunter Montagne" // flaming bolt and montagne
	id_assignment = "Hunter Montagne"
	job_icon = "srm_montagne"
	jobtype = /datum/job/captain

	ears = /obj/item/radio/headset/headset_com/alt
	uniform = /obj/item/clothing/under/suit/roumain
	shoes = /obj/item/clothing/shoes/cowboy
	suit = /obj/item/clothing/suit/armor/roumain/montagne
	suit_store = /obj/item/gun/ballistic/shotgun/flamingarrow/bolt
	belt = /obj/item/gun/ballistic/revolver/montagne
	head = /obj/item/clothing/head/cowboy/sec/roumain/montagne
	id = /obj/item/card/id/gold

	duffelbag = /obj/item/storage/backpack/cultpack
	courierbag = /obj/item/storage/backpack/cultpack
	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack

/datum/outfit/job/roumain/ert/leader/twobore
	name = "ERT - Saint-Roumain Hunter Montagne (Huntsman)" // huntsman (twobore) and montagne

	suit_store = /obj/item/gun/ballistic/shotgun/doublebarrel/twobore

	l_pocket = /obj/item/ammo_box/a357

	backpack_contents = list(/obj/item/ammo_casing/shotgun/buckshot/twobore = 8)

/datum/outfit/job/roumain/ert/leader/colligne
	name = "ERT - Saint-Roumain Hunter Colligne" // double barrel and ashhand
	id_assignment = "Hunter Colligne"
	job_icon = "srm_colligne"
	jobtype = /datum/job/head_of_personnel

	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/suit/roumain
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/colligne
	suit_store = /obj/item/gun/ballistic/shotgun/doublebarrel/roumain
	head = /obj/item/clothing/head/cowboy/sec/roumain/colligne
	belt = /obj/item/gun/ballistic/revolver/ashhand
	id = /obj/item/card/id/silver

	backpack_contents = list(/obj/item/storage/box/ammo/a12g_buckshot, /obj/item/storage/box/ammo/a4570)
