// CORRESPONDING VARIABLE NAME:
// hairstyle
// default value: "Bald"
/datum/preference/choiced_string/hairstyle
	name = "Hairstyle"
	external_key = "hairstyle"

	default_value = /datum/sprite_accessory/hair/bald::name
	dependencies = list(/datum/preference/species)

/datum/preference/choiced_string/hairstyle/get_options_list()
	return GLOB.hairstyles_list

/datum/preference/choiced_string/hairstyle/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	if(HAIR in chosen_species.species_traits)
		return TRUE
	return FALSE

/datum/preference/choiced_string/hairstyle/apply_to_human(mob/living/carbon/human/target, data)
	target.hairstyle = data

/datum/preference/choiced_string/hairstyle/randomize(list/dependency_data, list/rand_dependency_data)
	// i feel like some people are always gonna be bald, you know? it shouldn't be a 0.5% chance or whatever just because there's only one bald hairstyle.
	if(prob(5))
		return /datum/sprite_accessory/hair/bald::name
	// not convinced that random_hairstyle is really worth keeping...
	return random_hairstyle()


// UI CREATION
/*
			if(HAIR in current_species.species_traits)

				dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Hairstyle</h3>"

				dat += "<a href='?_src_=prefs;preference=hairstyle;task=input'>[hairstyle]</a>"
				dat += "<a href='?_src_=prefs;preference=previous_hairstyle;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_hairstyle;task=input'>&gt;</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HAIRSTYLE]'>[(randomise[RANDOM_HAIRSTYLE]) ? "Lock" : "Unlock"]</A>"

*/

// UI INTERACTION
/*
				if("hairstyle")
					var/new_hairstyle
					if(get_pref_data(/datum/preference/gender) == MALE)
						new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in GLOB.hairstyles_male_list
					else if(get_pref_data(/datum/preference/gender) == FEMALE)
						new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in GLOB.hairstyles_female_list
					else
						new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in GLOB.hairstyles_list
					if(new_hairstyle)
						hairstyle = new_hairstyle

				if("next_hairstyle")
					if (get_pref_data(/datum/preference/gender) == MALE)
						hairstyle = next_list_item(hairstyle, GLOB.hairstyles_male_list)
					else if(get_pref_data(/datum/preference/gender) == FEMALE)
						hairstyle = next_list_item(hairstyle, GLOB.hairstyles_female_list)
					else
						hairstyle = next_list_item(hairstyle, GLOB.hairstyles_list)

				if("previous_hairstyle")
					if (get_pref_data(/datum/preference/gender) == MALE)
						hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_male_list)
					else if(get_pref_data(/datum/preference/gender) == FEMALE)
						hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_female_list)
					else
						hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_list)

*/

// CHARACTER COPY
/*
	character.hairstyle = hairstyle

*/

// SERIALIZATION
/*
	WRITE_FILE(S["hairstyle_name"]				, hairstyle)

*/

// DESERIALIZATION
/*
	READ_FILE(S["hairstyle_name"], hairstyle)
	if(get_pref_data(/datum/preference/gender) == MALE)
		hairstyle								= sanitize_inlist(hairstyle, GLOB.hairstyles_male_list)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_male_list)
	else if(get_pref_data(/datum/preference/gender) == FEMALE)
		hairstyle								= sanitize_inlist(hairstyle, GLOB.hairstyles_female_list)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_female_list)
	else
		hairstyle								= sanitize_inlist(hairstyle, GLOB.hairstyles_list)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_list)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_HAIRSTYLE])
		hairstyle = random_hairstyle(get_pref_data(/datum/preference/gender))
/proc/random_hairstyle(gender)
	switch(gender)
		if(MALE)
			return pick(GLOB.hairstyles_male_list)
		if(FEMALE)
			return pick(GLOB.hairstyles_female_list)
		else
			return pick(GLOB.hairstyles_list)

*/


// CORRESPONDING VARIABLE NAME:
// facial_hairstyle
// default value: "Shaved"
/datum/preference/choiced_string/facial_hairstyle
	name = "Facial Hairstyle"
	external_key = "facial_hairstyle"

	default_value = /datum/sprite_accessory/facial_hair/shaved::name
	dependencies = list(/datum/preference/species)
	rand_dependencies = list(/datum/preference/choiced_string/gender)

/datum/preference/choiced_string/facial_hairstyle/get_options_list()
	return GLOB.facial_hairstyles_list

/datum/preference/choiced_string/facial_hairstyle/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	if(FACEHAIR in chosen_species.species_traits)
		return TRUE
	return FALSE

/datum/preference/choiced_string/facial_hairstyle/apply_to_human(mob/living/carbon/human/target, data)
	target.facial_hairstyle = data

datum/preference/choiced_string/facial_hairstyle/randomize(list/dependency_data, list/rand_dependency_data)
	var/char_gender = rand_dependency_data[/datum/preference/choiced_string/gender]
	// lots of men are clean-shaven, you know -- hence the prob(50)
	if(char_gender == MALE && prob(50))
		return /datum/sprite_accessory/facial_hair/shaved::name
	// otherwise, fall back to this (which will return shaved anyway for non-males)
	return random_facial_hairstyle(char_gender)


// UI CREATION
/*
				dat += "<BR><h3>Facial Hairstyle</h3>"

				dat += "<a href='?_src_=prefs;preference=facial_hairstyle;task=input'>[facial_hairstyle]</a>"
				dat += "<a href='?_src_=prefs;preference=previous_facehairstyle;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_facehairstyle;task=input'>&gt;</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_FACIAL_HAIRSTYLE]'>[(randomise[RANDOM_FACIAL_HAIRSTYLE]) ? "Lock" : "Unlock"]</A>"


*/

// UI INTERACTION
/*
				if("facial_hairstyle")
					var/new_facial_hairstyle
					if(get_pref_data(/datum/preference/gender) == MALE)
						new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_male_list
					else if(get_pref_data(/datum/preference/gender) == FEMALE)
						new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_female_list
					else
						new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_list
					if(new_facial_hairstyle)
						facial_hairstyle = new_facial_hairstyle

				if("next_facehairstyle")
					if (get_pref_data(/datum/preference/gender) == MALE)
						facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_male_list)
					else if(get_pref_data(/datum/preference/gender) == FEMALE)
						facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_female_list)
					else
						facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

				if("previous_facehairstyle")
					if (get_pref_data(/datum/preference/gender) == MALE)
						facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_male_list)
					else if (get_pref_data(/datum/preference/gender) == FEMALE)
						facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_female_list)
					else
						facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

*/

// CHARACTER COPY
/*
	character.facial_hairstyle = facial_hairstyle

*/

// SERIALIZATION
/*
	WRITE_FILE(S["facial_style_name"]			, facial_hairstyle)
*/

// DESERIALIZATION
/*
	READ_FILE(S["facial_style_name"], facial_hairstyle)
	if(get_pref_data(/datum/preference/gender) == MALE)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_male_list)
	else if(get_pref_data(/datum/preference/gender) == FEMALE)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_female_list)
	else
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_list)
	WRITE_FILE(S["facial_style_name"]			, facial_hairstyle)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_FACIAL_HAIRSTYLE])
		facial_hairstyle = random_facial_hairstyle(get_pref_data(/datum/preference/gender))
/proc/random_facial_hairstyle(gender)
	switch(gender)
		if(MALE)
			return pick(GLOB.facial_hairstyles_male_list)
		if(FEMALE)
			return pick(GLOB.facial_hairstyles_female_list)
		else
			return pick(GLOB.facial_hairstyles_list)

*/


// CORRESPONDING VARIABLE NAME:
// features[FEATURE_GRADIENT_STYLE] ( "grad_style" )
// default value: "None"
/datum/preference/choiced_string/hair_gradient_style
	name = "Hair Gradient"
	external_key = "hair_gradient_style"

	default_value = /datum/sprite_accessory/hair_gradient/none::name
	dependencies = list(/datum/preference/hairstyle)

/datum/preference/choiced_string/hair_gradient_style/get_options_list()
	return GLOB.hair_gradients_list

/datum/preference/choiced_string/hair_gradient_style/_is_available(list/dependency_data)
	// available if hairstyle is, but not otherwise. note that hair color has a bit more complex behavior.
	// that's because certain accessories, such as horns, can be affected by hair color, but those same accessories aren't affected by the gradient.
	return TRUE

/datum/preference/choiced_string/hair_gradient_style/apply_to_human(mob/living/carbon/human/target, data)
	target.grad_style = data

/datum/preference/choiced_string/hair_gradient_style/randomize(list/dependency_data, list/rand_dependency_data)
	// most people don't bother.
	if(prob(5))
		return ..()
	return /datum/sprite_accessory/hair_gradient/none::name


// UI CREATION
/*
				dat += "<h3>Hair Gradient</h3>"

				dat += "<a href='?_src_=prefs;preference=hair_gradient_style;task=input'>[features["grad_style"]]</a>"

				dat += "<a href='?_src_=prefs;preference=previous_hair_gradient_style;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_hair_gradient_style;task=input'>&gt;</a><BR>"

*/

// UI INTERACTION
/*
				if("hair_gradient_style")
					var/new_gradient_style
					new_gradient_style = input(user, "Choose your character's hair gradient style:", "Character Preference")  as null|anything in GLOB.hair_gradients_list
					if(new_gradient_style)
						features["grad_style"] = new_gradient_style

				if("next_hair_gradient_style")
					features["grad_style"] = next_list_item(features["grad_style"], GLOB.hair_gradients_list)

				if("previous_hair_gradient_style")
					features["grad_style"] = previous_list_item(features["grad_style"], GLOB.hair_gradients_list)

*/

// CHARACTER COPY
/*
	character.grad_style = features["grad_style"]

*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_grad_style"]			, features["grad_style"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_grad_style"], features[FEATURE_GRADIENT_STYLE])
	features["grad_style"]				= sanitize_inlist(features["grad_style"], GLOB.hair_gradients_list)

*/

// RANDOMIZATION
/*
 none apparently!
*/


// CORRESPONDING VARIABLE NAME:
// hair color
// default value: "000"
/datum/preference/color/hair_color
	name = "Hair Color"
	external_key = "hair_color"

	default_value = "202020"

	// turns out it controls horns color too, and kepori feathers, and IPC antennae, and certain types of human tails / ears.
	// accordingly, we can just depend on those to determine if we're available instead of duplicating all of their availability checks.
	dependencies = list(
		/datum/preference/choiced_string/hairstyle,
		/datum/preference/mutant_bodypart/kepori_feathers,
		/datum/preference/mutant_bodypart/ipc_antenna
	)
	#warn add human tails / human ears / horns to the above

/datum/preference/color/hair_color/_is_available(list/dependency_data)
	// always available if at least one of our dependencies is.
	return TRUE

/datum/preference/color/hair_color/apply_to_human(mob/living/carbon/human/target, data)
	target.hair_color = data

/datum/preference/hair_color/randomize(list/dependency_data, list/rand_dependency_data)
	// if you have actual hair, and you're not one of the hallowed 5%, you have a "natural" hair color.
	if(/datum/preference/choiced_string/hairstyle in dependency_data && prob(95))
		return random_color_natural() // this one already doesn't come with a leading # sign
	else
		// otherwise we get wacky with it.
		return ..()


// UI CREATION
/*
			if(HAIR in current_species.species_traits)
				dat += "<br><span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hair;task=input'>Change</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HAIR_COLOR]'>[(randomise[RANDOM_HAIR_COLOR]) ? "Lock" : "Unlock"]</A>"

	dat += "<span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hair;task=input'>Change</a><BR>"

*/

// UI INTERACTION
/*
				if("hair")
					var/new_hair = input(user, "Choose your character's hair colour:", "Character Preference","#"+hair_color) as color|null
					if(new_hair)
						hair_color = sanitize_hexcolor(new_hair)

*/

// CHARACTER COPY
/*
	character.hair_color = hair_color

*/

// SERIALIZATION
/*
	WRITE_FILE(S["hair_color"]					, hair_color)

*/

// DESERIALIZATION
/*
	READ_FILE(S["hair_color"], hair_color)
	hair_color			= sanitize_hexcolor(hair_color)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_HAIR_COLOR])
		hair_color = random_color_natural()

/proc/random_color_natural()	//For use in natural haircolors.
	var/red = num2text(rand(0,255), 2, 16)
	var/green = num2text(rand(0,128), 2, 16)	//Conversion to hex
	var/blue = "00"

	return red + green + blue

*/


// CORRESPONDING VARIABLE NAME:
// facial_hair_color
// default value: "000"
/datum/preference/color/facial_hair_color
	name = "Facial Hair Color"
	external_key = "facial_hair_color"

	default_value = "202020"
	// unlike normal hair color, no other accessories depend on facial hair color, so we don't need to add a bunch to this list.
	dependencies = list(/datum/preference/choiced_string/facial_hairstyle)

	rand_dependencies = list(/datum/preference/color/hair_color)

/datum/preference/color/facial_hair_color/_is_available(list/dependency_data)
	// just need for facial hair to be available
	return TRUE

/datum/preference/color/facial_hair_color/apply_to_human(mob/living/carbon/human/target, data)
	target.facial_hair_color = data

/datum/preference/color/facial_hair_color/randomize(list/dependency_data, list/rand_dependency_data)
	// 90% chance that it's just the same as the hair color, but we need to check if they even HAVE a hair color first
	if(/datum/preference/color/hair_color in rand_dependency_data)
		if(prob(90))
			return rand_dependency_data[/datum/preference/color/hair_color]
		else if(prob(50)) // 5% (absolute) chance that it's a separate, but natural hair color
			return random_color_natural()
	else
		if(prob(95))
			return random_color_natural()
	return ..() // if all else fails, get wacky with it





// UI CREATION
/*
				dat += "<br><span style='border: 1px solid #161616; background-color: #[facial_hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=facial;task=input'>Change</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_FACIAL_HAIR_COLOR]'>[(randomise[RANDOM_FACIAL_HAIR_COLOR]) ? "Lock" : "Unlock"]</A>"

*/

// UI INTERACTION
/*
				if("facial")
					var/new_facial = input(user, "Choose your character's facial-hair colour:", "Character Preference","#"+facial_hair_color) as color|null
					if(new_facial)
						facial_hair_color = sanitize_hexcolor(new_facial)

*/

// CHARACTER COPY
/*
	character.facial_hair_color = facial_hair_color

*/

// SERIALIZATION
/*
	WRITE_FILE(S["facial_hair_color"]			, facial_hair_color)

*/

// DESERIALIZATION
/*
	READ_FILE(S["facial_hair_color"], facial_hair_color)
	facial_hair_color	= sanitize_hexcolor(facial_hair_color)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_FACIAL_HAIR_COLOR])
		facial_hair_color = random_color_natural()

*/



// CORRESPONDING VARIABLE NAME:
// features[FEATURE_GRADIENT_COLOR] ("grad_color")
// default value: "FFF"
/datum/preference/color/hair_gradient_color
	name = "Hair Gradient Color"
	external_key = "hair_gradient_color"

	// gradients are already anime bullshit. and what's more "anime bullshit" than hair with snow-white tips?
	default_value = "FFFFFF"

	dependencies = list(/datum/preference/choiced_string/hair_gradient_style)

/datum/preference/color/hair_gradient_color/_is_available(list/dependency_data)
	return TRUE

/datum/preference/color/hair_gradient_color/apply_to_human(mob/living/carbon/human/target, data)
	target.grad_color = data


// UI CREATION
/*
				dat += "<span style='border:1px solid #161616; background-color: #[features["grad_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hair_gradient;task=input'>Change</a>"

*/

// UI INTERACTION
/*
				if("hair_gradient")
					var/new_hair_gradient_color = input(user, "Choose your character's hair gradient colour:", "Character Preference","#"+features["grad_color"]) as color|null
					if(new_hair_gradient_color)
						features["grad_color"] = sanitize_hexcolor(new_hair_gradient_color)

*/

// CHARACTER COPY
/*
	character.grad_color = features["grad_color"]

*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_grad_color"]			, features["grad_color"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_grad_color"], features[FEATURE_GRADIENT_COLOR])
	features["grad_color"]				= sanitize_hexcolor(features["grad_color"])

*/

// RANDOMIZATION
/*
 also apparently none!
*/
