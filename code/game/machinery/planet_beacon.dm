#define BEACON_UNANCHORED 1
#define BEACON_ANCHORED 2
#define BEACON_IDLE 3
#define BEACON_ACTIVE 4
#define BEACON_DISTRESS 5

#define DISTRESS_COOLDOWN 5 MINUTES // May need to be raised/lower in the future
#define MAX_NAME_LENGTH 32 // How long of a name the planet can be renamed to

/obj/machinery/power/planet_beacon
	icon = 'icons/obj/machines/beacon.dmi'
	icon_state = "beacon"
	name = "EHF point beacon"
	desc = "A long-range radio beacon for marking planetoids and points of interest for revisiting."
	density = TRUE
	anchored = FALSE
	clicksound = "terminal_type"
	use_power = NO_POWER_USE
	idle_power_usage = IDLE_DRAW_MINIMAL
	active_power_usage = ACTIVE_DRAW_MINIMAL
	light_power = 1.5
	var/state = BEACON_UNANCHORED
	var/preserving = FALSE // Separate from state to prevent it being unpreserved on distress
	var/obj/item/card/id/inserted_id
	var/distress_time = 0 // value to compare with world.time if a distress beacon can be sent according to DISTRESS_COOLDOWN

/obj/machinery/power/planet_beacon/Initialize()
	. = ..()
	AddComponent(/datum/component/gps, "EHF" + num2text(rand(0,9)))

/obj/machinery/power/planet_beacon/process()
	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = locate() in T
	if(!C && powernet)
		disconnect_from_network()
		change_state(BEACON_ANCHORED)
	if(state > BEACON_IDLE) // If active or sending distress, use active_power_usage
		if(avail(active_power_usage))
			add_load(active_power_usage)
		else
			change_state(BEACON_ANCHORED)
	else if(state == BEACON_IDLE) // If idle, use idle_power_usage
		if(avail(idle_power_usage))
			add_load(idle_power_usage)
		else
			change_state(BEACON_ANCHORED)

/obj/machinery/power/planet_beacon/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/card/id))
		if(!inserted_id || state != BEACON_UNANCHORED)
			inserted_id = O
			O.forceMove(src)
			update_icon()
			playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
	else if(O.tool_behaviour == TOOL_WRENCH)
		var/datum/overmap/dynamic/OE = get_overmap_location()
		if(!istype(OE) || !OE.planet || istype(loc, /area/ship)) // Quick check to make sure we're actually *on* a planet, and will stay there
			to_chat(user, "<span class='warning'>The [src] can only be deployed on planets!</span>")
			return
		default_unfasten_wrench(user, O, time = 20)
		if(anchored)
			change_state(BEACON_ANCHORED)
			connect_to_network()
		else
			change_state(BEACON_UNANCHORED)
			disconnect_from_network()
	else
		. = ..()

/obj/machinery/power/planet_beacon/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(state == BEACON_ANCHORED && avail(idle_power_usage))
		change_state(BEACON_IDLE)
		playsound(src, 'sound/machines/terminal_on.ogg', 50, FALSE)
		return
	if(state > BEACON_ANCHORED)
		var/list/choice_list = list("Toggle beacon transmission", "Broadcast new location name", "Send distress beacon", "Turn off beacon")
		var/choice = tgui_input_list(user, "Select an option", src, choice_list)
		if(choice)
			play_click_sound()
		switch(choice)
			if("Toggle beacon transmission")
				if(preserving)
					change_state(BEACON_IDLE)
				else
					change_state(BEACON_ACTIVE)
				play_click_sound()
				to_chat(user, "<span class='notice'>You [preserving ? "enable" : "disable"] the beacon.</span>")

			if("Broadcast new location name")
				if(!inserted_id || !inserted_id.officer)
					to_chat(user, "<span class='warning'>Changing the location name requires an officer ID!</span>")
					return
				play_click_sound()
				var/datum/overmap/dynamic/OE = get_overmap_location()
				var/new_name = stripped_input(user, "Assign [OE.name] a new name. Enter the new name and ensure that it is no bigger than [MAX_NAME_LENGTH] characters long.", "Location Naming", max_length = MAX_NAME_LENGTH)
				if(!new_name)
					return
				var/old_name = OE.name
				if(!OE.Rename(new_name + " ([OE.planet.name])")) // Keep the planet type in the name, no false flagging entire planets
					return
				play_click_sound()
				to_chat(user, "<span class='notice'>You set [old_name]'s name to [OE.name].</span>")

			if("Send distress beacon")
				if(!inserted_id)
					to_chat(user, "<span class='warning'>Sending a distress beacon requires an ID!</span>")
					return
				play_click_sound()
				if(alert(user, "Are you sure you want to activate the distress beacon?", "", "Yes", "No") == "No")
					return
				if(distress_time >= world.time)
					to_chat(user, "<span class='warning'>The distress system is still recharging!</span>")
					return
				if(change_state(BEACON_DISTRESS))
					play_click_sound()
					to_chat(user, "<span class='danger'>You activate the distress beacon!</span>")

			if("Turn off beacon")
				to_chat(user, "<span class='notice'>You turn off the beacon.</span>")
				playsound(src, 'sound/machines/terminal_off.ogg', 50, FALSE)
				change_state(BEACON_ANCHORED)

/obj/machinery/power/planet_beacon/AltClick(mob/user)
	..()
	if(state != BEACON_UNANCHORED)
		if(inserted_id)
			try_put_in_hand(inserted_id, user)
			inserted_id = null
			update_icon()
			playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
			return

/obj/machinery/power/planet_beacon/examine(mob/user)
	. = ..()
	if(inserted_id)
		. += "<span class='notice'>Alt-click to eject the ID card.</span>"
	if(preserving)
		. += "<span class='notice'>It is currently active, marking the zone for future docking.</span>"
	switch(state)
		if(BEACON_UNANCHORED)
			. += "<span class='notice'>It is currently unsecured, and must be wrenched in place to use.</span>"
		if(BEACON_ANCHORED)
			. += "<span class='notice'>It is currently secured, and can be activated.</span>"
		// Active message handled by preserving
		if(BEACON_DISTRESS)
			. += "<span class='warning'>It is currently broadcasting a distress signal!</span>"

/obj/machinery/power/planet_beacon/proc/change_state(new_state)
	if(!new_state)
		return

	switch (new_state)
		if(BEACON_UNANCHORED) // Unanchored, cannot be turned on
			icon_state = "beacon"
			preserving = FALSE
			set_light(0)
		if(BEACON_ANCHORED) // Anchored, able to be turned on
			icon_state = "beacon_anchored"
			preserving = FALSE
			set_light(0)
		if(BEACON_IDLE) // Turning on, but not persistent yet, idle power usage
			icon_state = "beacon_idle"
			preserving = FALSE
			set_light_color(COLOR_CYAN)
			set_light(2)
		if(BEACON_ACTIVE) // Enable persistence, use full power
			icon_state = "beacon_active"
			preserving = TRUE
			set_light_color(COLOR_CYAN)
			set_light(2)
		if(BEACON_DISTRESS) // Send out a distress and temporarily change the screen
			if(!send_distress())
				return FALSE
			icon_state = "beacon_distress"
			set_light_color(COLOR_DARK_RED)
			set_light(3)

			addtimer(CALLBACK(src, PROC_REF(change_state), state), 10 SECONDS) // Return to the previous state after a certain time

	state = new_state // Actually change the state, can you believe I forgot this at one point?
	referesh_preservation()
	return TRUE

/obj/machinery/power/planet_beacon/update_overlays()
	. = ..()
	if(inserted_id)
		. += mutable_appearance(icon, "overlay_card")

/obj/machinery/power/planet_beacon/proc/send_distress()
	if(!inserted_id)
		return FALSE

	var/datum/overmap/dynamic/OE = get_overmap_location()

	var/text = "A distress beacon has been activated by [inserted_id.registered_name] at local sector co-ordinates [OE.x]/[OE.y]. No further information available."
	priority_announce(text, null, 'sound/effects/alert.ogg', sender_override = "Outpost Distress Beacon System", zlevel = 0)
	next_clicksound = world.time + DISTRESS_COOLDOWN
	return TRUE

/obj/machinery/power/planet_beacon/proc/get_overmap_location()
	var/datum/map_zone/our_zone = get_map_zone()
	for(var/datum/overmap/dynamic/OE in SSovermap.overmap_objects)
		if(!istype(OE))
			continue
		if(!OE.mapzone)
			continue
		if(OE.mapzone == our_zone)
			return OE

/obj/machinery/power/planet_beacon/proc/referesh_preservation()
	var/datum/overmap/dynamic/OE = get_overmap_location()
	if(OE && OE.planet) // If this isn't true, something's gone wrong
		OE.set_preservation(preserving)
