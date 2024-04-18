/*
Templates:

Autowiki/Reaction
{{{chems|ERROR}}} {{#if: {{{temperature|}}} | <br />Temperature {{{temperature}}} | }} {{#if: {{{container|}}} | <br />Needs container "{{{container}}}" | }} <br/>Makes {{{volume|1}}}u

Autowiki/Reagent
{{#if: {{{tooltip|}}} | {{Tooltip|{{{volume}}} part [[#{{{name}}}|{{{name}}}]]|{{{tooltip}}}|FEF6E7}} | {{{volume}}} part {{{name}}} }}

*/

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
		var/required_chems = ""
		for(var/datum/reagent/required_chem_type as anything in reaction.required_reagents)
			var/has_tooltip = (required_chem_type in mixable_reagents) && !(required_chem_type in reaction.results) && !(required_chem_type in GLOB.base_reagents)
			required_chems += format_required_reagent(required_chem_type, reaction.required_reagents[required_chem_type], has_tooltip)

		for(var/datum/reagent/required_catalyst_type as anything in reaction.required_catalysts)
			var/has_tooltip = (required_catalyst_type in mixable_reagents) && !(required_catalyst_type in reaction.results) && !(required_catalyst_type in GLOB.base_reagents)
			required_chems += format_required_reagent(required_catalyst_type, reaction.required_catalysts[required_catalyst_type], has_tooltip, "Catalyst")

		for(var/datum/reagent/result_chem_type as anything in reaction.results)
			var/result_name = escape_value(initial(result_chem_type.name))
			var/list/details = list("volume" = reaction.results[result_chem_type], "chems" = required_chems, "name" = result_name)

			if(reaction.required_temp > 0)
				details["temperature"] = "[reaction.is_cold_recipe ? "below" : "above"] [reaction.required_temp]K"

			if(reaction.required_container)
				details["container"] = "[escape_value(initial(reaction.required_container.name))]"

			var/description = include_template("Autowiki/Reaction", details)
			if(result_name in output)
				output[result_name] += "<br />OR<br />[description]"
			else
				output[result_name] = description

	return output

/datum/autowiki/reagents/proc/format_required_reagent(datum/reagent/required_reagent_type, volume, has_tooltip = FALSE, type)
	var/list/details = list(
		"volume" = volume,
		"name" = escape_value(initial(required_reagent_type.name))
	)

	if(has_tooltip)
		details["tooltip"] = include_template("Autowiki/Content/Reactions/[initial(required_reagent_type.name)]")

	if(type)
		details["type"] = type

	return include_template("Autowiki/Reagent", details)
