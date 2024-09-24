
/datum/component/mission_poi


/obj/effect/landmark/mission_poi
	linked_mission
	var/setpieces

/obj/effect/landmark/mission_poi/Initialize
	// Needs to see if its a target of a mission then connect itself and the things it spawns to it
	if("is_target_of_a_mission")
	var/set_piece = p
	qdel(src)
/obj/effect/landmark/mission_poi/drill
	var/setpieces = list(/obj/structure/vein)
