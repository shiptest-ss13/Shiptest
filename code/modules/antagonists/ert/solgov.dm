// ********************************************************************
// ** SolGov **
// ********************************************************************
/datum/antagonist/ert/solgov
	name = "SolGov Sonnensöldner"
	outfit = /datum/outfit/job/solgov/ert
	random_names = FALSE
	role = "Sonnensöldner"

/datum/antagonist/ert/official/solgov
	name = "SolGov Inspector"
	outfit = /datum/outfit/job/solgov/ert/inspector
	role = "Solarian Inspector"

/datum/antagonist/ert/official/solgov/greet()
	to_chat(owner, "<B><font size=3 color=red>You are a Solarian Inspector.</font></B>")
	if (ert_team)
		to_chat(owner, "The Department of Administrative Affairs is sending you to [station_name()] with the task: [ert_team.mission.explanation_text]")
	else
		to_chat(owner, "The Department of Administrative Affairs is sending you to [station_name()] with the task: [mission.explanation_text]")
