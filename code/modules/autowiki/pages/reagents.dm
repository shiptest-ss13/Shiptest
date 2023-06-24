/datum/autowiki/reagents
	page = "Template:Autowiki/Content/Reactions"

/datum/autowiki/reagents/generate()
	var/list/output = list()

	var/list/mixable_reagents = list()
	var/list/all_reactions = list()
	for(var/type in subtypesof(/datum/chemical_reaction))
		var/datum/chemical_reaction/reaction = new type
		all_reactions += reaction
		mixable_reagents |= reaction.results

	for(var/datum/chemical_reaction/reaction as anything in all_reactions)
		for(var/datum/reagent/result_chem_type as anything in reaction.results)
			var/description = ""
			var/result_units = reaction.results[result_chem_type]
			var/result_name = escape_value(initial(result_chem_type.name))

			for(var/datum/reagent/required_chem_type as anything in reaction.required_reagents)
				var/parts = reaction.required_reagents[required_chem_type]
				var/required_name = escape_value(initial(required_chem_type.name))
				var/info = "[parts] part[parts > 1 ? "s" : ""]"

				if(required_chem_type in mixable_reagents)
					var/tooltip_text = "[info] \[\[#[required_name]|[required_name]\]\]"
					description += include_template("Tooltip", list("1" = tooltip_text, "2" = include_template("Autowiki/Content/Reactions/[required_name]")))

				else
					description += "[info] [required_name]<br />"

			for(var/datum/reagent/required_catalyst_type as anything in reaction.required_catalysts)
				var/parts = reaction.required_catalysts[required_catalyst_type]
				var/catalyst_name = escape_value(initial(required_catalyst_type.name))
				var/info = "[parts] part[parts > 1 ? "s" : ""] "

				if(required_catalyst_type in mixable_reagents)
					var/tooltip_text = "[info] \[\[#[catalyst_name]|[catalyst_name]\]\]"
					description += include_template("Tooltip", list("1" = tooltip_text, "2" = include_template("Autowiki/Content/Reactions/[catalyst_name]")))

				else
					description += "[info] [catalyst_name]<br />"

			if(reaction.required_temp > 0)
				description += "Temperature [reaction.is_cold_recipe ? "below" : "above"] [reaction.required_temp]K<br />"
			if(reaction.required_container)
				description += "Must be mixed in [escape_value(initial(reaction.required_container.name))]"

			description += "(Makes [result_units] unit[result_units > 1 ? "s" : ""])"

			if(result_name in output)
				output[result_name] += "OR<br />[description]"
			else
				output[result_name] = description

	return output
