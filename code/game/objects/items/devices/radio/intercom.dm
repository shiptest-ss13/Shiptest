/obj/item/radio/intercom
	name = "shortwave intercom"
	desc = "Talk through this."
	icon = 'icons/obj/radio.dmi'
	icon_state = "intercom"
	anchored = TRUE
	listening = TRUE
	w_class = WEIGHT_CLASS_BULKY
	canhear_range = 2
	dog_fashion = null
	unscrewed = FALSE
	var/obj/item/wallframe/wallframe = /obj/item/wallframe/intercom

MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom, 31)

/obj/item/radio/intercom/unscrewed
	unscrewed = TRUE

/obj/item/radio/intercom/Initialize(mapload, ndir, building)
	. = ..()
	if(building)
		setDir(turn(ndir,180))
	var/area/current_area = get_area(src)
	if(!current_area)
		return
	RegisterSignal(current_area, COMSIG_AREA_POWER_CHANGE, PROC_REF(AreaPowerCheck))

/obj/item/radio/intercom/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Use [MODE_TOKEN_INTERCOM] when nearby to speak into it.</span>"
	if(!unscrewed)
		. += "<span class='notice'>It's <b>screwed</b> and secured to the wall.</span>"
	else
		. += "<span class='notice'>It's <i>unscrewed</i> from the wall, and can be <b>detached</b>.</span>"

/obj/item/radio/intercom/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(unscrewed)
			user.visible_message("<span class='notice'>[user] starts tightening [src]'s screws...</span>", "<span class='notice'>You start screwing in [src]...</span>")
			if(I.use_tool(src, user, 30, volume=50))
				user.visible_message("<span class='notice'>[user] tightens [src]'s screws!</span>", "<span class='notice'>You tighten [src]'s screws.</span>")
				unscrewed = FALSE
		else
			user.visible_message("<span class='notice'>[user] starts loosening [src]'s screws...</span>", "<span class='notice'>You start unscrewing [src]...</span>")
			if(I.use_tool(src, user, 40, volume=50))
				user.visible_message("<span class='notice'>[user] loosens [src]'s screws!</span>", "<span class='notice'>You unscrew [src], loosening it from the wall.</span>")
				unscrewed = TRUE
		return
	else if(I.tool_behaviour == TOOL_WRENCH)
		if(!unscrewed)
			to_chat(user, "<span class='warning'>You need to unscrew [src] from the wall first!</span>")
			return
		user.visible_message("<span class='notice'>[user] starts unsecuring [src]...</span>", "<span class='notice'>You start unsecuring [src]...</span>")
		I.play_tool_sound(src)
		if(I.use_tool(src, user, 80))
			user.visible_message("<span class='notice'>[user] unsecures [src]!</span>", "<span class='notice'>You detach [src] from the wall.</span>")
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			new wallframe(get_turf(src))
			qdel(src)
		return
	return ..()

/obj/item/radio/intercom/attack_ai(mob/user)
	interact(user)

/obj/item/radio/intercom/attack_paw(mob/user)
	return attack_hand(user)


/obj/item/radio/intercom/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	interact(user)

/obj/item/radio/intercom/ui_state(mob/user)
	if(issilicon(user)) // for silicons give default_state
		return GLOB.default_state

	return GLOB.physical_state // for other non-dexterous mobs give physical_state



/obj/item/radio/intercom/can_receive(freq, map_zones)
	if(!on)
		return FALSE
	if(wires.is_cut(WIRE_RX))
		return FALSE
	if(!(0 in map_zones))
		var/turf/position = get_turf(src)
		var/datum/map_zone/mapzone = position.get_map_zone()
		if(!position || !(mapzone in map_zones))
			return FALSE
	if(!listening)
		return FALSE

	return TRUE


/obj/item/radio/intercom/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq, list/spans, list/message_mods = list())
	if(message_mods[RADIO_EXTENSION] == MODE_INTERCOM)
		return  // Avoid hearing the same thing twice
	return ..()

/obj/item/radio/intercom/emp_act(severity)
	. = ..() // Parent call here will set `on` to FALSE.
	update_appearance()

/obj/item/radio/intercom/end_emp_effect(curremp)
	. = ..()
	AreaPowerCheck() // Make sure the area/local APC is powered first before we actually turn back on.

/obj/item/radio/intercom/update_icon()
	. = ..()
	if(on)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]-p"

/**
 * Proc called whenever the intercom's area loses or gains power. Responsible for setting the `on` variable and calling `update_appearance()`.
 *
 * Normally called after the intercom's area recieves the `COMSIG_AREA_POWER_CHANGE` signal, but it can also be called directly.
 * Arguments:
 * * source - the area that just had a power change.
 */
/obj/item/radio/intercom/proc/AreaPowerCheck(datum/source)
	var/area/current_area = get_area(src)
	if(!current_area)
		on = FALSE
	else
		on = current_area.powered(AREA_USAGE_EQUIP) // set "on" to the equipment power status of our area.
	update_appearance()

/obj/item/radio/intercom/add_blood_DNA(list/blood_dna)
	return FALSE

//Created through the autolathe or through deconstructing intercoms. Can be applied to wall to make a new intercom on it!
/obj/item/wallframe/intercom
	name = "intercom frame"
	desc = "A ready-to-go intercom. Just slap it on a wall and screw it in!"
	icon_state = "intercom"
	result_path = /obj/item/radio/intercom/unscrewed
	pixel_shift = 31
	inverse = FALSE
	custom_materials = list(/datum/material/iron = 75, /datum/material/glass = 25)

//table Normal Intercoms

/obj/item/radio/intercom/table
	icon_state = "intercom-table"
	wallframe = /obj/item/wallframe/intercom/table

/obj/item/wallframe/intercom/table
	icon_state = "intercom-table"
	icon = 'icons/obj/radio.dmi'
	result_path = /obj/item/radio/intercom/table
	pixel_shift = 0


//wideband radio
/obj/item/radio/intercom/wideband
	name = "wideband relay"
	desc = "A low-gain reciever capable of sending and recieving wideband subspace messages."
	icon_state = "intercom-wideband"
	canhear_range = 3
	keyslot = new /obj/item/encryptionkey/wideband
	independent = TRUE
	frequency = FREQ_WIDEBAND
	freqlock = TRUE
	freerange = TRUE
	log = TRUE
	wallframe = /obj/item/wallframe/intercom/wideband

/obj/item/radio/intercom/wideband/Initialize(mapload, ndir, building)
	. = ..()
	set_frequency(FREQ_WIDEBAND)
	freqlock = TRUE

/obj/item/radio/intercom/wideband/examine_more(mob/user)
	interact(user)

/obj/item/radio/intercom/wideband/unscrewed
	unscrewed = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/wideband, 26)

/obj/item/radio/intercom/wideband/table
	icon_state = "intercom-wideband-table"
	wallframe = /obj/item/wallframe/intercom/wideband/table

/obj/item/radio/intercom/wideband/recalculateChannels()
	. = ..()
	independent = TRUE

/obj/item/wallframe/intercom/wideband
	name = "wideband relay frame"
	desc = "A detached wideband relay. Attach to a wall and screw it in to use."
	icon_state = "intercom-wideband"
	result_path = /obj/item/radio/intercom/wideband/unscrewed
	pixel_shift = 26

/obj/item/wallframe/intercom/wideband/table
	icon_state = "intercom-wideband-table"
	icon = 'icons/obj/radio.dmi'
	result_path = /obj/item/radio/intercom/wideband/table
	pixel_shift = 0
