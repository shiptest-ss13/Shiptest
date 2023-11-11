/datum/supply_pack/exploration
	group = "Exploration"
	crate_type = /obj/structure/closet/crate/wooden

/*
		Basic survival kits for worlds.
*/

/datum/supply_pack/exploration/lava
	name = "Lava Exploration Kit"
	desc = "Contains two pickaxes, 60 lavaproof rods, and goggles to protect eyes from the heat"
	cost = 1500
	contains = list(
		/obj/item/pickaxe/mini,
		/obj/item/pickaxe/mini,
		/obj/item/clothing/glasses/heat,
		/obj/item/clothing/glasses/heat,
		/obj/item/clothing/glasses/heat,
		/obj/item/clothing/glasses/heat,
		/obj/item/stack/rods/lava/thirty,
		/obj/item/stack/rods/lava/thirty,
	)
	crate_name = "Lava Exploration Kit"

/datum/supply_pack/exploration/ice
	name = "Ice Exploration Kit"
	desc = "Contains two pickaxes, winter clothes, and goggles to protect eyes from the cold"
	cost = 1500
	contains = list(
		/obj/item/pickaxe/mini,
		/obj/item/pickaxe/mini,
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/shoes/winterboots,
		/obj/item/clothing/shoes/winterboots,
		/obj/item/clothing/shoes/winterboots,
		/obj/item/clothing/shoes/winterboots,
	)
	crate_name = "Ice Exploration Kit"

/datum/supply_pack/exploration/jungle
	name = "Jungle Exploration Kit"
	desc = "Contains hatchets, picks, and antivenom, great for dense jungles!"
	cost = 750
	contains = list(
		/obj/item/pickaxe/mini,
		/obj/item/pickaxe/mini,
		/obj/item/storage/pill_bottle/charcoal,
		/obj/item/storage/pill_bottle/charcoal,
		/obj/item/hatchet,
	)
	crate_name = "Jungle Exploration Kit"

/datum/supply_pack/exploration/beach
	name = "Beach Kit"
	desc = "Shorts, picks, and (low quality) sunglasses, perfect for the beach!"
	cost = 500
	contains = list(
		/obj/item/pickaxe/mini,
		/obj/item/pickaxe/mini,
		/obj/item/clothing/under/shorts/black,
		/obj/item/clothing/under/shorts/blue,
		/obj/item/clothing/under/shorts/green,
		/obj/item/clothing/under/shorts/grey,
		/obj/item/clothing/under/shorts/purple,
		/obj/item/clothing/under/shorts/red,
		/obj/item/clothing/glasses/cheapsuns,
		/obj/item/clothing/glasses/cheapsuns,
		/obj/item/clothing/glasses/cheapsuns,
		/obj/item/clothing/glasses/cheapsuns,
		/obj/item/clothing/glasses/cheapsuns,
		/obj/item/clothing/glasses/cheapsuns,
	)
	crate_name = "Beach Kit"

/*
		Heavy Duty Exploration Gear
*/

/datum/supply_pack/exploration/capsules
	name = "Bluespace Shelter Capsules"
	desc = "A trio of Bluespace Shelter Capsules, for instant shelter in rough situations."
	cost = 3000
	contains = list(
		/obj/item/survivalcapsule,
		/obj/item/survivalcapsule,
		/obj/item/survivalcapsule,
	)

/datum/supply_pack/exploration/scanners
	name = "Survey Scanner Kit"
	desc = "Contains a Survey Scanner and survey locator, ideal for analyzing the surface of planets."
	cost = 1250
	contains = list(
		/obj/item/gear_pack/survey_pack,
		/obj/item/pinpointer/survey_data
	)
	crate_name = "Survey Scanner Kit"

/datum/supply_pack/exploration/adv_scanner
	name = "Advanced Survey Scanner Kit"
	desc = "Contains a state of the art Survey Scanner"
	cost = 2000
	contains = list(
		/obj/item/gear_pack/survey_pack/advanced,
		/obj/item/pinpointer/survey_data
	)
	crate_name = "Survey Scanner Kit"
