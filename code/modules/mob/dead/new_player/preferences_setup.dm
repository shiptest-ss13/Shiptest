
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
		skin_tone = random_skin_tone()
	if(randomise[RANDOM_EYE_COLOR])
		eye_color = random_eye_color()
	if(randomise[RANDOM_PROSTHETIC])
		prosthetic_limbs = random_prosthetic()
	if(!pref_species)
		var/rando_race = pick(GLOB.roundstart_races)
		pref_species = new rando_race()
	features = random_features()

/datum/preferences/proc/random_species()
	var/random_species_type = GLOB.species_list[pick(GLOB.roundstart_races)]
	pref_species = new random_species_type
	if(randomise[RANDOM_NAME])
		real_name = pref_species.random_name(gender,1)

/datum/preferences/proc/update_preview_icon(show_gear = TRUE, show_loadout = FALSE)
	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
	copy_to(mannequin, 1, TRUE, TRUE, loadout = show_loadout)

	if(selected_outfit && show_gear)
		selected_outfit.equip(mannequin, TRUE, preference_source = parent)

	COMPILE_OVERLAYS(mannequin)
	parent.show_character_previews(new /mutable_appearance(mannequin))
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
