GLOBAL_LIST_INIT(hardcoded_gases, list(GAS_O2, GAS_N2, GAS_CO2, GAS_PLASMA)) //the main four gases, which were at one time hardcoded
GLOBAL_LIST_INIT(nonreactive_gases, typecacheof(list(GAS_O2, GAS_N2, GAS_CO2, GAS_CHLORINE, GAS_HYDROGEN_CHLORIDE))) //unable to react amongst themselves

// Auxgm
// It's a send-up of XGM, like what baystation got.
// It's got the same architecture as XGM, but it's structured
// differently to make it more convenient for auxmos.

// Most important compared to TG is that it does away with hardcoded typepaths,
// which lead to problems on the auxmos end anyway. We cache the string value
// references on the Rust end, so no performance is lost here.

// Also allows you to add new gases at runtime

/datum/auxgm
	var/list/datums = list()
	var/list/specific_heats = list()
	var/list/molar_masses = list()
	var/list/names = list()
	var/list/visibility = list()
	var/list/overlays = list()
	var/list/flags = list()
	var/list/ids = list()
	var/list/typepaths = list()
	var/list/fusion_powers = list()
	var/list/breathing_classes = list()
	var/list/breath_results = list()
	var/list/breath_reagents = list()
	var/list/breath_reagents_dangerous = list()
	var/list/breath_alert_info = list()
	var/list/oxidation_temperatures = list()
	var/list/oxidation_rates = list()
	var/list/fire_temperatures = list()
	var/list/enthalpies = list()
	var/list/fire_products = list()
	var/list/fire_burn_rates = list()
	var/list/groups_by_gas = list()
	var/list/groups = list()

/datum/gas
	var/id = ""
	/// heat capacity? thats the only explanation on what this var is
	var/specific_heat = 0
	/// Molar mass, used to calculate specific impulse in certain thrusters
	var/molar_mass = 1
	var/name = ""
	///icon_state in icons/effects/atmospherics.dmi
	var/gas_overlay = "generic"
	/// Tints the overlay by this color. Use instead of gas_overlay, usually (but not necessarily).
	var/color = "#ffff"
	var/moles_visible = null
	///currently used by canisters
	var/flags = NONE
	/// groups for scrubber/filter listing
	var/group = null
	/// How much the gas destabilizes a fusion reaction
	var/fusion_power = 0
	/// what breathing this breathes out
	var/breath_results = GAS_CO2
	/// what breathing this adds to your reagents
	var/datum/reagent/breath_reagent = null
	/// what breathing this adds to your reagents IF it's above a danger threshold
	var/datum/reagent/breath_reagent_dangerous = null
	/// list for alerts that pop up when you have too much/not enough of something
	var/list/breath_alert_info = null
	/// temperature above which this gas is an oxidizer; null for none
	var/oxidation_temperature = null
	/// how much a single mole of this gas can oxidize another mole(s) of gas
	var/oxidation_rate = 1
	/// temperature above which gas may catch fire; null for none
	var/fire_temperature = null
	/// what results when this gas is burned (oxidizer or fuel); null for none
	var/list/fire_products = null
	/// Standard enthalpy of formation in joules, used for fires
	var/enthalpy = 0
	/// how many moles are burned per product released
	var/fire_burn_rate = 1
	/// How much radiation is released when this gas burns
	var/fire_radiation_released = 0
	///a list of odor texts this gas gives, if null or odor_power is 0 this gas is smellless
	var/list/odor
	///if the odor gives negative signs such as coughing on a high concentratation. if your gas doesn't have a noticeable scent, set this to false
	var/odor_emotes = TRUE
	///the multiplier per of this gas's odor, if higher its easily detected in lower conentrations and much more unbearable at lower conentrations as well
	var/odor_power = 0

/datum/gas/proc/breath(partial_pressure, light_threshold, heavy_threshold, moles, mob/living/carbon/C, obj/item/organ/lungs/lungs)
	// This is only called on gases with the GAS_FLAG_BREATH_PROC flag. When possible, do NOT use this--
	// greatly prefer just adding a reagent. This is mostly around for legacy reasons.
	return null

/datum/auxgm/proc/add_gas(datum/gas/gas)
	var/g = gas.id
	if(g)
		datums[g] = gas
		specific_heats[g] = gas.specific_heat
		molar_masses[g] = gas.molar_mass
		names[g] = gas.name
		if(gas.moles_visible)
			visibility[g] = gas.moles_visible
			overlays[g] = new /list(FACTOR_GAS_VISIBLE_MAX)
			for(var/i in 1 to FACTOR_GAS_VISIBLE_MAX)
				var/obj/effect/overlay/gas/overlay = new(gas.gas_overlay)
				overlay.color = gas.color
				overlay.alpha = i * 255 / FACTOR_GAS_VISIBLE_MAX
				overlays[g][i] = overlay
		else
			visibility[g] = 0
			overlays[g] = 0
		flags[g] = gas.flags
		ids[g] = g
		typepaths[g] = gas.type
		fusion_powers[g] = gas.fusion_power

		if(gas.breath_alert_info)
			breath_alert_info[g] = gas.breath_alert_info
		breath_results[g] = gas.breath_results
		if(gas.breath_reagent)
			breath_reagents[g] = gas.breath_reagent
		if(gas.breath_reagent_dangerous)
			breath_reagents_dangerous[g] = gas.breath_reagent_dangerous
		if(gas.oxidation_temperature)
			oxidation_temperatures[g] = gas.oxidation_temperature
			oxidation_rates[g] = gas.oxidation_rate
			if(gas.fire_products)
				fire_products[g] = gas.fire_products
			enthalpies[g] = gas.enthalpy
		else if(gas.fire_temperature)
			fire_temperatures[g] = gas.fire_temperature
			fire_burn_rates[g] = gas.fire_burn_rate
			if(gas.fire_products)
				fire_products[g] = gas.fire_products
			enthalpies[g] = gas.enthalpy
		_auxtools_register_gas(gas)

/datum/auxgm/New()
	for(var/gas_path in subtypesof(/datum/gas))
		var/datum/gas/gas = new gas_path
		add_gas(gas)
	for(var/breathing_class_path in subtypesof(/datum/breathing_class))
		var/datum/breathing_class/class = new breathing_class_path
		breathing_classes[breathing_class_path] = class
	finalize_gas_refs()

/datum/auxgm/proc/get_by_flag(flag)
	var/static/list/gases_by_flag
	if(!gases_by_flag)
		gases_by_flag = list()
	if(!(flag in gases_by_flag))
		gases_by_flag += flag
		gases_by_flag[flag] = list()
		for(var/g in flags)
			if(flags[g] & flag)
				gases_by_flag[flag] += g
	return gases_by_flag[flag]

GLOBAL_DATUM_INIT(gas_data, /datum/auxgm, new)

/obj/effect/overlay/gas
	icon = 'icons/effects/atmospherics.dmi'
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE  // should only appear in vis_contents, but to be safe
	layer = FLY_LAYER
	appearance_flags = TILE_BOUND | RESET_COLOR
	vis_flags = NONE

/obj/effect/overlay/gas/New(state)
	. = ..()
	icon_state = state
