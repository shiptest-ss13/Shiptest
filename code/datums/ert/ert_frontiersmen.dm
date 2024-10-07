/datum/ert/frontier
	teamsize = 4
	opendoors = FALSE
	leader_role = /datum/antagonist/ert/frontier/leader
	roles = list(/datum/antagonist/ert/frontier)
	rename_team = "Generic Frontiersmen Team"
	mission = "Pillage in the name of the Frontiersmen."
	polldesc = "a group of frontiersmen"
	random_names = TRUE
	leader_experience = FALSE
	spawn_at_outpost = FALSE
	ert_template = /datum/map_template/shuttle/subshuttles/brawler

/datum/ert/frontier/unarmed // use for finer control of pirate's armaments
	leader_role = /datum/antagonist/ert/frontier/leader/unarmed
	roles = list(/datum/antagonist/ert/frontier/unarmed)
	rename_team = "Unarmed Frontiersmen Team"

/datum/ert/frontier/random
	teamsize = 8 // the second takes the rifle and shoots
	leader_role = /datum/antagonist/ert/frontier/random
	roles = list(/datum/antagonist/ert/frontier/random)
	rename_team = "Randomly Equipped Frontiersmen Team"

/datum/ert/frontier/raiders
	leader_role = /datum/antagonist/ert/frontier/leader
	roles = list(/datum/antagonist/ert/frontier/skm, /datum/antagonist/ert/frontier/medic = 1, /datum/antagonist/ert/frontier/engineer = 1)
	rename_team = "Assault Frontiersmen Team"
	polldesc = "a well armed squad of pirates"

/datum/ert/frontier/shock
	teamsize = 6
	leader_role = /datum/antagonist/ert/frontier/leader/heavy
	roles = list(/datum/antagonist/ert/frontier/skm, /datum/antagonist/ert/frontier/sentry = 1, /datum/antagonist/ert/frontier/flamer = 1, /datum/antagonist/ert/frontier/medic/heavy = 1, /datum/antagonist/ert/frontier/engineer = 1)
	rename_team = "Frontiersmen Shock Troops"
	polldesc = "a frontiersmen shock troop squadron"
