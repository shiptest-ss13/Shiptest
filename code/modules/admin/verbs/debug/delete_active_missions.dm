/datum/admins/proc/delete_all_missions()
	set category = "Debug"
	set name = "Delete active missions"
	set desc = "Deletes all ruin active missions, does not include inactive ones."

	if(!check_rights(R_DEBUG))
		return

	message_admins("[key_name_admin(src)] has deleted all active ruin missions(total of [length(SSmissions.active_ruin_missions)]).")
	SSmissions.kill_active_missions()

	BLACKBOX_LOG_ADMIN_VERB("Delete active missions")
