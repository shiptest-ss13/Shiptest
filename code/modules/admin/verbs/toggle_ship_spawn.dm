/client/proc/toggle_ship_spawn()
	set name = "Toggle Ship Spawn"
	set category = "Server"
	set desc = "Toggles the ability of players to create ships via the roundstart screen or shuttle creator."

	if(!holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	if(check_rights(R_ADMIN, 1))
		GLOB.ship_spawn_enabled ^= TRUE
		var/message
		if(GLOB.ship_spawn_enabled)
			message = "[key_name_admin(usr)] enabled player ship spawning."
			to_chat(world, "<B>Ship Spawning is now enabled.</B>", confidential = TRUE)
		else
			message = "[key_name_admin(usr)] disabled player ship spawning."
			to_chat(world, "<B>Ship Spawning is now disabled.</B>", confidential = TRUE)
		message_admins(message)
		log_game(message)
	BLACKBOX_LOG_ADMIN_VERB("Toggle Ship Spawn")

/client/proc/toggle_ship_auto_locking()
	set name = "Toggle Automatic Ship Spawn Locking"
	set category = "Server"
	set desc = "Toggles if we have automatic ship locking enabled."

	if(!holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	if(check_rights(R_ADMIN, 1))
		CONFIG_SET(flag/auto_ship_spawn_locking, !CONFIG_GET(flag/auto_ship_spawn_locking))
		var/message
		if(CONFIG_GET(flag/auto_ship_spawn_locking))
			message = "[key_name_admin(usr)] enabled auto ship spawning locking."
			to_chat(world, "<B>Ship Automatic Locking is now enabled.</B>", confidential = TRUE)
		else
			message = "[key_name_admin(usr)] disabled auto ship spawning locking."
			to_chat(world, "<B>Ship Automatic Locking is now disabled.</B>", confidential = TRUE)
		message_admins(message)
		log_game(message)
	BLACKBOX_LOG_ADMIN_VERB("Toggle Automatic Ship Spawn Locking")
