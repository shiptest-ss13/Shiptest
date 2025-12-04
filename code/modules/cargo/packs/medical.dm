/datum/supply_pack/medical
	category = "Medical"
	crate_type = /obj/structure/closet/crate/medical

/*
		First aid kits
*/

/datum/supply_pack/medical/analyzer
	name = "Health Analyzer"
	desc = "An order for a single basic health analyzer."
	cost = 125
	contains = list(/obj/item/healthanalyzer)

/datum/supply_pack/medical/firstaid_single
	name = "First Aid Kit Single-Pack"
	desc = "Contains one first aid kit for healing most types of wounds."
	cost = 400
	contains = list(/obj/item/storage/firstaid/regular)

/datum/supply_pack/medical/firstaidbruises_single
	name = "Bruise Treatment Kit Single-Pack"
	desc = "Contains one first aid kit focused on healing bruises and broken bones."
	cost = 500
	contains = list(/obj/item/storage/firstaid/brute)

/datum/supply_pack/medical/firstaidburns_single
	name = "Burn Treatment Kit Single-Pack"
	desc = "Contains one first aid kit focused on healing severe burns."
	cost = 500
	contains = list(/obj/item/storage/firstaid/fire)

/datum/supply_pack/medical/firstaidoxygen_single
	name = "Oxygen Deprivation Kit Single-Pack"
	desc = "Contains one first aid kit focused on helping oxygen deprivation victims."
	cost = 500
	contains = list(/obj/item/storage/firstaid/o2)

/datum/supply_pack/medical/firstaidtoxins_single
	name = "Toxin Treatment Kit Single-Pack"
	desc = "Contains one first aid kit focused on healing damage dealt by heavy toxins."
	cost = 500
	contains = list(/obj/item/storage/firstaid/toxin)

/datum/supply_pack/medical/firstaid_rad_single
	name = "Radiation Treatment Kit Single-Pack"
	desc = "Contains one first aid kit focused on reducing the damage done by radiation."
	cost = 500
	contains = list(/obj/item/storage/firstaid/radiation)

/datum/supply_pack/medical/firstaidroumain_single
	name = "Roumain Medical Kit Single-Pack"
	desc = "Contains one first aid kit filled with natural medicine commonly used by the Saint-Roumain Militia."
	cost = 400
	contains = list(/obj/item/storage/firstaid/roumain)
	faction = /datum/faction/srm
	faction_discount = 10

/datum/supply_pack/medical/salbutamol_canister
	name = "Salbutamol Inhaler Canister Single-Pack"
	desc = "Contains one inhaler canister filled with aerosolized salbutamol, a potent bronchodilator."
	cost = 200
	contains = list(/obj/item/reagent_containers/inhaler_canister/salbutamol)

/*
		Tools
*/

/datum/supply_pack/medical/painkillers
	name = "Painkiller Supply Crate"
	desc = "Contains a supply of painkillers. Great for stopping headaches, feeling broken bones, and screaming people!"
	cost = 1000
	contains = list(
		/obj/item/reagent_containers/chem_pack/dimorlin,
		/obj/item/reagent_containers/glass/bottle/morphine,
		/obj/item/reagent_containers/glass/bottle/morphine,
		/obj/item/reagent_containers/glass/bottle/tramal,
		/obj/item/reagent_containers/glass/bottle/tramal,
	)
	faction = /datum/faction/syndicate/suns
	faction_discount = 25

/datum/supply_pack/medical/painkillers/fill(obj/structure/closet/crate/cargo_crate)
	. = ..()
	if(prob(5))
		new /obj/item/reagent_containers/glass/bottle/painkiller_booze(cargo_crate)

/datum/supply_pack/medical/iv_drip
	name = "IV Drip Crate"
	desc = "Contains a single IV drip for administering blood to patients."
	cost = 1000
	contains = list(/obj/machinery/iv_drip)
	crate_name = "iv drip crate"

/datum/supply_pack/medical/defibs
	name = "Defibrillator Crate"
	desc = "Contains a defibrillator for bringing the recently deceased back to life."
	cost = 750
	contains = list(/obj/item/defibrillator/loaded)
	crate_name = "defibrillator crate"

/datum/supply_pack/medical/surgery
	name = "Surgical Supplies Crate"
	desc = "Do you want to perform surgery, but don't have one of those fancy shmancy degrees? Just get started with this crate containing a medical case, Sterilizine spray and collapsible roller bed."
	cost = 3000
	contains = list(/obj/item/storage/case/surgery,
					/obj/item/reagent_containers/medigel/sterilizine,
					/obj/item/roller)
	crate_name = "surgical supplies crate"
	faction = /datum/faction/syndicate/suns
	faction_discount = 50 //this shouldnt be 3k but if it is...

/datum/supply_pack/medical/disk
	name = "Advanced Surgical Procedure Disk"
	desc = "A disk containing Advanced T2 surgical procedures for wound tending. Requires an Operating Console."
	cost = 2000
	contains = list(/obj/item/disk/surgery/t2)
	crate_name = "surgical supplies crate"

/datum/supply_pack/medical/console
	name = "Operating Console Crate"
	desc = "Contains a console board to construct an Operating Console. Required to install surgical disks and gives basic diagnostics on the patients vitals."
	cost = 500
	contains = list(/obj/item/circuitboard/computer/operating)
	crate_name = "surgical supplies crate"

/datum/supply_pack/medical/anesthetic
	name = "Anesthetics Crate"
	desc = "Contains a standard anesthetics tank, for standard surgical procedures."
	cost = 500
	contains = list(/obj/item/clothing/mask/breath/medical,
					/obj/item/tank/internals/anesthetic)
	crate_name = "anesthetics crate"
	faction = /datum/faction/syndicate/suns
	faction_discount = 25

/*
		Bundles and supplies
*/

/datum/supply_pack/medical/bloodpacks
	name = "Blood Pack Variety Crate"
	desc = "Contains several different blood packs for reintroducing blood to patients."
	cost = 1000
	contains = list(/obj/item/reagent_containers/blood,
					/obj/item/reagent_containers/blood,
					/obj/item/reagent_containers/blood/APlus,
					/obj/item/reagent_containers/blood/AMinus,
					/obj/item/reagent_containers/blood/BPlus,
					/obj/item/reagent_containers/blood/BMinus,
					/obj/item/reagent_containers/blood/OPlus,
					/obj/item/reagent_containers/blood/OMinus,
					/obj/item/reagent_containers/blood/lizard,
					/obj/item/reagent_containers/blood/elzuose,
					/obj/item/reagent_containers/blood/synthetic)
	crate_name = "blood freezer"
	crate_type = /obj/structure/closet/crate/freezer
	faction = /datum/faction/syndicate/suns
	faction_discount = 25

/datum/supply_pack/medical/salglucanister
	name = "Heavy-Duty Saline Canister"
	desc = "Contains a bulk supply of saline-glucose condensed into a single canister that should last a long time, with a large pump to fill containers with. Direct injection of saline should be left to medical professionals as the pump is capable of overdosing patients."
	cost = 5000
	contains = list(/obj/machinery/iv_drip/saline)
	crate_name = "saline glucose crate"
	crate_type = /obj/structure/closet/crate/large
	no_bundle = TRUE

/datum/supply_pack/medical/epipen_crate
	name = "Bulk Epipen Crate"
	desc = "Contains a spare box of epinephrine medipens, for when the going gets tough."
	cost = 600
	contains = list(/obj/item/storage/box/medipens)
	crate_name = "epinephrine medipen crate"

/datum/supply_pack/medical/medigel_crate
	name = "Empty Medical Gel Crate"
	desc = "Contains a box of seven empty medical gels, for applying your own chemical mixes."
	cost = 700
	contains = list(/obj/item/storage/box/medigels)
	crate_name = "empty medical gel crate"

/* Hypospray supplies */

/datum/supply_pack/medical/mkii_hypo
	name = "mk.II Hypospray kit"
	desc = "Contains an Nanotrasen Hypospray, for on the field medical care. Comes with an assortment of Ready-To-Go Vials"
	cost = 1200
	contains = list(/obj/item/storage/box/hypospray)
	crate_name = "mk.II hypospray crate"
	faction = /datum/faction/nt

/datum/supply_pack/medical/mkiii_hypo
	name = "mk.III Hypospray kit"
	desc = "Contains a mk.III Nanotrasen Hypospray, for on the field medical care. Comes with an assortment of Ready-To-Go Vials"
	cost = 2000
	contains = list(/obj/item/storage/box/hypospray/mkiii)
	crate_name = "mk.III hypospray crate"
	faction = /datum/faction/nt
	faction_locked = TRUE
	faction_discount = 0

/datum/supply_pack/medical/vials
	faction = /datum/faction/nt
	faction_discount = 50

/datum/supply_pack/medical/vials/empty_vial
	name = "Empty Vial Crate"
	desc = "Contains one empty hypospray vial, for usage in a Hypospray."
	cost = 200
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small)
	crate_name = "empty vial crate"

/datum/supply_pack/medical/vials/indo_vial
	name = "Indomide Vial Crate"
	desc = "Contains a spare indomide vial, for usage in a Hypospray."
	cost = 400
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/indomide,
	)
	crate_name = "indomide vial crate"

/datum/supply_pack/medical/vials/alvi_vial
	name = "Alvitane Vial Crate"
	desc = "Contains a spare alvitane vial, for usage in a Hypospray."
	cost = 400
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/alvitane,
	)
	crate_name = "alvitane vial crate"

/datum/supply_pack/medical/vials/dylo_vial
	name = "Pancrazine Vial Crate"
	desc = "Contains a spare dylovene vial, for usage in a Hypospray."
	cost = 400
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/pancrazine,
	)
	crate_name = "pancrazine vial crate"

/datum/supply_pack/medical/vials/dexa_vial
	name = "Dexalin Vial Crate"
	desc = "Contains a spare dexalin vial, for usage in a Hypospray."
	cost = 400
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/dexalin,
	)
	crate_name = "dexalin vial crate"

/datum/supply_pack/medical/vials/tric_vial
	name = "Cureall Vial Crate"
	desc = "Contains a spare cureall vial, for usage in a Hypospray."
	cost = 300
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/cureall,
	)
	crate_name = "cureall vial crate"

/datum/supply_pack/medical/vials/morb_vial
	name = "Morphine Vial Crate"
	desc = "Contains a spare morphine vial, for usage in a Hypospray."
	cost = 500
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/morphine,
	)
	crate_name = "morphine vial crate"

/datum/supply_pack/medical/vials/atro_vial
	name = "Atropine Vial Crate"
	desc = "Contains a spare atropine vial, for usage in a Hypospray."
	cost = 500
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/atropine,
	)
	crate_name = "atropine vial crate"

/datum/supply_pack/medical/vials/stas_vial
	name = "Stasis Vial Crate"
	desc = "Contains a spare stasis vial, for usage in a Hypospray."
	cost = 800
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/stasis,
	)
	crate_name = "stasis vial crate"

/datum/supply_pack/medical/vials/erp_vial
	name = "Radiation Purgant Vial Crate"
	desc = "Contains one spare radiation purgant vial, for usage in a Hypospray."
	cost = 300
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/erp)
	crate_name = "radiation purgant vial crate"

/datum/supply_pack/medical/vials/sal_vial
	name = "SalGlu Vial Crate"
	desc = "Contains one spare SalGlu Solution vial, for usage in a Hypospray."
	cost = 300
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/salclu)
	crate_name = "SalGlu vial crate"

/datum/supply_pack/medical/vials/chit_vial
	name = "Chitosan Vial Crate"
	desc = "Contains one spare Chitosan vial, for usage in a Hypospray."
	cost = 300
	contains = list(
		/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/chitosan)
	crate_name = "chitosan vial crate"
