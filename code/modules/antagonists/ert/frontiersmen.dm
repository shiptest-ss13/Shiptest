// ********************************************************************
// ** USCM **
// ********************************************************************

/datum/antagonist/ert/frontier
	name = "USCM Mercanar"
	outfit = /datum/outfit/job/frontiersmen/ert
	role = "Grunt"

/datum/antagonist/ert/frontier/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You are one of the ruthless, sadistic pirates in the USCM pirate fleet, stationed in [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to complete your objectives."
	else
		missiondesc += "Follow orders given to you by your Officer."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/frontier/random
	outfit = /datum/outfit/job/frontiersmen/ert/random

/datum/antagonist/ert/frontier/leader
	name = "USCM Officer"
	outfit = /datum/outfit/job/frontiersmen/ert/leader
	role = "Officer"

/datum/antagonist/ert/frontier/medic
	name = "USCM Medic"
	outfit = /datum/outfit/job/frontiersmen/ert/medic
	role = "Stretcher-Bearer"

/datum/antagonist/ert/frontier/engineer
	name = "USCM Engineer"
	outfit = /datum/outfit/job/frontiersmen/ert/engineer
	role = "Sapper"
