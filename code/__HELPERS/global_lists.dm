//////////////////////////
/////Initial Building/////
//////////////////////////

// lookup between the "mutant_string" variable and abstract mutant_part types. used to address into mut_part_name_datum_lookup
GLOBAL_LIST_EMPTY(mut_part_str_type_lookup)
// associative list (keyed by mutant_bodypart abstract_type, the "base" of that type of part)
// of associative lists (keyed by the mutant part var "name") of mutant_part datums.
// as iterating through an assoc list iterates through its keys, iterating through
// those lists will iterate through the names of the options for that part.
// a sub-list is only created when a variant is added; consequently, there are no empty sub-lists.
GLOBAL_LIST_EMPTY(mut_part_name_datum_lookup)

/proc/make_datum_references_lists()
	//hair
	init_sprite_accessory_subtypes(/datum/sprite_accessory/hair, GLOB.hairstyles_list)
	//facial hair
	init_sprite_accessory_subtypes(/datum/sprite_accessory/facial_hair, GLOB.facial_hairstyles_list)
	//underwear
	init_sprite_accessory_subtypes(/datum/sprite_accessory/underwear, GLOB.underwear_list)
	//undershirt
	init_sprite_accessory_subtypes(/datum/sprite_accessory/undershirt, GLOB.undershirt_list)
	//socks
	init_sprite_accessory_subtypes(/datum/sprite_accessory/socks, GLOB.socks_list)
	//bodypart accessories (blizzard intensifies)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ipc_chassis, GLOB.ipc_chassis_list)
	// ipc brains and digi legs used to be here, but they don't need to be initialized from subtypes

	init_mutant_bodypart_lookup_lists()

	//Species
	for(var/spath in subtypesof(/datum/species))
		var/datum/species/S = new spath()
		GLOB.species_list[S.id] = spath
	sortList(GLOB.species_list, /proc/cmp_typepaths_asc)

	//Species clothing
	for(var/spath in subtypesof(/datum/species))
		var/datum/species/S = new spath()
		GLOB.species_clothing_icons[S.id] = list()

	//Surgeries
	for(var/path in subtypesof(/datum/surgery))
		GLOB.surgeries_list += new path()
	sortList(GLOB.surgeries_list, /proc/cmp_typepaths_asc)

	// Hair Gradients - Initialise all /datum/sprite_accessory/hair_gradient into an list indexed by gradient-style name
	for(var/path in subtypesof(/datum/sprite_accessory/hair_gradient))
		var/datum/sprite_accessory/hair_gradient/H = new path()
		GLOB.hair_gradients_list[H.name] = H

	//Materials
	for(var/path in subtypesof(/datum/material))
		var/datum/material/D = new path()
		GLOB.materials_list[D.id] = D
	sortList(GLOB.materials_list, /proc/cmp_typepaths_asc)

	//Default Jobs
	for(var/path in subtypesof(/datum/job))
		var/datum/job/new_job = new path()
		GLOB.occupations += new_job
		GLOB.name_occupations[new_job.name] = new_job
		GLOB.type_occupations[path] = new_job

	// Keybindings
	init_keybindings()

	GLOB.emote_list = init_emote_list()

	init_subtypes(/datum/crafting_recipe, GLOB.crafting_recipes)

//creates every subtype of prototype (excluding prototype) and adds it to list L.
//if no list/L is provided, one is created.
/proc/init_subtypes(prototype, list/L)
	if(!istype(L))
		L = list()
	for(var/path in subtypesof(prototype))
		L += new path()
	return L

//returns a list of paths to every subtype of prototype (excluding prototype)
//if no list/L is provided, one is created.
/proc/init_paths(prototype, list/L)
	if(!istype(L))
		L = list()
		for(var/path in subtypesof(prototype))
			L+= path
		return L

