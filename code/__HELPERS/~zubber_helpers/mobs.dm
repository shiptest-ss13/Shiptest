/proc/accessory_list_of_key_for_species(key, datum/species/S, mismatched, ckey)
	var/list/accessory_list = list()
	var/list/cached_global_list = GLOB.sprite_accessories
	for(var/name in cached_global_list[key])
		var/datum/sprite_accessory/SP = cached_global_list[key][name]
		if(!mismatched && (!(SP.bodytypes & S.bodytype) || (SP.recommended_species && !(S.id in SP.recommended_species))))
			continue
		if(SP.ckey_whitelist && !SP.ckey_whitelist[ckey])
			continue
		accessory_list += SP.name
	return accessory_list


/proc/random_accessory_of_key_for_species(key, datum/species/S, mismatched=FALSE, ckey)
	var/list/accessory_list = accessory_list_of_key_for_species(key, S, mismatched, ckey)
	var/datum/sprite_accessory/SP
	if(length(accessory_list))
		SP = GLOB.sprite_accessories[key][pick(accessory_list)]
	// Try and default the choice to "None" if nothing was found
	if(!SP)
		SP = GLOB.sprite_accessories[key]["None"]
	if(!SP)
		CRASH("Cant find random accessory of [key] key, for species [S.id]")
	return SP

/proc/assemble_body_markings_from_set(datum/body_marking_set/BMS, list/features, datum/species/pref_species)
	var/list/body_markings = list()
	for(var/set_name in BMS.body_marking_list)
		var/datum/body_marking/BM = GLOB.body_markings[set_name]
		for(var/zone in GLOB.body_markings_per_limb)
			var/list/marking_list = GLOB.body_markings_per_limb[zone]
			if(set_name in marking_list)
				if(!body_markings[zone])
					body_markings[zone] = list()
				body_markings[zone][set_name] = BM.get_default_color(features, pref_species)
	return body_markings

/proc/marking_list_of_zone_for_species(zone, datum/species/species, mismatched = FALSE)
	if(mismatched)
		return GLOB.body_markings_per_limb[zone].Copy()
	var/list/compiled_list = list()
	var/list/global_list_cache = GLOB.body_markings_per_limb[zone]
	var/list/global_lookup_cache = GLOB.body_markings
	for(var/name in global_list_cache)
		var/datum/body_marking/body_marking = global_lookup_cache[name]
		if(!(body_marking.bodytypes & species.bodytype) || (body_marking.recommended_species && !(species.id in body_marking.recommended_species)))
			continue
		compiled_list[name] = body_marking
	return compiled_list

/proc/marking_sets_for_species(datum/species/species, mismatched = FALSE)
	if(mismatched)
		return GLOB.body_marking_sets.Copy()
	var/list/compiled_list = list()
	var/list/global_list_cache = GLOB.body_marking_sets
	for(var/name in global_list_cache)
		var/datum/body_marking_set/marking_set = global_list_cache[name]
		if(!(marking_set.bodytypes & species.bodytype) || (marking_set.recommended_species && !(species.id in marking_set.recommended_species)))
			continue
		compiled_list[name] = marking_set
	return compiled_list

/proc/hairstyle_list_for_species(datum/species/species, gender, mismatched = FALSE)
	if(mismatched)
		return GLOB.hairstyles_list.Copy()
	var/list/global_list_cache
	switch(gender)
		if(MALE)
			global_list_cache = GLOB.hairstyles_male_list
		if(FEMALE)
			global_list_cache = GLOB.hairstyles_female_list
		else
			global_list_cache = GLOB.hairstyles_list
	var/list/global_list_lookup = GLOB.hairstyles_list
	var/list/compiled_list = list()
	for(var/name in global_list_cache)
		var/datum/sprite_accessory/accessory = global_list_lookup[name]
		if(!(accessory.bodytypes & species.bodytype))
			continue
		compiled_list += accessory.name
	return compiled_list

/proc/facial_hairstyle_list_for_species(datum/species/species, gender, mismatched = FALSE)
	if(mismatched)
		return GLOB.facial_hairstyles_list.Copy()
	var/list/global_list_cache
	switch(gender)
		if(MALE)
			global_list_cache = GLOB.facial_hairstyles_male_list
		if(FEMALE)
			global_list_cache = GLOB.facial_hairstyles_female_list
		else
			global_list_cache = GLOB.facial_hairstyles_list
	var/list/global_list_lookup = GLOB.facial_hairstyles_list
	var/list/compiled_list = list()
	for(var/name in global_list_cache)
		var/datum/sprite_accessory/accessory = global_list_lookup[name]
		if(!(accessory.bodytypes & species.bodytype))
			continue
		compiled_list += accessory.name
	return compiled_list

/proc/underwear_list_for_species(datum/species/species, gender, mismatched = FALSE)
	if(mismatched)
		return GLOB.underwear_list.Copy()
	var/list/global_list_cache = GLOB.underwear_list
	var/list/compiled_list = list()
	for(var/name in global_list_cache)
		var/datum/sprite_accessory/accessory = global_list_cache[name]
		if(!(accessory.bodytypes & species.bodytype))
			continue
		compiled_list += accessory.name
	return compiled_list

/proc/undershirt_list_for_species(datum/species/species, gender, mismatched = FALSE)
	if(mismatched)
		return GLOB.undershirt_list.Copy()
	var/list/global_list_cache  = GLOB.undershirt_list
	var/list/compiled_list = list()
	for(var/name in global_list_cache)
		var/datum/sprite_accessory/accessory = global_list_cache[name]
		if(!(accessory.bodytypes & species.bodytype))
			continue
		compiled_list += accessory.name
	return compiled_list

/proc/socks_list_for_species(datum/species/species, mismatched = FALSE)
	if(mismatched)
		return GLOB.socks_list.Copy()
	var/list/global_list_cache = GLOB.socks_list
	var/list/compiled_list = list()
	for(var/name in global_list_cache)
		var/datum/sprite_accessory/accessory = global_list_cache[name]
		if(!(accessory.bodytypes & species.bodytype))
			continue
		compiled_list += accessory.name
	return compiled_list

/proc/prefix_a_or_an(text)
	var/start = lowertext(text[1])
	if(!start)
		return "a"
	if(start == "a" || start == "e" || start == "i" || start == "o" || start == "u")
		return "an"
	else
		return "a"
