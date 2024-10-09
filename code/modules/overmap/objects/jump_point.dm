/**
 * # Jump points
 *
 * These overmap objects can be interacted with and will send you to another sector.
 * These will then dump you onto another jump point post jump. Useful for events!s
 */
/datum/overmap/jump_point
	name = "jump point"
	char_rep = "~"
	token_icon_state = "jump_point"


	///if you dont want ships docking where they please, remove INTERACTION_OVERMAP_DOCK and leave the quick dock feature
	interaction_options = null

	///The currently linked jump point
	var/datum/overmap/jump_point/destination

/datum/overmap/jump_point/Initialize(position, _other_wormhole, ...)
	. = ..()
	alter_token_appearance()

/datum/overmap/jump_point/alter_token_appearance()
	..()
	if(current_overmap.override_object_colors)
		token.color = secondary_structure_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/jump_point/proc/handle_jump(datum/overmap/ship/controlled/jumper)
	if(!destination)
		qdel(src)
		return

	jumper.move_overmaps(destination.current_system, destination.x, destination.y)
	jumper.overmap_step(S.get_heading())

/datum/overmap/jump_point/alter_token_appearance()
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.primary_color
	current_overmap.post_edit_token_state(src)
