/datum/antagonist/ert/syndicate
	name = "Syndicate Infantry"
	outfit = /datum/outfit/job/syndicate/ert
	role = "Squaddie"

/datum/antagonist/ert/syndicate/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You are but another member of the Syndicate sent to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the completion of your objectives."
	else
		missiondesc += "Follow orders given to you by your Sergeant."
	if(deathsquad)
		missiondesc += "Leave no witnesses."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/leader
	name = "Syndicate Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/syndicate/ert/leader
	role = "Sergeant"

/datum/antagonist/ert/syndicate/gorlex
	name = "2nd Battlegroup Trooper"
	outfit = /datum/outfit/job/syndicate/ert/gorlex
	role = "Trooper"

/datum/antagonist/ert/syndicate/gorlex/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You're a soldier of the New Gorlex Republic sent to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the completion of your objectives."
	else
		missiondesc += "Follow orders given to you by your Sergeant."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/gorlex/pointman
	name = "Gorlex Republic Shotgunner"
	outfit = /datum/outfit/job/syndicate/ert/gorlex/pointman
	role = "Pointman"

/datum/antagonist/ert/syndicate/gorlex/medic
	name = "Gorlex Republic Medic"
	outfit = /datum/outfit/job/syndicate/ert/gorlex/medic
	role = "Medic"

/datum/antagonist/ert/syndicate/gorlex/sniper
	name = "Gorlex Republic Sniper"
	outfit = /datum/outfit/job/syndicate/ert/gorlex/sniper
	role = "Marksman"

/datum/antagonist/ert/syndicate/gorlex/leader
	name = "Gorlex Republic Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/syndicate/ert/gorlex/leader
	role = "Sergeant"

// cybersun

/datum/antagonist/ert/syndicate/cybersun
	name = "Cybersun Commando"
	outfit = /datum/outfit/job/syndicate/ert/cybersun
	role = "Operative"

/datum/antagonist/ert/syndicate/cybersun/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You are one of the commandos enlisted in Cybersun Industries, deployed to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the completion of your objectives."
	else
		missiondesc += "Follow orders given to you by your Sergeant."
	if(prob(50) && !leader)
		missiondesc += "<BR>In addition to your contract with Cybersun, you are also a <B>Gorlex Hardliner</B>. You do not <I>like</I> Cybersun, but you work with them regardless."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/cybersun/leader
	name = "Cybersun Commando Leader"
	leader = TRUE
	outfit = /datum/outfit/job/syndicate/ert/cybersun/leader
	role = "Lead Operative"

/datum/antagonist/ert/syndicate/cybersun/medic
	name = "Cybersun Paramedic"
	outfit = /datum/outfit/job/syndicate/ert/cybersun/medic
	role = "Medical Technician"

/datum/antagonist/ert/syndicate/cybersun/medic/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You are one of the many trained paramedics of Cybersun's Medical Intervention program, sent with your team to [station_name()] to aid Cybersun clients in distress.<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the safety of Cybersun's clientele.<BR>"
	else
		missiondesc += "Follow orders given to you by your Lead Technician. Assist Cybersun clients.<BR>"

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/cybersun/medic/leader
	name = "Cybersun Lead Paramedic"
	leader = TRUE
	outfit = /datum/outfit/job/syndicate/ert/cybersun/medic/leader
	role = "Lead Medical Technician"

// inspector

/datum/antagonist/ert/official/syndicate
	name = "Syndicate Inspector"
	outfit = /datum/outfit/job/syndicate/ert/inspector
	role = "Syndicate Inspector"

/datum/antagonist/ert/official/syndicate/greet()
	to_chat(owner, "<B><font size=3 color=red>You are a Syndicate Inspector.</font></B>")
	if (ert_team)
		to_chat(owner, "The Syndicate Coalition is sending you to [station_name()] with the task: [ert_team.mission.explanation_text]")
	else
		to_chat(owner, "The Syndicate Coalition is sending you to [station_name()] with the task: [mission.explanation_text]")
