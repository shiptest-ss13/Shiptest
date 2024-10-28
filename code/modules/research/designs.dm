/***************************************************************
**						Design Datums						  **
**	All the data for building stuff.						  **
***************************************************************/
/*
For the materials datum, it assumes you need reagents unless specified otherwise. To designate a material that isn't a reagent,
you use one of the material IDs below. These are NOT ids in the usual sense (they aren't defined in the object or part of a datum),
they are simply references used as part of a "has materials?" type proc. They all start with a $ to denote that they aren't reagents.
The currently supporting non-reagent materials. All material amounts are set as the define MINERAL_MATERIAL_AMOUNT, which defaults to 2000

Don't add new keyword/IDs if they are made from an existing one (such as rods which are made from metal). Only add raw materials.

Design Guidelines
- When adding new designs, check rdreadme.dm to see what kind of things have already been made and where new stuff is needed.
- A single sheet of anything is 2000 units of material. Materials besides metal/glass require help from other jobs (mining for
other types of metals and chemistry for reagents).
- Add the AUTOLATHE tag to
*/

//DESIGNS ARE GLOBAL. DO NOT CREATE OR DESTROY THEM AT RUNTIME OUTSIDE OF INIT, JUST REFERENCE THEM TO WHATEVER YOU'RE DOING! //why are you yelling?
//DO NOT REFERENCE OUTSIDE OF SSRESEARCH. USE THE PROCS IN SSRESEARCH TO OBTAIN A REFERENCE.

/datum/design //Datum for object designs, used in construction
	/// Name of the created object
	var/name = "Name"
	/// Description of the created object
	var/desc = null
	/// The ID of the design. Used for quick reference. Alphanumeric, lower-case, no symbols
	var/id = DESIGN_ID_IGNORE
	/// Bitflags indicating what machines this design is compatable with. ([IMPRINTER]|[AWAY_IMPRINTER]|[PROTOLATHE]|[AWAY_LATHE]|[AUTOLATHE]|[MECHFAB]|[BIOGENERATOR]|[LIMBGROWER]|[SMELTER])
	var/build_type = null
	/// List of materials required to create one unit of the product. Format is (typepath or caregory) -> amount
	var/list/materials = list()
	/// The amount of time required to create one unit of the product
	var/construction_time
	/// The typepath of the object produced by this design
	var/build_path = null
	/// List of reagents produced by this design. Currently only supported by the biogenerator
	var/list/make_reagents = list()
	/// What category this design falls under. Used for sorting in production machines, mostly the mechfab
	var/list/category = null
	/// List of reagents required to create one unit of the product
	var/list/reagents_list = list()
	/// The maximum number of units of whatever is produced by this can be produced in one go
	var/maxstack = 1
	/// How many times faster than normal is this to build on the protolathe
	var/lathe_time_factor = 1
	/// Notify and log for admin investigations if this is printed
	var/dangerous_construction = FALSE
	/// Bitflags for deplathes.
	var/departmental_flags = ALL
	var/list/datum/techweb_node/unlocked_by = list()
	/// Replaces the item icon in the research console
	var/research_icon
	var/research_icon_state
	var/icon_cache

/datum/design/error_design
	name = "ERROR"
	desc = "This usually means something in the database has corrupted. If this doesn't go away automatically, inform Central Comamnd so their techs can fix this ASAP(tm)"

/datum/design/Destroy()
	SSresearch.techweb_designs -= id
	return ..()

/datum/design/proc/InitializeMaterials()
	var/list/temp_list = list()
	for(var/i in materials) //Go through all of our materials, get the subsystem instance, and then replace the list.
		var/amount = materials[i]
		if(!istext(i)) //Not a category, so get the ref the normal way
			var/datum/material/M =  SSmaterials.GetMaterialRef(i)
			temp_list[M] = amount
		else
			temp_list[i] = amount
	materials = temp_list

/datum/design/proc/icon_html(client/user)
	var/datum/asset/spritesheet/sheet = get_asset_datum(/datum/asset/spritesheet/research_designs)
	sheet.send(user)
	return sheet.icon_tag(id)

/// Returns the description of the design
/datum/design/proc/get_description()
	var/obj/object_build_item_path = build_path

	return isnull(desc) ? initial(object_build_item_path.desc) : desc


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
	var/disk_name = "Design Disk"
	var/design_name
	var/list/blueprints = list()
	var/starting_blueprints = list()
	var/max_blueprints = 1

/obj/item/disk/design_disk/Initialize()
	. = ..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)
	if(design_name)
		name = jointext(list(disk_name, design_name), " - ")
	if(length(starting_blueprints))
		for(var/design in starting_blueprints)
			blueprints += new design()

/obj/item/disk/design_disk/adv
	name = "Advanced Component Design Disk"
	disk_name = "Advanced Design Disk"
	color = "#bed876"
	desc = "A disk for storing device design data for construction in lathes. This one has a little bit of extra storage space."
	custom_materials = list(/datum/material/iron =300, /datum/material/glass = 100, /datum/material/silver = 50)
	max_blueprints = 3

/obj/item/disk/design_disk/super
	name = "Super Component Design Disk"
	disk_name = "Super Design Disk"
	color = "#c25454"
	desc = "A disk for storing device design data for construction in lathes. This one has more extra storage space."
	custom_materials = list(/datum/material/iron =300, /datum/material/glass = 100, /datum/material/silver = 50, /datum/material/gold = 50)
	max_blueprints = 5

/obj/item/disk/design_disk/elite
	name = "Elite Component Design Disk"
	disk_name = "Elite Design Disk"
	color = "#333333"
	desc = "A disk for storing device design data for construction in lathes. This one has absurd amounts of extra storage space."
	custom_materials = list(/datum/material/iron =300, /datum/material/glass = 100, /datum/material/silver = 100, /datum/material/gold = 100, /datum/material/bluespace = 50)
	max_blueprints = 10

//Disks with content
/obj/item/disk/design_disk/ammo_c10mm
	design_name = "10mm Ammo"
	desc = "A design disk containing the pattern for a refill box of standard 10mm ammo, used in Stechkin pistols."
	starting_blueprints = (/datum/design/c10mm)

/obj/item/disk/design_disk/disposable_gun
	design_name = "Disposable gun"
	desc = "A design disk containing designs for a cheap and disposable gun."
	illustration = "gun"
	max_blueprints = 2
	starting_blueprints = list(/datum/design/disposable_gun)

/obj/item/disk/design_disk/clip_mechs
	design_name = "CLIP exosuit modifications"
	desc = "A design disk containing specifications for CLIP-custom exosuit conversions."
	color = "#57b8f0"
	max_blueprints = 2
	starting_blueprints = list(/datum/design/clip_ripley_upgrade, /datum/design/clip_durand_upgrade)

/obj/item/disk/design_disk/ammo_c9mm
	design_name = "9mm Ammo"
	desc = "A design disk containing the pattern for a refill box of standard 9mm ammo, used in Commander pistols."
	starting_blueprints = list(/datum/design/c9mmautolathe)

/obj/item/disk/design_disk/blanks
	design_name = "Blank Ammo"
	starting_blueprints = list(/datum/design/blank_shell)


/obj/item/disk/design_disk/ammo_1911
	design_name = "1911 Magazine"
	desc = "A design disk containing the pattern for the classic 1911's seven round .45ACP magazine."
	illustration = "ammo"
	starting_blueprints = list(/datum/design/colt_1911_magazine)

//KA modkit design discs
/obj/item/disk/design_disk/modkit_disc
	design_name = "KA Mod"
	desc = "A design disc containing the design for a unique kinetic accelerator modkit. It's compatible with a research console."
	illustration = "accel"
	color = "#6F6F6F"
	starting_blueprints = list(/datum/design/unique_modkit)

/obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe
	design_name = "Offensive Mining Explosion Mod"
	starting_blueprints = list(/datum/design/unique_modkit/offensive_turf_aoe)

/obj/item/disk/design_disk/modkit_disc/rapid_repeater
	design_name = "Rapid Repeater Mod"
	starting_blueprints = list(/datum/design/unique_modkit/rapid_repeater)

/obj/item/disk/design_disk/modkit_disc/resonator_blast
	design_name = "Resonator Blast Mod"
	starting_blueprints = list(/datum/design/unique_modkit/resonator_blast)

/obj/item/disk/design_disk/modkit_disc/bounty
	design_name = "Death Syphon Mod"
	starting_blueprints = list(/datum/design/unique_modkit/bounty)
