// ********************************************************************
// ** Minutemen **
// ********************************************************************

/datum/antagonist/ert/minutemen
	name = "Minutemen Infantry"
	outfit = /datum/outfit/job/minutemen/ert
	role = "Minuteman"

/datum/antagonist/ert/minutemen/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You stand shoulder to shoulder with your fellow colonists in the Colonial Minutemen within [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the completion of your objectives."
	else
		missiondesc += "Follow orders given to you by your Sergent."
	if(deathsquad)
		missiondesc += "Leave no witnesses."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/minutemen/leader
	name = "Minutemen Leader"
	leader = TRUE
	outfit = /datum/outfit/job/minutemen/ert/leader
	role = "Sergeant"

/datum/antagonist/ert/minutemen/bard
	name = "BARD Infantry"
	outfit = /datum/outfit/job/minutemen/ert/bard
	role = "Minuteman"

/datum/antagonist/ert/minutemen/bard/leader
	name = "BARD Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/minutemen/ert/bard/leader
	role = "Sergeant"

/datum/antagonist/ert/minutemen/riot
	name = "Riot Officer"
	outfit = /datum/outfit/job/minutemen/ert/riot
	role = "Minuteman"

/datum/antagonist/ert/minutemen/riot/leader
	name = "Riot Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/minutemen/ert/riot/leader
	role = "Sergeant"

/datum/antagonist/ert/official/minutemen
	name = "GOLD Inspector"
	outfit = /datum/outfit/job/minutemen/ert/inspector
	role = "Lieutenant"

/datum/antagonist/ert/official/minutemen/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the GOLD Inspector.</font></B>")
	if (ert_team)
		to_chat(owner, "You are part of The Galactic Optimum Labor Division, a division of the Colonial League. Your task: [ert_team.mission.explanation_text]")
	else
		to_chat(owner, "You are part of The Galactic Optimum Labor Division, a division of the Colonial League. Your task: [ert_team.mission.explanation_text]")

/datum/antagonist/ert/minutemen/piratehunters
	name = "Pirate Hunter"
	outfit = /datum/outfit/job/minutemen/ert/pirate_hunter
	role = "Minuteman"

/datum/antagonist/ert/minutemen/piratehunters/leader
	name = "Pirate Hunter Leader"
	leader = TRUE
	outfit = /datum/outfit/job/minutemen/ert/pirate_hunter/leader
	role = "Sergeant"
