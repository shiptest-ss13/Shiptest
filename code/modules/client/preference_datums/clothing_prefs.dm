// CORRESPONDING VARIABLE NAME:
// backpack
// default value: DBACKPACK
/datum/preference/choiced_string/default_backpack
	name = "Backpack Style"
	external_key = "default_backpack"

	default_value = DBACKPACK
	// you could argue it should depend on species, since some sprites not be implemented, but... shrug.
	randomization_flags = PREF_RAND_FLAG_SPAWN_HINTS

/datum/preference/choiced_string/default_backpack/get_options_list()
	return GLOB.backpacklist

/datum/preference/choiced_string/default_backpack/_is_available(list/dependency_data)
	return TRUE

/datum/preference/choiced_string/default_backpack/apply_to_human(mob/living/carbon/human/target, data)
	target.backpack = data

/datum/preference/choiced_string/default_backpack/randomize(list/dependency_data, list/rand_dependency_data)
	// FUCK random duffels!!!!!!!!!!!!!! none of that shit in this house
	return pick(GBACKPACK, GSATCHEL, GCOURIERBAG, LSATCHEL, DBACKPACK, DSATCHEL, DCOURIERBAG)

// UI CREATION
/*
			dat += "<b>Backpack:</b><BR><a href ='?_src_=prefs;preference=bag;task=input'>[backpack]</a>"
*/

// UI INTERACTION
/*
				if("bag")
					var/new_backpack = input(user, "Choose your character's style of bag:", "Character Preference")  as null|anything in GLOB.backpacklist
					if(new_backpack)
						backpack = new_backpack
*/

// CHARACTER COPY
/*
	character.backpack = backpack
*/

// SERIALIZATION
/*
	WRITE_FILE(S["backpack"]					, backpack)
*/

// DESERIALIZATION
/*
	READ_FILE(S["backpack"], backpack)
	backpack			= sanitize_inlist(backpack, GLOB.backpacklist, initial(backpack))
*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_BACKPACK])
		backpack = random_backpack()
/proc/random_backpack()
	return pick(GLOB.backpacklist)
*/


// CORRESPONDING VARIABLE NAME:
// jumpsuit_style
// default value: PREF_SUIT
/datum/preference/choiced_string/default_jumpsuit
	name = "Jumpsuit Style"
	external_key = "default_jumpsuit"

	default_value = PREF_SUIT
	randomization_flags = PREF_RAND_FLAG_SPAWN_HINTS

/datum/preference/choiced_string/default_jumpsuit/get_options_list()
	return GLOB.jumpsuitlist

/datum/preference/choiced_string/default_jumpsuit/_is_available(list/dependency_data)
	return TRUE

/datum/preference/choiced_string/default_jumpsuit/apply_to_human(mob/living/carbon/human/target, data)
	target.jumpsuit_style = data

/datum/preference/choiced_string/default_jumpsuit/randomize(list/dependency_data, list/rand_dependency_data)
	// i mean, look. most people in space are probably not wearing skirts. they're impractical!
	// yes this is femboy erasure
	if(prob(7))
		return PREF_SKIRT
	else
		return pick(GLOB.jumpsuitlist - PREF_SKIRT)

// UI CREATION
/*
			dat += "<br><b>Jumpsuit Style:</b><BR><a href ='?_src_=prefs;preference=suit;task=input'>[jumpsuit_style]</a>"

*/

// UI INTERACTION
/*
				if("suit")
					var/new_suit = input(user, "Choose your character's style of uniform:", "Character Preference")  as null|anything in GLOB.jumpsuitlist
					if(new_suit)
						jumpsuit_style = new_suit
*/

// CHARACTER COPY
/*
	character.jumpsuit_style = jumpsuit_style

*/

// SERIALIZATION
/*
	WRITE_FILE(S["jumpsuit_style"]				, jumpsuit_style)

*/

// DESERIALIZATION
/*
	READ_FILE(S["jumpsuit_style"], jumpsuit_style)
	READ_FILE(S["jumpsuit_style"], jumpsuit_style)
	jumpsuit_style		= sanitize_inlist(jumpsuit_style, GLOB.jumpsuitlist, initial(jumpsuit_style))

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_JUMPSUIT_STYLE])
		jumpsuit_style = PREF_SUIT

*/


// CORRESPONDING VARIABLE NAME:
// exowear
// default value: PREF_EXOWEAR
/datum/preference/choiced_string/default_exowear
	name = "Exowear Style"
	external_key = "default_exowear"

	default_value = PREF_EXOWEAR
	randomization_flags = PREF_RAND_FLAG_SPAWN_HINTS

/datum/preference/choiced_string/default_exowear/get_options_list()
	return GLOB.exowearlist

/datum/preference/choiced_string/default_exowear/_is_available(list/dependency_data)
	return TRUE

/datum/preference/choiced_string/default_exowear/apply_to_human(mob/living/carbon/human/target, data)
	target.exowear = data

// UI CREATION
/*
			dat += "<br><b>Outerwear Style:</b><BR><a href ='?_src_=prefs;preference=exo;task=input'>[exowear]</a>"

*/

// UI INTERACTION
/*
				if("exo")
					var/new_exo = input(user, "Choose your character's style of outerwear:", "Character Preference")  as null|anything in GLOB.exowearlist
					if(new_exo)
						exowear = new_exo

*/

// CHARACTER COPY
/*
	character.exowear = exowear

*/

// SERIALIZATION
/*
	WRITE_FILE(S["exowear"]						, exowear)

*/

// DESERIALIZATION
/*
	READ_FILE(S["exowear"], exowear)
	exowear				= sanitize_inlist(exowear, GLOB.exowearlist, initial(exowear))

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_EXOWEAR_STYLE])
		exowear = PREF_EXOWEAR
*/

