/*
Overview:
	Used to create objects that need a per step proc call.  Default definition of 'Initialize()'
	stores a reference to src machine in global 'machines list'.  Default definition
	of 'Destroy' removes reference to src machine in global 'machines list'.

Class Variables:
	use_power (num)
		current state of auto power use.
		Possible Values:
			NO_POWER_USE -- no auto power use
			IDLE_POWER_USE -- machine is using power at its idle power level
			ACTIVE_POWER_USE -- machine is using power at its active power level

	active_power_usage (num)
		Value for the amount of power to use when in active power mode

	idle_power_usage (num)
		Value for the amount of power to use when in idle power mode

	power_channel (num)
		What channel to draw from when drawing power for power mode
		Possible Values:
			AREA_USAGE_EQUIP:1 -- Equipment Channel
			AREA_USAGE_LIGHT:2 -- Lighting Channel
			AREA_USAGE_ENVIRON:3 -- Environment Channel

	component_parts (list)
		A list of component parts of machine used by frame based machines.

	stat (bitflag)
		Machine status bit flags.
		Possible bit flags:
			BROKEN -- Machine is broken
			NOPOWER -- No power is being supplied to machine.
			MAINT -- machine is currently under going maintenance.
			EMPED -- temporary broken by EMP pulse

Class Procs:
	Initialize()							'game/machinery/machine.dm'

	Destroy()						 'game/machinery/machine.dm'

	auto_use_power()				'game/machinery/machine.dm'
		This proc determines how power mode power is deducted by the machine.
		'auto_use_power()' is called by the 'master_controller' game_controller every
		tick. (not anymore)

		Return Value:
			return:1 -- if object is powered
			return:0 -- if object is not powered.

		Default definition uses 'use_power', 'power_channel', 'active_power_usage',
		'idle_power_usage', 'powered()', and 'use_power()' implement behavior.

	powered(chan = -1)			'modules/power/power.dm'
		Checks to see if area that contains the object has power available for power
		channel given in 'chan'. -1 defaults to power_channel

	use_power(amount, chan=-1)	'modules/power/power.dm'
		Deducts 'amount' from the power channel 'chan' of the area that contains the object.

	power_change()					'modules/power/power.dm'
		Called by the area that contains the object when ever that area under goes a
		power state change (area runs out of power, or area channel is turned off).

	RefreshParts()					'game/machinery/machine.dm'
		Called to refresh the variables in the machine that are contributed to by parts
		contained in the component_parts list. (example: glass and material amounts for
		the autolathe)

		Default definition does nothing.

	process()						'game/machinery/machine.dm'
		Called by the 'machinery subsystem' once per machinery tick for each machine that is listed in its 'machines' list.

	process_atmos()
		Called by the 'air subsystem' once per atmos tick for each machine that is listed in its 'atmos_machines' list.

	Compiled by Aygar
*/

/obj/machinery
	name = "machinery"
	icon = 'icons/obj/stationobjs.dmi'
	desc = "Some kind of machine."
	verb_say = "beeps"
	verb_yell = "blares"
	pressure_resistance = 15
	max_integrity = 200
	layer = BELOW_OBJ_LAYER //keeps shit coming out of the machine from ending up underneath it.
	flags_ricochet = RICOCHET_HARD
	receive_ricochet_chance_mod = 0.3

	anchored = TRUE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT

	hitsound_type = PROJECTILE_HITSOUND_METAL

	initial_language_holder = /datum/language_holder/gal_com

	var/machine_stat = NONE
	var/use_power = IDLE_POWER_USE
		//0 = dont run the auto
		//1 = run auto, use idle
		//2 = run auto, use active
	var/use_static_power = NO_POWER_USE
	var/idle_power_usage = 0
	var/active_power_usage = 0
	var/power_channel = AREA_USAGE_EQUIP
		//AREA_USAGE_EQUIP,AREA_USAGE_ENVIRON or AREA_USAGE_LIGHT
	///A combination of factors such as having power, not being broken and so on. Boolean.
	var/is_operational = TRUE
	var/wire_compatible = FALSE

	var/list/component_parts = null //list of all the parts used to build it, if made from certain kinds of frames.
	var/panel_open = FALSE
	var/state_open = FALSE
	var/critical_machine = FALSE //If this machine is critical to station operation and should have the area be excempted from power failures.
	var/list/occupant_typecache //if set, turned into typecache in Initialize, other wise, defaults to mob/living typecache
	var/atom/movable/occupant = null
	/// Viable flags to go here are START_PROCESSING_ON_INIT, or START_PROCESSING_MANUALLY. See code\__DEFINES\machines.dm for more information on these flags.
	var/processing_flags = START_PROCESSING_ON_INIT
	/// What subsystem this machine will use, which is generally SSmachines or SSfastprocess. By default all machinery use SSmachines. This fires a machine's process() roughly every 2 seconds.
	var/subsystem_type = /datum/controller/subsystem/machines
	var/obj/item/circuitboard/circuit // Circuit to be created and inserted when the machinery is created

	var/interaction_flags_machine = INTERACT_MACHINE_WIRES_IF_OPEN | INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN_SILICON | INTERACT_MACHINE_SET_MACHINE
	var/market_verb = "Customer"

	var/clickvol = 40	// sound volume played on succesful click
	var/next_clicksound = 0	// value to compare with world.time for whether to play clicksound according to CLICKSOUND_INTERVAL
	var/clicksound	// sound played on succesful interface use by a carbon lifeform

	// For storing and overriding ui id
	var/tgui_id // ID of TGUI interface

	var/atmos_processing = FALSE
	var/interacts_with_air = FALSE

/obj/machinery/Initialize(mapload, apply_default_parts = TRUE)
	if(!armor)
		armor = list("melee" = 25, "bullet" = 10, "laser" = 10, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 70)
	. = ..()
	GLOB.machines += src
	RegisterSignal(src, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(power_change))
	if(ispath(circuit, /obj/item/circuitboard))
		circuit = new circuit
		if(mapload || apply_default_parts)
			circuit.apply_default_parts(src)

	if(processing_flags & START_PROCESSING_ON_INIT)
		begin_processing()

	if(occupant_typecache)
		occupant_typecache = typecacheof(occupant_typecache)
	switch(use_power)
		if(IDLE_POWER_USE)
			set_idle_power()
		if(ACTIVE_POWER_USE)
			set_active_power()
	return INITIALIZE_HINT_LATELOAD

/// Helper proc for telling a machine to start processing with the subsystem type that is located in its `subsystem_type` var.
/obj/machinery/proc/begin_processing()
	var/datum/controller/subsystem/processing/subsystem = locate(subsystem_type) in Master.subsystems
	START_PROCESSING(subsystem, src)

/// Helper proc for telling a machine to stop processing with the subsystem type that is located in its `subsystem_type` var.
/obj/machinery/proc/end_processing()
	var/datum/controller/subsystem/processing/subsystem = locate(subsystem_type) in Master.subsystems
	STOP_PROCESSING(subsystem, src)

/obj/machinery/LateInitialize()
	. = ..()
	power_change()
	become_area_sensitive(ROUNDSTART_TRAIT)
	RegisterSignal(src, COMSIG_ENTER_AREA, PROC_REF(enter_area))
	RegisterSignal(src, COMSIG_EXIT_AREA, PROC_REF(exit_area))

/obj/machinery/proc/enter_area(datum/source, area/A)
	SIGNAL_HANDLER
	power_change(A)

/obj/machinery/proc/exit_area(datum/source, area/A)
	SIGNAL_HANDLER
	set_no_power(A)

/obj/machinery/Destroy()
	GLOB.machines.Remove(src)
	end_processing()
	dropContents()
	lose_area_sensitivity(ROUNDSTART_TRAIT)
	QDEL_NULL(circuit)
	QDEL_LIST(component_parts)
	set_no_power()
	return ..()

/obj/machinery/proc/locate_machinery()
	return

/obj/machinery/process(seconds_per_tick)//If you dont use process or power why are you here
	return PROCESS_KILL

/obj/machinery/proc/process_atmos(seconds_per_tick)//If you dont use process why are you here
	return PROCESS_KILL


///Called when we want to change the value of the machine_stat variable. Holds bitflags.
/obj/machinery/proc/set_machine_stat(new_value)
	if(new_value == machine_stat)
		return
	. = machine_stat
	machine_stat = new_value
	on_set_machine_stat(.)


///Called when the value of `machine_stat` changes, so we can react to it.
/obj/machinery/proc/on_set_machine_stat(old_value)
	if(old_value & (NOPOWER|BROKEN|MAINT))
		if(!(machine_stat & (NOPOWER|BROKEN|MAINT))) //From off to on.
			set_is_operational(TRUE)
	else if(machine_stat & (NOPOWER|BROKEN|MAINT)) //From on to off.
		set_is_operational(FALSE)


/obj/machinery/emp_act(severity)
	. = ..()
	if(use_power && !machine_stat && !(. & EMP_PROTECT_SELF))
		use_power(7500/severity)
		new /obj/effect/temp_visual/emp(loc)

/obj/machinery/proc/open_machine(drop = TRUE)
	state_open = TRUE
	density = FALSE
	if(drop)
		dropContents()
	update_appearance()
	updateUsrDialog()

/obj/machinery/proc/dropContents(list/subset = null)
	var/turf/T = get_turf(src)
	for(var/atom/movable/A in contents)
		if(subset && !(A in subset))
			continue

		A.forceMove(T)

		if(occupant == A)
			occupant = null

/**
 * Puts passed object in to user's hand
 *
 * Puts the passed object in to the users hand if they are adjacent.
 * If the user is not adjacent then place the object on top of the machine.
 *
 * Vars:
 * * object (obj) The object to be moved in to the users hand.
 * * user (mob/living) The user to recive the object
 */
/obj/machinery/proc/try_put_in_hand(obj/object, mob/living/user)
	if(!issilicon(user) && in_range(src, user))
		user.put_in_hands(object)
	else
		object.forceMove(drop_location())

/obj/machinery/proc/can_be_occupant(atom/movable/am)
	return occupant_typecache ? is_type_in_typecache(am, occupant_typecache) : isliving(am)

/obj/machinery/proc/close_machine(atom/movable/target = null)
	state_open = FALSE
	density = TRUE
	if(!target)
		for(var/am in loc)
			if (!(can_be_occupant(am)))
				continue
			var/atom/movable/AM = am
			if(AM.has_buckled_mobs())
				continue
			if(isliving(AM))
				var/mob/living/L = am
				if(L.buckled || L.mob_size >= MOB_SIZE_LARGE)
					continue
			target = am

	var/mob/living/mobtarget = target
	if(target && !target.has_buckled_mobs() && (!isliving(target) || !mobtarget.buckled))
		occupant = target
		target.forceMove(src)
	updateUsrDialog()
	update_appearance()
/*
/obj/machinery/proc/auto_use_power() //obsolete, tick controller doesn't call this anymore because machines use addStaticPower now.
	if(!powered(power_channel))
		return 0
	if(use_power == 1)
		use_power(idle_power_usage,power_channel)
	else if(use_power >= 2)
		use_power(active_power_usage,power_channel)
	return 1
*/

///Called when we want to change the value of the `is_operational` variable. Boolean.
/obj/machinery/proc/set_is_operational(new_value)
	if(new_value == is_operational)
		return
	. = is_operational
	is_operational = new_value
	on_set_is_operational(.)


///Called when the value of `is_operational` changes, so we can react to it.
/obj/machinery/proc/on_set_is_operational(old_value)
	return


/obj/machinery/can_interact(mob/user)
	if((machine_stat & (NOPOWER|BROKEN)) && !(interaction_flags_machine & INTERACT_MACHINE_OFFLINE)) // Check if the machine is broken, and if we can still interact with it if so
		return FALSE

	var/silicon = issilicon(user)
	if(panel_open && !(interaction_flags_machine & INTERACT_MACHINE_OPEN)) // Check if we can interact with an open panel machine, if the panel is open
		if(!silicon || !(interaction_flags_machine & INTERACT_MACHINE_OPEN_SILICON))
			return FALSE

	if(silicon || isAdminGhostAI(user)) // If we are an AI or adminghsot, make sure the machine allows silicons to interact
		if(!(interaction_flags_machine & INTERACT_MACHINE_ALLOW_SILICON))
			return FALSE

	else if(isliving(user)) // If we are a living human
		var/mob/living/L = user

		if(interaction_flags_machine & INTERACT_MACHINE_REQUIRES_SILICON) // First make sure the machine doesn't require silicon interaction
			return FALSE

		if(!Adjacent(user)) // Next make sure we are next to the machine unless we have telekinesis
			var/mob/living/carbon/H = L
			if(!(istype(H) && H.has_dna() && H.dna.check_mutation(TK)))
				return FALSE

		if(L.incapacitated()) // Finally make sure we aren't incapacitated
			return FALSE

	else // If we aren't a silicon, living, or admin ghost, bad!
		return FALSE

	return TRUE // If we pass all these checks, woohoo! We can interact

////////////////////////////////////////////////////////////////////////////////////////////

//Return a non FALSE value to interrupt attack_hand propagation to subtypes.
/obj/machinery/interact(mob/user, special_state)
	if(interaction_flags_machine & INTERACT_MACHINE_SET_MACHINE)
		user.set_machine(src)
	. = ..()

/obj/machinery/ui_act(action, list/params)
	add_fingerprint(usr)
	if(isliving(usr) && in_range(src, usr))
		play_click_sound()
	return ..()

/obj/machinery/Topic(href, href_list)
	..()
	if(!can_interact(usr))
		return 1
	if(!usr.canUseTopic(src))
		return 1
	add_fingerprint(usr)
	return 0

////////////////////////////////////////////////////////////////////////////////////////////

/obj/machinery/attack_paw(mob/living/user)
	if(user.a_intent != INTENT_HARM)
		return attack_hand(user)
	else
		user.changeNext_move(CLICK_CD_MELEE)
		user.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
		user.visible_message(span_danger("[user.name] smashes against \the [src.name] with its paws."), null, null, COMBAT_MESSAGE_RANGE)
		take_damage(4, BRUTE, "melee", 1)

/obj/machinery/attack_robot(mob/user)
	if(!(interaction_flags_machine & INTERACT_MACHINE_ALLOW_SILICON) && !isAdminGhostAI(user))
		return FALSE
	if(Adjacent(user) && can_buckle && has_buckled_mobs()) //so that borgs (but not AIs, sadly (perhaps in a future PR?)) can unbuckle people from machines
		if(buckled_mobs.len > 1)
			var/unbuckled = input(user, "Who do you wish to unbuckle?","Unbuckle Who?") as null|mob in sortNames(buckled_mobs)
			if(user_unbuckle_mob(unbuckled,user))
				return TRUE
		else
			if(user_unbuckle_mob(buckled_mobs[1],user))
				return TRUE
	return _try_interact(user)

/obj/machinery/attack_ai(mob/user)
	if(!(interaction_flags_machine & INTERACT_MACHINE_ALLOW_SILICON) && !isAdminGhostAI(user))
		return FALSE
	if(iscyborg(user))// For some reason attack_robot doesn't work
		return attack_robot(user)
	else
		return _try_interact(user)

/obj/machinery/_try_interact(mob/user)
	if((interaction_flags_machine & INTERACT_MACHINE_WIRES_IF_OPEN) && panel_open && (attempt_wire_interaction(user) == WIRE_INTERACTION_BLOCK))
		return TRUE
	return ..()

/obj/machinery/CheckParts(list/parts_list)
	..()
	RefreshParts()

/obj/machinery/proc/RefreshParts() //Placeholder proc for machines that are built using frames.
	return

/obj/machinery/proc/default_pry_open(obj/item/I)
	. = !(state_open || panel_open || is_operational || (flags_1 & NODECONSTRUCT_1)) && I.tool_behaviour == TOOL_CROWBAR
	if(.)
		I.play_tool_sound(src, 50)
		visible_message(span_notice("[usr] pries open \the [src]."), span_notice("You pry open \the [src]."))
		open_machine()

/obj/machinery/proc/default_deconstruction_crowbar(obj/item/I, ignore_panel = 0)
	. = (panel_open || ignore_panel) && !(flags_1 & NODECONSTRUCT_1) && I.tool_behaviour == TOOL_CROWBAR
	if(.)
		I.play_tool_sound(src, 50)
		deconstruct(TRUE)

/obj/machinery/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		on_deconstruction()
		if(circuit)
			circuit.forceMove(loc)
			circuit = null
		if(length(component_parts))
			spawn_frame(disassembled)
			for(var/obj/item/I in component_parts)
				I.forceMove(loc)
			component_parts.Cut()
	SEND_SIGNAL(src, COMSIG_OBJ_DECONSTRUCT, disassembled)
	qdel(src)

/**
 * Spawns a frame where this machine is. If the machine was not disassmbled, the
 * frame is spawned damaged. If the frame couldn't exist on this turf, it's smashed
 * down to metal sheets.
 *
 * Arguments:
 * * disassembled - If FALSE, the machine was destroyed instead of disassembled and the frame spawns at reduced integrity.
 */
/obj/machinery/proc/spawn_frame(disassembled)
	var/obj/structure/frame/machine/new_frame = new /obj/structure/frame/machine(loc)

	new_frame.state = 2

	// If the new frame shouldn't be able to fit here due to the turf being blocked, spawn the frame deconstructed.
	if(isturf(loc))
		var/turf/machine_turf = loc
		// We're spawning a frame before this machine is qdeleted, so we want to ignore it. We've also just spawned a new frame, so ignore that too.
		if(machine_turf.is_blocked_turf(TRUE, source_atom = new_frame, ignore_atoms = list(src)))
			new_frame.deconstruct(disassembled)
			return

	new_frame.icon_state = "box_1"
	. = new_frame
	new_frame.set_anchored(anchored)
	if(!disassembled)
		new_frame.atom_integrity = new_frame.max_integrity * 0.5 //the frame is already half broken
	transfer_fingerprints_to(new_frame)


/obj/machinery/atom_break(damage_flag)
	SHOULD_CALL_PARENT(1)
	. = ..()
	if(!(machine_stat & BROKEN) && !(flags_1 & NODECONSTRUCT_1))
		set_machine_stat(machine_stat | BROKEN)
		SEND_SIGNAL(src, COMSIG_MACHINERY_BROKEN, damage_flag)
		update_appearance()
		return TRUE

/obj/machinery/contents_explosion(severity, target)
	if(occupant)
		occupant.ex_act(severity, target)

/obj/machinery/handle_atom_del(atom/A)
	if(A == occupant)
		occupant = null
		update_appearance()
		updateUsrDialog()
		return ..()

	// The circuit should also be in component parts, so don't early return.
	if(A == circuit)
		circuit = null
	if((A in component_parts) && !QDELETED(src))
		component_parts.Remove(A)
		// It would be unusual for a component_part to be qdel'd ordinarily.
		deconstruct(FALSE)
	return ..()

/obj/machinery/proc/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/I)
	if(!(flags_1 & NODECONSTRUCT_1) && I.tool_behaviour == TOOL_SCREWDRIVER)
		I.play_tool_sound(src, 50)
		if(!panel_open)
			panel_open = TRUE
			icon_state = icon_state_open
			to_chat(user, span_notice("You open the maintenance hatch of [src]."))
		else
			panel_open = FALSE
			icon_state = icon_state_closed
			to_chat(user, span_notice("You close the maintenance hatch of [src]."))
		return TRUE
	return FALSE

/obj/machinery/proc/default_change_direction_wrench(mob/user, obj/item/I)
	if(panel_open && I.tool_behaviour == TOOL_WRENCH)
		I.play_tool_sound(src, 50)
		setDir(turn(dir,-90))
		to_chat(user, span_notice("You rotate [src]."))
		return 1
	return 0

/obj/proc/can_be_unfasten_wrench(mob/user, silent) //if we can unwrench this object; returns SUCCESSFUL_UNFASTEN and FAILED_UNFASTEN, which are both TRUE, or CANT_UNFASTEN, which isn't.
	if(!(isfloorturf(loc) || istype(loc, /turf/open/indestructible)) && !anchored)
		to_chat(user, span_warning("[src] needs to be on the floor to be secured!"))
		return FAILED_UNFASTEN
	return SUCCESSFUL_UNFASTEN

/obj/proc/default_unfasten_wrench(mob/user, obj/item/I, time = 20) //try to unwrench an object in a WONDERFUL DYNAMIC WAY
	if(!(flags_1 & NODECONSTRUCT_1) && I.tool_behaviour == TOOL_WRENCH)
		var/turf/ground = get_turf(src)
		if(!anchored && ground.is_blocked_turf(exclude_mobs = TRUE, source_atom = src))
			to_chat(user, span_notice("You fail to secure [src]."))
			return CANT_UNFASTEN
		var/can_be_unfasten = can_be_unfasten_wrench(user)
		if(!can_be_unfasten || can_be_unfasten == FAILED_UNFASTEN)
			return can_be_unfasten
		if(time)
			to_chat(user, span_notice("You begin [anchored ? "un" : ""]securing [src]..."))
		I.play_tool_sound(src, 50)
		var/prev_anchored = anchored
		//as long as we're the same anchored state and we're either on a floor or are anchored, toggle our anchored state
		if(I.use_tool(src, user, time, extra_checks = CALLBACK(src, PROC_REF(unfasten_wrench_check), prev_anchored, user)))
			if(!anchored && ground.is_blocked_turf(exclude_mobs = TRUE, source_atom = src))
				to_chat(user, span_notice("You fail to secure [src]."))
				return CANT_UNFASTEN
			to_chat(user, span_notice("You [anchored ? "un" : ""]secure [src]."))
			set_anchored(!anchored)
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			SEND_SIGNAL(src, COMSIG_OBJ_DEFAULT_UNFASTEN_WRENCH, anchored)
			return SUCCESSFUL_UNFASTEN
		return FAILED_UNFASTEN
	return CANT_UNFASTEN

/obj/proc/unfasten_wrench_check(prev_anchored, mob/user) //for the do_after, this checks if unfastening conditions are still valid
	if(anchored != prev_anchored)
		return FALSE
	if(can_be_unfasten_wrench(user, TRUE) != SUCCESSFUL_UNFASTEN) //if we aren't explicitly successful, cancel the fuck out
		return FALSE
	return TRUE

/obj/machinery/proc/exchange_parts(mob/user, obj/item/storage/part_replacer/W)
	if(!istype(W))
		return FALSE
	if((flags_1 & NODECONSTRUCT_1) && !W.works_from_distance)
		return FALSE
	var/shouldplaysound = 0
	if(component_parts)
		if(panel_open || W.works_from_distance)
			var/obj/item/circuitboard/machine/CB = locate(/obj/item/circuitboard/machine) in component_parts
			var/P
			if(W.works_from_distance)
				to_chat(user, display_parts(user))
			for(var/obj/item/A in component_parts)
				for(var/D in CB.req_components)
					if(ispath(A.type, D))
						P = D
						break
				for(var/obj/item/B in W.contents)
					if(istype(B, P) && istype(A, P))
						if(B.get_part_rating() > A.get_part_rating())
							if(istype(B,/obj/item/stack)) //conveniently this will mean A is also a stack and I will kill the first person to prove me wrong
								var/obj/item/stack/SA = A
								var/obj/item/stack/SB = B
								var/used_amt = SA.get_amount()
								if(!SB.use(used_amt))
									continue //if we don't have the exact amount to replace we don't
								var/obj/item/stack/SN = new SB.merge_type(null,used_amt)
								component_parts += SN
							else
								if(SEND_SIGNAL(W, COMSIG_TRY_STORAGE_TAKE, B, src))
									component_parts += B
									B.moveToNullspace()
							SEND_SIGNAL(W, COMSIG_TRY_STORAGE_INSERT, A, null, null, TRUE)
							component_parts -= A
							to_chat(user, span_notice("[capitalize(A.name)] replaced with [B.name]."))
							shouldplaysound = 1 //Only play the sound when parts are actually replaced!
							break
			RefreshParts()
		else
			to_chat(user, display_parts(user))
		if(shouldplaysound)
			W.play_rped_sound()
		return TRUE
	return FALSE

/obj/machinery/proc/display_parts(mob/user)
	. = list()
	. += span_notice("It contains the following parts:")
	for(var/obj/item/C in component_parts)
		. += span_notice("[icon2html(C, user)] \A [C].")
	. = jointext(., "")

/obj/machinery/examine(mob/user)
	. = ..()
	if(machine_stat & BROKEN)
		. += span_notice("It looks broken and non-functional.")
	if(!(resistance_flags & INDESTRUCTIBLE))
		if(resistance_flags & ON_FIRE)
			. += span_warning("It's on fire!")
		var/healthpercent = (atom_integrity/max_integrity) * 100
		switch(healthpercent)
			if(50 to 99)
				. += "It looks slightly damaged."
			if(25 to 50)
				. += "It appears heavily damaged."
			if(0 to 25)
				. += span_warning("It's falling apart!")
	if(user.research_scanner && component_parts)
		. += display_parts(user, TRUE)

//called on machinery construction (i.e from frame to machinery) but not on initialization
/obj/machinery/proc/on_construction()
	return

//called on deconstruction before the final deletion
/obj/machinery/proc/on_deconstruction()
	set_no_power()
	return

/obj/machinery/proc/can_be_overridden()
	. = 1

/obj/machinery/zap_act(power, zap_flags, shocked_objects)
	. = ..()
	if(prob(85) && (zap_flags & ZAP_MACHINE_EXPLOSIVE) && !(resistance_flags & INDESTRUCTIBLE))
		explosion(src, 0, 1, 2, flame_range = 2, adminlog = FALSE, smoke = FALSE)
	else if(zap_flags & ZAP_OBJ_DAMAGE)
		take_damage(power/2000, BURN, "energy")
		if(prob(40))
			emp_act(EMP_LIGHT)

/obj/machinery/Exited(atom/movable/AM, atom/newloc)
	. = ..()
	if (AM == occupant)
		occupant = null

/obj/machinery/proc/adjust_item_drop_location(atom/movable/AM)	// Adjust item drop location to a 3x3 grid inside the tile, returns slot id from 0 to 8
	var/md5 = md5(AM.name)										// Oh, and it's deterministic too. A specific item will always drop from the same slot.
	for (var/i in 1 to 32)
		. += hex2num(md5[i])
	. = . % 9
	AM.pixel_x = -8 + ((.%3)*8)
	AM.pixel_y = -8 + (round(. / 3)*8)

/obj/machinery/proc/play_click_sound(custom_clicksound)
	if((custom_clicksound||clicksound) && world.time > next_clicksound)
		next_clicksound = world.time + CLICKSOUND_INTERVAL
		if(custom_clicksound)
			playsound(src, custom_clicksound, clickvol)
		else if(clicksound)
			playsound(src, clicksound, clickvol)
	return
