

/client/proc/secrets() //Creates a verb for admins to open up the ui
	set name = "Secrets"
	set desc = "Abuse harder than you ever have before with this handy dandy semi-misc stuff menu"
	set category = "Admin.Game"
	BLACKBOX_LOG_ADMIN_VERB("Secrets Panel")
	var/datum/secrets_menu/tgui  = new(usr)//create the datum
	tgui.ui_interact(usr)//datum has a tgui component, here we open the window

/datum/secrets_menu
	var/client/holder //client of whoever is using this datum
	var/is_debugger = FALSE
	var/is_funmin = FALSE

/datum/secrets_menu/New(user)//user can either be a client or a mob due to byondcode(tm)
	if (istype(user, /client))
		var/client/user_client = user
		holder = user_client //if its a client, assign it to holder
	else
		var/mob/user_mob = user
		holder = user_mob.client //if its a mob, assign the mob's client to holder

	is_debugger = check_rights(R_DEBUG)
	is_funmin = check_rights(R_FUN)

/datum/secrets_menu/ui_state(mob/user)
	return GLOB.admin_state

/datum/secrets_menu/ui_close()
	qdel(src)

/datum/secrets_menu/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Secrets")
		ui.open()

/datum/secrets_menu/ui_data(mob/user)
	var/list/data = list()
	data["is_debugger"] = is_debugger
	data["is_funmin"] = is_funmin
	return data

/datum/secrets_menu/ui_act(action, params)
	. = ..()
	if(.)
		return
	if((action != "admin_log" || action != "show_admins") && !check_rights(R_ADMIN))
		return
	var/datum/round_event/E
	var/ok = FALSE
	switch(action)
		//Generic Buttons anyone can use.
		if("admin_log")
			var/dat = "<B>Admin Log<HR></B>"
			for(var/l in GLOB.admin_log)
				dat += "<li>[l]</li>"
			if(!GLOB.admin_log.len)
				dat += "No-one has done anything this round!"
			//holder << browse(dat, "window=admin_log") WS edit
			var/datum/browser/popup = new(holder, "admin_log", null, 300, 430)
			popup.set_content(dat)
			popup.open()

		//WS Begin - Mentors
		if("mentor_log")
			var/dat = "<B>Mentor Log<HR></B>"
			for(var/l in GLOB.mentorlog)
				dat += "<li>[l]</li>"
			if(!GLOB.mentorlog.len)
				dat += "No mentors have done anything this round! Not like they do much either way."
			var/datum/browser/popup = new(holder, "mentor_log", null, 300, 430)
			popup.set_content(dat)
			popup.open()
		//WS end

		if("show_admins")
			var/dat = "<B>Current admins:</B><HR>"
			if(GLOB.admin_datums)
				for(var/ckey in GLOB.admin_datums)
					var/datum/admins/D = GLOB.admin_datums[ckey]
					dat += "[ckey] - [D.rank.name]<br>"
				//holder << browse(dat, "window=showadmins;size=600x500") WS edit
				var/datum/browser/popup = new(holder, "showadmins", null, 600, 500)
				popup.set_content(dat)
				popup.open()

		//Buttons for debug.
		if("maint_access_engiebrig")
			if(!is_debugger)
				return
			for(var/obj/machinery/door/airlock/maintenance/M in GLOB.machines)
				M.check_access()
				if (ACCESS_MAINT_TUNNELS in M.req_access)
					M.req_access = list()
					M.req_one_access = list(ACCESS_BRIG,ACCESS_ENGINE)
			message_admins("[key_name_admin(holder)] made all maint doors engineering and brig access-only.")
		if("maint_access_brig")
			if(!is_debugger)
				return
			for(var/obj/machinery/door/airlock/maintenance/M in GLOB.machines)
				M.check_access()
				if (ACCESS_MAINT_TUNNELS in M.req_access)
					M.req_access = list(ACCESS_BRIG)
			message_admins("[key_name_admin(holder)] made all maint doors brig access-only.")
		//Buttons for helpful stuff. This is where people land in the tgui
		if("clear_virus")
			var/choice = input("Are you sure you want to cure all disease?") in list("Yes", "Cancel")
			if(choice == "Yes")
				message_admins("[key_name_admin(holder)] has cured all diseases.")
				for(var/thing in SSdisease.active_diseases)
					var/datum/disease/D = thing
					D.cure(0)
		if("list_bombers")
			var/dat = "<B>Bombing List</B><HR>"
			for(var/l in GLOB.bombers)
				dat += text("[l]<BR>")
			holder << browse(dat, "window=bombers")

		if("list_signalers")
			var/dat = "<B>Showing last [length(GLOB.lastsignalers)] signalers.</B><HR>"
			for(var/sig in GLOB.lastsignalers)
				dat += "[sig]<BR>"
			holder << browse(dat, "window=lastsignalers;size=800x500")
		if("list_lawchanges")
			var/dat = "<B>Showing last [length(GLOB.lawchanges)] law changes.</B><HR>"
			for(var/sig in GLOB.lawchanges)
				dat += "[sig]<BR>"
			holder << browse(dat, "window=lawchanges;size=800x500")
		if("showailaws")
			holder.holder.output_ai_laws()//huh, inconvenient var naming, huh?
		if("showgm")
			if(!SSticker.HasRoundStarted())
				alert("The game hasn't started yet!")
			else if (SSticker.mode)
				alert("The game mode is [SSticker.mode.name]")
			else
				alert("For some reason there's a SSticker, but not a game mode")
		if("manifest")
			GLOB.crew_manifest_tgui.ui_interact(holder)
		if("dna")
			var/dat = "<B>Showing DNA from blood.</B><HR>"
			dat += "<table cellspacing=5><tr><th>Name</th><th>DNA</th><th>Blood Type</th></tr>"
			for(var/i in GLOB.human_list)
				var/mob/living/carbon/human/H = i
				if(H.ckey)
					dat += "<tr><td>[H]</td><td>[H.dna.unique_enzymes]</td><td>[H.dna.blood_type.name]</td></tr>"
			dat += "</table>"
			holder << browse(dat, "window=DNA;size=440x410")
		if("fingerprints")
			var/dat = "<B>Showing Fingerprints.</B><HR>"
			dat += "<table cellspacing=5><tr><th>Name</th><th>Fingerprints</th></tr>"
			for(var/i in GLOB.human_list)
				var/mob/living/carbon/human/H = i
				if(H.ckey)
					dat += "<tr><td>[H]</td><td>[md5(H.dna.uni_identity)]</td></tr>"
			dat += "</table>"
			holder << browse(dat, "window=fingerprints;size=440x410")
		if("ctfbutton")
			toggle_all_ctf(holder)
		if("tdomereset")
			var/delete_mobs = alert("Clear all mobs?","Confirm","Yes","No","Cancel")
			if(delete_mobs == "Cancel")
				return

			log_admin("[key_name(holder)] reset the thunderdome to default with delete_mobs==[delete_mobs].", 1)
			message_admins(span_adminnotice("[key_name_admin(holder)] reset the thunderdome to default with delete_mobs==[delete_mobs]."))

			var/area/thunderdome = GLOB.areas_by_type[/area/tdome/arena]
			if(delete_mobs == "Yes")
				for(var/mob/living/mob in thunderdome)
					qdel(mob) //Clear mobs
			for(var/obj/obj in thunderdome)
				if(!istype(obj, /obj/machinery/camera))
					qdel(obj) //Clear objects

			var/area/template = GLOB.areas_by_type[/area/tdome/arena_source]
			template.copy_contents_to(thunderdome)
		if("set_name")
			var/new_name = input(holder, "Please input a new name for the sector.", "What?", "") as text|null
			if(!new_name)
				return
			set_station_name(new_name)
			log_admin("[key_name(holder)] renamed the sector to \"[new_name]\".")
			message_admins(span_adminnotice("[key_name_admin(holder)] renamed the station to: [new_name]."))
			priority_announce("[command_name()] has renamed the sector to \"[new_name]\".")
		if("reset_name")
			var/new_name = new_station_name()
			set_station_name(new_name)
			log_admin("[key_name(holder)] reset the sector's name.")
			message_admins(span_adminnotice("[key_name_admin(holder)] reset the sector's name."))
			priority_announce("[command_name()] has renamed the sector to \"[new_name]\".")
		//!fun! buttons.
		if("allspecies")
			if(!is_funmin)
				return
			var/result = input(holder, "Please choose a new species","Species") as null|anything in GLOB.species_list
			if(result)
				SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Mass Species Change", "[result]"))
				log_admin("[key_name(holder)] turned all humans into [result]", 1)
				message_admins("\blue [key_name_admin(holder)] turned all humans into [result]")
				var/newtype = GLOB.species_list[result]
				for(var/i in GLOB.human_list)
					var/mob/living/carbon/human/H = i
					H.set_species(newtype)
		if("power")
			if(!is_funmin)
				return
			var/result = input(holder, "Please choose what Z level to power. Specify none to power all Zs.","Power") as null|num
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Power All APCs"))
			log_admin("[key_name(holder)] made all areas powered", 1)
			message_admins(span_adminnotice("[key_name_admin(holder)] made all areas powered"))
			power_restore(result)
		if("unpower")
			if(!is_funmin)
				return
			var/result = input(holder, "Please choose what Z level to depower. Specify none to power all Zs.","Unpower") as null|num
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Depower All APCs"))
			log_admin("[key_name(holder)] made all areas unpowered", 1)
			message_admins(span_adminnotice("[key_name_admin(holder)] made all areas unpowered"))
			power_failure(result)
		if("quickpower")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Power All SMESs"))
			log_admin("[key_name(holder)] made all SMESs powered", 1)
			message_admins(span_adminnotice("[key_name_admin(holder)] made all SMESs powered"))
			power_restore_quick()
		if("guns")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Summon Guns"))
			var/survivor_probability = 0
			switch(alert("Do you want this to create survivors antagonists?",,"No Antags","Some Antags","All Antags!"))
				if("Some Antags")
					survivor_probability = 25
				if("All Antags!")
					survivor_probability = 100

			rightandwrong(SUMMON_GUNS, holder, survivor_probability)
		if("magic")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Summon Magic"))
			var/survivor_probability = 0
			switch(alert("Do you want this to create magician antagonists?",,"No Antags","Some Antags","All Antags!"))
				if("Some Antags")
					survivor_probability = 25
				if("All Antags!")
					survivor_probability = 100

			rightandwrong(SUMMON_MAGIC, holder, survivor_probability)
		if("events")
			if(!is_funmin)
				return
			if(!SSevents.wizardmode)
				if(alert("Do you want to toggle summon events on?",,"Yes","No") == "Yes")
					summonevents()
					SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Summon Events", "Activate"))

			else
				switch(alert("What would you like to do?",,"Intensify Summon Events","Turn Off Summon Events","Nothing"))
					if("Intensify Summon Events")
						summonevents()
						SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Summon Events", "Intensify"))
					if("Turn Off Summon Events")
						SSevents.toggleWizardmode()
						SSevents.resetFrequency()
						SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Summon Events", "Disable"))
		if("blackout")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Break All Lights"))
			message_admins("[key_name_admin(holder)] broke all lights")
			for(var/obj/machinery/light/L in GLOB.machines)
				L.break_light_tube()
		if("whiteout")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Fix All Lights"))
			message_admins("[key_name_admin(holder)] fixed all lights")
			for(var/obj/machinery/light/L in GLOB.machines)
				L.fix()
		if("changebombcap")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Bomb Cap"))

			var/newBombCap = input(holder,"What would you like the new bomb cap to be. (entered as the light damage range (the 3rd number in common (1,2,3) notation)) Must be above 4)", "New Bomb Cap", GLOB.MAX_EX_LIGHT_RANGE) as num|null
			if (!CONFIG_SET(number/bombcap, newBombCap))
				return

			message_admins(span_boldannounce("[key_name_admin(holder)] changed the bomb cap to [GLOB.MAX_EX_DEVESTATION_RANGE], [GLOB.MAX_EX_HEAVY_RANGE], [GLOB.MAX_EX_LIGHT_RANGE]"))
			log_admin("[key_name(holder)] changed the bomb cap to [GLOB.MAX_EX_DEVESTATION_RANGE], [GLOB.MAX_EX_HEAVY_RANGE], [GLOB.MAX_EX_LIGHT_RANGE]")
		//buttons that are fun for exactly you and nobody else.
		if("monkey")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Monkeyize All Humans"))
			for(var/i in GLOB.human_list)
				var/mob/living/carbon/human/H = i
				INVOKE_ASYNC(H, TYPE_PROC_REF(/mob/living/carbon, monkeyize))
			ok = TRUE
		if("traitor_all")
			if(!is_funmin)
				return
			if(!SSticker.HasRoundStarted())
				alert("The game hasn't started yet!")
				return
			var/objective = stripped_input(holder, "Enter an objective")
			if(!objective)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Traitor All", "[objective]"))
			for(var/mob/living/H in GLOB.player_list)
				if(!(ishuman(H)||istype(H, /mob/living/silicon/)))
					continue
				if(H.stat == DEAD || !H.mind || ispAI(H))
					continue
				if(is_special_character(H))
					continue
				var/datum/antagonist/traitor/T = new()
				T.give_objectives = FALSE
				var/datum/objective/new_objective = new
				new_objective.owner = H
				new_objective.explanation_text = objective
				T.add_objective(new_objective)
				H.mind.add_antag_datum(T)
			message_admins(span_adminnotice("[key_name_admin(holder)] used everyone is a traitor secret. Objective is [objective]"))
			log_admin("[key_name(holder)] used everyone is a traitor secret. Objective is [objective]")
		if("massbraindamage")
			if(!is_funmin)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Mass Braindamage"))
			for(var/mob/living/carbon/human/H in GLOB.player_list)
				to_chat(H, span_boldannounce("You suddenly feel stupid."), confidential = TRUE)
				H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 60, 80)
			message_admins("[key_name_admin(holder)] made everybody brain damaged")
		if("floorlava")
			/// Should point to a central mapzone.weather_controller, one doesn't exist in shiptest
			WARNING("Floor lava bus is not implemented.")
			return
		if("anime")
			if(!is_funmin)
				return
			var/animetype = alert("Would you like to have the clothes be changed?",,"Yes","No","Cancel")

			var/droptype
			if(animetype =="Yes")
				droptype = alert("Make the uniforms Nodrop?",,"Yes","No","Cancel")

			if(animetype == "Cancel" || droptype == "Cancel")
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Chinese Cartoons"))
			message_admins("[key_name_admin(holder)] made everything kawaii.")
			for(var/i in GLOB.human_list)
				var/mob/living/carbon/human/H = i
				SEND_SOUND(H, sound('sound/ai/animes.ogg'))

				if(H.dna.species.id == SPECIES_HUMAN)
					if(H.dna.features["tail_human"] == "None" || H.dna.features["ears"] == "None")
						var/obj/item/organ/ears/cat/ears = new
						var/obj/item/organ/tail/cat/tail = new
						ears.Insert(H, drop_if_replaced=FALSE)
						tail.Insert(H, drop_if_replaced=FALSE)
					var/list/honorifics = list("[MALE]" = list("kun"), "[FEMALE]" = list("chan","tan"), "[NEUTER]" = list("san"), "[PLURAL]" = list("san")) //John Robust -> Robust-kun
					var/list/names = splittext(H.real_name," ")
					var/forename = names.len > 1 ? names[2] : names[1]
					var/newname = "[forename]-[pick(honorifics["[H.gender]"])]"
					H.fully_replace_character_name(H.real_name,newname)
					H.update_mutant_bodyparts()
					if(animetype == "Yes")
						var/seifuku = pick(typesof(/obj/item/clothing/under/costume/schoolgirl))
						var/obj/item/clothing/under/costume/schoolgirl/I = new seifuku
						var/olduniform = H.w_uniform
						H.temporarilyRemoveItemFromInventory(H.w_uniform, TRUE, FALSE)
						H.equip_to_slot_or_del(I, ITEM_SLOT_ICLOTHING)
						qdel(olduniform)
						if(droptype == "Yes")
							ADD_TRAIT(I, TRAIT_NODROP, ADMIN_TRAIT)
				else
					to_chat(H, span_warning("You're not kawaii enough for this!"), confidential = TRUE)
		if("masspurrbation")
			if(!is_funmin)
				return
			mass_purrbation()
			message_admins("[key_name_admin(holder)] has put everyone on \
				purrbation!")
			log_admin("[key_name(holder)] has put everyone on purrbation.")
		if("massremovepurrbation")
			if(!is_funmin)
				return
			mass_remove_purrbation()
			message_admins("[key_name_admin(holder)] has removed everyone from \
				purrbation.")
			log_admin("[key_name(holder)] has removed everyone from purrbation.")
		if("massimmerse")
			if(!is_funmin)
				return
			mass_immerse()
			message_admins("[key_name_admin(holder)] has Fully Immersed \
				everyone!")
			log_admin("[key_name(holder)] has Fully Immersed everyone.")
		if("unmassimmerse")
			if(!is_funmin)
				return
			mass_immerse(remove=TRUE)
			message_admins("[key_name_admin(holder)] has Un-Fully Immersed \
				everyone!")
			log_admin("[key_name(holder)] has Un-Fully Immersed everyone.")
	if(E)
		E.processing = FALSE
		if(E.announce_when>0)
			switch(alert(holder, "Would you like to alert the crew?", "Alert", "Yes", "No", "Cancel"))
				if("Yes")
					E.announce_chance = 100
				if("Cancel")
					E.kill()
					return
				if("No")
					E.announce_chance = 0
		E.processing = TRUE
	if(holder)
		log_admin("[key_name(holder)] used secret [action]")
		if(ok)
			to_chat(world, text("<B>A secret has been activated by []!</B>", holder.key), confidential = TRUE)

/proc/portalAnnounce(announcement, playlightning)
	set waitfor = 0
	if (playlightning)
		sound_to_playing_players('sound/magic/lightning_chargeup.ogg')
		sleep(80)
	priority_announce(replacetext(announcement, "%STATION%", station_name()))
	if (playlightning)
		sleep(20)
		sound_to_playing_players('sound/magic/lightningbolt.ogg')

/proc/doPortalSpawn(turf/loc, mobtype, numtospawn, portal_appearance, players, humanoutfit)
	for (var/i in 1 to numtospawn)
		var/mob/spawnedMob = new mobtype(loc)
		if (length(players))
			var/mob/chosen = players[1]
			if (chosen.client)
				chosen.client.prefs.copy_to(spawnedMob)
				spawnedMob.key = chosen.key
			players -= chosen
		if (ishuman(spawnedMob) && ispath(humanoutfit, /datum/outfit))
			var/mob/living/carbon/human/H = spawnedMob
			H.equipOutfit(humanoutfit)
	var/turf/T = get_step(loc, SOUTHWEST)
	flick_overlay_static(portal_appearance, T, 15)
	playsound(T, 'sound/magic/lightningbolt.ogg', rand(80, 100), TRUE)
