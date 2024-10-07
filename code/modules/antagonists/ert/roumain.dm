/datum/antagonist/ert/roumain
	name = "Saint-Roumain Hunter"
	outfit = /datum/outfit/job/roumain/ert
	role = "Hunter"

/datum/antagonist/ert/roumain/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [role].</font></B>")
	var/missiondesc = "You are one of the devoted members of the Saint-Roumain Militia. You are being directed to the sector of [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your squad to complete all objectives."
	else
		missiondesc += "Follow orders given to you by your Leader, the Montage."
	if(deathsquad)
		missiondesc += "You have been given the order to fire at will."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/roumain/vickland
	outfit = /datum/outfit/job/roumain/ert/vickland

/datum/antagonist/ert/roumain/firestorm
	outfit = /datum/outfit/job/roumain/ert/firestorm

/datum/antagonist/ert/roumain/scout
	outfit = /datum/outfit/job/roumain/ert/scout

/datum/antagonist/ert/roumain/leader
	name = "Saint-Roumain Hunter Montagne"
	leader = TRUE
	outfit = /datum/outfit/job/roumain/ert/leader
	role = "Hunter Montagne"

/datum/antagonist/ert/roumain/leader/colligne
	name = "Saint-Roumain Hunter Colligne"
	outfit = /datum/outfit/job/roumain/ert/leader/colligne
	role = "Hunter clligne"

/datum/antagonist/ert/roumain/leader/twobore
	outfit = /datum/outfit/job/roumain/ert/leader/twobore

/datum/antagonist/ert/roumain/medic
	name = "Saint-Roumain Hunter Doctor"
	outfit = /datum/outfit/job/roumain/ert/medic
	role = "Doctor"

/datum/antagonist/ert/roumain/engineer
	name = "Saint-Roumain Machinist"
	outfit = /datum/outfit/job/roumain/ert/engineer
	role = "Hunter"
