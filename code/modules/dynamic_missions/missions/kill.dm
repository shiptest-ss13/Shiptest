/obj/item/dog_tags
	name = "dog tags"
	icon_state = "skub"

/obj/effect/landmark/mission_poi/main/kill

/datum/mission/dynamic/kill
	name = null
	desc = null
	setpiece_poi = /obj/effect/landmark/mission_poi/main/kill
	setpiece_item
	var/mob/target_type
	var/mob/required_target

/datum/mission/dynamic/kill/generate_mission_details()
	. = ..()
	if(!name)
		name = "[target_type::name] termination"
	if(!desc)
		desc = "Bounty for a high ranking [target_type::name] residing on this planet. They should have identifying items"

/datum/mission/dynamic/kill/spawn_main_piece(obj/effect/landmark/mission_poi/mission_poi)
	required_target = set_bound(mission_poi.use_poi(target_type), null, FALSE, TRUE)
	RegisterSignal(required_target, COMSIG_MOB_DEATH, PROC_REF(on_target_death))

/datum/mission/dynamic/kill/proc/on_target_death(mob/living/target)
	SIGNAL_HANDLER

	required_item = new setpiece_item(target.loc)
	set_bound(required_item, null, FALSE, TRUE)
	UnregisterSignal(target, COMSIG_MOB_DEATH)
	remove_bound(target)
	required_target = null

/datum/mission/dynamic/kill/frontiersmen
	target_type = /mob/living/simple_animal/hostile/human/frontier/ranged/officer

/datum/mission/dynamic/kill/syndi_docs
	target_type = /mob/living/simple_animal/hostile/human/nanotrasen/elite
	setpiece_item = /obj/item/folder/documents/syndicate

/datum/mission/dynamic/kill/megafauna

/datum/mission/dynamic/kill/megafauna/generate_mission_details()
	target_type = pick(
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner,
		/mob/living/simple_animal/hostile/megafauna/claw,
	)
	. = ..()

/datum/mission/dynamic/kill/elite

/datum/mission/dynamic/kill/elite/generate_mission_details()
	target_type = pick(
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother,
		/mob/living/simple_animal/hostile/asteroid/elite/herald,
		/mob/living/simple_animal/hostile/asteroid/elite/legionnaire,
		/mob/living/simple_animal/hostile/asteroid/elite/pandora,
	)
	. = ..()
