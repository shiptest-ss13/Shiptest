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
	allowed_roles = list("Chief Engineer", "Engineer")
	cost = 900

/datum/gear/hat/hhat_orange
	display_name = "hardhat, orange"
	path = /obj/item/clothing/head/hardhat/orange
	allowed_roles = list("Chief Engineer", "Engineer")

/datum/gear/hat/hhat_blue
	display_name = "hardhat, blue"
	path = /obj/item/clothing/head/hardhat/dblue
	allowed_roles = list("Chief Engineer", "Engineer")

//Berets, AKA how I lost my will to live again

/datum/gear/hat/beret
	display_name = "beret, red"
	cost = 2000

/datum/gear/hat/beret/service
	display_name = "beret, service"
	path = /obj/item/clothing/head/beret/service

/datum/gear/hat/beret/medical
	display_name = "beret, medical"
	path = /obj/item/clothing/head/beret/med
	allowed_roles = list("Medical Doctor", "Chemist", "Chief Medical Officer", "Geneticist")

/datum/gear/hat/beret/science
	display_name = "beret, science"
	path = /obj/item/clothing/head/beret/sci
	allowed_roles = list("Scientist", "Research Director", "Roboticist")


//Engineering
/datum/gear/hat/beret/engineering
	display_name = "beret, engineering"
	path = /obj/item/clothing/head/beret/eng
	allowed_roles = list("Station Engineer", "Atmospheric Technician", "Chief Engineer")
	collapse = TRUE

/datum/gear/hat/beret/engineering/atmos
	display_name = "beret, atmos"
	path = /obj/item/clothing/head/beret/atmos
	allowed_roles = list("Atmospheric Technician", "Chief Engineer")
	hidden = TRUE

/datum/gear/hat/beret/engineering/hazard
	display_name = "beret, hazard"
	path = /obj/item/clothing/head/beret/eng/hazard
	allowed_roles = list("Station Engineer", "Atmospheric Technician", "Chief Engineer")
	hidden = TRUE

/datum/gear/hat/beret/engineering/ce
	display_name = "beret, chief engineer"
	path = /obj/item/clothing/head/beret/ce
	allowed_roles = list("Chief Engineer")
	hidden = TRUE

//Sec
/datum/gear/hat/beret/security
	display_name = "beret, security"
	path = /obj/item/clothing/head/beret/sec
	allowed_roles = list("Security Officer", "Warden", "Detective", "Head of Security")

/datum/gear/hat/beret/command
	display_name = "beret, command"
	path = /obj/item/clothing/head/beret/command
	allowed_roles = list("Captain", "Head of Personnel", "Lieutenant")
	collapse = TRUE

/datum/gear/hat/beret/command/captain
	display_name = "beret, captain"
	path = /obj/item/clothing/head/beret/captain
	allowed_roles = list("Captain")
	hidden = TRUE

/datum/gear/hat/beret/command/hop
	display_name = "beret, head of personnel"
	path = /obj/item/clothing/head/beret/hop
	allowed_roles = list("Captain", "Head of Personnel")
	hidden = TRUE

/datum/gear/hat/beret/command/lt
	display_name = "beret, lieutenant"
	path = /obj/item/clothing/head/beret/lt
	allowed_roles = list("Captain", "Head of Personnel", "Lieutenant")
	hidden = TRUE

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
