/obj/item/tank
	name = "tank"
	icon = 'icons/obj/tank.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/tanks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tanks_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	hitsound = 'sound/weapons/smash.ogg'
	pressure_resistance = ONE_ATMOSPHERE * 5
	force = 5
	throwforce = 10
	throw_speed = 1
	throw_range = 4
	custom_materials = list(/datum/material/iron = 500)
	actions_types = list(/datum/action/item_action/set_internals)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 30)
	demolition_mod = 1.25
	var/datum/gas_mixture/air_contents = null
	var/distribute_pressure = ONE_ATMOSPHERE
	var/integrity = 3
	var/volume = 70

	//Alert variables
	var/warning_alert = FALSE
	var/critical_warning_alert = FALSE
	var/empty_alert = FALSE

	supports_variations = VOX_VARIATION

/obj/item/tank/ui_action_click(mob/user)
	toggle_internals(user)

/obj/item/tank/proc/toggle_internals(mob/user)
	var/mob/living/carbon/breather = user
	if(!istype(breather))
		return

	if(breather.internal == src)
		to_chat(breather, span_notice("You close [src] valve."))
		breather.internal = null
		breather.update_internals_hud_icon(0)
	else
		if(!breather.getorganslot(ORGAN_SLOT_BREATHING_TUBE))
			var/obj/item/clothing/clothes_check = breather.wear_mask
			var/internals = FALSE

			if(istype(clothes_check, /obj/item/clothing/mask))
				var/obj/item/clothing/mask/M = clothes_check
				if(M.mask_adjusted)
					M.adjustmask(breather)
				if(clothes_check.clothing_flags & ALLOWINTERNALS)
					internals = TRUE
			clothes_check = breather.head
			if(istype(clothes_check, /obj/item/clothing/head))
				if(clothes_check.clothing_flags & ALLOWINTERNALS) //i know this is hacky but unfortunately mask items can exist in your head slot. god hates us
					internals = TRUE

			if(!internals)
				to_chat(breather, span_warning("You are not wearing an internals mask!"))
				return

		if(breather.internal)
			to_chat(breather, span_notice("You switch your internals to [src]."))
		else
			to_chat(breather, span_notice("You open [src] valve."))
		breather.internal = src
		breather.update_internals_hud_icon(1)
	breather.update_action_buttons_icon()


/obj/item/tank/Initialize()
	. = ..()

	air_contents = new(volume) //liters
	air_contents.set_temperature(T20C)

	populate_gas()

	START_PROCESSING(SSobj, src)

	addtimer(CALLBACK(src, PROC_REF(pressure_alerts)), 5 SECONDS, TIMER_STOPPABLE|TIMER_LOOP|TIMER_DELETE_ME)

/obj/item/tank/proc/populate_gas()
	return

/obj/item/tank/Destroy()
	STOP_PROCESSING(SSobj, src)
	air_contents = null
	return ..()

/obj/item/tank/examine(mob/user)
	var/obj/icon = src
	. = ..()
	if(istype(src.loc, /obj/item/assembly))
		icon = src.loc
	if(!in_range(src, user) && !isobserver(user))
		if(icon == src)
			. += span_notice("If you want any more information you'll need to get closer.")
		return

	. += span_notice("The gauge reads [round(air_contents.total_moles(), 0.01)] mol at [round(src.air_contents.return_pressure(),0.01)] kPa.")	//yogs can read mols

	var/celsius_temperature = src.air_contents.return_temperature()-T0C
	var/descriptive

	if (celsius_temperature < 20)
		descriptive = "cold"
	else if (celsius_temperature < 40)
		descriptive = "room temperature"
	else if (celsius_temperature < 80)
		descriptive = "lukewarm"
	else if (celsius_temperature < 100)
		descriptive = "warm"
	else if (celsius_temperature < 300)
		descriptive = "hot"
	else
		descriptive = "furiously hot"

	. += span_notice("It feels [descriptive].")

/obj/item/tank/deconstruct(disassembled = TRUE)
	if(!disassembled)
		var/turf/T = get_turf(src)
		if(T)
			T.assume_air(air_contents)
			air_update_turf()
		playsound(src.loc, 'sound/effects/spray.ogg', 10, TRUE, -3)
	qdel(src)

/obj/item/tank/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if(istype(W, /obj/item/assembly_holder))
		bomb_assemble(W,user)
	else
		. = ..()

/obj/item/tank/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/tank/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Tank", name)
		ui.open()

/obj/item/tank/ui_static_data(mob/user)
	. = list (
		"defaultReleasePressure" = round(TANK_DEFAULT_RELEASE_PRESSURE),
		"minReleasePressure" = round(TANK_MIN_RELEASE_PRESSURE),
		"maxReleasePressure" = round(TANK_MAX_RELEASE_PRESSURE),
		"leakPressure" = round(TANK_LEAK_PRESSURE),
		"fragmentPressure" = round(TANK_FRAGMENT_PRESSURE)
	)

/obj/item/tank/ui_data(mob/user)
	. = list(
		"tankPressure" = round(air_contents.return_pressure()),
		"releasePressure" = round(distribute_pressure)
	)

	var/mob/living/carbon/C = user
	if(!istype(C))
		C = loc.loc
	if(istype(C) && C.internal == src)
		.["connected"] = TRUE

/obj/item/tank/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("pressure")
			var/pressure = params["pressure"]
			if(pressure == "reset")
				pressure = initial(distribute_pressure)
				. = TRUE
			else if(pressure == "min")
				pressure = TANK_MIN_RELEASE_PRESSURE
				. = TRUE
			else if(pressure == "max")
				pressure = TANK_MAX_RELEASE_PRESSURE
				. = TRUE
			else if(text2num(pressure) != null)
				pressure = text2num(pressure)
				. = TRUE
			if(.)
				distribute_pressure = clamp(round(pressure), TANK_MIN_RELEASE_PRESSURE, TANK_MAX_RELEASE_PRESSURE)

/obj/item/tank/remove_air(amount)
	return air_contents.remove(amount)

/obj/item/tank/remove_air_ratio(ratio)
	return air_contents.remove_ratio(ratio)

/obj/item/tank/return_air()
	return air_contents

/obj/item/tank/return_analyzable_air()
	return air_contents

/obj/item/tank/assume_air(datum/gas_mixture/giver)
	air_contents.merge(giver)

	check_status()
	return 1

/obj/item/tank/assume_air_moles(datum/gas_mixture/giver, moles)
	giver.transfer_to(air_contents, moles)

	check_status()
	return 1

/obj/item/tank/assume_air_ratio(datum/gas_mixture/giver, ratio)
	giver.transfer_ratio_to(air_contents, ratio)

	check_status()
	return 1

/obj/item/tank/proc/remove_air_volume(volume_to_return)
	if(!air_contents)
		return null

	var/moles_needed = distribute_pressure*volume_to_return/(R_IDEAL_GAS_EQUATION*air_contents.return_temperature())

	return remove_air(moles_needed)

/obj/item/tank/process(seconds_per_tick)
	//Allow for reactions
	air_contents.react()
	check_status()

/obj/item/tank/update_overlays()
	. = ..()
	var/status_overlay_icon_state
	var/pressure = air_contents.return_pressure()

	// Switches the pressure status overlay depending on which range the tank pressure lies in
	switch(pressure)
		if((5 * ONE_ATMOSPHERE) to (20 * ONE_ATMOSPHERE))
			status_overlay_icon_state = "status_nominal"
		if((2 * ONE_ATMOSPHERE) to (5 * ONE_ATMOSPHERE))
			status_overlay_icon_state = "status_warning"
		if((0.75 * ONE_ATMOSPHERE) to (2 * ONE_ATMOSPHERE))
			status_overlay_icon_state = "status_alert"
		if((0 * ONE_ATMOSPHERE) to (0.75 * ONE_ATMOSPHERE))
			status_overlay_icon_state = "status_critical"

	// Actually sets the overlay. As of now, this has only been done for smaller emergency tanks
	// The if statement is set as follows due to the coarse search type that the istype proc conducts, as subtypes count as valid types
	var/mutable_appearance/status_overlay = mutable_appearance(icon, status_overlay_icon_state)
	if(istype(src, /obj/item/tank/internals/emergency_oxygen/engi))
		status_overlay.pixel_x = 1
		status_overlay.pixel_y = 1
		overlays += status_overlay
	else if(istype(src, /obj/item/tank/internals/emergency_oxygen/double))
		status_overlay.pixel_x = 3
		status_overlay.pixel_y = 4
		overlays += status_overlay
	else if(istype(src, /obj/item/tank/internals/emergency_oxygen))
		status_overlay.pixel_x = 1
		status_overlay.pixel_y = 1
		overlays += status_overlay

/obj/item/tank/proc/check_status()
	//Handle exploding, leaking, and rupturing of the tank

	if(!air_contents)
		return 0

	var/pressure = air_contents.return_pressure()
	var/temperature = air_contents.return_temperature()

	if(pressure > TANK_FRAGMENT_PRESSURE)
		if(!istype(src.loc, /obj/item/transfer_valve))
			log_bomber(get_mob_by_key(fingerprintslast), "was last key to touch", src, "which ruptured explosively")
		//Give the gas a chance to build up more pressure through reacting
		air_contents.react(src)
		pressure = air_contents.return_pressure()
		var/range = (pressure-TANK_FRAGMENT_PRESSURE)/TANK_FRAGMENT_SCALE
		var/turf/epicenter = get_turf(loc)


		explosion(epicenter, round(range*0.25), round(range*0.5), round(range), round(range*1.5))
		if(istype(src.loc, /obj/item/transfer_valve))
			qdel(src.loc)
		else
			qdel(src)

	else if(pressure > TANK_RUPTURE_PRESSURE || temperature > TANK_MELT_TEMPERATURE)
		if(integrity <= 0)
			var/turf/T = get_turf(src)
			if(!T)
				return
			T.assume_air(air_contents)
			playsound(src.loc, 'sound/effects/spray.ogg', 10, TRUE, -3)
			qdel(src)
		else
			integrity--

	else if(pressure > TANK_LEAK_PRESSURE)
		if(integrity <= 0)
			var/turf/T = get_turf(src)
			if(!T)
				return
			var/datum/gas_mixture/leaked_gas = air_contents.remove_ratio(0.25)
			T.assume_air(leaked_gas)
		else
			integrity--

	else if(integrity < 3)
		integrity++

// adjusts sprites and issues text alerts depending on tank pressure
/obj/item/tank/proc/pressure_alerts()

	var/pressure = air_contents.return_pressure()

	// Prevents jetpacks from sending any kind of pressure alert
	if(istype(src, /obj/item/tank/jetpack))
		return 0

	// Prevents newly printed tanks from beeping out an alert
	if(!air_contents || pressure == 0)
		warning_alert = TRUE
		critical_warning_alert = TRUE
		empty_alert = TRUE
		return 0

	// Checks the pressure of the tank while it's in use and sends an alert out when the pressure reaches a specific range.
	// Binary variables are used here to prevent an alert from repeating more than once
	switch(pressure)
		if((5 * ONE_ATMOSPHERE) to (29 * ONE_ATMOSPHERE))
			warning_alert = FALSE
			critical_warning_alert = FALSE
			empty_alert = FALSE
		if((2 * ONE_ATMOSPHERE) to (5 * ONE_ATMOSPHERE))
			if(!warning_alert)
				warning_alert = TRUE
		if((0.75 * ONE_ATMOSPHERE) to (2 * ONE_ATMOSPHERE))
			if(!critical_warning_alert)
				critical_warning_alert = TRUE
				playsound(src, 'sound/machines/twobeep_high.ogg', 30, FALSE)
				say("Tank pressure low -- Estimated time until depletion: [(src.volume/2) * 5] minutes.")
		if((0 * ONE_ATMOSPHERE) to (0.75 * ONE_ATMOSPHERE))
			if(!empty_alert)
				empty_alert = TRUE
				playsound(src, 'sound/machines/twobeep_high.ogg', 30, FALSE)
				playsound(src, 'sound/machines/beep.ogg', 30, FALSE)
				say("Tank is nearly empty! Replacement recommended!")

	update_overlays()
