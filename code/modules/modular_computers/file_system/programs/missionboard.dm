/datum/computer_file/program/mission
	filename = "missionviewer"
	filedesc = "Mission viewer"
	program_icon_state = "bountyboard"
	extended_desc = "A multi-platform network for placing requests across the sector, with payment across the network being possible.."
	requires_ntnet = TRUE
	size = 10
	available_on_ntnet = TRUE
	tgui_id = "NtosMission"

/datum/computer_file/program/mission/ui_data(mob/user)
	var/list/data = get_header_data()
	data["missions"] = list()
	for(var/datum/mission/dynamic/M as anything in SSmissions.active_missions)
		data["missions"] += list(M.get_tgui_info())
	data["pad"] = FALSE
	data["id_inserted"] = FALSE
	return data
