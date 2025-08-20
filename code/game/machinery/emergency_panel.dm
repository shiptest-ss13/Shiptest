#define EMERGENCY_PANEL_COOLDOWN 10 MINUTES

/obj/machinery/emergency_panel
	name = "emergency distress panel"
	desc = "A panel installed in the floor of a vessel that can be used to signal distress with the ship's key. Functions without ship electricity."
	icon = 'icons/obj/machines/emergency_panel.dmi'
	icon_state = "panel"
	density = FALSE
	anchored = TRUE
	can_be_unanchored = FALSE
	resistance_flags = FIRE_PROOF | ACID_PROOF
	clicksound = "terminal_type"
	use_power = NO_POWER_USE // signal distress regardless of power

	// inserted ship key
	var/obj/item/key/ship/ship_key
	// ship that the panel is linked to
	var/datum/overmap/ship/controlled/linked_ship
	// hatch open
	var/hatch_open = FALSE
	// timestamp for cooldown
	var/distress_cooldown = 0

/obj/machinery/emergency_panel/examine(mob/user)
	. = ..()
	. += span_warning("Per interstellar travel code, misuse of emergency communication systems can lead to fines, questioning, and/or legal action.")
	if(!hatch_open)
		. += span_notice("You can Alt-Click to open the hatch and access the panel.")
	if(ship_key)
		. += span_notice("There's a key inserted in the panel. You can Alt-Click to take it.")

/obj/machinery/emergency_panel/update_appearance()
	. = ..()
	if(hatch_open)
		icon_state = "panel_open"
	if(ship_key)
		icon_state = "panel_open_key"
	else
		icon_state = "panel"

/obj/machinery/emergency_panel/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	linked_ship = port.current_ship

/obj/machinery/emergency_panel/AltClick(mob/user)
	. = ..()
	if(!hatch_open)
		to_chat(user, span_notice("You open the hatch of the emergency panel."))
		playsound(src, 'sound/effects/bin_open.ogg', 50, FALSE)
		hatch_open = TRUE
	else if(ship_key) // don't forget your key
		to_chat(user, span_notice("You twist the key sideways and take it from the panel."))
		playsound(src, 'sound/machines/locktoggle.ogg', 50, FALSE)
		try_put_in_hand(ship_key, user)
		ship_key = null
	else
		to_chat(user, span_notice("You close the hatch of the emergency panel."))
		playsound(src, 'sound/effects/bin_close.ogg', 50, FALSE)
		hatch_open = FALSE
	update_appearance()

/obj/machinery/emergency_panel/attackby(obj/item/item, mob/living/user, params)
	if(istype(item, /obj/item/key/ship))
		if(!hatch_open)
			to_chat(user, span_warning("You need to open the hatch first."))
			return
		var/obj/item/key/ship/key = item
		if(key.master_ship != linked_ship) // what are you trying to pull here
			to_chat(user, span_warning("That key doesn't go there."))
			return
		to_chat(user, span_notice("You insert the key into the panel and twist it sideways."))
		playsound(src, 'sound/machines/locktoggle.ogg', 50, FALSE)
		key.forceMove(src)
		ship_key = key
	else
		. = ..()

/obj/machinery/emergency_panel/attack_hand(mob/living/user)
	. = ..()
	if(!hatch_open)
		return
	if(!ship_key)
		to_chat(user, span_warning("The panel needs a ship key to work."))
		return
	if(distress_cooldown >= world.time)
		to_chat(user, span_warning("The panel is not ready to send another distress signal."))
		return

	switch(alert(user, "Are you sure you want to create a distress signal?",, "Yes", "No"))
		if("Yes")
			create_distress_beacon(get_overmap_location())
			playsound(src, 'sound/machines/triple_beep.ogg', 50, FALSE)
			to_chat(user, span_warning("Distress signal broadcasted."))
			distress_cooldown = world.time + EMERGENCY_PANEL_COOLDOWN
		else
			return

#undef EMERGENCY_PANEL_COOLDOWN
