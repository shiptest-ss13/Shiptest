//This file codes a helper to inject a door opening ID into a simple_animal.
//The helper needs to be placed on top of the mob for it to give the door_id trait to the mob.
//When the mob dies, a door with an "id" variable that matches the mob's "door_id" component will open.
//This only works if the mob on the tile as the helper falls under simple_animal. If not you will need to change the target_type variable ont he helper itself.
//The helper is called "doordeath" in the mapper.

/datum/component/poddoor_on_death
	var/door_id = ""

/datum/component/poddoor_on_death/Initialize(door_id)
	src.door_id = door_id

/datum/component/poddoor_on_death/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOB_DEATH, .proc/open_doors)

/datum/component/poddoor_on_death/proc/open_doors()
	for(var/obj/machinery/door/poddoor/D in GLOB.machines)
		if(D.id == door_id)
			D.open()

/obj/effect/mapping_helpers/component_injector/doordeath
	name = "Monster Closet Helper"
	icon = 'icons/obj/balloons.dmi'
	icon_state = "syndballoon"
	component_type = /datum/component/poddoor_on_death
	var/door_id
	target_type = /mob/living/simple_animal

/obj/effect/mapping_helpers/component_injector/doordeath/build_args()
	if(!istext(door_id))
		CRASH("Invalid doorid passed")
	return list(component_type,door_id)
