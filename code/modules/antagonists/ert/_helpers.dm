/// If we spawn an ERT with the "choose experienced leader" option, select the leader from the top X playtimes
#define ERT_EXPERIENCED_LEADER_CHOOSE_TOP 3

/proc/makeERT(datum/ert/ertemplate = null)
	if (ertemplate)
		ertemplate = new ertemplate
	else
		ertemplate = new /datum/ert/nanotrasen
	var/list/spawnpoints = GLOB.emergencyresponseteamspawn
	var/index = 0

	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you wish to be considered for [ertemplate.polldesc]?", null)
	var/teamSpawned = FALSE

	// This list will take priority over spawnpoints if not empty
	var/list/spawn_turfs = list()

	// Takes precedence over spawnpoints[1] if not null
	var/turf/brief_spawn

	if(!length(candidates))
		return NOT_ENOUGH_PLAYERS

	if(ertemplate.use_custom_shuttle && ertemplate.ert_template)
		message_admins("Attempting to spawn ERT custom shuttle, this may take a few seconds...")

		var/datum/map_template/shuttle/template = new ertemplate.ert_template
		var/spawn_location

		if(ertemplate.spawn_at_outpost)
			if(length(SSovermap.outposts) > 1)
				var/temp_loc = pick(SSovermap.outposts)
				if(!temp_loc)
					message_admins("ERT found no outpost to spawn at!")
					return MAP_ERROR
				spawn_location = temp_loc
			else
				spawn_location = SSovermap.outposts[1]

		if(!spawn_location)
			spawn_location = SSovermap.safe_system.get_unused_overmap_square()

		var/datum/overmap/ship/controlled/ship = new(spawn_location, template)

		if(!ship)
			stack_trace("Loading ERT shuttle failed!")
			return MAP_ERROR

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
		return SUCCESSFUL_SPAWN

#undef ERT_EXPERIENCED_LEADER_CHOOSE_TOP
