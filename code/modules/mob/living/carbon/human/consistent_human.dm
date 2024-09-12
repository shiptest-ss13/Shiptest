/mob/living/carbon/human/dummy/consistent/setup_human_dna()
	create_dna()
	return //No randomisation

/mob/living/carbon/human/dummy/consistent/proc/seeded_randomization(seed = 0, species_list = null)
	seed = md5(seed)

	gender = list(MALE, FEMALE)[hex2num(copytext(seed, 1, 2)) % 2 + 1]
	skin_tone = GLOB.skin_tones[hex2num(copytext(seed, 2, 3)) % length(GLOB.skin_tones) + 1]

	hairstyle = GLOB.hairstyles_list[hex2num(copytext(seed, 1, 3)) % length(GLOB.hairstyles_list) + 1]
	facial_hairstyle = GLOB.facial_hairstyles_list[hex2num(copytext(seed, 3, 6)) % length(GLOB.facial_hairstyles_list) + 1]

	hair_color = color_natural_from_seed(copytext(seed, 1, 6))
	facial_hair_color = hair_color
	eye_color = color_from_seed(copytext(seed, 3, 9))

	dna.features["mcolor"] = color_from_seed(copytext(seed, 1, 9))
	dna.features["mcolor2"] = color_from_seed(copytext(seed, 2, 10))
	dna.features["ethcolor"] = color_from_seed(copytext(seed, 3, 11))

	dna.features["tail_lizard"] = GLOB.tails_list_lizard[hex2num(copytext(seed, 2, 3)) % length(GLOB.tails_list_lizard) + 1]
	dna.features["face_markings"] = GLOB.face_markings_list[hex2num(copytext(seed, 3, 4)) % length(GLOB.face_markings_list) + 1]
	dna.features["horns"] = GLOB.horns_list[hex2num(copytext(seed, 4, 5)) % length(GLOB.horns_list) + 1]
	dna.features["frills"] = GLOB.frills_list[hex2num(copytext(seed, 5, 6)) % length(GLOB.frills_list) + 1]
	dna.features["spines"] = GLOB.spines_list[hex2num(copytext(seed, 6, 7)) % length(GLOB.spines_list) + 1]
	dna.features["body_markings"] = GLOB.body_markings_list[hex2num(copytext(seed, 7, 8)) % length(GLOB.body_markings_list) + 1]
	dna.features["moth_wings"] = GLOB.moth_wings_list[hex2num(copytext(seed, 8, 9)) % length(GLOB.moth_wings_list) + 1]
	dna.features["moth_fluff"] = GLOB.moth_fluff_list[hex2num(copytext(seed, 9, 10)) % length(GLOB.moth_fluff_list) + 1]
	dna.features["spider_legs"] = GLOB.spider_legs_list[hex2num(copytext(seed, 10, 11)) % length(GLOB.spider_legs_list) + 1]
	dna.features["spider_spinneret"] = GLOB.spider_spinneret_list[hex2num(copytext(seed, 11, 12)) % length(GLOB.spider_spinneret_list) + 1]
	dna.features["kepori_feathers"] = GLOB.kepori_feathers_list[hex2num(copytext(seed, 12, 13)) % length(GLOB.kepori_feathers_list) + 1]
	dna.features["kepori_body_feathers"] = GLOB.kepori_body_feathers_list[hex2num(copytext(seed, 13, 14)) % length(GLOB.kepori_body_feathers_list) + 1]
	dna.features["kepori_head_feathers"] = GLOB.kepori_head_feathers_list[hex2num(copytext(seed, 13, 14)) % length(GLOB.kepori_head_feathers_list) + 1]
	dna.features["vox_head_quills"] = GLOB.vox_head_quills_list[hex2num(copytext(seed, 14, 15)) % length(GLOB.vox_head_quills_list) + 1]
	dna.features["vox_neck_quills"] = GLOB.vox_neck_quills_list[hex2num(copytext(seed, 15, 16)) % length(GLOB.vox_neck_quills_list) + 1]
	dna.features["elzu_horns"] = GLOB.elzu_horns_list[hex2num(copytext(seed, 16, 17)) % length(GLOB.elzu_horns_list) + 1]
	dna.features["tail_elzu"] = GLOB.tails_list_elzu[hex2num(copytext(seed, 17, 18)) % length(GLOB.tails_list_elzu) + 1]
	dna.features["ipc_chassis"] = GLOB.ipc_chassis_list[hex2num(copytext(seed, 18, 19)) % length(GLOB.ipc_chassis_list) + 1]
	dna.features["ipc_screen"] = GLOB.ipc_screens_list[hex2num(copytext(seed, 19, 20)) % length(GLOB.ipc_screens_list) + 1]

	if(!species_list)
		species_list = GLOB.species_list

	var/species = species_list[hex2num(copytext(seed, 3, 4)) % length(species_list) + 1]
	set_species(species)
