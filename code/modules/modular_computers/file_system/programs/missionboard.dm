/datum/computer_file/program/mission
	filename = "missionviewer"
	filedesc = "Mission viewer"
	program_icon_state = "generic"
	extended_desc = "Mission viewer."
	size = 12
	requires_ntnet = TRUE
	usage_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP
	transfer_access = ACCESS_HEADS
	available_on_ntnet = TRUE
	tgui_id = "NtosMission"
	/// Variable dictating if we are in the process of restoring the AI in the inserted intellicard
	var/restoring = FALSE

/datum/computer_file/program/mission/ui_data(mob/user)
	var/list/data = list()
	data["missions"] = list()
	for(var/datum/mission/dynamic/M as anything in SSmissions.active_missions)
		data["missions"] += list(M.get_tgui_info())
	data["pad"] = FALSE
	data["id_inserted"] = FALSE
	return data
