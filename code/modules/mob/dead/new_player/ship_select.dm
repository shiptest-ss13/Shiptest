/datum/ship_select

/datum/ship_select/ui_state(mob/user)
	return GLOB.always_state

/datum/ship_select/ui_status(mob/user, datum/ui_state/state)
	return isnewplayer(user) ? UI_INTERACTIVE : UI_CLOSE

/datum/ship_select/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ShipSelect")
		ui.open()

/datum/ship_select/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(!isnewplayer(usr))
		return
	var/mob/dead/new_player/spawnee = usr
	switch(action)
		if("join")
			var/datum/overmap/ship/controlled/target = locate(params["ship"]) in SSovermap.controlled_ships
			if(!target)
				to_chat(spawnee, "<span class='danger'>Unable to locate ship. Please contact admins!</span>")
				spawnee.new_player_panel()
				return
			if(!target.is_join_option())
				to_chat(spawnee, "<span class='danger'>This ship is not currently accepting new players!</span>")
				spawnee.new_player_panel()
				return

			var/did_application = FALSE
			if(target.join_mode == SHIP_JOIN_MODE_APPLY)
				var/datum/ship_application/current_application = target.get_application(spawnee)
				if(isnull(current_application))
					var/datum/ship_application/app = new(spawnee, target)
					if(app.get_user_response())
						to_chat(spawnee, "<span class='notice'>Ship application sent. You will be notified if the application is accepted.</span>")
					else
						to_chat(spawnee, "<span class='notice'>Application cancelled, or there was an error sending the application.</span>")
					return
				switch(current_application.status)
					if(SHIP_APPLICATION_ACCEPTED)
						to_chat(spawnee, "<span class='notice'>Your ship application was accepted, continuing...</span>")
					if(SHIP_APPLICATION_PENDING)
						alert(spawnee, "You already have a pending application for this ship!")
						return
					if(SHIP_APPLICATION_DENIED)
						alert(spawnee, "You can't join this ship, as a previous application was denied!")
						return
				did_application = TRUE

			if(target.join_mode == SHIP_JOIN_MODE_CLOSED || (target.join_mode == SHIP_JOIN_MODE_APPLY && !did_application))
				to_chat(spawnee, "<span class='warning'>You cannot join this ship anymore, as its join mode has changed!</span>")
				return

			ui.close()
			var/datum/job/selected_job = locate(params["job"]) in target.job_slots
			if(!spawnee.AttemptLateSpawn(selected_job, target))
				to_chat(spawnee, "<span class='danger'>Unable to spawn on ship!</span>")
				spawnee.new_player_panel()


		if("buy")
			ui.close()
			var/datum/map_template/shuttle/template = SSmapping.ship_purchase_list[params["name"]]
			if(!template.enabled)
				to_chat(spawnee, "<span class='danger'>This ship is not currently available for purchase!</span>")
				spawnee.new_player_panel()
				return
			to_chat(spawnee, "<span class='danger'>Your [template.name] is being prepared. Please be patient!</span>")
			var/datum/overmap/ship/controlled/target = new(SSovermap.get_unused_overmap_square(), template)
			if(!target?.shuttle_port)
				to_chat(spawnee, "<span class='danger'>There was an error loading the ship. Please contact admins!</span>")
				spawnee.new_player_panel()
				return
			SSblackbox.record_feedback("tally", "ship_purchased", 1, template.name) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
			if(!spawnee.AttemptLateSpawn(target.job_slots[1], target)) //Try to spawn as the first listed job in the job slots (usually captain)
				to_chat(spawnee, "<span class='danger'>Ship spawned, but you were unable to be spawned. You can likely try to spawn in the ship through joining normally, but if not, please contact an admin.</span>")
				spawnee.new_player_panel()

/datum/ship_select/ui_static_data(mob/user)
	. = list()
	.["ships"] = list()
	for(var/datum/overmap/ship/controlled/S as anything in SSovermap.controlled_ships)
		if(!S.is_join_option())
			continue

		var/list/ship_jobs = list()
		for(var/datum/job/job as anything in S.job_slots)
			var/slots = S.job_slots[job]
			if(slots <= 0)
				continue
			ship_jobs += list(list(
				"name" = job,
				"slots" = slots,
				"ref" = REF(job)
			))

		var/list/ship_data = list(
			"name" = S.name,
			"class" = S.source_template.short_name,
			"memo" = S.memo,
			"jobs" = ship_jobs,
			"manifest" = S.manifest,
			"joinMode" = S.join_mode,
			"ref" = REF(S)
		)

		.["ships"] += list(ship_data)

	.["templates"] = list()
	for(var/template_name as anything in SSmapping.ship_purchase_list)
		var/datum/map_template/shuttle/T = SSmapping.ship_purchase_list[template_name]
		if(!T.enabled)
			continue
		var/list/ship_data = list(
			"name" = T.name,
			"desc" = T.description,
			"crewCount" = length(T.job_slots)
		)
		.["templates"] += list(ship_data)
