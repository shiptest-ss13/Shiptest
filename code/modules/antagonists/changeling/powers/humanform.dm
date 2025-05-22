/datum/action/changeling/humanform
	name = "Human Form"
	desc = "We change into a human. Costs 5 chemicals."
	button_icon_state = "human_form"
	chemical_cost = 5
	req_dna = 1

//Transform into a human.
/datum/action/changeling/humanform/sting_action(mob/living/carbon/user)
	if(user.movement_type & VENTCRAWLING)
		to_chat(user, span_notice("We must exit the pipes before we can transform back!"))
		return FALSE
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	var/datum/changelingprofile/chosen_prof = changeling.select_dna()
	if(!chosen_prof)
		return
	if(!user || user.notransform)
		return FALSE
	to_chat(user, span_notice("We transform our appearance."))
	..()
	changeling.purchasedpowers -= src

	var/datum/dna/chosen_dna = chosen_prof.dna
	var/datum/species/chosen_species = chosen_dna.species
	user.humanize(chosen_species)

	changeling.transform(user, chosen_prof)
	user.regenerate_icons()
	return TRUE
