/// If we spawn an ERT with the "choose experienced leader" option, select the leader from the top X playtimes
#define ERT_EXPERIENCED_LEADER_CHOOSE_TOP 3

/client/proc/one_click_antag()
	set name = "Create Antagonist"
	set desc = "Auto-create an antagonist of your choice"
	set category = "Event"

	if(holder)
		holder.one_click_antag()
	return


/datum/admins/proc/one_click_antag()

	var/dat = {"
		<a href='?src=[REF(src)];[HrefToken()];makeAntag=traitors'>Make Traitors</a><br>
		<a href='?src=[REF(src)];[HrefToken()];makeAntag=changelings'>Make Changelings</a><br>
		<a href='?src=[REF(src)];[HrefToken()];makeAntag=wizard'>Make Wizard (Requires Ghosts)</a><br>
		<a href='?src=[REF(src)];[HrefToken()];makeAntag=nukeops'>Make Nuke Team (Requires Ghosts)</a><br>
		<a href='?src=[REF(src)];[HrefToken()];makeAntag=centcom'>Make Response Team (Requires Ghosts)</a><br>
		<a href='?src=[REF(src)];[HrefToken()];makeAntag=abductors'>Make Abductor Team (Requires Ghosts)</a><br>
		<a href='?src=[REF(src)];[HrefToken()];makeAntag=revenant'>Make Revenant (Requires Ghost)</a><br>
		"}

	var/datum/browser/popup = new(usr, "oneclickantag", "Quick-Create Antagonist", 400, 400)
	popup.set_content(dat)
	popup.open()

/datum/admins/proc/isReadytoRumble(mob/living/carbon/human/applicant, targetrole, conscious = TRUE)
	if(applicant.mind.special_role)
		return FALSE
	if(!(targetrole in applicant.client.prefs.be_special))
		return FALSE
	if(conscious && applicant.stat) //incase you don't care about a certain antag being unconcious when made, ie if they have selfhealing abilities.
		return FALSE
	if(!considered_alive(applicant.mind) || considered_afk(applicant.mind)) //makes sure the player isn't a zombie, brain, or just afk all together
		return FALSE
	return !is_banned_from(applicant.ckey, list(targetrole, ROLE_SYNDICATE))


/datum/admins/proc/makeTraitors()
	var/datum/game_mode/traitor/temp = new

	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		temp.restricted_jobs += temp.protected_jobs

	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		temp.restricted_jobs += "Assistant"

	var/list/mob/living/carbon/human/candidates = list()
	var/mob/living/carbon/human/H = null

	for(var/mob/living/carbon/human/applicant in GLOB.player_list)
		if(isReadytoRumble(applicant, ROLE_TRAITOR))
			if(temp.age_check(applicant.client))
				if(!(applicant.job in temp.restricted_jobs))
					candidates += applicant

	if(candidates.len)
		var/numTraitors = min(candidates.len, 3)

		for(var/i = 0, i<numTraitors, i++)
			H = pick(candidates)
			H.mind.make_Traitor()
			candidates.Remove(H)

		return 1


	return 0


/datum/admins/proc/makeChangelings()

	var/datum/game_mode/changeling/temp = new
	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		temp.restricted_jobs += temp.protected_jobs

	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		temp.restricted_jobs += "Assistant"

	var/list/mob/living/carbon/human/candidates = list()
	var/mob/living/carbon/human/H = null

	for(var/mob/living/carbon/human/applicant in GLOB.player_list)
		if(isReadytoRumble(applicant, ROLE_CHANGELING))
			if(temp.age_check(applicant.client))
				if(!(applicant.job in temp.restricted_jobs))
					candidates += applicant

	if(candidates.len)
		var/numChangelings = min(candidates.len, 3)

		for(var/i = 0, i<numChangelings, i++)
			H = pick(candidates)
			H.mind.make_Changeling()
			candidates.Remove(H)

		return 1

	return 0


/datum/admins/proc/makeWizard()

	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you wish to be considered for the position of a Wizard Foundation 'diplomat'?", ROLE_WIZARD, null)

	var/mob/dead/observer/selected = pick_n_take(candidates)

	var/mob/living/carbon/human/new_character = makeBody(selected)
	new_character.mind.make_Wizard()
	return TRUE

/datum/admins/proc/makeNukeTeam()
	var/datum/game_mode/nuclear/temp = new
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you wish to be considered for a nuke team being sent in?", ROLE_OPERATIVE, temp)
	var/list/mob/dead/observer/chosen = list()
	var/mob/dead/observer/theghost = null

	if(candidates.len)
		var/numagents = 5
		var/agentcount = 0

		for(var/i = 0, i<numagents,i++)
			shuffle_inplace(candidates) //More shuffles means more randoms
			for(var/mob/j in candidates)
				if(!j || !j.client)
					candidates.Remove(j)
					continue

				theghost = j
				candidates.Remove(theghost)
				chosen += theghost
				agentcount++
				break
		//Making sure we have atleast 3 Nuke agents, because less than that is kinda bad
		if(agentcount < 3)
			return 0

		//Let's find the spawn locations
		var/leader_chosen = FALSE
		var/datum/team/nuclear/nuke_team
		for(var/mob/c in chosen)
			var/mob/living/carbon/human/new_character=makeBody(c)
			if(!leader_chosen)
				leader_chosen = TRUE
				var/datum/antagonist/nukeop/N = new_character.mind.add_antag_datum(/datum/antagonist/nukeop/leader)
				nuke_team = N.nuke_team
			else
				new_character.mind.add_antag_datum(/datum/antagonist/nukeop,nuke_team)
		return 1
	else
		return 0





/datum/admins/proc/makeAliens()
	var/datum/round_event/ghost_role/alien_infestation/E = new(FALSE)
	E.spawncount = 3
	// TODO The fact we have to do this rather than just have events start
	// when we ask them to, is bad.
	E.processing = TRUE
	return TRUE

/datum/admins/proc/makeSpaceNinja()
	new /datum/round_event/ghost_role/ninja()
	return 1

// DEATH SQUADS
/datum/admins/proc/makeDeathsquad()
	return makeEmergencyresponseteam(/datum/ert/deathsquad)

// CENTCOM RESPONSE TEAM

/datum/admins/proc/makeERTTemplateModified(list/settings)
	. = settings
	var/datum/ert/newtemplate = settings["mainsettings"]["template"]["value"]
	if (isnull(newtemplate))
		return
	if (!ispath(newtemplate))
		newtemplate = text2path(newtemplate)
	newtemplate = new newtemplate
	.["mainsettings"]["teamsize"]["value"] = newtemplate.teamsize
	.["mainsettings"]["mission"]["value"] = newtemplate.mission
	.["mainsettings"]["polldesc"]["value"] = newtemplate.polldesc
	.["mainsettings"]["open_armory"]["value"] = newtemplate.opendoors ? "Yes" : "No"
	.["mainsettings"]["leader_experience"]["value"] = newtemplate.leader_experience ? "Yes" : "No"
	.["mainsettings"]["random_names"]["value"] = newtemplate.random_names ? "Yes" : "No"
	.["mainsettings"]["limit_slots"]["value"] = newtemplate.limit_slots ? "Yes" : "No"
	.["mainsettings"]["spawn_admin"]["value"] = newtemplate.spawn_admin ? "Yes" : "No"
	.["mainsettings"]["use_custom_shuttle"]["value"] = newtemplate.use_custom_shuttle ? "Yes" : "No"
	.["mainsettings"]["spawn_at_outpost"]["value"] = newtemplate.spawn_at_outpost ? "Yes" : "No"


/datum/admins/proc/equipAntagOnDummy(mob/living/carbon/human/dummy/mannequin, datum/antagonist/antag)
	for(var/I in mannequin.get_equipped_items(TRUE))
		qdel(I)
	if (ispath(antag, /datum/antagonist/ert))
		var/datum/antagonist/ert/ert = antag
		mannequin.equipOutfit(initial(ert.outfit), TRUE)

/datum/admins/proc/makeERTPreviewIcon(list/settings)
	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_ADMIN)

	var/prefs = settings["mainsettings"]
	var/datum/ert/template = prefs["template"]["value"]
	if (isnull(template))
		return null
	if (!ispath(template))
		template = text2path(prefs["template"]["value"]) // new text2path ... doesn't compile in 511

	template = new template
	var/datum/antagonist/ert/ert = template.leader_role

	equipAntagOnDummy(mannequin, ert)

	COMPILE_OVERLAYS(mannequin)
	CHECK_TICK
	var/icon/preview_icon = icon('icons/effects/effects.dmi', "nothing")
	preview_icon.Scale(48+32, 16+32)
	CHECK_TICK
	mannequin.setDir(NORTH)
	var/icon/stamp = getFlatIcon(mannequin)
	CHECK_TICK
	preview_icon.Blend(stamp, ICON_OVERLAY, 25, 17)
	CHECK_TICK
	mannequin.setDir(WEST)
	stamp = getFlatIcon(mannequin)
	CHECK_TICK
	preview_icon.Blend(stamp, ICON_OVERLAY, 1, 9)
	CHECK_TICK
	mannequin.setDir(SOUTH)
	stamp = getFlatIcon(mannequin)
	CHECK_TICK
	preview_icon.Blend(stamp, ICON_OVERLAY, 49, 1)
	CHECK_TICK
	preview_icon.Scale(preview_icon.Width() * 2, preview_icon.Height() * 2) // Scaling here to prevent blurring in the browser.
	CHECK_TICK
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_ADMIN)
	return preview_icon

/datum/admins/proc/makeEmergencyresponseteam(datum/ert/ertemplate = null)
	if (ertemplate)
		ertemplate = new ertemplate
	else
		ertemplate = new /datum/ert/centcom_official

	var/list/settings = list(
		"preview_callback" = CALLBACK(src, PROC_REF(makeERTPreviewIcon)),
		"mainsettings" = list(
		"template" = list("desc" = "Template", "callback" = CALLBACK(src, PROC_REF(makeERTTemplateModified)), "type" = "datum", "path" = "/datum/ert", "subtypesonly" = TRUE, "value" = ertemplate.type),
		"teamsize" = list("desc" = "Team Size", "type" = "number", "value" = ertemplate.teamsize),
		"mission" = list("desc" = "Mission", "type" = "string", "value" = ertemplate.mission),
		"polldesc" = list("desc" = "Ghost poll description", "type" = "string", "value" = ertemplate.polldesc),
		"enforce_human" = list("desc" = "Spawn as humans", "type" = "boolean", "value" = "[(ertemplate.enforce_human ? "Yes" : "No")]"),
		"open_armory" = list("desc" = "Open armory doors", "type" = "boolean", "value" = "[(ertemplate.opendoors ? "Yes" : "No")]"),
		"leader_experience" = list("desc" = "Pick an experienced leader", "type" = "boolean", "value" = "[(ertemplate.leader_experience ? "Yes" : "No")]"),
		"random_names" = list("desc" = "Randomize names", "type" = "boolean", "value" = "[(ertemplate.random_names ? "Yes" : "No")]"),
		"limit_slots" = list("desc" = "Limit special roles", "type" = "boolean", "value" = "[(ertemplate.limit_slots ? "Yes" : "No")]"),
		"spawn_admin" = list("desc" = "Spawn yourself as briefing officer", "type" = "boolean", "value" = "[(ertemplate.spawn_admin ? "Yes" : "No")]"),
		"use_custom_shuttle" = list("desc" = "Use the ERT's custom shuttle (if it has one)", "type" = "boolean", "value" = "[(ertemplate.use_custom_shuttle ? "Yes" : "No")]"),
		"spawn_at_outpost" = list("desc" = "Spawn the ERT/Dock the ERT at the Outpost", "type" = "boolean", "value" = "[(ertemplate.spawn_at_outpost ? "Yes" : "No")]"),
		)
	)

	var/list/prefreturn = presentpreflikepicker(usr, "Customize ERT", "Customize ERT", Button1="Ok", width = 600, StealFocus = 1,Timeout = 0, settings=settings)

	if (isnull(prefreturn))
		return FALSE

	if (prefreturn["button"] == 1)
		var/list/prefs = settings["mainsettings"]

		var/templtype = prefs["template"]["value"]
		if (!ispath(prefs["template"]["value"]))
			templtype = text2path(prefs["template"]["value"]) // new text2path ... doesn't compile in 511

		if (ertemplate.type != templtype)
			ertemplate = new templtype

		ertemplate.teamsize = prefs["teamsize"]["value"]
		ertemplate.mission = prefs["mission"]["value"]
		ertemplate.polldesc = prefs["polldesc"]["value"]
		ertemplate.enforce_human = prefs["enforce_human"]["value"] == "Yes" // these next 8 are effectively toggles
		ertemplate.opendoors = prefs["open_armory"]["value"] == "Yes"
		ertemplate.leader_experience = prefs["leader_experience"]["value"] == "Yes"
		ertemplate.random_names = prefs["random_names"]["value"] == "Yes"
		ertemplate.limit_slots = prefs["limit_slots"]["value"] == "Yes"
		ertemplate.spawn_admin = prefs["spawn_admin"]["value"] == "Yes"
		ertemplate.use_custom_shuttle = prefs["use_custom_shuttle"]["value"] == "Yes"
		ertemplate.spawn_at_outpost = prefs["spawn_at_outpost"]["value"] == "Yes"

		var/list/spawnpoints = GLOB.emergencyresponseteamspawn
		var/index = 0

		var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you wish to be considered for [ertemplate.polldesc]?", "deathsquad")
		var/teamSpawned = FALSE

		// This list will take priority over spawnpoints if not empty
		var/list/spawn_turfs = list()

		// Takes precedence over spawnpoints[1] if not null
		var/turf/brief_spawn

		if(!length(candidates))
			to_chat(usr, span_warning("No applicants for ERT. Aborting spawn."))
			return FALSE

		if(ertemplate.use_custom_shuttle && ertemplate.ert_template)
			to_chat(usr, span_boldnotice("Attempting to spawn ERT custom shuttle, this may take a few seconds..."))

			var/datum/map_template/shuttle/template = new ertemplate.ert_template
			var/spawn_location

			if(ertemplate.spawn_at_outpost)
				if(length(SSovermap.outposts) > 1)
					var/temp_loc = input(usr, "Select outpost to spawn at") as null|anything in SSovermap.outposts
					if(!temp_loc)
						message_admins("ERT found no outpost to spawn at!")
						return
					spawn_location = temp_loc
				else
					spawn_location = SSovermap.outposts[1]

			if(!spawn_location)
				spawn_location = SSovermap.get_unused_overmap_square()

			var/datum/overmap/ship/controlled/ship = new(spawn_location, template)

			if(!ship)
				CRASH("Loading ERT shuttle failed!")

			var/list/shuttle_turfs = ship.shuttle_port.return_turfs()

			for(var/turf/ship_turfs as anything in shuttle_turfs)
				for(var/obj/effect/landmark/ert_shuttle_spawn/spawner in ship_turfs)
					spawn_turfs += get_turf(spawner)

				if(!brief_spawn)
					brief_spawn = locate(/obj/effect/landmark/ert_shuttle_brief_spawn) in ship_turfs

			if(!length(spawn_turfs))
				stack_trace("ERT shuttle loaded but found no spawnpoints, placing the ERT at wherever inside the shuttle instead.")
				for(var/turf/open/floor/open_turf in shuttle_turfs)
					if(!find_safe_turf(open_turf))
						continue
					spawn_turfs += open_turf

		if(!ertemplate.use_custom_shuttle && ertemplate.spawn_at_outpost)
			if(!length(GLOB.emergencyresponseteam_outpostspawn))
				message_admins("No outpost spawns found!")
			spawn_turfs = GLOB.emergencyresponseteam_outpostspawn

		if(ertemplate.spawn_admin)
			if(isobserver(usr))
				var/mob/living/carbon/human/admin_officer = new (brief_spawn || spawnpoints[1])
				var/chosen_outfit = usr.client?.prefs?.brief_outfit
				usr.client.prefs.copy_to(admin_officer)
				admin_officer.equipOutfit(chosen_outfit)
				admin_officer.key = usr.key
			else
				to_chat(usr, span_warning("Could not spawn you in as briefing officer as you are not a ghost!"))

		//Pick the (un)lucky players
		var/numagents = min(ertemplate.teamsize, length(candidates))

		//Create team
		var/datum/team/ert/ert_team = new ertemplate.team
		if(ertemplate.rename_team)
			ert_team.name = ertemplate.rename_team

		//Assign team objective
		var/datum/objective/missionobj = new
		missionobj.team = ert_team
		missionobj.explanation_text = ertemplate.mission
		missionobj.completed = TRUE
		ert_team.objectives += missionobj
		ert_team.mission = missionobj

		var/mob/dead/observer/earmarked_leader
		var/leader_spawned = FALSE // just in case the earmarked leader disconnects or becomes unavailable, we can try giving leader to the last guy to get chosen

		if(ertemplate.leader_experience)
			var/list/candidate_living_exps = list()
			for(var/i in candidates)
				var/mob/dead/observer/potential_leader = i
				candidate_living_exps[potential_leader] = potential_leader.client?.get_exp_living(TRUE)

			candidate_living_exps = sortList(candidate_living_exps, cmp=/proc/cmp_numeric_dsc)
			if(candidate_living_exps.len > ERT_EXPERIENCED_LEADER_CHOOSE_TOP)
				candidate_living_exps = candidate_living_exps.Cut(ERT_EXPERIENCED_LEADER_CHOOSE_TOP+1) // pick from the top ERT_EXPERIENCED_LEADER_CHOOSE_TOP contenders in playtime
			earmarked_leader = pick(candidate_living_exps)
		else
			earmarked_leader = pick(candidates)

		while(numagents && candidates.len)
			var/turf/spawnloc
			if(length(spawn_turfs))
				spawnloc = pick(spawn_turfs)
			else
				if(!spawnpoints.len)
					CRASH("ERT has no spawnpoints!")
				spawnloc = spawnpoints[index+1]
				//loop through spawnpoints one at a time
				index = (index + 1) % spawnpoints.len

			var/mob/dead/observer/chosen_candidate = earmarked_leader || pick(candidates) // this way we make sure that our leader gets chosen
			candidates -= chosen_candidate
			if(!chosen_candidate.key)
				continue

			//Spawn the body
			var/mob/living/carbon/human/ert_operative = new ertemplate.mobtype(spawnloc)
			chosen_candidate.client.prefs.copy_to(ert_operative)
			ert_operative.key = chosen_candidate.key

			if(ertemplate.enforce_human || !(ert_operative.dna.species.changesource_flags & ERT_SPAWN)) // Don't want any exploding plasmemes
				ert_operative.set_species(/datum/species/human)

			//Give antag datum
			var/datum/antagonist/ert/ert_antag

			if((chosen_candidate == earmarked_leader) || (numagents == 1 && !leader_spawned))
				ert_antag = new ertemplate.leader_role ()
				earmarked_leader = null
				leader_spawned = TRUE
			else if(ertemplate.limit_slots)
				// pick a role from the role list
				var/rolepick
				rolepick = pick(ertemplate.roles)
				var/count = ertemplate.roles[rolepick]
				// is it a special role (does it have a number value)? if not, tough luck, spawn
				if(!isnum(count))
					ert_antag = rolepick
					ert_antag = new ert_antag
				// pick another if the count is 0
				else if(!count)
					continue
				// pick it and decrease the count by one
				else
					count =- 1
					ert_antag = rolepick
					ert_antag = new ert_antag
			else
				ert_antag = ertemplate.roles[WRAP(numagents,1,length(ertemplate.roles) + 1)]
				ert_antag = new ert_antag
			ert_antag.random_names = ertemplate.random_names

			ert_operative.mind.add_antag_datum(ert_antag,ert_team)
			ert_operative.mind.assigned_role = ert_antag.name

			//Logging and cleanup
			log_game("[key_name(ert_operative)] has been selected as an [ert_antag.name]")
			numagents--
			teamSpawned++

		if(teamSpawned)
			// guestbook
			for(var/datum/mind/member in ert_team.members)
				var/member_mob = member.current
				for(var/datum/mind/other_member in ert_team.members)
					// skip yourself
					if(other_member.name == member.name)
						continue
					var/mob/living/carbon/human/other_member_mob = other_member.current
					member.guestbook.add_guest(member_mob, other_member_mob, other_member_mob.real_name, other_member_mob.real_name, TRUE)

			message_admins("[ertemplate.rename_team] has spawned with the mission: [ertemplate.mission]")

		//Open the Armory doors
		if(ertemplate.opendoors)
			for(var/obj/machinery/door/poddoor/ert/door in GLOB.airlocks)
				door.open()
				CHECK_TICK
		return TRUE

	return


//Abductors
/datum/admins/proc/makeAbductorTeam()
	new /datum/round_event/ghost_role/abductor
	return 1

/datum/admins/proc/makeRevenant()
	new /datum/round_event/ghost_role/revenant(TRUE, TRUE)
	return 1

#undef ERT_EXPERIENCED_LEADER_CHOOSE_TOP
