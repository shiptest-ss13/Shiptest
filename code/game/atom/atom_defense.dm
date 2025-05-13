/atom
	///any atom that uses integrity and can be damaged must set this to true, otherwise the integrity procs will throw an error

	var/uses_integrity = FALSE

	var/datum/armor/armor
	//TODO: Rename
	var/atom_integrity	//defaults to max_integrity
	var/max_integrity = 500
	var/integrity_failure = 0 //0 if we have no special broken behavior, otherwise is a percentage of at what point the obj breaks. 0.5 being 50%
	///Damage under this value will be completely ignored
	var/damage_deflection = 0

///returns the damage value of the attack after processing the atom's various armor protections
/atom/proc/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir, armour_penetration = 0)
	if(!uses_integrity)
		CRASH("run_atom_armor was called on [src] without being implemented as a type that uses integrity!")
	if(damage_flag == MELEE && damage_amount < damage_deflection)
		return 0
	if(damage_type != BRUTE && damage_type != BURN)
		return 0
	var/armor_protection = 0
	if(damage_flag)
		armor_protection = get_armor_rating(damage_flag)
	if(armor_protection) //Only apply weak-against-armor/hollowpoint effects if there actually IS armor.
		armor_protection = clamp(PENETRATE_ARMOUR(armor_protection, armour_penetration), min(armor_protection, 0), 100)
	return round(damage_amount * (100 - armor_protection) * 0.01, DAMAGE_PRECISION)
