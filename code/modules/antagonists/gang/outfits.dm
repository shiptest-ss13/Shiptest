/datum/outfit/families_police
	name = "Families: Police Officer"

/datum/outfit/families_police/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/W = H.wear_id
	W.access = get_all_accesses() // I have a warrant.
	W.assignment = "Space Police"
	W.registered_name = H.real_name
	W.update_label()
	..()

/datum/outfit/families_police/beatcop
	name = "Families: Beat Cop"

	uniform = /obj/item/clothing/under/rank/security/officer/beatcop
	back = /obj/item/storage/backpack/duffelbag/cops
	suit = null
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = null
	glasses = /obj/item/clothing/glasses/hud/spacecop
	ears = /obj/item/radio/headset/headset_sec
	mask = null
	belt = /obj/item/gun/ballistic/automatic/pistol/candor
	r_pocket = /obj/item/lighter
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id
	backpack_contents = list(/obj/item/storage/box/handcuffs = 1,
	/obj/item/storage/box/teargas = 1,
	/obj/item/storage/box/flashbangs = 1,
	/obj/item/shield/tele = 1)

/datum/outfit/families_police/beatcop/armored
	name = "Families: Armored Beat Cop"
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	head = /obj/item/clothing/head/helmet/blueshirt
	backpack_contents = list(/obj/item/storage/box/handcuffs = 1,
	/obj/item/storage/box/teargas = 1,
	/obj/item/storage/box/flashbangs = 1,
	/obj/item/shield/tele = 1,
	/obj/item/storage/box/lethalshot = 2)

/datum/outfit/families_police/beatcop/swat
	name = "Families: SWAT Beat Cop"
	suit = /obj/item/clothing/suit/armor/riot
	head = /obj/item/clothing/head/helmet/riot
	gloves = /obj/item/clothing/gloves/combat
	backpack_contents = list(/obj/item/storage/box/handcuffs = 1,
	/obj/item/storage/box/teargas = 1,
	/obj/item/storage/box/flashbangs = 1,
	/obj/item/shield/tele = 1)

/datum/outfit/families_police/beatcop/fbi
	name = "Families: Space FBI Officer"
	suit = /obj/item/clothing/suit/armor/laserproof
	head = /obj/item/clothing/head/helmet/riot
	gloves = /obj/item/clothing/gloves/combat
	backpack_contents = list(/obj/item/storage/box/handcuffs = 1,
	/obj/item/storage/box/teargas = 1,
	/obj/item/storage/box/flashbangs = 1,
	/obj/item/shield/tele = 1,
	/obj/item/ammo_box/magazine/m9mm_expedition = 3)

/datum/outfit/families_police/beatcop/military
	name = "Families: Space Military"
	uniform = /obj/item/clothing/under/syndicate/camo
	suit = /obj/item/clothing/suit/armor/laserproof
	head = /obj/item/clothing/head/beret/durathread
	belt = /obj/item/gun/energy/laser/scatter
	gloves = /obj/item/clothing/gloves/combat
	backpack_contents = list(/obj/item/storage/box/handcuffs = 1,
	/obj/item/storage/box/teargas = 1,
	/obj/item/storage/box/flashbangs = 1,
	/obj/item/shield/tele = 1)
