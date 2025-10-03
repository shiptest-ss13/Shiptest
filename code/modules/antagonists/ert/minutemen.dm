// ********************************************************************
// ** Minutemen **
// ********************************************************************

/datum/antagonist/ert/minutemen
	name = "C-MM Minuteman"
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/armed
	role = "Minuteman"

/datum/antagonist/ert/minutemen/eva
	outfit = /datum/outfit/job/clip/minutemen/grunt/dressed/hardsuit

/datum/antagonist/ert/minutemen/greet()
	to_chat(owner, "<B><font size=3 color=red>You are \the [role].</font></B>")
	var/missiondesc = "You serve in the Confederated League Minutemen, the armed forces of the Confederated League of Independent Planets. You are being deployed to the sector of [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your squad to complete all objectives."
	else
		missiondesc += "Follow orders given to you by your squadron leader."
	if(deathsquad)
		missiondesc += "You have been given the order to fire at will."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/minutemen/leader
	name = "C-MM Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/clip/minutemen/grunt/lead
	role = "Sergeant"

/datum/antagonist/ert/minutemen/leader/eva
	outfit = /datum/outfit/job/clip/minutemen/grunt/lead/armed/hardsuit

/datum/antagonist/ert/minutemen/corpsman
	name = "C-MM Field Corpsman"
	outfit = /datum/outfit/job/clip/minutemen/grunt/medic/dressed/cm5
	role = "Corpsman"

/datum/antagonist/ert/minutemen/engi
	name = "C-MM Field Engineer"
	outfit = /datum/outfit/job/clip/minutemen/grunt/engineer/dressed/armed
	role = "Engineer"

/datum/antagonist/ert/minutemen/gunner
	name = "C-MM Machinegunner"
	outfit = /datum/outfit/job/clip/minutemen/grunt/gunner/dressed/armed
	role = "Field Gunner"

// BARD

/datum/antagonist/ert/minutemen/bard
	name = "BARD Field Agent"
	outfit = /datum/outfit/job/clip/minutemen/bard
	role = "Agent"

/datum/antagonist/ert/minutemen/bard/emergency
	name = "BARD Xenofauna Specialist"
	outfit = /datum/outfit/job/clip/minutemen/bard/emergency
	role = "Specialist"

/datum/antagonist/ert/minutemen/bard/flamer
	name = "BARD Fire Control Specialist"
	outfit = /datum/outfit/job/clip/minutemen/bard/emergency/flamer
	role = "Fire Specialist"

/datum/antagonist/ert/minutemen/bard/medic
	name = "BARD Medical Aid Specialist"
	outfit = /datum/outfit/job/clip/minutemen/bard/emergency/medic
	role = "Medical Specialist"

/datum/antagonist/ert/minutemen/bard/emergency/leader
	name = "BARD Team Leader"
	leader = TRUE
	outfit = /datum/outfit/job/clip/minutemen/bard/emergency/leader
	role = "Team Leader"

/datum/antagonist/ert/minutemen/military_police
	name = "C-MM Military Police"
	outfit = /datum/outfit/job/clip/minutemen/military_police
	role = "Officer"

/datum/antagonist/ert/minutemen/military_police/riot
	outfit = /datum/outfit/job/clip/minutemen/military_police/riot

/datum/antagonist/ert/minutemen/military_police/leader
	name = "C-MM Chief Military Police"
	leader = TRUE
	outfit = /datum/outfit/job/clip/minutemen/military_police/leader
	role = "Chief Officer"

/datum/antagonist/ert/minutemen/military_police/leader/riot
	outfit = /datum/outfit/job/clip/minutemen/military_police/leader/riot

/datum/antagonist/ert/minutemen/inspector
	name = "GOLD Inspector"
	outfit = /datum/outfit/job/clip/investigator/cm5
	role = "Lieutenant"

/datum/antagonist/ert/minutemen/inspector/greet()
	to_chat(owner, "<B><font size=3 color=red>You are a Labor Division Inspector.</font></B>")
	to_chat(owner, "You are part of The Galactic Optimum Labor Division, a division of the CLIP Government. Your task: [ert_team.mission.explanation_text]")

/datum/antagonist/ert/minutemen/correspondent
	name = "C-MM Military Correspondent"
	outfit = /datum/outfit/job/clip/correspondent
	role = "Correspondant"

/datum/antagonist/ert/minutemen/correspondent/greet()
	to_chat(owner, "<B><font size=3 color=red>You are a Confederated League correspondant.</font></B>")
	to_chat(owner, "You have been hired to report on CLIP's activity in the frontier. Your task: [ert_team.mission.explanation_text]")
