SUBSYSTEM_DEF(factions)
	name = "Faction"
	init_order = INIT_ORDER_FACTION
	flags = SS_NO_FIRE
	var/list/datum/faction/factions = list()

/datum/controller/subsystem/factions/Initialize(timeofday)
	for(var/path in subtypesof(/datum/faction))
		factions += new path()
	return ..()

/datum/controller/subsystem/factions/proc/ship_prefix_to_faction(prefix)
	for(var/datum/faction/faction in factions)
		if(prefix in faction.prefixes)
			return faction
	var/static/list/screamed = list()
	if(!(prefix in screamed))
		screamed += prefix
		stack_trace("attempted to get faction for unknown prefix [prefix]")
	return null

/datum/controller/subsystem/factions/proc/ship_prefix_to_name(prefix)
	var/datum/faction/faction = ship_prefix_to_faction(prefix)
	if(faction)
		return faction.name
	return "?!ERR!?"

/datum/controller/subsystem/factions/proc/faction_path_to_datum(path)
	for(var/datum/faction/faction in factions)
		if(faction.type == path)
			return faction
	stack_trace("we did not return any faction with path [path]")
