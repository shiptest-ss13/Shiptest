// CORRESPONDING VARIABLE NAME:
// real_name
// no default, always randomized
/datum/preference/real_name
	name = "Name"
	external_key = "real_name"
	#warn this really demonstrates the failing of "always valid" default values... i HATE john trasen!!!!
	default_value = "John Trasen"

	#warn this is kinda dumb. if the config flag flag/humans_need_surnames isn't enabled on the server it might as well be removed...
	dependencies = list(/datum/preference/species)

	rand_dependencies = list(/datum/preference/choiced_string/gender)

/datum/preference/real_name/_is_available(list/dependency_data)
	return TRUE

#warn reject_bad_name is much weightier than this needs to be. lots of string ops. combined with the species dependency, this might be legitimately inefficient
/datum/preference/real_name/_is_invalid(data, list/dependency_data)
	if(!istext(data))
		return "Name must be a string!"

	var/cleaned_name = reject_bad_name(data, MAX_NAME_LEN, TRUE)
	if(!cleaned_name || cleaned_name != data)
		return "Name must be between 2 and [MAX_NAME_LEN] characters long and ASCII-only!"

	#warn hopefully this can be Fucking Removed
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	if(CONFIG_GET(flag/humans_need_surnames) && (chosen_species.id == SPECIES_HUMAN))
		var/firstspace = findtext(data, " ")
		var/name_length = length(data)
		//we need a surname
		if(!firstspace || firstspace == name_length)
			return "Humans must have surnames!"

	return FALSE

/datum/preference/real_name/apply_to_human(mob/living/carbon/human/target, data)
	target.real_name = data
	target.name = data
	target.dna.real_name = data

/datum/preference/real_name/_serialize(data)
	return data

/datum/preference/real_name/deserialize(serialized_data)
	return serialized_data

/datum/preference/real_name/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	// we autofilter the name for ease of use
	var/new_name = reject_bad_name(
		input(user, "Choose your character's name:", "Character Preference", old_data) as text|null,
		MAX_NAME_LEN,
		TRUE
	)
	if(new_name)
		return new_name
	return old_data

/datum/preference/real_name/randomize(list/dependency_data, list/rand_dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	return chosen_species.random_name(dependency_data[/datum/preference/choiced_string/gender], TRUE)

// UI CREATION
/*
			dat += "<br><b>Name:</b> "
			dat += "<a href='?_src_=prefs;preference=name;task=input'>[real_name]</a><BR>"

*/

// UI INTERACTION
/*
	if("name")
		var/new_name =  reject_bad_name( input(user, "Choose your character's name:", "Character Preference")  as text|null)
		if(new_name)
			real_name = new_name
		else
			to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, 0-9, and the following punctuation: ' - . ~ | @ : # $ % & * +</font>")
*/

// CHARACTER COPY
/*
	if(roundstart_checks)
		if(CONFIG_GET(flag/humans_need_surnames) && (dat_species.id == SPECIES_HUMAN))
			var/firstspace = findtext(real_name, " ")
			var/name_length = length(real_name)
			if(!firstspace)	//we need a surname
				real_name += " [pick(GLOB.last_names)]"
			else if(firstspace == name_length)
				real_name += "[pick(GLOB.last_names)]"

	character.real_name = real_name

*/

// SERIALIZATION
/*
	real_name = chosen_species.random_name(gender,1)
	WRITE_FILE(S["real_name"]					, real_name)

*/

// DESERIALIZATION
/*
	READ_FILE(S["real_name"], real_name)


	real_name = reject_bad_name(real_name)
	gender = sanitize_gender(gender)
	if(!real_name)
		real_name = random_unique_name(gender)


*/

// RANDOMIZATION
/*
	real_name = chosen_species.random_name(gender,1)

	if("random")
		switch(href_list["preference"])
			if("name")
				real_name = chosen_species.random_name(gender,1)

	if((randomise[RANDOM_NAME] || randomise[RANDOM_NAME_ANTAG] && antagonist) && !character_setup)
		slot_randomized = TRUE
		real_name = dat_species.random_name(gender)

	else if(randomise[RANDOM_NAME])
		var/datum/species/chosen_species = get_pref_data(/datum/preference/species)
		real_name = chosen_species.random_name(gender,1)

*/


// CORRESPONDING VARIABLE NAME:
// gender
// default male
/datum/preference/choiced_string/gender
	name = "Gender"
	external_key = "gender"
	default_value = MALE

	dependencies = list(/datum/preference/species)

/datum/preference/choiced_string/gender/get_options_list()
	// not sure if there's a global list for this..?
	return list(MALE, FEMALE, PLURAL, NEUTER)

// note: uses builtin define values NEUTER, MALE, FEMALE, PLURAL which are strings
/datum/preference/choiced_string/gender/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	// AGENDER in species_traits automatically sets character gender to PLURAL (i.e. they/them) when the species is set,
	// so this option doesn't need to be visible 24/7
	if(!(AGENDER in chosen_species.species_traits))
		return FALSE
	return TRUE

/datum/preference/choiced_string/gender/apply_to_human(mob/living/carbon/human/target, data)
	target.gender = data

/datum/preference/choiced_string/gender/randomize(list/dependency_data, list/rand_dependency_data)
	// we don't randomize to neuter pronouns, since it might be a bit odd to see those on a random body. all love to the it/its of the world though
	return pick(MALE, FEMALE, PLURAL)

// UI CREATION
/*
			if(!(AGENDER in current_species.species_traits))
				var/dispGender
				if(gender == MALE)
					dispGender = "Male"
				else if(gender == FEMALE)
					dispGender = "Female"
				else
					dispGender = "Other"
				dat += "<b>Gender:</b> <a href='?_src_=prefs;preference=gender'>[dispGender]</a>"
				if(randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG]) //doesn't work unless random body
					dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_GENDER]'>Always Random Gender: [(randomise[RANDOM_GENDER]) ? "Yes" : "No"]</A>"
					dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_GENDER_ANTAG]'>When Antagonist: [(randomise[RANDOM_GENDER_ANTAG]) ? "Yes" : "No"]</A>"


*/

// UI INTERACTION
/*
				if("gender")
					var/pickedGender = input(user, "Choose your gender.", "Character Preference", gender) as null|anything in friendlyGenders
					if(pickedGender && friendlyGenders[pickedGender] != gender)
						gender = friendlyGenders[pickedGender]
						underwear = random_underwear(gender)
						undershirt = random_undershirt(gender)
						socks = random_socks()
						facial_hairstyle = random_facial_hairstyle(gender)
						hairstyle = random_hairstyle(gender)


*/

// CHARACTER COPY
/*
	character.gender = gender

*/

// SERIALIZATION
/*
	WRITE_FILE(S["gender"]						, gender)

*/

// DESERIALIZATION
/*
	READ_FILE(S["gender"], gender)

	if(gender == MALE)
		hairstyle								= sanitize_inlist(hairstyle, GLOB.hairstyles_male_list)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_male_list)
	else if(gender == FEMALE)
		hairstyle								= sanitize_inlist(hairstyle, GLOB.hairstyles_female_list)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_female_list)
	else
		hairstyle								= sanitize_inlist(hairstyle, GLOB.hairstyles_list)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_list)
		underwear								= sanitize_inlist(underwear, GLOB.underwear_list)
		undershirt 								= sanitize_inlist(undershirt, GLOB.undershirt_list)
*/

// RANDOMIZATION
/*
	if(gender_override && !(randomise[RANDOM_GENDER] || randomise[RANDOM_GENDER_ANTAG] && antag_override))
		gender = gender_override
	else
		gender = pick(MALE,FEMALE,PLURAL)

*/


// CORRESPONDING VARIABLE NAME:
// age
// default 30
/datum/preference/age
	name = "Age"
	// having a key this short feels weird to me. doesn't affect anything though
	external_key = "age"
	default_value = 30 // sure

	dependencies = list(/datum/preference/species)

/datum/preference/age/_is_available(list/dependency_data)
	return TRUE

/datum/preference/age/_is_invalid(data, list/dependency_data)
	var/datum/species/cur_species = dependency_data[/datum/preference/species]

	if(!isnum(data) || round(data) != data || data < 0)
		return "Age must be a whole number!"
	if(data > cur_species.species_age_max || data < cur_species.species_age_min)
		return "Age is outside the species range of [cur_species.species_age_min] to [cur_species.species_age_max]!"
	return FALSE

/datum/preference/age/apply_to_human(mob/living/carbon/human/target, data)
	target.age = data

/datum/preference/age/_serialize(data)
	return "[data]"

/datum/preference/age/deserialize(serialized_data)
	return text2num(serialized_data)

/datum/preference/age/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	var/datum/species/cur_species = dependency_data[/datum/preference/species]
	var/new_age
	new_age = input(user, "Choose your character's age:\n([cur_species.species_age_min]-[cur_species.species_age_max])", "Character Preference", old_data) as num|null
	if(new_age)
		// make sure it's in the valid range
		return clamp(round(text2num(new_age)), cur_species.species_age_min, cur_species.species_age_max)
	return old_data

/datum/preference/age/randomize(list/dependency_data, list/rand_dependency_data)
	var/datum/species/cur_species = dependency_data[/datum/preference/species]
	return rand(cur_species.species_age_min, cur_species.species_age_max)

// UI CREATION
/*
			dat += "<br><b>Age:</b> <a href='?_src_=prefs;preference=age;task=input'>[age]</a>"
			if(randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG]) //doesn't work unless random body
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_AGE]'>Always Random Age: [(randomise[RANDOM_AGE]) ? "Yes" : "No"]</A>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_AGE_ANTAG]'>When Antagonist: [(randomise[RANDOM_AGE_ANTAG]) ? "Yes" : "No"]</A>"

*/

// UI INTERACTION
/*
				if("age")
					var/new_age = input(user, "Choose your character's age:\n([chosen_species.species_age_min]-[chosen_species.species_age_max])", "Character Preference") as num|null
					if(new_age)
						age = clamp(round(text2num(new_age)), chosen_species.species_age_min, chosen_species.species_age_max)

*/

// CHARACTER COPY
/*
	character.age = clamp(age, dat_species.species_age_min, dat_species.species_age_max)

*/

// SERIALIZATION
/*
	READ_FILE(S["age"], age)
	age					= sanitize_integer(age, chosen_species.species_age_min, chosen_species.species_age_max, initial(age))

*/

// DESERIALIZATION
/*
	WRITE_FILE(S["age"]							, age)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_AGE] || randomise[RANDOM_AGE_ANTAG] && antag_override)
		age = rand(AGE_MIN,AGE_MAX)

*/

#warn really similar to choiced_string... rbugh.
// CORRESPONDING VARIABLE NAME:
// generic_adjective
// default value "Unremarkable"
/datum/preference/generic_adjective
	name = "Adjective"
	external_key = "generic_adjective"
	default_value = "Unremarkable"

	dependencies = list(/datum/preference/species)

/datum/preference/generic_adjective/_is_available(list/dependency_data)
	return TRUE

/datum/preference/generic_adjective/_is_invalid(data, list/dependency_data)
	var/list/adj_list
	// kind of a dumb solution, should probably be subtyped onto species
	if(istype(dependency_data[/datum/preference/species], /datum/species/ipc))
		adj_list = GLOB.ipc_preference_adjectives
	else
		adj_list = GLOB.preference_adjectives

	if(!(data in adj_list))
		return "[data] is not a valid adjective" + (istype(dependency_data[/datum/preference/species], /datum/species/ipc) ? " for IPCs!" : "!")

	return FALSE

/datum/preference/generic_adjective/apply_to_human(mob/living/carbon/human/target, data)
	target.generic_adjective = data

/datum/preference/generic_adjective/_serialize(data)
	return data

/datum/preference/generic_adjective/deserialize(serialized_data)
	return serialized_data

/datum/preference/generic_adjective/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	var/list/adj_list
	if(istype(dependency_data[/datum/preference/species], /datum/species/ipc))
		adj_list = GLOB.ipc_preference_adjectives
	else
		adj_list = GLOB.preference_adjectives

	var/new_selection
	new_selection = input(user, "In one word, how would you describe your character's appearance?", "Character Preference", old_data) as null|anything in adj_list
	if(new_selection)
		return new_selection
	return old_data

/datum/preference/generic_adjective/randomize(list/dependency_data, list/rand_dependency_data)
	if(istype(dependency_data[/datum/preference/species], /datum/species/ipc))
		return pick(GLOB.ipc_preference_adjectives)
	else
		return pick(GLOB.preference_adjectives)

// UI CREATION
/*
			if("body_size" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Size</h3>"

				dat += "<a href='?_src_=prefs;preference=body_size;task=input'>[features["body_size"]]</a><BR>"


				dat += "<h3>Character Adjective</h3>"

				dat += "<a href='?_src_=prefs;preference=generic_adjective;task=input'>[generic_adjective]</a><BR>"

*/

// UI INTERACTION
/*
				if("generic_adjective")
					var/selectAdj
					if(istype(chosen_species, /datum/species/ipc))
						selectAdj = input(user, "In one word, how would you describe your character's appereance?", "Character Preference", generic_adjective) as null|anything in GLOB.ipc_preference_adjectives
					else
						selectAdj = input(user, "In one word, how would you describe your character's appereance?", "Character Preference", generic_adjective) as null|anything in GLOB.preference_adjectives
					if(selectAdj)
						generic_adjective = selectAdj

*/

// CHARACTER COPY
/*
	character.generic_adjective = generic_adjective

*/

// SERIALIZATION
/*
	WRITE_FILE(S["generic_adjective"]			, generic_adjective) // ! UNSANITIZED!!!!!

*/

// DESERIALIZATION
/*
	READ_FILE(S["generic_adjective"], generic_adjective)

*/

// RANDOMIZATION
/*
	unsure, but it apparently does happen. not sure where. maybe on /mob/.../human creation
*/


