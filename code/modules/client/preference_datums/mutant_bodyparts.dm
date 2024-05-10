// ! need to deal with "locked" parts

/datum/preference/mutant_bodypart
	abstract_type = /datum/preference/mutant_bodypart

	pref_type = PREFERENCE_CHARACTER

	var/datum/sprite_accessory/mutant_part/mut_part_type
	// ! should verify that this is unique?
	// the value actually added to the dna.features list

	// ! maybe a way of distinguishing between types with "None" available and types without it? at the moment, that seems to be a property of the sprite accessory.
	// ! it's important that the default value reflect something sane, and of course, be in range... unit tests for default values like that? hm.
	// ! the downside of hard-coding in a valid default is that occasionally the default really meaningfully IS NOT valid, and an "invalid" default will cause runtimes.
	// ! but of course the default being valid is UTTERLY necessary for the preference graph to stay correct.

/datum/preference/mutant_bodypart/New(...)
	. = ..()
	// ! unit test?
	// ! test for "locked" mutant bodyparts
	if(!(default_value in GLOB.mut_part_name_datum_lookup[mut_part_type]))
		CRASH("[type] had invalid default value [default_value]!")

#warn impl serialize(), deserialize_validate(), dependencies
/datum/preference/mutant_bodypart/_is_available(list/dependency_data)
	#warn impl
	return TRUE

/datum/preference/mutant_bodypart/_is_invalid(data, list/dependency_data)
	return !(data in GLOB.mut_part_name_datum_lookup[mut_part_type])

/datum/preference/mutant_bodypart/apply_to_human(mob/living/carbon/human/target, value)
	var/part_id = initial(mut_part_type.mutant_string)
	target.dna.features[part_id] = value
	// ! note that this causes some semi-intentional weirdness if the value set is "None", though this is in line with previous behavior which did not bother to check
	// ! after all, mutant_bodyparts is just a list of hints to handle_mutant_bodyparts, which does its own shit to determine whether or not different parts should render
	target.dna.species.mutant_bodyparts |= part_id

/datum/preference/mutant_bodypart/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	var/new_selection
	new_selection = input(user, "Choose your [name]:", "Character Preference") as null|anything in GLOB.mut_part_name_datum_lookup[mut_part_type]
	if(new_selection)
		return new_selection
	return old_data

// ! These will need to be given functioning dependencies (and, obviously, squid faces will need to be removed).
// ! also, ipc tails need to be added

/datum/preference/mutant_bodypart/body_markings
	name = "Body Markings"
	external_key = "feature_lizard_body_markings"

	mut_part_type = /datum/sprite_accessory/mutant_part/body_markings
	default_value = "None"

/datum/preference/mutant_bodypart/face_markings
	name = "Face Markings"
	external_key = "feature_lizard_face_markings"

	mut_part_type = /datum/sprite_accessory/mutant_part/face_markings
	default_value = "None"

/datum/preference/mutant_bodypart/squid_face
	name = "Squid Face"
	external_key = "feature_squid_face"

	mut_part_type = /datum/sprite_accessory/mutant_part/squid_face
	default_value = "Squidward"

/datum/preference/mutant_bodypart/spider_legs
	name = "Spider Legs"
	external_key = "feature_spider_legs"

	mut_part_type = /datum/sprite_accessory/mutant_part/spider_legs
	default_value = "Plain"

/datum/preference/mutant_bodypart/spider_spinneret
	name = "Spider Spinneret"
	external_key = "feature_spider_spinneret"

	mut_part_type = /datum/sprite_accessory/mutant_part/spider_spinneret
	default_value = "Plain"

/datum/preference/mutant_bodypart/moth_markings
	name = "Moth Markings"
	external_key = "feature_moth_markings"

	mut_part_type = /datum/sprite_accessory/mutant_part/moth_markings
	default_value = "None"

/datum/preference/mutant_bodypart/moth_fluff
	name = "Moth Fluff"
	external_key = "feature_moth_fluff"

	mut_part_type = /datum/sprite_accessory/mutant_part/moth_fluff
	default_value = "Plain"

/datum/preference/mutant_bodypart/kepori_feathers
	name = "Kepori Feathers"
	external_key = "feature_kepori_feathers"

	mut_part_type = /datum/sprite_accessory/mutant_part/kepori_feathers
	default_value = "None"

/datum/preference/mutant_bodypart/kepori_body_feathers
	name = "Kepori Body Feathers"
	external_key = "feature_kepori_body_feathers"

	mut_part_type = /datum/sprite_accessory/mutant_part/kepori_body_feathers
	default_value = "None"

/datum/preference/mutant_bodypart/kepori_tail_feathers
	name = "Kepori Tail Feathers"
	external_key = "feature_kepori_tail_feathers"

	mut_part_type = /datum/sprite_accessory/mutant_part/kepori_tail_feathers
	default_value = "Fan"

/datum/preference/mutant_bodypart/vox_head_quills
	name = "Vox Head Quills"
	external_key = "feature_vox_head_quills"

	mut_part_type = /datum/sprite_accessory/mutant_part/vox_head_quills
	default_value = "None"

/datum/preference/mutant_bodypart/vox_neck_quills
	name = "Vox Neck Quills"
	external_key = "feature_vox_neck_quills"

	mut_part_type = /datum/sprite_accessory/mutant_part/vox_neck_quills
	default_value = "Plain"

/datum/preference/mutant_bodypart/elzu_horns
	name = "Elzu Horns"
	external_key = "feature_elzu_horns"

	mut_part_type = /datum/sprite_accessory/mutant_part/elzu_horns
	default_value = "None"

/datum/preference/mutant_bodypart/ipc_antenna
	name = "IPC Antennae"
	external_key = "feature_ipc_antenna"

	mut_part_type = /datum/sprite_accessory/mutant_part/ipc_antennas
	default_value = "None"

// ! IPC screens have an associated "change screen" action and some on-death information. that deserves its own attention

