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
	var/target_pressure = rand(minimum_pressure, maximum_pressure)
	var/pressure_scalar = target_pressure / maximum_pressure
	var/temperature = rand(minimum_temp, maximum_temp)

	var/total_moles = target_pressure * CELL_VOLUME / (temperature * R_IDEAL_GAS_EQUATION)

	var/list/gas_weights = list()
	var/sum

	for(var/gas in base_gases)
		var/to_add = base_gases[gas]
		gas_weights[gas] = to_add
		sum += to_add

	for(var/gas in normal_gases)
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
		var/real_weight = CEILING(gas_weights[gas] / sum * total_moles, 0.1)
		string_builder += "[GLOB.gas_data.ids[gas]]=[real_weight]"
	string_builder += "TEMP=[temperature]"

	gas_string = string_builder.Join(";")
	return

	// First let's set up the gasmix and base gases for this template
	// We make the string from a gasmix in this proc because gases need to calculate their pressure
	var/datum/gas_mixture/gasmix = new
	gasmix.set_temperature(rand(minimum_temp, maximum_temp))
	for(var/i in base_gases)
		gasmix.set_moles(i, base_gases[i])

	// Now let the random choices begin
	var/datum/gas/gastype
	var/amount
	while(gasmix.return_pressure() < target_pressure)
		if(!prob(restricted_chance))
			gastype = pick(normal_gases)
			amount = normal_gases[gastype]
		else
			gastype = pick(restricted_gases)
			amount = restricted_gases[gastype]
			if(gasmix.get_moles(gastype))
				continue

		amount *= rand(50, 200) / 100	// Randomly modifes the amount from half to double the base for some variety
		amount *= pressure_scalar		// If we pick a really small target pressure we want roughly the same mix but less of it all
		amount = CEILING(amount, 0.1)

		gasmix.set_moles(gastype, gasmix.get_moles(gastype) + amount)

	// That last one put us over the limit, remove some of it
	while(gasmix.return_pressure() > target_pressure)
		gasmix.set_moles(gastype, gasmix.get_moles(gastype) - (gasmix.get_moles(gastype) * 0.1))
	gasmix.set_moles(gastype, FLOOR(gasmix.get_moles(gastype), 0.1))
	// Now finally lets make that string
	var/list/gas_string_builder = list()
	for(var/i in gasmix.get_gases())
		gas_string_builder += "[GLOB.gas_data.ids[i]]=[gasmix.get_moles(i)]"
	gas_string_builder += "TEMP=[gasmix.return_temperature()]"
	gas_string = gas_string_builder.Join(";")
