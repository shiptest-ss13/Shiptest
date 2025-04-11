/*
	This file contains disks with medical designs.
*/

// MEDICAL AND SURGICAL

/obj/item/disk/design_disk/medical //Medical parent type
	name = "design disk - Medical"
	desc = "A design disk containing medical equipment."
	color = "#57b8f0"
	illustration = "med"
	max_blueprints = 5
	starting_blueprints = list(
		/datum/design/defibrillator,
		/datum/design/defibrillator_mount,
		/datum/design/healthanalyzer,
		/datum/design/crewpinpointer,
		/datum/design/health_hud
	)

/obj/item/disk/design_disk/medical/surgery
	name = "design disk - surgical tools"
	desc = "A design disk containing designs for surgical tools."
	starting_blueprints = list(
		/datum/design/scalpel,
		/datum/design/retractor,
		/datum/design/hemostat,
		/datum/design/circular_saw,
		/datum/design/cautery
	)

// CHEMISTRY
/obj/item/disk/design_disk/medical/chemistry
	name = "design disk - chemistry equipment"
	desc = "A design disk containing designs for chemistry equipment. Stock parts not included."
	color = "#db8a2d"
	illustration = "beaker"
	max_blueprints = 7
	starting_blueprints = list(
		/datum/design/medigel,
		/datum/design/reagentanalyzer,
		/datum/design/pillbottle,
		/datum/design/xlarge_beaker,
		/datum/design/seperatory_funnel,
		/datum/design/medical_spray_bottle,
		/datum/design/chem_pack
	)

// CYBERNETIC ORGANS

/obj/item/disk/design_disk/medical/cyber_organ
	name = "design disk - basic cybernetic organs"
	desc = "A design disk containing basic cybernetic organs. Produced and distributed by Cybersun Industries."
	illustration = "cybersun"
	starting_blueprints = list(
		/datum/design/cybernetic_liver,
		/datum/design/cybernetic_heart,
		/datum/design/cybernetic_lungs,
		/datum/design/cybernetic_stomach,
		/datum/design/cybernetic_ears
	)

/obj/item/disk/design_disk/medical/cyber_organ/tier2
	name = "design disk - upgraded cybernetic organs"
	desc = "A design disk containing designs forupgraded cybernetic organs. Produced and distributed by Cybersun Industries."
	starting_blueprints = list(
		/datum/design/cybernetic_liver/tier2,
		/datum/design/cybernetic_heart/tier2,
		/datum/design/cybernetic_lungs/tier2,
		/datum/design/cybernetic_stomach/tier2,
		/datum/design/cybernetic_ears_u
	)

/obj/item/disk/design_disk/medical/cyber_organ/tier3
	name = "design disk - advanced cybernetic organs"
	desc = "A design disk containing designs for advanced cybernetic organs. Produced and distributed by Cybersun Industries."
	starting_blueprints = list(
		/datum/design/cybernetic_liver/tier3,
		/datum/design/cybernetic_heart/tier3,
		/datum/design/cybernetic_lungs/tier3,
		/datum/design/cybernetic_stomach/tier3,
		/datum/design/cybernetic_ears_u
	)

// LIMITED USE DISKS PAST HERE
