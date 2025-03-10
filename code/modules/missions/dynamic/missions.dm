/datum/mission/ruin/data_reterival
	name = "data recovery"
	desc = "We are looking for %MISSION_REQUIRED"
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
	name = "blackbox recovery"
	desc = "We lost communication with this planet. Investigate the planet, clear it of hostiles if you find any. Recover the lost logs from its blackbox recorder as proof of completion."
	setpiece_item = /obj/machinery/blackbox_recorder

