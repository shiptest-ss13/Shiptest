/datum/freight_type/single/object/mineral
	target = 50

/datum/freight_type/single/object/mineral/get_item_targets( var/datum/freight_type_check/freight_type_check )
	var/datum/freight_contents_index/index = new /datum/freight_contents_index()
	freight_contents_index = index

	for ( var/obj/item/stack/a in freight_type_check.container.GetAllContents() )
		if( !is_type_in_typecache( a, GLOB.blacklisted_paperwork_itemtypes ) || ( is_type_in_typecache( item_type, GLOB.blacklisted_paperwork_itemtypes ) && is_type_in_typecache( a, GLOB.blacklisted_paperwork_itemtypes ) ) )
			if( istype( a, item_type ) || ( length( prepackaged_items ) && recursive_loc_check( a, item_type ) ) )
				if ( in_required_loc_or_is_required_loc( a ) )
					// Add to contents index for more checks
					index.add_amount( a, a.amount )

	return index.get_amount( item_type, target, TRUE )

/datum/freight_type/single/object/mineral/get_brief_segment()
	return "[item_name] ([target] sheet\s)"
