/datum/outfit/sonnensoldner
	name = "SolGov Sonnensoldner"
	id = /obj/item/card/id/solgov
	uniform = /obj/item/clothing/under/solgov
	suit = /obj/item/clothing/suit/armor/vest/bulletproof/solgov
	ears = /obj/item/radio/headset/solgov
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/solgov/sonnensoldner
	r_hand = /obj/item/energyhalberd
	r_pocket = /obj/item/gun/ballistic/automatic/pistol/solgov
	l_pocket = /obj/item/ammo_box/magazine/pistol556mm
	shoes = /obj/item/clothing/shoes/jackboots
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
	back = /obj/item/storage/backpack
	box = /obj/item/storage/box/survival
	backpack_contents = list(/obj/item/crowbar/power,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/grenade/c4/x4=2,\
		/obj/item/ammo_box/magazine/pistol556mm=1,\
		/obj/item/megaphone=1,\
		/obj/item/clothing/head/beret/solgov=1)
