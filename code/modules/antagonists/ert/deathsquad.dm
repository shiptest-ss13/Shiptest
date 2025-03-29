/datum/antagonist/ert/deathsquad
	name = "Death Commando"
	outfit = /datum/outfit/job/ert/deathsquad
	role = "Commando"
	random_names = TRUE

/datum/antagonist/ert/deathsquad/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [role].</font></B>")
	var/missiondesc = "You are one of the Deathsquad, you don't exist and you never have. You are being directed to the sector of [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your squad, leave no witnesses, let no one obtain your gear."

	if(solo)
		missiondesc += "Complete your objectives, leave no witnesses, disappear."

	else
		missiondesc += "Follow your orders, protect your leader. Maybe you'll get into the next issue."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/deathsquad/leader
	name = "Cleanup Squad Leader"
	outfit = /datum/outfit/job/ert/deathsquad/leader
	role = "Director"

/datum/antagonist/ert/deathsquad/leader/elite
	name = "Elite Cleanup Squad Leader"
	outfit = /datum/outfit/job/ert/deathsquad/leader/elite
	role = "Prime Director"

/datum/antagonist/ert/deathsquad/medic
	name = "Cleanup Squad Medic"
	outfit = /datum/outfit/job/ert/deathsquad/medic
	role = "Anodyne"

/datum/antagonist/ert/deathsquad/medic/elite
	name = "Elite Cleanup Squad Medic"
	outfit = /datum/outfit/job/ert/deathsquad/medic/elite
	role = "Panacea"

/datum/antagonist/ert/deathsquad/demolitions
	name = "Cleanup Squad Demolitions"
	outfit = /datum/outfit/job/ert/deathsquad/demolitions
	role = "Gale"

/datum/antagonist/ert/deathsquad/demolitions/elite
	name = "Elite Cleanup Squad Demolitions"
	outfit = /datum/outfit/job/ert/deathsquad/demolitions/elite
	role = "Storm"

/datum/antagonist/ert/deathsquad/elite
	name = "Elite Commando"
	outfit = /datum/outfit/job/ert/deathsquad/elite
	role = "Prime Commando"

/datum/antagonist/ert/deathsquad/solo
	name = "Solo Commando"
	outfit = /datum/outfit/job/ert/deathsquad/solo
	role = "Solo"
