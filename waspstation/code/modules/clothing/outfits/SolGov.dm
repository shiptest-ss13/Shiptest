/datum/outfit/solgov
	name = "SolGov Officer"
	id = /obj/item/card/id/solgov
	uniform = /obj/item/clothing/under/solgov
	suit = /obj/item/clothing/suit/armor/vest/solgov
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/solgov
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/helmet/solgov
	r_pocket = /obj/item/gun/ballistic/automatic/pistol/solgov
	l_pocket = /obj/item/ammo_box/magazine/pistol556mm
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = /obj/item/gun/energy/laser/terra
	back = /obj/item/storage/backpack
	box = /obj/item/storage/box/survival
	backpack_contents = list(/obj/item/crowbar/power,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/ammo_box/magazine/pistol556mm=2)

/datum/outfit/solgov/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	var/obj/item/radio/headset/R = H.ears
	R.set_frequency(FREQ_SOLGOV)
	R.freqlock = TRUE

/datum/outfit/solgov/commander
	name = "SolGov Commander"
	id = /obj/item/card/id/solgov/commander
	uniform = /obj/item/clothing/under/solgov/formal
	suit = /obj/item/clothing/suit/toggle/solgov
	head = /obj/item/clothing/head/solgov
	r_pocket = /obj/item/gun/ballistic/automatic/pistol/solgov
	l_pocket = /obj/item/ammo_box/magazine/pistol556mm
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = null
	belt = /obj/item/gun/energy/pulse/terra
	back = /obj/item/storage/backpack
	box = /obj/item/storage/box/survival
	backpack_contents = list(/obj/item/crowbar/power,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/grenade/c4/x4=2,\
		/obj/item/ammo_box/magazine/pistol556mm=1,\
		/obj/item/megaphone=1,\
		/obj/item/clothing/head/beret/solgov=1)

/datum/outfit/solgov/elite
	name = "SolGov Elite"
	id = /obj/item/card/id/solgov/elite
	uniform = /obj/item/clothing/under/solgov/elite
	suit = /obj/item/clothing/suit/space/hardsuit/solgov
	suit_store = /obj/item/tank/internals/oxygen
	box = /obj/item/storage/box/survival
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/beret/solgov
	r_pocket = /obj/item/gun/ballistic/automatic/pistol/solgov
	l_pocket = /obj/item/melee/transforming/energy/ctf/solgov
	backpack_contents = list(/obj/item/crowbar/power,\
		/obj/item/ammo_box/magazine/rifle47x33mm=2,\
		/obj/item/grenade/c4/x4=2,\
		/obj/item/ammo_box/magazine/pistol556mm=2)
