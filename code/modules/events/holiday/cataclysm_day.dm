/*
/datum/round_event_control/cataclysm
	name = "Cataclysm Day"
	holidayID = CATACLYSM_DAY
	typepath = /datum/round_event/cataclysm
	weight = -1 //forces it to be called, regardless of weight
	max_occurrences = 1
	earliest_start = 0 MINUTES
	category = EVENT_CATEGORY_HOLIDAY

/datum/round_event/cataclysm
*/

//https://hackmd.io/@shiptest/H1DRZzjggg#Cataclysm-Planets
/datum/round_event_control/cataclysm_morning_broadcast
	name = "Cataclysm Planet Broadcast"
	holidayID = CATACLYSM_DAY
	typepath = /datum/round_event/cataclysm_morning_broadcast
	weight = -1 //forces it to be called, regardless of weight
	max_occurrences = 1
	earliest_start = 5 MINUTES
	category = EVENT_CATEGORY_HOLIDAY

/datum/round_event_control/cataclysm_morning_broadcast/can_spawn_event(players_amt, gamemode)
	if(!(length(SSovermap.outposts)))
		return FALSE

/datum/round_event/cataclysm_morning_broadcast
	end_when = 50
	var/datum/overmap/outpost/target_outpost

/datum/round_event/cataclysm_morning_broadcast/setup()
	target_outpost = pick(SSovermap.outposts)

/datum/round_event/cataclysm_morning_broadcast/start()
	//List off a bunch of planets
	return


/obj/item/storage/box/papersack/srm_rations/PopulateContents()
	new /obj/effect/spawner/random/food_or_drink/srm_rations(src)

/obj/effect/spawner/random/food_or_drink/srm_rations
	spawn_loot_count = 4
	loot = list(
			/obj/item/food/breadslice/plain = 10,
		)
