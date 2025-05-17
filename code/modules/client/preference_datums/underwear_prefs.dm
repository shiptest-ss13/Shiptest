// CORRESPONDING VARIABLE NAME:
// underwear
// default value = "Nude"
/datum/preference/choiced_string/underwear_bottom
	name = "Underwear"
	external_key = "underwear_bottom"

	default_value = /datum/sprite_accessory/underwear/nude::name
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/choiced_string/underwear_bottom/get_options_list()
	return GLOB.underwear_list

/datum/preference/choiced_string/underwear_bottom/_is_available(list/dependency_data)
	var/datum/species/dep_species = dependency_data[/datum/preference/species]
	if(NO_UNDERWEAR in dep_species.species_traits)
		return FALSE
	return TRUE

/datum/preference/choiced_string/underwear_bottom/apply_to_human(mob/living/carbon/human/target, data)
	target.underwear = data

// UI CREATION
/*
			if(!(NO_UNDERWEAR in current_species.species_traits))
				dat += "<b>Underwear:</b><br><a href ='?_src_=prefs;preference=underwear;task=input'>[underwear]</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERWEAR]'>[(randomise[RANDOM_UNDERWEAR]) ? "Lock" : "Unlock"]</A><br>"
*/

// UI INTERACTION
/*
				if("underwear")
					var/new_underwear
					new_underwear = input(user, "Choose your character's underwear:", "Character Preference")  as null|anything in GLOB.underwear_list
					if(new_underwear)
						underwear = new_underwear
*/

// CHARACTER COPY
/*
	character.underwear = underwear

*/

// SERIALIZATION
/*
	WRITE_FILE(S["underwear"]					, underwear)
*/

// DESERIALIZATION
/*
	READ_FILE(S["underwear"], underwear)
		underwear								= sanitize_inlist(underwear, GLOB.underwear_list)
*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_UNDERWEAR])
		underwear = random_underwear()
*/


// CORRESPONDING VARIABLE NAME:
// undershirt
// default value: "Nude" // in the far future of shiptest we have finally freed the nipple
/datum/preference/choiced_string/undershirt
	name = "Undershirt"
	external_key = "underwear_undershirt"

	default_value = /datum/sprite_accessory/undershirt/nude::name
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/choiced_string/undershirt/get_options_list()
	return GLOB.undershirt_list

/datum/preference/choiced_string/undershirt/_is_available(list/dependency_data)
	var/datum/species/dep_species = dependency_data[/datum/preference/species]
	if(NO_UNDERWEAR in dep_species.species_traits)
		return FALSE
	return TRUE

/datum/preference/choiced_string/undershirt/apply_to_human(mob/living/carbon/human/target, data)
	target.undershirt = data


// UI CREATION
/*
			if(!(NO_UNDERWEAR in current_species.species_traits))
				dat += "<b>Undershirt:</b><br><a href ='?_src_=prefs;preference=undershirt;task=input'>[undershirt]</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERSHIRT]'>[(randomise[RANDOM_UNDERSHIRT]) ? "Lock" : "Unlock"]</A><br>"

*/

// UI INTERACTION
/*
				if("undershirt")
					var/new_undershirt
					new_undershirt = input(user, "Choose your character's undershirt:", "Character Preference") as null|anything in GLOB.undershirt_list
					if(new_undershirt)
						undershirt = new_undershirt

*/

// CHARACTER COPY
/*
	character.undershirt = undershirt

*/

// SERIALIZATION
/*
	WRITE_FILE(S["undershirt"]					, undershirt)

*/

// DESERIALIZATION
/*
	READ_FILE(S["undershirt"], undershirt)
		undershirt 								= sanitize_inlist(undershirt, GLOB.undershirt_list)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_UNDERSHIRT])
		undershirt = random_undershirt(get_pref_data(/datum/preference/gender)) // nvm the nipple remains unfreed

*/

// CORRESPONDING VARIABLE NAME:
// socks
// default value: "Nude" // let those dogs bark
/datum/preference/choiced_string/socks
	name = "Socks"
	external_key = "underwear_socks"

	default_value = /datum/sprite_accessory/socks/nude::name
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/choiced_string/socks/get_options_list()
	return GLOB.socks_list

/datum/preference/choiced_string/socks/_is_available(list/dependency_data)
	var/datum/species/dep_species = dependency_data[/datum/preference/species]
	#warn might be worth removing NO_SOCKS when we update to master and find it still unused?
	if((NO_SOCKS in dep_species.species_traits) || (NO_UNDERWEAR in dep_species.species_traits))
		return FALSE
	return TRUE

/datum/preference/choiced_string/socks/apply_to_human(mob/living/carbon/human/target, data)
	target.socks = data

// UI CREATION
/*
	NO_SOCKS trait not respected??
			if(!(NO_UNDERWEAR in current_species.species_traits))
				dat += "<b>Socks:</b><br><a href ='?_src_=prefs;preference=socks;task=input'>[socks]</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SOCKS]'>[(randomise[RANDOM_SOCKS]) ? "Lock" : "Unlock"]</A><br>"

*/

// UI INTERACTION
/*
				if("socks")
					var/new_socks
					new_socks = input(user, "Choose your character's socks:", "Character Preference") as null|anything in GLOB.socks_list
					if(new_socks)
						socks = new_socks


*/

// CHARACTER COPY
/*
	character.socks = socks
*/

// SERIALIZATION
/*
	WRITE_FILE(S["socks"]						, socks)

*/

// DESERIALIZATION
/*
	READ_FILE(S["socks"], socks)
	socks				= sanitize_inlist(socks, GLOB.socks_list)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_SOCKS])
		socks = random_socks()
*/


// CORRESPONDING VARIABLE NAME:
// underwear_color
// default value: "000"
/datum/preference/color/underwear_bottom_color
	name = "Underwear Color"
	external_key = "underwear_bottom_color"

	default_value = "#FFFFFF"
	include_hash = TRUE
	min_hsv_value = 10
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/color/underwear_bottom_color/_is_available(list/dependency_data)
	var/datum/species/dep_species = dependency_data[/datum/preference/species]
	if(NO_UNDERWEAR in dep_species.species_traits)
		return FALSE
	return TRUE

/datum/preference/color/underwear_bottom_color/apply_to_human(mob/living/carbon/human/target, data)
	target.underwear_color = data

// UI CREATION
/*
			if(!(NO_UNDERWEAR in current_species.species_traits))
				dat += "<b>Underwear Color:</b><br><span style='border: 1px solid #161616; background-color: #[underwear_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=underwear_color;task=input'>Change</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERWEAR_COLOR]'>[(randomise[RANDOM_UNDERWEAR_COLOR]) ? "Lock" : "Unlock"]</A><br>"

*/

// UI INTERACTION
/*
				if("underwear_color")
					var/new_underwear_color = input(user, "Choose your character's underwear color:", "Character Preference","#"+underwear_color) as color|null
					if(new_underwear_color)
						underwear_color = sanitize_hexcolor(new_underwear_color)

*/

// CHARACTER COPY
/*
	character.underwear_color = underwear_color

*/

// SERIALIZATION
/*
	WRITE_FILE(S["underwear_color"]				, underwear_color)
*/

// DESERIALIZATION
/*
	READ_FILE(S["underwear_color"], underwear_color)
	underwear_color		= sanitize_hexcolor(underwear_color)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_UNDERWEAR_COLOR])
		underwear_color = random_color()
*/



// CORRESPONDING VARIABLE NAME:
// undershirt_color
// default value: "000"
/datum/preference/color/undershirt_color
	name = "Undershirt Color"
	external_key = "underwear_undershirt_color"

	default_value = "#FFFFFF"
	include_hash = TRUE
	min_hsv_value = 10
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/color/undershirt_color/_is_available(list/dependency_data)
	var/datum/species/dep_species = dependency_data[/datum/preference/species]
	if(NO_UNDERWEAR in dep_species.species_traits)
		return FALSE
	return TRUE

/datum/preference/color/undershirt_color/apply_to_human(mob/living/carbon/human/target, data)
	target.undershirt_color = data

// UI CREATION
/*
			if(!(NO_UNDERWEAR in current_species.species_traits))
				dat += "<b>Undershirt Color:</b><br><span style='border: 1px solid #161616; background-color: #[undershirt_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=undershirt_color;task=input'>Change</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERSHIRT_COLOR]'>[(randomise[RANDOM_UNDERSHIRT_COLOR]) ? "Lock" : "Unlock"]</A><br>"

*/

// UI INTERACTION
/*
				if("undershirt_color")
					var/new_undershirt_color = input(user, "Choose your character's underwear color:", "Character Preference","#"+undershirt_color) as color|null
					if(new_undershirt_color)
						undershirt_color = sanitize_hexcolor(new_undershirt_color)

*/

// CHARACTER COPY
/*
	character.undershirt_color = undershirt_color

*/

// SERIALIZATION
/*
	WRITE_FILE(S["undershirt_color"]			, undershirt_color)

*/

// DESERIALIZATION
/*
	READ_FILE(S["undershirt_color"], undershirt_color)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_UNDERSHIRT_COLOR])
		undershirt_color = random_short_color()

*/



// CORRESPONDING VARIABLE NAME:
// socks_color
// default_value = "000"
/datum/preference/color/socks_color
	name = "Sock Color"
	external_key = "underwear_socks_color"

	default_value = "#FFFFFF"
	include_hash = TRUE
	min_hsv_value = 10
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/color/socks_color/_is_available(list/dependency_data)
	var/datum/species/dep_species = dependency_data[/datum/preference/species]
	if((NO_SOCKS in dep_species.species_traits) || (NO_UNDERWEAR in dep_species.species_traits))
		return FALSE
	return TRUE

/datum/preference/color/socks_color/apply_to_human(mob/living/carbon/human/target, data)
	target.socks_color = data

// UI CREATION
/*
			if(!(NO_UNDERWEAR in current_species.species_traits))
				dat += "<b>Socks Color:</b><br><span style='border: 1px solid #161616; background-color: #[socks_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=socks_color;task=input'>Change</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SOCKS_COLOR]'>[(randomise[RANDOM_SOCKS_COLOR]) ? "Lock" : "Unlock"]</A></td>"
*/

// UI INTERACTION
/*
				if("socks_color")
					var/new_socks_color = input(user, "Choose your character's underwear color:", "Character Preference","#"+socks_color) as color|null
					if(new_socks_color)
						socks_color = sanitize_hexcolor(new_socks_color)
*/

// CHARACTER COPY
/*
	character.socks_color = socks_color
*/

// SERIALIZATION
/*
	WRITE_FILE(S["socks_color"]					, socks_color)
*/

// DESERIALIZATION
/*
	READ_FILE(S["socks_color"], socks_color)
*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_SOCKS_COLOR])
		socks_color = random_short_color()
*/

