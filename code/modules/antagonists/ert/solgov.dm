// ********************************************************************
// ** SolGov **
// ********************************************************************
/datum/antagonist/ert/solgov
	name = "SolGov Sonnensöldner"
	outfit = /datum/outfit/job/solgov/ert
	random_names = FALSE
	role = "Sonnensöldner"

/datum/antagonist/ert/solgov/inspector
	name = "SolGov Inspector"
	outfit = /datum/outfit/job/solgov/ert/inspector
	role = "Solarian Inspector"

/datum/antagonist/ert/solgov/inspector/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the Solarian Inspector.</font></B>")
	to_chat(owner, "The Department of Administrative Affairs is sending you to [station_name()] with the task: [ert_team.mission.explanation_text]")
