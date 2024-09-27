/obj/effect/landmark/mission_poi/kill

/datum/mission/dynamic/kill
	name = null
	desc = null
	setpiece_poi = /obj/effect/landmark/mission_poi/kill
	var/mob/target_type = /mob/living/simple_animal/hostile/human/nanotrasen/elite
	setpiece_item = /obj/item/folder/documents/syndicate
	var/mob/required_target

/datum/mission/dynamic/kill/generate_mission_details()
	. = ..()
	if(!name)
		name = "[target_type::name] termination"
	if(!desc)
		desc = "Bounty for a high ranking [target_type::name] residing on this planet. They should have identifying dog tags"

/datum/mission/dynamic/kill/spawn_main_piece(obj/effect/landmark/mission_poi/mission_poi)
	required_target = set_bound(mission_poi.use_poi(setpiece_item), mission_poi.loc, null, FALSE, TRUE)
	RegisterSignal(required_target, COMSIG_MOB_DEATH, PROC_REF(on_target_death))

/datum/mission/dynamic/kill/proc/on_target_death(mob/living/target)
	SIGNAL_HANDLER
	required_item = new setpiece_item(target.loc)
	UnregisterSignal(target, COMSIG_MOB_DEATH)
	remove_bound(target)
	required_target = null
