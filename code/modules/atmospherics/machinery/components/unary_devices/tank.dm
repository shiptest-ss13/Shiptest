#define AIR_CONTENTS ((50*ONE_ATMOSPHERE)*(air_contents.return_volume())/(R_IDEAL_GAS_EQUATION*air_contents.return_temperature()))
/obj/machinery/atmospherics/components/unary/tank
	icon = 'icons/obj/atmospherics/pipes/pressure_tank.dmi'
	icon_state = "generic"

	name = "pressure tank"
	desc = "A large vessel containing pressurized gas."

	obj_integrity = 800
	max_integrity = 800
	density = TRUE
	layer = ABOVE_WINDOW_LAYER
	pipe_flags = PIPING_ONE_PER_TURF

	var/volume = 10000 //in liters
	var/gas_type = 0

/obj/machinery/atmospherics/components/unary/tank/New()
	. = ..()
	var/datum/gas_mixture/air_contents = airs[1]
	air_contents.set_volume(volume)
	air_contents.set_temperature(T20C)
	if(gas_type)
		air_contents.set_moles(gas_type, AIR_CONTENTS)
		name = "[name] ([GLOB.gas_data.names[gas_type]])"
	setPipingLayer(piping_layer)

/obj/machinery/atmospherics/components/unary/tank/Initialize(mapload)
	. = ..()
	SSair.start_processing_machine(src, mapload)

/obj/machinery/atmospherics/components/unary/tank/process_atmos()
	var/datum/gas_mixture/air_contents = airs[1]

	//handle melting
	var/current_temp = air_contents.return_temperature()
	if(current_temp > TANK_MELT_TEMPERATURE)
		take_damage(max((current_temp - TANK_MELT_TEMPERATURE), 0), BRUTE, 0)

	//handle external melting
	var/turf/open/current_turf = get_turf(src)
	if(current_turf)
		temperature_expose(current_turf.air, current_turf.air.return_temperature(), current_turf.air.return_pressure())

	update_appearance()


/obj/machinery/atmospherics/components/unary/tank/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	var/datum/gas_mixture/air_contents = airs[1]
	var/tank_temperature = air_contents.return_temperature()
	tank_temperature = ((tank_temperature * 4) + exposed_temperature)/5 //equalize with the air - since this means theres an active fire on the canister's tile
	air_contents.set_temperature(tank_temperature)
	if(exposed_temperature > TANK_MELT_TEMPERATURE)
		take_damage(max((exposed_temperature - TANK_MELT_TEMPERATURE), 0), BURN, 0)
	if(exposed_volume > volume*2) // implosion
		take_damage(max((exposed_volume - TANK_RUPTURE_PRESSURE), 0), BURN, 0)


/obj/machinery/atmospherics/components/unary/tank/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > TANK_MELT_TEMPERATURE) //dont equalize temperature as this would affect atmos balance, we only want fires to be more dangerous
		take_damage(max((exposed_temperature - TANK_MELT_TEMPERATURE), 0), BURN, 0)
	if(exposed_volume > volume*2) // implosion
		take_damage(max((exposed_volume - TANK_RUPTURE_PRESSURE), 0), BURN, 0)

/obj/machinery/atmospherics/components/unary/tank/obj_destruction(damage_flag)
	var/datum/gas_mixture/air_contents = airs[1]
	//Give the gas a chance to build up more pressure through reacting
	air_contents.react(src)
	var/pressure = air_contents.return_pressure()
	var/range = (pressure-TANK_LEAK_PRESSURE)/TANK_FRAGMENT_SCALE
	var/turf/epicenter = get_turf(loc)
	if(range > 2)
		message_admins("[src] ruptured explosively at [ADMIN_VERBOSEJMP(src)], last touched by [get_mob_by_key(fingerprintslast)]!")
		log_admin("[src] ruptured explosively at [ADMIN_VERBOSEJMP(src)], last touched by [get_mob_by_key(fingerprintslast)]!")
		log_bomber(get_mob_by_key(fingerprintslast), "was last key to touch", src, "which ruptured explosively")
		investigate_log("was destroyed.", INVESTIGATE_ATMOS)

		explosion(epicenter, round(range*0.25), round(range*0.5), round(range), round(range*1.5))

		AddComponent(/datum/component/pellet_cloud, /obj/projectile/bullet/shrapnel/hot, round(range))

	var/turf/T = get_turf(src)
	T.assume_air(air_contents)
	air_update_turf()

	density = FALSE
	playsound(src.loc, 'sound/effects/spray.ogg', 10, TRUE, -3)

	return ..()


/obj/machinery/atmospherics/components/unary/tank/air
	icon_state = "grey"
	name = "pressure tank (Air)"

/obj/machinery/atmospherics/components/unary/tank/air/New()
	. = ..()
	var/datum/gas_mixture/air_contents = airs[1]
	air_contents.set_moles(GAS_O2, AIR_CONTENTS * 0.2)
	air_contents.set_moles(GAS_N2, AIR_CONTENTS * 0.8)

/obj/machinery/atmospherics/components/unary/tank/carbon_dioxide
	gas_type = GAS_CO2

/obj/machinery/atmospherics/components/unary/tank/toxins
	icon_state = "orange"
	gas_type = GAS_PLASMA

/obj/machinery/atmospherics/components/unary/tank/fuel
	icon_state = "orange"

/obj/machinery/atmospherics/components/unary/tank/fuel/New()
	. = ..()
	var/datum/gas_mixture/air_contents = airs[1]
	air_contents.set_moles(GAS_O2, AIR_CONTENTS * 0.3)
	air_contents.set_moles(GAS_PLASMA, AIR_CONTENTS * 0.6)

/obj/machinery/atmospherics/components/unary/tank/oxygen
	icon_state = "blue"
	gas_type = GAS_O2

/obj/machinery/atmospherics/components/unary/tank/nitrogen
	icon_state = "red"
	gas_type = GAS_N2
