/obj/effect/landmark/mission_poi/main/kill

/datum/mission/ruin/signaled/kill
	name = "%MISSION_TARGET termination"
	desc = "Bounty for a high ranking %MISSION_TARGET residing on this planet. They should have identifying dogtags."
	setpiece_poi = /obj/effect/landmark/mission_poi/main/kill
	setpiece_item = /obj/item/clothing/neck/dogtag
	mission_main_signal = COMSIG_MOB_DEATH

/datum/mission/ruin/signaled/kill/generate_mission_details()
	. = ..()
	registered_type = pick(registered_type)

/datum/mission/ruin/signaled/kill/mission_regexs(mission_string)
	mission_string = ..()
	if(ispath(registered_type))
		var/atom/target = registered_type
		mission_string = replacetext(mission_string, "%MISSION_TARGET", "[target::name]")
	return mission_string

/datum/mission/ruin/signaled/kill/frontiersmen
	value = 3500
	mission_reward = list(
		/obj/item/gun/ballistic/automatic/pistol/mauler,
		/obj/item/gun/ballistic/automatic/pistol/spitter
	)
	registered_type = /mob/living/simple_animal/hostile/human/frontier/ranged/officer
	setpiece_item = /obj/item/clothing/neck/dogtag/frontier

/datum/mission/ruin/signaled/kill/syndi_docs
	value = 4000
	registered_type = /mob/living/simple_animal/hostile/human/nanotrasen/elite
	setpiece_item = /obj/item/folder/documents/syndicate

/datum/mission/ruin/signaled/kill/megafauna

/datum/mission/ruin/signaled/kill/megafauna/generate_mission_details()
	registered_type = pick(
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner,
		/mob/living/simple_animal/hostile/megafauna/claw,
	)
	. = ..()

/datum/mission/ruin/signaled/kill/elite

/datum/mission/ruin/signaled/kill/elite/generate_mission_details()
	registered_type = pick(
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother,
		/mob/living/simple_animal/hostile/asteroid/elite/herald,
		/mob/living/simple_animal/hostile/asteroid/elite/legionnaire,
		/mob/living/simple_animal/hostile/asteroid/elite/pandora,
	)
	. = ..()
