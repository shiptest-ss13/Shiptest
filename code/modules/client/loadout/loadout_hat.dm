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

//Berets, AKA how I lost my will to live again

/datum/gear/hat/beret
	display_name = "beret, red"
	path = /obj/item/clothing/head/beret

/datum/gear/hat/beret/departmental
	display_name = "beret, departmental"
	path = /obj/item/clothing/head/beret/grey
	role_replacements = list(
		/datum/job/captain = /obj/item/clothing/head/beret/captain,
		/datum/job/head_of_personnel = /obj/item/clothing/head/beret/hop,
		/datum/job/solgov = /obj/item/clothing/head/beret/solgov,

		/datum/job/hos = /obj/item/clothing/head/beret/sec/hos,
		/datum/job/warden = /obj/item/clothing/head/beret/sec/warden,
		/datum/job/officer = /obj/item/clothing/head/beret/sec/officer,
		/datum/job/detective = /obj/item/clothing/head/beret/sec,
		/datum/job/brig_phys = /obj/item/clothing/head/beret/sec/brig_phys,

		/datum/job/chief_engineer = /obj/item/clothing/head/beret/ce,
		/datum/job/engineer = /obj/item/clothing/head/beret/eng,
		/datum/job/atmos = /obj/item/clothing/head/beret/atmos,

		/datum/job/rd = /obj/item/clothing/head/beret/rd,
		/datum/job/scientist = /obj/item/clothing/head/beret/sci,
		/datum/job/roboticist = /obj/item/clothing/head/beret/sci,

		/datum/job/cmo = /obj/item/clothing/head/beret/cmo,
		/datum/job/doctor = /obj/item/clothing/head/beret/med,
		/datum/job/paramedic = /obj/item/clothing/head/beret/med,
		/datum/job/chemist = /obj/item/clothing/head/beret/chem,
		/datum/job/geneticist = /obj/item/clothing/head/beret/med,

		/datum/job/qm = /obj/item/clothing/head/beret/qm,
		/datum/job/cargo_tech = /obj/item/clothing/head/beret/cargo,
		/datum/job/mining = /obj/item/clothing/head/beret/mining,

		/datum/job/bartender = /obj/item/clothing/head/beret/service,
		/datum/job/hydro = /obj/item/clothing/head/beret/service,
		/datum/job/cook = /obj/item/clothing/head/beret/service,
		/datum/job/curator = /obj/item/clothing/head/beret/service,
		/datum/job/janitor = /obj/item/clothing/head/beret/service,
		/datum/job/lawyer = /obj/item/clothing/head/beret/service,
		/datum/job/mime = /obj/item/clothing/head/beret,
		/datum/job/clown = /obj/item/clothing/head/beret/puce
	)

/datum/gear/hat/beret/engineering/hazard
	display_name = "beret, hazard"
	path = /obj/item/clothing/head/beret/eng/hazard
	allowed_roles = list("Station Engineer", "Atmospheric Technician", "Chief Engineer")

//Misc

/datum/gear/hat/that
	display_name = "top hat"
	path = /obj/item/clothing/head/that

/datum/gear/hat/maidheadband
	display_name = "maid headband"
	path = /obj/item/clothing/head/maidheadband

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

/datum/gear/hat/catears
	display_name = "cat ears"
	path = /obj/item/clothing/head/kitty

/datum/gear/hat/horse
	display_name = "horse mask"
	path = /obj/item/clothing/mask/horsehead
	slot = ITEM_SLOT_MASK

/datum/gear/hat/piratehat
	display_name = "pirate hat"
	description = "Yarr. Comes with one free pirate speak manual."
	path = /obj/item/clothing/head/pirate

/datum/gear/hat/ushanka
	display_name = "space ushanka"
	path = /obj/item/clothing/head/ushanka
