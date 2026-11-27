#define EMERGENCY_PANEL_COOLDOWN 10 MINUTES

/obj/machinery/emergency_panel
	name = "emergency distress panel"
	desc = "A panel installed in the floor of a vessel that can be used to signal distress. Functions without ship electricity."
	icon = 'icons/obj/machines/emergency_panel.dmi'
	icon_state = "panel"
	density = FALSE
	anchored = TRUE
	can_be_unanchored = FALSE
	resistance_flags = FIRE_PROOF | ACID_PROOF
	clicksound = "terminal_type"
	use_power = NO_POWER_USE // signal distress regardless of power
	plane = FLOOR_PLANE
	layer = LOW_OBJ_LAYER

	// ship that the panel is linked to
	var/datum/overmap/ship/controlled/linked_ship
	// hatch open
	var/hatch_open = FALSE
	// cooldown
	var/on_cooldown = FALSE

/obj/machinery/emergency_panel/examine(mob/user)
	. = ..()
	. += span_warning("Per interstellar travel code, misuse of emergency communication systems can lead to fines, questioning, and/or legal action.")
	if(!hatch_open)
		. += span_notice("You can Alt-Click to open the hatch and access the panel.")

/obj/machinery/emergency_panel/update_icon_state()
	if(!hatch_open)
		icon_state = initial(icon_state)
	else if(on_cooldown)
		icon_state = "[initial(icon_state)]_open"
	else
		icon_state = "[initial(icon_state)]_open_key"
	return ..()

/obj/machinery/emergency_panel/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	linked_ship = port.current_ship

/obj/machinery/emergency_panel/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	if(!hatch_open)
		to_chat(user, span_notice("You open the hatch of the emergency panel."))
		playsound(src, 'sound/effects/bin_open.ogg', 50, FALSE)
		hatch_open = TRUE
	else
		to_chat(user, span_notice("You close the hatch of the emergency panel."))
		playsound(src, 'sound/effects/bin_close.ogg', 50, FALSE)
		hatch_open = FALSE
	update_appearance()

/obj/machinery/emergency_panel/attack_hand(mob/living/user)
	. = ..()
	if(!hatch_open)
		return
	if(on_cooldown)
		to_chat(user, span_warning("The panel is not ready to send another distress signal."))
		return

	switch(alert(user, "Are you sure you want to create a distress signal?",, "Yes", "No"))
		if("Yes")
			if(on_cooldown || !hatch_open || !user.canUseTopic(src, BE_CLOSE))
				return
			create_distress_beacon(linked_ship)

			playsound(src, 'sound/machines/triple_beep.ogg', 50, FALSE)
			to_chat(user, span_warning("Distress signal broadcasted."))
			on_cooldown = TRUE
			update_appearance()
			addtimer(CALLBACK(src, PROC_REF(reset_cooldown)), EMERGENCY_PANEL_COOLDOWN)
		else
			return

/obj/machinery/emergency_panel/proc/reset_cooldown()
	on_cooldown = FALSE
	update_appearance()

/obj/machinery/emergency_panel/dark
	icon_state = "panel-dark"

#undef EMERGENCY_PANEL_COOLDOWN
