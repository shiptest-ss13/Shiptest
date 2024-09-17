/**
 * This proc generates the panel that opens to all newly joining players, allowing them to join, observe, view polls, view the current crew manifest, and open the character customization menu.
 */
/mob/dead/new_player/proc/new_player_panel()
	if(auth_check)
		return

	if(CONFIG_GET(flag/auth_only))
		if(client?.holder && CONFIG_GET(flag/auth_admin_testing))
			to_chat(src, "<span class='userdanger'>This server is allowed to be used for admin testing. Please ensure you are able to clean up anything you do. If the server needs to be restarted contact someone with TGS access.</span>")
		else
			to_chat(src, "<span class='userdanger'>This server is for authentication only.</span>")
			auth_check = TRUE
			return

	if (client?.interviewee)
		return

	var/datum/asset/asset_datum = get_asset_datum(/datum/asset/simple/lobby)
	asset_datum.send(client)
	var/list/output = list("<center><p><a href='byond://?src=[REF(src)];show_preferences=1'>Setup Character</a></p>")

	output += "<p><a href='byond://?src=[REF(src)];motd=1'>MOTD</a></p>"
	if(SSticker.current_state <= GAME_STATE_PREGAME)
		switch(ready)
			if(PLAYER_NOT_READY)
				output += "<p>\[[LINKIFY_READY("Observe", PLAYER_READY_TO_OBSERVE)]\]</p>"
			if(PLAYER_READY_TO_OBSERVE)
				output += "<p>\[ [LINKIFY_READY("<b> Observe </b>", PLAYER_NOT_READY)] \]</p>"
	else
		output += "<p><a href='byond://?src=[REF(src)];manifest=1'>View the Crew Manifest</a></p>"
		output += "<p><a href='byond://?src=[REF(src)];late_join=1'>Join Game!</a></p>"
		output += "<p>[LINKIFY_READY("Observe", PLAYER_READY_TO_OBSERVE)]</p>"

	output += "<p><a href='byond://?src=[REF(src)];player_panel_tgui=1'>Fancy UI</a></p>"

	if(!IsGuestKey(src.key))
		output += playerpolls()

	output += "</center>"

	var/datum/browser/popup = new(src, "playersetup", "<div align='center'>New Player Options</div>", 250, 265)
	popup.set_window_options("can_close=0")
	popup.set_content(output.Join())
	popup.open(FALSE)

GLOBAL_DATUM(new_player_panel_tgui, /datum/new_player_panel_tgui_edition)

/datum/new_player_panel_tgui_edition
	var/mob/dead/new_player/owner

/datum/new_player_panel_tgui_edition/New(mob/dead/new_player/new_owner)
	if(!istype(new_owner))
		qdel(src)
	owner = new_owner

/datum/new_player_panel_tgui_edition

/datum/new_player_panel_tgui_edition/ui_state(mob/user)
	return GLOB.always_state

/datum/new_player_panel_tgui_edition/ui_status(mob/user, datum/ui_state/state)
	return (ismob(user)) ? UI_INTERACTIVE : UI_CLOSE

/datum/new_player_panel_tgui_edition/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "NewPlayerPanel")
		ui.open()

/datum/new_player_panel_tgui_edition/ui_data(mob/user)
	var/list/data = list()
	data["motd"] = global.config.motd
	data["round_started"] = SSticker?.IsRoundInProgress()
	return data

/datum/new_player_panel_tgui_edition/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(!isnewplayer(usr))
		return

	var/mob/dead/new_player/spawnee = usr

	if(!spawnee.client)
		return 0

	var/client/client = spawnee.client

	if(client.interviewee)
		return FALSE

	switch(action)
		if("show_preferences")
			client.prefs.ShowChoices(spawnee)
		if("join_game")
			spawnee.LateChoices()
		if("manifest")
			spawnee.ViewManifest()
		if("observe")
			spawnee.make_me_an_observer()
