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

/datum/antagonist/ert/syndicate/inspector
	name = "ACLF Inspector"
	outfit = /datum/outfit/job/syndicate/ert/inspector
	role = "Inspector"

/datum/antagonist/ert/official/syndicate/greet()
	to_chat(owner, "<B><font size=3 color=red>You are a mid-rank official from the Liberation Front.</font></B>")
	to_chat(owner, "The Syndicate Coalition is sending you to [station_name()] with the task: [ert_team.mission.explanation_text]")

/datum/antagonist/ert/syndicate/ngr
	name = "Gorlex Republic Serviceman"
	outfit = /datum/outfit/job/syndicate/ert/ngr
	role = "Serviceman"

/datum/antagonist/ert/syndicate/ngr/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You're an enlistee of the New Gorlex Republic sent to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the completion of your objectives."
	else
		missiondesc += "Follow orders given to you by your Sergeant."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/ngr/grenadier
	name = "Gorlex Republic Grenadier"
	outfit = /datum/outfit/job/syndicate/ert/ngr/grenadier
	role = "Grenadier"

/datum/antagonist/ert/syndicate/ngr/medic
	name = "Gorlex Republic Field Medic"
	outfit = /datum/outfit/job/syndicate/ert/ngr/medic
	role = "Medic"

/datum/antagonist/ert/syndicate/ngr/sniper
	name = "Gorlex Republic Marksman"
	outfit = /datum/outfit/job/syndicate/ert/ngr/sniper
	role = "Marksman"

/datum/antagonist/ert/syndicate/ngr/leader
	name = "Gorlex Republic Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/syndicate/ert/ngr/leader
	role = "Officer"

/datum/antagonist/ert/syndicate/ngr/inspector
	name = "Gorlex Republic Official"
	outfit = /datum/outfit/job/syndicate/ert/ngr/inspector
	role = "Official"

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
	if(prob(50) && !leader && random_names)
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

/datum/antagonist/ert/syndicate/cybersun/inspector
	name = "Cybersun Representative"
	outfit = /datum/outfit/job/syndicate/ert/cybersun/inspector
	role = "Representative"

/datum/antagonist/ert/syndicate/hardliner
	name = "Hardliner Mercenary"
	outfit = /datum/outfit/job/syndicate/ert/hardliner
	role = "Mercenary"

/datum/antagonist/ert/syndicate/hardliner/medic
	name = "Hardliner Medic"
	outfit = /datum/outfit/job/syndicate/ert/hardliner/medic
	role = "Medic"

/datum/antagonist/ert/syndicate/hardliner/engineer
	name = "Hardliner Mechanic"
	outfit = /datum/outfit/job/syndicate/ert/hardliner/engineer
	role = "Mechanic"

/datum/antagonist/ert/syndicate/hardliner/leader
	name = "Hardliner Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/syndicate/ert/hardliner/leader
	role = "Sergeant"

// ramzi

/datum/antagonist/ert/syndicate/ramzi
	name = "Ramzi Clique Cell Member"
	outfit = /datum/outfit/job/syndicate/ert/ramzi
	role = "Cell Member"

/datum/antagonist/ert/syndicate/ramzi/medic
	name = "Ramzi Clique Medic"
	outfit = /datum/outfit/job/syndicate/ert/ramzi/medic
	role = "Cell Medic"

/datum/antagonist/ert/syndicate/ramzi/demolitionist
	name = "Ramzi Clique Demolitonist"
	outfit = /datum/outfit/job/syndicate/ert/ramzi/demolitionist
	role = "Cell Demolitonist"

/datum/antagonist/ert/syndicate/ramzi/leader
	name = "Ramzi Clique Cell Leader"
	outfit = /datum/outfit/job/syndicate/ert/ramzi/leader
	role = "Cell Leader"
