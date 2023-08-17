//Dead mobs can exist whenever. This is needful

INITIALIZE_IMMEDIATE(/mob/dead)

/mob/dead
	sight = SEE_TURFS | SEE_MOBS | SEE_OBJS | SEE_SELF
	move_resist = INFINITY
	throwforce = 0

/mob/dead/Initialize()
	SHOULD_CALL_PARENT(FALSE)
	if(flags_1 & INITIALIZED_1)
		stack_trace("Warning: [src]([type]) initialized multiple times!")
	flags_1 |= INITIALIZED_1
	tag = "mob_[next_mob_id++]"
	add_to_mob_list()

	prepare_huds()

	if(length(CONFIG_GET(keyed_list/cross_server)))
		add_verb(src, /mob/dead/proc/server_hop)
	set_focus(src)
	become_hearing_sensitive(ROUNDSTART_TRAIT)
	return INITIALIZE_HINT_NORMAL

/mob/dead/canUseStorage()
	return FALSE

/mob/dead/dust(just_ash, drop_items, force)
	return

/mob/dead/gib()
	return

/mob/dead/ConveyorMove()
	return

/mob/dead/get_status_tab_items()
	. = ..()
	. += ""
	. += "Game Mode: [SSticker.hide_mode ? "Secret" : "[GLOB.master_mode]"]"

	if(SSticker.HasRoundStarted())
		return

	var/time_remaining = SSticker.GetTimeLeft()
	if(time_remaining > 0)
		. += "Time To Start: [round(time_remaining/10)]s"
	else if(time_remaining == -10)
		. += "Time To Start: DELAYED"
	else
		. += "Time To Start: SOON"

	. += "Players: [SSticker.totalPlayers]"
	if(client.holder)
		. += "Players Ready: [SSticker.totalPlayersReady]"

/mob/dead/proc/server_hop()
	set category = "OOC"
	set name = "Server Hop!"
	set desc= "Jump to the other server"
	if(notransform)
		return
	var/list/our_id = CONFIG_GET(string/cross_comms_name)
	var/list/csa = CONFIG_GET(keyed_list/cross_server) - our_id
	var/pick
	switch(csa.len)
		if(0)
			remove_verb(src, /mob/dead/proc/server_hop)
			to_chat(src, "<span class='notice'>Server Hop has been disabled.</span>")
		if(1)
			pick = csa[1]
		else
			pick = input(src, "Pick a server to jump to", "Server Hop") as null|anything in csa

	if(!pick)
		return

	var/addr = csa[pick]

	if(alert(src, "Jump to server [pick] ([addr])?", "Server Hop", "Yes", "No") != "Yes")
		return

	var/client/C = client
	to_chat(C, "<span class='notice'>Sending you to [pick].</span>")
	new /atom/movable/screen/splash(C)

	notransform = TRUE
	sleep(29)	//let the animation play
	notransform = FALSE

	if(!C)
		return

	winset(src, null, "command=.options") //other wise the user never knows if byond is downloading resources

	C << link("[addr]?server_hop=[key]")

/mob/dead/auto_deadmin_on_login()
	return

/mob/dead/Login()
	. = ..()
	if(!client)
		return
	LAZYADDASSOC(SSmobs.dead_players_by_virtual_z, "[virtual_z()]", src)

/mob/dead/Logout()
	. = ..()
	LAZYREMOVEASSOC(SSmobs.dead_players_by_virtual_z, "[virtual_z()]", src)
