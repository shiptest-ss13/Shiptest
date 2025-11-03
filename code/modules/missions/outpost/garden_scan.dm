/datum/mission/outpost/survey
	//incoming pr: scan 12 rocks
	desc = "Survey some features"

	weight = 0

	/// The type of scanner to be spawned when the mission is accepted.
	var/obj/item/survey_handheld/scanner_type
	/// Instance of the scanner, spawned after the mission is accepted.
	var/obj/item/survey_handheld/scanner

	var/atom/movable/objective_type
	var/num_wanted = 1
	var/allow_subtypes = FALSE
	var/count_stacks = TRUE

/datum/mission/outpost/survey/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	. = ..()
	scanner = spawn_bound(scanner_type, accept_loc, VARSET_CALLBACK(src, scanner, null))
	scanner.name += " ([capitalize(objective_type.name)])"
	scanner.scans_required = num_wanted
	scanner.scan_target = objective_type

/datum/mission/outpost/survey/Destroy()
	scanner = null
	return ..()

/datum/mission/outpost/survey/can_complete()
	. = ..()
	if(!.)
		return
	var/obj/docking_port/mobile/cont_port = SSshuttle.get_containing_shuttle(scanner)
	return . && (current_num() >= num_wanted) && (cont_port?.current_ship == servant)

/datum/mission/outpost/survey/get_progress_string()
	return "[current_num()]/[num_wanted]"

/datum/mission/outpost/survey/turn_in()
	recall_bound(scanner)
	return ..()

/datum/mission/outpost/survey/give_up()
	recall_bound(scanner)
	return ..()

/datum/mission/outpost/survey/proc/current_num()
	if(!scanner)
		return 0
	return scanner.scan_tally


//Survey: The heavens

/datum/mission/outpost/survey/garden
	name = ""
	desc = ""
	value = 1500
	weight = 10
	duration = 90 MINUTES
	scanner_type = /obj/item/survey_handheld
	objective_type = /obj/structure/flora/ash/garden
	num_wanted = 12
	var/danger_bonus = 50
	var/garden_string = "lush gardens"
	var/planet_hint ="Beach and Jungle"

/datum/mission/outpost/survey/garden/New(...)
	if(!name)
		name = "Survey [garden_string]"
	if(!desc)
		desc = "[SSmissions.get_researcher_name()] has requested that we conduct a survey on the worlds in [GLOB.station_name] and determine their suitablity for future colonization. \
		The first step of this process is analysis of local flora. Utilize the provided scanner to scan [num_wanted] botanical 'gardens' on nearby worlds. [capitalize(garden_string)] are usually found on [planet_hint]-class worlds."
	num_wanted = rand(num_wanted-4,num_wanted+2)
	value = rand(value*0.75, value*1.25) + (num_wanted*50)
	. = ..()

/datum/mission/outpost/survey/garden/waste
	value = 3000
	scanner_type = /obj/item/survey_handheld/advanced
	objective_type = /obj/structure/flora/ash/garden/waste
	weight = 4
	num_wanted = 6
	danger_bonus = 100
	garden_string = "sickly gardens"
	planet_hint = "Waste"

/datum/mission/outpost/survey/garden/ice
	value = 2000
	objective_type = /obj/structure/flora/ash/garden/frigid
	scanner_type = /obj/item/survey_handheld/advanced
	num_wanted = 6
	danger_bonus = 75
	garden_string = "chilly gardens"
	planet_hint = "Ice"

/datum/mission/outpost/survey/garden/arid
	value = 2000
	objective_type = /obj/structure/flora/ash/garden/arid
	scanner_type = /obj/item/survey_handheld/advanced
	num_wanted = 6
	danger_bonus = 75
	garden_string = "rock gardens"
	planet_hint = "Rock"

//Survey: we like chemicals

/datum/mission/outpost/survey/geyser
	name = "scan chemical geyser"
	desc = ""
	value = 2500
	objective_type = /obj/structure/geyser
	scanner_type = /obj/item/survey_handheld/elite
	duration = 90 MINUTES
	weight = 4

	num_wanted = 1

/datum/mission/outpost/survey/geyser/New(...)
	if(!desc)
		desc = "[SSmissions.get_researcher_name()] has requested that we locate and scan planetary geysers for potential investment into pharmacuticals within the system. Utilze the provided scanner to scan and record data on [num_wanted] geyser."
	. = ..()
