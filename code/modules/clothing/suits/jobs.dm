/*
 * Job related
 */

//Botanist
/obj/item/clothing/suit/apron
	name = "apron"
	desc = "A basic blue apron."
	icon = 'icons/obj/clothing/suits/utility.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/utility.dmi'
	icon_state = "apron"
	item_state = "apron"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN
	allowed = list(/obj/item/reagent_containers/spray/plantbgone, /obj/item/plant_analyzer, /obj/item/seeds, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/cultivator, /obj/item/reagent_containers/spray/pestspray, /obj/item/hatchet, /obj/item/storage/bag/plants)

/obj/item/clothing/suit/apron/waders
	name = "horticultural waders"
	desc = "A pair of heavy duty leather waders, perfect for insulating your soft flesh from spills, soil and thorns."
	icon_state = "hort_waders"
	item_state = "hort_waders"
	body_parts_covered = CHEST|GROIN|LEGS
	permeability_coefficient = 0.5

//Captain
/obj/item/clothing/suit/captunic
	name = "captain's parade tunic"
	desc = "Worn by a Captain to show their class."
	icon_state = "captunic"
	item_state = "bio_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT
	allowed = list(/obj/item/disk, /obj/item/stamp, /obj/item/reagent_containers/food/drinks/flask, /obj/item/melee, /obj/item/storage/lockbox/medal, /obj/item/assembly/flash/handheld, /obj/item/storage/box/matches, /obj/item/lighter, /obj/item/clothing/mask/cigarette, /obj/item/storage/fancy/cigarettes, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

//Chef
/obj/item/clothing/suit/toggle/chef
	name = "chef's apron"
	desc = "An apron-jacket used by a high class chef."
	icon_state = "chef"
	item_state = "chef"
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list(/obj/item/kitchen)
	togglename = "sleeves"

//Cook
/obj/item/clothing/suit/apron/chef
	name = "cook's apron"
	desc = "A basic, dull, white chef's apron."
	icon_state = "apronchef"
	item_state = "apronchef"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN
	allowed = list(/obj/item/kitchen)

//Detective
/obj/item/clothing/suit/det_suit
	name = "trenchcoat"
	desc = "An 18th-century multi-purpose trenchcoat. Someone who wears this means serious business."
	icon_state = "detective"
	item_state = "det_suit"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 35, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 45)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/det_suit/Initialize()
	. = ..()
	allowed = GLOB.detective_vest_allowed

/obj/item/clothing/suit/det_suit/grey
	name = "noir trenchcoat"
	desc = "A hard-boiled private investigator's grey trenchcoat."
	icon_state = "greydet"
	item_state = "greydet"

/obj/item/clothing/suit/det_suit/noir
	name = "noir suit coat"
	desc = "A dapper private investigator's grey suit coat."
	icon_state = "detsuit"
	item_state = "detsuit"

//Engineering
/obj/item/clothing/suit/hazardvest
	name = "hazard vest"
	desc = "A high-visibility vest used in work zones."
	icon = 'icons/obj/clothing/suits/utility.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/utility.dmi'
	icon_state = "hazard"
	item_state = "hazard"
	blood_overlay_type = "armor"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/t_scanner, /obj/item/radio)
	resistance_flags = NONE
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large

/obj/item/clothing/suit/hazardvest/solgov
	name = "SolGov hazard vest"
	desc = "A high-visibility vest used in work zones by solarian engineers."
	icon_state = "hazard_solgov"
	item_state = "hazard_solgov"
	blood_overlay_type = "armor"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/t_scanner, /obj/item/radio)
	resistance_flags = NONE
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large

/obj/item/clothing/suit/toggle/hazard
	name = "high-visibility jacket"
	desc = "A highlighter-yellow jacket with reflective stripes."
	icon_state = "jacket_hazard"
	item_state = "jacket_hazard"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	togglename = "zipper"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/t_scanner, /obj/item/radio)
	resistance_flags = NONE
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large

/obj/item/clothing/suit/toggle/industrial
	name = "industrial jacket"
	desc = "A black bomber jacket with high-visibility markings."
	icon_state = "highvis"
	item_state = "highvis"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	togglename = "zipper"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/t_scanner, /obj/item/radio)
	resistance_flags = NONE
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large

//Lawyer
/obj/item/clothing/suit/toggle/lawyer
	name = "blue suit jacket"
	desc = "A snappy dress jacket."
	icon_state = "suitjacket_blue"
	item_state = "suitjacket_blue"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	togglename = "buttons"

/obj/item/clothing/suit/toggle/lawyer/purple
	name = "purple suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_purp"
	item_state = "suitjacket_purp"

/obj/item/clothing/suit/toggle/lawyer/black
	name = "black suit jacket"
	desc = "A professional suit jacket."
	icon_state = "suitjacket_black"
	item_state = "ro_suit"

/obj/item/clothing/suit/toggle/lawyer/burgundy
	name = "burgundy suit jacket"
	desc = "A burgundy suit jacket. Makes you want to psychoanalyze."
	icon_state = "suitjacket_burgundy"
	item_state = "suitjacket_burgundy"

/obj/item/clothing/suit/toggle/lawyer/navy
	name = "navy suit jacket"
	desc = "An orderly dress jacket."
	icon_state = "suitjacket_navy"
	item_state = "suitjacket_navy"

/obj/item/clothing/suit/toggle/lawyer/charcoal
	name = "charcoal suit jacket"
	desc = "An enterprising dress jacket."
	icon_state = "suitjacket_charcoal"
	item_state = "suitjacket_charcoal"

/obj/item/clothing/suit/toggle/lawyer/minutemen
	name = "minutemen suit jacket"
	desc = "An enterprising dress jacket used by officers of the Colonial Minutemen."
	icon_state = "suitjacket_minuteman"
	item_state = "suitjacket_navy"

/obj/item/clothing/suit/toggle/lawyer/minutemen/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed //it's hop-equivalent gear after all

/obj/item/clothing/suit/toggle/lawyer/cmo
	name = "light blue suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_cmo"

/obj/item/clothing/suit/toggle/lawyer/medical
	name = "saturated blue suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_medical"

/obj/item/clothing/suit/toggle/lawyer/science
	name = "purple suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_science"

/obj/item/clothing/suit/toggle/lawyer/brown
	name = "brown suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_brown"

/obj/item/clothing/suit/toggle/lawyer/orange
	name = "orange suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_orange"

/obj/item/clothing/suit/toggle/lawyer/atmos
	name = "light blue jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_light_blue"

//Mime
/obj/item/clothing/suit/toggle/suspenders
	name = "suspenders"
	desc = "They suspend the illusion of the mime's play."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "suspenders"
	blood_overlay_type = "armor" //it's the less thing that I can put here
	togglename = "straps"

//Surgeon
/obj/item/clothing/suit/apron/surgical
	name = "surgical apron"
	desc = "A sterile blue surgical apron."
	icon_state = "surgical"
	allowed = list(/obj/item/scalpel, /obj/item/cautery, /obj/item/hemostat, /obj/item/retractor)

//Robotocist

/obj/item/clothing/suit/hooded/techpriest
	name = "techpriest robes"
	desc = "For those who REALLY love their toasters."
	icon_state = "techpriest"
	item_state = "techpriest"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hooded/techpriest

/obj/item/clothing/head/hooded/techpriest
	name = "techpriest's hood"
	desc = "A hood for those who REALLY love their toasters."
	icon_state = "techpriesthood"
	item_state = "techpriesthood"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS

//Lieutenant
/obj/item/clothing/suit/armor/lieutenant_trenchcoat
	name = "lieutenant's trenchcoat"
	desc = "A design taken from a war over 500 years ago. Makes you look like a badass."
	icon_state = "armor_blueshield_trenchcoat"
	item_state = "trenchcoat_blueshield"
	blood_overlay_type = "coat"
	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|ARMS|HANDS
	cold_protection = CHEST|LEGS|ARMS
	heat_protection = CHEST|LEGS|ARMS

/obj/item/clothing/suit/toggle/lieutenant
	name = "lieutenant's coat"
	desc = "Surplus from some military. You finally have your own coat."
	icon_state = "blueshield_coat"
	item_state = "blueshield_coat"
	allowed = list(/obj/item/gun/energy, /obj/item/reagent_containers/spray/pepper, /obj/item/ammo_box, /obj/item/ammo_casing,/obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/flashlight/seclite, /obj/item/melee/classic_baton)
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	body_parts_covered = CHEST|GROIN|ARMS|HANDS

//SolGov suits

/obj/item/clothing/suit/solgov
	name = "SolGov robe"
	desc = "A set of plain SolGov robes, commonly used by civilians."
	body_parts_covered = CHEST|GROIN|ARMS
	icon_state = "solgov_robe"
	item_state = "solgov_robe"

/obj/item/clothing/suit/solgov/dress
	name = "SolGov dress"
	desc = "A plain SolGov dress, commonly used by civilians."
	body_parts_covered = CHEST|GROIN
	icon_state = "solgov_dress"
	item_state = "solgov_dress"

/obj/item/clothing/suit/solgov/suit
	name = "SolGov suit"
	desc = "A formal SolGov suit, commonly used by civilians."
	body_parts_covered = CHEST|GROIN
	icon_state = "solgov_suit"
	item_state = "solgov_suit"

/obj/item/clothing/suit/solgov/bureaucrat
	name = "SolGov bureaucrat robe"
	desc = "A set of unique SolGov robes, utilized by Solarian Bureaucrats."
	body_parts_covered = CHEST|GROIN|ARMS
	icon_state = "solgov_bureaucrat_robe"
	item_state = "solgov_bureaucrat_robe"

/obj/item/clothing/suit/solgov/jacket
	name = "SolGov jacket"
	desc = "A plain SolGov jacket, commonly used by civilians."
	body_parts_covered = CHEST|GROIN|ARMS
	icon_state = "solgov_jacket"
	item_state = "solgov_jacket"

/obj/item/clothing/suit/toggle/solgov
	name = "\improper SolGov coat"
	desc = "An armored coat worn for special occasions. This one is dyed in SolGov blue."
	body_parts_covered = CHEST|GROIN|ARMS|HANDS
	icon_state = "coat_solgov"
	item_state = "coat_solgov"
	blood_overlay_type = "coat"
	togglename = "buttons"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/suit/toggle/solgov/terragov
	name = "\improper Terragov coat"
	desc = "An armored coat worn for special occasions. This one is still dyed in original TerraGov green."
	icon_state = "coat_terragov"
	item_state = "coat_terragov"

/obj/item/clothing/suit/hooded/enginseer
	name = "enginseer regalia"
	desc = "You hold the secrets of the Machine."
	icon_state = "enginseer"
	item_state = "enginseer"
	hoodtype = /obj/item/clothing/head/hooded/enginseer
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDESHOES|HIDEJUMPSUIT|HIDEGLOVES
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/gun, /obj/item/melee, /obj/item/nullrod, /obj/item/radio, /obj/item/storage/book)

/obj/item/clothing/head/hooded/enginseer
	name = "enginseer's hood"
	desc = "You are honored that they require your skills."
	icon_state = "enginseerhood"
	item_state = "enginseerhood"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACE|HIDEFACIALHAIR
