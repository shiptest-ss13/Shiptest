// ********************************************************************
// ** Minutemen **
// ********************************************************************

/datum/antagonist/ert/minutemen
	name = "CLIP Minutemen"
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/armed
	role = "Minuteman"

/datum/antagonist/ert/minutemen/greet()
	to_chat(owner, "<B><font size=3 color=red>You are \the [role].</font></B>")
	var/missiondesc = "You serve in the armed forced of the Confederated League of Independent Planets (CLIP), an independent government. You are being deployed to the sector of [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your squad to complete all objectives."
	else
		missiondesc += "Follow orders given to you by your Leader, the Sergent."
	if(deathsquad)
		missiondesc += "You have been given the order to fire at will."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/minutemen/leader
	name = "CLIP Minutemen Field Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/clip/minutemen/grunt/lead
	role = "Sergeant"

/datum/antagonist/ert/minutemen/corpsman
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/med/armed
	role = "Field Corpsman"

/datum/antagonist/ert/minutemen/engi
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/engi/armed
	role = "Field Engineer"

/datum/antagonist/ert/minutemen/gunner
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/gunner_armed
	role = "Field Gunner"

/datum/antagonist/ert/minutemen/bard
	name = "BARD Infantry"
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/bard
	role = "Minuteman"

/datum/antagonist/ert/minutemen/bard/flamer
	name = "BARD Flamethrower Infantry"
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/bard/flamer

/datum/antagonist/ert/minutemen/bard/medic
	name = "BARD Corpsman"
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/bard/medic
	role = "Corpsman"

/datum/antagonist/ert/minutemen/bard/leader
	name = "BARD Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/bard/leader
	role = "Sergeant"

/datum/antagonist/ert/minutemen/riot
	name = "Riot Officer"
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/riot
	role = "Minuteman"

/datum/antagonist/ert/minutemen/riot/leader
	name = "Riot Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/riot/leader
	role = "Sergeant"

/datum/antagonist/ert/official/minutemen
	name = "GOLD Inspector"
	outfit = /datum/outfit/job/clip/investigator
	role = "Lieutenant"

/datum/antagonist/ert/official/minutemen/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the GOLD Inspector.</font></B>")
	to_chat(owner, "You are part of The Galactic Optimum Labor Division, a division of the CLIP Government. Your task: [ert_team.mission.explanation_text]")

/datum/antagonist/ert/minutemen/eva
	name = "CLIP Minutemen"
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/hardsuit
	role = "Minuteman"

/datum/antagonist/ert/minutemen/eva/leader
	name = "CLIP Minutemen Field Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/clip/minutemen/grunt/lead/armed/hardsuit
	role = "Sergeant"
