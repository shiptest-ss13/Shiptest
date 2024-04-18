
/////////////////////////////////////////
///////////////Bluespace/////////////////
/////////////////////////////////////////

/datum/design/beacon
	name = "Tracking Beacon"
	desc = "A bluespace tracking beacon."
	id = "beacon"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 150, /datum/material/glass = 100)
	build_path = /obj/item/beacon
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_SECURITY

/datum/design/bluespace_crystal
	name = "Artificial Bluespace Crystal"
	desc = "A small blue crystal with mystical properties."
	id = "bluespace_crystal"
	build_type = PROTOLATHE
	materials = list(/datum/material/diamond = 1500, /datum/material/plasma = 1500)
	build_path = /obj/item/stack/ore/bluespace_crystal/artificial
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/telesci_gps
	name = "GPS Device"
	desc = "Little thingie that can track its position at all times."
	id = "telesci_gps"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 1000)
	build_path = /obj/item/gps
	category = list("Bluespace Designs")

/datum/design/desynchronizer
	name = "Desynchronizer"
	desc = "A device that can desynchronize the user from spacetime."
	id = "desynchronizer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 500, /datum/material/silver = 1500, /datum/material/bluespace = 1000)
	build_path = /obj/item/desynchronizer
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/miningsatchel_holding
	name = "Mining Satchel of Holding"
	desc = "A mining satchel that can hold an infinite amount of ores."
	id = "minerbag_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 250, /datum/material/uranium = 500) //quite cheap, for more convenience
	build_path = /obj/item/storage/bag/ore/holding
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/swapper
	name = "Quantum Spin Inverter"
	desc = "An experimental device that is able to swap the locations of two entities by switching their particles' spin values. Must be linked to another device to function."
	id = "swapper"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 1000, /datum/material/bluespace = 2000, /datum/material/gold = 1500, /datum/material/silver = 1000)
	build_path = /obj/item/swapper
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/biobag_holding
	name = "Biohazard Container of Holding"
	desc = "A bag designed to safely contain biologically-hazardous objects. This bag has been outfitted with a bluespace storage well, and can carry considerably more then it's actual size."
	id = "biobag_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 1500, /datum/material/diamond = 750, /datum/material/uranium = 250, /datum/material/bluespace = 1000)
	build_path = /obj/item/storage/bag/bio/holding
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_MEDICAL

/datum/design/engibag_holding
	name = "Construction Bag of Holding"
	desc = "A bag for storing construction equipment. With the help of bluespace, you'll be building more airlocks and cameras then ever before."
	id = "engibag_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 1500, /datum/material/diamond = 750, /datum/material/uranium = 250, /datum/material/bluespace = 1000)
	build_path = /obj/item/storage/bag/construction/holding
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/plantbag_holding
	name = "Harvest Carrier of Holding"
	desc = "A bag for storing agricultural goods, augmented with bluespace technology. A glorious melon-carrying chariot, worthy of a true botanist."
	id = "plantbag_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 1500, /datum/material/diamond = 750, /datum/material/uranium = 250, /datum/material/bluespace = 1000)
	build_path = /obj/item/storage/bag/plants/holding
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/chembag_holding
	name = "Chemistry Satchel of Holding"
	desc = "A bag for storing varied chemical goods, optimized with bluespace technology to allow the resident chemist to carry their entire lab around with them."
	id = "chembag_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 1500, /datum/material/diamond = 750, /datum/material/uranium = 250, /datum/material/bluespace = 1000)
	build_path = /obj/item/storage/bag/chemistry/holding
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

