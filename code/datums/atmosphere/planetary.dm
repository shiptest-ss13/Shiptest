// Atmos types used for planetary airs
/datum/atmosphere/lavaland
	id = LAVALAND_DEFAULT_ATMOS

	base_gases = list(
		GAS_O2=5,
		GAS_N2=10,
	)
	normal_gases = list(
		GAS_O2=10,
		GAS_N2=10,
		GAS_CO2=10,
	)
	restricted_gases = list(
		GAS_BZ=10,
		GAS_PLASMA=0.1,
		GAS_H2O=0.1,
	)
	restricted_chance = 50

	minimum_pressure = WARNING_LOW_PRESSURE + 10
	maximum_pressure = LAVALAND_EQUIPMENT_EFFECT_PRESSURE - 1

	// temperature range USED to be 100-140 C. this was bad, because
	// fires start at 100C; occasionally, there would be a perma-plasmafire, too tiny to notice.
	// even worse, occasionally there would be a perma-TRITFIRE, if oxygen
	// concentration was high enough. this caused a bunch of lag and added nothing to the game whatsoever
	// thus, the temperatures were reduced to 70-90 C
	minimum_temp = T20C + 50
	maximum_temp = T20C + 70

/datum/atmosphere/icemoon
	id = ICEMOON_DEFAULT_ATMOS

	base_gases = list(
		GAS_O2=5,
		GAS_N2=10,
	)
	normal_gases = list(
		GAS_O2=10,
		GAS_N2=10,
		GAS_CO2=10,
	)
	restricted_gases = list(
		GAS_PLASMA=0.1,
		GAS_H2O=0.1,
	)
	restricted_chance = 50

	minimum_pressure = HAZARD_LOW_PRESSURE + 10
	maximum_pressure = LAVALAND_EQUIPMENT_EFFECT_PRESSURE - 1

	minimum_temp = 180
	maximum_temp = 180

/datum/atmosphere/gas_giant
	id = GAS_GIANT_ATMOS

	base_gases = list(
		GAS_N2=10,
		GAS_NITROUS=10,
	)
	normal_gases = list(
		GAS_O2=5,
		GAS_H2O=7,
		GAS_N2=5,
		GAS_NITROUS=7,
		GAS_CO2=5,
	)
	restricted_gases = list(
		GAS_NITROUS=7,
	)
	restricted_chance = 1

	minimum_pressure = WARNING_HIGH_PRESSURE + 175
	maximum_pressure = HAZARD_HIGH_PRESSURE + 1000

	minimum_temp = 30 //number i pulled out of my ass
	maximum_temp = 120

/datum/atmosphere/gas_giant/plasma
	id = PLASMA_GIANT_ATMOS

	base_gases = list(
		GAS_PLASMA=10,
	)
	normal_gases = list(
		GAS_PLASMA=10,
		GAS_CO2=5,
	)
	restricted_gases = list(
		GAS_PLASMA=0.1,
	)
	restricted_chance = 1

/datum/atmosphere/wasteplanet
	id = WASTEPLANET_DEFAULT_ATMOS


	base_gases = list(
		GAS_O2=7,
		GAS_N2=10,
	)
	normal_gases = list(
		GAS_O2=7,
		GAS_O2=3,
		GAS_N2=5,
		GAS_N2=2
	)
	restricted_gases = list(
		GAS_H2O=1,
	)
	restricted_chance = 10

	minimum_pressure = ONE_ATMOSPHERE - 30
	maximum_pressure = ONE_ATMOSPHERE + 100

	minimum_temp = T20C + 1
	maximum_temp = T20C + 80
