/datum/blackmarket_item/clothing
	category = "Clothing"

/datum/blackmarket_item/clothing/ninja_mask
	name = "Space Ninja Mask"
	desc = "Apart from being acid, lava, fireproof and being hard to take off someone it does nothing special on it's own."
	item = /obj/item/clothing/mask/gas/space_ninja

	price_min = 200
	price_max = 500
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/clothing/durathread_vest
	name = "Durathread Vest"
	desc = "Don't let them tell you this stuff is \"Like asbestos\" or \"Pulled from the market for safety concerns\". It could be the difference between a robusting and a retaliation."
	item = /obj/item/clothing/suit/armor/vest/durathread

	price_min = 200
	price_max = 400
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/clothing/durathread_helmet
	name = "Durathread Helmet"
	desc = "Customers ask why it's called a helmet when it's just made from armoured fabric and I always say the same thing: No refunds."
	item = /obj/item/clothing/head/helmet/durathread

	price_min = 100
	price_max = 200
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/clothing/full_spacesuit_set
	name = "\improper Nanotrasen Branded Spacesuit Box"
	desc = "A few boxes of \"Old Style\" space suits fell off the back of a space truck."
	item = /obj/item/storage/box

	price_min = 1500
	price_max = 2000
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/clothing/full_spacesuit_set/spawn_item(loc)
	var/obj/item/storage/box/B = ..()
	B.name = "Spacesuit Box"
	B.desc = "It has a NT logo on it."
	new /obj/item/clothing/suit/space(B)
	new /obj/item/clothing/head/helmet/space(B)
	return B

/datum/blackmarket_item/clothing/chameleon_hat
	name = "Chameleon Hat"
	desc = "Pick any hat you want with this Handy device. Not Quality Tested."
	item = /obj/item/clothing/head/chameleon/broken

	price_min = 100
	price_max = 200
	stock_max = 2
	availability_prob = 70

/datum/blackmarket_item/clothing/combatmedic_suit
	name = "Combat Medic hardsuit"
	desc = "A discarded combat medic hardsuit, found in the ruins of a carpet bombed xeno hive. Definately used, but as sturdy as an anchor."
	item = /obj/item/clothing/suit/space/hardsuit/combatmedic

	price_min = 5500
	price_max = 6000
	stock_max = 1
	availability_prob = 10
/datum/blackmarket_item/clothing/hitmankit
	name = "Hitman Kit"
	desc = "Because at the end of the day, as long as there is two people left on the planet, someone is gonna want someone dead."
	item = /obj/item/storage/backpack/duffelbag/syndie/hitman

	price_min = 7000
	price_max = 8500
	availability_prob = 15
	stock_max = 3
/datum/blackmarket_item/clothing/centcom
	name = "Nanotrasen Intern Costume"
	desc = "Can get you out of a situation in a pinch, beware of SSV vessels (Please, just beware)"
	item = /obj/item/storage/box/syndie_kit/centcom_costume
	price_min = 1300
	price_max = 1600
	availability_prob = 20
	stock_max = 4
