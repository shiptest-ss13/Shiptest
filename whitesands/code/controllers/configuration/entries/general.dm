/datum/config_entry/string/metacurrency_name
	config_entry_value = "MetaCoin"

/datum/config_entry/number/whitesands_atmos_moles
	config_entry_value = 103
	integer = FALSE
	min_val = 10
	max_val = 200

/datum/config_entry/keyed_list/whitesands_atmos_mix
	key_mode = KEY_MODE_TEXT
	value_mode = VALUE_MODE_NUM
	lowercase = FALSE
	splitter = " "


/datum/config_entry/keyed_list/whitesands_atmos_mix/ValidateListEntry(key_name, key_value)
	var/list/gas_types = gas_types()
	for (var/type in gas_types)
		var/datum/gas/T = type
		if (initial(T.id) == key_name)
			// even a high pressure zone will be less than 1.5x one atmos
			return key_value > 0 && key_value < 1.5
	return FALSE
