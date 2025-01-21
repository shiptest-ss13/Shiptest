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
	desc = "Recover some lost logs from this ruin's blackbox recorder."
	setpiece_item = /obj/machinery/blackbox_recorder

/datum/mission/ruin/nt_files
	name = "NT asset recovery"
	desc = "Look- long story short, I need this folder retrieved. You don't ask why, I make sure you get paid."
	value = 1250
	mission_reward = list(
		/obj/item/gun/energy/e_gun/old,
		/obj/item/gun/energy/laser/retro,
	)
	faction = /datum/faction/nt
	setpiece_item = /obj/item/documents/nanotrasen

/datum/mission/ruin/nt_files/generate_mission_details()
	. = ..()
	author = "Captain [random_species_name()]"

