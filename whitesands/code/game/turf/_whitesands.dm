
#define WHITESANDS_WALL_ENV "rock"
#define WHITESANDS_SAND_ENV "sand"
#define WHITESANDS_DRIED_ENV "dried_up"
#define WHITESANDS_ATMOS "ws_atmos"

/datum/atmosphere/whitesands
	id = WHITESANDS_ATMOS

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
