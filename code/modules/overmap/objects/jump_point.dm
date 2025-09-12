/**
 * # Jump points
 *
 * These overmap objects can be interacted with and will send you to another sector.
 * These will then dump you onto another jump point post jump. Useful for events or punchcards!
 */
/datum/overmap/jump_point
	name = "jump point"
	desc = "A specific point in this system where you are able to bluespace 'jump' to one specific system."
	char_rep = "~"
	token_icon_state = "jump_point"

	interaction_options = list(INTERACTION_OVERMAP_JUMPTO)

	///Direction we are facing, used for token mostly
	var/dir
	///The currently linked jump point
	var/datum/overmap/jump_point/destination


/datum/overmap/jump_point/Initialize(position, datum/overmap_star_system/system_spawned_in, _other_point, ...)
	. = ..()
	if(_other_point)
		link_points(_other_point)

/datum/overmap/jump_point/proc/link_points(other_point)
	destination = other_point
	destination.destination = src
	alter_token_appearance()
	destination.alter_token_appearance()

/datum/overmap/jump_point/get_jump_to_turf()
	return get_turf(destination.token)

/datum/overmap/jump_point/alter_token_appearance()
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.primary_color
	current_overmap.post_edit_token_state(src)
	if(destination)
		desc = "A specific point in this system where you are able to bluespace 'jump' to one specific system."
		desc += {"
		[span_boldnotice("Destination information:")]
		[span_bold("System: ")][destination.current_overmap]
		[span_bold("Location: ")]X[destination.x]/Y[destination.y]
		"}
	token.setDir(dir)


/datum/overmap/jump_point/handle_interaction_on_target(mob/living/user, datum/overmap/interactor, choice)
	if(!destination)
		qdel(src)
		return INTERACTION_OVERMAP_SELECTED
	switch(choice)
		if(INTERACTION_OVERMAP_JUMPTO)
			if(tgui_alert(user, "Do you want to bluespace jump to [destination.current_overmap.name]? Your ship will NOT be removed from the round and you will have to stay near [name] doing this.", "Jump Confirmation", list("Yes", "No")) != "Yes")
				return
			RegisterSignal(interactor, COMSIG_OVERMAP_MOVED, PROC_REF(ship_moved))
			RegisterSignal(interactor, COMSIG_OVERMAP_MOVE_SYSTEMS, PROC_REF(ship_jumped))
			SEND_SIGNAL(interactor, COMSIG_OVERMAP_CALIBRATE_JUMP, destination.current_overmap, destination.x, destination.y)

			return INTERACTION_OVERMAP_SELECTED
	return ..()


/datum/overmap/jump_point/proc/ship_moved(datum/overmap/interactor)
	for(var/dir in GLOB.cardinals)
		var/list/checked_coords = get_overmap_step(dir, 1)
		//for(var/datum/overmap/current_event as anything in overmap_container[checked_coords["x"]][checked_coords["y"]])
		if(locate(interactor) in current_overmap.overmap_container[checked_coords["x"]][checked_coords["y"]])
			return
	SEND_SIGNAL(interactor, COMSIG_OVERMAP_CANCEL_JUMP)
	UnregisterSignal(interactor, COMSIG_OVERMAP_MOVED)
	UnregisterSignal(interactor, COMSIG_OVERMAP_MOVE_SYSTEMS)


/datum/overmap/jump_point/proc/ship_jumped(datum/overmap/interactor)
	UnregisterSignal(interactor, COMSIG_OVERMAP_MOVED)
	UnregisterSignal(interactor, COMSIG_OVERMAP_MOVE_SYSTEMS)
