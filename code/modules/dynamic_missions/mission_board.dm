/obj/machinery/computer/mission
	name = "\improper Outpost mission board"
	desc = "Used to check and claim missions offered by the outpost"
	icon_screen = "bounty"
	circuit = /obj/item/circuitboard/computer/mission
	light_color = COLOR_BRIGHT_ORANGE

/obj/machinery/computer/mission/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MissionBoard", name)
		ui.open()

/obj/machinery/computer/mission/ui_data(mob/user)
	var/list/data = list()
	data["missions"] = list()
	for(var/datum/dynamic_mission/M as anything in SSmissions.active_missions)
		data["missions"] += list(M.get_tgui_info())
	return data
