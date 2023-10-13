/*
	This file contains disks with science designs designs, including mechs.
*/

// SCIENCE EQUIPMENT

/obj/item/disk/design_disk/science/ //Science parent type
	name = "design disk - Science"
	desc = "A design disk containing basic science equipment."
	color = "#bf4de2"
	illustration = "sci"
	max_blueprints = 5

/obj/item/disk/design_disk/science/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/diagnostic_hud
	blueprints[2] = new /datum/design/welding_mask
	blueprints[3] = new /datum/design/sci_goggles
	blueprints[4] = new /datum/design/anomaly_neutralizer
	blueprints[5] = new /datum/design/telesci_gps

// IPC/ROBOTICS

/obj/item/disk/design_disk/science/ipc_parts
	name = "design disk - IPC components"
	desc = "A design disk containing designs for IPC components."
	illustration = "cybersun"
	max_blueprints = 7

/obj/item/disk/design_disk/science/ipc_parts/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/robotic_liver
	blueprints[2] = new /datum/design/robotic_eyes
	blueprints[3] = new /datum/design/robotic_tongue
	blueprints[4] = new /datum/design/robotic_heart
	blueprints[5] = new /datum/design/robotic_stomach
	blueprints[6] = new /datum/design/robotic_ears
	blueprints[7] = new /datum/design/power_cord

/obj/item/disk/design_disk/cmm_mechs
	name = "design disk - CMM mecha modifications"
	desc = "A design disk containing specifications for CMM-custom mecha conversions."
	color = "#57b8f0"
	illustration = "sword"
	max_blueprints = 2

/obj/item/disk/design_disk/cmm_mechs/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/cmm_ripley_upgrade
	blueprints[2] = new /datum/design/cmm_durand_upgrade
