/datum/faction
	var/name
	/// Primarly to be used for backend stuff.
	var/short_name
	var/parent_faction
	/// List of prefixes that ships of this faction uses
	var/list/prefixes
	/// list of factions that are "allowed" with this faction, used for factional cargo
	var/list/allowed_factions

/datum/faction/New()
	if(!short_name)
		short_name = name

/// Easy way to check if something is "allowed", checks to see if it matches the name or faction typepath because factions are a fucking mess
/datum/faction/proc/allowed_faction(value_to_check)
	var/datum/faction/faction_to_check = value_to_check
	//are we the same faction datum?
	if(istype(value_to_check, src))
		return TRUE
	///if they are our parent faction then allow
	if(istype(faction_to_check, parent_faction))
		return TRUE
	//do we have the same faction even if one is a define?
	if(value_to_check == name)
		return TRUE
	if(value_to_check in allowed_factions)
		return TRUE
	return FALSE

/datum/faction/syndicate
	name = FACTION_SYNDICATE
	parent_faction = /datum/faction/syndicate
	prefixes = PREFIX_SYNDICATE

/datum/faction/syndicate/ngr
	name = FACTION_NGR
	short_name = "NGR"
	prefixes = PREFIX_NGR

/datum/faction/syndicate/cybersun
	name = FACTION_CYBERSUN
	prefixes = PREFIX_CYBERSUN

/datum/faction/syndicate/suns
	name = FACTION_SUNS
	short_name = "SUNS"
	prefixes = PREFIX_SUNS

/datum/faction/solgov
	name = FACTION_SOLGOV
	prefixes = PREFIX_SOLGOV

/datum/faction/srm
	name = FACTION_SRM
	short_name = "SRM"
	prefixes = PREFIX_SRM

/datum/faction/inteq
	name = FACTION_INTEQ
	short_name = "INTEQ"
	prefixes = PREFIX_INTEQ

/datum/faction/clip
	name = FACTION_CLIP
	short_name = "CLIP"
	prefixes = PREFIX_CLIP

/datum/faction/nt
	name = FACTION_NT
	short_name = "NT"
	parent_faction = /datum/faction/nt
	prefixes = PREFIX_NT

/datum/faction/nt/ns_logi
	name = FACTION_NS_LOGI
	prefixes = PREFIX_NS_LOGI

/datum/faction/nt/vigilitas
	name = FACTION_VIGILITAS
	prefixes = PREFIX_VIGILITAS

/datum/faction/frontier
	name = FACTION_FRONTIER
	prefixes = PREFIX_FRONTIER

/datum/faction/pgf
	name = FACTION_PGF
	short_name = "PGF"
	prefixes = PREFIX_PGF

/datum/faction/independent
	name = FACTION_INDEPENDENT
	short_name = "Indie"
	prefixes = PREFIX_INDEPENDENT

/datum/faction/scarborough_arms
	name = "Scarborough Arms"
	parent_faction = /datum/faction/syndicate
	prefixes = PREFIX_INDEPENDENT
	allowed_factions = list(/datum/faction/syndicate)
