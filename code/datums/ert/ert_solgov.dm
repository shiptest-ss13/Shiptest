/datum/ert/solgov
	teamsize = 4
	opendoors = FALSE
	leader_role = /datum/antagonist/ert/solgov
	roles = list(/datum/antagonist/ert/solgov)
	mission = "Intervene in Solarian interests."
	rename_team = "SolGov Sonnensoldner Team"
	polldesc = "a SolGov mercenary team"

/datum/ert/solgov/inspector
	teamsize = 1
	leader_role = /datum/antagonist/ert/solgov/inspector
	roles = list(/datum/antagonist/ert/solgov/inspector)
	rename_team = "SolGov Inspector"
	polldesc = "a solarian inspector"
	spawn_at_outpost = FALSE

/datum/ert/solgov/inspector/New()
	mission = "Conduct a routine review on [station_name()]'s vessels."
