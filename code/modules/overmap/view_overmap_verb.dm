/datum/admins/proc/overmap_view()
	set category = "Debug"
	set name = "Overmap View"
	set desc = "Opens the basic overmap view UI."

	if(!check_rights(R_DEBUG))
		return

	SSovermap.overmap_container_view(usr)
