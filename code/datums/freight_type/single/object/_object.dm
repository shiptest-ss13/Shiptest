// Handheld item type objectives
// The most commonly used freight_type since most objects don't have amount or count vars, but the freight_type datum can still count individual objects in freight_contents_index

/datum/freight_type/single/object
	target = 1

/datum/freight_type/single/object/New( var/obj/object, var/number )
	// Object should be initialized
	if ( object )
		item_type = object

	if ( number )
		target = number

	set_item_name()

/datum/freight_type/single/object/get_item_targets( var/datum/freight_type_check/freight_type_check )
	var/datum/freight_contents_index/index = new /datum/freight_contents_index()
	freight_contents_index = index

	for ( var/atom/a in freight_type_check.container.GetAllContents() )
		if( !is_type_in_typecache( a, GLOB.blacklisted_paperwork_itemtypes ) || ( is_type_in_typecache( item_type, GLOB.blacklisted_paperwork_itemtypes ) && is_type_in_typecache( a, GLOB.blacklisted_paperwork_itemtypes ) ) )
			if( istype( a, item_type ) )
				if ( in_required_loc_or_is_required_loc( a ) )
					// Add to contents index for more checks
					index.add_amount( a, 1 )

	return index.get_amount( item_type, target, TRUE )

/datum/freight_type/single/object/get_brief_segment()
	return (target==1?"[item_name]":"[item_name] ([target] items)")
