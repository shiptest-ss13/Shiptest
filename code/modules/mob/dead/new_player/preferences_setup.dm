
	//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/random_character(gender_override, antag_override = FALSE)
	if(randomise[RANDOM_SPECIES])
		random_species()
	else if(randomise[RANDOM_NAME])
		real_name = pref_species.random_name(gender,1)
	if(gender_override && !(randomise[RANDOM_GENDER] || randomise[RANDOM_GENDER_ANTAG] && antag_override))
		gender = gender_override
	else
		gender = pick(MALE,FEMALE,PLURAL)
	if(randomise[RANDOM_AGE] || randomise[RANDOM_AGE_ANTAG] && antag_override)
		age = rand(AGE_MIN,AGE_MAX)
	if(randomise[RANDOM_UNDERWEAR])
		underwear = random_underwear()
	if(randomise[RANDOM_UNDERWEAR_COLOR])
		underwear_color = random_color()
	if(randomise[RANDOM_UNDERSHIRT])
		undershirt = random_undershirt(gender)
	if(randomise[RANDOM_UNDERSHIRT_COLOR])
		undershirt_color = random_short_color()
	if(randomise[RANDOM_SOCKS])
		socks = random_socks()
	if(randomise[RANDOM_SOCKS_COLOR])
		socks_color = random_short_color()
	if(randomise[RANDOM_BACKPACK])
		backpack = random_backpack()
	if(randomise[RANDOM_JUMPSUIT_STYLE])
		jumpsuit_style = PREF_SUIT
	if(randomise[RANDOM_EXOWEAR_STYLE])
		exowear = PREF_EXOWEAR
	if(randomise[RANDOM_HAIRSTYLE])
		hairstyle = random_hairstyle(gender)
	if(randomise[RANDOM_FACIAL_HAIRSTYLE])
		facial_hairstyle = random_facial_hairstyle(gender)
	if(randomise[RANDOM_HAIR_COLOR])
		hair_color = random_color_natural()
	if(randomise[RANDOM_FACIAL_HAIR_COLOR])
		facial_hair_color = random_color_natural()
	if(randomise[RANDOM_SKIN_TONE])
		set_skin_tone(random_skin_tone())
	if(randomise[RANDOM_EYE_COLOR])
		eye_color = random_eye_color()
	if(randomise[RANDOM_PROSTHETIC])
		prosthetic_limbs = random_prosthetic()
	if(!pref_species)
		var/rando_race = pick(GLOB.roundstart_races)
		set_new_species(rando_race)
	//features = pref_species.get_random_features()
	var/list/new_features = pref_species.get_random_features() //We do this to keep flavor text, genital sizes etc.
	for(var/key in new_features)
		features[key] = new_features[key]
	mutant_bodyparts = pref_species.get_random_mutant_bodyparts(features)
	body_markings = pref_species.get_random_body_markings(features)

/datum/preferences/proc/random_species()
	var/random_species_type = GLOB.species_list[pick(GLOB.roundstart_races)]
	set_new_species(random_species_type)
	if(randomise[RANDOM_NAME])
		real_name = pref_species.random_name(gender,1)

/datum/preferences/proc/update_preview_icon(show_gear = TRUE, show_loadout = FALSE)
	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
	switch(preview_pref)
		if(PREVIEW_PREF_JOB)
			copy_to(mannequin, 1, TRUE, TRUE)
			mannequin.underwear_visibility = NONE
		if(PREVIEW_PREF_LOADOUT)
			copy_to(mannequin, 1, TRUE, TRUE, loadout = show_loadout)
			if(selected_outfit)
				selected_outfit.equip(mannequin, TRUE, preference_source = parent)
			mannequin.underwear_visibility = NONE
		if(PREVIEW_PREF_NAKED)
			copy_to(mannequin, 1, TRUE, TRUE)
			mannequin.underwear_visibility = UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_SOCKS
		else
			copy_to(mannequin, 1, TRUE, TRUE) // if for whatever reason either setting doesnt work

	mannequin.update_body() //Unfortunately, due to a certain case we need to update this just in case

	COMPILE_OVERLAYS(mannequin)
	parent.show_character_previews(new /mutable_appearance(mannequin))
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)

//This proc makes sure that we only have the parts that the species should have, add missing ones, remove extra ones(should any be changed)
//Also, this handles missing color keys
/datum/preferences/proc/validate_species_parts()
	if(!pref_species)
		return

	var/list/target_bodyparts = pref_species.default_mutant_bodyparts.Copy()

	if(!isnum(features["body_size"]))
		features["body_size"] = BODY_SIZE_NORMAL //unfucks body size if fucked

	//Remove all "extra" accessories
	for(var/key in mutant_bodyparts)
		if(!GLOB.sprite_accessories[key]) //That accessory no longer exists, remove it
			mutant_bodyparts -= key
			continue
		if(!pref_species.default_mutant_bodyparts[key])
			mutant_bodyparts -= key
			continue
		if(!GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]) //The individual accessory no longer exists
			mutant_bodyparts[key][MUTANT_INDEX_NAME] = pref_species.default_mutant_bodyparts[key]
		validate_color_keys_for_part(key) //Validate the color count of each accessory that wasnt removed

	//Add any missing accessories
	for(var/key in target_bodyparts)
		if(!mutant_bodyparts[key])
			var/datum/sprite_accessory/SA
			if(target_bodyparts[key] == ACC_RANDOM)
				SA = random_accessory_of_key_for_species(key, pref_species)
			else
				SA = GLOB.sprite_accessories[key][target_bodyparts[key]]
			var/final_list = list()
			final_list[MUTANT_INDEX_NAME] = SA.name
			final_list[MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)
			mutant_bodyparts[key] = final_list

	if(!allow_advanced_colors)
		reset_colors()

/datum/preferences/proc/validate_color_keys_for_part(key)
	var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
	var/list/colorlist = mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST]
	if(SA.color_src == USE_MATRIXED_COLORS && colorlist.len != 3)
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)
	else if (SA.color_src == USE_ONE_COLOR && colorlist.len != 1)
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)

/datum/preferences/proc/set_new_species(new_species_path)
	pref_species = new new_species_path()
	var/list/new_features = pref_species.get_random_features() //We do this to keep flavor text, genital sizes etc.
	for(var/key in new_features)
		features[key] = new_features[key]
	mutant_bodyparts = pref_species.get_random_mutant_bodyparts(features)
	body_markings = pref_species.get_random_body_markings(features)
	if(pref_species.use_skintones)
		features["uses_skintones"] = TRUE
	//We reset the quirk-based stuff
	augments = list()
	all_quirks = list()

/datum/preferences/proc/reset_colors()
	for(var/key in mutant_bodyparts)
		var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
		if(SA.always_color_customizable)
			continue
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)

	for(var/zone in body_markings)
		var/list/bml = body_markings[zone]
		for(var/key in bml)
			var/datum/body_marking/BM = GLOB.body_markings[key]
			bml[key] = BM.get_default_color(features, pref_species)
