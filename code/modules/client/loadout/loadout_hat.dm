/datum/gear/hat
	subtype_path = /datum/gear/hat
	slot = ITEM_SLOT_HEAD
	sort_category = "Headwear"
	species_blacklist = list("plasmaman") //Their helmet takes up the head slot

//Hardhats

/datum/gear/hat/hhat_yellow
	display_name = "hardhat, yellow"
	path = /obj/item/clothing/head/hardhat
	allowed_roles = list("Chief Engineer", "Engineer", "Atmospheric Technician")

/datum/gear/hat/hhat_orange
	display_name = "hardhat, orange"
	path = /obj/item/clothing/head/hardhat/orange
	allowed_roles = list("Chief Engineer", "Engineer", "Atmospheric Technician")

/datum/gear/hat/hhat_blue
	display_name = "hardhat, blue"
	path = /obj/item/clothing/head/hardhat/dblue
	allowed_roles = list("Chief Engineer", "Engineer", "Atmospheric Technician")

//Motorcycle Helmets

/datum/gear/hat/motorcycle
	display_name = "motorcycle helmet, recolorable"
	path = /obj/item/clothing/head/motorcycle

/datum/gear/hat/motorcycle_cat
	display_name = "motorcycle helmet (ears), recolorable"
	path = /obj/item/clothing/head/motorcycle/cat

//Berets, AKA how I lost my will to live again

/datum/gear/hat/beret
	display_name = "beret, recolorable"
	path = /obj/item/clothing/head/beret/color

/datum/gear/hat/beret/departmental
	display_name = "beret, departmental"
	path = /obj/item/clothing/head/beret/grey
	role_replacements = list(
		"Captain" = /obj/item/clothing/head/beret/captain,
		"Head of Personnel" = /obj/item/clothing/head/beret/hop,
		"SolGov Representative" = /obj/item/clothing/head/beret/solgov,

		"Head of Security" = /obj/item/clothing/head/beret/sec/hos,
		"Warden" = /obj/item/clothing/head/beret/sec/warden,
		"Security Officer" = /obj/item/clothing/head/beret/sec/officer,
		"Detective" = /obj/item/clothing/head/beret/sec,
		"Brig Physician" = /obj/item/clothing/head/beret/sec/brig_phys,

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
	)

/datum/gear/hat/beret/engineering/hazard
	display_name = "beret, hazard"
	path = /obj/item/clothing/head/beret/eng/hazard
	allowed_roles = list("Station Engineer", "Atmospheric Technician", "Chief Engineer")

//Soft caps

/datum/gear/hat/softcap
	display_name = "cap, recolorable"
	path = /obj/item/clothing/head/soft

/datum/gear/hat/utility_black
	display_name = "utility cover, black"
	path = /obj/item/clothing/head/soft/utility_black

/datum/gear/hat/utility_olive
	display_name = "utility cover, olive"
	path = /obj/item/clothing/head/soft/utility_olive

/datum/gear/hat/utility_beige
	display_name = "utility cover, beige"
	path = /obj/item/clothing/head/soft/utility_beige

/datum/gear/hat/utility_navy
	display_name = "utility cover, navy"
	path = /obj/item/clothing/head/soft/utility_navy


//Beanies

/datum/gear/hat/beanie
	display_name = "beanie, recolorable"
	path = /obj/item/clothing/head/beanie

//Misc

/datum/gear/hat/that
	display_name = "top hat"
	path = /obj/item/clothing/head/that

/datum/gear/hat/fedora
	display_name = "fedora, black"
	path = /obj/item/clothing/head/fedora

/datum/gear/hat/fedora/white
	display_name = "fedora, white"
	path = /obj/item/clothing/head/fedora/white

/datum/gear/hat/fedora/beige
	display_name = "fedora, beige"
	path = /obj/item/clothing/head/fedora/beige

/datum/gear/hat/flatcap
	display_name = "flatcap"
	path = /obj/item/clothing/head/flatcap

/datum/gear/hat/wig
	display_name = "wig"
	path = /obj/item/clothing/head/wig

/datum/gear/hat/cowboy
	display_name = "cowboy hat"
	path = /obj/item/clothing/head/cowboy

/datum/gear/hat/cowboyblack
	display_name = "black cowboy hat"
	path = /obj/item/clothing/head/cowboy/black

/datum/gear/hat/trapper
	display_name = "trapper hat"
	path = /obj/item/clothing/head/trapper

/datum/gear/hat/flowers
	display_name = "plastic flower, pickable"
	path = /obj/item/clothing/head/plastic_flower

/datum/gear/hat/flap
	display_name = "flap cap, recolorable"
	path = /obj/item/clothing/head/flap

/datum/gear/hat/sunhat
	display_name = "sun hat"
	path = /obj/item/clothing/head/sunhat

/datum/gear/hat/hairbow
	display_name = "hairbow, recolorable"
	path = /obj/item/clothing/head/hairbow

/datum/gear/hat/headband
	display_name = "headband, recolorable"
	path = /obj/item/clothing/head/headband

/datum/gear/hat/ribbon
	display_name = "ribbon, recolorable"
	path = /obj/item/clothing/head/ribbon
