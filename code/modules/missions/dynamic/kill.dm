/obj/item/dog_tags
	name = "dog tags"
	icon_state = "skub"

/obj/effect/landmark/mission_poi/main/kill

/datum/mission/dynamic/signaled/kill
	name = "%MISSION_TARGET termination"
	desc = "Bounty for a high ranking %MISSION_TARGET residing on this planet. They should have identifying dogtags."
	setpiece_poi = /obj/effect/landmark/mission_poi/main/kill
	setpiece_item = /obj/item/dog_tags
	mission_main_signal = COMSIG_MOB_DEATH

/datum/mission/dynamic/signaled/kill/generate_mission_details()
	. = ..()
	registered_type = pick(registered_type)

/datum/mission/dynamic/signaled/kill/mission_regexs(mission_string)
	mission_string = ..()
	if(ispath(registered_type))
		var/atom/target = registered_type
		mission_string = replacetext(mission_string, "%MISSION_TARGET", "[target::name]")
	return mission_string

/datum/mission/dynamic/signaled/kill/frontiersmen
	value = 2500
	mission_reward = /obj/item/gun/ballistic/automatic/pistol/mauler
	registered_type = /mob/living/simple_animal/hostile/human/frontier/ranged/officer

/datum/mission/dynamic/signaled/kill/syndi_docs
	value = 3000
	registered_type = /mob/living/simple_animal/hostile/human/nanotrasen/elite
	setpiece_item = /obj/item/folder/documents/syndicate

/datum/mission/dynamic/signaled/kill/megafauna

/datum/mission/dynamic/signaled/kill/megafauna/generate_mission_details()
	registered_type = pick(
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner,
		/mob/living/simple_animal/hostile/megafauna/claw,
	)
	. = ..()

/datum/mission/dynamic/signaled/kill/elite

/datum/mission/dynamic/signaled/kill/elite/generate_mission_details()
	registered_type = pick(
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother,
		/mob/living/simple_animal/hostile/asteroid/elite/herald,
		/mob/living/simple_animal/hostile/asteroid/elite/legionnaire,
		/mob/living/simple_animal/hostile/asteroid/elite/pandora,
	)
	. = ..()
