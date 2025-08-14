/// Get the atom's armor reference
/atom/proc/get_armor()
	RETURN_TYPE(/datum/armor)
	return (armor)

/// Helper to get a specific rating for the atom's armor
/atom/proc/get_armor_rating(damage_type)
	var/datum/armor/armor = get_armor()
	return armor.getRating(damage_type)
