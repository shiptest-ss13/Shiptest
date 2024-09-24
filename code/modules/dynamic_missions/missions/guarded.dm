/obj/effect/landmark/mission_poi/guard
	icon_state = "guard"

/datum/dynamic_mission/simple/guarded
	name = "Item recovery(with friends)"
	desc = "Kill some guys and take there thingy"
	var/guard_poi = /obj/effect/landmark/mission_poi/guard
	var/guard_type
	var/list/mob/guard_list

/datum/dynamic_mission/simple/guarded/spawn_mission_setpiece(datum/overmap/dynamic/planet)
	for(var/obj/effect/landmark/mission_poi/mission_poi in planet.spawned_mission_pois)
		if((!required_item) && mission_poi.type == setpiece_poi)
			required_item =	spawn_bound(setpiece_item, mission_poi.loc, null, TRUE, TRUE)
			qdel(mission_poi)
		if(mission_poi.type == guard_poi)
			guard_list += list(spawn_guard(mission_poi))

	if(!required_item)
		CRASH("[src] was unable to find its required landmark")

/datum/dynamic_mission/simple/guarded/proc/spawn_guard(obj/effect/landmark/mission_poi/guard_poi)
	var/guard = new guard_type(guard_poi.loc)
	qdel(guard_poi)
	return guard
