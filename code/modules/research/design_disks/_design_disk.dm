//Disks for transporting design datums to be used in autolathes.

/*Available illustrations - use with illustration var on disks.
	nt_old				Nanotrasen logo, single N
	nt					Nanotrasen logo, NT
	nt_n				Nanotrasen logo, modern N
	dna_words			text, DNA
	nuke_useless		some squiggles
	nuke_useless_alt	triangle thing?
	syndicate			Syndicate S
	generic				3 horizontal lines
	solgov				small solgov circle logo
	solgov_old			terragov, TG
	rd_major			2px dithered line
	beaker				Chemistry beaker
	sci					text, SCI
	med					text, MED
	sec					text, SEC
	cargo				text, CAR
	engineering			text, ENG
	service				text, SER
	civilian			text, CIV
	liberator			text, LIB
	bepis				text, BEP
	sword				Small sword graphic
	sword_thin			Thin small sword graphic
	sus					amogus
	moth				little moth face
	shiptest			text, ST
	poyo				little face
	accel				PKA small icon
	target				box with a smaller box inside
	ammo				small bullet icon
	cybersun			Cybersun logo
	gun					small gun icon
	holo				Holopad design, animated
	dna					DNA disk design, animated
	o2					text, o2
	hammer				its a hammer
	depleted			This is used for limited disks with no charges left
	nuke_retro			old nukedisk, alternating lines like a sine wave
	nuke_new			sine wave, more detailed
	nanite				black and green lines, animated
	design				default, animated scrolling design
*/

/*
	To add a new disk:
	1. Navigate to the respective file in this folder:
		/design_disks/engineering.dm
		/design_disks/firearms.dm
		/design_disks/medical.dm
		/design_disks/science.dm (more tba)
	2. Create a new subtype of the disk in the file you are choosing.
	3. Set the max_blueprints variable, and the max_charges variable.
	4. Add an Initialize() proc of your subtype directly below your subtype definition.
	5. Add design datums to the blueprints list - see the existing ones for an example.

	WARNING! If your item is NOT showing on the "Imported" category on the autolathe with
	the disk inserted, you need to navigate to the design datum's code, and make sure it has:
		build_type = AUTOLATHE
		category = list("Imported")
	If it does, it will show up in the autolathe Imported category when the disk is interted.
*/
/obj/item/disk/design_disk
	name = "Component Design Disk"
	desc = "A disk for storing device design data for construction in lathes."
	random_color = FALSE
	color = "#8b70ff"
	illustration = "design"
	var/list/blueprints = list()	// List of blueprints downloaded to the disk
	var/max_blueprints = 1			// Max amount of blueprints a disk can have
	var/max_charges = 0				// Max amount of prints a disk is allowed
	var/used_charges = 0			// Number of prints the disk has made
	var/modifiable = FALSE			// If the disk can have designs added/removed
	custom_materials = list(
							/datum/material/iron = 300,
							/datum/material/glass = 100,
							)

/obj/item/disk/design_disk/Initialize()
	. = ..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)
	blueprints = new(max_blueprints)

/obj/item/disk/design_disk/examine(user)
	. = ..()
	var/readout = list("")
	if(!max_charges)
		readout += "[span_notice("It has [span_warning("infinite")] charges.")]"
	else
		readout += "[span_notice("It has [span_warning("[max_charges - used_charges]")] charges out of [span_warning("[max_charges]")] remaining.")]"
	if(modifiable)
		readout += "[span_notice("It's modifiable with a research console.")]"
	else
		readout += "[span_notice("It's [span_warning("not")] modifiable with a research console.")]"
	. += readout

/obj/item/disk/design_disk/proc/check_charges()
	if(!max_charges)
		return
	if(max_charges == used_charges) // Check if it's been used as many time as maximum
		for(var/i in 1 to max_blueprints)
			blueprints[i] = null // Remove all of the designs, and change the icon
			illustration = "depleted"
	update_icon()

/obj/item/disk/design_disk/adv
	name = "Advanced Component Design Disk"
	desc = "A disk for storing device design data for construction in lathes. This one has a little bit of extra storage space."
	color = "#bed876"
	max_blueprints = 3
	modifiable = TRUE
	custom_materials = list(
							/datum/material/iron = 300,
							/datum/material/glass = 100,
							/datum/material/silver = 50,
							)

/obj/item/disk/design_disk/super
	name = "Super Component Design Disk"
	desc = "A disk for storing device design data for construction in lathes. This one has more extra storage space."
	color = "#c25454"
	max_blueprints = 5
	modifiable = TRUE
	custom_materials = list(
							/datum/material/iron = 300,
							/datum/material/glass = 100,
							/datum/material/silver = 50,
							/datum/material/gold = 50,
							)

/obj/item/disk/design_disk/elite
	name = "Elite Component Design Disk"
	color = "#333333"
	desc = "A disk for storing device design data for construction in lathes. This one has absurd amounts of extra storage space."
	max_blueprints = 10
	modifiable = TRUE
	custom_materials = list(
							/datum/material/iron = 300,
							/datum/material/glass = 100,
							/datum/material/silver = 100,
							/datum/material/gold = 100,
							/datum/material/bluespace = 50,
							)

// Limited use design disk basetype

/obj/item/disk/design_disk/limited	//basetype, don't use this
	name = "Limited Design Disk"
	color = "#333333"
	desc = "A disk with limited charges"
	max_charges = 10 //Default for limited disks is 10 charges.
