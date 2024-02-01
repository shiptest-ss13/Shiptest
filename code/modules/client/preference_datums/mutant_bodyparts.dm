

/datum/preference/mutant_bodypart
	abstract_type = /datum/preference/mutant_bodypart

	pref_type = PREFERENCE_CHARACTER

	var/list/global_accessory_list

	var/sprite_accessory_type
	// ! should verify that this is unique?
	// the value actually added to the dna.features list
	var/feature_name

	// ! maybe a way of distinguishing between types with "None" available and types without it? at the moment, that seems to be a property of the sprite accessory.
	// ! it's important that the default value reflect something sane, and of course, be in range... unit tests for default values like that? hm.
	// ! the downside of hard-coding in a valid default is that occasionally the default really meaningfully IS NOT valid, and an "invalid" default will cause runtimes.
	// ! but of course the default being valid is UTTERLY necessary for the preference graph to stay correct.

/datum/preference/mutant_bodypart/New(...)
	. = ..()
	global_accessory_list = get_accessory_list()
	if(!global_accessory_list.len)
		init_sprite_accessory_subtypes(sprite_accessory_type, global_accessory_list)
	// ! unit test?
	if(!(default_value in global_accessory_list))
		CRASH("[type] had invalid default value [default_value]!")

/datum/preference/mutant_bodypart/proc/get_accessory_list()
	RETURN_TYPE(/list)
	#warn should throw an error probably


/datum/preference/mutant_bodypart/_is_available(list/dependency_data)
	#warn impl
	return TRUE

/datum/preference/mutant_bodypart/_is_invalid(data, list/dependency_data)
	return !(data in global_accessory_list)

/datum/preference/mutant_bodypart/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features[feature_name] = value
	// ! note that this causes problems if the value set is "None", though this is in line with previous behavior which did not bother to check
	// ! after all, mutant_bodyparts is just a list of hints to handle_mutant_bodyparts, which does its own shit to determine whether or not different parts should render
	// ! if i'm going to be reworking mutant bodyparts, i could arguably remove this shit entirely
	target.dna.species.mutant_bodyparts |= feature_name

/datum/preference/mutant_bodypart/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	var/new_selection
	new_selection = input(user, "Choose your [name]:", "Character Preference") as null|anything in global_accessory_list
	if(new_selection)
		return new_selection
	return old_data

// ! These will need to be given functioning dependencies (and, obviously, squid faces will need to be removed).
// ! Additionally, external_key and feature_name might need to be merged. But because feature_name has external significance, maybe not?

/datum/preference/mutant_bodypart/body_markings
	name = "Body Markings"
	external_key = "feature_lizard_body_markings"

	feature_name = "body_markings"
	default_value = "None"
	sprite_accessory_type = /datum/sprite_accessory/body_markings

/datum/preference/mutant_bodypart/body_markings/get_accessory_list()
	return GLOB.body_markings_list


/datum/preference/mutant_bodypart/face_markings
	name = "Face Markings"
	external_key = "feature_lizard_face_markings"

	feature_name = "face_markings"
	default_value = "None"
	sprite_accessory_type = /datum/sprite_accessory/face_markings

/datum/preference/mutant_bodypart/face_markings/get_accessory_list()
	return GLOB.face_markings_list


/datum/preference/mutant_bodypart/squid_face
	name = "Squid Face"
	external_key = "feature_squid_face"

	feature_name = "squid_face"
	default_value = "Squidward"
	sprite_accessory_type = /datum/sprite_accessory/squid_face

/datum/preference/mutant_bodypart/squid_face/get_accessory_list()
	return GLOB.squid_face_list


/datum/preference/mutant_bodypart/spider_legs
	name = "Spider Legs"
	external_key = "feature_spider_legs"

	feature_name = "spider_legs"
	default_value = "Plain"
	sprite_accessory_type = /datum/sprite_accessory/spider_legs

/datum/preference/mutant_bodypart/spider_legs/get_accessory_list()
	return GLOB.spider_legs_list


/datum/preference/mutant_bodypart/spider_spinneret
	name = "Spider Spinneret"
	external_key = "feature_spider_spinneret"

	feature_name = "spider_spinneret"
	default_value = "Plain"
	sprite_accessory_type = /datum/sprite_accessory/spider_spinneret

/datum/preference/mutant_bodypart/spider_spinneret/get_accessory_list()
	return GLOB.spider_spinneret_list


/datum/preference/mutant_bodypart/spider_mandibles
	name = "Spider Mandibles"
	external_key = "feature_spider_mandibles"

	feature_name = "spider_mandibles"
	default_value = "Plain"
	sprite_accessory_type = /datum/sprite_accessory/spider_mandibles

/datum/preference/mutant_bodypart/spider_mandibles/get_accessory_list()
	return GLOB.spider_mandibles_list


/datum/preference/mutant_bodypart/moth_markings
	name = "Moth Markings"
	external_key = "feature_moth_markings"

	feature_name = "moth_markings"
	default_value = "None"
	sprite_accessory_type = /datum/sprite_accessory/moth_markings

/datum/preference/mutant_bodypart/moth_markings/get_accessory_list()
	return GLOB.moth_markings_list


/datum/preference/mutant_bodypart/moth_fluff
	name = "Moth Fluff"
	external_key = "feature_moth_fluff"

	feature_name = "moth_fluff"
	default_value = "Plain"
	sprite_accessory_type = /datum/sprite_accessory/moth_fluff

/datum/preference/mutant_bodypart/moth_fluff/get_accessory_list()
	return GLOB.moth_fluff_list


/datum/preference/mutant_bodypart/kepori_feathers
	name = "Kepori Feathers"
	external_key = "feature_kepori_feathers"

	feature_name = "kepori_feathers"
	default_value = "None"
	sprite_accessory_type = /datum/sprite_accessory/kepori_feathers

/datum/preference/mutant_bodypart/kepori_feathers/get_accessory_list()
	return GLOB.kepori_feathers_list


/datum/preference/mutant_bodypart/kepori_body_feathers
	name = "Kepori Body Feathers"
	external_key = "feature_kepori_body_feathers"

	feature_name = "kepori_body_feathers"
	default_value = "None"
	sprite_accessory_type = /datum/sprite_accessory/kepori_body_feathers

/datum/preference/mutant_bodypart/kepori_body_feathers/get_accessory_list()
	return GLOB.kepori_body_feathers_list


/datum/preference/mutant_bodypart/kepori_tail_feathers
	name = "Kepori Tail Feathers"
	external_key = "feature_kepori_tail_feathers"

	feature_name = "kepori_tail_feathers"
	default_value = "Fan"
	sprite_accessory_type = /datum/sprite_accessory/kepori_tail_feathers

/datum/preference/mutant_bodypart/kepori_tail_feathers/get_accessory_list()
	return GLOB.kepori_tail_feathers_list


/datum/preference/mutant_bodypart/vox_head_quills
	name = "Vox Head Quills"
	external_key = "feature_vox_head_quills"

	feature_name = "vox_head_quills"
	default_value = "None"
	sprite_accessory_type = /datum/sprite_accessory/vox_head_quills

/datum/preference/mutant_bodypart/vox_head_quills/get_accessory_list()
	return GLOB.vox_head_quills_list


/datum/preference/mutant_bodypart/vox_neck_quills
	name = "Vox Neck Quills"
	external_key = "feature_vox_neck_quills"

	feature_name = "vox_neck_quills"
	default_value = "Plain"
	sprite_accessory_type = /datum/sprite_accessory/vox_neck_quills

/datum/preference/mutant_bodypart/vox_neck_quills/get_accessory_list()
	return GLOB.vox_neck_quills_list


/datum/preference/mutant_bodypart/elzu_horns
	name = "Elzu Horns"
	external_key = "feature_elzu_horns"

	feature_name = "elzu_horns"
	default_value = "None"
	sprite_accessory_type = /datum/sprite_accessory/elzu_horns

/datum/preference/mutant_bodypart/elzu_horns/get_accessory_list()
	return GLOB.elzu_horns_list


/datum/preference/mutant_bodypart/ipc_antenna
	name = "IPC Antennae"
	external_key = "feature_ipc_antenna"

	feature_name = "ipc_antenna"
	default_value = "None"
	sprite_accessory_type = /datum/sprite_accessory/ipc_antennas

/datum/preference/mutant_bodypart/ipc_antenna/get_accessory_list()
	return GLOB.ipc_antennas_list

// ! IPC screens have an associated "change screen" action and some on-death information. that deserves its own attention

