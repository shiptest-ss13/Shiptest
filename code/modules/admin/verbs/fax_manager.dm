/client/proc/fax_manager()
	set category = "Fun"
	set name = "Fax Manager"
	set desc = "Open the manager panel to view all requests during the round in progress."
	if(!check_rights(R_ADMIN))
		return

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Fax Manager") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	GLOB.fax_manager.ui_interact(usr)
