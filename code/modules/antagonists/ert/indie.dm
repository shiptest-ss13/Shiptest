// ********************************************************************
// ** independent **
// ********************************************************************

/datum/antagonist/ert/independent
	name = "Independent Security Officer"
	outfit = /datum/outfit/job/independent/ert
	role = "Security Officer"

/datum/antagonist/ert/independent/greet()
	to_chat(owner, "<B><font size=3 color=red>You are \a [name].</font></B>")
	var/missiondesc = "You are one of the many Independent contractors, workers and students on [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to complete your objectives."
	else
		missiondesc += "Follow orders given to you by your leader."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/independent/emt
	name = "Independent Medical Technician"
	outfit = /datum/outfit/job/independent/ert/emt
	role = "Paramedic"

/datum/antagonist/ert/independent/emt/eva
	outfit = /datum/outfit/job/independent/ert/emt/eva

/datum/antagonist/ert/independent/firefighter
	name = "Independent Firefighter"
	outfit = /datum/outfit/job/independent/ert/firefighter
	role = "Firefighter"

/datum/antagonist/ert/independent/firefighter/medic
	name = "Independent Firefighter Paramedic"
	outfit = /datum/outfit/job/independent/ert/firefighter/medic
	role = "Paramedic"

/datum/antagonist/ert/independent/firefighter/leader
	name = "Independent Firefighter Group Captain"
	outfit = /datum/outfit/job/independent/ert/firefighter/leader
	role = "Group Captain"

/datum/antagonist/ert/independent/technician
	name = "Independent Technician"
	outfit = /datum/outfit/job/independent/ert/technician
	role = "Technician"

/datum/antagonist/ert/independent/deathsquad
	name = "Deathsquad Commando"
	outfit = /datum/outfit/job/independent/ert/deathsquad
	role = "Commando"

/datum/antagonist/ert/independent/pizza
	name = "Pizza Delivery Worker"
	outfit = /datum/outfit/job/independent/ert/pizza
	role = "Delivery Worker"

/datum/antagonist/ert/independent/janitor
	name = "Independent Sanitation Technician"
	outfit = /datum/outfit/job/independent/ert/janitor
	role = "Sanitation Technician"
