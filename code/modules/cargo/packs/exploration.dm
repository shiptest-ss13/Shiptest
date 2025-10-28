/datum/supply_pack/exploration
	category = "Exploration"
	crate_type = /obj/structure/closet/crate/wooden

/* Exploration Gear */

/datum/supply_pack/exploration/lava
	name = "Lava Exploration Kit"
	desc = "Contains 50 rods, a pocket extinguisher, and goggles to protect yourself from the heat."
	cost = 50
	contains = list(
		/obj/item/extinguisher/mini,
		/obj/item/clothing/glasses/heat,
		/obj/item/stack/rods/fifty,
	)
	crate_name = "Lava Exploration Kit"

/datum/supply_pack/exploration/ice
	name = "Ice Exploration Kit"
	desc = "Contains a set of winter clothes and ice hiking boots, along with goggles to protect eyes from the cold."
	cost = 250
	contains = list(
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/suit/hooded/wintercoat,
		/obj/item/clothing/shoes/winterboots/ice_boots,
	)
	crate_name = "Ice Exploration Kit"


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
	desc = "Contains one pair of binoculars for surveying terrain."
	cost = 200
	contains = list(
		/obj/item/binoculars
	)

/datum/supply_pack/exploration/anom_neutralizer
	name = "Anomaly Neutralizer"
	desc = "Contains a single use anomaly neutralizer for stabilizing hazardous anomalies."
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
	desc = "Contains a GPS device, useful for keeping track of yourself and others."
	cost = 100
	contains = list(
		/obj/item/gps
	)

/datum/supply_pack/exploration/flares
	name = "Flare Supply Pack"
	desc = "Contains a box of flares (7 total)! Great for lighting things up."
	cost = 25
	contains = list(
		/obj/item/storage/box/flares,
	)

/datum/supply_pack/exploration/nvg
	name = "Night Vision Goggles"
	desc = "Contains a singular pair of Night Vision Goggles, for all your spelunking and military LARP occasions."
	cost = 1000
	contains = list(
		/obj/item/clothing/glasses/night
	)
