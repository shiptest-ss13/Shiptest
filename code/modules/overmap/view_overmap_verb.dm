/datum/admins/proc/overmap_view()
	set category = "Debug"
	set name = "Overmap View"
	set desc = "Opens the basic overmap view UI."

	if(!check_rights(R_DEBUG))
		return

	var/datum/overmap_star_system/selected_system
	if(length(SSovermap.tracked_star_systems) >= 1)
		selected_system = tgui_input_list(usr, "Which star system do you want to view?", "Overmap View", SSovermap.tracked_star_systems)
	else
		selected_system = SSovermap.tracked_star_systems[1]
	if(!selected_system)
		return

	selected_system.overmap_container_view(usr)
