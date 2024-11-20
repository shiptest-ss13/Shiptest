/datum/faction
	var/name
	/// Primarly to be used for backend stuff.
	var/short_name
	var/parent_faction
	/// List of prefixes that ships of this faction uses
	var/list/prefixes
	/// list of factions that are "allowed" with this faction, used for factional cargo
	var/list/allowed_factions
	/// Theme color for this faction, currently only used for the wiki
	var/color = "#ffffff"
	/// Whether or not this faction should be able to use prefixes that aren't their own (see: Frontiersmen using Indie prefixes)
	var/check_prefix = TRUE

/datum/faction/New()
	if(!short_name)
		short_name = uppertext(copytext_char(name, 3))

/// Easy way to check if something is "allowed", checks to see if it matches the name or faction typepath because factions are a fucking mess
/datum/faction/proc/allowed_faction(value_to_check)
	///Are we the same datum?
	if(istype(value_to_check, src))
		return TRUE
	///Allow if we share a parent faction
	if(istype(value_to_check, parent_faction))
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
	color = "#B22C20"

/datum/faction/syndicate/ngr
	name = FACTION_NGR
	short_name = "NGR"
	prefixes = PREFIX_NGR

/datum/faction/syndicate/cybersun
	name = FACTION_CYBERSUN
	prefixes = PREFIX_CYBERSUN

/datum/faction/syndicate/hardliners
	name = FACTION_HARDLINERS
	prefixes = PREFIX_HARDLINERS
	check_prefix = FALSE

/datum/faction/syndicate/suns
	name = FACTION_SUNS
	short_name = "SUNS"
	prefixes = PREFIX_SUNS

/datum/faction/solgov
	name = FACTION_SOLGOV
	prefixes = PREFIX_SOLGOV
	color = "#444e5f"

/datum/faction/srm
	name = FACTION_SRM
	short_name = "SRM"
	prefixes = PREFIX_SRM
	color = "#6B3500"

/datum/faction/inteq
	name = FACTION_INTEQ
	short_name = "INTEQ"
	prefixes = PREFIX_INTEQ
	color = "#7E6641"

/datum/faction/clip
	name = FACTION_CLIP
	short_name = "CLIP"
	prefixes = PREFIX_CLIP
	color = "#3F90DF"

/datum/faction/nt
	name = FACTION_NT
	short_name = "NT"
	parent_faction = /datum/faction/nt
	prefixes = PREFIX_NT
	color = "#283674"

/datum/faction/nt/ns_logi
	name = FACTION_NS_LOGI
	prefixes = PREFIX_NS_LOGI

/datum/faction/nt/vigilitas
	name = FACTION_VIGILITAS
	prefixes = PREFIX_VIGILITAS

/datum/faction/frontiersmen
	name = FACTION_FRONTIERSMEN
	prefixes = PREFIX_FRONTIERSMEN
	color = "#80735D"
	check_prefix = FALSE

/datum/faction/pgf
	name = FACTION_PGF
	short_name = "PGF"
	prefixes = PREFIX_PGF
	color = "#359829"

/datum/faction/independent
	name = FACTION_INDEPENDENT
	short_name = "IND"
	prefixes = PREFIX_INDEPENDENT
	color = "#A0A0A0"

/datum/faction/syndicate/scarborough_arms
	name = "Scarborough Arms"
	parent_faction = /datum/faction/syndicate
	prefixes = PREFIX_INDEPENDENT
	allowed_factions = list(/datum/faction/syndicate)
