// WINTER COATS

//Someone please make the allowed lists globals or something

/obj/item/clothing/suit/hooded/wintercoat
	name = "winter coat"
	desc = "A heavy jacket made from 'synthetic' animal furs."
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/wintercoat.dmi'
	icon_state = "coatwinter"
	item_state = "coatwinter"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large
	allowed = list(	/obj/item/flashlight,
					/obj/item/tank/internals/emergency_oxygen,
					/obj/item/tank/internals/plasmaman,
					/obj/item/toy,
					/obj/item/storage/fancy/cigarettes,
					/obj/item/lighter,
					/obj/item/radio,
					/obj/item/storage/pill_bottle
					)

/obj/item/clothing/head/hooded/winterhood
	name = "winter hood"
	desc = "A hood attached to a heavy winter jacket."
	icon = 'icons/obj/clothing/head/winterhood.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/winterhood.dmi'
	icon_state = "hood_winter"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/suit/hooded/wintercoat/recolorable
	desc = "A heavy jacket made from 'synthetic' animal furs. This one can be recolored, but only once."
	unique_reskin = list(
		"grey winter coat" = "coatwinter"
		"red winter coat" = "coatsecurity",
		"light blue winter coat" = "coatmedical",
		"blue winter coat" = "coatparamedic",
		"white-purple winter coat" = "coatscience",
		"yellow winter coat" = "coatengineer",
		"yellow-cyan winter coat" = "coatatmos",
		"green-blue winter coat" = "coathydro",
		"black-yellow winter coat" = "coatcargo",
		"purple-orange winter coat" = "coatminer"
	)

/obj/item/clothing/suit/hooded/wintercoat/captain
	name = "captain's winter coat"
	icon_state = "coatcaptain"
	item_state = "coatcaptain"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/captain

/obj/item/clothing/suit/hooded/wintercoat/captain/Initialize()
	. = ..()
	allowed = GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/captain
	icon_state = "coatcaptain"

/obj/item/clothing/suit/hooded/wintercoat/security
	name = "security winter coat"
	icon_state = "coatsecurity"
	item_state = "coatsecurity"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security

/obj/item/clothing/suit/hooded/wintercoat/security/Initialize()
	. = ..()
	allowed = GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/security
	icon_state = "coatsecurity"

/obj/item/clothing/suit/hooded/wintercoat/medical
	name = "medical winter coat"
	icon_state = "coatmedical"
	item_state = "coatmedical"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical
	allowed = MEDICAL_SUIT_ALLOWED_ITEMS

/obj/item/clothing/head/hooded/winterhood/medical
	icon_state = "coatmedical"

/obj/item/clothing/suit/hooded/wintercoat/medical/paramedic
	name = "paramedic winter coat"
	icon_state = "coatparamedic"
	item_state = "coatparamedic"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/paramedic

/obj/item/clothing/head/hooded/winterhood/medical/paramedic
	icon_state = "coatparamedic"

/obj/item/clothing/suit/hooded/wintercoat/science
	name = "science winter coat"
	icon_state = "coatscience"
	item_state = "coatscience"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science
	allowed = list(
				/obj/item/analyzer,
				/obj/item/stack/medical,
				/obj/item/dnainjector,
				/obj/item/reagent_containers/dropper,
				/obj/item/reagent_containers/syringe,
				/obj/item/reagent_containers/hypospray,
				/obj/item/healthanalyzer,
				/obj/item/flashlight/pen,
				/obj/item/reagent_containers/glass/bottle,
				/obj/item/reagent_containers/glass/beaker,
				/obj/item/reagent_containers/pill,
				/obj/item/storage/pill_bottle,
				/obj/item/paper,
				/obj/item/melee/classic_baton/telescopic,
				/obj/item/toy,
				/obj/item/storage/fancy/cigarettes,
				/obj/item/lighter,
				/obj/item/tank/internals/emergency_oxygen,
				/obj/item/tank/internals/plasmaman,
				)

/obj/item/clothing/head/hooded/winterhood/science
	icon_state = "coatscience"

/obj/item/clothing/suit/hooded/wintercoat/engineering
	name = "engineering winter coat"
	icon_state = "coatengineer"
	item_state = "coatengineer"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering
	allowed = list(
				/obj/item/flashlight,
				/obj/item/tank/internals/emergency_oxygen,
				/obj/item/tank/internals/plasmaman,
				/obj/item/t_scanner,
				/obj/item/construction/rcd,
				/obj/item/pipe_dispenser,
				/obj/item/toy,
				/obj/item/storage/fancy/cigarettes,
				/obj/item/lighter,
				)


/obj/item/clothing/head/hooded/winterhood/engineering
	icon_state = "coatengineer"

/obj/item/clothing/suit/hooded/wintercoat/engineering/atmos
	name = "atmospherics winter coat"
	icon_state = "coatatmos"
	item_state = "coatatmos"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering/atmos

/obj/item/clothing/head/hooded/winterhood/engineering/atmos
	icon_state = "coatatmos"

/obj/item/clothing/suit/hooded/wintercoat/hydro
	name = "hydroponics winter coat"
	icon_state = "coathydro"
	item_state = "coathydro"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/hydro
	allowed = list(
				/obj/item/reagent_containers/spray/plantbgone,
				/obj/item/plant_analyzer,
				/obj/item/seeds,
				/obj/item/reagent_containers/glass/bottle,
				/obj/item/cultivator,
				/obj/item/reagent_containers/spray/pestspray,
				/obj/item/hatchet,
				/obj/item/storage/bag/plants,
				/obj/item/toy,
				/obj/item/tank/internals/emergency_oxygen,
				/obj/item/tank/internals/plasmaman,
				/obj/item/storage/fancy/cigarettes,
				/obj/item/lighter,
				)

/obj/item/clothing/head/hooded/winterhood/hydro
	icon_state = "coathydro"

/obj/item/clothing/suit/hooded/wintercoat/cargo
	name = "cargo winter coat"
	icon_state = "coatcargo"
	item_state = "coatcargo"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/cargo

/obj/item/clothing/head/hooded/winterhood/cargo
	icon_state = "coatcargo"

/obj/item/clothing/suit/hooded/wintercoat/miner
	name = "mining winter coat"
	icon_state = "coatminer"
	item_state = "coatminer"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/miner
	allowed = list(
				/obj/item/pickaxe,
				/obj/item/flashlight,
				/obj/item/tank/internals/emergency_oxygen,
				/obj/item/toy,
				/obj/item/storage/fancy/cigarettes,
				/obj/item/lighter,
				)

/obj/item/clothing/head/hooded/winterhood/miner
	icon_state = "coatminer"

// Inteq

/obj/item/clothing/suit/hooded/wintercoat/security/inteq
	name = "inteq winter coat"
	desc = "An armored wintercoat in the colors of the IRMG, the zipper tab is the golden shield of the IRMG."
	icon_state = "coatinteq"
	item_state = "coatinteq"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/inteq
	//supports_variations = KEPORI_VARIATION

/obj/item/clothing/head/hooded/winterhood/security/inteq
	icon_state = "coatinteq"
	//supports_variations = KEPORI_VARIATION

/obj/item/clothing/suit/hooded/wintercoat/security/inteq/alt
	name = "inteq hooded coat"
	desc = "A hooded coat with a fur trim around the hood, comfy! It has a small 'IRMG' embroidered onto the shoulder."
	icon_state = "coatinteq_alt"
	item_state = "coatinteq_alt"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/inteq/alt

/obj/item/clothing/head/hooded/winterhood/security/inteq/alt
	name = "inteq hood"
	desc = "A comfortable looking brown hood."
	icon_state = "coatinteq_alt"
	item_state = "coatinteq_alt"

// CentCom

/obj/item/clothing/suit/hooded/wintercoat/centcom
	name = "centcom winter coat"
	desc = "A luxurious winter coat woven in the bright green and gold colours of Central Command. It has a small pin in the shape of the Nanotrasen logo for a zipper."
	icon_state = "coatcentcom"
	item_state = "coatcentcom"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/centcom

/obj/item/clothing/suit/hooded/wintercoat/centcom/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/centcom
	icon_state = "coatcentcom"

// SolGov

/obj/item/clothing/suit/hooded/wintercoat/solgov
	name = "solgov winter coat"
	desc = "An environment-resistant wintercoat in the colors of the Solarian Confederation."
	icon_state = "coatsolgov"
	item_state = "coatsolgov"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/solgov

/obj/item/clothing/head/hooded/winterhood/solgov
	icon_state = "coatsolgov"
