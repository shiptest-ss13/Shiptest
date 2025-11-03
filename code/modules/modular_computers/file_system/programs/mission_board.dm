///I will work on reimplmenting player bounties!
/datum/computer_file/program/mission_board
	filename = "missionboard"
	filedesc = "Mission Network Viewer"
	program_icon_state = "bounty"
	extended_desc = "A multi-platform network for placing requests across the sector, modular software cant handle item transfer so this is only for viewing."
	requires_ntnet = TRUE
	size = 10
	available_on_ntnet = TRUE
	tgui_id = "NtosMission"
	COOLDOWN_DECLARE(dibs_cooldown)

/datum/computer_file/program/mission_board/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	switch(action)
		if("claim")
			if(!COOLDOWN_FINISHED(src, dibs_cooldown))
				computer.say("The claim function is on cooldown.")
				playsound(computer, 'sound/machines/buzz-two.ogg', 10, FALSE, FALSE)
				return
			var/datum/mission/ruin/mission = locate(params["mission"])
			if(!istype(mission, /datum/mission/ruin))
				return
			var/obj/item/computer_hardware/card_slot/card_slot
			var/obj/item/card/id/inserted_scan_id
			if(computer)
				card_slot = computer.all_components[MC_CARD]
			if(computer && card_slot)
				inserted_scan_id = card_slot.stored_card
			if(inserted_scan_id)
				var/datum/overmap/ship/controlled/ship = locate(/datum/overmap/ship/controlled) in inserted_scan_id.ship_access
				var/ship_name
				if(ship)
					ship_name = "[ship.name]"
				mission.dibs_string = "[inserted_scan_id.registered_name] - [inserted_scan_id.assignment] - [ship_name] - [station_time_timestamp()]"
			else
				mission.dibs_string = "unknown claimer - [station_time_timestamp()]"
			COOLDOWN_START(src, dibs_cooldown, 5 SECONDS)

/datum/computer_file/program/mission_board/ui_data(mob/user)
	var/list/data = get_header_data()
	data["missions"] = list()
	for(var/datum/mission/M in SSmissions.active_ruin_missions)
		data["missions"] += list(M.get_tgui_info())
	data["pad"] = FALSE
	data["id_inserted"] = FALSE

	var/obj/item/computer_hardware/card_slot/card_slot
	if(computer)
		card_slot = computer.all_components[MC_CARD]
	if(computer && card_slot)
		var/obj/item/card/id/id_card = card_slot.stored_card
		data["id_inserted"] = !!id_card

	return data
