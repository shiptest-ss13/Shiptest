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
			if(ai_needs_to_breathe(basic_mob))
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

// whether basic_mob needs some gas or other in the air, so no air at all hurts it
/proc/ai_needs_to_breathe(mob/living/basic/basic_mob)
	var/list/needs = basic_mob.habitable_atmos
	return basic_mob.unsuitable_atmos_damage && length(needs) && (needs["min_oxy"] || needs["min_tox"] || needs["min_plas"] || needs["min_n2"] || needs["min_co2"])

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

// whether breaking blocker would make our environment unsafe
/proc/breaking_would_vent(mob/living/basic/basic_mob, atom/blocker)
	var/turf/blocker_turf = get_turf(blocker)
	if(!blocker_turf || !is_environment_safe_for(basic_mob, get_turf(basic_mob)))
		return FALSE
	var/list/sides = list()
	if(blocker.flags_1 & ON_BORDER_1)
		var/turf/across = get_step(blocker_turf, blocker.dir)
		if(!across || blocker.CanAtmosPass(across))
			return FALSE // it's not holding back any air
		sides += blocker_turf
		sides += across
	else
		for(var/direction in GLOB.cardinals)
			var/turf/beside = get_step(blocker_turf, direction)
			if(isopenturf(beside) && !blocker.CanAtmosPass(beside))
				sides += beside
	for(var/turf/side as anything in sides)
		if(isopenturf(side) && !is_environment_safe_for(basic_mob, side))
			return TRUE
	return FALSE

// whether vacuum can't hurt us
/proc/ai_unbothered_by_vacuum(atom/movable/mover)
	var/mob/living/basic/basic_mob = mover
	if(!istype(basic_mob))
		return FALSE
	var/mob/living/basic/human/human_mob = basic_mob
	if(istype(human_mob) && !human_mob.pressure_sealed)
		return FALSE
	if(ai_needs_to_breathe(basic_mob))
		return FALSE // needs something to breathe
	return !basic_mob.unsuitable_cold_damage || basic_mob.minimum_survivable_temperature <= TCMB

// whether mover can let the air out, for prying airlocks
/proc/ai_fine_venting(atom/movable/mover, range = 7)
	if(!ai_unbothered_by_vacuum(mover))
		return FALSE
	for(var/mob/living/ally as anything in get_ai_allies_in_range(mover, range))
		if(!ai_unbothered_by_vacuum(ally))
			return FALSE
	return TRUE
