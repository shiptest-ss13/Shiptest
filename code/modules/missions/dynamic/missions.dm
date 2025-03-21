/datum/mission/ruin/data_retrieval
	name = "Data Recovery"
	desc = "We would like %MISSION_REQUIRED retrieved from a site of interest."
	mission_limit = 2
	setpiece_item = list(
		/obj/item/research_notes/loot,
		/obj/item/documents
	)

/obj/effect/landmark/mission_poi/main/blackbox
	icon_state = "main_blackbox"
	already_spawned = TRUE

/obj/effect/landmark/mission_poi/main/blackbox/use_poi(_type_to_spawn)
	var/obj/machinery/blackbox_recorder/recorder = ..()
	if(istype(recorder, /obj/machinery/blackbox_recorder))
		if(istype(recorder.stored, /obj/item/blackbox))
			return recorder.stored

/datum/mission/ruin/blackbox
	name = "Blackbox Recovery"
	desc = "Communication has recently been lost with this world. Investigate the site, engage hostiles at your discretion, and recover the %MISSION_REQUIRED so we can plan a course of action."
	mission_limit = 2
	setpiece_item = /obj/machinery/blackbox_recorder

