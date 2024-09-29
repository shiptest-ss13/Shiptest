/datum/mission/dynamic/simple
	setpiece_poi = /obj/effect/landmark/mission_poi/recovery

/datum/mission/dynamic/simple/spawn_mission_setpiece(datum/overmap/dynamic/planet)
	for(var/obj/effect/landmark/mission_poi/mission_poi in planet.spawned_mission_pois)
		if(mission_poi.type == setpiece_poi)
			//Spawns the item or gets it via use_poi then sets it as bound so the mission fails if its deleted
			required_item =	set_bound(mission_poi.use_poi(setpiece_item), mission_poi.loc, null, TRUE, TRUE)
			return
	CRASH("[src] was unable to find its required landmark")

/datum/mission/dynamic/simple/can_turn_in(atom/movable/item_to_check)
	if(istype(required_item))
		if(specific_item)
			if(item_to_check == required_item)
				return TRUE
		else
			if(istype(item_to_check, required_item.type))
				return TRUE
