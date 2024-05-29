/datum/blackmarket_item/tech
	category = "Technology"

/datum/blackmarket_item/tech/ripley_mk_4
	name = "Ripley Mk IV Upgrade Kit"
	desc = "Pimp out your Ripley to the CLIP Mark IV Rogue Model today! Killjoy bureaucrats not included, thank god."
	item = /obj/item/mecha_parts/mecha_equipment/conversion_kit/ripley/clip

	price_min = 1500
	price_max = 2500
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/tech/chem_master
	name = "Chem Master Board"
	desc = "A Chem Master board, capable of seperating and packaging reagents. Perfect for any aspiring at home chemist."
	item = /obj/item/circuitboard/machine/chem_master

	price_min = 1000
	price_max = 3000
	stock = 1
	availability_prob = 30

/datum/blackmarket_item/tech/ai_core
	name = "AI Core Board"
	desc = "The future is now! Become one with your ship with this AI core board! (Some assembly required.)"
	item = /obj/item/circuitboard/aicore
// pair_item = list(/datum/blackmarket_item/tech/boris, /datum/blackmarket_item/tech/mmi,/datum/blackmarket_item/tech/borg)

	price_min = 3000
	price_max = 4500
	stock = 1
	availability_prob = 20

/datum/blackmarket_item/tech/boris
	name = "B.O.R.I.S Module"
	desc = "A Bluespace Optimi-blah blah blah, I'm bored already. This module will convert a cyborg frame into an AI compatible shell."
	item = /obj/item/borg/upgrade/ai

	price_min = 500
	price_max = 1000
	stock = 1
	availability_prob = 0

/datum/blackmarket_item/tech/mmi
	name = "Man Machine Interface"
	desc = "Transcend the weakness of your flesh with this man machine interface, compatible with AIs, Cyborgs and Mechs!"
	item = /obj/item/mmi
	pair_item = /datum/blackmarket_item/tech/borg

	price_min = 500
	price_max = 1000
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/tech/borg
	name = "Cyborg Construction Kit"
	desc = "This durable and verastile cyborg frame is capable of fufilling a number of roles and survive situations that would kill the average person. Brain sold seperately."
	item = /obj/structure/closet/crate/cyborg

	price_min = 1000
	price_max = 2000
	stock_max = 2
	availability_prob = 0
