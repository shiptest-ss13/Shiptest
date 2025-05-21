// certain IPC prefs have some odd behavior, so they get their own file
// ain't that nice!

#warn might behave weirdly w/ big tails? not sure
// CORRESPONDING VARIABLE NAME:
// features["ipc_tail"]
// default value: "None"
/datum/preference/choiced_string/mutant_bodypart/ipc_tail
	name = "Tail (IPC)"
	savefile_key = "feature_ipc_tail"

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



// CORRESPONDING VARIABLE NAME:
// features["ipc_screen"]
// default value: "Blue"
/datum/preference/choiced_string/mutant_bodypart/ipc_screen
	name = "IPC Screen"
	savefile_key = "feature_ipc_screen"

	dependencies = list(/datum/preference/species, /datum/preference/choiced_string/ipc_chassis)

	mut_part_type = /datum/sprite_accessory/mutant_part/ipc_screens
	default_value = /datum/sprite_accessory/mutant_part/ipc_screens/blue::name

/datum/preference/choiced_string/mutant_bodypart/ipc_screen/_is_available(list/dependency_data)
	var/prev = ..()
	if(prev && (/datum/preference/choiced_string/ipc_chassis in dependency_data))
		var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.ipc_chassis_list[dependency_data[/datum/preference/choiced_string/ipc_chassis]]
		if(chassis_of_choice.has_screen)
			return TRUE
	return prev

/datum/preference/choiced_string/mutant_bodypart/ipc_screen/apply_to_human(mob/living/carbon/human/target, data)
	. = ..()
#warn IPC screens have an associated "change screen" action and some on-death behavior. that deserves its own attention. for now we are ignoring it

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


// CORRESPONDING VARIABLE NAME:
// features[FEATURE_IPC_CHASSIS]
// default value: "Morpheus Cyberkinetics (Custom)"
/datum/preference/choiced_string/ipc_chassis
	name = "IPC Chassis"
	savefile_key = "feature_ipc_chassis"

	application_priority = PREF_APPLICATION_PRIORITY_SPECIES_FINALIZE - 1

	default_value = /datum/sprite_accessory/ipc_chassis/mcgreyscale::name
	dependencies = list(/datum/preference/species)

/datum/preference/choiced_string/ipc_chassis/get_options_list()
	return GLOB.ipc_chassis_list

/datum/preference/choiced_string/ipc_chassis/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	if(FEATURE_IPC_CHASSIS in chosen_species.default_features)
		return TRUE
	return FALSE

/datum/preference/choiced_string/ipc_chassis/apply_to_human(mob/living/carbon/human/target, data)
	target.dna.features[FEATURE_IPC_CHASSIS] = data

	// var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.ipc_chassis_list[data]

	// #warn dangerous fucking assumption
	// var/datum/species/ipc/spec = target.dna.species.spec

	// if(chassis_of_choice.use_eyes)
	// 	LAZYREMOVE(target.dna.species.species_traits, NOEYESPRITES)
	// 	LAZYADD(target.dna.species.species_traits, EYECOLOR)

	// if(!chassis_of_choice.has_screen)
	// 	spec.has_screen = FALSE
	// 	#warn should almost certainly be removed
	// 	target.dna.features["ipc_screen"] = null

	// for(var/obj/item/bodypart/BP as anything in C.bodyparts) //Override bodypart data as necessary
	// 	if(BP.limb_id=="synth")
	// 		var/mutcolor_bodyparts = chassis_of_choice.use_mutcolors ? TRUE : FALSE
	// 		if(mutcolor_bodyparts)
	// 			BP.should_draw_greyscale = TRUE
	// 			BP.effective_skin_color = C.dna?.features[FEATURE_MUTANT_COLOR]
	// 			BP.species_secondary_color = C.dna?.features[FEATURE_MUTANT_COLOR2]

	// 		if(chassis_of_choice.icon)
	// 			BP.static_icon = chassis_of_choice.icon
	// 			BP.icon = chassis_of_choice.icon

	// 		if(chassis_of_choice.has_overlay)
	// 			BP.overlay_icon_state = TRUE

	// 		if(chassis_of_choice.is_digi)
	// 			if(istype(BP,/obj/item/bodypart/leg))
	// 				BP.bodytype |= BODYTYPE_DIGITIGRADE //i hate this so much

	// 		if(chassis_of_choice.has_snout)
	// 			if(istype(BP,/obj/item/bodypart/head))
	// 				BP.bodytype |= BODYTYPE_SNOUT //hate. hate. (tik tok tts)

	// 		BP.limb_id = chassis_of_choice.limbs_id
	// 		BP.name = "\improper[chassis_of_choice.name] [parse_zone(BP.body_zone)]"
	// 		BP.update_limb()

	// synchronize bodytypes goes here

	// target.update_body()


// UI CREATION
/*
			if("ipc_chassis" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Chassis Style</h3>"

				dat += "<a href='?_src_=prefs;preference=ipc_chassis;task=input'>[features["ipc_chassis"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

*/

// UI INTERACTION
/*
				if("ipc_chassis")
					var/new_ipc_chassis

					new_ipc_chassis = input(user, "Choose your character's chassis:", "Character Preference") as null|anything in GLOB.ipc_chassis_list

					if(new_ipc_chassis)
						features["ipc_chassis"] = new_ipc_chassis


*/

// CHARACTER COPY
/*
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

	if(chassis_of_choice.is_digi)
		digitigrade_customization = DIGITIGRADE_FORCED
		bodytype = BODYTYPE_DIGITIGRADE

	for(var/obj/item/bodypart/BP as anything in C.bodyparts) //Override bodypart data as necessary
		if(BP.limb_id=="synth")
			var/mutcolor_bodyparts = chassis_of_choice.use_mutcolors ? TRUE : FALSE
			if(mutcolor_bodyparts)
				BP.should_draw_greyscale = TRUE
				BP.effective_skin_color = C.dna?.features[FEATURE_MUTANT_COLOR]
				BP.species_secondary_color = C.dna?.features[FEATURE_MUTANT_COLOR2]

			if(chassis_of_choice.icon)
				BP.static_icon = chassis_of_choice.icon
				BP.icon = chassis_of_choice.icon

			if(chassis_of_choice.has_overlay)
				BP.overlay_icon_state = TRUE

			if(chassis_of_choice.is_digi)
				if(istype(BP,/obj/item/bodypart/leg))
					BP.bodytype |= BODYTYPE_DIGITIGRADE //i hate this so much

			if(chassis_of_choice.has_snout)
				if(istype(BP,/obj/item/bodypart/head))
					BP.bodytype |= BODYTYPE_SNOUT //hate. hate. (tik tok tts)

			BP.limb_id = chassis_of_choice.limbs_id
			BP.name = "\improper[chassis_of_choice.name] [parse_zone(BP.body_zone)]"
			BP.update_limb()

*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_ipc_chassis"]			, features["ipc_chassis"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_ipc_chassis"], features[FEATURE_IPC_CHASSIS])
	features["ipc_chassis"]				= sanitize_inlist(features["ipc_chassis"], GLOB.ipc_chassis_list)

*/

// RANDOMIZATION
/*
 none, feature
*/


// CORRESPONDING VARIABLE NAME:
// features[FEATURE_IPC_BRAIN]
// default value: "Posibrain"
/datum/preference/choiced_string/indiv_organs/ipc_brain
	name = "IPC Brain"

	savefile_key = "feature_ipc_brain"
	dependencies = list(/datum/preference/species)

	string_type_lookup = list(
		"Posibrain" = /obj/item/organ/brain/mmi_holder,
		"Man-Machine Interface" = /obj/item/organ/brain/mmi_holder/posibrain
	)
	default_value = "Posibrain"

/datum/preference/choiced_string/indiv_organs/ipc_brain/_is_available(list/dependency_data)
	var/datum/species/chosen_species = dependency_data[/datum/preference/species]
	if(FEATURE_IPC_BRAIN in chosen_species.default_features)
		return TRUE
	return FALSE

/datum/preference/choiced_string/indiv_organs/ipc_brain/randomize(list/dependency_data, list/rand_dependency_data)
	// most IPCs do not have human brains
	if(prob(80))
		return default_value
	else
		return ..()

// UI CREATION
/*
			if("ipc_brain" in current_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Brain Type</h3>"
				dat += "<a href='?_src_=prefs;preference=ipc_brain;task=input'>[features["ipc_brain"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

*/

// UI INTERACTION
/*
				if("ipc_brain")
					var/new_ipc_brain
					new_ipc_brain = input(user, "Choose your character's brain type:", "Character Preference") as null|anything in GLOB.ipc_brain_list
					if(new_ipc_brain)
						features["ipc_brain"] = new_ipc_brain

*/

// CHARACTER COPY
/*

*/

// SERIALIZATION
/*
	WRITE_FILE(S["feature_ipc_brain"]			, features["ipc_brain"])

*/

// DESERIALIZATION
/*
	READ_FILE(S["feature_ipc_brain"], features[FEATURE_IPC_BRAIN])
	features["ipc_brain"]				= sanitize_inlist(features["ipc_brain"], GLOB.ipc_brain_list)

*/

// RANDOMIZATION
/*
 none, feature
*/

// /datum/species/ipc/on_species_gain(mob/living/carbon/C) // Let's make that IPC actually robotic.
// 	. = ..()
// 	if(ishuman(C))
// 		var/mob/living/carbon/human/H = C
// 		if(!change_screen)
// 			var/datum/species/ipc/species_datum = H.dna.species
// 			if(species_datum?.has_screen)
// 				change_screen = new
// 				change_screen.Grant(H)
// 		if(H.dna.features[FEATURE_IPC_BRAIN] == "Man-Machine Interface")
// 			mutantbrain = /obj/item/organ/brain/mmi_holder
// 		else
// 			mutantbrain = /obj/item/organ/brain/mmi_holder/posibrain
// 		C.RegisterSignal(C, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, TYPE_PROC_REF(/mob/living/carbon, charge))

// /datum/species/ipc/on_species_gain(mob/living/carbon/C) // Let's make that IPC actually robotic.
// 	. = ..()
// 	if(ishuman(C))
// 		var/mob/living/carbon/human/H = C
// 		if(!change_screen)
// 			var/datum/species/ipc/species_datum = H.dna.species
// 			if(species_datum?.has_screen)
// 				change_screen = new
// 				change_screen.Grant(H)
// 		if(H.dna.features[FEATURE_IPC_BRAIN] == "Man-Machine Interface")
// 			mutantbrain = /obj/item/organ/brain/mmi_holder
// 		else
// 			mutantbrain = /obj/item/organ/brain/mmi_holder/posibrain
// 		C.RegisterSignal(C, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, TYPE_PROC_REF(/mob/living/carbon, charge))

// /datum/species/ipc/on_species_loss(mob/living/carbon/C)
// 	. = ..()
// 	if(change_screen)
// 		change_screen.Remove(C)
// 	C.UnregisterSignal(C, COMSIG_PROCESS_BORGCHARGER_OCCUPANT)

// #warn direct string modifications... ugh.
// /datum/species/ipc/spec_death(gibbed, mob/living/carbon/C)
// 	if(!has_screen)
// 		return
// 	saved_screen = C.dna.features["ipc_screen"]
// 	C.dna.features["ipc_screen"] = "BSOD"
// 	C.update_body()
// 	addtimer(CALLBACK(src, PROC_REF(post_death), C), 5 SECONDS)

// /datum/species/ipc/proc/post_death(mob/living/carbon/C)
// 	if(C.stat < DEAD)
// 		return
// 	if(!has_screen)
// 		return
// 	C.dna.features["ipc_screen"] = null // Turns off their monitor on death.
// 	C.update_body()

// /datum/action/innate/change_screen
// 	name = "Change Display"
// 	check_flags = AB_CHECK_CONSCIOUS
// 	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
// 	button_icon_state = "drone_vision"

// /datum/action/innate/change_screen/Activate()
// 	var/screen_list = GLOB.mut_part_name_datum_lookup[/datum/sprite_accessory/mutant_part/ipc_screens]
// 	var/screen_choice = input(usr, "Which screen do you want to use?", "Screen Change") as null | anything in screen_list
// 	var/color_choice = input(usr, "Which color do you want your screen to be?", "Color Change") as null | color
// 	if(!screen_choice)
// 		return
// 	if(!color_choice)
// 		return
// 	if(!ishuman(owner))
// 		return
// 	var/mob/living/carbon/human/H = owner
// 	var/datum/species/ipc/species_datum = H.dna.species
// 	if(!species_datum)
// 		return
// 	if(!species_datum.has_screen)
// 		return
// 	H.dna.features["ipc_screen"] = screen_choice
// 	H.eye_color = sanitize_hexcolor(color_choice)
// 	H.update_body()

