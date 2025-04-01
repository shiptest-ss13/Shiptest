/datum/ert/inteq
	teamsize = 4
	leader_role = /datum/antagonist/ert/inteq/leader
	roles = list(/datum/antagonist/ert/inteq, /datum/antagonist/ert/inteq/medic, /datum/antagonist/ert/inteq/engineer)
	mission = "Carry out your contract."
	rename_team = "Inteq Assault Team"
	polldesc = "an Inteq assault team"
	ert_template = /datum/map_template/shuttle/subshuttles/anvil

/datum/ert/inteq/eva
	leader_role = /datum/antagonist/ert/inteq/leader/eva
	roles = list(/datum/antagonist/ert/inteq/eva, /datum/antagonist/ert/inteq/medic/eva, /datum/antagonist/ert/inteq/engineer/eva)

/datum/ert/inteq/inspector
	teamsize = 1
	leader_role = /datum/antagonist/ert/inteq/inspector
	roles = list(/datum/antagonist/ert/inteq/inspector)
	mission = "Assure Inteq's quality on the frontier."
	rename_team = "Inteq Investigator Team"
	polldesc = "an Inteq investigator"

/datum/ert/inteq/inspector/guarded
	teamsize = 3
	leader_role = /datum/antagonist/ert/inteq/inspector
	roles = list(/datum/antagonist/ert/inteq/honor_guard)

/datum/ert/inteq/honor_guard
	teamsize = 3
	leader_role = /datum/antagonist/ert/inteq/honor_guard
	roles = list(/datum/antagonist/ert/inteq/honor_guard)
	rename_team = "Inteq Honor Guard"
	polldesc = "an Inteq honor guardsman team"
