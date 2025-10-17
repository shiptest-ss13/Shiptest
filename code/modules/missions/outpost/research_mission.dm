/datum/mission/outpost/research
	name = "Electrical storm research mission"
	desc = " requires data on the behavior of electrical storms in the system for an ongoing study. \
			Please anchor the attached sensor array to your ship and fly it through the storms. \
			It must be powered to collect the data. "
	value = 1850 // base value, before adding bonus for number of things to fly through
	duration = 90 MINUTES
	weight = 8

	var/datum/overmap/objective_type = /datum/overmap/event/electric
	var/obj/machinery/mission_scanner/scanner
	///how many storms have we flown through already
	var/num_current = 0
	///goal number of storms
	var/num_wanted = 5
	var/researcher_name
	///how much is a storm worth to fly through
	var/storm_value = 150

/datum/mission/outpost/research/New(...)
	researcher_name = SSmissions.get_researcher_name()
	num_wanted = rand(num_wanted - 2, num_wanted + 2)
	value += num_wanted * storm_value
	desc = "[researcher_name] [desc]"
	return ..()

/datum/mission/outpost/research/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	. = ..()
	scanner = spawn_bound(/obj/machinery/mission_scanner, accept_loc, VARSET_CALLBACK(src, scanner, null))
	RegisterSignal(servant, COMSIG_OVERMAP_MOVED, PROC_REF(ship_moved))

/datum/mission/outpost/research/Destroy()
	scanner = null
	return ..()

/datum/mission/outpost/research/turn_in()
	recall_bound(scanner)
	return ..()

/datum/mission/outpost/research/give_up()
	recall_bound(scanner)
	return ..()

/datum/mission/outpost/research/get_progress_string()
	return "[num_current]/[num_wanted]"

/datum/mission/outpost/research/can_complete()
	. = ..()
	if(!.)
		return
	var/obj/docking_port/mobile/scanner_port = SSshuttle.get_containing_shuttle(scanner)
	return . && (num_current >= num_wanted) && (scanner_port?.current_ship == servant)

/datum/mission/outpost/research/proc/ship_moved(datum/overmap/ship/controlled/ship, old_x, old_y)
	SIGNAL_HANDLER

	var/datum/overmap/over_obj
	var/obj/docking_port/mobile/scanner_port
	if(failed || (num_current >= num_wanted))
		return
	over_obj = locate(objective_type) in ship.current_overmap.overmap_container[ship.x][ship.y]
	scanner_port = SSshuttle.get_containing_shuttle(scanner)
	if(!over_obj || !scanner.is_operational || scanner_port?.current_ship != servant)
		return
	num_current++

/datum/mission/outpost/research/meteor
	name = "Asteroid field research mission"
	desc = "requires data on the behavior of asteroid fields in the system for an ongoing study. \
			Please anchor the attached sensor array to your ship and fly it through the fields. \
			It must be powered to collect the data."
	value = 1500
	storm_value = 200
	weight = 4
	objective_type = /datum/overmap/event/meteor

/datum/mission/outpost/research/carp
	name = "Carp migration research mission"
	desc = "requires data on the migration patterns of space carp for an ongoing study. \
			Please anchor the attached sensor array to your ship and fly it through the fields. \
			It must be powered to collect the data."
	value = 88
	storm_value = 150
	weight = 4
	num_wanted = 3
	objective_type = /datum/overmap/event/meteor/carp

/datum/mission/outpost/research/dust
	name = "dust research mission"
	desc = "requires data on the density of space dust for updated navcharts. \
			Please anchor the attached sensor array to your ship and fly it through the fields. \
			It must be powered to collect the data."
	value = 800
	storm_value = 150
	weight = 4
	objective_type = /datum/overmap/event/meteor/dust

/datum/mission/outpost/research/radstorm
	name = "Radiation storm field research mission"
	desc = "requires data on the behavior of radiation storms in the system for an ongoing study. \
			Please anchor the attached sensor array to your ship and fly it through the fields. \
			It must be powered to collect the data."
	value = 1500
	weight = 2
	storm_value = 100
	objective_type = /datum/overmap/event/rad
/*
/datum/mission/outpost/research/ion
	name = "Ion storm research mission"
	desc = "requires data on the behavior of electromagnetic storms in the system for an ongoing study. \
			Please anchor the attached sensor array to your ship and fly it through the storms. \
			It must be powered to collect the data."
	value = 2500
	weight = 2
	storm_value = 100
	objective_type = /datum/overmap/event/emp
*/
/datum/mission/outpost/research/flare
	name = "Solar flare field research mission"
	desc = "requires data on the behavior of solar flares in the system for an ongoing study. \
			Please anchor the attached sensor array to your ship and fly it through the fields. \
			It must be powered to collect the data."
	value = 2000
	storm_value = 200
	weight = 2
	objective_type = /datum/overmap/event/flare



/*
		Research mission scanning machine
*/

/obj/machinery/mission_scanner
	name = "polymodal sensor array"
	desc = "A complicated scanning device that integrates numerous sensors, commonly used \
			to detect and measure a wide variety of astrophysical phenomena."
	icon_state = "scanner_unanchor"
	max_integrity = 500
	density = FALSE
	anchored = FALSE
	use_power = NO_POWER_USE
	idle_power_usage = IDLE_DRAW_MEDIUM
	processing_flags = START_PROCESSING_MANUALLY

/obj/machinery/mission_scanner/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(!. && default_unfasten_wrench(user, I))
		return TRUE

/obj/machinery/mission_scanner/set_anchored(anchorvalue)
	. = ..()
	if(isnull(.))
		return
	density = anchorvalue
	if(anchorvalue)
		set_is_operational(TRUE)
		START_PROCESSING(SSmachines, src)
		set_idle_power()
	else
		set_is_operational(FALSE)
		STOP_PROCESSING(SSmachines, src)
		use_power = NO_POWER_USE
	power_change() // calls update_appearance(), makes sure we're powered

/obj/machinery/mission_scanner/update_appearance(updates)
	. = ..()
	if(is_operational)
		icon_state = "scanner_power"
	else if(anchored)
		icon_state = "scanner_depower"
	else
		icon_state = "scanner_unanchor"
