/datum/faction
	var/name
	/// Primarly to be used for backend stuff.
	var/short_name
	/// Parent faction of this faction, used for allowed factions and information
	var/parent_faction
	/// List of prefixes that ships of this faction uses
	var/list/prefixes
	/// List/Typecache of factions that this faction is allowed to interact with. Non-recursive.
	var/list/allowed_factions = list()
	/// The official language of this faction. Galactic Common by default.
	var/official_language = /datum/language/galactic_common
	/// Theme color for this faction, currently only used for the wiki
	var/color = "#ffffff"
	/// Contrast color for this faction, used for links on the wiki
	var/contrast_color
	/// Background color for this faction, for use under black text
	var/background_color
	/// Whether or not this faction should be able to use prefixes that aren't their own (see: Frontiersmen using Indie prefixes)
	var/check_prefix = TRUE
	/// Sorting order for factions
	var/order = FACTION_SORT_DEFAULT

/datum/faction/New()
	if(!short_name)
		short_name = uppertext(copytext_char(name, 3))

	if(!contrast_color)
		contrast_color = "#[invert_hex(copytext_char(color, 2))]"
	if(!background_color)
		var/list/hsl = rgb2num(color, COLORSPACE_HSL)
		background_color = rgb(hsl[1], min(hsl[2], 50), max(hsl[3], 66), space=COLORSPACE_HSL)

	//All subtypes of this faction, all subtypes of specifically allowed factions, and SPECIFICALLY the parent faction (no subtypes) are allowed.
	//Try not to nest factions too deeply, yeah?
	allowed_factions += src
	allowed_factions = typecacheof(allowed_factions)
	allowed_factions[parent_faction] = TRUE

/// Easy way to check if something is "allowed", checks to see if it matches the name or faction typepath because factions are a fucking mess
/datum/faction/proc/allowed_faction(value_to_check)
	//do we have the same faction even if one is a define?
	if(value_to_check == name)
		return TRUE
	return is_type_in_typecache(value_to_check, allowed_factions)

/datum/faction/syndicate
	name = FACTION_SYNDICATE
	parent_faction = /datum/faction/syndicate
	prefixes = PREFIX_SYNDICATE
	color = "#B22C20"

/datum/faction/syndicate/ngr
	name = FACTION_NGR
	short_name = "NGR"
	prefixes = PREFIX_NGR
	color = "#C59973"

/datum/faction/syndicate/cybersun
	name = FACTION_CYBERSUN
	prefixes = PREFIX_CYBERSUN
	color = "#4C9C9C"

/datum/faction/syndicate/hardliners
	name = FACTION_HARDLINERS
	prefixes = PREFIX_HARDLINERS
	check_prefix = FALSE
	color = "#97150B"

/datum/faction/syndicate/suns
	name = FACTION_SUNS
	short_name = "SUNS"
	official_language = /datum/language/solarian_international
	prefixes = PREFIX_SUNS
	color = "#CD94D3"

/datum/faction/syndicate/scarborough
	name = "Scarborough Arms"
	prefixes = PREFIX_NONE
	allowed_factions = list(/datum/faction/syndicate)

/datum/faction/solgov
	name = FACTION_SOLCON
	parent_faction = /datum/faction/solgov
	official_language = /datum/language/solarian_international
	prefixes = PREFIX_SOLCON
	color = "#444e5f"

/datum/faction/srm
	name = FACTION_SRM
	short_name = "SRM"
	parent_faction = /datum/faction/srm
	prefixes = PREFIX_SRM
	color = "#6B3500"

/datum/faction/inteq
	name = FACTION_INTEQ
	short_name = "INTEQ"
	parent_faction = /datum/faction/inteq
	prefixes = PREFIX_INTEQ
	color = "#E6B93C"

/datum/faction/clip
	name = FACTION_CLIP
	short_name = "CLIP"
	parent_faction = /datum/faction/clip
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
	color = "#FF6600"

/datum/faction/nt/vigilitas
	name = FACTION_VIGILITAS
	prefixes = PREFIX_VIGILITAS
	color = "#d40000"

/datum/faction/frontiersmen
	name = FACTION_FRONTIERSMEN
	prefixes = PREFIX_FRONTIERSMEN
	color = "#80735D"
	check_prefix = FALSE
	parent_faction = /datum/faction/frontiersmen
	order = FACTION_SORT_ASPAWN

/datum/faction/pgf
	name = FACTION_PGF
	short_name = "PGF"
	parent_faction = /datum/faction/pgf
	official_language = /datum/language/gezena_kalixcian
	prefixes = PREFIX_PGF
	color = "#359829"

/datum/faction/independent
	name = FACTION_INDEPENDENT
	short_name = "IND"
	parent_faction = /datum/faction/independent
	prefixes = PREFIX_INDEPENDENT
	color = "#A0A0A0"
	order = FACTION_SORT_INDEPENDENT

/datum/faction/ramzi
	name = FACTION_RAMZI
	short_name = "RAM"
	parent_faction = /datum/faction/ramzi
	prefixes = PREFIX_RAMZI
	color = "#c45508"
	check_prefix = FALSE
	order = FACTION_SORT_ASPAWN

/datum/faction/unknown
	name = FACTION_UNKNOWN
	short_name = "???"
	parent_faction = /datum/faction/unknown
	prefixes = PREFIX_NONE
	color = "#504c4c"
	check_prefix = FALSE
	order = FACTION_SORT_ASPAWN
