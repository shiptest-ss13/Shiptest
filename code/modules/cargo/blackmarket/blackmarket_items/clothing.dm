/datum/blackmarket_item/clothing
	category = "Clothing"

/datum/blackmarket_item/clothing/cloth
	name = "Build Your Own Jumpsuit Special"
	desc = "Ever wanted to learn how to sew? This lovely selection of cloth is perfect to get some practice with."
	item = /obj/item/stack/sheet/cotton/cloth/ten

	price_min = 200
	price_max = 400
	stock_max = 5
	availability_prob = 80

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

/datum/blackmarket_item/clothing/degraded_armor_set
	name = "Clearance Bin Armor Set"
	desc = "Looking to protect yourself, but on a tight budget? These previously used vest and helmets served their former owners well! (May they rest in peace.)"
	item = /obj/item/storage/box

	price_min = 100
	price_max = 400
	stock_max = 3
	availability_prob = 80

/datum/blackmarket_item/clothing/degraded_armor_set/spawn_item(loc)
	var/obj/item/storage/box/B = ..()
	B.name = "Used Armor Set Box"
	B.desc = "It smells distinctly of iron."
	new /obj/item/clothing/head/helmet/old(B)
	new /obj/item/clothing/suit/armor/vest/old(B)
	return B

/datum/blackmarket_item/clothing/frontiersmen_armor_set
	name = "X-11 Bulletproof Armor Set"
	desc = "We got a good deal on some extra bulletproof armor from a Frontiersmen Quartermaster, and we're passing those savings onto you!"
	item = /obj/item/storage/box

	price_min = 1000
	price_max = 1750
	stock_max = 2
	availability_prob = 50

/datum/blackmarket_item/clothing/frontiersmen_armor_set/spawn_item(loc)
	var/obj/item/storage/box/B = ..()
	B.name = "Bulletproof Armor Set Box"
	B.desc = "A beat up looking box with some armor inside."
	new /obj/item/clothing/suit/armor/vest/bulletproof/frontier(B)
	new /obj/item/clothing/head/helmet/bulletproof/x11/frontier(B)
	return B

/datum/blackmarket_item/clothing/gezena_armor
	name = "Raksha-plating vest"
	desc = "Genuine armor vests used by the PGF Marine Corp. This is hot merchandise, so we need to move it fast."
	item = /obj/item/clothing/suit/armor/gezena/marine

	price_min = 1500
	price_max = 2000
	stock_max = 2
	availability_prob = 20

/datum/blackmarket_item/clothing/full_spacesuit_set
	name = "\improper Nanotrasen Branded Spacesuit Box"
	desc = "A few boxes of \"Old Style\" space suits fell off the back of a space truck."
	item = /obj/item/storage/box

	price_min = 250
	price_max = 750
	stock_max = 3
	availability_prob = 70

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

	price_min = 1000
	price_max = 1750
	stock_max = 2
	availability_prob = 40

/datum/blackmarket_item/clothing/ramzi_suit
	name = "Rusted Red hardsuit"
	desc = "A vintage ICW Era Gorlex Maruader hardsuit. The previous owner said we could have it when we pried it off their cold dead hands. Dry cleaning not included."
	item = /obj/item/clothing/head/helmet/space/hardsuit/syndi/ramzi

	price_min = 1250
	price_max = 2500
	stock = 1
	availability_prob = 30

/datum/blackmarket_item/clothing/frontiersmen_hardsuit
	name = "Frontiersmen hardsuit"
	desc = "An old, if not durable hardsuit typically used by the Frontiersmen. We accept no liability if you're shot by CLIP while wearing this."
	item = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

	price_min = 1000
	price_max = 2000
	stock_max = 2
	availability_prob = 30
