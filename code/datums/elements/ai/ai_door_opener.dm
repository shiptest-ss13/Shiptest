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
	if(source.client || source.stat != CONSCIOUS || !isobj(bumped))
		return
	var/obj/door = bumped
	if(door.density && door.ai_can_open(source) && !DOING_INTERACTION_WITH_TARGET(source, door))
		INVOKE_ASYNC(door, TYPE_PROC_REF(/obj, ai_open), source)
