/datum/antagonist/ert/inteq
	name = "Inteq Mercenary"
	outfit = /datum/outfit/job/inteq/security
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

/datum/antagonist/ert/inteq/leader
	name = "Inteq Mercenary Leader"
	outfit = /datum/outfit/job/inteq/captain/empty
	role = "Vanguard"
