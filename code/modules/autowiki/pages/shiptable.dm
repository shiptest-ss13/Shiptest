/datum/autowiki/ship_table
	page = "Template:Autowiki/Content/ShipTable"

/datum/autowiki/ship_table/generate()
	var/list/factions = list()

	for(var/path in SSfactions.factions)
		var/datum/faction/faction = SSfactions.factions[path]
		factions |= faction.parent_faction

	factions = sortList(factions, GLOBAL_PROC_REF(cmp_factions_asc))

	for(var/shipname in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/ship = SSmapping.shuttle_templates[shipname]
		if(!ship.faction)
			continue
		if(ship.category == "subshuttles")
			continue

		LAZYADDASSOCLIST(factions[ship.faction.parent_faction], ship.faction.type, ship)

	return include_template("Autowiki/ShipTable", list(
		"rows" = generate_rows(factions)
	))

/datum/autowiki/ship_table/proc/generate_rows(list/factions)
	var/list/output = list()
	for(var/faction_type in factions)
		var/datum/faction/current = SSfactions.factions[faction_type]
		var/list/subfactions = factions[faction_type]

		if(current.wiki_hidden)
			continue
		if(!length(subfactions))
			output += generate_row(current, subfactions, FALSE)
			continue
		if(length(subfactions) == 1)
			output += generate_row(current, subfactions[faction_type], FALSE)
			continue

		output += include_template("Autowiki/ShipTable/ParentRow", list(
			"name" = current.name,
			"color" = current.color,
			"length" = length(subfactions) + 1
		))

		for(var/subfaction_type in subfactions)
			var/datum/faction/subfaction = SSfactions.factions[subfaction_type]
			output += generate_row(subfaction, subfactions[subfaction_type], TRUE)

	return output.Join("\n")

/datum/autowiki/ship_table/proc/generate_row(datum/faction/current, list/ships, subrow = FALSE)
	var/list/ships_output = list()
	for(var/datum/map_template/shuttle/ship as anything in ships)
		var/shorter_name = replacetext(ship.short_name, "-class", "")
		var/ship_name = "\[\[[ship.name]|[shorter_name]\]\]"
		if(!ship.enabled)
			ships_output += include_template("Tooltip", list(
				"1" = "''[ship_name]''",
				"2" = "This ship is admin-spawn only.",
				"3" = "c44" //red
			))
			continue
		ships_output += ship_name

	ships_output = ships_output.Join(", ")
	if(!length(ships_output))
		ships_output = "''No available ships.''"

	var/list/details = list(
		"name" = current.name,
		"color" = current.color,
		"ships" = ships_output
	)

	if(subrow)
		return include_template("Autowiki/ShipTable/SubRow", details)

	return include_template("Autowiki/ShipTable/Row", details)
