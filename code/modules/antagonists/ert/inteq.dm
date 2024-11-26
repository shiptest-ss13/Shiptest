/datum/antagonist/ert/inteq
	name = "Inteq Mercenary"
	outfit = /datum/outfit/job/inteq/ert
	random_names = TRUE
	role = "Enforcer"

/datum/antagonist/ert/inteq/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You're one of the many mercenaries under the Inteq Risk Management Group sent to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your squadron to ensure the completion of your contract."
	else
		missiondesc += "Follow orders given to you by your Vanguard."
	if(deathsquad)
		missiondesc += "Leave no witnesses."

	missiondesc += "<BR><B>Contract Terms</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/inteq/eva
	outfit = /datum/outfit/job/inteq/ert/eva

/datum/antagonist/ert/inteq/leader
	name = "Inteq Mercenary Leader"
	outfit = /datum/outfit/job/inteq/ert/leader
	role = "Vanguard"

/datum/antagonist/ert/inteq/leader/eva
	outfit = /datum/outfit/job/inteq/ert/leader/eva

/datum/antagonist/ert/inteq/medic
	name = "Inteq Corpsman"
	outfit = /datum/outfit/job/inteq/ert/medic
	role = "Corpsman"

/datum/antagonist/ert/inteq/medic/eva
	outfit = /datum/outfit/job/inteq/ert/medic/eva

/datum/antagonist/ert/inteq/engineer
	name = "Inteq Artificer"
	outfit = /datum/outfit/job/inteq/ert/engineer
	role = "Artificer"

/datum/antagonist/ert/inteq/engineer/eva
	outfit = /datum/outfit/job/inteq/ert/engineer/eva

/datum/antagonist/ert/inteq/honor_guard
	name = "Inteq Honor Guard"
	outfit = /datum/outfit/job/inteq/ert/honor_guard
	role = "Guardsman"

/datum/antagonist/ert/inteq/inspector
	name = "Mothership Investigator"
	outfit = /datum/outfit/job/inteq/ert/inspector
	random_names = FALSE
	role = "Investigator"
