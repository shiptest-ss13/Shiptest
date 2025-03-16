/*
	This file contains disks with science designs designs, including mechs.
*/

// SCIENCE EQUIPMENT

/obj/item/disk/design_disk/science //Science parent type
	name = "design disk - Science"
	desc = "A design disk containing basic science equipment."
	color = "#bf4de2"
	illustration = "sci"
	max_blueprints = 5
	starting_blueprints = list(
		/datum/design/diagnostic_hud,
		/datum/design/welding_mask,
		/datum/design/sci_goggles,
		/datum/design/anomaly_neutralizer,
		/datum/design/telesci_gps
	)

// IPC/ROBOTICS

/obj/item/disk/design_disk/science/ipc_parts
	name = "design disk - IPC components"
	desc = "A design disk containing designs for IPC components."
	illustration = "cybersun"
	max_blueprints = 7
	starting_blueprints = list(
		/datum/design/robotic_liver,
		/datum/design/robotic_eyes,
		/datum/design/robotic_tongue,
		/datum/design/robotic_heart,
		/datum/design/robotic_stomach,
		/datum/design/robotic_ears,
		/datum/design/power_cord
	)

/obj/item/disk/design_disk/clip_mechs
	design_name = "CLIP exosuit modifications"
	desc = "A design disk containing specifications for CLIP-custom exosuit conversions."
	color = "#57b8f0"
	max_blueprints = 2
	starting_blueprints = list(
		/datum/design/clip_ripley_upgrade,
		/datum/design/clip_durand_upgrade
	)
