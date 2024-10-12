/datum/mission/dynamic
	var/setpiece_poi = /obj/effect/landmark/mission_poi/main
	var/setpiece_item
	///Specific item uses an exact item, if false it will allow type or any subtype
	var/specific_item = TRUE
	var/atom/movable/required_item

/datum/mission/dynamic/generate_mission_details()
	. = ..()
	setpiece_item = pick(setpiece_item)

/datum/mission/dynamic/spawn_mission_setpiece(datum/overmap/dynamic/planet)
	for(var/obj/effect/landmark/mission_poi/mission_poi in planet.spawned_mission_pois)
		if(mission_poi.type == setpiece_poi)
			//Spawns the item or gets it via use_poi then sets it as bound so the mission fails if its deleted
			spawn_main_piece(planet, mission_poi)
			return
	CRASH("[src] was unable to find its required landmark")

/datum/mission/dynamic/proc/spawn_main_piece(datum/overmap/dynamic/planet, obj/effect/landmark/mission_poi/mission_poi)
	required_item =	set_bound(mission_poi.use_poi(setpiece_item), mission_poi.loc, null, TRUE, TRUE)

/datum/mission/dynamic/can_turn_in(atom/movable/item_to_check)
	if(istype(required_item))
		if(specific_item)
			if(item_to_check == required_item)
				return TRUE
		else
			if(istype(item_to_check, required_item.type))
				return TRUE

/datum/mission/dynamic/data_reterival
	name = "data recovery"
	///Assumes its a list
	setpiece_item = list(
		/obj/item/blackbox,
		/obj/item/research_notes/loot
	)

/datum/mission/dynamic/data_reterival/generate_mission_details()
	. = ..()
	if(ispath(setpiece_item, /obj/item))
		var/obj/item/mission_item = setpiece_item
		desc = "We are looking for a [mission_item::name]"
