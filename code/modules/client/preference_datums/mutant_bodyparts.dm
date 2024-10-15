/datum/preference/choiced_string/mutant_bodypart
	abstract_type = /datum/preference/choiced_string/mutant_bodypart

	dependencies = list(/datum/preference/species)
	randomization_flags = PREF_RAND_FLAG_APPEARANCE

	var/datum/sprite_accessory/mutant_part/mut_part_type
	/// If TRUE, the corresponding mutant part string will be added to the mob's species' mutant_bodyparts list when the preference is applied,
	/// causing the part to appear. If FALSE, this is skipped.
	/// Should only be FALSE if the feature is rendered by an organ, not at all, or by some other unusual method.
	var/make_visible = TRUE

/datum/preference/choiced_string/mutant_bodypart/New(...)
	. = ..()
	#warn unit test? meh. might not be necessary so long as default values are confirmed valid
	if(!(default_value in options_list))
		CRASH("[type] had invalid default value [default_value]!")

/datum/preference/choiced_string/mutant_bodypart/get_options_list()
	return GLOB.mut_part_name_datum_lookup[mut_part_type]

#warn list default_features shouldn't be associative, and should be renamed with its functionality removed
/datum/preference/choiced_string/mutant_bodypart/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	return (mut_part_type::mutant_string in chosen_species.default_features)

/datum/preference/choiced_string/mutant_bodypart/apply_to_human(mob/living/carbon/human/target, data)
	var/part_id = mut_part_type::mutant_string
	target.dna.features[part_id] = data
	if(make_visible)
		target.dna.species.mutant_bodyparts |= part_id


/datum/preference/choiced_string/mutant_bodypart/body_markings
	name = "Body Markings"
	external_key = "feature_lizard_body_markings"

	mut_part_type = /datum/sprite_accessory/mutant_part/body_markings
	default_value = /datum/sprite_accessory/mutant_part/body_markings/none::name

/datum/preference/choiced_string/mutant_bodypart/face_markings
	name = "Face Markings"
	external_key = "feature_lizard_face_markings"

	mut_part_type = /datum/sprite_accessory/mutant_part/face_markings
	default_value = /datum/sprite_accessory/mutant_part/face_markings/none::name

/datum/preference/choiced_string/mutant_bodypart/squid_face
	name = "Squid Face"
	external_key = "feature_squid_face"

	mut_part_type = /datum/sprite_accessory/mutant_part/squid_face
	default_value = /datum/sprite_accessory/mutant_part/squid_face/squidward::name

/datum/preference/choiced_string/mutant_bodypart/spider_legs
	name = "Spider Legs"
	external_key = "feature_spider_legs"

	mut_part_type = /datum/sprite_accessory/mutant_part/spider_legs
	default_value = /datum/sprite_accessory/mutant_part/spider_legs/carapace::name

/datum/preference/choiced_string/mutant_bodypart/spider_spinneret
	name = "Spider Spinneret"
	external_key = "feature_spider_spinneret"

	mut_part_type = /datum/sprite_accessory/mutant_part/spider_spinneret
	default_value = /datum/sprite_accessory/mutant_part/spider_spinneret/spikecore::name

/datum/preference/choiced_string/mutant_bodypart/moth_markings
	name = "Moth Markings"
	external_key = "feature_moth_markings"

	mut_part_type = /datum/sprite_accessory/mutant_part/moth_markings
	default_value = /datum/sprite_accessory/mutant_part/moth_markings/none::name

/datum/preference/choiced_string/mutant_bodypart/moth_fluff
	name = "Moth Fluff"
	external_key = "feature_moth_fluff"

	mut_part_type = /datum/sprite_accessory/mutant_part/moth_fluff
	default_value = /datum/sprite_accessory/mutant_part/moth_fluff/plain::name

/datum/preference/choiced_string/mutant_bodypart/kepori_feathers
	name = "Kepori Feathers"
	external_key = "feature_kepori_feathers"

	mut_part_type = /datum/sprite_accessory/mutant_part/kepori_feathers
	default_value = /datum/sprite_accessory/mutant_part/kepori_feathers/none::name

/datum/preference/choiced_string/mutant_bodypart/kepori_body_feathers
	name = "Kepori Body Feathers"
	external_key = "feature_kepori_body_feathers"

	mut_part_type = /datum/sprite_accessory/mutant_part/kepori_body_feathers
	default_value = /datum/sprite_accessory/mutant_part/kepori_body_feathers/none::name

/datum/preference/choiced_string/mutant_bodypart/kepori_tail_feathers
	name = "Kepori Tail Feathers"
	external_key = "feature_kepori_tail_feathers"

	mut_part_type = /datum/sprite_accessory/mutant_part/kepori_tail_feathers
	default_value = /datum/sprite_accessory/mutant_part/kepori_tail_feathers/fan::name

/datum/preference/choiced_string/mutant_bodypart/vox_head_quills
	name = "Vox Head Quills"
	external_key = "feature_vox_head_quills"

	mut_part_type = /datum/sprite_accessory/mutant_part/vox_head_quills
	default_value = /datum/sprite_accessory/mutant_part/vox_head_quills/none::name

/datum/preference/choiced_string/mutant_bodypart/vox_neck_quills
	name = "Vox Neck Quills"
	external_key = "feature_vox_neck_quills"

	mut_part_type = /datum/sprite_accessory/mutant_part/vox_neck_quills
	default_value = /datum/sprite_accessory/mutant_part/vox_neck_quills/plain::name

/datum/preference/choiced_string/mutant_bodypart/elzu_horns
	name = "Elzu Horns"
	external_key = "feature_elzu_horns"

	mut_part_type = /datum/sprite_accessory/mutant_part/elzu_horns
	default_value = /datum/sprite_accessory/mutant_part/elzu_horns/none::name

/datum/preference/choiced_string/mutant_bodypart/ipc_antenna
	name = "IPC Antennae"
	external_key = "feature_ipc_antenna"

	mut_part_type = /datum/sprite_accessory/mutant_part/ipc_antennas
	default_value = /datum/sprite_accessory/mutant_part/ipc_antennas/none::name

// CORRESPONDING VARIABLE NAME:
// "spines"
// default value: "None"
/datum/preference/choiced_string/mutant_bodypart/spines
	name = "Spines"
	external_key = "feature_spines"

	// unlike other mutant_bodyparts, this one doesn't depend directly on the species, since it's more like a corollary to the tail.
	dependencies = list(/datum/preference/choiced_string/mutant_bodypart/organ_linked/sarathi_tail)
	// we're going to assume that there is a tail organ to handle adding this to mutant_bodyparts.
	// the pref thus can't really stand "on its own", but that's fine
	make_visible = FALSE

	mut_part_type = /datum/sprite_accessory/mutant_part/spines
	default_value = /datum/sprite_accessory/mutant_part/spines/none::name

/datum/preference/choiced_string/mutant_bodypart/spines/_is_available(list/dependency_data)
	if(!(/datum/preference/choiced_string/mutant_bodypart/organ_linked/sarathi_tail in dependency_data))
		return FALSE
	// if we have a large or small tail (both of which are shaped such that spines don't line up), we aren't available.
	var/tail_data = dependency_data[/datum/preference/choiced_string/mutant_bodypart/organ_linked/sarathi_tail]
	if(tail_data == /datum/sprite_accessory/mutant_part/tails/lizard/large::name || tail_data == /datum/sprite_accessory/mutant_part/tails/lizard/small::name)
		return FALSE
	return TRUE

// UI CREATION
/*
			if("spines" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Spines</h3>"

				dat += "<a href='?_src_=prefs;preference=spines;task=input'>[features["spines"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0


*/

// UI INTERACTION
/*

				if("spines")
					var/new_spines
					new_spines = input(user, "Choose your character's spines:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/spines]
					if(new_spines)
						features["spines"] = new_spines

*/

// CHARACTER COPY
/*
	feature
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_lizard_spines"]		, features["spines"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_lizard_spines"], features["spines"])
	features["spines"]					= sanitize_inlist(features["spines"], GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/spines])

*/

// RANDOMIZATION
/*
	feature
*/



// CORRESPONDING VARIABLE NAME:
// features["horns"]
// default value: "None"
/datum/preference/choiced_string/mutant_bodypart/horns
	name = "Horns"
	external_key = "feature_lizard_horns"

	mut_part_type = /datum/sprite_accessory/mutant_part/horns
	default_value = /datum/sprite_accessory/mutant_part/horns/none::name

// UI CREATION
/*
			if("horns" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Horns</h3>"

				dat += "<a href='?_src_=prefs;preference=horns;task=input'>[features["horns"]]</a><BR>"
				// dat += "<span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hair;task=input'>Change</a><BR>"
				// dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HAIR_COLOR]'>[(randomise[RANDOM_HAIR_COLOR]) ? "Lock" : "Unlock"]</A><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0


*/

// UI INTERACTION
/*
				if("horns")
					var/new_horns
					new_horns = input(user, "Choose your character's horns:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/horns]
					if(new_horns)
						features["horns"] = new_horns

*/

// CHARACTER COPY
/*
	feature
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_lizard_horns"]		, features["horns"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_lizard_horns"], features["horns"])
	features["horns"]					= sanitize_inlist(features["horns"], GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/horns])

*/

// RANDOMIZATION
/*
	feature
*/




// CORRESPONDING VARIABLE NAME:
// features["frills"]
// default value: "None"
/datum/preference/choiced_string/mutant_bodypart/frills
	name = "Frills"
	external_key = "feature_lizard_frills"

	mut_part_type = /datum/sprite_accessory/mutant_part/frills
	default_value = /datum/sprite_accessory/mutant_part/frills/none::name

// UI CREATION
/*
			if("frills" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Frills</h3>"

				dat += "<a href='?_src_=prefs;preference=frills;task=input'>[features["frills"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

*/

// UI INTERACTION
/*
				if("frills")
					var/new_frills
					new_frills = input(user, "Choose your character's frills:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/frills]
					if(new_frills)
						features["frills"] = new_frills


*/

// CHARACTER COPY
/*
	feature
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_lizard_frills"]		, features["frills"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_lizard_frills"], features["frills"])
	features["frills"]					= sanitize_inlist(features["frills"], GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/frills])

*/

// RANDOMIZATION
/*
	feature
*/


#warn might behave weirdly w/ big tails? not sure
// CORRESPONDING VARIABLE NAME:
// features["ipc_tail"]
// default value: "None"
/datum/preference/choiced_string/mutant_bodypart/ipc_tail
	name = "IPC Tail"
	external_key = "feature_ipc_tail"

	mut_part_type = /datum/sprite_accessory/mutant_part/ipc_tail
	default_value = /datum/sprite_accessory/mutant_part/ipc_tail/none::name

// UI CREATION
/*
			if("ipc_tail" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Tail Style</h3>"

				dat += "<a href='?_src_=prefs;preference=ipc_tail;task=input'>[features["ipc_tail"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0


*/

// UI INTERACTION
/*
				if("ipc_tail")
					var/new_ipc_tail

					new_ipc_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/ipc_tail]

					if(new_ipc_tail)
						features["ipc_tail"] = new_ipc_tail

*/

// CHARACTER COPY
/*
	feature
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_ipc_tail"] 			, features["ipc_tail"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_ipc_tail"], features["ipc_tail"])
	features["ipc_tail"]				= sanitize_inlist(features["ipc_tail"], GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/ipc_tail])

*/

// RANDOMIZATION
/*
	feature
*/



#warn IPC screens have an associated "change screen" action and some on-death behavior. that deserves its own attention -- as well as custom chassis-based availability...

// CORRESPONDING VARIABLE NAME:
// features["ipc_screen"]
// default value: "Blue"
/datum/preference/choiced_string/mutant_bodypart/ipc_screen
	name = "IPC Screen"
	external_key = "feature_ipc_screen"

	mut_part_type = /datum/sprite_accessory/mutant_part/ipc_screens
	default_value = /datum/sprite_accessory/mutant_part/ipc_screens/blue::name

/datum/preference/choiced_string/mutant_bodypart/ipc_screen/_is_available(list/dependency_data)

/datum/preference/choiced_string/mutant_bodypart/ipc_screen/apply_to_human(mob/living/carbon/human/target, data)

// UI CREATION
/*
			if("ipc_screen" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Screen Style</h3>"

				dat += "<a href='?_src_=prefs;preference=ipc_screen;task=input'>[features["ipc_screen"]]</a><BR>"

				// dat += "<span style='border: 1px solid #161616; background-color: #[eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=eyes;task=input'>Change</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0


*/

// UI INTERACTION
/*
				if("ipc_screen")
					var/new_ipc_screen

					new_ipc_screen = input(user, "Choose your character's screen:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/ipc_screens]

					if(new_ipc_screen)
						features["ipc_screen"] = new_ipc_screen


*/

// CHARACTER COPY
/*

/datum/species/ipc/spec_death(gibbed, mob/living/carbon/C)
	if(!has_screen)
		return
	saved_screen = C.dna.features["ipc_screen"]
	C.dna.features["ipc_screen"] = "BSOD"
	C.update_body()
	addtimer(CALLBACK(src, PROC_REF(post_death), C), 5 SECONDS)

/datum/species/ipc/proc/post_death(mob/living/carbon/C)
	if(C.stat < DEAD)
		return
	if(!has_screen)
		return
	C.dna.features["ipc_screen"] = null // Turns off their monitor on death.
	C.update_body()

/datum/action/innate/change_screen
	name = "Change Display"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "drone_vision"

/datum/action/innate/change_screen/Activate()
	var/screen_list = GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/ipc_screens]
	var/screen_choice = input(usr, "Which screen do you want to use?", "Screen Change") as null | anything in screen_list
	var/color_choice = input(usr, "Which color do you want your screen to be?", "Color Change") as null | color
	if(!screen_choice)
		return
	if(!color_choice)
		return
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/H = owner
	var/datum/species/ipc/species_datum = H.dna.species
	if(!species_datum)
		return
	if(!species_datum.has_screen)
		return
	H.dna.features["ipc_screen"] = screen_choice
	H.eye_color = sanitize_hexcolor(color_choice)
	H.update_body()


/datum/species/ipc/spec_revival(mob/living/carbon/human/H)
	if(has_screen)
		H.dna.features["ipc_screen"] = "BSOD"
		H.update_body()
	H.say("Reactivating [pick("core systems", "central subroutines", "key functions")]...")
	addtimer(CALLBACK(src, PROC_REF(post_revival), H), 6 SECONDS)

/datum/species/ipc/proc/post_revival(mob/living/carbon/human/H)
	if(H.stat == DEAD)
		return
	if(!has_screen)
		return
	H.dna.features["ipc_screen"] = saved_screen
	H.update_body()

/datum/species/ipc/replace_body(mob/living/carbon/C, datum/species/new_species, robotic = FALSE)
	..()

	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.ipc_chassis_list[C.dna.features[FEATURE_IPC_CHASSIS]]

	if(chassis_of_choice.use_eyes)
		LAZYREMOVE(species_traits, NOEYESPRITES)
		LAZYADD(species_traits, EYECOLOR)
		C.update_body()

	if(!chassis_of_choice.has_screen)
		has_screen = FALSE
		C.dna.features["ipc_screen"] = null
		C.update_body()

*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_ipc_screen"]			, features["ipc_screen"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_ipc_screen"], features["ipc_screen"])
	features["ipc_screen"]				= sanitize_inlist(features["ipc_screen"], GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/ipc_screens])

*/

// RANDOMIZATION
/*
	feature
*/



#warn so there are effectively two types of pref here -- the feature-based aggregative organ, and the subtype-based non-aggregative organ... hm.gh.
/// This variant of /datum/preference/choiced_string/mutant_bodypart always adds an organ to a mob's species bodyplan when it is applied,
/// instead of adding the part's string to the mob's species' mutant_bodyparts list. It still adds data to the mob's dna's features list.
/// Intended for sprite accessory-linked organs with variable_feature_data = TRUE.
/datum/preference/choiced_string/mutant_bodypart/organ_linked
	abstract_type = /datum/preference/choiced_string/mutant_bodypart/organ_linked

	// adding the part to the mutant_bodyparts list should hopefully be handled by the organ, so we don't need to do it ourselves.
	make_visible = FALSE

	var/skip_key

	var/obj/item/organ/linked_organ_type

/datum/preference/choiced_string/mutant_bodypart/organ_linked/apply_to_human(mob/living/carbon/human/target, data)
	if(skip_key && data == skip_key)
		return

	var/part_id = mut_part_type::mutant_string
	// because of the way our organs work, we need to add to our features list
	target.dna.features[part_id] = data

	switch(initial(linked_organ_type.slot))
		if(ORGAN_SLOT_BRAIN)
			target.dna.species.mutantbrain = linked_organ_type
		if(ORGAN_SLOT_HEART)
			target.dna.species.mutantheart = linked_organ_type
		if(ORGAN_SLOT_LUNGS)
			target.dna.species.mutantlungs = linked_organ_type
		if(ORGAN_SLOT_EYES)
			target.dna.species.mutanteyes = linked_organ_type
		if(ORGAN_SLOT_EARS)
			target.dna.species.mutantears = linked_organ_type
		if(ORGAN_SLOT_TONGUE)
			target.dna.species.mutanttongue = linked_organ_type
		if(ORGAN_SLOT_LIVER)
			target.dna.species.mutantliver = linked_organ_type
		if(ORGAN_SLOT_STOMACH)
			target.dna.species.mutantstomach = linked_organ_type
		if(ORGAN_SLOT_APPENDIX)
			target.dna.species.mutantappendix = linked_organ_type
		else
			target.dna.species.mutant_organs |= linked_organ_type


#warn clear these out from species mutant_organs lists.
// CORRESPONDING VARIABLE NAME:
// features["tail_lizard"]
// default value: "Smooth"
/datum/preference/choiced_string/mutant_bodypart/organ_linked/sarathi_tail
	name = "Sarathi Tail"
	external_key = "feature_lizard_tail"

	mut_part_type = /datum/sprite_accessory/mutant_part/tails/lizard
	default_value = /datum/sprite_accessory/mutant_part/tails/lizard/smooth::name

	linked_organ_type = /obj/item/organ/tail/lizard

// UI CREATION
/*
			if("tail_lizard" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Tail</h3>"

				dat += "<a href='?_src_=prefs;preference=tail_lizard;task=input'>[features["tail_lizard"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

*/

// UI INTERACTION
/*
				if("tail_lizard")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/tails/lizard]
					if(new_tail)
						features["tail_lizard"] = new_tail

*/

// CHARACTER COPY
/*
	feature
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_lizard_tail"]			, features["tail_lizard"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_lizard_tail"], features["tail_lizard"])
	features["tail_lizard"]				= sanitize_inlist(features["tail_lizard"], GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/tails/lizard])

*/

// RANDOMIZATION
/*
	feature
*/




// CORRESPONDING VARIABLE NAME:
// features["tail_elzu"]
// default value: "None"
/datum/preference/choiced_string/mutant_bodypart/organ_linked/elzu_tail
	name = "Elzu Tail"
	external_key = "feature_elzu_tail"

	mut_part_type = /datum/sprite_accessory/mutant_part/tails/elzu
	default_value = /datum/sprite_accessory/mutant_part/tails/elzu/none::name

	linked_organ_type = /obj/item/organ/tail/elzu
	// no point in giving them a tail organ if they specify that they don't want one.
	skip_key = /datum/sprite_accessory/mutant_part/tails/elzu/none::name


// UI CREATION
/*
			if("tail_elzu" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Tail</h3>"

				dat += "<a href='?_src_=prefs;preference=tail_elzu;task=input'>[features["tail_elzu"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

*/

// UI INTERACTION
/*
				if("tail_elzu")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/tails/elzu]
					if(new_tail)
						features["tail_elzu"] = new_tail

*/

// CHARACTER COPY
/*
	none, organfeature
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_tail_elzu"]			, features["tail_elzu"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_tail_elzu"], features["tail_elzu"])
	features["tail_elzu"]				= sanitize_inlist(features["tail_elzu"], GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/tails/elzu])

*/

// RANDOMIZATION
/*
	feature
*/



// CORRESPONDING VARIABLE NAME:
// features["moth_wings"]
// default value: "Plain"
/datum/preference/choiced_string/mutant_bodypart/organ_linked/moth_wings
	name = "Moth Wings"
	external_key = "feature_moth_wings"

	mut_part_type = /datum/sprite_accessory/mutant_part/moth_wings
	default_value = /datum/sprite_accessory/mutant_part/moth_wings/plain::name

	linked_organ_type = /obj/item/organ/moth_wings

// UI CREATION
/*
			if("moth_wings" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Moth wings</h3>"

				dat += "<a href='?_src_=prefs;preference=moth_wings;task=input'>[features["moth_wings"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

*/

// UI INTERACTION
/*
				if("moth_wings")
					var/new_moth_wings
					new_moth_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/moth_wings]
					if(new_moth_wings)
						features["moth_wings"] = new_moth_wings

*/

// CHARACTER COPY
/*
	none
*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_moth_wings"]			, features["moth_wings"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_moth_wings"], features["moth_wings"])
	features["moth_wings"]				= sanitize_inlist(features["moth_wings"], GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/moth_wings], "Plain")

*/

// RANDOMIZATION
/*
	feature
*/



#warn should be in another file; should maybe be unified with datum/preference/choiced_string/mutant_bodypart/organ_linked.
/datum/preference/choiced_string/organ_types
	abstract_type = /datum/preference/choiced_string/organ

	dependencies = list(/datum/preference/species)
	randomization_flags = PREF_RAND_FLAG_APPEARANCE

	/// An associative list matching user-displayed (and save-written) strings to the organ type to be added to the mob's species datum prior to its finalization.
	var/list/string_type_lookup

/datum/preference/choiced_string/organ_types/get_options_list()
	return string_type_lookup

/datum/preference/choiced_string/organ_types/apply_to_human(mob/living/carbon/human/target, data)
	var/obj/item/organ/organ_type = string_type_lookup[data]
	// add the organ to their bodyplan -- later, in the
	switch(initial(organ_type.slot))
		if(ORGAN_SLOT_BRAIN)
			target.dna.species.mutantbrain = organ_type
		if(ORGAN_SLOT_HEART)
			target.dna.species.mutantheart = organ_type
		if(ORGAN_SLOT_LUNGS)
			target.dna.species.mutantlungs = organ_type
		if(ORGAN_SLOT_EYES)
			target.dna.species.mutanteyes = organ_type
		if(ORGAN_SLOT_EARS)
			target.dna.species.mutantears = organ_type
		if(ORGAN_SLOT_TONGUE)
			target.dna.species.mutanttongue = organ_type
		if(ORGAN_SLOT_LIVER)
			target.dna.species.mutantliver = organ_type
		if(ORGAN_SLOT_STOMACH)
			target.dna.species.mutantstomach = organ_type
		if(ORGAN_SLOT_APPENDIX)
			target.dna.species.mutantappendix = organ_type
		else
			target.dna.species.mutant_organs |= organ_type


// NOTE: this is a bad way of doing things.
// New organ-linked sprite accessory preferences should use the /datum/preference/choiced_string/mutant_bodypart/organ_linked approach instead;
// THIS approach is what's necessary for sprite-accessory linked organs with variable_feature_data = FALSE.
/datum/preference/choiced_string/organ_types/human_ears

// CORRESPONDING VARIABLE NAME:
// features["tail_human"]
// default value: "None"
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
			if("tail_human" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Tail</h3>"

				dat += "<a href='?_src_=prefs;preference=tail_human;task=input'>[features["tail_human"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

*/

// UI INTERACTION
/*
				if("tail_human")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/tails/human]
					if(new_tail)
						features["tail_human"] = new_tail


*/

// CHARACTER COPY
/*
	if(C.dna.features["tail_human"] == "Cat")
		mutant_organs |= /obj/item/organ/tail/cat
	if(C.dna.features["tail_human"] == "Fox")
		mutant_organs |= /obj/item/organ/tail/fox

*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_human_tail"]			, features["tail_human"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_human_tail"], features["tail_human"])
	features["tail_human"]				= sanitize_inlist(features["tail_human"], GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/tails/human], "None")

*/

// RANDOMIZATION
/*
	feature
*/






// CORRESPONDING VARIABLE NAME:
// features["ears"]
// default value: "None"
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
			if("ears" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Mutant Ears</h3>"

				dat += "<a href='?_src_=prefs;preference=ears;task=input'>[features["ears"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0


*/

// UI INTERACTION
/*
				if("ears")
					var/new_ears
					new_ears = input(user, "Choose your character's mutant ears:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/ears]
					if(new_ears)
						features["ears"] = new_ears


*/

// CHARACTER COPY
/*
	if(C.dna.features["ears"] == "Cat")
		mutantears = /obj/item/organ/ears/cat
	if(C.dna.features["ears"] == "Fox")
		mutantears = /obj/item/organ/ears/fox
	if(C.dna.features["ears"] == "Elf")
		mutantears = /obj/item/organ/ears/elf

*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_human_ears"]			, features["ears"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_human_ears"], features["ears"])
	features["ears"]					= sanitize_inlist(features["ears"], GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/ears], "None")

*/

// RANDOMIZATION
/*
	feature
*/

