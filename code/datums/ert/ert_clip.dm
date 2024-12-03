/datum/ert/minutemen
	teamsize = 5
	leader_role = /datum/antagonist/ert/minutemen/leader
	/// TODO: figure out a way to fill in at least one rifleman first
	roles = list(/datum/antagonist/ert/minutemen, /datum/antagonist/ert/minutemen/corpsman = 1, /datum/antagonist/ert/minutemen/engi = 1, /datum/antagonist/ert/minutemen/gunner = 1)
	mission = "Keep the peace in sector affairs."
	rename_team = "CLIP Minutemen Infantry"
	polldesc = "a CLIP Minutemen squadron"
	ert_template = /datum/map_template/shuttle/subshuttles/crux

/datum/ert/minutemen/eva
	leader_role = /datum/antagonist/ert/minutemen/leader/eva
	roles = list(/datum/antagonist/ert/minutemen/eva)

/datum/ert/minutemen/inspector
	teamsize = 1
	leader_role = /datum/antagonist/ert/minutemen/inspector
	roles = list(/datum/antagonist/ert/minutemen/inspector)
	rename_team = "CLIP Minutemen GOLD Inspector"
	polldesc = "a CLIP Minutemen inspector"

/datum/ert/minutemen/inspector/guarded
	teamsize = 3
	roles = list(/datum/antagonist/ert/minutemen/military_police)

/datum/ert/minutemen/bard
	teamsize = 4
	leader_role = /datum/antagonist/ert/minutemen/bard
	roles = list(/datum/antagonist/ert/minutemen/bard)
	rename_team = "BARD Biohazard Squadron"
	polldesc = "a CLIP BARD biohazard team"

/datum/ert/minutemen/bard/emergency
	leader_role = /datum/antagonist/ert/minutemen/bard/emergency/leader
	roles = list(/datum/antagonist/ert/minutemen/bard/emergency, /datum/antagonist/ert/minutemen/bard/medic = 1, /datum/antagonist/ert/minutemen/bard/flamer = 1)
	rename_team = "BARD Emergency Squadron"
	polldesc = "an emergency CLIP BARD team"

/datum/ert/minutemen/military_police
	teamsize = 4
	leader_role = /datum/antagonist/ert/minutemen/military_police/leader
	roles = list(/datum/antagonist/ert/minutemen/military_police)
	rename_team = "C-MM Military Police"
	polldesc = "a C-MM military police team"

/datum/ert/minutemen/military_police/riot
	leader_role = /datum/antagonist/ert/minutemen/military_police/leader/riot
	roles = list(/datum/antagonist/ert/minutemen/military_police/riot)
	rename_team = "C-MM Riot Control Team"
	polldesc = "a C-MM riot control team"

/datum/ert/minutemen/journalist
	teamsize = 3
	leader_role = /datum/antagonist/ert/minutemen/correspondant
	roles = list(/datum/antagonist/ert/minutemen/correspondant)
	mission = "Inform the public of the frontier's news."
	rename_team = "C-MM Correspondants"
	polldesc = "a C-MM media team"
	ert_template = /datum/map_template/shuttle/subshuttles/kunai
