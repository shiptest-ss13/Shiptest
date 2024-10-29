
/datum/admins/proc/create_mob(mob/user)
	var/static/create_mob_html
	if (!create_mob_html)
		var/mobjs = null
		mobjs = jointext(typesof(/mob), ";")
		create_mob_html = file2text('html/create_object.html')
		create_mob_html = replacetext(create_mob_html, "Create Object", "Create Mob")
		create_mob_html = replacetext(create_mob_html, "null; /* object types */", "\"[mobjs]\"")

	user << browse(create_panel_helper(create_mob_html), "window=create_mob;size=425x475")

#warn randomization, remove
/proc/randomize_human(mob/living/carbon/human/H)
	H.gender = pick(MALE, FEMALE)
	H.real_name = random_unique_name(H.gender)
	H.name = H.real_name
	// H.underwear = random_underwear(H.gender)
	H.underwear_color = random_color()
	H.skin_tone = random_skin_tone()
	H.hairstyle = random_hairstyle()
	H.facial_hairstyle = random_facial_hairstyle(H.gender)
	H.hair_color = random_color_natural()
	H.facial_hair_color = H.hair_color
	H.eye_color = random_eye_color()
	H.dna.blood_type = random_blood_type()
	H.generic_adjective = pick_species_adjective(H)

	// Mutant randomizing, doesn't affect the mob appearance unless it's the specific mutant.
	H.dna.features = random_features()

	H.update_body()
	H.update_hair()
