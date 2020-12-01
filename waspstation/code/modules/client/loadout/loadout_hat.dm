/datum/gear/hat
	subtype_path = /datum/gear/hat
	slot = ITEM_SLOT_HEAD
	sort_category = "Headwear"
	species_blacklist = list("plasmaman") //Their helmet takes up the head slot
	cost = 1000

//Hardhats

/datum/gear/hat/hhat_yellow
	display_name = "hardhat, yellow"
	path = /obj/item/clothing/head/hardhat
	allowed_roles = list("Chief Engineer", "Engineer", "Atmospheric Technician")
	cost = 900

/datum/gear/hat/hhat_orange
	display_name = "hardhat, orange"
	path = /obj/item/clothing/head/hardhat/orange
	allowed_roles = list("Chief Engineer", "Engineer", "Atmospheric Technician")

/datum/gear/hat/hhat_blue
	display_name = "hardhat, blue"
	path = /obj/item/clothing/head/hardhat/dblue
	allowed_roles = list("Chief Engineer", "Engineer", "Atmospheric Technician")

//Berets, AKA how I lost my will to live again

/datum/gear/hat/beret
	display_name = "beret, red"
	path = /obj/item/clothing/head/beret
	cost = 2000

/datum/gear/hat/beret/departmental
	display_name = "beret, departmental"
	path = /obj/item/clothing/head/beret/grey
	role_replacements = list(
		"Captain" = /obj/item/clothing/head/beret/captain,
		"Head of Personnel" = /obj/item/clothing/head/beret/hop,
		"Lieutenant" = /obj/item/clothing/head/beret/lt,

		"Head of Security" = /obj/item/clothing/head/beret/sec/navyhos,
		"Warden" = /obj/item/clothing/head/beret/sec/navywarden,
		"Security Officer" = /obj/item/clothing/head/beret/sec/navyofficer,
		"Detective" = /obj/item/clothing/head/beret/sec,
		"Brig Physician" = /obj/item/clothing/head/beret/sec,

		"Chief Engineer" = /obj/item/clothing/head/beret/ce,
		"Station Engineer" = /obj/item/clothing/head/beret/eng,
		"Atmospheric Technician" = /obj/item/clothing/head/beret/atmos,

		"Research Director" = /obj/item/clothing/head/beret/rd,
		"Scientist" = /obj/item/clothing/head/beret/sci,
		"Roboticist" = /obj/item/clothing/head/beret/sci,

		"Chief Medical Officer" = /obj/item/clothing/head/beret/cmo,
		"Medical Doctor" = /obj/item/clothing/head/beret/med,
		"Paramedic" = /obj/item/clothing/head/beret/med,
		"Chemist" = /obj/item/clothing/head/beret/chem,
		"Geneticist" = /obj/item/clothing/head/beret/med,

		"Quartermaster" = /obj/item/clothing/head/beret/qm,
		"Cargo Technician" = /obj/item/clothing/head/beret/cargo,
		"Shaft Miner" = /obj/item/clothing/head/beret/mining,

		"Bartender" = /obj/item/clothing/head/beret/service,
		"Botanist" = /obj/item/clothing/head/beret/service,
		"Chef" = /obj/item/clothing/head/beret/service,
		"Curator" = /obj/item/clothing/head/beret/service,
		"Janitor" = /obj/item/clothing/head/beret/service,
		"Lawyer" = /obj/item/clothing/head/beret/service,
		"Mime" = /obj/item/clothing/head/beret,
		"Clown" = /obj/item/clothing/head/beret/puce
	)

/datum/gear/hat/beret/engineering/hazard
	display_name = "beret, hazard"
	path = /obj/item/clothing/head/beret/eng/hazard
	allowed_roles = list("Station Engineer", "Atmospheric Technician", "Chief Engineer")

//Misc

/datum/gear/hat/that
	display_name = "top hat"
	path = /obj/item/clothing/head/that

/datum/gear/hat/fedora
	display_name = "fedora"
	path = /obj/item/clothing/head/fedora

/datum/gear/hat/flatcap
	display_name = "flatcap"
	path = /obj/item/clothing/head/flatcap

/datum/gear/hat/beanie
	display_name = "beanie"
	path = /obj/item/clothing/head/beanie

/datum/gear/hat/tinfoil
	display_name = "tinfoil hat"
	path = /obj/item/clothing/head/foilhat

/datum/gear/hat/wig
	display_name = "wig"
	path = /obj/item/clothing/head/wig

/datum/gear/hat/cowboy
	display_name = "cowboy hat"
	path = /obj/item/clothing/head/cowboy
	cost = 1500

/datum/gear/hat/tinfoil
	display_name = "cat ears"
	path = /obj/item/clothing/head/kitty
	cost = 5000
