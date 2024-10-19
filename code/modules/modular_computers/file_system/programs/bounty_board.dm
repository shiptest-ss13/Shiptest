///I will work on reimplmenting player bounties!
/datum/computer_file/program/bounty_board
	filename = "bountyboard"
	filedesc = "Bounty Network Viewer"
	program_icon_state = "bountyboard"
	extended_desc = "A multi-platform network for placing requests across the sector, modular software cant handle item transfer so this is only for viewing."
	requires_ntnet = TRUE
	size = 10
	available_on_ntnet = TRUE
	tgui_id = "NtosMission"

/datum/computer_file/program/bounty_board/ui_data(mob/user)
	var/list/data = get_header_data()
	data["missions"] = list()
	for(var/datum/mission/dynamic/M as anything in SSmissions.active_missions)
		data["missions"] += list(M.get_tgui_info())
	data["pad"] = FALSE
	data["id_inserted"] = FALSE
	return data
