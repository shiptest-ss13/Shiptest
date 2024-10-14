
/datum/computer_file/program/
	filename = "aidiag"
	filedesc = "NT FRK"
	program_icon_state = "generic"
	extended_desc = "Mission viewer."
	size = 12
	requires_ntnet = TRUE
	usage_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP
	transfer_access = ACCESS_HEADS
	available_on_ntnet = TRUE
	tgui_id = "NtosAiRestorer"
	/// Variable dictating if we are in the process of restoring the AI in the inserted intellicard
	var/restoring = FALSE

ui_data(mob/user)
	var/list/data = list()
	data["missions"] = list()
	var/list/items_on_pad = recalc()
	for(var/datum/mission/dynamic/M as anything in SSmissions.active_missions)
		data["missions"] += list(M.get_tgui_info(items_on_pad))
	data["pad"] = pad_ref?.resolve() ? TRUE : FALSE
	data["id_inserted"] = inserted_scan_id ? TRUE : FALSE
	return data
