/datum/autowiki/reagents
	page = "Template:Autowiki/Content/Reagents"

/datum/autowiki/reagents/generate()
	var/output = ""

	var/list/mixable_reagents = list()
	for(var/type in subtypesof(/datum/chemical_reaction))
		var/datum/chemical_reaction/reaction = new type
		mixable_reagents |= reaction.results
		qdel(reaction)

	var/list/categories = list()

	for(var/reagent in mixable_reagents)
		var/datum/reagent/chem = new reagent

		LAZYINITLIST(categories[chem.category])
		categories[chem.category] += list(chem)

	for(var/category in sortList(categories))
		output += "\n"
		output += generate_category(category, categories[category])

	return output

/datum/autowiki/reagents/proc/generate_category(name, list/datum/reagent/reagents)
	var/output = "== [escape_value(name)] ==\n"

	output += "{| class='wikitable sortable' style=width:100%; text-align:left; border: 3px solid #FFDD66; cellspacing=0; cellpadding=2; background-color:white;'\n"
	output += "! scope='col' style='width:150px; background-color:#FFDD66;' |Name\n"
	output += "! class='unsortable' scope='col' style='width:150px; background-color:#FFDD66;' |Recipe\n"
	output += "! class='unsortable' scope='col' style='background-color:#FFDD66;' |Description\n"
	output += "! scope='col' | Metabolization Rate\n"
	output += "! scope='col' | Overdose Threshold\n"
	output += "! scope='col' | Addiction Threshold\n"
	output += "|-\n"

	reagents = sortList(reagents, /proc/cmp_typepaths_asc)

	for(var/datum/reagent/reagent as anything in reagents)
		output += "! style='background-color: #FFEE88;' | [include_template("anchor", list("1" = escape_value(reagent.name)))][escape_value(reagent.name)] <span style='color:[escape_value(reagent.color)];background-color:[escape_value(reagent.color)]'>_</span>\n"
		output += "|[include_template("Autowiki/Content/Reactions/[escape_value(reagent.name)]")]\n"
		output += "|[escape_value(reagent.description)]\n"
		output += "|data-sort-value=[reagent.metabolization_rate]|[reagent.metabolization_rate] units per tick\n"
		output += "|[reagent.overdose_threshold || "data-sort-value=0|N/A"]\n"
		output += "|[reagent.addiction_threshold || "data-sort-value=0|N/A"]\n"
		output += "|-\n"

	output += "|}\n"

	return output
