/datum/mission/acquire
	desc = "Get me some things."

	/// The type of container to be spawned when the mission is accepted.
	var/atom/movable/container_type
	/// Instance of the container, spawned after the mission is accepted.
	var/atom/movable/container

	var/atom/movable/desired_type
	var/num_wanted = 1
	var/allow_subtypes = TRUE
	var/count_stacks = TRUE

/datum/mission/acquire/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	. = ..()
	container = new container_type(accept_loc)
	do_sparks(3, FALSE, get_turf(container))
	RegisterSignal(container, COMSIG_PARENT_QDELETING, .proc/container_deleted)

/datum/mission/acquire/Destroy()
	. = ..()
	container = null

/datum/mission/acquire/proc/container_deleted()
	UnregisterSignal(container, COMSIG_PARENT_QDELETING)
	container = null

/datum/mission/acquire/is_failed()
	return ..() || (accepted && !container)

/datum/mission/acquire/is_complete()
	return ..() && (current_num() >= num_wanted)

/datum/mission/acquire/get_progress_string()
	return "[current_num()]/[num_wanted]"

/datum/mission/acquire/turn_in()
	do_sparks(3, FALSE, get_turf(container))
	for(var/A in container.contents)
		if(atom_effective_count(A))
			qdel(A)
	qdel(container)
	return ..()

/datum/mission/acquire/give_up()
	do_sparks(3, FALSE, get_turf(container))
	for(var/A in container.contents)
		if(atom_effective_count(A))
			qdel(A)
	qdel(container)
	return ..()

/datum/mission/acquire/proc/current_num()
	if(!container)
		return 0
	var/num = 0
	for(var/A in container.contents)
		num += atom_effective_count(A)
		if(num >= num_wanted)
			return num
	return num

/datum/mission/acquire/proc/atom_effective_count(atom/movable/A)
	if(allow_subtypes ? !istype(A, desired_type) : A.type != desired_type)
		return 0
	if(count_stacks && istype(A, /obj/item/stack))
		var/obj/item/stack/S = A
		return S.amount
	return 1





/datum/mission/acquire/goliath
	container_type = /obj/structure/closet/body_bag/bluespace
	desired_type = /mob/living/simple_animal/hostile/asteroid/goliath




