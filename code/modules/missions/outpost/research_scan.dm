/datum/mission/survey
	//incoming pr: scan 12 rocks
	desc = "Survey some features"

	weight = 0

	/// The type of scanner to be spawned when the mission is accepted.
	var/obj/item/survey_handheld/scanner_type
	/// Instance of the scanner, spawned after the mission is accepted.
	var/obj/item/survey_handheld/scanner

	var/atom/movable/objective_type
	var/num_wanted = 1

/datum/mission/survey/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc, obj/hangar_crate_spawner/cargo_belt)
	. = ..()
	scanner = spawn_bound(scanner_type, accept_loc, VARSET_CALLBACK(src, scanner, null))
	scanner.name += " ([capitalize(objective_type.name)])"
	scanner.scans_required = num_wanted
	scanner.scan_target = objective_type

/datum/mission/survey/Destroy()
	scanner = null
	return ..()

/datum/mission/survey/can_complete()
	. = ..()
	if(!.)
		return
	var/obj/docking_port/mobile/cont_port = SSshuttle.get_containing_shuttle(scanner)
	return . && (current_num() >= num_wanted) && (cont_port?.current_ship == servant)

/datum/mission/survey/get_progress_string()
	return "[current_num()]/[num_wanted]"

/datum/mission/survey/get_progress_percent()
	if(!scanner)
		return 0
	return current_num()/num_wanted


/datum/mission/survey/turn_in()
	recall_bound(scanner)
	return ..()

/datum/mission/survey/give_up()
	recall_bound(scanner)
	return ..()

/datum/mission/survey/proc/current_num()
	if(!scanner)
		return 0
	return scanner.scan_tally


//Survey: The heavens

/datum/mission/survey/garden
	name = ""
	desc = ""
	value = 1500
	weight = 10
	scanner_type = /obj/item/survey_handheld
	objective_type = /obj/structure/flora/ash/garden
	num_wanted = 12
	var/garden_string = "lush gardens"
	var/planet_hint ="Beach and Jungle"

/datum/mission/survey/garden/New(...)
	num_wanted = rand(num_wanted-4,num_wanted+2)
	if(!name)
		name = "Survey [garden_string]"
	if(!desc)
		desc = "[SSmissions.get_researcher_name()] has requested that we conduct a survey on the worlds in [GLOB.station_name] and determine their suitablity for future colonization. \
		The first step of this process is analysis of local flora. Utilize the provided scanner to scan [num_wanted] botanical 'gardens' on nearby worlds. [capitalize(garden_string)] are usually found on [planet_hint]-class worlds."

	value = rand(value*0.75, value*1.25) + (num_wanted*50)
	. = ..()

/datum/mission/survey/garden/waste
	value = 3000
	scanner_type = /obj/item/survey_handheld/advanced
	objective_type = /obj/structure/flora/ash/garden/waste
	weight = 4
	num_wanted = 6
	garden_string = "sickly gardens"
	planet_hint = "Waste"

/datum/mission/survey/garden/ice
	value = 2000
	objective_type = /obj/structure/flora/ash/garden/frigid
	scanner_type = /obj/item/survey_handheld/advanced
	num_wanted = 6
	garden_string = "chilly gardens"
	planet_hint = "Ice"

/datum/mission/survey/garden/arid
	value = 2000
	objective_type = /obj/structure/flora/ash/garden/arid
	scanner_type = /obj/item/survey_handheld/advanced
	num_wanted = 6
	garden_string = "rock gardens"
	planet_hint = "Rock"

//Survey: we like chemicals

/datum/mission/survey/geyser
	name = "scan chemical geyser"
	desc = ""
	value = 2500
	objective_type = /obj/structure/geyser
	scanner_type = /obj/item/survey_handheld/elite
	weight = 4

	num_wanted = 1

/datum/mission/survey/geyser/New(...)
	if(!desc)
		desc = "[SSmissions.get_researcher_name()] has requested that we locate and scan planetary geysers for potential investment into pharmacuticals within the system. Utilze the provided scanner to scan and record data on [num_wanted] geyser."
	. = ..()

/datum/mission/survey/anomaly
	name = ""
	desc = ""
	value = 3000
	weight = 4
	scanner_type = /obj/item/survey_handheld/elite
	objective_type = /obj/effect/anomaly
	num_wanted = 2

/datum/mission/survey/anomaly/New(...)
	num_wanted = rand(num_wanted-1,num_wanted+1)
	if(!name)
		name = "Scan Anomaly"
	if(!desc)
		desc = "Anomaly manifestation is on the rise in this area of space,  and [SSmissions.get_researcher_name()] has placed a bounty for the scanning of in-place anomaly fields. \
		Locate an anomaly and use the provided scanner to analyze active wavelengths in the area of manifestation."

	value = rand(value*0.75, value*1.25) + (num_wanted*2000)
	. = ..()
