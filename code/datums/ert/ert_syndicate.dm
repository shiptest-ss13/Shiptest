// stand-ins

/datum/ert/syndicate
	teamsize = 4
	leader_role = /datum/antagonist/ert/syndicate/leader
	roles = list(/datum/antagonist/ert/syndicate)
	mission = "Serve the interests of the Syndicate."
	rename_team = "Generic Syndicate Team"
	polldesc = "a Syndicate emergency team"
	spawn_at_outpost = FALSE

/datum/ert/syndicate/inspector
	teamsize = 1
	leader_role = /datum/antagonist/ert/syndicate/inspector
	roles = list(/datum/antagonist/ert/syndicate/inspector)
	rename_team = "Syndicate Inspector"
	polldesc = "a syndicate ACLF inspector"

/datum/ert/syndicate/inspector/New()
	mission = "Conduct a routine review on [station_name()]'s Coalition vessels."

// new gorlex republic

/datum/ert/syndicate/ngr
	teamsize = 5
	leader_role = /datum/antagonist/ert/syndicate/ngr/leader
	roles = list(/datum/antagonist/ert/syndicate/ngr, /datum/antagonist/ert/syndicate/ngr/grenadier = 1, /datum/antagonist/ert/syndicate/ngr/medic = 1, /datum/antagonist/ert/syndicate/ngr/sniper = 1)
	mission = "Uphold the sovereignty of the New Gorlex Republic."
	rename_team = "Gorlex Republic Detachment"
	polldesc = "a Gorlex Republic battle squad"

/datum/ert/syndicate/ngr/inspector
	teamsize = 1
	leader_role = /datum/antagonist/ert/syndicate/ngr/inspector
	roles = list(/datum/antagonist/ert/syndicate/ngr/inspector)
	rename_team = "Gorlex Republic Official"
	polldesc = "a Gorlex Republic inspector"

/datum/ert/syndicate/ngr/inspector/guarded
	teamsize = 3
	leader_role = /datum/antagonist/ert/syndicate/ngr/inspector
	roles = list(/datum/antagonist/ert/syndicate/ngr)

// cybersun

/datum/ert/syndicate/cybersun
	leader_role = /datum/antagonist/ert/syndicate/cybersun/leader
	roles = list(/datum/antagonist/ert/syndicate/cybersun)
	mission = "Serve the interests of CyberSun."
	rename_team = "Cybersun Commando Team"
	polldesc = "a Cybersun Commando team"

/datum/ert/syndicate/cybersun/medic
	leader_role = /datum/antagonist/ert/syndicate/cybersun/medic/leader
	roles = list(/datum/antagonist/ert/syndicate/cybersun/medic)
	mission = "Assist CyberSun clients."
	rename_team = "Cybersun Medical Intervention Team"
	polldesc = "a Cybersun paramedic team"
	ert_template = /datum/map_template/shuttle/subshuttles/runner

/datum/ert/syndicate/hardliners
	leader_role = /datum/antagonist/ert/syndicate/hardliner/leader
	roles = list(/datum/antagonist/ert/syndicate/hardliner, /datum/antagonist/ert/syndicate/hardliner/medic = 1, /datum/antagonist/ert/syndicate/hardliner/engineer = 1)
	mission = "Serve the interests of CyberSun."
	rename_team = "Hardliner Element"
	polldesc = "a Hardliner attack team"

/datum/ert/syndicate/ramzi
	leader_role = /datum/antagonist/ert/syndicate/ramzi/leader
	roles = list(/datum/antagonist/ert/syndicate/ramzi, /datum/antagonist/ert/syndicate/ramzi/medic = 1, /datum/antagonist/ert/syndicate/ramzi/demolitionist = 1)
	mission = "Make Ramzi proud."
	rename_team = "Ramzi Cell"
	polldesc = "a Ramzi pirate team"
