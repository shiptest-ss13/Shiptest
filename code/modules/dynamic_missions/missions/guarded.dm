/obj/effect/landmark/mission_poi/guard

/datum/dynamic_mission/simple/guarded
	name = "Item recovery(with friends)"
	desc = "Kill some guys and take there thingy"
	var/guard_poi = /obj/effect/landmark/mission_poi/guard
	var/guard_type
	var/list/mob/guard_list

/datum/dynamic_mission/simple/guarded/spawn_mission_setpiece(datum/overmap/dynamic/planet)
	for(var/obj/effect/landmark/mission_poi/mission_poi in planet.spawned_mission_pois)
		if((!required_item) && mission_poi.type == setpiece_poi)
			required_item = new setpiece_item(mission_poi.loc)
			RegisterSignal(required_item, COMSIG_PARENT_QDELETING, PROC_REF(on_vital_delete))
			qdel(mission_poi)
		if(mission_poi.type == guard_poi)
			guard_list += list(spawn_guard(mission_poi))

	if(!required_item)
		CRASH("[src] was unable to find its required landmark")

/datum/dynamic_mission/simple/guarded/spawn_guard(obj/effect/landmark/mission_poi/guard_poi)
	var/guard = new guard_type(guard_poi.loc)
	qdel(guard_poi)
	return guard
