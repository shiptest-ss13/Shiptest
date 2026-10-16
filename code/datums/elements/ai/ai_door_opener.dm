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
	else if(istype(bumped, /obj/machinery/door/airlock) || istype(bumped, /obj/machinery/door/window))
		var/obj/machinery/door/door = bumped
		if(door.density && !door.operating && !door.hasPower() && can_force(door) && !DOING_INTERACTION_WITH_TARGET(source, door))
			INVOKE_ASYNC(src, PROC_REF(force_unpowered_door), source, door)
	else if(istype(bumped, /obj/machinery/door/firedoor))
		var/obj/machinery/door/firedoor/firelock = bumped
		if(firelock.density && !firelock.welded && !firelock.operating && !DOING_INTERACTION_WITH_TARGET(source, firelock))
			INVOKE_ASYNC(src, PROC_REF(pry_firelock), source, firelock)

/datum/element/ai_door_opener/proc/pry_firelock(mob/living/source, obj/machinery/door/firedoor/firelock)
	if(firelock.is_holding_pressure() && !ai_fine_venting(source))
		return
	if(!do_after(source, 3 SECONDS, firelock))
		return
	if(!firelock.density || firelock.welded || firelock.operating || (firelock.is_holding_pressure() && !ai_fine_venting(source)))
		return // things changed while we were at it
	firelock.emergency_close_timer = world.time + 6 SECONDS // so it doesn't snap shut again instantly
	firelock.open()

// forcing an unpowered airlock or windoor open
/datum/element/ai_door_opener/proc/force_unpowered_door(mob/living/source, obj/machinery/door/door)
	if(!do_after(source, 2 SECONDS, door))
		return
	if(!door.density || door.operating || door.hasPower() || !can_force(door))
		return // things changed while we were at it
	door.open(2)

/datum/element/ai_door_opener/proc/can_force(obj/machinery/door/door)
	if(door.welded)
		return FALSE
	var/obj/machinery/door/airlock/airlock = door
	return !istype(airlock) || (!airlock.locked && !airlock.seal)
