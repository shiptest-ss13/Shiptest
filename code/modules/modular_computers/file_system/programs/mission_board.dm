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
		if("dibs")
			if(!COOLDOWN_FINISHED(src, dibs_cooldown))
				computer.say("The dibs function is on cooldown.")
				playsound(computer, 'sound/machines/buzz-two.ogg', 10, FALSE, FALSE)
				return
			var/datum/mission/ruin/mission = locate(params["mission"])
			if(!istype(mission, /datum/mission/ruin))
				return
			mission.dibs++
			COOLDOWN_START(src, dibs_cooldown, 5 SECONDS)

/datum/computer_file/program/mission_board/ui_data(mob/user)
	var/list/data = get_header_data()
	data["missions"] = list()
	for(var/datum/mission/ruin/M in SSmissions.active_missions)
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
