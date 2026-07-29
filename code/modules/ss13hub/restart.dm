/datum/ss13lib/proc/handle_reboot()
	for(var/ckey in ckey_to_launcher)
		var/datum/ss13lib_launcher/launcher_datum = ckey_to_launcher[ckey]
		launcher_datum.restart("Server Restart")
