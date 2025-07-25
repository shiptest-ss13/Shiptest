
/obj/machinery/hydroponics/constructable
	name = "hydroponics tray"
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "hydrotray3"
	can_self_sustatin = TRUE

/obj/machinery/hydroponics/constructable/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation, ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS, null, CALLBACK(src, PROC_REF(can_be_rotated)))
	AddComponent(/datum/component/plumbing/simple_demand)

/obj/machinery/hydroponics/constructable/proc/can_be_rotated(mob/user, rotation_type)
	return !anchored

/obj/machinery/hydroponics/constructable/RefreshParts()
	var/tmp_capacity = 0
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		tmp_capacity += M.rating
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		rating = max(1.2, M.rating)
		break
	maxwater = tmp_capacity * 50 // Up to 400
	maxnutri = (tmp_capacity * 5) + STATIC_NUTRIENT_CAPACITY // Up to 50 Maximum
	reagents.maximum_volume = maxnutri
	nutridrain = 1/rating

/obj/machinery/hydroponics/constructable/examine(mob/user)
	. = ..()
	. += span_notice("Use <b>Ctrl-Click</b> to activate autogrow. <b>Alt-Click</b> to empty the tray's nutrients.")
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: Tray efficiency at <b>[rating*100]%</b>.")

/obj/machinery/hydroponics/constructable/attackby(obj/item/I, mob/user, params)
	if (user.a_intent != INTENT_HARM)
		// handle opening the panel
		if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
			return
		if(default_deconstruction_crowbar(I))
			return

	return ..()

