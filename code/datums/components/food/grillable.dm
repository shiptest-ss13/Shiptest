/datum/component/grillable
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS //So you can change grill results with various cookstuffs
	///Result atom type of grilling this object
	var/atom/cook_result
	///Amount of time required to cook the food
	var/required_cook_time = 2 MINUTES
	///Time spent cooking so far
	var/current_cook_time = 0
	///Are we currently grilling?
	var/currently_grilling = FALSE
	///Is this a positive grill result?
	var/positive_result = TRUE

	///Do we use the large steam sprite?
	var/use_large_steam_sprite = FALSE

/datum/component/grillable/Initialize(cook_result, required_cook_time, positive_result, use_large_steam_sprite)
	. = ..()
	if(!isitem(parent)) //Only items support grilling at the moment
		return COMPONENT_INCOMPATIBLE

	src.cook_result = cook_result
	src.required_cook_time = required_cook_time
	src.positive_result = positive_result
	src.use_large_steam_sprite = use_large_steam_sprite

	RegisterSignal(parent, COMSIG_ITEM_GRILLED, PROC_REF(on_grill))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE,  PROC_REF(on_examine))

// Inherit the new values passed to the component
/datum/component/grillable/InheritComponent(datum/component/grillable/new_comp, original, cook_result, required_cook_time, positive_result, use_large_steam_sprite)
	if(!original)
		return
	if(cook_result)
		src.cook_result = cook_result
	if(required_cook_time)
		src.required_cook_time = required_cook_time
	if(positive_result)
		src.positive_result = positive_result
	if(use_large_steam_sprite)
		src.use_large_steam_sprite = use_large_steam_sprite

///Ran every time an item is grilled by something
/datum/component/grillable/proc/on_grill(datum/source, atom/used_grill, seconds_per_tick = 1)
	SIGNAL_HANDLER

	. = COMPONENT_HANDLED_GRILLING

	current_cook_time += seconds_per_tick * 10 //turn it into ds
	if(current_cook_time >= required_cook_time)
		finish_grilling(used_grill)
	else if(!currently_grilling) //We havn't started grilling yet
		start_grilling(used_grill)

///Ran when an object starts grilling on something
/datum/component/grillable/proc/start_grilling(atom/grill_source)
	currently_grilling = TRUE
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED,  PROC_REF(on_moved))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS,  PROC_REF(add_grilled_overlay))

	var/atom/A = parent
	A.update_appearance()

///Ran when an object finished grilling
/datum/component/grillable/proc/finish_grilling(atom/grill_source)
	var/atom/original_object = parent
	var/atom/grilled_result = new cook_result(original_object.loc)

	grilled_result.pixel_x = original_object.pixel_x
	grilled_result.pixel_y = original_object.pixel_y

	//blind feedback will be important for stuff like this
	grill_source.visible_message(
		"<span class='[positive_result ? "nicegreen" : "boldwarning"]'>[parent] turns into \a [grilled_result]!</span>",
		blind_message = span_notice("Something smells [positive_result ? "great" : "awful"]."),
	)

	SEND_SIGNAL(parent, COMSIG_GRILL_COMPLETED, grilled_result)
	currently_grilling = FALSE
	qdel(parent)

///Ran when an object almost finishes grilling
/datum/component/grillable/proc/on_examine(atom/A, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!current_cook_time) //Not grilled yet
		if(positive_result)
			if(initial(cook_result.name) == PLURAL)
				examine_list += span_notice("It can be <b>grilled</b>.")
		return

	if(positive_result)
		if(current_cook_time <= required_cook_time * 0.75)
			examine_list += span_danger("It needs to be cooked a bit longer!")
		else if(current_cook_time <= required_cook_time)
			examine_list += span_danger("It is almost done cooking!")
	else
		examine_list += span_nicegreen("It looks perfectly cooked.")

///Ran when an object moves from the grill
/datum/component/grillable/proc/on_moved(atom/A, atom/OldLoc, Dir, Forced)
	SIGNAL_HANDLER
	currently_grilling = FALSE
	UnregisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS)
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	A.update_appearance()

/datum/component/grillable/proc/add_grilled_overlay(datum/source, list/overlays)
	SIGNAL_HANDLER

	overlays += mutable_appearance('icons/effects/steam.dmi', "[use_large_steam_sprite ? "steam_triple" : "steam_single"]", ABOVE_OBJ_LAYER)
