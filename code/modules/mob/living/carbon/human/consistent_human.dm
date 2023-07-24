/mob/living/carbon/human/dummy/consistent/setup_human_dna()
	create_dna()
	return //No randomisation

/mob/living/carbon/human/dummy/consistent/proc/seeded_randomization(seed = 0)
	gender = list(MALE, FEMALE)[seed % 2 + 1]
	skin_tone = GLOB.skin_tones[seed % length(GLOB.skin_tones) + 1]
	hairstyle = GLOB.hairstyles_list[seed % length(GLOB.hairstyles_list) + 1]
	hair_color = color_natural_from_seed(seed)
	eye_color = short_color_from_seed(seed)

	// Mutant randomizing, doesn't affect the mob appearance unless it's the specific mutant.
	dna.features["mcolor"] = short_color_from_seed(seed * 2)
	dna.features["mcolor2"] = short_color_from_seed(seed * 3)
	//AAAAAAAAAAAAAAAAAAAAAAAAAA
	dna.features["ethcolor"] = GLOB.color_list_ethereal[GLOB.color_list_ethereal[seed % length(GLOB.color_list_ethereal) + 1]]
	dna.features["tail_lizard"] = GLOB.tails_list_lizard[seed % length(GLOB.tails_list_lizard) + 1]
	dna.features["snout"] = GLOB.snouts_list[seed % length(GLOB.snouts_list) + 1]
	dna.features["horns"] = GLOB.horns_list[seed % length(GLOB.horns_list) + 1]
	dna.features["frills"] = GLOB.frills_list[seed % length(GLOB.frills_list) + 1]
	dna.features["spines"] = GLOB.spines_list[seed % length(GLOB.spines_list) + 1]
	dna.features["body_markings"] = GLOB.body_markings_list[seed % length(GLOB.body_markings_list) + 1]
	dna.features["moth_wings"] = GLOB.moth_wings_list[seed % length(GLOB.moth_wings_list) + 1]
	dna.features["moth_fluff"] = GLOB.moth_fluff_list[seed % length(GLOB.moth_fluff_list) + 1]
	dna.features["spider_legs"] = GLOB.spider_legs_list[seed % length(GLOB.spider_legs_list) + 1]
	dna.features["spider_spinneret"] = GLOB.spider_spinneret_list[seed % length(GLOB.spider_spinneret_list) + 1]
	dna.features["spider_mandibles"] = GLOB.spider_mandibles_list[seed % length(GLOB.spider_mandibles_list) + 1]
	dna.features["squid_face"] = GLOB.squid_face_list[seed % length(GLOB.squid_face_list) + 1]
	dna.features["kepori_feathers"] = GLOB.kepori_feathers_list[seed % length(GLOB.kepori_feathers_list) + 1]
	dna.features["kepori_body_feathers"] = GLOB.kepori_body_feathers_list[seed % length(GLOB.kepori_body_feathers_list) + 1]
	dna.features["vox_head_quills"] = GLOB.vox_head_quills_list[seed % length(GLOB.vox_head_quills_list) + 1]
	dna.features["vox_neck_quills"] = GLOB.vox_neck_quills_list[seed % length(GLOB.vox_neck_quills_list) + 1]
	dna.features["elzu_horns"] = GLOB.elzu_horns_list[seed % length(GLOB.elzu_horns_list) + 1]
	dna.features["tail_elzu"] = GLOB.tails_list_elzu[seed % length(GLOB.tails_list_elzu) + 1]
	dna.features["ipc_chassis"] = GLOB.ipc_chassis_list[seed % length(GLOB.ipc_chassis_list) + 1]
	dna.features["ipc_screen"] = GLOB.ipc_screens_list[seed % length(GLOB.ipc_screens_list) + 1]

	update_body()
	update_hair()
