/obj/effect/landmark/mission_poi/guard
	icon_state = "guard"

/datum/mission/dynamic/simple/guarded
	name = "Item recovery(with friends)"
	desc = "Kill some guys and take there thingy"
	var/guard_poi = /obj/effect/landmark/mission_poi/guard
	var/guard_type
	var/list/mob/guard_list

/datum/mission/dynamic/simple/guarded/spawn_mission_setpiece(datum/overmap/dynamic/planet)
	for(var/obj/effect/landmark/mission_poi/mission_poi in planet.spawned_mission_pois)
		if(mission_name && (mission_name != mission_poi.mission_name))
			continue
		if((!required_item) && mission_poi.type == setpiece_poi)
			//Spawns the item or gets it via use_poi then sets it as bound so the mission fails if its deleted
			required_item =	set_bound(mission_poi.use_poi(setpiece_item), mission_poi.loc, null, TRUE, TRUE)
		if(mission_poi.type == guard_poi)
			guard_list += list(spawn_guard(mission_poi))
	if(!required_item)
		CRASH("[src] was unable to find its required landmark")

/datum/mission/dynamic/simple/guarded/proc/spawn_guard(obj/effect/landmark/mission_poi/guard_poi)
	var/guard = guard_poi.use_poi(guard_type)
	return guard
