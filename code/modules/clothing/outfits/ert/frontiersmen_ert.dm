/datum/outfit/job/frontiersmen/ert
	name = "ERT - Frontiersman Basic"

	head = /obj/item/clothing/head/beret/sec/frontier
	mask = /obj/item/clothing/mask/gas/sechailer/balaclava
	suit = /obj/item/clothing/suit/armor/vest/bulletproof/frontier
	suit_store = /obj/item/gun/ballistic/rifle/illestren
	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/radio/headset/pirate/alt
	back = /obj/item/storage/backpack
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	id = null // lol

	backpack_contents = list(/obj/item/ammo_box/magazine/illestren_a850r=5, /obj/item/grenade/frag=1)

/datum/outfit/job/frontiersmen/ert/random
	name = "ERT - Frontiersman Randomized"

	head = null
	mask = null
	suit = null
	suit_store = null
	back = null
	l_pocket = null
	r_pocket = /obj/item/radio
	backpack_contents = list()

/datum/outfit/job/frontiersmen/ert/random/pre_equip(mob/living/carbon/human/H, visualsOnly, client/preference_source)
	. = ..()
	if(visualsOnly)
		return

	if(prob(90))
		head = pickweight(list(
		/obj/item/clothing/head/beret/sec/frontier = 10,
		/obj/item/clothing/head/helmet/bulletproof/x11/frontier = 5,
		/obj/item/reagent_containers/glass/bucket = 1))

	if(prob(60))
		suit = pickweight(list(
		/obj/item/clothing/suit/armor/vest = 5,
		/obj/item/clothing/suit/armor/vest/bulletproof/frontier = 5,
		/obj/item/clothing/suit/armor/vest/scrap_armor = 1))

	if(prob(30))
		mask = pickweight(list(
		/obj/item/clothing/mask/gas = 5,
		/obj/item/clothing/mask/gas/sechailer/balaclava = 5,
		/obj/item/clothing/mask/breath = 5,
		/obj/item/clothing/mask/whistle = 3))

	if(prob(90))
		back = pickweight(list(
		/obj/item/storage/backpack = 20,
		/obj/item/storage/backpack/satchel = 20,
		/obj/item/storage/backpack/messenger = 20,
		/obj/item/melee/baton/cattleprod/loaded = 5,
		/obj/item/reagent_containers/food/snacks/baguette = 2, // yes you can put this on your back
		/obj/item/deployable_turret_folded = 1,
		))

	if(prob(90))
		shoes = pickweight(list(
		/obj/item/clothing/shoes/jackboots = 10,
		/obj/item/clothing/shoes/sneakers = 5,
		))

	var/extra_class = pick(list("Doctor", "Breacher", "Ammo Carrier"))
	switch(extra_class)
		if("Doctor")
			backpack_contents += list(/obj/item/storage/firstaid/regular = 1)
			gloves = /obj/item/clothing/gloves/color/latex
			if(prob(50))
				belt = /obj/item/storage/belt/medical/surgery
			if(prob(30))
				glasses = /obj/item/clothing/glasses/hud/health
		if("Breacher")
			backpack_contents += list(/obj/item/grenade/c4 = 2)
			if(prob(10))
				belt = /obj/item/storage/belt/grenade/full
		if("Ammo Carrier")
			backpack_contents += list(/obj/item/ammo_box/a762_40 = 1)

	var/weapon = pick(list("Bolt-Action", "Pistol", "Melee"))
	switch(weapon)
		if("Bolt-Action")
			r_hand = /obj/item/gun/ballistic/rifle/illestren
			if(prob(70) && istype(back, /obj/item/storage/backpack))
				backpack_contents += list(/obj/item/ammo_box/magazine/illestren_a850r = rand(1,4))
			if(prob(55))
				l_pocket = /obj/item/ammo_box/magazine/illestren_a850r
		if("Pistol")
			r_hand = pick(list(
			/obj/item/gun/ballistic/automatic/pistol/disposable,
			/obj/item/gun/ballistic/automatic/pistol,
			/obj/item/gun/ballistic/revolver/firebrand,
			/obj/item/gun/energy/e_gun/mini))
			if(prob(30))
				l_hand = pick(list(
				/obj/item/gun/ballistic/automatic/pistol/disposable,
				/obj/item/gun/ballistic/automatic/pistol,
				/obj/item/gun/ballistic/revolver/firebrand,
				/obj/item/gun/energy/e_gun/mini))
		if("Melee")
			r_hand = pickweight(list(
			/obj/item/kitchen/knife = 15,
			/obj/item/melee/baseball_bat = 10,
			/obj/item/melee/cleric_mace = 7,
			/obj/item/melee/roastingstick = 2,
			/obj/item/kitchen/fork = 1,
			/obj/item/melee/flyswatter = 1,
			))


/datum/outfit/job/frontiersmen/ert/leader
	name = "ERT - Frontiersman Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/frontier/officer
	head = /obj/item/clothing/head/beret/sec/frontier/officer
	ears = /obj/item/radio/headset/pirate/alt/captain
	back = /obj/item/storage/backpack/satchel/leather
	suit = /obj/item/clothing/suit/armor/frontier
	suit_store = /obj/item/gun/ballistic/revolver
	belt = /obj/item/storage/belt/military/assault

	backpack_contents = list(/obj/item/ammo_box/a357=3, /obj/item/binoculars=1, /obj/item/kitchen/knife/combat/survival)

/datum/outfit/job/frontiersmen/ert/medic
	name = "ERT - Frontiersman Medic"

	back = /obj/item/storage/backpack/medic
	mask = /obj/item/clothing/mask/surgical
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/storage/belt/medical/surgery
	suit = null
	suit_store = null

	backpack_contents = list(/obj/item/storage/firstaid/medical=1, /obj/item/reagent_containers/hypospray/medipen/stimpack=3)


/datum/outfit/job/frontiersmen/ert/engineer
	name = "ERT - Frontiersman Engineer"

	back = /obj/item/storage/backpack/industrial
	belt = /obj/item/storage/belt/utility/full
	head = /obj/item/clothing/head/hardhat/weldhat
	suit_store = null

	backpack_contents = list(/obj/item/grenade/c4=3, /obj/item/crowbar/large=1)

