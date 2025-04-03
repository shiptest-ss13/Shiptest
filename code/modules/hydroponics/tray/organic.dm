///////////////////////////////////////////////////////////////////////////////
/obj/machinery/hydroponics/soil //Not actually hydroponics at all! Honk!
	name = "soil"
	desc = "A patch of dirt."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "soil"
	circuit = null
	density = FALSE
	use_power = NO_POWER_USE
	flags_1 = NODECONSTRUCT_1
	unwrenchable = FALSE
	self_sustaining_overlay_icon_state = null
	rating = 0.8

/obj/machinery/hydroponics/soil/update_status_light_overlays()
	return // Has no lights

/obj/machinery/hydroponics/soil/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/shovel) && !istype(O, /obj/item/shovel/spade)) //Doesn't include spades because of uprooting plants
		to_chat(user, span_notice("You clear up [src]!"))
		qdel(src)
	else
		return ..()

/obj/machinery/hydroponics/wooden
	name = "wooden planter box"
	desc = "A wooden plant tray"
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "wooden_tray"
	circuit = null
	use_power = NO_POWER_USE
	unwrenchable = TRUE
	self_sustaining_overlay_icon_state = null
	rating = 1.2

/obj/machinery/hydroponics/wooden/update_status_light_overlays()
	return // Has no lights

/obj/machinery/hydroponics/wooden/on_deconstruction()
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 5)
	return TRUE

/obj/machinery/hydroponics/wooden/attackby(obj/item/I, mob/user, params)
	if (user.a_intent != INTENT_HARM)
		if(default_deconstruction_crowbar(I, TRUE))
			return

	return ..()
