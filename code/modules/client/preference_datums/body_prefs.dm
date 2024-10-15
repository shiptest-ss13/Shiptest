#warn mutant colors go here, and skintone, and eyes, and limbs, and fbp, and... species, maybe.


// CORRESPONDING VARIABLE NAME:
// skin_tone
// default value: "caucasian1"
/datum/preference/choiced_string/skin_tone
	name = "Skin Tone"
	external_key = "skin_tone"

	default_value = "caucasian1"
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/choiced_string/skin_tone/get_options_list()
	return GLOB.skin_tones

/datum/preference/choiced_string/skin_tone/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	if(SKINCOLORS in chosen_species.species_traits)
		return TRUE
	return FALSE

/datum/preference/choiced_string/skin_tone/apply_to_human(mob/living/carbon/human/target, data)
	target.skin_tone = data

/datum/preference/choiced_string/skin_tone/randomize(list/dependency_data, list/rand_dependency_data)
	#warn another worthless randomization proc that should be removed in time
	return random_skin_tone()

// UI CREATION
/*
			if(current_species.use_skintones)

				dat += "<h3>Skin Tone</h3>"

				dat += "<a href='?_src_=prefs;preference=s_tone;task=input'>[skin_tone]</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SKIN_TONE]'>[(randomise[RANDOM_SKIN_TONE]) ? "Lock" : "Unlock"]</A>"
				dat += "<br>"

*/

// UI INTERACTION
/*
				if("s_tone")
					var/new_s_tone = input(user, "Choose your character's skin-tone:", "Character Preference")  as null|anything in GLOB.skin_tones
					if(new_s_tone)
						skin_tone = new_s_tone


*/

// CHARACTER COPY
/*
	character.skin_tone = skin_tone

*/

// SERIALIZATION
/*
	WRITE_FILE(S["skin_tone"]					, skin_tone)

*/

// DESERIALIZATION
/*
	READ_FILE(S["skin_tone"], skin_tone)
	skin_tone			= sanitize_inlist(skin_tone, GLOB.skin_tones)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_SKIN_TONE])
		skin_tone = random_skin_tone()
/proc/random_skin_tone()
	return pick(GLOB.skin_tones)


*/


#warn needs to show up for IPC screens as well, actually... ooogh ! oooootough!
// CORRESPONDING VARIABLE NAME:
// eye_color
// default value: "000"
/datum/preference/color/eye_color
	name = "Eye Color"
	external_key = "eye_color"

	default_value = "000000"
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/color/eye_color/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	if((EYECOLOR in chosen_species.species_traits) && !(NOEYESPRITES in chosen_species.species_traits))
		return TRUE
	return FALSE

#warn should figure out where this sits in the application hierarchy, since this might well not penetrate to the organ level if it's set after species, as organ_eyes.eye_color is set unreliably.
#warn currently, eye color doesn't appear until you change tabs, and changing your gender to or from male will hide your eye color until a different preference is changed.
#warn quite strange !!!!
/datum/preference/color/eye_color/apply_to_human(mob/living/carbon/human/target, data)
	target.eye_color = data
	var/obj/item/organ/eyes/organ_eyes = target.getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		if(!initial(organ_eyes.eye_color))
			organ_eyes.eye_color = data
		organ_eyes.old_eye_color = data

/datum/preference/color/eye_color/randomize(list/dependency_data, list/rand_dependency_data)
	// finally, a special randomization proc with meaningful behavior
	return random_eye_color()

// UI CREATION
/*
			if((EYECOLOR in current_species.species_traits) && !(NOEYESPRITES in current_species.species_traits))

				dat += "<h3>Eye Color</h3>"
				dat += "<span style='border: 1px solid #161616; background-color: #[eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=eyes;task=input'>Change</a>"
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_EYE_COLOR]'>[(randomise[RANDOM_EYE_COLOR]) ? "Lock" : "Unlock"]</A>"

				dat += "<br></td>"


*/

// UI INTERACTION
/*
				if("eyes")
					var/new_eyes = input(user, "Choose your character's eye colour:", "Character Preference","#"+eye_color) as color|null
					if(new_eyes)
						eye_color = sanitize_hexcolor(new_eyes)


*/

// CHARACTER COPY
/*
	character.eye_color = eye_color
	var/obj/item/organ/eyes/organ_eyes = character.getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		if(!initial(organ_eyes.eye_color))
			organ_eyes.eye_color = eye_color
		organ_eyes.old_eye_color = eye_color

*/

// SERIALIZATION
/*
	WRITE_FILE(S["eye_color"]					, eye_color)

*/

// DESERIALIZATION
/*
	READ_FILE(S["eye_color"], eye_color)
	eye_color			= sanitize_hexcolor(eye_color)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_EYE_COLOR])
		eye_color = random_eye_color()

*/


#warn another pref with fairly important application priority. i'm told IPCs are buggy, for some reason...
#warn this whole thing needs to be redone, really. semi-downside of this system is that list based data is a total fucking pain in the ass to work around
// CORRESPONDING VARIABLE NAME:
// prosthetic_limbs
// default value: list(BODY_ZONE_L_ARM = PROSTHETIC_NORMAL, BODY_ZONE_R_ARM = PROSTHETIC_NORMAL, BODY_ZONE_L_LEG = PROSTHETIC_NORMAL, BODY_ZONE_R_LEG = PROSTHETIC_NORMAL)
/datum/preference/prosthetic_limbs
	name = "Prosthetic Limbs"
	external_key = "prosthetic_limbs"

	// needs to happen after finalization so we can lop the limbs off correctly
	application_priority = PREF_APPLICATION_PRIORITY_SPECIES_FINALIZE - 1

	default_value = list(BODY_ZONE_L_ARM = PROSTHETIC_NORMAL, BODY_ZONE_R_ARM = PROSTHETIC_NORMAL, BODY_ZONE_L_LEG = PROSTHETIC_NORMAL, BODY_ZONE_R_LEG = PROSTHETIC_NORMAL)
	dependencies = list(/datum/preference/bool/fbp)

	randomization_flags = NONE

/datum/preference/prosthetic_limbs/_is_available(list/dependency_data)
	if(dependency_data[/datum/preference/bool/fbp])
		return FALSE
	return TRUE

/datum/preference/prosthetic_limbs/_is_invalid(data, list/dependency_data)
	if(!islist(data))
		return "[data] is not a list!"
	if(length(data & default_value) != length(default_value))
		return "Prosthetic limbs list has missing, extra, or extraneous entries!"
	var/list/data_list
	for(var/zone in data_list)
		var/val = data_list[zone]
		if(val != PROSTHETIC_NORMAL && val != PROSTHETIC_AMPUTATED && val != PROSTHETIC_ROBOTIC)
			return "Prosthetic limbs list contains erroneous [zone] entry, [val]!"
	return FALSE

/datum/preference/prosthetic_limbs/apply_to_human(mob/living/carbon/human/target, data)
	var/list/data_list = data
	if(data == default_value)
		return

	for(var/pros_limb in data_list)
		var/obj/item/bodypart/old_part = target.get_bodypart(pros_limb)
		switch(data_list[pros_limb])
			if(PROSTHETIC_NORMAL)
				continue
			if(PROSTHETIC_AMPUTATED)
				if(old_part)
					old_part.drop_limb(TRUE)
					qdel(old_part)
			if(PROSTHETIC_ROBOTIC)
				if(old_part)
					old_part.drop_limb(TRUE)
					qdel(old_part)
				target.regenerate_limb(pros_limb, robotic = TRUE)

#warn dumb and bad and non-string. not fucking worrying about it right now
/datum/preference/prosthetic_limbs/_serialize(data)
	return data

/datum/preference/prosthetic_limbs/deserialize(serialized_data)
	return serialized_data

/datum/preference/prosthetic_limbs/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	var/list/old_list = old_data
	var/selected_zone = input(user, "Select a limb zone to modify:", "Character Preference") as null|anything in default_value
	if(!selected_zone)
		return old_data

	var/selected_option = input(
		user,
		"You are modifying your [parse_zone(selected_zone)], what should it be changed to?",
		"Character Preference", old_list[selected_zone]
	) as null|anything in list(PROSTHETIC_NORMAL, PROSTHETIC_ROBOTIC, PROSTHETIC_AMPUTATED)
	if(!selected_option || selected_option == old_list[selected_zone])
		return old_data

	var/list/new_list = old_list.Copy()
	new_list[selected_zone] = selected_option
	return new_list

/datum/preference/prosthetic_limbs/randomize(list/dependency_data, list/rand_dependency_data)
	// no randomization. sorry
	return default_value


// UI CREATION
/*
			if(!fbp)
				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_PROSTHETIC]'>Random Prosthetic: [(randomise[RANDOM_PROSTHETIC]) ? "Yes" : "No"]</a><br>"

				dat += "<table>"
				for(var/index in prosthetic_limbs)
					var/bodypart_name = parse_zone(index)
					dat += "<tr><td><b>[bodypart_name]:</b></td>"
					dat += "<td><a href='?_src_=prefs;preference=limbs;customize_limb=[index]'>[prosthetic_limbs[index]]</a></td></tr>"
				dat += "</table><br>"


*/

// UI INTERACTION
/*
				if("limbs")
					if(href_list["customize_limb"])
						var/limb = href_list["customize_limb"]
						var/status = input(user, "You are modifying your [parse_zone(limb)], what should it be changed to?", "Character Preference", prosthetic_limbs[limb]) as null|anything in list(PROSTHETIC_NORMAL,PROSTHETIC_ROBOTIC,PROSTHETIC_AMPUTATED)
						if(status)
							prosthetic_limbs[limb] = status

*/

// CHARACTER COPY
/*
	if(!fbp)
		for(var/pros_limb in prosthetic_limbs)
			var/obj/item/bodypart/old_part = character.get_bodypart(pros_limb)
			if(old_part)
				icon_updates = TRUE
			switch(prosthetic_limbs[pros_limb])
				if(PROSTHETIC_NORMAL)
					if(old_part)
						old_part.drop_limb(TRUE)
						qdel(old_part)
					character.regenerate_limb(pros_limb)
				if(PROSTHETIC_AMPUTATED)
					if(old_part)
						old_part.drop_limb(TRUE)
						qdel(old_part)
				if(PROSTHETIC_ROBOTIC)
					if(old_part)
						old_part.drop_limb(TRUE)
						qdel(old_part)
					character.regenerate_limb(pros_limb, robotic = TRUE)


*/

// SERIALIZATION
/*
	WRITE_FILE(S["prosthetic_limbs"]			, prosthetic_limbs)

*/

// DESERIALIZATION
/*
	READ_FILE(S["prosthetic_limbs"], prosthetic_limbs)
	prosthetic_limbs ||= list(BODY_ZONE_L_ARM = PROSTHETIC_NORMAL, BODY_ZONE_R_ARM = PROSTHETIC_NORMAL, BODY_ZONE_L_LEG = PROSTHETIC_NORMAL, BODY_ZONE_R_LEG = PROSTHETIC_NORMAL)

*/

// RANDOMIZATION
/*
	if(randomise[RANDOM_PROSTHETIC] && !character_setup)
		prosthetic_limbs = random_prosthetic()

/proc/random_prosthetic()
	. = list(BODY_ZONE_L_ARM = PROSTHETIC_NORMAL, BODY_ZONE_R_ARM = PROSTHETIC_NORMAL, BODY_ZONE_L_LEG = PROSTHETIC_NORMAL, BODY_ZONE_R_LEG = PROSTHETIC_NORMAL)
	.[pick(.)] = PROSTHETIC_ROBOTIC

*/


// CORRESPONDING VARIABLE NAME:
// fbp
// default value: FALSE
/datum/preference/bool/fbp
	name = "Full-Body Positronic"
	external_key = "is_fbp"

	default_value = FALSE
	dependencies = list(/datum/preference/species)

	randomization_flags = NONE // not for now.

/datum/preference/bool/fbp/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	if(istype(chosen_species, /datum/species/ipc))
		// no FBP IPCs. what the fuck would that even mean?
		return FALSE
	return TRUE

/datum/preference/bool/fbp/apply_to_human(mob/living/carbon/human/target, data)
	// kind of an evil way of doing it, but oh well!
	target.fbp = data

/datum/preference/bool/fbp/randomize(list/dependency_data, list/rand_dependency_data)
	return FALSE

// UI CREATION
/*
			dat += "<h3>Prosthetic Limbs</h3>"
			dat += "<a href='?_src_=prefs;preference=fbp'>Full Body Prosthesis: [fbp ? "Yes" : "No"]</a><br>"

*/

// UI INTERACTION
/*
				if("fbp")
					fbp = !fbp
*/

// CHARACTER COPY
/*
	character.fbp = fbp
*/

// SERIALIZATION
/*
	WRITE_FILE(S["fbp"]							, fbp)
*/

// DESERIALIZATION
/*
	READ_FILE(S["fbp"], fbp)

	fbp					= sanitize_integer(fbp, FALSE, TRUE, FALSE)
*/

// RANDOMIZATION
/*
	none!
*/

// CORRESPONDING VARIABLE NAME:
// features[FEATURE_MUTANT_COLOR] ("mcolor")
// default value: "FFF"
/datum/preference/color/mutant_color
	name = "Mutant Color"
	external_key = "mutant_color"

	default_value = "FFFFFF"
	min_hsv_value = 9
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/color/mutant_color/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	// so, elzu technically use this variable to override how their limbs appear
	// without having to constantly change their DNA as they take damage.
	// however, that's only happening when the species datum is attached to a human,
	// which isn't the case for the species datum that we use as data.
	// thus elzu will always get the mutant color option.
	if(chosen_species.fixed_mut_color)
		return FALSE
	return TRUE

/datum/preference/color/mutant_color/_is_invalid(data, list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	// kind-of-evil way of giving elzu a different minimum brightness
	if(istype(chosen_species, /datum/species/elzuose) && istext(data))
		if(!color_has_min_value(data, 31))
			return "[data] is not bright enough! Brightness (via HSV) should be at least 31!"
	return ..()

/datum/preference/color/mutant_color/apply_to_human(mob/living/carbon/human/target, data)
	target.dna.features[FEATURE_MUTANT_COLOR] = data

// for now, using the default randomize is fine.

// UI CREATION
/*
			dat += "<h3>Mutant Colors</h3>"

			dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color;task=input'>Change</a><BR>"
			dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color_2;task=input'>Change</a><BR>"


*/

// UI INTERACTION
/*
				if("mutant_color")
					var/new_mutantcolor = input(user, "Choose your character's primary alien/mutant color:", "Character Preference","#" + features["mcolor"]) as color|null
					if(new_mutantcolor)
						var/temp_hsv = RGBtoHSV(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor"] = chosen_species.default_color
						else if((MUTCOLORS_PARTSONLY in chosen_species.species_traits) || ReadHSV(temp_hsv)[3] >= ReadHSV("#191919")[3]) // mutantcolors must be bright, but only if they affect the skin
							features["mcolor"] = sanitize_hexcolor(new_mutantcolor)
						else
							to_chat(user, "<span class='danger'>Invalid color. Your color is not bright enough.</span>")

*/

// CHARACTER COPY
/*
	feature
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_mcolor"]				, features["mcolor"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_mcolor"], features[FEATURE_MUTANT_COLOR])
	if(!features[FEATURE_MUTANT_COLOR] || text2num(features[FEATURE_MUTANT_COLOR], 16) == 0)
		features[FEATURE_MUTANT_COLOR] = random_color()
	features["mcolor"]					= sanitize_hexcolor(features["mcolor"])

*/

// RANDOMIZATION
/*

*/


// CORRESPONDING VARIABLE NAME:
// features[FEATURE_MUTANT_COLOR2] ("mcolor2")
// default value: "FFF"
/datum/preference/color/mutant_color_2
	name = "Mutant Color 2"
	external_key = "mutant_color_2"

	default_value = "FFFFFF"
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/color/mutant_color_2/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	// see the primary mutant color pref for info on elzu
	if(chosen_species.fixed_mut_color)
		return FALSE
	return TRUE

// validity doesn't really matter even though elzu should have a higher
// minimum brightness, because this pref is basically unused for elzu

/datum/preference/color/mutant_color_2/apply_to_human(mob/living/carbon/human/target, data)
	target.dna.features[FEATURE_MUTANT_COLOR2] = data

// UI CREATION
/*
			dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color_2;task=input'>Change</a><BR>"

*/

// UI INTERACTION
/*
				if("mutant_color_2")
					var/new_mutantcolor = input(user, "Choose your character's secondary alien/mutant color:", "Character Preference","#" + features["mcolor2"]) as color|null
					if(new_mutantcolor)
						var/temp_hsv = RGBtoHSV(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor2"] = chosen_species.default_color
						else if((MUTCOLORS_PARTSONLY in chosen_species.species_traits) || ReadHSV(temp_hsv)[3] >= ReadHSV("#191919")[3]) // mutantcolors must be bright, but only if they affect the skin
							features["mcolor2"] = sanitize_hexcolor(new_mutantcolor)
						else
							to_chat(user, "<span class='danger'>Invalid color. Your color is not bright enough.</span>")

*/

// CHARACTER COPY
/*
	feature
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_mcolor2"]				, features["mcolor2"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_mcolor2"], features[FEATURE_MUTANT_COLOR2])
	features["mcolor2"]					= sanitize_hexcolor(features["mcolor2"])

*/

// RANDOMIZATION
/*

*/


// CORRESPONDING VARIABLE NAME:
// features[FEATURE_FLAVOR_TEXT] ("flavor_text")
// default value: ""
/datum/preference/flavor_text
	name = "Flavor Text"
	external_key = "flavor_text"

	default_value = ""
	randomization_flags = NONE // doesn't really make sense to randomize this ever

/datum/preference/flavor_text/_is_available(list/dependency_data)
	return TRUE

/datum/preference/flavor_text/_is_invalid(data, list/dependency_data)
	#warn impl. make sure shit gets sanitized well!!!

/datum/preference/flavor_text/apply_to_human(mob/living/carbon/human/target, data)
	target.flavor_text = data
	// gotta add it to their DNA too.
	target.dna.features[FEATURE_FLAVOR_TEXT] = data

/datum/preference/flavor_text/_serialize(data)
	return data

/datum/preference/flavor_text/deserialize(serialized_data)
	return serialized_data

/datum/preference/flavor_text/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	#warn impl

// 	var/msg =
// 	sanitize(
// 		stripped_multiline_input(
// 			usr,
// 			"Set the flavor text in your 'examine' verb."
// 			"Flavor Text",
// 			features["flavor_text"],
// 			4096,
// 			TRUE
// 		)
// 	)
// 	if(msg) //WS edit - "Cancel" does not clear flavor text
// 		features["flavor_text"] = html_decode(msg)

// /mob/proc/update_flavor_text()
// 	set name = "Update Flavor Text"
// 	set category = "IC"
// 	set src in usr

// 	if(usr != src)
// 		to_chat(usr, span_warning("You can't set someone else's flavour text!"))
// 	var/msg = sanitize(input(usr,"Set the flavor text in your 'examine' verb. Can also be used for OOC notes about your character.","Flavor Text",html_decode(flavor_text)) as message|null)

// 	if(msg)
// 		msg = copytext(msg, 1, MAX_MESSAGE_LEN)
// 		msg = html_encode(msg)

// 		flavor_text = msg

// /mob/proc/print_flavor_text()
// 	if(flavor_text && flavor_text != "")
// 		var/msg = replacetext(flavor_text, "\n", " ")
// 		if(length(msg) <= 100)
// 			return "<span class='notice'>[msg]</span>"
// 		else
// 			return "<span class='notice'>[copytext(msg, 1, 97)]... <a href=\"byond://?src=[text_ref(src)];flavor_more=1\">More...</span></a>"



// UI CREATION
/*
			dat += "<br><a href='?_src_=prefs;preference=flavor_text;task=input'><b>Set Flavor Text</b></a>"
			if(length(features["flavor_text"]) <= 40)
				if(!length(features["flavor_text"]))
					dat += "\[...\]"
				else
					dat += "[features["flavor_text"]]"
			else
				dat += "[copytext_char(features["flavor_text"], 1, 37)]...<BR>"


*/

// UI INTERACTION
/*
				if("flavor_text")
					var/msg = sanitize(stripped_multiline_input(usr, "Set the flavor text in your 'examine' verb. This can also be used for OOC notes and preferences!", "Flavor Text", features["flavor_text"], 4096, TRUE))
					if(msg) //WS edit - "Cancel" does not clear flavor text
						features["flavor_text"] = html_decode(msg)

*/

// CHARACTER COPY
/*
	feature
	sure. fuck it. fine. wait, is it seriouslya fucking variable THEN WHY IS IT A FUCKING FEATURE oh my GOD
	character.flavor_text = features["flavor_text"] //Let's update their flavor_text at least initially
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_flavor_text"]			, features["flavor_text"])

*/

// DESERIALIZATION
/*
	S["feature_flavor_text"]		>> features[FEATURE_FLAVOR_TEXT]
	features["flavor_text"]				= sanitize_text(features["flavor_text"], initial(features["flavor_text"]))

*/

// RANDOMIZATION
/*
	not randomized obviously
*/


// CORRESPONDING VARIABLE NAME:
// features[FEATURE_BODY_SIZE] ("body_size")
// default value: "Normal" (BODY_SIZE_NORMAL)
/datum/preference/choiced_string/body_size
	name = "Body Size"
	external_key = "body_size"

	default_value = BODY_SIZE_NORMAL
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/choiced_string/body_size/get_options_list()
	return GLOB.body_sizes

/datum/preference/choiced_string/body_size/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	if(FEATURE_BODY_SIZE in chosen_species.default_features)
		return TRUE
	return FALSE

/datum/preference/choiced_string/body_size/apply_to_human(mob/living/carbon/human/target, data)
	target.dna.features[FEATURE_BODY_SIZE] = data
	target.dna.update_body_size()

/datum/preference/choiced_string/body_size/randomize(list/dependency_data, list/rand_dependency_data)
	return BODY_SIZE_NORMAL // other sprites look a bit weird honestly.

// UI CREATION
/*
			if("body_size" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Size</h3>"

				dat += "<a href='?_src_=prefs;preference=body_size;task=input'>[features["body_size"]]</a><BR>"


				// dat += "<h3>Character Adjective</h3>"

				// dat += "<a href='?_src_=prefs;preference=generic_adjective;task=input'>[generic_adjective]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0


*/

// UI INTERACTION
/*
				if("body_size")
					var/new_size = input(user, "Choose your character's height:", "Character Preference") as null|anything in GLOB.body_sizes
					if(new_size)
						features["body_size"] = new_size

*/

// CHARACTER COPY
/*
	feature
	character.dna.update_body_size()

*/

// SERIALIZATION
/*
	WRITE_FILE(S["body_size"]					, features["body_size"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["body_size"], features[FEATURE_BODY_SIZE])
	features["body_size"]				= sanitize_inlist(features["body_size"], GLOB.body_sizes, "Normal")

*/

// RANDOMIZATION
/*
	?? not sure
*/


// CORRESPONDING VARIABLE NAME:
// features[FEATURE_LEGS_TYPE]
// default value: FEATURE_NORMAL_LEGS
/datum/preference/bool/digitigrade
	name = "Digitigrade"
	external_key = "digitigrade"

	default_value = FALSE
	dependencies = list(/datum/preference/species)

	randomization_flags = PREF_RAND_FLAG_APPEARANCE

/datum/preference/bool/digitigrade/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	if(chosen_species.digitigrade_customization == DIGITIGRADE_OPTIONAL)
		return TRUE
	return FALSE

/datum/preference/bool/digitigrade/apply_to_human(mob/living/carbon/human/target, data)
	if(data)
		target.dna.features[FEATURE_LEGS_TYPE] = FEATURE_DIGITIGRADE_LEGS
	else
		target.dna.features[FEATURE_LEGS_TYPE] = FEATURE_NORMAL_LEGS

/datum/preference/bool/digitigrade/randomize(list/dependency_data, list/rand_dependency_data)
	// idk. 70% of lizards are digitigrade. sure
	return prob(70)

// UI CREATION
/*
			if("legs" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Legs</h3>"

				dat += "<a href='?_src_=prefs;preference=legs;task=input'>[features["legs"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0


*/

// UI INTERACTION
/*
				if("legs")
					var/new_legs
					new_legs = input(user, "Choose your character's legs:", "Character Preference") as null|anything in GLOB.legs_list
					if(new_legs)
						features["legs"] = new_legs

*/

// CHARACTER COPY
/*
	feature
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_lizard_legs"]			, features["legs"])

*/

// DESERIALIZATION
/*
	features["feature_lizard_legs"]		= sanitize_inlist(features["legs"], GLOB.legs_list, FEATURE_NORMAL_LEGS)
	READ_FILE(S["feature_lizard_legs"], features[FEATURE_LEGS_TYPE])

*/

// RANDOMIZATION
/*

*/


#warn ethereal color: remove due to redundancy
/*
// CORRESPONDING VARIABLE NAME:
// features[FEATURE_ETHEREAL_COLOR]
// default value: "9c3030"
/datum/preference/
	// abstract_type = /datum/preference

	// name =

	// external_key =
	// application_priority = PREF_APPLICATION_PRIORITY_SPECIES_FINALIZE

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
				dat += "<h3>Elzuosa Color</h3>"

				dat += "<span style='border: 1px solid #161616; background-color: #[features[FEATURE_ETHEREAL_COLOR]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=color_ethereal;task=input'>Change</a><BR>"

*/

// UI INTERACTION
/*
				if("color_ethereal")
					var/new_etherealcolor = input(user, "Choose your elzuose color:", "Character Preference","#"+features[FEATURE_ETHEREAL_COLOR]) as color|null
					if(new_etherealcolor)
						var/temp_hsv = RGBtoHSV(new_etherealcolor)
						if(ReadHSV(temp_hsv)[3] >= ReadHSV("#505050")[3]) // elzu colors should be bright
							features[FEATURE_ETHEREAL_COLOR] = sanitize_hexcolor(new_etherealcolor)
						else
							to_chat(user, "<span class='danger'>Invalid color. Your color is not bright enough.</span>")


*/

// CHARACTER COPY
/*
	feature
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_ethcolor"]			, features[FEATURE_ETHEREAL_COLOR])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_ethcolor"], features[FEATURE_ETHEREAL_COLOR])
	if(!features[FEATURE_ETHEREAL_COLOR] || text2num(features[FEATURE_ETHEREAL_COLOR], 16) == 0)
		features[FEATURE_ETHEREAL_COLOR] = GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)]

	features[FEATURE_ETHEREAL_COLOR]				= copytext_char(features[FEATURE_ETHEREAL_COLOR], 1, 7)

*/

// RANDOMIZATION
/*

*/


*/
