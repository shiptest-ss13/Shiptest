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

//Disks with content
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
