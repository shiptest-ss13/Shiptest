/mob/living/carbon/human/dummy/consistent/setup_human_dna()
	create_dna()
	return //No randomisation

#warn randomization, remove (tbf, this is a wiki thing... need a seed)
/mob/living/carbon/human/dummy/consistent/proc/seeded_randomization(seed = 0, species_list = null)
	// a 32-character hex string. we read characters off of this for randomization. 2 characters = 1 byte
	seed = md5(seed)

	gender = list(MALE, FEMALE)[hex2num(copytext(seed, 1, 2)) % 2 + 1]
	skin_tone = GLOB.skin_tones[hex2num(copytext(seed, 2, 3)) % length(GLOB.skin_tones) + 1]

	hairstyle = GLOB.hairstyles_list[hex2num(copytext(seed, 3, 6)) % length(GLOB.hairstyles_list) + 1]
	if(gender == MALE)
		facial_hairstyle = GLOB.facial_hairstyles_list[hex2num(copytext(seed, 6, 9)) % length(GLOB.facial_hairstyles_list) + 1]

	// color_from_seed hashes its input, so giving nonoverlapping windows is less important
	hair_color = color_natural_from_seed(copytext(seed, 9, 15))
	eye_color = color_from_seed(copytext(seed, 11, 17))
	facial_hair_color = hair_color

	var/list/feature_list = list(
		FEATURE_MUTANT_COLOR = color_from_seed(copytext(seed, 17, 25)),
		FEATURE_MUTANT_COLOR2 = color_from_seed(copytext(seed, 19, 27)),

		// ugh
		FEATURE_IPC_CHASSIS = GLOB.ipc_chassis_list[hex2num(copytext(seed, 29, 31)) % length(GLOB.ipc_chassis_list) + 1]
	)

	// pick the species for later -- done so that adding new customization options at least won't randomize the species.
	if(!species_list)
		species_list = GLOB.species_list
	var/species = species_list[hex2num(copytext(seed, 31, 33)) % length(species_list) + 1]

	// now we're out of bits. luckily we can get "more"
	seed = md5(seed) // is this cryptographically secure? fuck no, but that doesn't matter one bit

	// Now we need to further randomize the features
	// Code here is a little clunky, but it was written to mimic old behavior.
	var/first_char = 1
	for(var/datum/sprite_accessory/mutant_part/abstr_part_type as anything in GLOB.mut_part_name_datum_lookup)
		// do not consider non-randomizable part types
		if(!initial(abstr_part_type.randomizable))
			continue
		// look into the list to get the list of options
		var/list/part_option_names = GLOB.mut_part_name_datum_lookup[abstr_part_type]
		var/part_type_id = initial(abstr_part_type.mutant_string)

		// pick an option to add to features. the hex2num-copytext is basically just getting a random byte
		var/chosen_index = hex2num(copytext(seed, first_char, first_char + 2)) % length(part_option_names)
		feature_list[part_type_id] = part_option_names[chosen_index]

		first_char += 2 // bump up the window
		if(first_char > 31) // md5() returns 32 characters. if first_char > 31, we're trying to get a 2-character window past the end of the string
			seed = md5(seed)
			first_char = 1

	dna.features = feature_list

	set_species(species)
