/// Tucking element, for things that can be tucked into bed.
/datum/element/bed_tuckable
	element_flags = ELEMENT_BESPOKE|ELEMENT_DETACH
	id_arg_index = 2
	/// our pixel_x offset - how much the item moves x when in bed (+x is closer to the pillow)
	var/x_offset = 0
	/// our pixel_y offset - how much the item move y when in bed (-y is closer to the middle)
	var/y_offset = 0
	/// our rotation degree - how much the item turns when in bed (+degrees turns it more parallel)
	var/rotation_degree = 0
	/// Whether the item changes its dir to match the desired lying direction of the bed that it's tucked into.
	var/change_dir = FALSE
	/// Whether the item changes its layer to the layer suggested by the bed for tucked-in item.
	/// When the item is untucked, it is returned to its initial() layer.
	var/change_layer = FALSE

/datum/element/bed_tuckable/Attach(obj/target, x = 0, y = 0, rotation = 0, _change_dir = FALSE, _change_layer = FALSE)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	x_offset = x
	y_offset = y
	rotation_degree = rotation
	change_dir = _change_dir
	change_layer = _change_layer
	RegisterSignal(target, COMSIG_ITEM_ATTACK_OBJ, PROC_REF(tuck_into_bed))

/datum/element/bed_tuckable/Detach(obj/target)
	. = ..()
	UnregisterSignal(target, list(COMSIG_ITEM_ATTACK_OBJ, COMSIG_ITEM_PICKUP))

/**
 * Tuck our object into bed.
 *
 * tucked - the object being tucked
 * target_bed - the bed we're tucking them into
 * tucker - the guy doing the tucking
 */
/datum/element/bed_tuckable/proc/tuck_into_bed(obj/item/tucked, obj/structure/bed/target_bed, mob/living/tucker)
	SIGNAL_HANDLER

	if(!istype(target_bed))
		return

	if(!tucker.transferItemToLoc(tucked, target_bed.drop_location()))
		return

	to_chat(tucker, "<span class='notice'>You lay [tucked] out on [target_bed].</span>")
	tucked.pixel_x = x_offset + target_bed.tucked_x_shift
	tucked.pixel_y = y_offset + target_bed.tucked_y_shift
	if(rotation_degree)
		tucked.transform = turn(tucked.transform, rotation_degree)
		RegisterSignal(tucked, COMSIG_ITEM_PICKUP, PROC_REF(untuck))
	// the buckle_lying value on the bed controls the direction that mobs lay down in when they're buckled into bed.
	// some items (bedsheets) have different states to reflect those directions.
	if(change_dir)
		if(target_bed.buckle_lying == 270)
			tucked.setDir(NORTH)
		else
			tucked.setDir(SOUTH)
	if(target_bed.suggested_tuck_layer != null)
		tucked.layer = target_bed.suggested_tuck_layer

	return COMPONENT_NO_AFTERATTACK

/**
 * If we rotate our object, then we need to un-rotate it when it's picked up
 *
 * tucked - the object that is tucked
 */
/datum/element/bed_tuckable/proc/untuck(obj/item/tucked)
	SIGNAL_HANDLER

	tucked.transform = turn(tucked.transform, -rotation_degree)
	tucked.layer = initial(tucked.layer)
	UnregisterSignal(tucked, COMSIG_ITEM_PICKUP)
