/mob/living/carbon/human/dummy/consistent/setup_human_dna()
	create_dna()
	return //No randomisation

// ! randomization (tbf, this is a wiki thing)
/mob/living/carbon/human/dummy/consistent/proc/seeded_randomization(seed = 0)
	gender = list(MALE, FEMALE)[seed % 2 + 1]
	skin_tone = GLOB.skin_tones[seed % length(GLOB.skin_tones) + 1]
	hairstyle = GLOB.hairstyles_list[seed % length(GLOB.hairstyles_list) + 1]
	hair_color = color_natural_from_seed(seed)
	eye_color = short_color_from_seed(seed)

	var/list/feature_list = list(
		FEATURE_MUTANT_COLOR = short_color_from_seed(seed * 2),
		FEATURE_MUTANT_COLOR2 = short_color_from_seed(seed * 3),

		//AAAAAAAAAAAAAAAAAAAAAAAAAA
		FEATURE_ETHEREAL_COLOR = GLOB.color_list_ethereal[GLOB.color_list_ethereal[seed % length(GLOB.color_list_ethereal) + 1]],
		FEATURE_IPC_CHASSIS = GLOB.ipc_chassis_list[seed % length(GLOB.ipc_chassis_list) + 1]
	)

	// Mutant randomizing, doesn't affect the mob appearance unless it's the specific mutant.
	for(var/datum/sprite_accessory/mutant_part/abstr_part_type as anything in GLOB.mut_part_name_datum_lookup)
		// do not consider non-randomizable part types
		if(!initial(abstr_part_type.randomizable))
			continue
		// look into the list to get the list of options
		var/list/part_option_names = GLOB.mut_part_name_datum_lookup[abstr_part_type]
		// pick an option to add to features
		var/part_type_id = initial(abstr_part_type.mutant_string)
		feature_list[part_type_id] = part_option_names[seed % length(part_option_names) + 1]

	dna.features = feature_list

	update_body()
	update_hair()
