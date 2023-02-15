GLOBAL_LIST_EMPTY(loadout_categories)
GLOBAL_LIST_EMPTY(gear_datums)

/datum/loadout_category
	var/category = ""
	var/list/gear = list()

/datum/loadout_category/New(cat)
	category = cat
	..()

///Create a list of gear datums to sort
/proc/populate_gear_list()
	for(var/geartype in subtypesof(/datum/gear))
		var/datum/gear/G = geartype

		var/display_name = initial(G.display_name)
		var/list/categories = splittext(initial(G.sort_categories), ", ")
		categories += "All"

		if(G == initial(G.subtype_path))
			continue

		if(!display_name)
			WARNING("Loadout - Missing display name: [G]")
			continue
		if(!initial(G.path))
			WARNING("Loadout - Missing path definition: [G]")
			continue

		for(var/loadout_category in categories)
			if(!GLOB.loadout_categories[loadout_category])
				GLOB.loadout_categories[loadout_category] = new /datum/loadout_category(loadout_category)
			var/datum/loadout_category/LC = GLOB.loadout_categories[loadout_category]
			GLOB.gear_datums[display_name] = new geartype
			LC.gear[display_name] = GLOB.gear_datums[display_name]

	GLOB.loadout_categories = sortAssoc(GLOB.loadout_categories)
	return 1

/datum/gear
	///Name/index. Must be unique.
	var/display_name
	///Description of this gear. If left blank will default to the description of the pathed item.
	var/description
	///Path to item.
	var/path
	///Slot to equip to.
	var/slot
	///Roles that can spawn with this item.
	var/list/allowed_roles
	///A list of jobs with typepaths to the loadout item the job should recieve
	var/list/role_replacements
	///The tabs under gear that the loadout item is listed under, eg. "Glasses, Prescription Glasses"
	var/sort_categories = "Misc"
	///for skipping organizational subtypes (optional)
	var/subtype_path = /datum/gear
	///Balance cost of loadout item
	var/cost = 5
	///Maximum amount of an item that can be taken
	var/limit = 1

/datum/gear/New()
	..()
	if(!description)
		var/obj/O = path
		description = initial(O.desc)

/datum/gear_data
	var/path
	var/location

/datum/gear_data/New(npath, nlocation)
	path = npath
	location = nlocation

/datum/gear/proc/spawn_item(location, mob/owner, datum/outfit/job/outfit_datum)
	var/datum/gear_data/gd
	if(outfit_datum)
		if(outfit_datum.loadout_replace && (outfit_datum.loadout_replace_specifics[src] != "forbid" || (!owner?.client?.prefs.equipped_gear_preferences[src.type]["no_replace"] && (outfit_datum.jobtype in role_replacements)))) //If the owner is a human (should be one) and the item in question has a role replacement
			var/temp_gd
			if((src in outfit_datum.loadout_replace_specifics) || (outfit_datum.jobtype in role_replacements))
				temp_gd = outfit_datum.loadout_replace_specifics[src] ? outfit_datum.loadout_replace_specifics[src] : role_replacements[outfit_datum.jobtype]
			gd = new(temp_gd != null ? temp_gd : path, location)
			return new gd.path(gd.location)

	gd = new(path, location) //Else, just give them the item and be done with it

	return new gd.path(gd.location)
