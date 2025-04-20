/datum/mission/outpost/acquire
	desc = "Get me some things."

	/// The type of container to be spawned when the mission is accepted.
	var/atom/movable/container_type
	/// Instance of the container, spawned after the mission is accepted.
	var/atom/movable/container

	var/atom/movable/objective_type
	var/num_wanted = 1
	var/allow_subtypes = TRUE
	var/count_stacks = TRUE

/datum/mission/outpost/acquire/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	. = ..()
	container = spawn_bound(container_type, accept_loc, VARSET_CALLBACK(src, container, null))
	container.name += " ([capitalize(objective_type.name)])"

/datum/mission/outpost/acquire/Destroy()
	container = null
	return ..()

/datum/mission/outpost/acquire/can_complete()
	. = ..()
	if(!.)
		return
	var/obj/docking_port/mobile/cont_port = SSshuttle.get_containing_shuttle(container)
	return . && (current_num() >= num_wanted) && (cont_port?.current_ship == servant)

/datum/mission/outpost/acquire/get_progress_string()
	return "[current_num()]/[num_wanted]"

/datum/mission/outpost/acquire/turn_in()
	del_container()
	return ..()

/datum/mission/outpost/acquire/give_up()
	del_container()
	return ..()

/datum/mission/outpost/acquire/proc/current_num()
	if(!container)
		return 0
	var/num = 0
	for(var/target in container.contents)
		num += atom_effective_count(target)
		if(num >= num_wanted)
			return num
	return num

/datum/mission/outpost/acquire/proc/atom_effective_count(atom/movable/target)
	if(allow_subtypes ? !istype(target, objective_type) : target.type != objective_type)
		return 0
	if(count_stacks && istype(target, /obj/item/stack))
		var/obj/item/stack/target_stack = target
		return target_stack.amount
	return 1

/datum/mission/outpost/acquire/proc/del_container()
	var/turf/cont_loc = get_turf(container)
	for(var/atom/movable/target in container.contents)
		if(atom_effective_count(target))
			qdel(target)
		else
			target.forceMove(cont_loc)
	recall_bound(container)

/*
		Acquire: The Creature
*/

/datum/mission/outpost/acquire/creature
	name = ""
	desc = ""
	value = 1500
	duration = 60 MINUTES
	weight = 6
	container_type = /obj/structure/closet/mob_capture
	objective_type = /mob/living/simple_animal/hostile/asteroid/goliath
	num_wanted = 1
	count_stacks = FALSE
	var/creature_name = "goliath"

/datum/mission/outpost/acquire/creature/New(...)
	if(!name)
		name = "Capture a [creature_name]"
	if(!desc)
		desc = "I require a live [creature_name] for research purposes. Trap one within the given \
				Lifeform Containment Unit and return it to me and you will be paid handsomely."
	. = ..()

/datum/mission/outpost/acquire/creature/atom_effective_count(atom/movable/target)
	. = ..()
	if(!.)
		return
	var/mob/creature = target
	if(creature.stat == DEAD)
		return 0

/datum/mission/outpost/acquire/creature/legion
	value = 1300
	objective_type = /mob/living/simple_animal/hostile/asteroid/hivelord/legion
	creature_name = "legion"

/datum/mission/outpost/acquire/creature/ice_whelp
	value = 1700
	weight = 2
	objective_type = /mob/living/simple_animal/hostile/asteroid/ice_whelp
	creature_name = "ice whelp"

/datum/mission/outpost/acquire/creature/migo
	value = 1050
	weight = 2
	objective_type = /mob/living/simple_animal/hostile/netherworld/migo/asteroid
	creature_name = "mi-go"

/*
		Acquiry mission containers
*/
/obj/structure/closet/mob_capture
	name = "\improper Lifeform Containment Unit"
	desc = "A large closet-like container, used to capture hostile lifeforms for retrieval and analysis. The interior is heavily armored, preventing animals from breaking out while inside."
	icon_state = "abductor"
	icon_door = "abductor"
	color = "#FF88FF"
	drag_slowdown = 1
	max_integrity = 300
	armor = list("melee" = 50, "bullet" = 10, "laser" = 10, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 30, "fire" = 80, "acid" = 70)
	mob_storage_capacity = 1
	max_mob_size = MOB_SIZE_LARGE
	anchorable = FALSE
	can_weld_shut = FALSE

/obj/structure/closet/mob_capture/attack_animal(mob/living/simple_animal/M)
	if(M.loc == src)
		return FALSE
	return ..()
