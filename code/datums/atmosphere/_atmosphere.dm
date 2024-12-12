/datum/atmosphere
	var/id
	var/gas_string

	var/list/base_gases // A list of gases to always have
	var/list/normal_gases // A list of allowed gases:base_amount
	var/list/restricted_gases // A list of allowed gases like normal_gases but each can only be selected a maximum of one time
	var/restricted_chance = 10 // Chance per iteration to take from restricted gases

	var/minimum_pressure
	var/maximum_pressure

	var/minimum_temp
	var/maximum_temp

/datum/atmosphere/New()
	generate_gas_string()

/datum/atmosphere/proc/generate_gas_string()
	// Pure randomization
	var/target_pressure = rand(minimum_pressure, maximum_pressure)
	var/temperature = rand(minimum_temp, maximum_temp)

	// This was used in the old method to keep ratios of gases "correct" even at different pressures. I'm not touching it
	var/pressure_scalar = target_pressure / maximum_pressure

	// Get the total moles of gas in each turf, and then distribute the gases based on their weights
	var/total_moles = target_pressure * CELL_VOLUME / (temperature * R_IDEAL_GAS_EQUATION)

	// The weight of each potential gas
	var/list/gas_weights = list()
	// The sum of all the weights, used to normalize them
	var/sum = 0

	for(var/gas in base_gases)
		var/to_add = base_gases[gas]
		gas_weights[gas] = to_add
		sum += to_add

	for(var/gas in normal_gases)
		// 0.5 to 2x the base amount
		var/to_add = normal_gases[gas] * rand(50, 200) / 100 * pressure_scalar
		gas_weights[gas] += to_add
		sum += to_add

	for(var/gas in restricted_gases)
		if(!prob(restricted_chance))
			continue
		var/to_add = restricted_gases[gas] * rand(50, 200) / 100 * pressure_scalar
		gas_weights[gas] += to_add
		sum += to_add

	var/list/string_builder = list()
	for(var/gas in gas_weights)
		// CEIL will make it inaccurate, but prettier
		var/real_weight = CEILING(gas_weights[gas] / sum * total_moles, 0.1)
		string_builder += "[gas]=[real_weight]"
	string_builder += "TEMP=[temperature]"

	gas_string = string_builder.Join(";")
