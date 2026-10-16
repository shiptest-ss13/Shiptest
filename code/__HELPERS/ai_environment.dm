// Helpers for AI working out where it can stand without the air, heat or cold hurting it

/proc/is_environment_safe_for(mob/living/basic/basic_mob, turf/spot)
	return isnull(get_environment_hazard(basic_mob, spot))

/proc/get_environment_hazard(mob/living/basic/basic_mob, turf/spot)
	if(!isopenturf(spot))
		return AI_ENVIRONMENT_UNBREATHABLE
	var/turf/open/open_spot = spot
	var/datum/gas_mixture/air = open_spot.air
	var/mob/living/basic/human/human_mob = basic_mob
	if(istype(human_mob) && !human_mob.pressure_sealed && (air ? air.return_pressure() : 0) < HAZARD_LOW_PRESSURE)
		return AI_ENVIRONMENT_UNBREATHABLE
	var/list/needs = basic_mob.habitable_atmos
	if(basic_mob.unsuitable_atmos_damage && length(needs))
		if(!air)
			if(needs["min_oxy"] || needs["min_tox"] || needs["min_plas"] || needs["min_n2"] || needs["min_co2"])
				return AI_ENVIRONMENT_UNBREATHABLE
		else
			var/static/list/gas_by_need = list("oxy" = GAS_O2, "plas" = GAS_PLASMA, "tox" = GAS_PLASMA, "n2" = GAS_N2, "co2" = GAS_CO2)
			for(var/gas_name in gas_by_need)
				var/moles = air.get_moles(gas_by_need[gas_name])
				var/minimum = needs["min_[gas_name]"]
				var/maximum = needs["max_[gas_name]"]
				if((minimum && moles < minimum) || (maximum && moles > maximum))
					return AI_ENVIRONMENT_UNBREATHABLE
	var/temperature = air ? air.return_temperature() : TCMB // no air at all is vacuum, as cold as space
	if(basic_mob.unsuitable_cold_damage && temperature < basic_mob.minimum_survivable_temperature)
		return AI_ENVIRONMENT_TOO_COLD
	if(basic_mob.unsuitable_heat_damage && temperature > basic_mob.maximum_survivable_temperature)
		return AI_ENVIRONMENT_TOO_HOT
	return null

/proc/ai_can_stand_on(mob/living/mover, turf/spot)
	if(is_bare_space(spot) && !mover.ai_controller?.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE])
		return FALSE
	if(is_ai_hazard_turf(spot))
		return FALSE
	var/mob/living/basic/basic_mover = mover
	return !istype(basic_mover) || is_environment_safe_for(basic_mover, spot)

/proc/is_bare_space(turf/spot)
	return isspaceturf(spot) && !(locate(/obj/structure/lattice) in spot)

/proc/is_ai_hazard_turf(turf/spot)
	if(istype(spot, /turf/open/chasm))
		return !HAS_TRAIT(spot, TRAIT_CHASM_STOPPED)
	if(istype(spot, /turf/open/lava))
		var/turf/open/lava/lava_spot = spot
		return !lava_spot.is_safe()
	return FALSE
