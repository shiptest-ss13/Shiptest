////////////////////////////////////////
//Disks for transporting design datums//
////////////////////////////////////////

/obj/item/disk/design_disk
	name = "Component Design Disk"
	desc = "A disk for storing device design data for construction in lathes."
	random_color = FALSE
	color = "#8b70ff"
	illustration = "design"
	custom_materials = list(/datum/material/iron =300, /datum/material/glass =100)
	var/list/blueprints = list()
	var/max_blueprints = 1

/obj/item/disk/design_disk/Initialize()
	. = ..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)
	for(var/i in 1 to max_blueprints)
		blueprints += null

/obj/item/disk/design_disk/adv
	name = "Advanced Component Design Disk"
	color = "#bed876"
	desc = "A disk for storing device design data for construction in lathes. This one has a little bit of extra storage space."
	custom_materials = list(/datum/material/iron =300, /datum/material/glass = 100, /datum/material/silver = 50)
	max_blueprints = 3

/obj/item/disk/design_disk/super
	name = "Super Component Design Disk"
	color = "#c25454"
	desc = "A disk for storing device design data for construction in lathes. This one has more extra storage space."
	custom_materials = list(/datum/material/iron =300, /datum/material/glass = 100, /datum/material/silver = 50, /datum/material/gold = 50)
	max_blueprints = 5

/obj/item/disk/design_disk/elite
	name = "Elite Component Design Disk"
	color = "#333333"
	desc = "A disk for storing device design data for construction in lathes. This one has absurd amounts of extra storage space."
	custom_materials = list(/datum/material/iron =300, /datum/material/glass = 100, /datum/material/silver = 100, /datum/material/gold = 100, /datum/material/bluespace = 50)
	max_blueprints = 10

//CUSTOM DISKS

/obj/item/disk/design_disk/ammo_38_hunting
	name = "Design Disk - .38 Hunting Ammo"
	desc = "A design disk containing the pattern for a refill ammo box for Winchester rifles and Detective Specials."
	illustration = "ammo"

/obj/item/disk/design_disk/ammo_38_hunting/Initialize()
	. = ..()
	var/datum/design/c38_hunting/M = new
	blueprints[1] = M

/obj/item/disk/design_disk/ammo_c10mm
	name = "Design Disk - 10mm Ammo"
	desc = "A design disk containing the pattern for a refill box of standard 10mm ammo, used in Stechkin pistols."

/obj/item/disk/design_disk/ammo_c10mm/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/c10mm()

/obj/item/disk/design_disk/ammo_n762
	name = "Design Disk - 7.62x38mmR Ammo"
	desc = "A design disk containing the pattern for an ammo holder of 7.62x38mmR ammo, used in Nagant revolvers. It's a wonder anybody still makes these."

/obj/item/disk/design_disk/ammo_n762/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/n762()

/obj/item/disk/design_disk/adv/disposable_gun
	name = "design disk - disposable gun"
	desc = "A design disk containing designs for a cheap and disposable gun."
	illustration = "gun"

/obj/item/disk/design_disk/disposable_gun/Initialize()
	. = ..()
	var/datum/design/disposable_gun/G = new
	var/datum/design/pizza_disposable_gun/P = new
	blueprints[1] = G
	blueprints[2] = P

/obj/item/disk/design_disk/cmm_mechs
	name = "design disk - CMM mecha modifications"
	desc = "A design disk containing specifications for CMM-custom mecha conversions."
	color = "#57b8f0"
	max_blueprints = 3

/obj/item/disk/design_disk/cmm_mechs/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/cmm_ripley_upgrade
	blueprints[2] = new /datum/design/cmm_durand_upgrade

/// Custom medical disks

/obj/item/disk/design_disk/surgery
	name = "design disk - surgical tools"
	desc = "A design disk containing designs for basic surgical tools."
	color = "#57b8f0"
	illustration = "med"
	max_blueprints = 5

/obj/item/disk/design_disk/surgery/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/scalpel()
	blueprints[2] = new /datum/design/retractor()
	blueprints[3] = new /datum/design/hemostat()
	blueprints[4] = new /datum/design/circular_saw()
	blueprints[5] = new /datum/design/cautery()

/obj/item/disk/design_disk/surgery/basic
	name = "design disk - basic surgical tools"
	desc = "A design disk containing just the basic set of surgical tools."
	max_blueprints = 3

/obj/item/disk/design_disk/surgery/basic/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/scalpel()
	blueprints[2] = new /datum/design/hemostat()
	blueprints[3] = new /datum/design/cautery()

/obj/item/disk/design_disk/cyber_organ
	name = "design disk - basic cybernetic organs"
	desc = "A design disk containing basic cybernetic organs. Produced and distributed by Cybersun Industries."
	color = "#57b8f0"
	illustration = "cybersun"
	max_blueprints = 5

/obj/item/disk/design_disk/cyber_organ/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/cybernetic_liver()
	blueprints[2] = new /datum/design/cybernetic_heart()
	blueprints[3] = new /datum/design/cybernetic_lungs()
	blueprints[4] = new /datum/design/cybernetic_stomach()
	blueprints[5] = new /datum/design/cybernetic_ears()

/obj/item/disk/design_disk/cyber_organ/tier2
	name = "design disk - upgraded cybernetic organs"
	desc = "A design disk containing designs forupgraded cybernetic organs. Produced and distributed by Cybersun Industries."

/obj/item/disk/design_disk/cyber_organ/tier2/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/cybernetic_liver/tier2()
	blueprints[2] = new /datum/design/cybernetic_heart/tier2()
	blueprints[3] = new /datum/design/cybernetic_lungs/tier2()
	blueprints[4] = new /datum/design/cybernetic_stomach/tier2()
	blueprints[5] = new /datum/design/cybernetic_ears_u()

/obj/item/disk/design_disk/cyber_organ/tier3
	name = "design disk - advanced cybernetic organs"
	desc = "A design disk containing designs for advanced cybernetic organs. Produced and distributed by Cybersun Industries."

/obj/item/disk/design_disk/cyber_organ/tier3/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/cybernetic_liver/tier3()
	blueprints[2] = new /datum/design/cybernetic_heart/tier3()
	blueprints[3] = new /datum/design/cybernetic_lungs/tier3()
	blueprints[4] = new /datum/design/cybernetic_stomach/tier3()
	blueprints[5] = new /datum/design/cybernetic_ears_u()

/obj/item/disk/design_disk/chemistry
	name = "design disk - chemistry equipment"
	desc = "A design disk containing designs for chemistry equipment. Stock parts not included."
	color = "#db8a2d"
	illustration = "beaker"
	max_blueprints = 7

/obj/item/disk/design_disk/chemistry/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/medigel()
	blueprints[2] = new /datum/design/reagentanalyzer()
	blueprints[3] = new /datum/design/pillbottle()
	blueprints[4] = new /datum/design/xlarge_beaker()
	blueprints[5] = new /datum/design/seperatory_funnel()
	blueprints[6] = new /datum/design/medical_spray_bottle()
	blueprints[7] = new /datum/design/chem_pack()

///Custom science disks

/obj/item/disk/design_disk/ipc_parts
	name = "design disk - IPC components"
	desc = "A design disk containing designs for IPC components."
	color = "#bf4de2"
	illustration = "cybersun"
	max_blueprints = 7

/obj/item/disk/design_disk/ipc_parts/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/robotic_liver()
	blueprints[2] = new /datum/design/robotic_eyes()
	blueprints[3] = new /datum/design/robotic_tongue()
	blueprints[4] = new /datum/design/robotic_heart()
	blueprints[5] = new /datum/design/robotic_stomach()
	blueprints[6] = new /datum/design/robotic_ears()
	blueprints[7] = new /datum/design/power_cord()
