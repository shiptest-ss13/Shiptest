/datum/freight_type/single/specimen
	var/reveal_specimen = FALSE // WIP
	approve_inner_contents = TRUE // Don't count equipment attached to mobs as trash

/datum/freight_type/single/specimen/New( var/mob/living/simple_animal/object )
	if ( object )
		item_type = object

	var/picked = get_random_food()
	additional_prepackaging += new picked()

	set_item_name()

/datum/freight_type/single/specimen/add_item_to_crate( var/obj/C )
	// DuplicateObject on a mob producing runtimes
	var/mob/living/simple_animal/M = new item_type( C )
	// specimen = M
	M.AIStatus = AI_OFF
	return M

/datum/freight_type/single/specimen/get_item_targets( var/datum/freight_type_check/freight_type_check )
	var/datum/freight_contents_index/index = new /datum/freight_contents_index()
	freight_contents_index = index

	for ( var/atom/a in freight_type_check.container.GetAllContents() )
		if( !is_type_in_typecache( a, GLOB.blacklisted_paperwork_itemtypes ) || ( is_type_in_typecache( item_type, GLOB.blacklisted_paperwork_itemtypes ) && is_type_in_typecache( a, GLOB.blacklisted_paperwork_itemtypes ) ) )
			if( istype( a, item_type ) || ( length( prepackaged_items ) && recursive_loc_check( a, item_type ) ) ) // I can't remember why this deviated from the typical object check and I'm scared to remove it
				if ( in_required_loc_or_is_required_loc( a ) )
					// Add to contents index for more checks
					index.add_amount( a, 1 )

	return index.get_amount( item_type, target, TRUE )

/datum/freight_type/single/specimen/get_brief_segment()
	if ( reveal_specimen )
		return (target==1?"[item_name] specimen":"[target] [item_name] specimens")
	else
		return (target==1?"a secure specimen":"[target] secure specimens")

/datum/freight_type/single/specimen/get_supply_request_form_segment()
	return "<span>Disclaimer: By accepting this objective you accept that Nanotrasen and all affiliated facilities are NOT responsible for release of the specimen!</span><br>"

/datum/freight_type/single/specimen/get_item_name()
	if ( reveal_specimen )
		return (target==1?"[item_name] specimen":"[target] [item_name] specimens")
	else
		return (target==1?"a secure specimen":"[target] secure specimens")
