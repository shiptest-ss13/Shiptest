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

		LAZYADD(factions[ship.faction.parent_faction], ship)

	return include_template("Autowiki/ShipTable", list(
		"rows" = generate_rows(factions)
	))

/datum/autowiki/ship_table/proc/generate_rows(list/factions)
	var/list/output = list()
	for(var/type in factions)
		var/datum/faction/current = SSfactions.factions[type]
		var/list/ships = factions[type]

		var/list/ships_output = list()
		for(var/datum/map_template/shuttle/ship as anything in ships)
			var/shorter_name = replacetext(ship.short_name, "-class", "")
			var/ship_name = "\[\[[ship.name]|[shorter_name]\]\]"
			if(!ship.enabled)
				ships_output += include_template("Tooltip", list(
					"1" = "''[ship_name]''",
					"2" = "This ship is admin-spawn only.",
					"3" = "f00" //red
				))
				continue
			ships_output += ship_name

		output += include_template("Autowiki/ShipTable/Row", list(
			"name" = "\[\[[current.name]\]\]",
			"color" = current.color,
			"ships" = ships_output.Join(", ")
		))

	return output.Join("\n")
