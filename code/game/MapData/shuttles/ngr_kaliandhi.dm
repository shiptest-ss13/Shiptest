/obj/machinery/air_sensor/atmos/oxygen_tank/kaliandhi
	id_tag = "kali_oxygen_sensor"

/obj/machinery/atmospherics/components/unary/outlet_injector/atmos/oxygen_input/kaliandhi
	id = "kali_oxygen_in"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos/oxygen_output/kaliandhi
	id_tag = "kali_oxygen_out"

/obj/machinery/air_sensor/atmos/nitrogen_tank/kaliandhi
	id_tag = "kali_nitrogen_sensor"

/obj/machinery/atmospherics/components/unary/outlet_injector/atmos/nitrogen_input/kaliandhi
	id = "kali_nitrogen_in"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos/nitrogen_output/kaliandhi
	id_tag = "kali_nitrogen_out"

/obj/machinery/air_sensor/atmos/kali_andhi_hydrogen
	id_tag = "kali_hydrogen_sensor"

/obj/machinery/atmospherics/components/unary/outlet_injector/atmos/kali_andhi_hydrogen
	id = "kali_hydrogen_in"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos/kali_andhi_hydrogen
	id_tag = "kali_hydrogen_out"

/obj/machinery/air_sensor/atmos/kali_andhi_burn
	id_tag = "kali_burn_sensor"


/obj/machinery/computer/atmos_control/tank/nitrogen_tank/kaliandhi
	input_tag = "kali_nitrogen_in"
	output_tag = "kali_nitrogen_out"
	sensors = list("kali_nitrogen_sensor" = "Nitrogen Tank")

/obj/machinery/computer/atmos_control/tank/oxygen_tank/kaliandhi
	input_tag = "kali_oxygen_in"
	output_tag = "kali_oxygen_out"
	sensors = list("kali_oxygen_sensor" = "Oxygen Tank")

/obj/machinery/computer/atmos_control/tank/kali_andhi_hydrogen
	name = "Hydrogen Supply Control"
	input_tag = "kali_hydrogen_in"
	output_tag = "kali_hydrogen_out"
	sensors = list("kali_hydrogen_sensor" = "Hydrogen Tank")

/obj/machinery/computer/atmos_control/kali_andhi_burn
	name = "Burn Chamber Monitoring Console"
	sensors = list("kali_burn_sensor" = "Burn Chamber", "kali_hydrogen_sensor" = "Hydrogen Tank", "kali_oxygen_sensor" = "Oxygen Tank")

/obj/machinery/air_sensor/external/kaliandhi
	id_tag = "kali_external_sensor"

/obj/machinery/computer/atmos_control/external/kaliandhi
	sensors = list("kali_external_sensor" = "External Atmospherics Monitoring")

//teg manual

/obj/item/paper/fluff/ship/kaliandhi/teg
	name = "Generator Manual"
	desc = "A guide left by technicians at a Hardline-operated fleetyard on how to operate the TEG."
	default_raw_text = {"
	The generator on the Mark 3 Kali-Andhi class destroyer is a more complex setup than most other ships. This guide describes solely the way our engineers have deemed to be most effective after fitting out the first ships of the class.
	Skilled engineers are encouraged to make modifications to this configuration as they see fit, but are also encouraged to let their commanding officer know beforehand.

	First, differences. Unlike most generators, the Kali-Andhi's has been fitted with a plasma booster. In layman's terms, this puts a trickle of plasma into the burn system. While this would logically not produce much extra power,
	this setup is in fact incredibly powerful; taking the usual approximately 80kW produced by a pure hydrogen burner on this setup up to 2mW during yard tests.
	The booster is operated through connecting a plasma canister to the port immediately next to the generator (a canister has been issued) and setting the mixer next to it to load about 5% plasma into the loop. It is recommended to lower this to 1% after the generator has reached 2mW production.

	If you slept through enough training days to need to read past the differences, this is the bit you'll want to pay more attention to. First, wander up to the life support room and set the Hydrogen to Generator and Oxygen to Generator pumps up (preferably at max pressure).
	Then, go back down to the generator and set the first mixture to be about 2/3 hydrogen, 1/3 oxygen (about the same mix as the thrusters, at higher pressure, or alternatively go with 1/3 hydrogen 2/3 oxygen if you don't need much power). If you need more than 80kW, set up the plasma booster as instructed prior.
	After doing this, set up the air alarm - set the scrubber in the generator room to scrub out everything but oxygen, hydrogen, and plasma; then open the valve next to the hot side of the generator to exhaust waste gas overboard.
	Finally, hit the igniter and - if everything worked - the generator should start making power. Remember to set up the SMES units according to the ship's needs, and remember that once the plasma canister runs out the mixer connecting it to the fuel mix will need to be reconfigured to account for this and avoid cutting off fuel to the chamber.

	If you have any further questions, contact Hardline Salvage & Mining or your senior officer for advice.
	"}

