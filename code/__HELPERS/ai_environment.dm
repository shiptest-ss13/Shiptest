// Helpers for AI working out where it can stand without the air, heat or cold hurting it

/proc/is_environment_safe_for(mob/living/basic/basic_mob, turf/spot)
	if(!isopenturf(spot))
		return FALSE
	var/turf/open/open_spot = spot
	var/datum/gas_mixture/air = open_spot.air
	var/temperature = air ? air.return_temperature() : TCMB // no air at all is vacuum, as cold as space
	if(basic_mob.unsuitable_cold_damage && temperature < basic_mob.minimum_survivable_temperature)
		return FALSE
	if(basic_mob.unsuitable_heat_damage && temperature > basic_mob.maximum_survivable_temperature)
		return FALSE
	var/list/needs = basic_mob.habitable_atmos
	if(!basic_mob.unsuitable_atmos_damage || !length(needs))
		return TRUE
	if(!air)
		return !(needs["min_oxy"] || needs["min_tox"] || needs["min_plas"] || needs["min_n2"] || needs["min_co2"])
	var/static/list/gas_by_need = list("oxy" = GAS_O2, "plas" = GAS_PLASMA, "tox" = GAS_PLASMA, "n2" = GAS_N2, "co2" = GAS_CO2)
	for(var/gas_name in gas_by_need)
		var/moles = air.get_moles(gas_by_need[gas_name])
		var/minimum = needs["min_[gas_name]"]
		var/maximum = needs["max_[gas_name]"]
		if((minimum && moles < minimum) || (maximum && moles > maximum))
			return FALSE
	return TRUE
