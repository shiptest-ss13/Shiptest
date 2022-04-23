
// Stores freight torpedo contents and its prepackaged status data

// Self reminder to uptick this tally every time you looked at this file, seriously considered axing it, but changed your mind because it was too arcane to refactor courier code without this file
// Apparently they weren't kidding about the ballmer peak
// ihatethisfile = 3

/datum/freight_contents_index
	// Keep a total count of the actual type we're checking
	// atoms_amount = (
	// 	typepath "/obj/structure/closet" = 5
	// 	...
	// )
	var/list/atoms_amount = list()

	// Return these items that contain the amount in the list above
	// atoms_list = (
	// 	"/obj/structure/closet" = (
	// 		an initialized atom,
	// 		...
	// 	)
	// 	...
	// )
	var/list/atoms_list = list()

/datum/freight_contents_index/proc/add_amount( var/atom/a, var/amount, var/type )
	if ( !type )
		if ( a?.type )
			type = a.type

	if ( !atoms_amount[ type ] )
		atoms_amount[ type ] = 0
		atoms_list[ type ] = list()
	atoms_amount[ type ] += amount
	atoms_list[ type ] += a

/datum/freight_contents_index/proc/get_all()
	// Compile a list of all items from atoms_list types and their lists
	var/list/allAtoms = list()
	for ( var/types in atoms_list )
		for ( var/atom/a in atoms_list[ types ] )
			allAtoms += a

	if ( length( allAtoms ) )
		return allAtoms

/datum/freight_contents_index/proc/get_amount( var/type, var/amount, var/allow_subtypes )
	if ( atoms_amount[ type ] && atoms_amount[ type ] >= amount )
		return atoms_list[ type ]

	if ( allow_subtypes && ispath( type ) )
		// Object subtype leniency
		// If a parent type of an object is requested like a plain cake or a base fighter_component object, allow its subtypes to be submitted as well
		var/list/allAtoms = list()
		for ( var/subtype in subtypesof( type ) )
			if ( atoms_amount[ subtype ] )
				// Collate all partial subtypes
				allAtoms += atoms_list[ subtype ]

		if ( length( allAtoms ) >= amount )
			return allAtoms

/datum/freight_contents_index/proc/get_all_if_successful( var/type, var/amount, var/allow_subtypes )
	// Runs get_amount by default. If successful, marks all filtered contents in atoms_list as not trash for objectives with approve_inner_contents
	var/list/valid_atoms = get_amount( type, amount, allow_subtypes )
	if ( valid_atoms && length( valid_atoms ) )
		return get_all()
