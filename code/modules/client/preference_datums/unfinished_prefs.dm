#warn this file is just a temporary staging ground for all the preferences i've written a small part of. it also helps me remember what the old variable corresponding to a pref was. aint nothing more than that
#warn prefs with no dependencies don't actually need an availability check.

// CORRESPONDING VARIABLE NAME:
// pref_species
// default human
/datum/preference/species
	name = "Species"
	external_key = "species"

	// it has to happen early
	application_priority = 10

/datum/preference/species/New(...)
	. = ..()
	// we need a default value
	default_value = new /datum/species/human()

/datum/preference/species/_is_available(list/dependency_data)
	return TRUE

/datum/preference/species/_is_invalid(data, list/dependency_data)
	if(!istype(data, /datum/species))
		return "[data] is not a species datum!"
	var/datum/species/chosen_species = data
	#warn roundstart_races isn't populated at The Beginning Of Everything but instead at the end of SSticker init. unsure if that happens before clients connect or not. test
	#warn also the name "roundstart_races" and "roundstart_no_hard_check" doesn't quite make sense since we don't have roundstart........
	if(!(chosen_species.id in GLOB.roundstart_races) || !(chosen_species.id in (CONFIG_GET(keyed_list/roundstart_no_hard_check))))
		return "[chosen_species] not a valid join species."
	return FALSE

/datum/preference/species/apply_to_human(mob/living/carbon/human/target, data)
	#warn ughhghghghghghghh. set_species calls code (quirk handling and stack-based hand stuff) that has a chance to sleep
	#warn read below
	// ! so, the issue here is set_species, which does a total regeneration of bodyparts and organs.
	// ! first of all, that might end up being sort of unnecessary depending on how we handle prosthetics / organ features.

	// ! cat ears / tails / etc. for humans are handled by the human species adding the ears to its mutant organ vars in on_species_gain().
	// ! that's... sort of in conflict with the way we want to do things prefwise, where the only necessary step to adding cat ears to a species is to make their pref available for that species.
	// ! this cuts at the heart of a problem with the whole prefs model that i haven't quite fully ironed out.
	// ! do we want a character creation-parochial view, or a less specialized (and, ultimately, more boilerplatey) one?
	#warn need to add fbp compat. fuck
	var/datum/species/chosen_species = data
	target.set_species(chosen_species.type, icon_update = FALSE, robotic = FALSE)

/datum/preference/species/_serialize(data)
	var/datum/species/chosen_species = data
	return chosen_species.id

/datum/preference/species/deserialize(serialized_data)
	var/datum/species/spec_type = GLOB.species_list[serialized_data]
	return new spec_type()

/datum/preference/species/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	var/new_id = input(user, "Choose your character's species:", "Character Preference", old_data) as null|anything in GLOB.roundstart_races
	if(new_id && new_id != old_data)
		// no need to create a new species datum if the old one is still valid
		return new GLOB.species_list[new_id]
	return old_data

/datum/preference/species/randomize(list/dependency_data, list/rand_dependency_data)
	var/rand_spec_id = pick(GLOB.roundstart_races)
	var/datum/species/spec_type = GLOB.species_list[rand_spec_id]
	return new spec_type()

// UI CREATION
/*
/datum/preferences/proc/ShowSpeciesChoices(mob/user)
	var/list/dat = list()
	dat += "<div><table style='width:100%'><tr><th>"
	dat += "<div style='overflow-y:auto;height=180px;width=75px'>"
	for(var/speciesid in GLOB.roundstart_races)
		var/speciespath = GLOB.species_list[speciesid]
		if(!speciespath)
			continue
		var/datum/species/S = new speciespath()
		if(species_looking_at == speciesid)
			dat += "<b>[S.name]</b><BR><BR>"
		else
			dat += "<a href='?_src_=prefs;preference=species;task=lookatspecies;newspecies=[speciesid]'>[S.name]</a><BR><BR>"
		QDEL_NULL(S)

	dat += "</div></th><th><div style='overflow-y:auto;height=180px;width=420px'>"
	var/sppath = GLOB.species_list[species_looking_at]
	var/datum/species/S = new sppath()

	dat += "<center><font size=3 style='font-weight:bold'>[S.name]</font><BR><BR>[S.loreblurb]</center></div></th><th>"
	if(pref_species.id == species_looking_at)
		dat += "Set Species "
	else
		dat += "<a href='?_src_=prefs;preference=species;task=setspecies;newspecies=[species_looking_at]'>Set Species</a> "
	dat += "<a href='?_src_=prefs;preference=species;task=close'>Done</a><BR>"
	user << browse(null, "window=preferences")
	var/datum/browser/popup = new(user, "mob_species", "<div align='center'>Species Pick</div>", 700, 350)
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)
	QDEL_NULL(S)

*/

// UI INTERACTION
/*
	if(href_list["preference"] == "species")
		switch(href_list["task"])
			if("random")
				random_species()
				ShowChoices(user)
				return TRUE
			if("close")
				user << browse(null, "window=mob_species")
				ShowChoices(user)
				return TRUE
			if("setspecies")
				var/sid = href_list["newspecies"]
				var/newtype = GLOB.species_list[sid]
				pref_species = new newtype()
				//Now that we changed our species, we must verify that the mutant colour is still allowed.
				var/temp_hsv = RGBtoHSV(features["mcolor"])
				if(text2num(features["mcolor"], 16) == 0  || (!(MUTCOLORS_PARTSONLY in pref_species.species_traits) && ReadHSV(temp_hsv)[3] < ReadHSV("#191919")[3]))
					features["mcolor"] = pref_species.default_color
				user << browse(null, "window=speciespick")
				ShowChoices(user)
				age = rand(pref_species.species_age_min, pref_species.species_age_max)
				handle_quirk_conflict("species", pref_species)
				return TRUE
			if("lookatspecies")
				species_looking_at = href_list["newspecies"]

		ShowSpeciesChoices(user)
		return TRUE

*/

// CHARACTER COPY
/*
	var/datum/species/chosen_species
	chosen_species = pref_species.type
	if(roundstart_checks && !(pref_species.id in GLOB.roundstart_races) && !(pref_species.id in (CONFIG_GET(keyed_list/roundstart_no_hard_check))))
		chosen_species = /datum/species/human
		pref_species = new /datum/species/human
		save_character()

	//prosthetics work for vox and kepori and update just fine for everyone
	character.dna.features = features.Copy()
	character.set_species(chosen_species, icon_update = FALSE, pref_load = TRUE, robotic = fbp)

	// prosthetic handling goes here (removed)

	if(pref_species.id == "ipc") // If triggered, vox and kepori arms do not spawn in but ipcs sprites break without it as the code for setting the right prosthetics for them is in set_species().
		character.set_species(chosen_species, icon_update = FALSE, pref_load = TRUE)

*/

// SERIALIZATION
/*
	WRITE_FILE(S["species"]						, pref_species.id)
*/

// DESERIALIZATION
/*
	READ_FILE(S["species"], species_id)
	if(species_id)
		var/newtype = GLOB.species_list[species_id]
		if(newtype)
			pref_species = new newtype
*/


// CORRESPONDING VARIABLE NAME:
//
// default value:
/datum/preference/
	// abstract_type = /datum/preference

	// name =

	// external_key =
	// application_priority = 0

	// default_value =

	// dependencies = list()

	// can_be_randomized = TRUE
	// rand_dependencies = list()

/datum/preference//_is_available(list/dependency_data)

/datum/preference//_is_invalid(data, list/dependency_data)

/datum/preference//apply_to_human(mob/living/carbon/human/target, data)

/datum/preference//_serialize(data)

/datum/preference//deserialize(serialized_data)

/datum/preference//button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)

/datum/preference//randomize(list/dependency_data, list/rand_dependency_data)

// UI CREATION
/*

*/

// UI INTERACTION
/*

*/

// CHARACTER COPY
/*

*/

// SERIALIZATION
/*

*/

// DESERIALIZATION
/*

*/

// RANDOMIZATION
/*

*/


