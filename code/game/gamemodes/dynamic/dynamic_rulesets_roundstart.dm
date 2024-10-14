
//////////////////////////////////////////////
//                                          //
//           SYNDICATE TRAITORS             //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/traitor
	name = "Traitors"
	persistent = TRUE
	antag_flag = ROLE_TRAITOR
	antag_datum = /datum/antagonist/traitor/
	minimum_required_age = 0
	protected_roles = list("Prisoner", "Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Research Director", "Chief Medical Officer", "Chief Engineer", "Head of Personnel", "SolGov Representative")
	restricted_roles = list("Cyborg")
	required_candidates = 1
	weight = 5
	cost = 10	// Avoid raising traitor threat above 10, as it is the default low cost ruleset.
	scaling_cost = 10
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	high_population_requirement = 10
	antag_cap = list(1,1,1,1,2,2,2,2,3,3)
	var/autotraitor_cooldown = 450 // 15 minutes (ticks once per 2 sec)

/datum/dynamic_ruleset/roundstart/traitor/pre_execute()
	. = ..()
	var/num_traitors = antag_cap[indice_pop] * (scaled_times + 1)
	for (var/i = 1 to num_traitors)
		var/mob/M = pick_n_take(candidates)
		assigned += M.mind
		M.mind.special_role = ROLE_TRAITOR
		M.mind.restricted_roles = restricted_roles
		GLOB.pre_setup_antags += M.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/traitor/rule_process()
	if (autotraitor_cooldown > 0)
		autotraitor_cooldown--
	else
		autotraitor_cooldown = 450 // 15 minutes
		message_admins("Checking if we can turn someone into a traitor.")
		log_game("DYNAMIC: Checking if we can turn someone into a traitor.")
		mode.picking_specific_rule(/datum/dynamic_ruleset/midround/autotraitor)

//////////////////////////////////////////
//                                      //
//           BLOOD BROTHERS             //
//                                      //
//////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/traitorbro
	name = "Blood Brothers"
	antag_flag = ROLE_BROTHER
	antag_datum = /datum/antagonist/brother/
	protected_roles = list("Prisoner", "Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "SolGov Representative")
	restricted_roles = list("Cyborg", "AI")
	required_candidates = 2
	weight = 4
	cost = 15
	scaling_cost = 15
	requirements = list(40,30,30,20,20,15,15,15,10,10)
	high_population_requirement = 15
	antag_cap = list(2,2,2,2,2,2,2,2,2,2)	// Can pick 3 per team, but rare enough it doesn't matter.
	var/list/datum/team/brother_team/pre_brother_teams = list()
	var/const/min_team_size = 2

/datum/dynamic_ruleset/roundstart/traitorbro/pre_execute()
	. = ..()
	var/num_teams = (antag_cap[indice_pop]/min_team_size) * (scaled_times + 1) // 1 team per scaling
	for(var/j = 1 to num_teams)
		if(candidates.len < min_team_size || candidates.len < required_candidates)
			break
		var/datum/team/brother_team/team = new
		var/team_size = prob(10) ? min(3, candidates.len) : 2
		for(var/k = 1 to team_size)
			var/mob/bro = pick_n_take(candidates)
			assigned += bro.mind
			team.add_member(bro.mind)
			bro.mind.special_role = "brother"
			bro.mind.restricted_roles = restricted_roles
			GLOB.pre_setup_antags += bro.mind
		pre_brother_teams += team
	return TRUE

/datum/dynamic_ruleset/roundstart/traitorbro/execute()
	for(var/datum/team/brother_team/team in pre_brother_teams)
		team.pick_meeting_area()
		team.forge_brother_objectives()
		for(var/datum/mind/M in team.members)
			M.add_antag_datum(/datum/antagonist/brother, team)
			GLOB.pre_setup_antags -= M
		team.update_name()
	mode.brother_teams += pre_brother_teams
	return TRUE

//////////////////////////////////////////////
//                                          //
//               CHANGELINGS                //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/changeling
	name = "Changelings"
	antag_flag = ROLE_CHANGELING
	antag_datum = /datum/antagonist/changeling
	protected_roles = list("Prisoner", "Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Research Director", "Chief Medical Officer", "Chief Engineer", "SolGov Representative")
	restricted_roles = list("AI", "Cyborg")
	required_candidates = 1
	weight = 3
	cost = 15
	scaling_cost = 15
	requirements = list(70,70,60,50,40,20,20,10,10,10)
	high_population_requirement = 10
	antag_cap = list(1,1,1,1,1,2,2,2,2,3)
	var/team_mode_probability = 30

/datum/dynamic_ruleset/roundstart/changeling/pre_execute()
	. = ..()
	var/num_changelings = antag_cap[indice_pop] * (scaled_times + 1)
	for (var/i = 1 to num_changelings)
		var/mob/M = pick_n_take(candidates)
		assigned += M.mind
		M.mind.restricted_roles = restricted_roles
		M.mind.special_role = ROLE_CHANGELING
		GLOB.pre_setup_antags += M.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/changeling/execute()
	var/team_mode = FALSE
	if(prob(team_mode_probability))
		team_mode = TRUE
		var/list/team_objectives = subtypesof(/datum/objective/changeling_team_objective)
		var/list/possible_team_objectives = list()
		for(var/T in team_objectives)
			var/datum/objective/changeling_team_objective/CTO = T
			if(assigned.len >= initial(CTO.min_lings))
				possible_team_objectives += T

		if(possible_team_objectives.len && prob(20*assigned.len))
			GLOB.changeling_team_objective_type = pick(possible_team_objectives)
	for(var/datum/mind/changeling in assigned)
		var/datum/antagonist/changeling/new_antag = new antag_datum()
		new_antag.team_mode = team_mode
		changeling.add_antag_datum(new_antag)
		GLOB.pre_setup_antags -= changeling
	return TRUE

//////////////////////////////////////////////
//                                          //
//               WIZARDS                    //
//                                          //
//////////////////////////////////////////////

// Dynamic is a wonderful thing that adds wizards to every round and then adds even more wizards during the round.
/datum/dynamic_ruleset/roundstart/wizard
	name = "Wizard"
	antag_flag = ROLE_WIZARD
	antag_datum = /datum/antagonist/wizard
	minimum_required_age = 14
	restricted_roles = list("Head of Security", "Captain") // Just to be sure that a wizard getting picked won't ever imply a Captain or HoS not getting drafted
	required_candidates = 1
	weight = 2
	cost = 30
	requirements = list(90,90,70,40,30,20,10,10,10,10)
	high_population_requirement = 10
	var/list/roundstart_wizards = list()

/datum/dynamic_ruleset/roundstart/wizard/acceptable(population=0, threat=0)
	if(GLOB.wizardstart.len == 0)
		log_admin("Cannot accept Wizard ruleset. Couldn't find any wizard spawn points.")
		message_admins("Cannot accept Wizard ruleset. Couldn't find any wizard spawn points.")
		return FALSE
	return ..()

/datum/dynamic_ruleset/roundstart/wizard/pre_execute()
	. = ..()
	if(GLOB.wizardstart.len == 0)
		return FALSE
	mode.antags_rolled += 1
	var/mob/M = pick_n_take(candidates)
	if (M)
		assigned += M.mind
		M.mind.assigned_role = ROLE_WIZARD
		M.mind.special_role = ROLE_WIZARD

	return TRUE

/datum/dynamic_ruleset/roundstart/wizard/execute()
	for(var/datum/mind/M in assigned)
		M.current.forceMove(pick(GLOB.wizardstart))
		M.add_antag_datum(new antag_datum())
	return TRUE

//////////////////////////////////////////////
//                                          //
//          NUCLEAR OPERATIVES              //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/nuclear
	name = "Nuclear Emergency"
	antag_flag = ROLE_OPERATIVE
	antag_datum = /datum/antagonist/nukeop
	var/datum/antagonist/antag_leader_datum = /datum/antagonist/nukeop/leader
	minimum_required_age = 14
	restricted_roles = list("Head of Security", "Captain") // Just to be sure that a nukie getting picked won't ever imply a Captain or HoS not getting drafted
	required_candidates = 5
	weight = 3
	cost = 40
	requirements = list(90,90,90,80,60,40,30,20,10,10)
	high_population_requirement = 10
	flags = HIGHLANDER_RULESET
	antag_cap = list(2,2,2,3,3,3,4,4,5,5)
	var/datum/team/nuclear/nuke_team

/datum/dynamic_ruleset/roundstart/nuclear/ready(forced = FALSE)
	required_candidates = antag_cap[indice_pop]
	. = ..()

/datum/dynamic_ruleset/roundstart/nuclear/pre_execute()
	. = ..()
	// If ready() did its job, candidates should have 5 or more members in it
	var/operatives = antag_cap[indice_pop]
	mode.antags_rolled += operatives
	for(var/operatives_number = 1 to operatives)
		if(candidates.len <= 0)
			break
		var/mob/M = pick_n_take(candidates)
		assigned += M.mind
		M.mind.assigned_role = "Nuclear Operative"
		M.mind.special_role = "Nuclear Operative"
	return TRUE

/datum/dynamic_ruleset/roundstart/nuclear/execute()
	var/leader = TRUE
	for(var/datum/mind/M in assigned)
		if (leader)
			leader = FALSE
			var/datum/antagonist/nukeop/leader/new_op = M.add_antag_datum(antag_leader_datum)
			nuke_team = new_op.nuke_team
		else
			var/datum/antagonist/nukeop/new_op = new antag_datum()
			M.add_antag_datum(new_op)
	return TRUE

/datum/dynamic_ruleset/roundstart/nuclear/round_result()
	var/result = nuke_team.get_result()
	switch(result)
		if(NUKE_RESULT_FLUKE)
			SSticker.mode_result = "loss - syndicate nuked - disk secured"
			SSticker.news_report = NUKE_SYNDICATE_BASE
		if(NUKE_RESULT_NUKE_WIN)
			SSticker.mode_result = "win - syndicate nuke"
			SSticker.news_report = STATION_NUKED
		if(NUKE_RESULT_WRONG_STATION)
			SSticker.mode_result = "halfwin - blew wrong station"
			SSticker.news_report = NUKE_MISS
		if(NUKE_RESULT_CREW_WIN_SYNDIES_DEAD)
			SSticker.mode_result = "loss - evacuation - disk secured - syndi team dead"
			SSticker.news_report = OPERATIVES_KILLED
		if(NUKE_RESULT_CREW_WIN)
			SSticker.mode_result = "loss - evacuation - disk secured"
			SSticker.news_report = OPERATIVES_KILLED
		if(NUKE_RESULT_DISK_LOST)
			SSticker.mode_result = "halfwin - evacuation - disk not secured"
			SSticker.news_report = OPERATIVE_SKIRMISH
		if(NUKE_RESULT_DISK_STOLEN)
			SSticker.mode_result = "halfwin - detonation averted"
			SSticker.news_report = OPERATIVE_SKIRMISH
		else
			SSticker.mode_result = "halfwin - interrupted"
			SSticker.news_report = OPERATIVE_SKIRMISH


// Admin only rulesets. The threat requirement is 101 so it is not possible to roll them.

//////////////////////////////////////////////
//                                          //
//               EXTENDED                   //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/extended
	name = "Extended"
	antag_flag = null
	antag_datum = null
	restricted_roles = list()
	required_candidates = 0
	weight = 3
	cost = 0
	requirements = list(101,101,101,101,101,101,101,101,101,101)
	high_population_requirement = 101

/datum/dynamic_ruleset/roundstart/extended/pre_execute()
	. = ..()
	message_admins("Starting a round of extended.")
	log_game("Starting a round of extended.")
	mode.spend_threat(mode.threat)
	mode.threat_log += "[game_timestamp()]: Extended ruleset set threat to 0."
	return TRUE

//////////////////////////////////////////////
//                                          //
//               CLOWN OPS                  //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/nuclear/clown_ops
	name = "Clown Ops"
	antag_datum = /datum/antagonist/nukeop/clownop
	antag_leader_datum = /datum/antagonist/nukeop/leader/clownop
	requirements = list(101,101,101,101,101,101,101,101,101,101)
	high_population_requirement = 101

/datum/dynamic_ruleset/roundstart/nuclear/clown_ops/pre_execute()
	. = ..()
	if(.)
		for(var/obj/machinery/nuclearbomb/syndicate/S in GLOB.nuke_list)
			var/turf/T = get_turf(S)
			if(T)
				qdel(S)
				new /obj/machinery/nuclearbomb/syndicate/bananium(T)
		for(var/datum/mind/V in assigned)
			V.assigned_role = "Clown Operative"
			V.special_role = "Clown Operative"
