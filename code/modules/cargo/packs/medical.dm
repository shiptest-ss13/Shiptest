/datum/supply_pack/medical
	group = "Medical"
	crate_type = /obj/structure/closet/crate/medical

/*
		First aid kits
*/

/datum/supply_pack/medical/firstaid_single
	name = "First Aid Kit Single-Pack"
	desc = "Contains one first aid kit for healing most types of wounds."
	cost = 400
	small_item = TRUE
	contains = list(/obj/item/storage/firstaid/regular)

/datum/supply_pack/medical/firstaidbruises_single
	name = "Bruise Treatment Kit Single-Pack"
	desc = "Contains one first aid kit focused on healing bruises and broken bones."
	cost = 700
	small_item = TRUE
	contains = list(/obj/item/storage/firstaid/brute)

/datum/supply_pack/medical/firstaidburns_single
	name = "Burn Treatment Kit Single-Pack"
	desc = "Contains one first aid kit focused on healing severe burns."
	cost = 700
	small_item = TRUE
	contains = list(/obj/item/storage/firstaid/fire)

/datum/supply_pack/medical/firstaidoxygen_single
	name = "Oxygen Deprivation Kit Single-Pack"
	desc = "Contains one first aid kit focused on helping oxygen deprivation victims."
	cost = 500
	small_item = TRUE
	contains = list(/obj/item/storage/firstaid/o2)

/datum/supply_pack/medical/firstaidtoxins_single
	name = "Toxin Treatment Kit Single-Pack"
	desc = "Contains one first aid kit focused on healing damage dealt by heavy toxins."
	cost = 500
	small_item = TRUE
	contains = list(/obj/item/storage/firstaid/toxin)

/datum/supply_pack/medical/firstaid_rad_single
	name = "Radiation Treatment Kit Single-Pack"
	desc = "Contains one first aid kit focused on reducing the damage done by radiation."
	cost = 500
	small_item = TRUE
	contains = list(/obj/item/storage/firstaid/radiation)

/*
		Tools
*/

/datum/supply_pack/medical/painkillers
	name = "Painkiller Supply Crate"
	desc = "Contains a supply of painkillers. Great for stopping headaches, feeling broken bones, and screaming people!"
	cost = 1000
	contains = list(
		/obj/item/reagent_containers/glass/bottle/morphine,
		/obj/item/reagent_containers/glass/bottle/morphine,
		/obj/item/reagent_containers/glass/bottle/morphine,
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

/datum/supply_pack/medical/surplus
	name = "Medical Surplus Crate"
	desc = "Contains an assortment of medical supplies haphazardly pulled from storage. German doctor not included."
	cost = 3000
	contains = list(/obj/item/reagent_containers/glass/bottle/charcoal,
					/obj/item/reagent_containers/glass/bottle/epinephrine,
					/obj/item/reagent_containers/glass/bottle/morphine,
					/obj/item/reagent_containers/glass/bottle/toxin,
					/obj/item/reagent_containers/glass/beaker/large,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/stack/medical/gauze,
					/obj/item/storage/box/beakers,
					/obj/item/storage/box/medigels,
					/obj/item/storage/box/syringes,
					/obj/item/storage/box/bodybags,
					/obj/item/storage/firstaid/regular,
					/obj/item/storage/firstaid/o2,
					/obj/item/storage/firstaid/toxin,
					/obj/item/storage/firstaid/brute,
					/obj/item/storage/firstaid/fire,
					/obj/item/defibrillator/loaded,
					/obj/item/reagent_containers/blood/OMinus,
					/obj/item/storage/pill_bottle/mining,
					/obj/item/reagent_containers/pill/neurine,
					/obj/item/vending_refill/medical)
	crate_name = "medical surplus crate"
	faction = /datum/faction/syndicate/suns
	faction_discount = 25

/datum/supply_pack/medical/surplus/fill(obj/structure/closet/crate/C)
	for(var/i in 1 to 7)
		var/item = pick(contains)
		new item(C)

/datum/supply_pack/medical/salglucanister
	name = "Heavy-Duty Saline Canister"
	desc = "Contains a bulk supply of saline-glucose condensed into a single canister that should last a long time, with a large pump to fill containers with. Direct injection of saline should be left to medical professionals as the pump is capable of overdosing patients."
	cost = 5000
	contains = list(/obj/machinery/iv_drip/saline)
	crate_name = "saline glucose crate"
	crate_type = /obj/structure/closet/crate/large

// CYBERNETICS

/datum/supply_pack/medical/cyberarm_surgset
	name = "Integrated Surgical Toolset Kit"
	desc = "The latest in advanced medical cybernetics, the Surgical Toolset can be installed in the arms and act as a concealed kit to render surgical aid at striking efficiency."
	cost = 3000
	contains = list(/obj/item/organ/cyberimp/arm/surgery)
	crate_name = "implant crate"
	crate_type = /obj/structure/closet/crate/freezer
	faction = /datum/faction/syndicate/cybersun
	faction_discount = 25

/datum/supply_pack/medical/cyberarm_toolset
	name = "Integrated Engineering Toolset Kit"
	desc = "A recent innovation in engineering labor, this functions as a concealed toolkit for use in all manner of engineering operations. It is installed in the arms."
	cost = 2000
	contains = list(/obj/item/organ/cyberimp/arm/toolset)
	crate_name = "implant crate"
	crate_type = /obj/structure/closet/crate/freezer
	faction = /datum/faction/syndicate/cybersun
	faction_discount = 25

/datum/supply_pack/medical/cyberhud_sec
	name = "Integrated Security HUD"
	desc = "A HUD over the user's eyes that allows one to view security and IFF data on the field. Reports of recalls and blindness are merely disinformation by competitors."
	cost = 1500
	contains = list(/obj/item/organ/cyberimp/eyes/hud/security)
	crate_name = "implant crate"
	crate_type = /obj/structure/closet/crate/freezer
	faction = /datum/faction/syndicate/cybersun
	faction_discount = 25

/datum/supply_pack/medical/cyberhud_med
	name = "Integrated Medical Analysis HUD"
	desc = "A HUD over the user's eyes that allows one to view medical and heart-rate data on the field. Reports of recalls and blindness are merely disinformation by competitors."
	cost = 1500
	contains = list(/obj/item/organ/cyberimp/eyes/hud/medical)
	crate_name = "implant crate"
	crate_type = /obj/structure/closet/crate/freezer
	faction = /datum/faction/syndicate/cybersun
	faction_discount = 25

/datum/supply_pack/medical/cyberhud_diagnostic
	name = "Integrated Exosuit Diagnostic HUD"
	desc = "A HUD over the user's eyes that allows one to view an uplink of Powered Exoskeleton information. Reports of recalls and blindness are merely disinformation by competitors."
	cost = 500
	contains = list(/obj/item/organ/cyberimp/eyes/hud/diagnostic)
	crate_name = "implant crate"
	crate_type = /obj/structure/closet/crate/freezer
	faction = /datum/faction/syndicate/cybersun
	faction_discount = 25

/datum/supply_pack/medical/cyber_breathing
	name = "Integrated Breathing Tube"
	desc = "Commonly used for those with medical conditions relating to breathing, this implant provides a port to attach portable oxygen canisters to that pumps air directly into your lungs. Keep port sealed when not in use."
	cost = 750
	contains = list(/obj/item/organ/cyberimp/mouth/breathing_tube)
	crate_name = "implant crate"
	crate_type = /obj/structure/closet/crate/freezer
	faction = /datum/faction/syndicate/cybersun
	faction_discount = 25

/datum/supply_pack/medical/cyberorgans
	name = "Cybernetic Organs Replacement Pack"
	desc = "Precision-manufactured replacement organs for those suffering catastrophic organ failure. Keep crate sealed until use, contaminants may cause rejection."
	cost = 1000
	contains = list(/obj/item/organ/lungs/cybernetic/tier2,
					/obj/item/organ/stomach/cybernetic/tier2,
					/obj/item/organ/liver/cybernetic/tier2,
					/obj/item/organ/heart/cybernetic/tier2)
	crate_name = "organs crate"
	crate_type = /obj/structure/closet/crate/freezer
	faction = /datum/faction/syndicate/cybersun
	faction_discount = 25
