/obj/mecha
	name = "exosuit"
	desc = "Exosuit"
	icon = 'icons/mecha/mecha.dmi'
	density = TRUE //Dense. To raise the heat.
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	resistance_flags = FIRE_PROOF | ACID_PROOF
	layer = BELOW_MOB_LAYER//icon draw layer
	infra_luminosity = 15 //byond implementation is bugged.
	force = 5
	light_system = MOVABLE_LIGHT
	light_power = 0.8
	light_range = 6
	light_on = FALSE
	var/repair_multiplier = 1 //multiply incoming repairs by this value. used to make some mechs less efficient and slower to repair.
	var/ruin_mecha = FALSE //if the mecha starts on a ruin, don't automatically give it a tracking beacon to prevent metagaming.
	var/can_move = 0 //time of next allowed movement
	var/mob/living/carbon/occupant = null
	var/step_in = 10 //make a step in step_in/10 sec.
	var/dir_in = SOUTH //What direction will the mech face when entered/powered on?
	var/base_step_energy_drain = 15 //The base amount of energy the mech should consume each time it moves. This variable is a backup for when leg actuators affect the energy drain.
	var/step_energy_drain  // How much energy the mech actually consumes when moving after modifiers (Eg, stock parts, leg actuators)
	var/melee_energy_drain = 15
	var/overload_step_energy_drain_min = 100
	max_integrity = 300 //max_integrity is base health
	var/deflect_chance = 10 //chance to deflect the incoming projectiles, hits, or lesser the effect of ex_act.
	armor = list("melee" = 20, "bullet" = 10, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	var/list/facing_modifiers = list(MECHA_FRONT_ARMOUR = 1.5, MECHA_SIDE_ARMOUR = 1, MECHA_BACK_ARMOUR = 0.5)
	var/equipment_disabled = 0 //disabled due to EMP
	var/obj/item/stock_parts/cell/cell ///Keeps track of the mech's cell
	var/obj/item/stock_parts/scanning_module/scanmod ///Keeps track of the mech's scanning module
	var/obj/item/stock_parts/capacitor/capacitor ///Keeps track of the mech's capacitor
	var/construction_state = MECHA_LOCKED
	var/last_message = 0
	var/add_req_access = 1
	var/maint_access = 0
	var/dna_lock //dna-locking the mech
	var/list/proc_res = list() //stores proc owners, like proc_res["functionname"] = owner reference
	var/datum/effect_system/spark_spread/spark_system = new
	var/lights = FALSE
	var/last_user_hud = 1 // used to show/hide the mecha hud while preserving previous preference
	var/completely_disabled = FALSE //stops the mech from doing anything

	///Vars for mech charges
	var/charging = FALSE
	var/charge_ready = TRUE
	var/charge_windup = 0.5
	var/charge_cooldown = 50
	var/charge_power_consume = 200
	var/charge_distance = 5
	var/charge_break_walls = FALSE
	var/charge_toss_structures  = FALSE
	var/charge_toss_mobs = FALSE

	var/bumpsmash = 0 //Whether or not the mech destroys walls by running into it.
	//inner atmos
	var/use_internal_tank = 0
	var/internal_tank_valve = ONE_ATMOSPHERE
	var/obj/machinery/portable_atmospherics/canister/internal_tank
	var/datum/gas_mixture/cabin_air
	var/obj/machinery/atmospherics/components/unary/portables_connector/connected_port = null

	var/obj/item/radio/mech/radio
	var/list/trackers = list()

	var/max_temperature = 25000
	var/internal_damage_threshold = 50 //health percentage below which internal damage is possible
	var/internal_damage = 0 //contains bitflags

	var/list/operation_req_access = list()//required access level for mecha operation
	var/list/internals_req_access = list()//REQUIRED ACCESS LEVEL TO OPEN CELL COMPARTMENT

	var/wreckage

	var/list/equipment = new
	var/obj/item/mecha_parts/mecha_equipment/selected
	var/max_equip = 3
	var/datum/events/events //WS - Readded for Smartwire Revert

	var/step_silent = FALSE //Used for disabling mech step sounds while using thrusters or pushing off lockers
	var/stepsound = 'sound/mecha/mechstep.ogg'
	var/turnsound = 'sound/mecha/mechturn.ogg'

	var/melee_cooldown = 10
	var/melee_can_hit = 1

	var/silicon_pilot = FALSE //set to true if an AI or MMI is piloting.

	var/enter_delay = 40 //Time taken to enter the mech
	var/exit_delay = 20 //Time to exit mech
	var/destruction_sleep_duration = 20 //Time that mech pilot is put to sleep for if mech is destroyed
	var/enclosed = TRUE //Set to false for open-cockpit mechs
	var/silicon_icon_state = null //if the mech has a different icon when piloted by an AI or MMI
	var/is_currently_ejecting = FALSE //Mech cannot use equiptment when true, set to true if pilot is trying to exit mech

	//Action datums
	var/datum/action/innate/mecha/mech_eject/eject_action = new
	var/datum/action/innate/mecha/mech_toggle_internals/internals_action = new
	var/datum/action/innate/mecha/mech_cycle_equip/cycle_action = new
	var/datum/action/innate/mecha/mech_toggle_lights/lights_action = new
	var/datum/action/innate/mecha/mech_view_stats/stats_action = new
	var/datum/action/innate/mecha/mech_defense_mode/defense_action = new
	var/datum/action/innate/mecha/mech_overload_mode/overload_action = new
	var/datum/action/innate/mecha/mech_charge_mode/charge_action = new
	var/datum/effect_system/smoke_spread/smoke_system = new //not an action, but trigged by one
	var/datum/action/innate/mecha/mech_smoke/smoke_action = new
	var/datum/action/innate/mecha/mech_zoom/zoom_action = new
	var/datum/action/innate/mecha/mech_switch_damtype/switch_damtype_action = new
	var/datum/action/innate/mecha/mech_toggle_phasing/phasing_action = new
	var/datum/action/innate/mecha/strafe/strafing_action = new

	// for mechs with unique actions
	var/datum/action/innate/mecha/mech_unique_action

	//Action vars
	var/obj/item/mecha_parts/mecha_equipment/thrusters/active_thrusters
	var/defense_mode = FALSE
	var/leg_overload_mode = FALSE
	var/leg_overload_coeff = 100
	var/smoke = 5
	var/smoke_ready = 1
	var/smoke_cooldown = 100
	var/phasing = FALSE
	var/phasing_energy_drain = 200
	var/phase_state = "" //icon_state when phasing
	var/strafe = FALSE //If we are strafing

	var/zoom_mode = FALSE
	var/zoom_mod = 6
	var/zoom_out_mod = 2

	var/nextsmash = 0
	var/smashcooldown = 3	//deciseconds

	var/occupant_sight_flags = 0 //sight flags to give to the occupant (e.g. mech mining scanner gives meson-like vision)
	var/mouse_pointer

	hud_possible = list (DIAG_STAT_HUD, DIAG_BATT_HUD, DIAG_MECH_HUD, DIAG_TRACK_HUD)

/obj/item/radio/mech //this has to go somewhere
	canhear_range = 0

/obj/mecha/Initialize()
	. = ..()
	events = new //WS - Readded for Smartwire Revert
	icon_state += "-open"
	add_radio()
	add_cabin()
	if (enclosed)
		add_airtank()
	spark_system.set_up(2, 0, src)
	spark_system.attach(src)
	smoke_system.set_up(3, src)
	smoke_system.attach(src)
	add_cell()
	add_scanmod()
	add_capacitor()
	START_PROCESSING(SSobj, src)
	SSpoints_of_interest.make_point_of_interest(src)
	log_message("[src.name] created.", LOG_MECHA)
	GLOB.mechas_list += src //global mech list
	prepare_huds()
	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.add_to_hud(src)
	diag_hud_set_mechhealth()
	diag_hud_set_mechcell()
	diag_hud_set_mechstat()
	become_hearing_sensitive(ROUNDSTART_TRAIT)
	update_part_values()
	AddComponent(/datum/component/automatic_fire_mecha,0.5)
	set_up_unique_action()

/obj/mecha/update_icon_state()
	if(silicon_pilot && silicon_icon_state)
		icon_state = silicon_icon_state
		return ..()
	return ..()

/obj/mecha/get_cell()
	return cell

/obj/mecha/Destroy()
	if(occupant && iscarbon(occupant))
		occupant.set_sleeping(destruction_sleep_duration)
	go_out()
	var/mob/living/silicon/ai/AI
	for(var/mob/M in src) //Let's just be ultra sure
		if(isAI(M))
			occupant = null
			AI = M //AIs are loaded into the mech computer itself. When the mech dies, so does the AI. They can be recovered with an AI card from the wreck.
		else
			M.forceMove(loc)
	for(var/obj/item/mecha_parts/mecha_equipment/E in equipment)
		E.detach(loc)
		qdel(E)
	if(AI)
		AI.gib() //No wreck, no AI to recover
		AI = null
	STOP_PROCESSING(SSobj, src)
	SSpoints_of_interest.remove_point_of_interest(src)
	equipment.Cut()

	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.remove_from_hud(src)

	QDEL_NULL(cell)
	QDEL_NULL(scanmod)
	QDEL_NULL(capacitor)
	QDEL_NULL(internal_tank)
	QDEL_NULL(spark_system)
	QDEL_NULL(smoke_system)
	QDEL_NULL(radio)

	QDEL_NULL(eject_action)
	QDEL_NULL(internals_action)
	QDEL_NULL(cycle_action)
	QDEL_NULL(lights_action)
	QDEL_NULL(stats_action)
	QDEL_NULL(defense_action)
	QDEL_NULL(overload_action)
	QDEL_NULL(smoke_system)
	QDEL_NULL(smoke_action)
	QDEL_NULL(zoom_action)
	QDEL_NULL(switch_damtype_action)
	QDEL_NULL(phasing_action)
	QDEL_NULL(strafing_action)

	assume_air(cabin_air)
	QDEL_NULL(cabin_air)

	GLOB.mechas_list -= src //global mech list
	return ..()

/obj/mecha/proc/restore_equipment()
	equipment_disabled = 0
	if(occupant)
		SEND_SOUND(occupant, sound('sound/items/timer.ogg', volume=50))
		to_chat(occupant, "<span=notice>Equipment control unit has been rebooted successfully.</span>")
		occupant.update_mouse_pointer()

/obj/mecha/CheckParts(list/parts_list)
	..()
	cell = locate(/obj/item/stock_parts/cell) in contents
	scanmod = locate(/obj/item/stock_parts/scanning_module) in contents
	capacitor = locate(/obj/item/stock_parts/capacitor) in contents
	update_part_values()

/obj/mecha/proc/update_part_values() ///Updates the values given by scanning module and capacitor tier, called when a part is removed or inserted.
	if(scanmod)
		step_energy_drain = max(1, base_step_energy_drain - (5 * scanmod.rating)) //10 is normal, so on lowest part its worse, on second its ok and on higher its real good up to 0 on best
	else
		step_energy_drain = 500
	if(capacitor)
		armor = armor.modifyRating(energy = (capacitor.rating * 5)) //Each level of capacitor protects the mech against emp by 5%
	else //because we can still be hit without a cap, even if we can't move
		armor = armor.setRating(energy = 0)


////////////////////////
////// Helpers /////////
////////////////////////

/obj/mecha/proc/add_airtank()
	internal_tank = new /obj/machinery/portable_atmospherics/canister/air(src)
	return internal_tank

///Adds a cell, for use in Map-spawned mechs, Nuke Ops mechs, and admin-spawned mechs. Mechs built by hand will replace this.
/obj/mecha/proc/add_cell(obj/item/stock_parts/cell/C=null)
	QDEL_NULL(cell)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new /obj/item/stock_parts/cell/high/plus(src)

///Adds a scanning module, for use in Map-spawned mechs, Nuke Ops mechs, and admin-spawned mechs. Mechs built by hand will replace this.
/obj/mecha/proc/add_scanmod(obj/item/stock_parts/scanning_module/sm=null)
	QDEL_NULL(scanmod)
	if(sm)
		sm.forceMove(src)
		scanmod = sm
		return
	scanmod = new /obj/item/stock_parts/scanning_module(src)

///Adds a capacitor, for use in Map-spawned mechs, Nuke Ops mechs, and admin-spawned mechs. Mechs built by hand will replace this.
/obj/mecha/proc/add_capacitor(obj/item/stock_parts/capacitor/cap=null)
	QDEL_NULL(capacitor)
	if(cap)
		cap.forceMove(src)
		capacitor = cap
	else
		capacitor = new /obj/item/stock_parts/capacitor(src)

/obj/mecha/proc/add_cabin()
	cabin_air = new
	cabin_air.set_temperature(T20C)
	cabin_air.set_volume(200)
	cabin_air.set_moles(GAS_O2, O2STANDARD*cabin_air.return_volume()/(R_IDEAL_GAS_EQUATION*cabin_air.return_temperature()))
	cabin_air.set_moles(GAS_N2, N2STANDARD*cabin_air.return_volume()/(R_IDEAL_GAS_EQUATION*cabin_air.return_temperature()))
	return cabin_air

/obj/mecha/proc/add_radio()
	radio = new(src)
	radio.name = "[src] radio"
	radio.icon = icon
	radio.icon_state = icon_state

/obj/mecha/proc/can_use(mob/user)
	if(user != occupant)
		return 0
	if(user && ismob(user))
		if(!user.incapacitated())
			return 1
	return 0

////////////////////////////////////////////////////////////////////////////////

/obj/mecha/examine(mob/user)
	. = ..()
	var/integrity = atom_integrity*100/max_integrity
	switch(integrity)
		if(85 to 100)
			. += "It's fully intact."
		if(65 to 85)
			. += "It's slightly damaged."
		if(45 to 65)
			. += "It's badly damaged."
		if(25 to 45)
			. += "It's heavily damaged."
		else
			. += "It's falling apart."
	var/hide_weapon = locate(/obj/item/mecha_parts/weapon_bay/concealed) in contents
	var/hidden_weapon = hide_weapon ? (locate(/obj/item/mecha_parts/mecha_equipment/weapon) in equipment) : null
	var/list/visible_equipment = equipment - hidden_weapon
	if(visible_equipment.len)
		. += "It's equipped with:"
		for(var/obj/item/mecha_parts/mecha_equipment/ME in visible_equipment)
			. += "[icon2html(ME, user)] \A [ME]."
	if(!enclosed)
		if(silicon_pilot)
			. += "[src] appears to be piloting itself..."
		else if(occupant && occupant != user) //!silicon_pilot implied
			. += "You can see [occupant] inside."
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				for(var/O in H.held_items)
					if(istype(O, /obj/item/gun))
						. += span_warning("It looks like you can hit the pilot directly if you target the center or above.")
						break //in case user is holding two guns
	if(mech_unique_action)
		. += "This mech has a special action you can activate by pressing the <b>unique action</b> key. By default, this is <b>space</b>"
//processing internal damage, temperature, air regulation, alert updates, lights power use.
/obj/mecha/process(seconds_per_tick)
	var/internal_temp_regulation = 1

	if(internal_damage)
		if(internal_damage & MECHA_INT_FIRE)
			if(!(internal_damage & MECHA_INT_TEMP_CONTROL) && prob(5))
				clearInternalDamage(MECHA_INT_FIRE)
			if(internal_tank)
				var/datum/gas_mixture/int_tank_air = internal_tank.return_air()
				if(int_tank_air.return_pressure() > internal_tank.maximum_pressure && !(internal_damage & MECHA_INT_TANK_BREACH))
					setInternalDamage(MECHA_INT_TANK_BREACH)
				if(int_tank_air && int_tank_air.return_volume() > 0) //heat the air_contents
					int_tank_air.set_temperature(min(6000+T0C, int_tank_air.return_temperature()+rand(10,15)))
			if(cabin_air && cabin_air.return_volume()>0)
				cabin_air.set_temperature(min(6000+T0C, cabin_air.return_temperature()+rand(10,15)))
				if(cabin_air.return_temperature() > max_temperature/2)
					take_damage(4/round(max_temperature/cabin_air.return_temperature(),0.1), BURN, 0, 0)

		if(internal_damage & MECHA_INT_TEMP_CONTROL)
			internal_temp_regulation = 0

		if(internal_damage & MECHA_INT_TANK_BREACH) //remove some air from internal tank
			if(internal_tank)
				assume_air_ratio(internal_tank.return_air(), 0.1)

		if(internal_damage & MECHA_INT_SHORT_CIRCUIT)
			if(get_charge())
				spark_system.start()
				cell.charge -= min(20,cell.charge)
				cell.maxcharge -= min(20,cell.maxcharge)

	if(internal_temp_regulation)
		if(cabin_air && cabin_air.return_volume() > 0)
			var/delta = cabin_air.return_temperature() - T20C
			cabin_air.set_temperature(cabin_air.return_temperature() - max(-10, min(10, round(delta/4,0.1))))

	if(internal_tank)
		var/datum/gas_mixture/tank_air = internal_tank.return_air()

		var/release_pressure = internal_tank_valve
		var/cabin_pressure = cabin_air.return_pressure()
		var/pressure_delta = min(release_pressure - cabin_pressure, (tank_air.return_pressure() - cabin_pressure)/2)
		var/transfer_moles = 0
		if(pressure_delta > 0) //cabin pressure lower than release pressure
			if(tank_air.return_temperature() > 0)
				transfer_moles = pressure_delta*cabin_air.return_volume()/(cabin_air.return_temperature() * R_IDEAL_GAS_EQUATION)
				tank_air.transfer_to(cabin_air,transfer_moles)
		else if(pressure_delta < 0) //cabin pressure higher than release pressure
			var/datum/gas_mixture/t_air = return_air()
			pressure_delta = cabin_pressure - release_pressure
			if(t_air)
				pressure_delta = min(cabin_pressure - t_air.return_pressure(), pressure_delta)
			if(pressure_delta > 0) //if location pressure is lower than cabin pressure
				transfer_moles = pressure_delta*cabin_air.return_volume()/(cabin_air.return_temperature() * R_IDEAL_GAS_EQUATION)
				cabin_air.transfer_to(t_air, transfer_moles)

	if(occupant)
		if(cell)
			var/cellcharge = cell.charge/cell.maxcharge
			switch(cellcharge)
				if(0.75 to INFINITY)
					occupant.clear_alert("charge")
				if(0.5 to 0.75)
					occupant.throw_alert("charge", /atom/movable/screen/alert/lowcell, 1)
				if(0.25 to 0.5)
					occupant.throw_alert("charge", /atom/movable/screen/alert/lowcell, 2)
				if(0.01 to 0.25)
					occupant.throw_alert("charge", /atom/movable/screen/alert/lowcell, 3)
				else
					occupant.throw_alert("charge", /atom/movable/screen/alert/emptycell)

		var/integrity = atom_integrity/max_integrity*100
		switch(integrity)
			if(30 to 45)
				occupant.throw_alert("exosuit damage", /atom/movable/screen/alert/low_mech_integrity, 1)
			if(15 to 35)
				occupant.throw_alert("exosuit damage", /atom/movable/screen/alert/low_mech_integrity, 2)
			if(-INFINITY to 15)
				occupant.throw_alert("exosuit damage", /atom/movable/screen/alert/low_mech_integrity, 3)
			else
				occupant.clear_alert("exosuit damage")
		var/atom/checking = occupant.loc
		// recursive check to handle all cases regarding very nested occupants,
		// such as brainmob inside brainitem inside MMI inside mecha
		while (!isnull(checking))
			if (isturf(checking))
				// hit a turf before hitting the mecha, seems like they have
				// been moved out
				occupant.clear_alert("charge")
				occupant.clear_alert("exosuit damage")
				RemoveActions(occupant, human_occupant=1)
				occupant = null
				break
			else if (checking == src)
				break  // all good
			checking = checking.loc

	if(lights)
		var/lights_energy_drain = 2
		use_power(lights_energy_drain)

	if(!enclosed && occupant?.incapacitated()) //no sides mean it's easy to just sorta fall out if you're incapacitated.
		visible_message(span_warning("[occupant] tumbles out of the cockpit!"))
		go_out() //Maybe we should install seat belts?

//Diagnostic HUD updates
	diag_hud_set_mechhealth()
	diag_hud_set_mechcell()
	diag_hud_set_mechstat()

/obj/mecha/fire_act() //Check if we should ignite the pilot of an open-canopy mech
	. = ..()
	if (occupant && !enclosed && !silicon_pilot)
		if (occupant.fire_stacks < 5)
			occupant.fire_stacks += 1
		occupant.IgniteMob()

/obj/mecha/proc/drop_item()//Derpfix, but may be useful in future for engineering exosuits.
	return

/obj/mecha/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list())
	. = ..()
	if(speaker != occupant)
		return
	//flick speech bubble
	var/list/speech_bubble_recipients = list()
	for(var/mob/M in get_hearers_in_view(7,src))
		if(M.client)
			speech_bubble_recipients.Add(M.client)
	var/image/mech_speech = image('icons/mob/talk.dmi', src, "machine[say_test(say_test(raw_message))]",MOB_LAYER+1)
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flick_overlay_global), mech_speech, speech_bubble_recipients, 3 SECONDS)

////////////////////////////
///// Action processing ////
////////////////////////////


/obj/mecha/proc/click_action(atom/target,mob/user,params, cooldown_override = null)
	if(!occupant || occupant != user)
		return
	if(!locate(/turf) in list(target,target.loc)) // Prevents inventory from being drilled
		return
	if(completely_disabled)
		return
	if(is_currently_ejecting)
		return
	if(phasing)
		occupant_message(span_warning("Unable to interact with objects while phasing."))
		return
	if(user.incapacitated())
		return
	if(construction_state)
		occupant_message(span_warning("Maintenance protocols in effect."))
		return
	if(!get_charge())
		return
	if(src == target)
		return
	var/dir_to_target = get_dir(src,target)
	if(dir_to_target && !(dir_to_target & dir))//wrong direction
		return
	if(internal_damage & MECHA_INT_CONTROL_LOST)
		if (!target)
			return
		target = pick(view(3,target))

	var/mob/living/L = user
	if(!Adjacent(target))
		if(selected && selected.is_ranged())
			if(HAS_TRAIT(L, TRAIT_PACIFISM) && selected.harmful)
				to_chat(user, span_warning("You don't want to harm other living beings!"))
				return
			if(selected.action(target,params))
				selected.start_cooldown(cooldown_override)
	else if(selected && selected.is_melee())
		if(isliving(target) && selected.harmful && HAS_TRAIT(L, TRAIT_PACIFISM))
			to_chat(user, span_warning("You don't want to harm other living beings!"))
			return
		if(selected.action(target,params))
			selected.start_cooldown(cooldown_override)
	else
		if(internal_damage & MECHA_INT_CONTROL_LOST)
			var/list/possible_targets = oview(1,src)
			if (!length(possible_targets))
				return
			target = pick(possible_targets)
		if(!melee_can_hit || !istype(target, /atom))
			return
		target.mech_melee_attack(src)
		melee_can_hit = FALSE
		addtimer(VARSET_CALLBACK(src, melee_can_hit, TRUE), melee_cooldown)


/obj/mecha/proc/range_action(atom/target)
	return

/obj/mecha/proc/set_up_unique_action(mob/user)
	return

/obj/mecha/proc/handle_unique_action(mob/user)
	mech_unique_action.Activate()
	return


//////////////////////////////////
////////  Movement procs  ////////
//////////////////////////////////

///Plays the mech step sound effect. Split from movement procs so that other mechs can override this one specific part.
/obj/mecha/proc/play_stepsound()
	if(stepsound)
		playsound(src,stepsound,40,1)

/obj/mecha/Move(atom/newloc, direct)
	. = ..()
	if(.)
		events.fireEvent("onMove",get_turf(src)) //WS - Readded for Smartwire Revert
	if (internal_tank?.disconnect()) // Something moved us and broke connection
		occupant_message(span_warning("Air port connection has been severed!"))
		log_message("Lost connection to gas port.", LOG_MECHA)

/obj/mecha/Process_Spacemove(movement_dir = 0)
	. = ..()
	if(.)
		return TRUE

	var/atom/movable/backup = get_spacemove_backup()
	if(backup)
		if(istype(backup) && movement_dir && !backup.anchored)
			if(backup.newtonian_move(turn(movement_dir, 180)))
				step_silent = TRUE
				if(occupant)
					to_chat(occupant, span_info("You push off [backup] to propel yourself."))
		return TRUE

	if(can_move <= world.time && active_thrusters && movement_dir && active_thrusters.thrust(movement_dir))
		step_silent = TRUE
		return TRUE

	return FALSE

/obj/mecha/relaymove(mob/living/user, direction)
	if(completely_disabled)
		return
	if(!direction)
		return
	if(user != occupant) //While not "realistic", this piece is player friendly.
		user.forceMove(get_turf(src))
		to_chat(user, span_notice("You climb out from [src]."))
		return 0
	if(internal_tank?.connected_port)
		if(world.time - last_message > 20)
			occupant_message(span_warning("Unable to move while connected to the air system port!"))
			last_message = world.time
		return 0
	if(construction_state)
		if(world.time - last_message > 20)
			occupant_message(span_danger("Maintenance protocols in effect."))
			last_message = world.time
		return
	return domove(direction)

/obj/mecha/proc/domove(direction)
	if(can_move >= world.time)
		return 0
	if(!Process_Spacemove(direction))
		return 0
	if(!has_charge(step_energy_drain))
		return 0
	if(zoom_mode)
		if(world.time - last_message > 20)
			occupant_message(span_warning("Unable to move while in zoom mode!"))
			last_message = world.time
		return 0
	if(charging)
		if(world.time - last_message > 20)
			occupant_message(span_warning("You can't change direction while charging!"))
			last_message = world.time
		return 0
	if(!cell)
		if(world.time - last_message > 20)
			occupant_message(span_warning("Missing power cell."))
			last_message = world.time
		return 0
	if(!scanmod || !capacitor)
		if(world.time - last_message > 20)
			occupant_message(span_warning("Missing [scanmod? "capacitor" : "scanning module"]."))
			last_message = world.time
		return 0

	var/move_result = 0
	var/oldloc = loc
	if(internal_damage & MECHA_INT_CONTROL_LOST)
		set_glide_size(DELAY_TO_GLIDE_SIZE(step_in))
		move_result = mechsteprand()
	else if(dir != direction && (!strafe || occupant.client.keys_held["Alt"]))
		move_result = mechturn(direction)
	else
		set_glide_size(DELAY_TO_GLIDE_SIZE(step_in))
		move_result = mechstep(direction)
	if(move_result || loc != oldloc)// halfway done diagonal move still returns false
		use_power(step_energy_drain)
		can_move = world.time + step_in
		return 1
	return 0

/obj/mecha/proc/mechturn(direction)
	set_dir_mecha(direction)
	if(turnsound)
		playsound(src,turnsound,40,TRUE)
	return 1

/obj/mecha/proc/mechstep(direction)
	var/current_dir = dir
	. = step(src,direction)
	if(strafe)
		set_dir_mecha(current_dir)
	if(. && !step_silent)
		play_stepsound()
	step_silent = FALSE

/obj/mecha/proc/mechsteprand()
	. = step_rand(src)
	if(. && !step_silent)
		play_stepsound()
	step_silent = FALSE

/obj/mecha/Bump(atom/obstacle)
	var/atom/throw_target = get_edge_target_turf(obstacle, dir)
	if(phasing && get_charge() >= phasing_energy_drain && !throwing)
		if(!can_move)
			return
		if(istype(obstacle, /turf/closed/indestructible))
			return
		can_move = FALSE
		if(phase_state)
			flick(phase_state, src)
		forceMove(get_step(src,dir))
		use_power(phasing_energy_drain)
		addtimer(VARSET_CALLBACK(src, can_move, TRUE), step_in*3)
	else if(charging)
		if(charge_break_walls && iswallturf(obstacle))
			var/turf/closed/wall/crushed = obstacle
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
			visible_message(span_danger("[src] smashes through [obstacle]"))
			crushed.dismantle_wall(TRUE)
		if(isobj(obstacle))
			var/obj/object = obstacle
			obstacle.mech_melee_attack(src)
			if(!(object.resistance_flags & INDESTRUCTIBLE) && charge_toss_structures)
				object.throw_at(throw_target, 4, 3)
			visible_message(span_danger("[src] crashes into [obstacle]!"))
			playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		if(ishuman(obstacle))
			var/mob/living/carbon/human/H = obstacle
			H.throw_at(throw_target,4,3)
			visible_message(span_danger("[src] slams into \the [obstacle], sending [obstacle.p_them()] flying!"))
			playsound(H, 'sound/effects/bang.ogg', 100, FALSE, -1)
			H.Paralyze(20)
			H.adjustStaminaLoss(30)
			H.apply_damage(rand(20,35), BRUTE)
	else
		if(..()) //mech was thrown
			return
		if(bumpsmash && occupant) //Need a pilot to push the PUNCH button.
			if(nextsmash < world.time)
				obstacle.mech_melee_attack(src)
				nextsmash = world.time + smashcooldown
				if(!obstacle || obstacle.CanPass(src,get_step(src,dir)))
					step(src,dir)
		if(isobj(obstacle))
			var/obj/O = obstacle
			if(!O.anchored && O.move_resist <= move_force)
				step(obstacle, dir)
		else if(ismob(obstacle))
			var/mob/M = obstacle
			if(M.move_resist <= move_force)
				step(obstacle, dir)





///////////////////////////////////
////////  Internal damage  ////////
///////////////////////////////////

/obj/mecha/proc/check_for_internal_damage(list/possible_int_damage,ignore_threshold=null)
	if(!islist(possible_int_damage) || !length(possible_int_damage))
		return
	if(prob(20))
		if(ignore_threshold || atom_integrity*100/max_integrity < internal_damage_threshold)
			for(var/T in possible_int_damage)
				if(internal_damage & T)
					possible_int_damage -= T
			if (length(possible_int_damage))
				var/int_dam_flag = pick(possible_int_damage)
				if(int_dam_flag)
					setInternalDamage(int_dam_flag)
	if(prob(5))
		if(ignore_threshold || atom_integrity*100/max_integrity < internal_damage_threshold)
			if (length(equipment))
				var/obj/item/mecha_parts/mecha_equipment/ME = pick(equipment)
				qdel(ME)

/obj/mecha/proc/setInternalDamage(int_dam_flag)
	internal_damage |= int_dam_flag
	log_message("Internal damage of type [int_dam_flag].", LOG_MECHA)
	SEND_SOUND(occupant, sound('sound/machines/warning-buzzer.ogg',wait=0))
	diag_hud_set_mechstat()

/obj/mecha/proc/clearInternalDamage(int_dam_flag)
	if(internal_damage & int_dam_flag)
		switch(int_dam_flag)
			if(MECHA_INT_TEMP_CONTROL)
				occupant_message(span_boldnotice("Life support system reactivated."))
			if(MECHA_INT_FIRE)
				occupant_message(span_boldnotice("Internal fire extinquished."))
			if(MECHA_INT_TANK_BREACH)
				occupant_message(span_boldnotice("Damaged internal tank has been sealed."))
	internal_damage &= ~int_dam_flag
	diag_hud_set_mechstat()

/////////////////////////////////////
//////////// AI piloting ////////////
/////////////////////////////////////

/obj/mecha/attack_ai(mob/living/silicon/ai/user)
	if(!isAI(user))
		return
	//Allows the Malf to scan a mech's status and loadout, helping it to decide if it is a worthy chariot.
	if(user.can_dominate_mechs)
		examine(user) //Get diagnostic information!
		for(var/obj/item/mecha_parts/mecha_tracking/B in trackers)
			to_chat(user, span_danger("Warning: Tracking Beacon detected. Enter at your own risk. Beacon Data:"))
			to_chat(user, "[B.get_mecha_info()]")
			break
		//Nothing like a big, red link to make the player feel powerful!
		to_chat(user, "<a href='byond://?src=[REF(user)];ai_take_control=[REF(src)]'>[span_userdanger("ASSUME DIRECT CONTROL?")]</a><br>")
	else
		examine(user)
		if(occupant)
			to_chat(user, span_warning("This exosuit has a pilot and cannot be controlled."))
			return
		var/can_control_mech = 0
		for(var/obj/item/mecha_parts/mecha_tracking/ai_control/A in trackers)
			can_control_mech = 1
			to_chat(user, "[span_notice("[icon2html(src, user)] Status of [name]:")]\n[A.get_mecha_info()]")
			break
		if(!can_control_mech)
			to_chat(user, span_warning("You cannot control exosuits without AI control beacons installed."))
			return
		to_chat(user, "<a href='byond://?src=[REF(user)];ai_take_control=[REF(src)]'>[span_boldnotice("Take control of exosuit?")]</a><br>")

/obj/mecha/transfer_ai(interaction, mob/user, mob/living/silicon/ai/AI, obj/item/aicard/card)
	if(!..())
		return

//Transfer from core or card to mech. Proc is called by mech.
	switch(interaction)
		if(AI_TRANS_TO_CARD) //Upload AI from mech to AI card.
			if(!construction_state) //Mech must be in maint mode to allow carding.
				to_chat(user, span_warning("[name] must have maintenance protocols active in order to allow a transfer."))
				return
			AI = occupant
			if(!AI || !isAI(occupant)) //Mech does not have an AI for a pilot
				to_chat(user, span_warning("No AI detected in the [name] onboard computer."))
				return
			AI.ai_restore_power()//So the AI initially has power.
			AI.control_disabled = TRUE
			AI.radio_enabled = FALSE
			AI.disconnect_shell()
			RemoveActions(AI, TRUE)
			occupant = null
			silicon_pilot = FALSE
			AI.forceMove(card)
			card.AI = AI
			AI.controlled_mech = null
			AI.remote_control = null
			icon_state = initial(icon_state)+"-open"
			to_chat(AI, span_notice("You have been downloaded to a mobile storage device. Wireless connection offline."))
			to_chat(user, "[span_boldnotice("Transfer successful")]: [AI.name] ([rand(1000,9999)].exe) removed from [name] and stored within local memory.")

		if(AI_MECH_HACK) //Called by AIs on the mech
			AI.linked_core = new /obj/structure/AIcore/deactivated(AI.loc)
			if(AI.can_dominate_mechs)
				if(occupant) //Oh, I am sorry, were you using that?
					to_chat(AI, span_warning("Pilot detected! Forced ejection initiated!"))
					to_chat(occupant, span_danger("You have been forcibly ejected!"))
					go_out(1) //IT IS MINE, NOW. SUCK IT, RD!
			ai_enter_mech(AI, interaction)

		if(AI_TRANS_FROM_CARD) //Using an AI card to upload to a mech.
			AI = card.AI
			if(!AI)
				to_chat(user, span_warning("There is no AI currently installed on this device."))
				return
			if(AI.deployed_shell) //Recall AI if shelled so it can be checked for a client
				AI.disconnect_shell()
			if(AI.stat || !AI.client)
				to_chat(user, span_warning("[AI.name] is currently unresponsive, and cannot be uploaded."))
				return
			if(occupant || dna_lock) //Normal AIs cannot steal mechs!
				to_chat(user, span_warning("Access denied. [name] is [occupant ? "currently occupied" : "secured with a DNA lock"]."))
				return
			AI.control_disabled = FALSE
			AI.radio_enabled = TRUE
			to_chat(user, "[span_boldnotice("Transfer successful")]: [AI.name] ([rand(1000,9999)].exe) installed and executed successfully. Local copy has been removed.")
			card.AI = null
			ai_enter_mech(AI, interaction)

//Hack and From Card interactions share some code, so leave that here for both to use.
/obj/mecha/proc/ai_enter_mech(mob/living/silicon/ai/AI, interaction)
	AI.ai_restore_power()
	AI.forceMove(src)
	occupant = AI
	silicon_pilot = TRUE
	icon_state = initial(icon_state)
	update_appearance()
	playsound(src, 'sound/machines/windowdoor.ogg', 50, TRUE)
	if(!internal_damage)
		SEND_SOUND(occupant, sound('sound/mecha/nominal.ogg',volume=50))
	AI.cancel_camera()
	AI.controlled_mech = src
	AI.remote_control = src
	REMOVE_TRAIT(AI, TRAIT_HANDS_BLOCKED, ROUNDSTART_TRAIT)
	AI.can_shunt = 0 //ONE AI ENTERS. NO AI LEAVES.
	to_chat(AI, AI.can_dominate_mechs ? span_announce("Takeover of [name] complete! You are now loaded onto the onboard computer. Attempting to leave your transmission region will result in connection loss!") :\
		span_notice("You have been uploaded to a mech's onboard computer."))
	to_chat(AI, "<span class='reallybig boldnotice'>Use Middle-Mouse to activate mech functions and equipment. Click normally for AI interactions.</span>")
	if(interaction == AI_TRANS_FROM_CARD)
		GrantActions(AI, FALSE) //No eject/return to core action for AI uploaded by card
	else
		GrantActions(AI, !AI.can_dominate_mechs)


//An actual AI (simple_animal mecha pilot) entering the mech
/obj/mecha/proc/aimob_enter_mech(mob/living/simple_animal/hostile/human/ramzi/mecha_pilot/pilot_mob)
	if(pilot_mob && pilot_mob.Adjacent(src))
		if(occupant)
			return
		icon_state = initial(icon_state)
		occupant = pilot_mob
		pilot_mob.mecha = src
		pilot_mob.forceMove(src)
		GrantActions(pilot_mob)//needed for checks, and incase a badmin puts somebody in the mob

/obj/mecha/proc/aimob_exit_mech(mob/living/simple_animal/hostile/human/ramzi/mecha_pilot/pilot_mob)
	if(occupant == pilot_mob)
		occupant = null
	if(pilot_mob.mecha == src)
		pilot_mob.mecha = null
	icon_state = "[initial(icon_state)]-open"
	pilot_mob.forceMove(get_turf(src))
	RemoveActions(pilot_mob)


/////////////////////////////////////
////////  Atmospheric stuff  ////////
/////////////////////////////////////

/obj/mecha/remove_air(amount)
	if(use_internal_tank)
		return cabin_air.remove(amount)
	return ..()

/obj/mecha/remove_air_ratio(ratio)
	if(use_internal_tank)
		return cabin_air.remove_ratio(ratio)
	return ..()

/obj/mecha/return_air()
	if(use_internal_tank)
		return cabin_air
	return ..()

/obj/mecha/return_analyzable_air()
	return cabin_air

/obj/mecha/proc/return_pressure()
	var/datum/gas_mixture/t_air = return_air()
	if(t_air)
		. = t_air.return_pressure()

/obj/mecha/return_temperature()
	var/datum/gas_mixture/t_air = return_air()
	if(t_air)
		. = t_air.return_temperature()

/obj/mecha/MouseDrop_T(mob/M, mob/user)
	if((user != M) || user.incapacitated() || !Adjacent(user))
		return
	if(!ishuman(user)) // no silicons or drones in mechas.
		return
	if(HAS_TRAIT(user, TRAIT_PRIMITIVE)) //no lavalizards either.
		to_chat(user, span_warning("The knowledge to use this device eludes you!"))
		return
	log_message("[user] tries to move in.", LOG_MECHA)
	if (occupant)
		to_chat(usr, span_warning("The [name] is already occupied!"))
		log_message("Permission denied (Occupied).", LOG_MECHA)
		return
	if(dna_lock)
		var/passed = FALSE
		if(user.has_dna())
			var/mob/living/carbon/C = user
			if(C.dna.unique_enzymes==dna_lock)
				passed = TRUE
		if (!passed)
			to_chat(user, span_warning("Access denied. [name] is secured with a DNA lock."))
			log_message("Permission denied (DNA LOCK).", LOG_MECHA)
			return
	if(!operation_allowed(user))
		to_chat(user, span_warning("Access denied. Insufficient operation keycodes."))
		log_message("Permission denied (No keycode).", LOG_MECHA)
		return
	if(user.buckled)
		to_chat(user, span_warning("You are currently buckled and cannot move."))
		log_message("Permission denied (Buckled).", LOG_MECHA)
		return
	if(user.has_buckled_mobs()) //mob attached to us
		to_chat(user, span_warning("You can't enter the exosuit with other creatures attached to you!"))
		log_message("Permission denied (Attached mobs).", LOG_MECHA)
		return

	visible_message(span_notice("[user] starts to climb into [name]."))

	//check user for fast embark, divide enter_delay by 2, then pass final delay to do_after
	var/final_delay = enter_delay
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.wear_suit)
			var/obj/item/clothing/suit/S = H.get_item_by_slot(ITEM_SLOT_OCLOTHING)
			if(S.clothing_flags & FAST_EMBARK)
				final_delay = enter_delay/2

	if(do_after(user, final_delay, target = src))
		if(atom_integrity <= 0)
			to_chat(user, span_warning("You cannot get in the [name], it has been destroyed!"))
		else if(occupant)
			to_chat(user, span_danger("[occupant] was faster! Try better next time, loser."))
		else if(user.buckled)
			to_chat(user, span_warning("You can't enter the exosuit while buckled."))
		else if(user.has_buckled_mobs())
			to_chat(user, span_warning("You can't enter the exosuit with other creatures attached to you!"))
		else
			moved_inside(user)
	else
		to_chat(user, span_warning("You stop entering the exosuit!"))

// wake up should go off here
/obj/mecha/proc/moved_inside(mob/living/carbon/human/H)
	. = FALSE
	if(H && H.client && (H in range(1)))
		occupant = H
		H.forceMove(src)
		H.update_mouse_pointer()
		add_fingerprint(H)
		GrantActions(H, human_occupant=1)
		forceMove(loc)
		log_message("[H] moved in as pilot.", LOG_MECHA)
		icon_state = initial(icon_state)
		set_dir_mecha(dir_in)
		playsound(src, 'sound/machines/windowdoor.ogg', 50, TRUE)
		if(!internal_damage)
			SEND_SOUND(occupant, sound('sound/mecha/nominal.ogg',volume=50))
		SEND_SIGNAL(src,COMSIG_MECH_ENTERED, occupant)
		equipment_check()
		return TRUE

/obj/mecha/proc/mmi_move_inside(obj/item/mmi/M, mob/user)
	. = FALSE
	if(!M.brain_check(user))
		return

	var/mob/living/brain/B = M.brainmob
	if(occupant)
		to_chat(user, span_warning("Occupant detected!"))
		return
	if(dna_lock && (!B.stored_dna || (dna_lock != B.stored_dna.unique_enzymes)))
		to_chat(user, span_warning("Access denied. [name] is secured with a DNA lock."))
		return

	visible_message(span_notice("[user] starts to insert an MMI into [name]."))

	if(do_after(user, 40, target = src))
		if(!occupant)
			return mmi_moved_inside(M, user)
		else
			to_chat(user, span_warning("Occupant detected!"))
	else
		to_chat(user, span_notice("You stop inserting the MMI."))

/obj/mecha/proc/mmi_moved_inside(obj/item/mmi/M, mob/user)
	if(!(Adjacent(M) && Adjacent(user)))
		return FALSE
	if(!M.brain_check(user))
		return FALSE

	var/mob/living/brain/B = M.brainmob
	if(!user.transferItemToLoc(M, src))
		to_chat(user, span_warning("\the [M] is stuck to your hand, you cannot put it in \the [src]!"))
		return FALSE

	M.set_mecha(src)
	occupant = B
	silicon_pilot = TRUE
	B.forceMove(src) //should allow relaymove
	B.reset_perspective(src)
	B.remote_control = src
	B.update_mouse_pointer()
	icon_state = initial(icon_state)
	SEND_SIGNAL(src,COMSIG_MECH_ENTERED, occupant)
	equipment_check()
	update_appearance()
	set_dir_mecha(dir_in)
	log_message("[M] moved in as pilot.", LOG_MECHA)
	if(!internal_damage)
		SEND_SOUND(occupant, sound('sound/mecha/nominal.ogg',volume=50))
	GrantActions(B)
	log_game("[key_name(user)] has put the MMI/posibrain of [key_name(B)] into [src] at [AREACOORD(src)]")
	return TRUE

/obj/mecha/container_resist_act(mob/living/user)
	is_currently_ejecting = TRUE
	to_chat(occupant, span_notice("You begin the ejection procedure. Equipment is disabled during this process. Hold still to finish ejecting."))
	var/final_exit_delay = exit_delay
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.wear_suit)
			var/obj/item/clothing/suit/S = H.get_item_by_slot(ITEM_SLOT_OCLOTHING)
			if(S.clothing_flags & FAST_EMBARK)
				final_exit_delay = exit_delay/2

	if(do_after(occupant, has_gravity() ? final_exit_delay : 0 , target = src))
		to_chat(occupant, span_notice("You exit the exosuit."))
		go_out()
	else
		to_chat(occupant, span_notice("You stop exiting the exosuit. Weapons are enabled again."))
	is_currently_ejecting = FALSE

/obj/mecha/Exited(atom/movable/M, atom/newloc)
	. = ..()
	if(occupant && occupant == M) // The occupant exited the mech without calling go_out()
		go_out(TRUE, newloc)

	if(cell && cell == M)
		cell = null
		return
	if(scanmod && scanmod == M)
		scanmod = null
		update_part_values()
		return
	if(capacitor && capacitor == M)
		armor = armor.modifyRating(energy = (capacitor.rating * -5)) //lose the energy armor if we lose this cap
		capacitor = null
		update_part_values()

/obj/mecha/proc/go_out(forced, atom/newloc = loc)
	if(!occupant)
		return
	var/atom/movable/mob_container
	occupant.clear_alert("charge")
	occupant.clear_alert("exosuit damage")
	if(ishuman(occupant))
		mob_container = occupant
		RemoveActions(occupant, human_occupant=1)
	else if(isbrain(occupant))
		var/mob/living/brain/brain = occupant
		RemoveActions(brain)
		mob_container = brain.container
	else if(isAI(occupant))
		var/mob/living/silicon/ai/AI = occupant
		if(forced)//This should only happen if there are multiple AIs in a round, and at least one is Malf.
			RemoveActions(occupant)
			occupant.gib()  //If one Malf decides to steal a mech from another AI (even other Malfs!), they are destroyed, as they have nowhere to go when replaced.
			occupant = null
			silicon_pilot = FALSE
			return
		else
			if(!AI.linked_core)
				to_chat(AI, span_userdanger("Inactive core destroyed. Unable to return."))
				AI.linked_core = null
				return
			to_chat(AI, span_notice("Returning to core..."))
			ADD_TRAIT(AI, TRAIT_HANDS_BLOCKED, ROUNDSTART_TRAIT) // Resets the AI's hand status
			AI.controlled_mech = null
			AI.remote_control = null
			RemoveActions(occupant, 1)
			mob_container = AI
			newloc = get_turf(AI.linked_core)
			qdel(AI.linked_core)
	else
		return
	var/mob/living/L = occupant
	occupant = null //we need it null when forceMove calls Exited().
	silicon_pilot = FALSE
	SEND_SIGNAL(src,COMSIG_MECH_EXITED,L)
	if(mob_container.forceMove(newloc))//ejecting mob container
		log_message("[mob_container] moved out.", LOG_MECHA)
		L << browse(null, "window=exosuit")

		if(istype(mob_container, /obj/item/mmi))
			var/obj/item/mmi/mmi = mob_container
			if(mmi.brainmob)
				L.forceMove(mmi)
				L.reset_perspective()
			mmi.set_mecha(null)
			mmi.update_appearance()
		icon_state = initial(icon_state)+"-open"
		set_dir_mecha(dir_in)

	if(L && L.client)
		L.update_mouse_pointer()
		L.client.view_size.resetToDefault()
		zoom_mode = 0

/////////////////////////
////// Access stuff /////
/////////////////////////

/obj/mecha/proc/operation_allowed(mob/M)
	req_access = operation_req_access
	req_one_access = list()
	return allowed(M)

/obj/mecha/proc/internals_access_allowed(mob/M)
	req_one_access = internals_req_access
	req_access = list()
	return allowed(M)



////////////////////////////////
/////// Messages and Log ///////
////////////////////////////////

/obj/mecha/proc/occupant_message(message as text)
	if(message)
		if(occupant && occupant.client)
			to_chat(occupant, "[icon2html(src, occupant)] [message]")

GLOBAL_VAR_INIT(year, time2text(world.realtime,"YYYY"))
GLOBAL_VAR_INIT(year_integer, text2num(year)) // = 2013???

///////////////////////
///// Power stuff /////
///////////////////////

/obj/mecha/proc/has_charge(amount)
	return (get_charge()>=amount)

/obj/mecha/proc/get_charge()
	for(var/obj/item/mecha_parts/mecha_equipment/tesla_energy_relay/R in equipment)
		var/relay_charge = R.get_charge()
		if(relay_charge)
			return relay_charge
	if(cell)
		return max(0, cell.charge)

/obj/mecha/proc/use_power(amount)
	if(get_charge() && cell.use(amount))
		return 1
	return 0

/obj/mecha/proc/give_power(amount)
	if(!isnull(get_charge()))
		cell.give(amount)
		return 1
	return 0

/obj/mecha/update_remote_sight(mob/living/user)
	if(occupant_sight_flags)
		if(user == occupant)
			user.sight |= occupant_sight_flags

///////////////////////
////// Weapon stuff ///
///////////////////////

/obj/mecha/proc/ammo_resupply(obj/item/mecha_ammo/A, mob/user,fail_chat_override = FALSE)
	if(!A.rounds)
		if(!fail_chat_override)
			to_chat(user, span_warning("This box of ammo is empty!"))
		return FALSE
	var/ammo_needed
	var/found_gun
	for(var/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/gun in equipment)
		ammo_needed = 0

		if(istype(gun, /obj/item/mecha_parts/mecha_equipment/weapon/ballistic) && gun.ammo_type == A.ammo_type)
			found_gun = TRUE
			if(A.direct_load)
				ammo_needed = gun.projectiles_max - gun.projectiles
			else
				ammo_needed = gun.projectiles_cache_max - gun.projectiles_cache

			if(ammo_needed)
				if(ammo_needed < A.rounds)
					if(A.direct_load)
						gun.projectiles = gun.projectiles + ammo_needed
					else
						gun.projectiles_cache = gun.projectiles_cache + ammo_needed
					playsound(get_turf(user),A.load_audio,50,TRUE)
					to_chat(user, span_notice("You add [ammo_needed] [A.round_term][ammo_needed > 1?"s":""] to the [gun.name]"))
					A.rounds = A.rounds - ammo_needed
					A.update_name()
					return TRUE

				else
					if(A.direct_load)
						gun.projectiles = gun.projectiles + A.rounds
					else
						gun.projectiles_cache = gun.projectiles_cache + A.rounds
					playsound(get_turf(user),A.load_audio,50,TRUE)
					to_chat(user, span_notice("You add [A.rounds] [A.round_term][A.rounds > 1?"s":""] to the [gun.name]"))
					A.rounds = 0
					A.update_name()
					return TRUE
	if(!fail_chat_override)
		if(found_gun)
			to_chat(user, span_notice("You can't fit any more ammo of this type!"))
		else
			to_chat(user, span_notice("None of the equipment on this exosuit can use this ammo!"))
	return FALSE

// handles actions tied to mech equipment
/obj/mecha/proc/equipment_check()
	occupant.client.view_size.zoomIn()
	if(istype(selected,/obj/item/mecha_parts/mecha_equipment/weapon))
		var/obj/item/mecha_parts/mecha_equipment/weapon/mech_gun = selected
		if(mech_gun.full_auto)
			SEND_SIGNAL(src,COMSIG_MECH_ENABLE_AUTOFIRE)
			SEND_SIGNAL(src,COMSIG_MECH_SET_AUTOFIRE_SPEED, mech_gun.equip_cooldown)
		else
			SEND_SIGNAL(src,COMSIG_MECH_DISABLE_AUTOFIRE)
		if(mech_gun.scoped)
			zoom_action.Grant(occupant,src)
			zoom_mod = mech_gun.zoom_mod
			zoom_out_mod = mech_gun.zoom_out_mod
		else
			zoom_action.Remove(occupant)
			zoom_mod = initial(zoom_mod)
			zoom_out_mod = initial(zoom_out_mod)
	else
		SEND_SIGNAL(src,COMSIG_MECH_DISABLE_AUTOFIRE)
		zoom_action.Remove(occupant)
		zoom_mod = initial(zoom_mod)
		zoom_out_mod = initial(zoom_out_mod)


///////////////////////
////// Charging /////
///////////////////////

/obj/mecha/proc/start_charge()
	Shake(15, 15, 1 SECONDS)
	var/obj/effect/temp_visual/decoy/new_decoy = new /obj/effect/temp_visual/decoy(loc,src)
	animate(new_decoy, alpha = 0, color = "#5a5858", transform = matrix()*2, time = 2)
	addtimer(CALLBACK(src,PROC_REF(handle_charge)), charge_windup SECONDS, TIMER_STOPPABLE)

/obj/mecha/proc/handle_charge()
	var/turf/mecha_loc = get_turf(src)
	charging = TRUE
	var/turf/charge_target = get_ranged_target_turf(mecha_loc,dir,charge_distance)
	if(!charge_target)
		charging = FALSE
		return
	cell.use(charge_power_consume)
	walk_towards(src, charge_target, 0.7)
	sleep(get_dist(src, charge_target) * 0.7)
	charge_end()

/obj/mecha/proc/charge_end()
	walk(src,0)
	charging = FALSE

/// Sets the direction of the mecha and all of its occcupents, required for FOV. Alternatively one could make a recursive contents registration and register topmost direction changes in the fov component
/obj/mecha/proc/set_dir_mecha(new_dir)
	setDir(new_dir)
	occupant.setDir(new_dir)
