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

	///the overmap that this jump point wants to traverse to
	var/datum/overmap_star_system/target_overmap
	///A linked jump point for bi-directional movement.
	//'linking' jump points will make them attempt to jump out over each other, otherwise it'll attempt to find a jump location from target_overmap
	var/datum/overmap/jump_point/target_jump_point


/datum/overmap/jump_point/Initialize(position, datum/overmap_star_system/system_spawned_in, datum/overmap_star_system/target_system, _other_point, ...)
	. = ..()
	target_overmap = target_system
	name = "[target_overmap] [pick("Passage", "Corridor", "Tunnel", "Gallery", "Breezeway")]"
	system_spawned_in.jump_points += src
	if(_other_point)
		link_points(_other_point)

/datum/overmap/jump_point/proc/link_points(other_point)
	target_jump_point = other_point
	target_jump_point.target_jump_point = src

	target_jump_point.name = name

	RegisterSignal(target_jump_point, COMSIG_OVERMAP_MOVED, PROC_REF(alter_token_appearance))
	target_jump_point.RegisterSignal(src, COMSIG_OVERMAP_MOVED, PROC_REF(alter_token_appearance))

	alter_token_appearance()
	target_jump_point.alter_token_appearance()

/datum/overmap/jump_point/get_jump_to_turf()
	if(target_jump_point)
		return get_turf(target_jump_point.token)
	//go to the star.
	return get_turf(target_overmap.overmap_objects[1]?:token)

/datum/overmap/jump_point/alter_token_appearance()
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.primary_color
	current_overmap.post_edit_token_state(src)
	desc = "A break in the local space-time where you can safely enter the Frontier's unstable Bluespace."
	if(target_overmap)
		desc += {"
		[span_boldnotice("Destination information:")]
		[span_bold("System: ")][target_overmap.name]
		[target_jump_point ? span_bold("Location: ") + "[target_jump_point.x] by [target_jump_point.y]" : ""]
		"}
	token.setDir(dir)



/datum/overmap/jump_point/handle_interaction_on_target(mob/living/user, datum/overmap/interactor, choice)
	if(!target_overmap)
		qdel(src)
		return INTERACTION_OVERMAP_SELECTED
	var/list/destination = target_jump_point ? list("x" = target_jump_point.x, "y" = target_jump_point.y) : target_overmap.get_overmap_edge(REVERSE_DIR(dir))
	switch(choice)
		if(INTERACTION_OVERMAP_JUMPTO)
			if(tgui_alert(user, "Do you want to bluespace jump to [target_overmap]? You will have to stay near [name] while jumping.", "Jump Confirmation", list("Yes", "No")) != "Yes")
				return
			RegisterSignal(interactor, COMSIG_OVERMAP_MOVED, PROC_REF(ship_moved))
			RegisterSignal(interactor, COMSIG_OVERMAP_MOVE_SYSTEMS, PROC_REF(ship_jumped))
			SEND_SIGNAL(interactor, COMSIG_OVERMAP_CALIBRATE_JUMP, target_overmap, destination["x"], destination["y"])

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
