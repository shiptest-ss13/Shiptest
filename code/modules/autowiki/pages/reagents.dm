/datum/autowiki/reagents
	page = "Template:Autowiki/Content/Reactions"

/datum/autowiki/reagents/generate()
	var/list/output = list()

	for(var/id in GLOB.chemical_reactions_list)
		var/datum/chemical_reaction/reaction = GLOB.chemical_reactions_list[id]

		world.log << id
		world.log << json_encode(reaction)

		for(var/datum/reagent/result_chem as anything in reaction.results)
			var/description = ""
			var/result_units = reaction.results[result_chem]
			var/result_name = escape_value(result_chem.name)

			for(var/datum/reagent/required_chem in reaction.required_reagents)
				var/parts = reaction.required_reagents[required_chem]
				var/required_name = escape_value(required_chem.name)
				var/info = "[parts] part[parts > 1 ? "s" : ""] [required_name]"

				if(required_chem.type in GLOB.chemical_reactions_list)
					description += include_template("Tooltip", list("1" = info, "2" = include_template("Template:Autowiki/Content/Reactions/[required_name]")))
				else
					description += info

				description += "<br />"

			description += "(Makes [result_units] unit[result_units > 1 ? "s" : ""])"

			if(result_name in output)
				output[result_name] += "OR<br />[description]"
			else
				output[result_name] = description

	return output
