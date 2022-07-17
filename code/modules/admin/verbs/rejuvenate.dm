/client/proc/cmd_admin_rejuvenate(mob/living/M in GLOB.mob_list)
	set category = "Admin.Game"
	set name = "Rejuvenate"


	if(!check_rights(R_ADMIN))
		return

	if(!mob)
		return
	if(!istype(M))
		alert("Cannot revive a ghost")
		return
	M.revive(full_heal = 1, admin_revive = 1)

	log_admin("[key_name(usr)] healed / revived [key_name(M)]")
	var/msg = "Admin [key_name(usr)] healed / revived [key_name(M)]!" // yogs - Yog Tickets
	message_admins(msg)
	admin_ticket_log(M, msg)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Rejuvinate") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
