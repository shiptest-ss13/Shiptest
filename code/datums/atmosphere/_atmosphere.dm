/datum/atmosphere
	var/id
	/// The atmosphere's gasmix. No longer a gas string, because params2list sucks.
	/// When auxmos is updated, change this back to a string and use __auxtools_parse_gas_string.
	var/datum/gas_mixture/gasmix

	var/list/base_gases // A list of gases to always have
	var/list/normal_gases // A list of allowed gases:base_amount
	var/list/restricted_gases // A list of allowed gases like normal_gases but each can only be selected a maximum of one time
	var/restricted_chance = 10 // Chance per iteration to take from restricted gases

	var/minimum_pressure
	var/maximum_pressure

	var/minimum_temp
	var/maximum_temp

/datum/atmosphere/New()
	generate_gas()

/datum/atmosphere/proc/generate_gas()
	var/target_pressure = rand(minimum_pressure, maximum_pressure)
	var/pressure_scalar = target_pressure / maximum_pressure

	// First let's set up the gasmix and base gases for this template
	gasmix = new(CELL_VOLUME)
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
	gasmix.mark_immutable()
