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
				to_chat(spawnee, span_danger("Unable to locate ship. Please contact admins!"))
				spawnee.new_player_panel()
				return
			if(!target.is_join_option())
				to_chat(spawnee, span_danger("This ship is not currently accepting new players!"))
				spawnee.new_player_panel()
				return

			var/did_application = FALSE
			if(target.join_mode == SHIP_JOIN_MODE_APPLY)
				var/datum/ship_application/current_application = target.get_application(spawnee)
				if(isnull(current_application))
					var/datum/ship_application/app = new(spawnee, target)
					if(app.get_user_response())
						to_chat(spawnee, span_notice("Ship application sent. You will be notified if the application is accepted."))
					else
						to_chat(spawnee, span_notice("Application cancelled, or there was an error sending the application."))
					return
				switch(current_application.status)
					if(SHIP_APPLICATION_ACCEPTED)
						to_chat(spawnee, span_notice("Your ship application was accepted, continuing..."))
					if(SHIP_APPLICATION_PENDING)
						alert(spawnee, "You already have a pending application for this ship!")
						return
					if(SHIP_APPLICATION_DENIED)
						alert(spawnee, "You can't join this ship, as a previous application was denied!")
						return
				did_application = TRUE

			if(target.join_mode == SHIP_JOIN_MODE_CLOSED || (target.join_mode == SHIP_JOIN_MODE_APPLY && !did_application))
				to_chat(spawnee, span_warning("You cannot join this ship anymore, as its join mode has changed!"))
				return

			var/datum/faction/registered_faction = target.shuttle_port.registered_faction
			var/datum/language/official_lang = initial(registered_faction.official_language)
			if(official_lang != spawnee.client.prefs.native_language && spawnee.client.prefs.learned_languages[official_lang] != LANGUAGE_FLUENT && \
				tgui_alert(spawnee, "Your character does not fully understand this faction's official language ([initial(official_lang.name)]), are you sure?", "Official language", list("Yes", "No")) != "Yes")
				return // pop-up warning for new players that forgot to set their

			ui.close()
			var/datum/job/selected_job = locate(params["job"]) in target.job_slots
			//boots you out if you're banned from officer roles
			if(selected_job.officer && is_banned_from(spawnee.ckey, "Ship Command"))
				to_chat(spawnee, span_danger("You are banned from Officer roles!"))
				spawnee.new_player_panel()
				ui.close()
				return

			// Attempts the spawn itself. This checks for playtime requirements.
			if(!spawnee.AttemptLateSpawn(selected_job, target))
				to_chat(spawnee, span_danger("Unable to spawn on ship!"))
				spawnee.new_player_panel()

		if("buy")
			if(is_banned_from(spawnee.ckey, "Ship Purchasing"))
				to_chat(spawnee, span_danger("You are banned from purchasing ships!"))
				spawnee.new_player_panel()
				ui.close()
				return

			var/datum/map_template/shuttle/template = SSmapping.ship_purchase_list[params["name"]]
			if(SSovermap.ship_spawning)
				to_chat(spawnee, span_danger("A ship is currently spawning. Try again in a little while."))
				return
			if(!SSovermap.player_ship_spawn_allowed())
				to_chat(spawnee, span_danger("No more ships may be spawned at this time!"))
				return
			if(!template.enabled)
				to_chat(spawnee, span_danger("This ship is not currently available for purchase!"))
				return
			if(!template.has_ship_spawn_playtime(spawnee.client))
				to_chat(spawnee, span_danger("You do not have enough playtime to spawn this ship!"))
				return

			var/num_ships_with_template = 0
			for(var/datum/overmap/ship/controlled/Ship as anything in SSovermap.controlled_ships)
				if(template == Ship.source_template)
					num_ships_with_template += 1
			if(num_ships_with_template >= template.limit)
				to_chat(spawnee, span_danger("There are already [num_ships_with_template] ships of this type; you cannot spawn more!"))
				return

			ui.close()

			var/ship_loc
			var/datum/overmap_star_system/selected_system //the star system we want to spawn in

			if(length(SSovermap.outposts) > 1)
				var/datum/overmap/outpost/temp_loc = input(spawnee, "Select outpost to spawn at") as null|anything in SSovermap.outposts
				if(!temp_loc)
					return
				selected_system = temp_loc.current_overmap
				ship_loc = temp_loc
			else
				ship_loc = SSovermap.outposts[1]
				selected_system = SSovermap.tracked_star_systems[1]

			if(!selected_system)
				CRASH("Ship attemped to be bought at spawn menu, but spawning outpost was not selected! This is bad!") //if selected_system didnt get selected, we nope out, this is very bad

			to_chat(spawnee, "<span class='danger'>Your [template.name] is being prepared. Please be patient!</span>")
			var/datum/overmap/ship/controlled/target = SSovermap.spawn_ship_at_start(template, ship_loc, selected_system)

			if(!target?.shuttle_port)
				to_chat(spawnee, span_danger("There was an error loading the ship. Please contact admins!"))
				spawnee.new_player_panel()
				return
			SSblackbox.record_feedback("tally", "ship_purchased", 1, template.name)
			SSblackbox.record_feedback("tally", "faction_ship_purchased", 1, template.faction.name)
			// Try to spawn as the first listed job in the job slots (usually captain)
			// Playtime checks are overridden, to ensure the player gets to join the ship they spawned.
			if(!spawnee.AttemptLateSpawn(target.job_slots[1], target, FALSE))
				to_chat(spawnee, span_danger("Ship spawned, but you were unable to be spawned. You can likely try to spawn in the ship through joining normally, but if not, please contact an admin."))
				spawnee.new_player_panel()

/datum/ship_select/ui_data(mob/user)
	. = list()
	.["shipSpawning"] = SSovermap.ship_spawning

/datum/ship_select/ui_static_data(mob/user)
	// tracks the number of existing ships of each template type so that their unavailability for purchase can be communicated to the user
	var/list/template_num_lookup = list()

	. = list()
	.["ships"] = list()
	.["shipSpawnAllowed"] = SSovermap.player_ship_spawn_allowed()
	.["purchaseBanned"] = is_banned_from(user.ckey, "Ship Purchasing")
	.["officerBanned"] = is_banned_from(user.ckey, "Ship Command")
	// if the player has a client which is not eligible for playtime restriction (for admin + player DB flag playtime exemption), they "auto meet" playtime requirements
	.["autoMeet"] = user.client && !user.client.is_playtime_restriction_eligible()
	.["playMin"] = user.client ? user.client.get_exp_living(TRUE) : 0

	for(var/datum/overmap/ship/controlled/S as anything in SSovermap.controlled_ships)
		if(S.source_template)
			if(!template_num_lookup[S.source_template])
				template_num_lookup[S.source_template] = 1
			else
				template_num_lookup[S.source_template] += 1
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
				"minTime" = job.officer ? S.source_template.get_req_officer_minutes() : 0,
				"officer" = job.officer,
				"ref" = REF(job),
			))

		var/list/ship_data = list(
			"name" = S.name,
			"faction" = S.source_template.faction.name,
			"class" = S.source_template.short_name,
			"desc" = S.source_template.description,
			"tags" = S.source_template.tags,
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
			"faction" = T.faction.name,
			"desc" = T.description,
			"tags" = T.tags,
			"crewCount" = length(T.job_slots),
			"limit" = T.limit,
			"curNum" = template_num_lookup[T] || 0,
			"minTime" = T.get_req_spawn_minutes(),
		)
		.["templates"] += list(ship_data)
