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

/datum/round_event_control/cataclysm_broadcast
	name = "Cataclysm Planet Morning Broadcast"
	holidayID = CATACLYSM_DAY
	typepath = /datum/round_event/cataclysm_broadcast
	//weight = -1 //forces it to be called, regardless of weight
	weight = 10000
	max_occurrences = 1
	earliest_start = 5 MINUTES
	category = EVENT_CATEGORY_HOLIDAY

/datum/round_event_control/cataclysm_broadcast/can_spawn_event(players_amt, gamemode)
	if(!(length(SSovermap.outposts)))
		return FALSE
	return ..()


/datum/round_event_control/cataclysm_broadcast/end_of_day
	name = "Cataclysm Planet End of Day Broadcast"
	typepath = /datum/round_event/cataclysm_broadcast/end_of_day
	earliest_start = 1 HOURS

/datum/round_event_control/cataclysm_broadcast/end_of_day/can_spawn_event(players_amt, gamemode)
	// Dont let the event trigger if the round hasnt ended or soon to end.
	if((SSticker.current_state != GAME_STATE_FINISHED) && (SSshuttle.jump_mode == BS_JUMP_IDLE))
		return FALSE
	return ..()


/datum/round_event/cataclysm_broadcast
	end_when = 50
	var/list/planets_to_name = list("Minya", "Terra", "Teceti", "Sitami's Folly", "Mikiliwolo", "Gorlex VII", "Re'tex'himl", "Iakono-XZT2", "Curie H2H-B")

/datum/round_event/cataclysm_broadcast/start()
	for(var/datum/overmap/outpost/target_outpost in SSovermap.outposts)
		var/target_turf = target_outpost.get_jump_to_turf()
		target_outpost.broadcast_message(target_turf, "Today we remember the worlds of Cataclysm, where the flame of life faltered. Take a moment of silence. Remember...")

/datum/round_event/cataclysm_broadcast/tick()
	if(!length(planets_to_name))
		return
	for(var/datum/overmap/outpost/target_outpost in SSovermap.outposts)
		var/list/temp_planet_names = planets_to_name.Copy()
		var/target_turf = target_outpost.get_jump_to_turf()
		if(activeFor % 4 == 0)
			var/planet_to_name = pick(temp_planet_names)
			target_outpost.broadcast_message(target_turf, "[planet_to_name]...")
			temp_planet_names -= planet_to_name


/datum/round_event/cataclysm_broadcast/end_of_day

/datum/round_event/cataclysm_broadcast/end_of_day/start()
	for(var/datum/overmap/outpost/target_outpost in SSovermap.outposts)
		var/target_turf = target_outpost.get_jump_to_turf()
		target_outpost.broadcast_message(target_turf, "As Cataclysm Day comes to a close, we take a moment to honor the living worlds, which host the hopes of life in our Galaxy. May life propser forever more on....")


/obj/item/storage/box/papersack/srm_rations/PopulateContents()
	new /obj/effect/spawner/random/food_or_drink/srm_rations(src)

/obj/effect/spawner/random/food_or_drink/srm_rations
	spawn_loot_count = 4
	loot = list(
			/obj/item/food/breadslice/plain = 10,
		)

/obj/item/terrarium
	name = "empty terrarium"
	desc = "An empty jar waiting to be filled with flora"
	icon_state = "jar_empty"
	icon = 'icons/obj/item/terrarium.dmi'
	obj_flags = UNIQUE_RENAME

/obj/item/terrarium/attackby(obj/item/O, mob/user, params)
	. = ..()
	if(istype(O, /obj/item/food/grown))
		to_chat(user, span_notice("You begin sealing the flora inside the jar to create a lovely terrarium. Give your new little world a label or name with a pen."))
		if(do_after(user, 15 SECONDS, O))
			name = "filled terrarium"
			icon_state = "jar_plants"
			desc = "A handmade sealed terrarium"
			qdel(O)
