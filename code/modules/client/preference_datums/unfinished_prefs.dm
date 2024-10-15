#warn this file is just a temporary staging ground for all the preferences i've written a small part of. it also helps me remember what the old variable corresponding to a pref was. aint nothing more than that
#warn prefs with no dependencies don't actually need an availability check.
#warn clear out all the damn commented blocks in every file

// CORRESPONDING VARIABLE NAME:
// pref_species
// default human
/datum/preference/species
	name = "Species"
	external_key = "species"

	application_priority = PREF_APPLICATION_PRIORITY_SPECIES_PRELIMINARY
	randomization_flags = PREF_RAND_FLAG_APPEARANCE | PREF_RAND_FLAG_IDENTITY

/datum/preference/species/New(...)
	. = ..()
	if(application_priority <= PREF_APPLICATION_PRIORITY_SPECIES_FINALIZE)
		CRASH("[type] has application_priority [application_priority], which is not less than the bodyplan-finalization priority of [PREF_APPLICATION_PRIORITY_SPECIES_FINALIZE]! This breaks preference application really bad!")

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
	if(!(chosen_species.id in GLOB.roundstart_races) && !(chosen_species.id in (CONFIG_GET(keyed_list/roundstart_no_hard_check))))
		return "[chosen_species] not a valid join species."
	return FALSE

/datum/preference/species/apply_to_human(mob/living/carbon/human/target, data)
	var/datum/species/chosen_species = data
	target.set_species_prelim(chosen_species.type)

/datum/preference/species/_serialize(data)
	var/datum/species/chosen_species = data
	return chosen_species.id

/datum/preference/species/deserialize(serialized_data)
	var/datum/species/spec_type = GLOB.species_list[serialized_data]
	return new spec_type()

/datum/preference/species/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	var/datum/species/old_spec = old_data

	var/new_id = input(user, "Choose your character's species:", "Character Preference", old_spec.id) as null|anything in GLOB.roundstart_races
	if(new_id && new_id != old_spec.id)
		// no need to create a new species datum if the old one is still valid
		var/new_spec_type = GLOB.species_list[new_id]
		return new new_spec_type()
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
	// application_priority = PREF_APPLICATION_PRIORITY_SPECIES_FINALIZE

	// default_value =

	// dependencies = list()

	// randomization_flags = NONE
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


