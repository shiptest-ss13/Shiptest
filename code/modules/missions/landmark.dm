#define VALID_POI_CONTAINERS list(/obj/structure/closet,/obj/structure/safe,/obj/structure/cabinet)

/obj/effect/landmark/mission_poi
	name = "mission poi"
	icon = 'icons/effects/mission_poi.dmi'
	icon_state = "side_thing"
	layer = LOW_LANDMARK_LAYER
	invisibility = INVISIBILITY_ABSTRACT
	var/use_count = 1
	///Assume the item we want is included in the map and we simple have to return it
	var/already_spawned = FALSE
	///if the object we're looking for is in a certain kind of container that we need to look for
	var/object_container
	///Grabbed as apart of late init to ensure that the item of intrest cant move
	var/datum/weakref/prespawned_weakref
	///Only needed if you have multipe missiosn that would otherwise use the same poi's
	var/mission_index = 1
	///Prefered over the passed one, used for varediting primarly.
	var/type_to_spawn
	///checks for containters on the turf for this to put into, or if prespawned check container for the object
	var/spawn_in_containter = FALSE


/obj/effect/landmark/mission_poi/Initialize(mapload)
	. = ..()
	if(mapload && isnull(mission_index))
		NOTICE("[src] didnt have a mission index")
	SSmissions.unallocated_pois += list(src)
	if(already_spawned && type_to_spawn)
		var/atom/item_of_interest = search_poi()
		prespawned_weakref = WEAKREF(item_of_interest)

/obj/effect/landmark/mission_poi/LateInitialize()
	. = ..()
	if(!prespawned_weakref && already_spawned && type_to_spawn)
		var/atom/item_of_interest = search_poi()
		prespawned_weakref = WEAKREF(item_of_interest)

/obj/effect/landmark/mission_poi/Destroy()
	SSmissions.unallocated_pois -= src
	. = ..()

/obj/effect/landmark/mission_poi/proc/use_poi(_type_to_spawn, datum/mission/mission)
	var/atom/item_of_interest
	use_count--
	log_world("[src] was used for [mission.name]!")
	if(!ispath(type_to_spawn))
		type_to_spawn = _type_to_spawn
	if(!ispath(type_to_spawn))
		CRASH("[src] didnt get passed a type.")
	if(already_spawned) //Search for the item
		item_of_interest = search_poi()
		if(!item_of_interest)
			CRASH("[src] is meant to have its item prespawned but could not find it on its tile.")
	else if(spawn_in_containter)//Spawn the item
		var/poi_container = get_container()
		if(poi_container)
			item_of_interest = new type_to_spawn(poi_container)
		else
			CRASH("[src] is meant to have a container to be spawn inside but could not find one on its tile.")
	else
		item_of_interest = new type_to_spawn(loc)
	// We dont have an item to return
	if(!istype(item_of_interest))
		CRASH("[src] did not return a item_of_interest")
	item_of_interest.AddComponent(/datum/component/mission_important, MISSION_IMPORTANCE_RELEVENT, mission)
	return item_of_interest

/obj/effect/landmark/mission_poi/proc/search_poi()
	if(isweakref(prespawned_weakref))
		var/atom/prespawned_item = prespawned_weakref.resolve()
		if(istype(prespawned_item, type_to_spawn))
			return prespawned_item
	for(var/atom/movable/item_in_poi as anything in get_turf(src))
		if(spawn_in_containter)
			if(is_type_in_list(item_in_poi, VALID_POI_CONTAINERS))
				for(var/atom/movable/item_in_container as anything in item_in_poi.contents)
					if(istype(item_in_container, type_to_spawn))
						return item_in_container
		else if(istype(item_in_poi, type_to_spawn))
			return item_in_poi

/*
/obj/effect/landmark/mission_poi/proc/valid_item(_item, _type)
	if(istype(_item, _type))
		return TRUE
*/

/obj/effect/landmark/mission_poi/proc/get_container()
	for(var/atom/movable/container as anything in get_turf(src))
		if(is_type_in_list(container,VALID_POI_CONTAINERS))
			return container

/obj/effect/landmark/mission_poi/main
	name = "mission focus"
	icon_state = "main_thing"

/obj/effect/landmark/mission_poi/guard
	name = "mission guard spawner"
	icon_state = "guard"

/obj/effect/landmark/mission_poi/remover
	name = "mission obj remover"

/obj/effect/landmark/mission_poi/remover/use_poi(_type_to_spawn, datum/mission/mission)
	if(!ispath(type_to_spawn))
		type_to_spawn = _type_to_spawn
	if(!ispath(type_to_spawn))
		stack_trace("[src] didnt get passed a type.")
	if(already_spawned) //Search for the item
		for(var/atom/movable/item_in_poi as anything in get_turf(src))
			if(istype(item_in_poi, type_to_spawn))
				qdel(item_in_poi)
				return
	stack_trace("[src] didnt remove anything somehow")

/obj/effect/landmark/mission_poi/relevent
	name = "mission releventor"

/obj/effect/landmark/mission_poi/relevent/use_poi(_type_to_spawn, datum/mission/mission)
	if(!ispath(type_to_spawn))
		type_to_spawn = _type_to_spawn
	if(!ispath(type_to_spawn))
		stack_trace("[src] didnt get passed a type.")
	if(already_spawned) //Search for the item
		for(var/atom/movable/item_in_poi as anything in get_turf(src))
			if(istype(item_in_poi, type_to_spawn))
				item_in_poi.AddComponent(/datum/component/mission_important, MISSION_IMPORTANCE_RELEVENT, mission)
				return
	stack_trace("[src] didnt mark anything somehow")
