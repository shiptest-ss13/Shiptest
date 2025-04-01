/datum/ert/gezena
	teamsize = 4
	leader_role = /datum/antagonist/ert/gezena/leader
	roles = list(/datum/antagonist/ert/gezena, /datum/antagonist/ert/gezena/gunner, /datum/antagonist/ert/gezena/medic, /datum/antagonist/ert/gezena/engineer)
	rename_team = "Gezenan Heavy Response Team"
	polldesc = "a PGF response team"
	ert_template = /datum/map_template/shuttle/subshuttles/nail

/datum/ert/gezena/inspector
	teamsize = 1
	leader_role = /datum/antagonist/ert/gezena/inspector
	roles = list(/datum/antagonist/ert/gezena/inspector)
	rename_team = "Gezenan Federation Observer"
	polldesc = "a PGF inspector"

/datum/ert/gezena/inspector/guarded
	teamsize = 3
	roles = list(/datum/antagonist/ert/gezena)

/datum/ert/gezena/inspector/New()
	mission = "Conduct a routine review on [station_name()]'s Federation vessels."
