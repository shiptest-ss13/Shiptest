/obj/effect/landmark/mission_poi/main/kill

/datum/mission/ruin/signaled/kill
	name = "%MISSION_TARGET Termination"
	desc = "This is a bounty for the elimination of a %MISSION_TARGET. Return their %MISSION_ITEM to claim the reward."
	setpiece_poi = /obj/effect/landmark/mission_poi/main/kill
	setpiece_item = /obj/item/clothing/neck/dogtag/gold
	mission_main_signal = COMSIG_MOB_DEATH

/datum/mission/ruin/signaled/kill/generate_mission_details()
	. = ..()
	registered_type = pick(registered_type)

/datum/mission/ruin/signaled/kill/mission_regexs(mission_string)
	mission_string = ..()
	if(ispath(registered_type))
		var/atom/target = registered_type
		mission_string = replacetext(mission_string, "%MISSION_TARGET", "[target::name]")
		mission_string = replacetext(mission_string, "%MISSION_ITEM", "[setpiece_item::name]")
	return mission_string

/datum/mission/ruin/signaled/kill/frontiersmen
	value = 2000
	mission_limit = 3
	mission_reward = list(
		/obj/item/gun/ballistic/automatic/pistol/mauler,
		/obj/item/gun/ballistic/automatic/pistol/spitter
	)
	registered_type = /mob/living/simple_animal/hostile/human/frontier/ranged/officer
	//setpiece_item = /obj/item/clothing/neck/dogtag/frontier

/datum/mission/ruin/signaled/kill/ramzi
	value = 2500
	mission_limit = 3
	mission_reward = list(
		/obj/item/gun/ballistic/automatic/smg/cobra,
		/obj/item/gun/ballistic/automatic/smg/sidewinder,
	)
	registered_type = /mob/living/simple_animal/hostile/human/ramzi
	//setpiece_item = /obj/item/clothing/neck/dogtag/ramzi

/datum/mission/ruin/signaled/kill/syndi_docs
	value = 3000
	mission_limit = 1
	faction = /datum/faction/syndicate
	registered_type = /mob/living/simple_animal/hostile/human/nanotrasen/elite
	setpiece_item = /obj/item/folder/documents/syndicate

/datum/mission/ruin/signaled/kill/megafauna
	mission_limit = 2

/datum/mission/ruin/signaled/kill/megafauna/generate_mission_details()
	registered_type = pick(
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner,
		/mob/living/simple_animal/hostile/megafauna/claw,
	)
	. = ..()

/datum/mission/ruin/signaled/kill/elite
	value = 6000
	mission_limit = 2

/datum/mission/ruin/signaled/kill/elite/generate_mission_details()
	registered_type = pick(
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother,
		/mob/living/simple_animal/hostile/asteroid/elite/herald,
		/mob/living/simple_animal/hostile/asteroid/elite/legionnaire,
		/mob/living/simple_animal/hostile/asteroid/elite/pandora,
	)
	. = ..()
