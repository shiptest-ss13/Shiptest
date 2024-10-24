/obj/effect/landmark/mission_poi
	name = "mission poi"
	icon = 'icons/effects/mission_poi.dmi'
	icon_state = "side_thing"
	layer = LOW_LANDMARK_LAYER
	invisibility = INVISIBILITY_ABSTRACT
	var/use_count = 1
	///Assume the item we want is included in the map and we simple have to return it
	var/already_spawned = FALSE
	///Grabbed as apart of late init to ensure that the item of intrest cant move
	var/datum/weakref/prespawned_weakref
	///Only needed if you have multipe missiosn that would otherwise use the same poi's
	var/mission_index = null
	///Prefered over the passed one, used for varediting primarly.
	var/type_to_spawn

/obj/effect/landmark/mission_poi/Initialize(mapload)
	. = ..()
	if(mapload && isnull(mission_index))
		CRASH("[src] didnt have a mission index")
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
	if(!ispath(type_to_spawn))
		type_to_spawn = _type_to_spawn
	if(!ispath(type_to_spawn))
		CRASH("[src] didnt get passed a type.")
	if(already_spawned) //Search for the item
		item_of_interest = search_poi()
		if(!item_of_interest)
			CRASH("[src] is meant to have its item prespawned but could not find it on its tile.")
	else //Spawn the item
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
		if(istype(item_in_poi, type_to_spawn))
			return item_in_poi

/obj/effect/landmark/mission_poi/main
	name = "mission focus"
	icon_state = "main_thing"

/obj/effect/landmark/mission_poi/guard
	icon_state = "guard"

/obj/effect/landmark/mission_poi/remover

/obj/effect/landmark/mission_poi/remover/use_poi(_type_to_spawn)
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

