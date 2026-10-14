/datum/mission/acquire/material
	desc = "Refined Material Bounty"

	blackbox_prefix = "Acquire "

	/// The type of container to be spawned when the mission is accepted.
	container_type = /obj/structure/material_crate
	/// Instance of the container, spawned after the mission is accepted.
	var/atom/movable/container

	///The item that this mission wants
	var/atom/movable/objective_type
	///How many of this item does the mission want?
	var/num_wanted = 1
	///Does this mission allow subtypes of objective_type to count to the total required?
	var/allow_subtypes = TRUE
	///Are stacks of objective_type counted individually?
	var/count_stacks = TRUE

/datum/mission/acquire/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc, obj/hangar_crate_spawner/cargo_belt)
	. = ..()
	if(isnull(cargo_belt))
		container = spawn_bound(container_type, accept_loc, VARSET_CALLBACK(src, container, null))
		stack_trace("[src] issued by [source_outpost] could not find cargo chute to send items down. Fell back to cargo console.")
	else
		container = spawn_bound(container_type, cargo_belt.loc, VARSET_CALLBACK(src, container, null))
	container.name += " ([capitalize(objective_type.name)])"

/datum/mission/acquire/Destroy()
	container = null
	return ..()

/datum/mission/acquire/can_complete()
	. = ..()
	if(!.)
		return
	var/obj/docking_port/mobile/cont_port = SSshuttle.get_containing_shuttle(container)
	return . && (current_num() >= num_wanted) && (cont_port?.current_ship == servant)

/datum/mission/acquire/get_progress_string()
	return "[current_num()]/[num_wanted]"

/datum/mission/acquire/get_progress_percent()
	if(!container)
		return 0
	else
		return current_num()/num_wanted

/datum/mission/acquire/turn_in()
	del_container()
	return ..()

/datum/mission/acquire/give_up()
	del_container()
	return ..()

/datum/mission/acquire/proc/current_num()
	if(!container)
		return 0
	var/num = 0
	for(var/target in container.contents)
		num += atom_effective_count(target)
		if(num >= num_wanted)
			return num
	return num

/datum/mission/acquire/proc/atom_effective_count(atom/movable/target)
	if(allow_subtypes ? !istype(target, objective_type) : target.type != objective_type)
		return 0
	if(count_stacks && istype(target, /obj/item/stack))
		var/obj/item/stack/target_stack = target
		return target_stack.amount
	return 1

/datum/mission/acquire/proc/del_container()
	var/turf/cont_loc = get_turf(container)
	for(var/atom/movable/target in container.contents)
		if(atom_effective_count(target))
			qdel(target)
		else
			target.forceMove(cont_loc)
	recall_bound(container)

/obj/structure/material_crate
