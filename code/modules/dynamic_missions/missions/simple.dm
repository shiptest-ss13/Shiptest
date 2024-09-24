/datum/dynamic_mission/simple
	name = "Item recovery"
	desc = "Retrive this thing for us and we will pay you"
	var/setpiece_poi
	var/setpiece_item
	var/required_item

/datum/dynamic_mission/simple/spawn_mission_setpiece(datum/overmap/dynamic/planet)
	for(var/obj/effect/landmark/mission_poi/mission_poi in planet.spawned_mission_pois)
		if(mission_poi.type == setpiece_poi)
			required_item =	spawn_bound(setpiece_item, mission_poi.loc, null, TRUE, TRUE)
			qdel(mission_poi)
			return
	CRASH("[src] was unable to find its required landmark")

/datum/dynamic_mission/simple/can_turn_in(atom/movable/item_to_check)
	if(item_to_check == required_item)
		return TRUE

