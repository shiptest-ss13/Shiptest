/datum/element/ai_door_opener

/datum/element/ai_door_opener/Attach(datum/target)
	. = ..()
	if(!ismob(target))
		return ELEMENT_INCOMPATIBLE
	ADD_TRAIT(target, TRAIT_AI_OPENS_DOORS, ELEMENT_TRAIT(type))
	RegisterSignal(target, COMSIG_MOVABLE_BUMP, PROC_REF(on_bump))

/datum/element/ai_door_opener/Detach(datum/source, ...)
	. = ..()
	REMOVE_TRAIT(source, TRAIT_AI_OPENS_DOORS, ELEMENT_TRAIT(type))
	UnregisterSignal(source, COMSIG_MOVABLE_BUMP)

/datum/element/ai_door_opener/proc/on_bump(mob/source, atom/bumped)
	SIGNAL_HANDLER
	if(source.client || source.stat != CONSCIOUS)
		return
	if(istype(bumped, /obj/structure/mineral_door))
		var/obj/structure/mineral_door/mineral_door = bumped
		if(mineral_door.anchored && !mineral_door.isSwitchingStates)
			INVOKE_ASYNC(mineral_door, TYPE_PROC_REF(/obj/structure/mineral_door, Open))
	else if(istype(bumped, /obj/structure/fence/door))
		var/obj/structure/fence/door/fence_door = bumped
		if(fence_door.density && fence_door.can_open(source))
			INVOKE_ASYNC(fence_door, TYPE_PROC_REF(/obj/structure/fence/door, toggle), source)
