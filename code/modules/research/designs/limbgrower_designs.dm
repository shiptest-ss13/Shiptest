/////////////////////////////////////
//////////Limb Grower Designs ///////
/////////////////////////////////////

/datum/design/leftarm
	name = "Left Arm"
	id = "l_arm"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 25)
	build_path = /obj/item/bodypart/l_arm
	category = list("initial",SPECIES_HUMAN,SPECIES_LIZARD,SPECIES_MOTH,SPECIES_PLASMAMAN,SPECIES_ETHEREAL,SPECIES_RACHNID,SPECIES_VOX,SPECIES_KEPORI)

/datum/design/rightarm
	name = "Right Arm"
	id = "r_arm"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 25)
	build_path = /obj/item/bodypart/r_arm
	category = list("initial",SPECIES_HUMAN,SPECIES_LIZARD,SPECIES_MOTH,SPECIES_PLASMAMAN,SPECIES_ETHEREAL,SPECIES_RACHNID,SPECIES_VOX,SPECIES_KEPORI)

/datum/design/leftleg
	name = "Left Leg"
	id = "l_leg"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 25)
	build_path = /obj/item/bodypart/l_leg
	category = list("initial",SPECIES_HUMAN,SPECIES_LIZARD,SPECIES_MOTH,SPECIES_PLASMAMAN,SPECIES_ETHEREAL,SPECIES_RACHNID,SPECIES_VOX,SPECIES_KEPORI)

/datum/design/rightleg
	name = "Right Leg"
	id = "r_leg"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 25)
	build_path = /obj/item/bodypart/r_leg
	category = list("initial",SPECIES_HUMAN,SPECIES_LIZARD,SPECIES_MOTH,SPECIES_PLASMAMAN,SPECIES_ETHEREAL,SPECIES_RACHNID,SPECIES_VOX,SPECIES_KEPORI)

/datum/design/digitigrade/leftleg
	name = "Digitigrade Left Leg"
	id = "digi_l_leg"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 25)
	build_path = /obj/item/bodypart/l_leg/digitigrade
	category = list("initial",SPECIES_LIZARD)

/datum/design/digitigrade/rightleg
	name = "Digitigrade Right Leg"
	id = "digi_r_leg"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 25)
	build_path = /obj/item/bodypart/r_leg/digitigrade
	category = list("initial",SPECIES_LIZARD)

//Non-limb limb designs

/datum/design/heart
	name = "Heart"
	id = "heart"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 30)
	build_path = /obj/item/organ/heart
	category = list(SPECIES_HUMAN,"initial")

/datum/design/lungs
	name = "Lungs"
	id = "lungs"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20)
	build_path = /obj/item/organ/lungs
	category = list(SPECIES_HUMAN,"initial")

/datum/design/liver
	name = "Liver"
	id = "liver"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20)
	build_path = /obj/item/organ/liver
	category = list(SPECIES_HUMAN,"initial")

/datum/design/stomach
	name = "Stomach"
	id = "stomach"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 15)
	build_path = /obj/item/organ/stomach
	category = list(SPECIES_HUMAN,"initial")

/datum/design/appendix
	name = "Appendix"
	id = "appendix"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 5) //why would you need this
	build_path = /obj/item/organ/appendix
	category = list(SPECIES_HUMAN,"initial")

/datum/design/eyes
	name = "Eyes"
	id = "eyes"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/eyes
	category = list(SPECIES_HUMAN,"initial")

/datum/design/ears
	name = "Ears"
	id = "ears"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/ears
	category = list(SPECIES_HUMAN,"initial")

/datum/design/tongue
	name = "Tongue"
	id = "tongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/tongue
	category = list(SPECIES_HUMAN,"initial")

// Grows a fake lizard tail - not usable in lizard wine and other similar recipes.
/datum/design/lizard_tail
	name = "Lizard Tail"
	id = "liztail"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20)
	build_path = /obj/item/organ/tail/lizard/fake
	category = list(SPECIES_LIZARD)

/datum/design/lizard_tongue
	name = "Forked Tongue"
	id = "liztongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/tongue/lizard
	category = list(SPECIES_LIZARD)

//  someday this will get uncommented
// /datum/design/monkey_tail
// 	name = "Monkey Tail"
// 	id = "monkeytail"
// 	build_type = LIMBGROWER
// 	reagents_list = list(/datum/reagent/medicine/synthflesh = 20)
// 	build_path = /obj/item/organ/tail/monkey
// 	category = list("other","initial")

/datum/design/cat_tail
	name = "Cat Tail"
	id = "cattail"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20)
	build_path = /obj/item/organ/tail/cat
	category = list(SPECIES_FELINID)

/datum/design/cat_ears
	name = "Cat Ears"
	id = "catears"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/ears/cat
	category = list(SPECIES_FELINID)

/datum/design/dwarf_gland
	name = "Dwarf Gland"
	id = "dwarfgland"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20, /datum/reagent/consumable/ethanol = 20)
	build_path = /obj/item/organ/dwarfgland
	category = (SPECIES_DWARF)

/datum/design/dwarf_liver
	name = "Dwarf Liver"
	id = "dwarfliver"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20, /datum/reagent/consumable/ethanol = 20)
	build_path = /obj/item/organ/liver/dwarf
	category = (SPECIES_DWARF)

/datum/design/dwarf_tongue
	name = "Dwarf Tongue"
	id = "dwarftongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10, /datum/reagent/consumable/ethanol = 10)
	build_path = /obj/item/organ/tongue/dwarf
	category = (SPECIES_DWARF)

/datum/design/lizard_tongue
	name = "Lizard Tongue"
	id = "lizardtongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/tongue/lizard
	category = (SPECIES_LIZARD)

/datum/design/plasmaman_lungs
	name = "Plasma Filter"
	id = "plasmamanlungs"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20, /datum/reagent/toxin/plasma = 20)
	build_path = /obj/item/organ/lungs/plasmaman
	category = list(SPECIES_PLASMAMAN)

/datum/design/plasmaman_tongue
	name = "Plasma Bone Tongue"
	id = "plasmamantongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10, /datum/reagent/toxin/plasma = 10)
	build_path = /obj/item/organ/tongue/bone/plasmaman
	category = list(SPECIES_PLASMAMAN)

/datum/design/plasmaman_liver
	name = "Reagent Processing Crystal"
	id = "plasmamanliver"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20, /datum/reagent/toxin/plasma = 20)
	build_path = /obj/item/organ/liver/plasmaman
	category = list(SPECIES_PLASMAMAN)

/datum/design/plasmaman_stomach
	name = "Digestive Crystal"
	id = "plasmamanstomach"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20, /datum/reagent/toxin/plasma = 20)
	build_path = /obj/item/organ/stomach/plasmaman
	category = list(SPECIES_PLASMAMAN)

/datum/design/ethereal_stomach
	name = "Biological Battery"
	id = "etherealstomach"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20, /datum/reagent/consumable/liquidelectricity = 20)
	build_path = /obj/item/organ/stomach/ethereal
	category = list(SPECIES_ETHEREAL)

/datum/design/ethereal_tongue
	name = "Ethereal Tongue"
	id = "etherealtongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10, /datum/reagent/consumable/liquidelectricity = 10)
	build_path = /obj/item/organ/tongue/ethereal
	category = list(SPECIES_ETHEREAL)

/datum/design/moth_eyes
	name = "Moth Eyes"
	id = "motheyes"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/eyes/compound
	category = list(SPECIES_MOTH)

/datum/design/moth_tongue
	name = "Moth Tongue"
	id = "mothtongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/tongue/moth
	category = list(SPECIES_MOTH)

/datum/design/spider_tongue
	name = "Spider Tongue"
	id = "spidertongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/tongue/spider
	category = list(SPECIES_RACHNID)

/datum/design/spider_eyes
	name = "Spider Eyes"
	id = "spidereyes"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 20)
	build_path = /obj/item/organ/eyes/night_vision/spider
	category = list(SPECIES_RACHNID)

/datum/design/kepori_tongue
	name = "Kepori Tongue"
	id = "keporitongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/tongue/kepori
	category = list(SPECIES_KEPORI)

/datum/design/vox_tongue
	name = "Vox Tongue"
	id = "voxtongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 10)
	build_path = /obj/item/organ/tongue/vox
	category = list(SPECIES_VOX)

/datum/design/armblade
	name = "Arm Blade"
	id = "armblade"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/synthflesh = 75)
	build_path = /obj/item/melee/synthetic_arm_blade
	category = list("other","emagged")

/// Design disks and designs - for adding limbs and organs to the limbgrower.
/obj/item/disk/design_disk/limbs
	name = "Limb Design Disk"
	desc = "A disk containing limb and organ designs for a limbgrower."
	/// List of all limb designs this disk contains.
	var/list/limb_designs = list()

/obj/item/disk/design_disk/limbs/Initialize()
	. = ..()
	max_blueprints = limb_designs.len
	for(var/design in limb_designs)
		var/datum/design/new_design = design
		blueprints += new new_design

/datum/design/limb_disk
	name = "Limb Design Disk"
	desc = "Contains designs for various limbs."
	id = "limbdesign_parent"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 300, /datum/material/glass = 100)
	build_path = /obj/item/disk/design_disk/limbs
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/obj/item/disk/design_disk/limbs/felinid
	name = "Felinid Limb Design Disk"
	limb_designs = list(/datum/design/cat_tail, /datum/design/cat_ears)

/datum/design/limb_disk/felinid
	name = "Felinid Limb Design Disk"
	desc = "Contains designs for felinid bodyparts for the limbgrower - Felinid ears and tail."
	id = "limbdesign_felinid"
	build_path = /obj/item/disk/design_disk/limbs/felinid

/obj/item/disk/design_disk/limbs/dwarf
	name = "Dwarf Limb Design Disk"
	limb_designs = list(/datum/design/dwarf_gland, /datum/design/dwarf_liver, /datum/design/dwarf_tongue)

/datum/design/limb_disk/dwarf
	name = "Dwarf Limb Design Disk"
	desc = "Contains designs for dwarf bodyparts for the limbgrower - Dwarf liver, gland, and tongue."
	id = "limbdesign_dwarf"
	build_path = /obj/item/disk/design_disk/limbs/dwarf

/obj/item/disk/design_disk/limbs/lizard
	name = "Sarathi Limb Design Disk"
	limb_designs = list(/datum/design/lizard_tail, /datum/design/lizard_tongue)

/datum/design/limb_disk/lizard
	name = "Sarathi Limb Design Disk"
	desc = "Contains designs for sarathi bodyparts for the limbgrower - Sarathi tongue, and tail"
	id = "limbdesign_lizard"
	build_path = /obj/item/disk/design_disk/limbs/lizard

/obj/item/disk/design_disk/limbs/plasmaman
	name = "Plasmaman Limb Design Disk"
	limb_designs = list(/datum/design/plasmaman_stomach, /datum/design/plasmaman_liver, /datum/design/plasmaman_lungs, /datum/design/plasmaman_tongue)

/datum/design/limb_disk/plasmaman
	name = "Plasmaman Limb Design Disk"
	desc = "Contains designs for plasmaman organs for the limbgrower - Plasmaman tongue, liver, stomach, and lungs."
	id = "limbdesign_plasmaman"
	build_path = /obj/item/disk/design_disk/limbs/plasmaman

/obj/item/disk/design_disk/limbs/ethereal
	name = "Elzuose Limb Design Disk"
	limb_designs = list(/datum/design/ethereal_stomach)

/datum/design/limb_disk/ethereal
	name = "Elzuose Limb Design Disk"
	desc = "Contains designs for elzuose organs for the limbgrower - Elzuose tongue and stomach."
	id = "limbdesign_ethereal"
	build_path = /obj/item/disk/design_disk/limbs/ethereal

/obj/item/disk/design_disk/limbs/moth
	name = "Moth Limb Design Disk"
	limb_designs = list(/datum/design/moth_eyes, /datum/design/moth_tongue)

/datum/design/limb_disk/moth
	name = "Moth Limb Design Disk"
	desc = "Contains designs for moth organs for the limbgrower - Moth tongue and eyes."
	id = "limbdesign_moth"
	build_path = /obj/item/disk/design_disk/limbs/moth

/obj/item/disk/design_disk/limbs/spider
	name = "Rachnid Limb Design Disk"
	limb_designs = list(/datum/design/spider_eyes, /datum/design/spider_tongue)

/datum/design/limb_disk/spider
	name = "Rachnid Limb Design Disk"
	desc = "Contains designs for rachnid organs for the limbgrower - Rachnid tongue and eyes."
	id = "limbdesign_spider"
	build_path = /obj/item/disk/design_disk/limbs/spider

/obj/item/disk/design_disk/limbs/kepori
	name = "Kepori Limb Design Disk"
	limb_designs = list(/datum/design/kepori_tongue)

/datum/design/limb_disk/kepori
	name = "Kepori Limb Design Disk"
	desc = "Contains designs for kepori organs for the limbgrower - Kepori tongue."
	id = "limbdesign_kepori"
	build_path = /obj/item/disk/design_disk/limbs/kepori

/obj/item/disk/design_disk/limbs/vox
	name = "Vox Limb Design Disk"
	limb_designs = list(/datum/design/vox_tongue)

/datum/design/limb_disk/vox
	name = "Vox Limb Design Disk"
	desc = "Contains designs for vox organs for the limbgrower - Vox tongue."
	id = "limbdesign_vox"
	build_path = /obj/item/disk/design_disk/limbs/vox
