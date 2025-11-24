/datum/gas/oxygen
	id = GAS_O2
	specific_heat = 30
	molar_mass = 32
	name = "Oxygen"
	oxidation_temperature = T0C - 100 // it checks max of this and fire temperature, so rarely will things spontaneously combust
	breath_alert_info = list(
		not_enough_alert = list(
			alert_category = ALERT_NOT_ENOUGH_OXYGEN,
			alert_type = /atom/movable/screen/alert/not_enough_oxy
		),
		too_much_alert = list(
			alert_category = ALERT_TOO_MUCH_OXYGEN,
			alert_type = /atom/movable/screen/alert/too_much_oxy
		)
	)

/datum/gas/nitrogen
	id = GAS_N2
	specific_heat = 30
	molar_mass = 28
	name = "Nitrogen"
	breath_alert_info = list(
		not_enough_alert = list(
			alert_category = ALERT_NOT_ENOUGH_NITRO,
			alert_type = /atom/movable/screen/alert/not_enough_nitro
		),
		too_much_alert = list(
			alert_category = ALERT_TOO_MUCH_NITRO,
			alert_type = /atom/movable/screen/alert/too_much_nitro
		)
	)

/datum/gas/carbon_monoxide
	id = GAS_CO
	specific_heat = 30
	molar_mass = 28
	name = "Carbon Monoxide"
	breath_results = GAS_CO

	flags = GAS_FLAG_DANGEROUS

	fire_temperature = FIRE_MINIMUM_TEMPERATURE_TO_EXIST
	fire_products = list(GAS_CO2 = 1)
	fire_burn_rate = 2

	fusion_power = 0
	enthalpy = -110500

/datum/gas/carbon_dioxide //what the fuck is this?
	id = GAS_CO2
	specific_heat = 30
	molar_mass = 44
	name = "Carbon Dioxide"
	breath_results = GAS_O2
	breath_alert_info = list(
		not_enough_alert = list(
			alert_category = ALERT_NOT_ENOUGH_CO2,
			alert_type = /atom/movable/screen/alert/not_enough_co2
		),
		too_much_alert = list(
			alert_category = ALERT_TOO_MUCH_CO2,
			alert_type = /atom/movable/screen/alert/too_much_co2
		)
	)
	fusion_power = 3
	enthalpy = -393500

/datum/gas/plasma
	id = GAS_PLASMA
	specific_heat = 200
	molar_mass = 126
	name = "Plasma"
	gas_overlay = "plasma"
	moles_visible = MOLES_GAS_VISIBLE
	flags = GAS_FLAG_DANGEROUS|GAS_FLAG_IRRITANT
	breath_alert_info = list(
		not_enough_alert = list(
			alert_category = "not_enough_tox",
			alert_type = /atom/movable/screen/alert/not_enough_tox
		),
		too_much_alert = list(
			alert_category = "too_much_tox",
			alert_type = /atom/movable/screen/alert/too_much_tox
		)
	)
	fire_burn_rate = PLASMA_BURN_RATE_BASE // named when plasma fires were the only fires, surely
	fire_temperature = FIRE_MINIMUM_TEMPERATURE_TO_EXIST
	fire_products = FIRE_PRODUCT_PLASMA
	enthalpy = FIRE_PLASMA_ENERGY_RELEASED // 3000000, 3 megajoules, 3000 kj

	odor = GAS_ODOR_SMOG
	odor_emotes = TRUE
	odor_power = 10 //extremely toxic

/datum/gas/water_vapor
	id = GAS_H2O
	specific_heat = 75
	molar_mass = 18
	name = "Water Vapor"
	gas_overlay = "water_vapor"
	moles_visible = MOLES_GAS_VISIBLE
	flags = GAS_FLAG_DANGEROUS
	fusion_power = 8
	enthalpy = -285800 // FIRE_HYDROGEN_ENERGY_RELEASED is actually what this was supposed to be
	breath_reagent = /datum/reagent/water

/datum/gas/nitrous_oxide
	id = GAS_NITROUS
	specific_heat = 40
	molar_mass = 44
	name = "Nitrous Oxide"
	gas_overlay = "nitrous_oxide"
	moles_visible = MOLES_GAS_VISIBLE * 2
	flags = GAS_FLAG_DANGEROUS
	fire_products = list(GAS_N2 = 1)
	oxidation_rate = 0.5
	oxidation_temperature = FIRE_MINIMUM_TEMPERATURE_TO_EXIST + 100
	enthalpy = 81600

/datum/gas/tritium
	id = GAS_TRITIUM
	specific_heat = 10
	molar_mass = 6
	name = "Tritium"
	gas_overlay = "tritium"
	moles_visible = MOLES_GAS_VISIBLE
	flags = GAS_FLAG_DANGEROUS
	fusion_power = 1
	fire_products = list(GAS_H2O = 1)
	fire_burn_rate = 2
	fire_radiation_released = 50 // arbitrary number, basically 60 moles of trit burning will just barely start to harm you
	fire_temperature = FIRE_MINIMUM_TEMPERATURE_TO_EXIST - 50

/datum/gas/bz //remove from atmospheres // https://en.wikipedia.org/wiki/3-Quinuclidinyl_benzilate not sure why we have this
	id = GAS_BZ
	specific_heat = 20
	molar_mass = 337
	name = "BZ"
	flags = GAS_FLAG_DANGEROUS
	fusion_power = 8
	enthalpy = FIRE_CARBON_ENERGY_RELEASED // it is a mystery

/datum/gas/ozone
	id = GAS_O3
	specific_heat = 30
	molar_mass = 48
	name = "Ozone"
	gas_overlay = "water_vapor"
	moles_visible = MOLES_GAS_VISIBLE
	color = "#a1a1e6"
	oxidation_temperature = T0C - 100 // it checks max of this and fire temperature, so rarely will things spontaneously combust
	oxidation_rate = 1.5
	enthalpy = 142000

	odor = GAS_ODOR_CHEMICAL
	odor_emotes = TRUE
	odor_power = 1


/datum/gas/argon
	id = GAS_ARGON
	specific_heat = 20
	molar_mass = 40
	name = "Argon"
	gas_overlay = "water_vapor"
	oxidation_rate = -1
	//moles_visible = MOLES_GAS_VISIBLE

/datum/gas/freon
	id = GAS_FREON
	specific_heat = 600
	molar_mass = 408 // 2x plasma + 1x co2 + 1/3x bz
	name = "Freon"
	gas_overlay = "freon"
	moles_visible = MOLES_GAS_VISIBLE *30
	fusion_power = -5

/datum/gas/hydrogen
	id = GAS_HYDROGEN
	specific_heat = 10
	molar_mass = 2
	name = "Hydrogen"
	flags = GAS_FLAG_DANGEROUS
	//moles_visible = MOLES_GAS_VISIBLE
	color = "#ffe"
	fusion_power = 0
	fire_products = list(GAS_H2O = 1)
	fire_burn_rate = 2
	fire_temperature = FIRE_MINIMUM_TEMPERATURE_TO_EXIST - 50

/datum/gas/chlorine
	id = GAS_CHLORINE
	specific_heat = 30
	molar_mass = 69 // yes, really
	name = "Chlorine"
	flags = GAS_FLAG_DANGEROUS|GAS_FLAG_IRRITANT
	moles_visible = MOLES_GAS_VISIBLE * 5
	oxidation_temperature = T0C - 100
	oxidation_rate = 0.5
	gas_overlay = "nitrous_oxide"
	color = "#FFFB89"
	fusion_power = 0

/datum/gas/hydrogen_chloride
	id = GAS_HYDROGEN_CHLORIDE
	specific_heat = 40
	molar_mass = 36
	name = "Hydrogen Chloride"
	flags = GAS_FLAG_DANGEROUS|GAS_FLAG_IRRITANT
	moles_visible = MOLES_GAS_VISIBLE * 2
	gas_overlay = "nitrous_oxide"
	color = "#5bfd45"
	fusion_power = 0
	fire_products = list(GAS_CHLORINE = 1, GAS_H2O = 0.5)
	enthalpy = 63000
	fire_burn_rate = 2
	fire_temperature = FIRE_MINIMUM_TEMPERATURE_TO_EXIST

/datum/gas/sulfur_dioxide
	id = GAS_SO2
	specific_heat = 22
	molar_mass = 64
	name = "Sulfur Dioxide"
	flags = GAS_FLAG_DANGEROUS|GAS_FLAG_IRRITANT
	moles_visible = MOLES_GAS_VISIBLE * 60
	gas_overlay = "generic"
	color = "#d4cb28"
	enthalpy = -296800

	odor = GAS_ODOR_SULFUR
	odor_emotes = TRUE
	odor_power = 1

/datum/gas/methane
	id = GAS_METHANE
	specific_heat = 35
	molar_mass = 16
	name = "Methane"
	flags = GAS_FLAG_DANGEROUS
	//moles_visible = MOLES_GAS_VISIBLE
	color = "#ffe"
	fusion_power = 0
	fire_products = list(GAS_H2O = 2, GAS_CO2 = 1)
	enthalpy = -74600
	fire_burn_rate = 0.5
	fire_temperature = FIRE_MINIMUM_TEMPERATURE_TO_EXIST - 50

/datum/gas/ammonia
	id = GAS_AMMONIA

	specific_heat = 100 //used as a coolant
	molar_mass = 17
	name = "Ammonia"
	flags = GAS_FLAG_DANGEROUS|GAS_FLAG_IRRITANT
	moles_visible = MOLES_GAS_VISIBLE
	color = "#ffe"
	gas_overlay = "nitrous_oxide"
	fusion_power = 0
	fire_products = list(GAS_N2 = 0.5, GAS_H2O = 1.5)
	enthalpy = -46000
	fire_burn_rate = (4 / 3)

	odor = GAS_ODOR_CHEMICAL
	odor_emotes = TRUE
	odor_power = 3
