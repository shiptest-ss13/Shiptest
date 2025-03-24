SUBSYSTEM_DEF(factions)
	name = "Faction"
	init_order = INIT_ORDER_FACTION
	flags = SS_NO_FIRE
	var/list/datum/faction/factions = list()
	var/list/faction_prefixes = list()

/datum/controller/subsystem/factions/Initialize(timeofday)
	for(var/path in subtypesof(/datum/faction))
		var/datum/faction/faction = new path()
		factions[path] = faction
		for(var/prefix in faction.prefixes)
			if(prefix in faction_prefixes)
				var/datum/faction/other_faction = faction_prefixes[prefix]
				stack_trace("Duplicate ship prefix: [prefix] for [faction.name] and [other_faction.name]")
			faction_prefixes[prefix] = faction

	return ..()

/datum/controller/subsystem/factions/proc/ship_prefix_to_faction(prefix)
	if(!(prefix in faction_prefixes))
		CRASH("Unknown ship prefix: [prefix]")
	return faction_prefixes[prefix]

/datum/controller/subsystem/factions/proc/faction_name(path_or_type)
	var/datum/faction/faction
	if(istype(path_or_type, /datum/faction))
		faction = path_or_type
	else if(ispath(path_or_type))
		faction = factions[path_or_type]
	else
		return "Unknown Faction"
	return faction.name
