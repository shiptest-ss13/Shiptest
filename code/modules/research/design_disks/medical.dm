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

/obj/item/disk/design_disk/medical/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/defibrillator
	blueprints[2] = new /datum/design/defibrillator_mount
	blueprints[3] = new /datum/design/healthanalyzer
	blueprints[4] = new /datum/design/crewpinpointer
	blueprints[5] = new /datum/design/health_hud

/obj/item/disk/design_disk/medical/surgery
	name = "design disk - surgical tools"
	desc = "A design disk containing designs for surgical tools."

/obj/item/disk/design_disk/medical/surgery/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/scalpel
	blueprints[2] = new /datum/design/retractor
	blueprints[3] = new /datum/design/hemostat
	blueprints[4] = new /datum/design/circular_saw
	blueprints[5] = new /datum/design/cautery

// CHEMISTRY

/obj/item/disk/design_disk/medical/chemistry
	name = "design disk - chemistry equipment"
	desc = "A design disk containing designs for chemistry equipment. Stock parts not included."
	color = "#db8a2d"
	illustration = "beaker"
	max_blueprints = 7

/obj/item/disk/design_disk/medical/chemistry/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/medigel
	blueprints[2] = new /datum/design/reagentanalyzer
	blueprints[3] = new /datum/design/pillbottle
	blueprints[4] = new /datum/design/xlarge_beaker
	blueprints[5] = new /datum/design/seperatory_funnel
	blueprints[6] = new /datum/design/medical_spray_bottle
	blueprints[7] = new /datum/design/chem_pack

// CYBERNETIC ORGANS

/obj/item/disk/design_disk/medical/cyber_organ
	name = "design disk - basic cybernetic organs"
	desc = "A design disk containing basic cybernetic organs. Produced and distributed by Cybersun Industries."
	illustration = "cybersun"

/obj/item/disk/design_disk/medical/cyber_organ/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/cybernetic_liver
	blueprints[2] = new /datum/design/cybernetic_heart
	blueprints[3] = new /datum/design/cybernetic_lungs
	blueprints[4] = new /datum/design/cybernetic_stomach
	blueprints[5] = new /datum/design/cybernetic_ears

/obj/item/disk/design_disk/medical/cyber_organ/tier2
	name = "design disk - upgraded cybernetic organs"
	desc = "A design disk containing designs forupgraded cybernetic organs. Produced and distributed by Cybersun Industries."

/obj/item/disk/design_disk/medical/cyber_organ/tier2/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/cybernetic_liver/tier2
	blueprints[2] = new /datum/design/cybernetic_heart/tier2
	blueprints[3] = new /datum/design/cybernetic_lungs/tier2
	blueprints[4] = new /datum/design/cybernetic_stomach/tier2
	blueprints[5] = new /datum/design/cybernetic_ears_u

/obj/item/disk/design_disk/medical/cyber_organ/tier3
	name = "design disk - advanced cybernetic organs"
	desc = "A design disk containing designs for advanced cybernetic organs. Produced and distributed by Cybersun Industries."

/obj/item/disk/design_disk/medical/cyber_organ/tier3/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/cybernetic_liver/tier3
	blueprints[2] = new /datum/design/cybernetic_heart/tier3
	blueprints[3] = new /datum/design/cybernetic_lungs/tier3
	blueprints[4] = new /datum/design/cybernetic_stomach/tier3
	blueprints[5] = new /datum/design/cybernetic_ears_u

// LIMITED USE DISKS PAST HERE
