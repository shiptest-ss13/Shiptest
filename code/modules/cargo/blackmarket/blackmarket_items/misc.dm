/datum/blackmarket_item/misc
	category = "Miscellaneous"

/datum/blackmarket_item/misc/cap_gun
	name = "Cap Gun"
	desc = "Prank your friends with this harmless gun! Harmlessness guranteed."
	item = /obj/item/toy/gun

	price_min = 50
	price_max = 200
	stock_max = 6
	availability_prob = 80

/datum/blackmarket_item/misc/shoulder_holster
	name = "Shoulder holster"
	desc = "Yeehaw, hardboiled friends! This holster is the first step in your dream of becoming a detective and being allowed to shoot real guns!"
	item = /obj/item/clothing/accessory/holster

	price_min = 200
	price_max = 800
	stock_max = 8
	availability_prob = 60

/datum/blackmarket_item/misc/strange_seed
	name = "Strange Seeds"
	desc = "An Exotic Variety of seed that can contain anything from glow to acid."
	item = /obj/item/seeds/random

	price_min = 150
	price_max = 360
	availability_prob = 100
	unlimited = TRUE

/datum/blackmarket_item/misc/smugglers_satchel
	name = "Smuggler's Satchel"
	desc = "This easily hidden satchel can become a versatile tool to anybody with the desire to keep certain items out of sight and out of mind."
	item = /obj/item/storage/backpack/satchel/flat/empty

	price_min = 250
	price_max = 1000
	stock_max = 2
	availability_prob = 30

/datum/blackmarket_item/misc/organs
	name = "Organ Freezer"
	desc = "Need some fresh organs in a jiffy? We got you covered. Make good use of them, someone died to get these to you."
	item = /obj/structure/closet/crate/freezer/surplus_limbs/organs

	price_min = 1000
	price_max = 2500
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/misc/abandoned_crate
	name = "Abandoned Crate"
	desc = "Why, it could be anything. Are you feeling lucky?"
	item = /obj/structure/closet/crate/secure/loot

	price_min = 250
	price_max = 400
	availability_prob = 100
	unlimited =  TRUE

/datum/blackmarket_item/misc/spygass
	name = "Spy Glass Kit"
	desc = "A set of trick glasses and a linked camera. Suit and dashing shades not included."
	item = /obj/item/storage/box/rxglasses/spyglasskit

	price_min = 250
	price_max = 1000
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/misc/ripley_mk_4
	name = "Ripley Mk IV Upgrade Kit"
	desc = "Pimp out your Ripley to the CLIP Mark IV Rogue Model today! Killjoy bureaucrats not included, thank god."
	item = /obj/item/mecha_parts/mecha_equipment/conversion_kit/ripley/clip

	price_min = 1500
	price_max = 2500
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/misc/secret_docs
	name = "Classified Documents"
	desc = "Good people died to get these. Luckily, we aren't good people."
	item = /obj/item/documents

	price_min = 1000
	price_max = 10000
	stock = 1
	availability_prob = 40

/datum/blackmarket_item/misc/secret_docs/spawn_item(loc)
	var/docs = pick(list(/obj/item/documents/nanotrasen,
				/obj/item/documents/solgov,
				/obj/item/documents/terragov,
				/obj/item/documents/syndicate/red))
	return new docs(loc)

/datum/blackmarket_item/misc/black_box
	name = "Blackbox"
	desc = "Recorded in here is final moments of some poor souls who are no longer with us. We suggest watching it with friends and popcorn."
	item = /obj/item/blackbox

	price_min = 1000
	price_max = 10000
	stock = 1
	availability_prob = 40
