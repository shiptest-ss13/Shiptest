/datum/unit_test/atmospheres

/datum/unit_test/atmospheres/Run()
	for(var/id in SSair.string_mixes)
		var/datum/atmosphere/mix = SSair.string_mixes[id]
		compare(mix)

/datum/unit_test/atmospheres/proc/compare(datum/atmosphere/mix)
	var/max_moles = mix.maximum_pressure * CELL_VOLUME / (mix.minimum_temp * R_IDEAL_GAS_EQUATION)
	var/lowest_sum = get_min_sum(mix)
	var/list/max_possible = list()

	for(var/gas_id in mix.base_gases)
		var/value = mix.base_gases[gas_id]

		max_possible[gas_id] = value / (lowest_sum - value) * max_moles

	for(var/gas_id in mix.normal_gases)
		var/value = mix.normal_gases[gas_id]

		max_possible[gas_id] = value * 2 / (lowest_sum - value * 2) * max_moles

	for(var/gas_id in mix.restricted_gases)
		var/value = mix.restricted_gases[gas_id] * 2

		max_possible[gas_id] += value / lowest_sum * max_moles

	for(var/datum/gas_reaction/reaction as anything in SSair.gas_reactions)
		var/min_temp = reaction.min_requirements["TEMP"] || 0
		var/max_temp = reaction.min_requirements["MAX_TEMP"] || INFINITY

		if(max_temp < mix.minimum_temp)
			continue
		if(min_temp > mix.maximum_temp)
			continue

		var/fire_reagents = reaction.min_requirements["FIRE_REAGENTS"]
		if(fire_reagents)
			var/oxidizer
			var/fuel

			for(var/gas_id in max_possible)
				var/datum/gas/gas = GLOB.gas_data.datums[gas_id]
				if(gas.oxidation_rate > 0 && gas.oxidation_temperature && gas.oxidation_temperature < mix.maximum_temp && max_possible[gas_id] > fire_reagents)
					oxidizer = gas
				if(gas.fire_temperature && gas.fire_temperature < mix.maximum_temp)
					fuel = gas

			if(!oxidizer || !fuel)
				continue

		var/list/reqs = reaction.min_requirements - list("TEMP", "MAX_TEMP", "ENER", "FIRE_REAGENTS")

		//See if the reaction can be done in the worst case scenario mix
		var/real_max_temp = max_temp
		var/remaining_moles = max_moles
		if(real_max_temp > mix.maximum_temp)
			real_max_temp = mix.maximum_temp
			remaining_moles = mix.maximum_pressure * CELL_VOLUME / (real_max_temp * R_IDEAL_GAS_EQUATION)

		var/reacted = TRUE

		var/gas_str = "TEMP=[real_max_temp];"
		for(var/gas_id as anything in reqs)
			if(!(gas_id in max_possible))
				reacted = FALSE
				break
			if(reqs[gas_id] > max_possible[gas_id])
				reacted = FALSE
				break
			if(reqs[gas_id] > remaining_moles)
				reacted = FALSE
				break

			remaining_moles -= reqs[gas_id]
			gas_str += "[gas_id]=[reqs[gas_id]];"

		if(!reacted)
			continue

		var/datum/gas_mixture/remaining = new /datum/gas_mixture
		remaining.parse_gas_string(gas_str)

		if(reaction.react(remaining, src.run_loc_bottom_left) != NO_REACTION)
			TEST_FAIL("Reaction \"[reaction]\" could happen in [mix]")
		else
			TEST_NOTICE(src, "Reaction \"[reaction]\"- could get constantly called in [mix]")


/datum/unit_test/atmospheres/proc/get_min_sum(datum/atmosphere/mix)
	. = 0

	for(var/gas_id in mix.base_gases)
		. += mix.base_gases[gas_id]
	for(var/gas_id in mix.normal_gases)
		. += mix.normal_gases[gas_id] * 0.5

	return .
