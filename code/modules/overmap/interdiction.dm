#define INTERDICTION_CHARGEUP 15 SECONDS
#define INTERDICTION_SPEED_DIFF_MAX 10
#define INTERDICTION_COOLDOWN_START 1 MINUTES
#define INTERDICTION_COOLDOWN_VICTIM 20 SECONDS


/obj/machinery/computer/interdiction
	name = "interdiction control"
	desc = "Used to attempt interdiction on a nearby ship."
	icon_screen = "navigation"
	icon_keyboard = "tech_key"
	circuit = /obj/item/circuitboard/computer/interdiction
	light_color = LIGHT_COLOR_FLARE
	clicksound = null

	var/datum/overmap/ship/controlled/current_ship
	var/datum/overmap/ship/controlled/interdicting


	var/cur_timer
	var/datum/beam/tether
	var/range = 2
	var/tether_target_time

/obj/machinery/computer/interdiction/Destroy()
	end_interdiction()
	current_ship = null
	if(cur_timer)
		deltimer(cur_timer)
	return ..()

/obj/machinery/computer/interdiction/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	current_ship = port.current_ship

/obj/machinery/computer/interdiction/proc/scan_for_targets()
	. = list()
	for(var/obj/overmap/token in orange(range, current_ship.token))
		if(!istype(token.parent, /datum/overmap/ship/controlled))
			continue
		var/datum/overmap/ship/controlled/possible = token.parent
		if(!COOLDOWN_FINISHED(possible, interdiction_cooldown))
			continue // to prevent three or more ships just constantly bullying someone
		if(get_dist(token, current_ship.token) > range)
			continue
		if(abs(current_ship.get_speed() - possible.get_speed()) > INTERDICTION_SPEED_DIFF_MAX)
			continue
		. += possible

/obj/machinery/computer/interdiction/attack_hand(mob/living/user)
	if(!Adjacent(user))
		return
	if(!istype(user))
		return

	user.changeNext_move(CLICK_CD_RAPID)
	if(!can_interact(user))
		say("Access denied.")
		return

	if(interdicting)
		say("Interdiction is already in effect, and cannot be canceled manually.")
		return

	if(!COOLDOWN_FINISHED(current_ship, interdiction_cooldown))
		say("Interdiction array is still cooling down. ETA: [COOLDOWN_TIMELEFT(current_ship, interdiction_cooldown)]")
		return

	var/list/targets = sortList(scan_for_targets(), .proc/cmp_ship_dist)
	var/list/list_targets = list()
	for(var/datum/overmap/ship/controlled/target as anything in targets)
		list_targets["[get_dist(current_ship.token, target.token)] - [target]"] = target

	var/datum/overmap/ship/controlled/selection = tgui_input_list(user, "Select Target", "Interdiction", list_targets, 10 SECONDS)
	if(!selection || !(selection in list_targets))
		return
	selection = list_targets[selection]

	message_admins("[ADMIN_LOOKUPFLW(user)] has begun interdiction! [current_ship]([ADMIN_JMP(current_ship.token)]) -> [selection]([ADMIN_JMP(selection.token)])")
	start_interdiction(user, selection)
	COOLDOWN_START(current_ship, interdiction_cooldown, INTERDICTION_COOLDOWN_START)

/obj/machinery/computer/interdiction/proc/announce_to_ships(message)
	for(var/v_z as anything in list(interdicting.shuttle_port.virtual_z(), current_ship.shuttle_port.virtual_z()))
		priority_announce(message, "Interdiction Notice", 'sound/misc/announce.ogg', "interdiction", "Interdiction ([current_ship])", zlevel=v_z)

/obj/machinery/computer/interdiction/proc/cmp_ship_dist(datum/overmap/t1, datum/overmap/t2)
	return cmp_numeric_asc(get_dist(current_ship.token, t1.token), get_dist(current_ship.token, t2.token))

/obj/machinery/computer/interdiction/proc/throw_ship_contents(datum/overmap/ship/controlled/target, dir, strength)
	for(var/area/area as anything in target.shuttle_port.shuttle_areas)
		for(var/atom/movable/movable in area)
			var/turf/target_turf = get_edge_target_turf(movable, dir)
			movable.throw_at(target_turf, 2 * strength, strength)

/obj/machinery/computer/interdiction/proc/get_target_range()
	. = get_dist(current_ship.token, interdicting.token)

/obj/machinery/computer/interdiction/proc/start_interdiction(mob/user, datum/overmap/ship/controlled/target)
	interdicting = target
	interdicting.interdictor = current_ship

	announce_to_ships("Interdiction Tether Engaged. ETA: [DisplayTimeText(INTERDICTION_CHARGEUP)]")
	target.announce_to_helms("Interdiction Tether detected; Attempt to escape enemy range or cause their tether to slip by increasing difference in ship speeds!")
	current_ship.announce_to_helms("Interdiction Tether launched; Attempt to close distance to and match speed of enemy ship!")

	tether = target.token.Beam(current_ship.token, time=INFINITY)
	tether_target_time = world.time + INTERDICTION_CHARGEUP
	start_interdiction_callback()

/obj/machinery/computer/interdiction/proc/start_interdiction_callback()
	if(QDELETED(src))
		return

	if(!is_operational)
		announce_to_ships("Interdiction Tether operational failure.")
		return end_interdiction()

	if(!powered())
		announce_to_ships("Interdiction Tether power failure.")
		return end_interdiction()

	if(get_target_range() < range)
		announce_to_ships("Target out of range, Interdiction Tether dissipating.")
		return end_interdiction()

	var/speed_diff = abs(current_ship.get_speed() - interdicting.get_speed())
	if(speed_diff > INTERDICTION_SPEED_DIFF_MAX)
		announce_to_ships("Target speed difference too great, Interdiction Tether dissipating.")
		return end_interdiction()

	if(tether_target_time >= world.time)
		announce_to_ships("Target locked, Interdiction Tether engaged!")
		return do_interdiction()

	cur_timer = addtimer(CALLBACK(src, .proc/start_interdiction_callback), min(1, INTERDICTION_CHARGEUP * 0.2), TIMER_STOPPABLE|TIMER_UNIQUE|TIMER_OVERRIDE)

	var/state_us
	var/state_them
	var/speed_us = round(current_ship.get_speed(), 0.1)
	var/speed_them = round(interdicting.get_speed(), 0.1)
	var/speed_diff_large = abs(speed_us - speed_them) > 10
	if(speed_us == speed_them)
		state_us = state_them = "the same speed"
	else if(speed_us > speed_them)
		state_them = (speed_diff_large ? "much faster" : "slightly faster")
		state_us = (speed_diff_large ? "much slower" : "slightly slower")
	else
		state_them = (speed_diff_large ? "much slower" : "slightly slower")
		state_us = (speed_diff_large ? "much faster" : "slightly faster")

	var/t_range = get_target_range()

	var/msg_base = "Interdiction update: They are"
	interdicting.announce_to_helms("[msg_base] [state_them] than us! Range is [t_range] sectors. ETA: [DisplayTimeText(tether_target_time - world.time)]")

/obj/machinery/computer/interdiction/proc/do_interdiction(mob/user, datum/overmap/ship/controlled/target)
	// Calculate the speed differental
	var/speed_diff = abs(target.get_speed() - current_ship.get_speed())
	var/speed_mult = 1 + (get_target_range() * 0.1) // every additional tile is 10% more speed penalty, launching a tether from range is dangerous
	var/effective_penalty = speed_diff * speed_mult

	// Create the interdiction event and immediatly dock the target
	var/old_is = target.token.icon_state
	target.token.icon_state = null // this is done to prevent any visible lag time where it looks like their ship just isnt doing anything
	var/datum/overmap/dynamic/empty/point = new(list("x" = target.x, "y" = target.y)) // TODO: dedicated interdiction subtype, docks literally next to each other
	target.Dock(point, force=TRUE)
	target.token.icon_state = old_is

	// I want the aggressor to take 66% of the force damage, to really penalize for not managing your speed properly
	var/our_strength = effective_penalty * 0.66
	var/their_strength = effective_penalty * 0.33
	throw_ship_contents(current_ship, current_ship.get_heading(), our_strength)
	throw_ship_contents(interdicting, target.get_heading(), their_strength)

	// remove the old beam and make a new one
	qdel(tether)
	tether = point.token.Beam(current_ship.token, time=INFINITY)

	// pull the aggressor towards the interdiction point by half the speed diff
	// This exists to not penalize poor speed management too hard
	current_ship.accelerate(current_ship.get_heading(), speed_diff * 0.5)

/obj/machinery/computer/interdiction/proc/end_interdiction()
	deltimer(cur_timer)
	if(interdicting)
		interdicting.interdictor = null
		interdicting = null
		COOLDOWN_START(interdicting, interdiction_cooldown, INTERDICTION_COOLDOWN_VICTIM)
	if(tether)
		QDEL_NULL(tether)
