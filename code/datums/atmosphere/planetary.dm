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
	// thus, the temperatures were reduced to 70-99 C
	minimum_temp = T20C + 50
	maximum_temp = T20C + 79

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

