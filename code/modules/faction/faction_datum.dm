/datum/faction
	var/name
	var/parent_faction
	var/list/prefixes

/datum/faction/syndicate
	name = FACTION_SYNDICATE
	parent_faction = /datum/faction/syndicate
	prefixes = list("SEV", "SSV")

/datum/faction/syndicate/ngr
	name = FACTION_NGR
	prefixes = list("NGRV")

/datum/faction/syndicate/cybersun
	name = FACTION_CYBERSUN
	prefixes = list("CSSV")

/datum/faction/syndicate/suns
	name = FACTION_SUNS
	prefixes = list("SUNS")

/datum/faction/solgov
	name = FACTION_SOLGOV
	prefixes = list("SCSV")

/datum/faction/srm
	name = FACTION_SRM
	prefixes = list("SRSV")

/datum/faction/inteq
	name = FACTION_INTEQ
	prefixes = list("IRMV")

/datum/faction/clip
	name = FACTION_CLIP
	prefixes = list("CMSV", "CMGSV")

/datum/faction/nt
	name = FACTION_NT
	parent_faction = /datum/faction/nt
	prefixes = list("NTSV")

/datum/faction/nt/ns_logi
	name = FACTION_NS_LOGI
	prefixes = list("NSSV")

/datum/faction/nt/vigilitas
	name = FACTION_VIGILITAS
	prefixes = list("VISV")

/datum/faction/frontier
	name = FACTION_FRONTIER
	prefixes = list("FFV")

/datum/faction/pgf
	name = FACTION_PGF
	prefixes = list("PGF", "PGFMC", "PGFN")

/datum/faction/independent
	name = FACTION_INDEPENDENT
	prefixes = list("SV", "IMV", "ISV")

/datum/faction/ramzi
	name = FACTION_RAMZI
	prefixes = list("SV", "ISV")
