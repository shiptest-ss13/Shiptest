/obj/effect/landmark/mission_poi/guard
	icon_state = "guard"

/datum/mission/dynamic/guarded
	name = "item recovery(with friends)"
	desc = "Kill some guys and take there thingy"
	var/guard_poi = /obj/effect/landmark/mission_poi/guard
	var/guard_type
	var/list/mob/guard_list

/datum/mission/dynamic/guarded/spawn_mission_setpiece(datum/overmap/dynamic/planet)
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

/datum/mission/dynamic/guarded/proc/spawn_guard(obj/effect/landmark/mission_poi/guard_poi)
	var/guard = guard_poi.use_poi(guard_type)
	return guard

/datum/mission/dynamic/guarded/nt_files
	name = "NT asset recovery"
	faction = /datum/faction/nt
	setpiece_item = /obj/item/documents/nanotrasen
	guard_type = /mob/living/simple_animal/hostile/human/syndicate/melee

/datum/mission/dynamic/guarded/nt_files/generate_mission_details()
	. = ..()
	name = pick("NT asset recovery", "Asset recovery requested ASAP")
	author = "Captain [random_species_name()]"
	desc = pick("Look- long story short, I need this folder retrieved. You don't ask why, I make sure you get paid.")

/datum/mission/dynamic/guarded/nt_files/spawn_guard(obj/effect/landmark/mission_poi/guard_poi)
	guard_type = pick(/mob/living/simple_animal/hostile/human/syndicate/melee, /mob/living/simple_animal/hostile/human/syndicate/ranged)
	var/guard = guard_poi.use_poi(guard_type)
	return guard
