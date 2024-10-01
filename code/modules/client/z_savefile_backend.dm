#warn this file is unfinished and, right now, unnecessary. either rework it or get the fuck out!!!
/*
#warn document everything here -- all vars, procs, types
#warn maybe there should be a way of removing key-value pairs? hm. alternatively, pruning unnecessary entries can be done after updating, as a final pass for things unrecognized and not updated
#warn the cacheing shit is also a huge fucking mess... i really should just use /tg/'s json_savefile s
/datum/save_backend
	var/ckey

	var/use_cache = TRUE

	// ! make sure they know to set these!!!
	VAR_PROTECTED/acc_cache_loaded = FALSE
	VAR_PRIVATE/list/acc_values_cache = list()

	VAR_PROTECTED/char_cache_loaded = list()
	VAR_PRIVATE/list/list/char_values_cache = list()


/datum/save_backend/New(_ckey)
	if(use_cache)
		for(var/i in 1 to MAX_SAVE_SLOTS)
			char_cache_loaded += FALSE
			// double-wrapped list because of how byond's list addition works. don't worry, this only adds the one list
			char_values_cache += list(list())

	ckey = _ckey

/datum/save_backend/proc/prepare_save()
	#warn implement
	return
	// if(!has_entry())
	// 	// check for original /savefile at the original path, port its values over, and save, including every character
	// 	return
	// return
	// // get the save data and port it to a new version if necessary: update entries by operating directly on the key-value pairs

#warn remove; caches effectively make it redundant.
/datum/save_backend/proc/get_values(p_type, num)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!use_cache)
		return _get_values(p_type, num)

	switch(p_type)
		if(PREFERENCE_ACCOUNT)
			if(!acc_cache_loaded)
				acc_values_cache = _get_values(p_type, num)
				acc_cache_loaded = TRUE
			return acc_values_cache

		if(PREFERENCE_CHARACTER)
			if(!char_cache_loaded[num])
				char_values_cache[num] = _get_values(p_type, num)
				char_cache_loaded[num] = TRUE
			return char_values_cache[num]

/datum/save_backend/proc/get_value(p_type, num, key)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!use_cache)
		return _get_value(p_type, num, key)

	switch(p_type)
		if(PREFERENCE_ACCOUNT)
			if(!(key in acc_values_cache))
				// if the data has been loaded "properly", we don't want to stuff the cache
				// with a key with null data, when the key doesn't actually exist in the save itself
				if(acc_cache_loaded)
					return null
				acc_values_cache[key] = _get_value(p_type, num, key)
			return acc_values_cache[key]

		if(PREFERENCE_CHARACTER)
			if(!(key in char_values_cache[num]))
				if(char_cache_loaded[num])
					return null
				char_values_cache[num][key] = _get_value(p_type, num, key)
			return char_values_cache[num][key]

/datum/save_backend/proc/write_values(p_type, num, key_val_assoc)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!use_cache)
		return _write_values(p_type, num, key_val_assoc)

	var/write_success = _write_values(p_type, num, key_val_assoc)
	if(!write_success)
		return FALSE

	switch(p_type)
		if(PREFERENCE_ACCOUNT)
			acc_values_cache |= key_val_assoc
		if(PREFERENCE_CHARACTER)
			char_values_cache[num] |= key_val_assoc
	return TRUE


#warn use for save updating, or remove
// note return type bool; document purpose, along with rest.
/datum/save_backend/proc/has_entry()
	PROTECTED_PROC(TRUE)
	SHOULD_CALL_PARENT(FALSE)
	CRASH("Attempted to call an unimplemented has_entry() proc! This proc must be implemented on all subtypes of /datum/save_backend!")

// ! note args -- all take the "p_type", and then optional "num" for the character index. should NEVER return null!!! make that super clear!!! if it ever returns null, it fucks up the cache!!!!
/datum/save_backend/proc/_get_values(p_type, num)
	PROTECTED_PROC(TRUE)
	SHOULD_CALL_PARENT(FALSE)
	RETURN_TYPE(/list)
	CRASH("Attempted to call an unimplemented _get_values() proc! This proc must be implemented on all subtypes of /datum/save_backend!")

/datum/save_backend/proc/_get_value(p_type, num, key)
	PROTECTED_PROC(TRUE)
	SHOULD_CALL_PARENT(FALSE)
	CRASH("Attempted to call an unimplemented _get_value() proc! This proc must be implemented on all subtypes of /datum/save_backend!")

// ! note that the final values are the old values |= the previous values; return type bool
/datum/save_backend/proc/_write_values(p_type, num, key_val_assoc)
	PROTECTED_PROC(TRUE)
	SHOULD_CALL_PARENT(FALSE)
	CRASH("Attempted to call an unimplemented _write_values() proc! This proc must be implemented on all subtypes of /datum/save_backend!")




#warn move this to its own file?
/datum/save_backend/guest

/datum/save_backend/guest/_get_values(...)
	return list()

/datum/save_backend/guest/_get_value(...)
	return null

/datum/save_backend/guest/_write_values(...)
	return TRUE



#warn similar to above -- move? deprecate?
/datum/save_backend/byond_savefile
	use_cache = FALSE

	var/ckey_save_path

/datum/save_backend/byond_savefile/New(_ckey)
	#warn change this to the real path
	ckey_save_path = "data/player_saves___/[_ckey[1]]/[_ckey]/preferences.sav"
	// ckey_save_path = "data/player_saves/[_ckey[1]]/[_ckey]/preferences.sav"
	. = ..()

*/
