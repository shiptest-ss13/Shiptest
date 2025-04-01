/datum/ert/independent
	teamsize = 4
	opendoors = FALSE
	leader_role = /datum/antagonist/ert/independent
	roles = list(/datum/antagonist/ert/independent)
	rename_team = "Security Independent Team"
	polldesc = "an independent security team"

/datum/ert/independent/emt
	teamsize = 3
	leader_role = /datum/antagonist/ert/independent/emt
	roles = list(/datum/antagonist/ert/independent/emt)
	rename_team = "Medical Independent Team"
	polldesc = "an independent medical response team"

/datum/ert/independent/emt/eva
	leader_role = /datum/antagonist/ert/independent/emt/eva
	roles = list(/datum/antagonist/ert/independent/emt/eva)

/datum/ert/independent/firefighter
	teamsize = 5
	leader_role = /datum/antagonist/ert/independent/firefighter/leader
	roles = list(/datum/antagonist/ert/independent/firefighter, /datum/antagonist/ert/independent/firefighter/medic)
	rename_team = "Independent Firefighter Team"
	polldesc = "an independent firefighting team"

/datum/ert/independent/engineer
	leader_role = /datum/antagonist/ert/independent/technician
	roles = list(/datum/antagonist/ert/independent/technician)
	rename_team = "Engineering Independent Team"
	polldesc = "an independent engineering team"

/datum/ert/independent/janitor
	leader_role = /datum/antagonist/ert/independent/janitor
	roles = list(/datum/antagonist/ert/independent/janitor)
	rename_team = "Independent Janitorial Team"
	polldesc = "an independent clean-up team"

/datum/ert/independent/pizza
	leader_role = /datum/antagonist/ert/independent/pizza
	roles = list(/datum/antagonist/ert/independent/pizza)
	rename_team = "Independent Pizza Delivery Team"
	polldesc = "a pizza delivery job"

/datum/ert/independent/deathsquad
	teamsize = 2
	leader_role = /datum/antagonist/ert/independent/deathsquad
	roles = list(/datum/antagonist/ert/independent/deathsquad)
	rename_team = "Death Commando Team"
	polldesc = "a death squadron team"
