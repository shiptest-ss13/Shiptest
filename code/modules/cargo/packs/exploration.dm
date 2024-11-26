/datum/supply_pack/exploration
	group = "Exploration"
	crate_type = /obj/structure/closet/crate/wooden

/*
		Basic survival kits for worlds.
*/

/datum/supply_pack/exploration/lava
	name = "Lava Exploration Kit"
	desc = "Contains two pickaxes, 60 lavaproof rods, two pocket extinguishers and goggles to protect yourself from the heat."
	cost = 500
	contains = list(
		/obj/item/pickaxe/mini,
		/obj/item/pickaxe/mini,
		/obj/item/extinguisher/mini,
		/obj/item/extinguisher/mini,
		/obj/item/clothing/glasses/heat,
		/obj/item/clothing/glasses/heat,
		/obj/item/stack/rods/lava/thirty,
		/obj/item/stack/rods/lava/thirty,
	)
	crate_name = "Lava Exploration Kit"

/datum/supply_pack/exploration/lavaproof_ords
	name ="Lavaproof Rods Crate"
	desc = "Contains 60 lavaproof rods for safely traversing molten pits."
	cost = 200
	contains = list(
		/obj/item/stack/rods/lava/thirty,
		/obj/item/stack/rods/lava/thirty,
		)
	crate_name = "Lavaproof Rod Crate"

/datum/supply_pack/exploration/ice
	name = "Ice Exploration Kit"
	desc = "Contains two pickaxes, 2 sets of winter clothes and ice hiking boots, along with goggles to protect eyes from the cold."
	cost = 500
	contains = list(
		/obj/item/pickaxe/mini,
		/obj/item/pickaxe/mini,
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/suit/hooded/wintercoat,
		/obj/item/clothing/suit/hooded/wintercoat,
		/obj/item/clothing/shoes/winterboots/ice_boots,
		/obj/item/clothing/shoes/winterboots/ice_boots,
	)
	crate_name = "Ice Exploration Kit"

/datum/supply_pack/exploration/jungle
	name = "Jungle Exploration Kit"
	desc = "Contains a hatchets, two picks and lanterns, plus antivenom pills, great for dense jungles!"
	cost = 500
	contains = list(
		/obj/item/pickaxe/mini,
		/obj/item/pickaxe/mini,
		/obj/item/flashlight/lantern,
		/obj/item/flashlight/lantern,
		/obj/item/storage/pill_bottle/charcoal,
		/obj/item/storage/pill_bottle/charcoal,
		/obj/item/hatchet,
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
		General Exploration Gear
*/

/datum/supply_pack/exploration/capsules
	name = "Bluespace Shelter Capsule"
	desc = "Contains a Bluespace Shelter Capsule, for instant shelter in rough situations."
	cost = 500
	contains = list(
		/obj/item/survivalcapsule
	)

/datum/supply_pack/exploration/binocular
	name = "Binoculars"
	desc = "One pair of binoculars for surveying terrain."
	cost = 200
	contains = list(
		/obj/item/binoculars
	)

/datum/supply_pack/exploration/anom_neutralizer
	name = "Anomaly Neutralizer"
	desc = "A single use anomaly neutralizer for stabalizing hazardous anomalies."
	cost = 250
	contains = list(
		/obj/item/anomaly_neutralizer
	)

/datum/supply_pack/exploration/mineral_scanner
	name = "Underground Mineral Scanner"
	desc = "Contains an underground mineral scanner for locating veins of ore beneath the earth. Deep core laser drill for extracting said ores not included."
	cost = 250
	contains = list(
		/obj/item/pinpointer/mineral
	)

/datum/supply_pack/exploration/gps
	name = "GPS"
	desc = "Contains a GPS device, useful for finding lost things and not getting lost yourself."
	cost = 100
	contains = list(
		/obj/item/gps
	)

/datum/supply_pack/exploration/flares
	name = "Flare Supply Pack"
	desc = "Contains 4 boxes of flares (28 total)! Great for lighting things up."
	cost = 100
	contains = list(
		/obj/item/storage/box/flares,
		/obj/item/storage/box/flares,
		/obj/item/storage/box/flares,
		/obj/item/storage/box/flares,
	)
