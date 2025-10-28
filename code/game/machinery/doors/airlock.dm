/*
	New methods:
	pulse - sends a pulse into a wire for hacking purposes
	cut - cuts a wire and makes any necessary state changes
	mend - mends a wire and makes any necessary state changes
	canAIControl - 1 if the AI can control the airlock, 0 if not (then check canAIHack to see if it can hack in)
	canAIHack - 1 if the AI can hack into the airlock to recover control, 0 if not. Also returns 0 if the AI does not *need* to hack it.
	hasPower - 1 if the main or backup power are functioning, 0 if not.
	requiresIDs - 1 if the airlock is requiring IDs, 0 if not
	isAllPowerCut - 1 if the main and backup power both have cut wires.
	regainMainPower - handles the effect of main power coming back on.
	loseMainPower - handles the effect of main power going offline. Usually (if one isn't already running) spawn a thread to count down how long it will be offline - counting down won't happen if main power was completely cut along with backup power, though, the thread will just sleep.
	loseBackupPower - handles the effect of backup power going offline.
	regainBackupPower - handles the effect of main power coming back on.
	shock - has a chance of electrocuting its target.
*/

// Wires for the airlock are located in the datum folder, inside the wires datum folder.

#define AIRLOCK_CLOSED 1
#define AIRLOCK_CLOSING 2
#define AIRLOCK_OPEN 3
#define AIRLOCK_OPENING 4
#define AIRLOCK_DENY 5
#define AIRLOCK_EMAG 6

#define AIRLOCK_SECURITY_NONE 0 //Normal airlock				//Wires are not secured
#define AIRLOCK_SECURITY_METAL 1 //Medium security airlock		//There is a simple metal over wires (use welder)
#define AIRLOCK_SECURITY_PLASTEEL_I_S 2 								//Sliced inner plating (use crowbar), jumps to 0
#define AIRLOCK_SECURITY_PLASTEEL_I 3 								//Removed outer plating, second layer here (use welder)
#define AIRLOCK_SECURITY_PLASTEEL_O_S 4 								//Sliced outer plating (use crowbar)
#define AIRLOCK_SECURITY_PLASTEEL_O 5 								//There is first layer of plasteel (use welder)
#define AIRLOCK_SECURITY_PLASTEEL 6 //Max security airlock		//Fully secured wires (use wirecutters to remove grille, that is electrified)

#define AIRLOCK_INTEGRITY_N 300 // Normal airlock integrity
#define AIRLOCK_INTEGRITY_MULTIPLIER 1.5 // How much reinforced doors health increases
/// How much extra health airlocks get when braced with a seal
#define AIRLOCK_SEAL_MULTIPLIER 2
#define AIRLOCK_DAMAGE_DEFLECTION_N 21  // Normal airlock damage deflection
#define AIRLOCK_DAMAGE_DEFLECTION_R 30  // Reinforced airlock damage deflection

/obj/machinery/door/airlock
	name = "airlock"
	icon = 'icons/obj/doors/airlocks/station/public.dmi'
	icon_state = "closed"
	max_integrity = 300
	var/normal_integrity = AIRLOCK_INTEGRITY_N
	integrity_failure = 0.25
	damage_deflection = AIRLOCK_DAMAGE_DEFLECTION_N
	autoclose = TRUE
	secondsElectrified = MACHINE_NOT_ELECTRIFIED //How many seconds remain until the door is no longer electrified. -1/MACHINE_ELECTRIFIED_PERMANENT = permanently electrified until someone fixes it.
	assemblytype = /obj/structure/door_assembly
	fast_close = FALSE
	explosion_block = 1
	hud_possible = list(DIAG_AIRLOCK_HUD)
	req_ship_access = TRUE

	close_speed = 150

	smoothing_groups = list(SMOOTH_GROUP_AIRLOCK)

	FASTDMM_PROP(\
		pinned_vars = list("req_access_txt", "req_one_access_txt", "name")\
	)

	interaction_flags_machine = INTERACT_MACHINE_WIRES_IF_OPEN | INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN_SILICON | INTERACT_MACHINE_REQUIRES_SILICON | INTERACT_MACHINE_OPEN

	var/security_level = 0 //How much are wires secured
	var/aiControlDisabled = AI_WIRE_NORMAL //If 1, AI control is disabled until the AI hacks back in and disables the lock. If 2, the AI has bypassed the lock. If -1, the control is enabled but the AI had bypassed it earlier, so if it is disabled again the AI would have no trouble getting back in.
	var/hackProof = FALSE // if true, this door can't be hacked by the AI
	var/secondsMainPowerLost = 0 //The number of seconds until power is restored.
	var/secondsBackupPowerLost = 0 //The number of seconds until power is restored.
	var/spawnPowerRestoreRunning = FALSE
	var/lights = TRUE // bolt lights show by default
	var/aiDisabledIdScanner = FALSE
	var/aiHacking = FALSE
	var/closeOtherId //Cyclelinking for airlocks that aren't on the same x or y coord as the target.
	var/obj/machinery/door/airlock/closeOther
	var/justzap = FALSE
	var/obj/item/electronics/airlock/electronics
	var/shockCooldown = FALSE //Prevents multiple shocks from happening
	var/obj/item/note //Any papers pinned to the airlock
	/// The seal on the airlock
	var/obj/item/seal
	var/detonated = FALSE
	var/abandoned = FALSE

	var/doorOpen = 'sound/machines/airlocks/standard/open.ogg'
	var/doorClose = 'sound/machines/airlocks/standard/close.ogg'
	var/doorDeni = 'sound/machines/airlocks/access_denied.ogg' // i'm thinkin' Deni's
	var/boltUp = 'sound/machines/airlocks/bolts_up.ogg'
	var/boltDown = 'sound/machines/airlocks/bolts_down.ogg'

	var/pry_sound = 'sound/machines/creaking.ogg'
	var/pry_open_sound = 'sound/machines/airlocks/open_force.ogg'
	var/pry_close_sound = 'sound/machines/airlocks/close_force.ogg'

	var/noPower = 'sound/machines/doorclick.ogg'

	var/previous_airlock = /obj/structure/door_assembly //what airlock assembly mineral plating was applied to
	var/airlock_material //material of inner filling; if its an airlock with glass, this should be set to "glass"
	var/overlays_file = 'icons/obj/doors/airlocks/station/overlays.dmi'
	var/note_overlay_file = 'icons/obj/doors/airlocks/station/overlays.dmi' //Used for papers and photos pinned to the airlock

	var/cyclelinkeddir = 0
	var/cyclelinkedx = 0			//WS start	negative is left positive is right
	var/cyclelinkedy = 0			//WS end		negative is down positive is up
	var/obj/machinery/door/airlock/cyclelinkedairlock
	var/shuttledocked = 0
	var/delayed_close_requested = FALSE // TRUE means the door will automatically close the next time it's opened.

	var/prying_so_hard = FALSE

	flags_1 = RAD_PROTECT_CONTENTS_1 | RAD_NO_CONTAMINATE_1 | HTML_USE_INITAL_ICON_1
	rad_insulation = RAD_MEDIUM_INSULATION

	var/static/list/airlock_overlays = list()

	var/has_hatch = TRUE //If TRUE, this door has hatches, and certain small creatures can move through them without opening the door
	var/hatchstate = 0 //0: closed, 1: open
	var/hatch_offset_x = 0
	var/hatch_offset_y = 0
	var/hatch_colour = "#7d7d7d"
	var/hatch_open_sound = 'sound/machines/airlocks/hatch/hatch_open.ogg'
	var/hatch_close_sound = 'sound/machines/airlocks/hatch/hatch_close.ogg'

/obj/machinery/door/airlock/Initialize()
	. = ..()
	wires = new /datum/wires/airlock(src)
	if(frequency)
		set_frequency(frequency)

	if(closeOtherId != null)
		addtimer(CALLBACK(PROC_REF(update_other_id)), 5)
	if(glass)
		airlock_material = "glass"
	if(security_level > AIRLOCK_SECURITY_METAL)
		atom_integrity = normal_integrity * AIRLOCK_INTEGRITY_MULTIPLIER
		max_integrity = normal_integrity * AIRLOCK_INTEGRITY_MULTIPLIER
	else
		atom_integrity = normal_integrity
		max_integrity = normal_integrity
	if(damage_deflection == AIRLOCK_DAMAGE_DEFLECTION_N && security_level > AIRLOCK_SECURITY_METAL)
		damage_deflection = AIRLOCK_DAMAGE_DEFLECTION_R
	prepare_huds()
	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.add_to_hud(src)
	diag_hud_set_electrified()

	RegisterSignal(src, COMSIG_MACHINERY_BROKEN, PROC_REF(on_break))

	update_appearance()

	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_EXITED = PROC_REF(on_exited)
	)
	AddElement(/datum/element/connect_loc, connections)

	return INITIALIZE_HINT_LATELOAD

/obj/machinery/door/airlock/LateInitialize()
	. = ..()
	if(cyclelinkedx || cyclelinkedy)	//WS start
		cyclelinkairlock_target()
	else
		if(cyclelinkeddir)
			cyclelinkairlock()		//WS end
	if(abandoned)
		var/outcome = rand(1,100)
		switch(outcome)
			if(1 to 11)
				lights = FALSE
				locked = TRUE
			if(12 to 15)
				locked = TRUE
			if(16 to 23)
				welded = TRUE
			if(24 to 30)
				panel_open = TRUE
			if(31 to 40)
				panel_open = TRUE
				set_electrified(MACHINE_ELECTRIFIED_PERMANENT)
			if(41 to 50)
				seal = new /obj/item/door_seal(src)
				modify_max_integrity(max_integrity * AIRLOCK_SEAL_MULTIPLIER)
			if(51 to 60)
				new previous_airlock(loc)
				qdel(src)
			if(69)
				new /obj/effect/decal/cleanable/oil/slippery(loc)


	update_appearance()

/obj/machinery/door/airlock/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/ntnet_interface)

/obj/machinery/door/airlock/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	if(id_tag)
		id_tag = "[REF(port)][id_tag]"

/obj/machinery/door/airlock/CanPass(atom/movable/mover, turf/target)
	. = ..()
	if(density && has_hatch && (mover.pass_flags & PASSDOORHATCH))
		return TRUE //If this airlock is closed, has hatches, and this creature can go through hatches, then we let it through without opening the airlock

/obj/machinery/door/airlock/proc/on_entered(datum/source, atom/movable/mover)
	SIGNAL_HANDLER
	if(density && has_hatch && (mover.pass_flags & PASSDOORHATCH) && !hatchstate)
		hatchstate = 1
		update_appearance()
		playsound(loc, hatch_open_sound, 40, 1, -1, mono_adj = TRUE)
		if(mover.layer != initial(mover.layer))
			return
		mover.layer = UNDERDOOR

/obj/machinery/door/airlock/proc/on_exited(datum/source, atom/movable/mover)
	SIGNAL_HANDLER
	if(density && has_hatch && (mover.pass_flags & PASSDOORHATCH))
		mover.layer = initial(mover.layer)
		close_hatch()

/obj/machinery/door/airlock/proc/close_hatch()
	hatchstate = 0
	update_appearance()
	playsound(loc, hatch_close_sound, 30, 1, -1, mono_adj = TRUE)

/obj/machinery/door/airlock/proc/update_other_id()
	for(var/obj/machinery/door/airlock/A in GLOB.airlocks)
		if(A.closeOtherId == closeOtherId && A != src)
			closeOther = A
			break

/obj/machinery/door/airlock/proc/cyclelinkairlock_target()		//WS start
	if (cyclelinkedairlock)
		cyclelinkedairlock.cyclelinkedairlock = null
		cyclelinkedairlock = null
	if(!cyclelinkedx && !cyclelinkedy)
		return
	var/turf/T = get_turf(src)
	var/obj/machinery/door/airlock/FoundDoor
	var/dirlook
	var/targ
	if(cyclelinkedx)
		if(cyclelinkedx > 0)
			targ = cyclelinkedx
			dirlook = 4
		else
			targ = cyclelinkedx * -1
			dirlook = 8
		for(var/i = 0; i < targ; i++)
			T = get_step(T, dirlook)

	if(cyclelinkedy)
		if(cyclelinkedy > 0)
			targ = cyclelinkedy
			dirlook = 1
		else
			targ = cyclelinkedy * -1
			dirlook = 2
		for(var/i = 0; i < targ; i++)
			T = get_step(T, dirlook)

	FoundDoor = locate() in T
	if (FoundDoor && (FoundDoor.cyclelinkedy != -1 * cyclelinkedy || FoundDoor.cyclelinkedx != -1 * cyclelinkedx))
		FoundDoor = null
	if (!FoundDoor)
		log_mapping("[src] at [AREACOORD(src)] failed to find a valid airlock to cyclelink_target with! Was targeting [T.x], [T.y], [T.z].")
		return
	FoundDoor.cyclelinkedairlock = src
	cyclelinkedairlock = FoundDoor				//WS end

/obj/machinery/door/airlock/proc/cyclelinkairlock()
	if (cyclelinkedairlock)
		cyclelinkedairlock.cyclelinkedairlock = null
		cyclelinkedairlock = null
	if (!cyclelinkeddir)
		return
	var/limit = world.view
	var/turf/T = get_turf(src)
	var/obj/machinery/door/airlock/FoundDoor
	do
		T = get_step(T, cyclelinkeddir)
		FoundDoor = locate() in T
		if (FoundDoor && FoundDoor.cyclelinkeddir != get_dir(FoundDoor, src))
			FoundDoor = null
		limit--
	while(!FoundDoor && limit)
	if (!FoundDoor)
		log_mapping("[src] at [AREACOORD(src)] failed to find a valid airlock to cyclelink with!")
		return
	FoundDoor.cyclelinkedairlock = src
	cyclelinkedairlock = FoundDoor

/obj/machinery/door/airlock/vv_edit_var(var_name)
	. = ..()
	switch (var_name)
		if (NAMEOF(src, cyclelinkedx))				//WS start
			cyclelinkairlock_target()
		if (NAMEOF(src, cyclelinkedy))
			cyclelinkairlock_target()	//WS end
		if (NAMEOF(src, cyclelinkeddir))
			cyclelinkairlock()

/obj/machinery/door/airlock/check_access_ntnet(datum/netdata/data)
	return !requiresID() || ..()

/obj/machinery/door/airlock/ntnet_receive(datum/netdata/data)
	// Check if the airlock is powered and can accept control packets.
	if(!hasPower() || !canAIControl())
		return

	// Check packet access level.
	if(!check_access_ntnet(data))
		return

	// Handle received packet.
	var/command = lowertext(data.data["data"])
	var/command_value = lowertext(data.data["data_secondary"])
	switch(command)
		if("open")
			if(command_value == "on" && !density)
				return

			if(command_value == "off" && density)
				return

			if(density)
				INVOKE_ASYNC(src, PROC_REF(open))
			else
				INVOKE_ASYNC(src, PROC_REF(close))

		if("bolt")
			if(command_value == "on" && locked)
				return

			if(command_value == "off" && !locked)
				return

			if(locked)
				unbolt()
			else
				bolt()

		if("emergency")
			if(command_value == "on" && emergency)
				return

			if(command_value == "off" && !emergency)
				return

			emergency = !emergency
			update_appearance()

/obj/machinery/door/airlock/lock()
	bolt()

/obj/machinery/door/airlock/proc/bolt()
	if(locked)
		return
	locked = TRUE
	playsound(src, boltDown, 30, FALSE, 3, mono_adj = TRUE)
	audible_message(span_hear("You hear a click from the bottom of the door."), null, 1)
	update_appearance()

/obj/machinery/door/airlock/unlock()
	unbolt()

/obj/machinery/door/airlock/proc/unbolt()
	if(!locked)
		return
	locked = FALSE
	playsound(src, boltUp, 30, FALSE, 3, mono_adj = TRUE)
	audible_message(span_hear("You hear a click from the bottom of the door."), null, 1)
	update_appearance()

/obj/machinery/door/airlock/Destroy()
	QDEL_NULL(wires)
	QDEL_NULL(electronics)
	if(closeOther)
		closeOther.closeOther = null
		closeOther = null
	if (cyclelinkedairlock)
		if (cyclelinkedairlock.cyclelinkedairlock == src)
			cyclelinkedairlock.cyclelinkedairlock = null
		cyclelinkedairlock = null
	if(id_tag)
		for(var/obj/machinery/doorButtons/D in GLOB.machines)
			D.removeMe(src)
	QDEL_NULL(note)
	QDEL_NULL(seal)
	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.remove_from_hud(src)
	return ..()

/obj/machinery/door/airlock/handle_atom_del(atom/A)
	if(A == note)
		note = null
		update_appearance()
	if(A == seal)
		seal = null
		update_appearance()

/obj/machinery/door/airlock/bumpopen(mob/living/user) //Airlocks now zap you when you 'bump' them open when they're electrified. --NeoFite
	if(!issilicon(usr))
		if(isElectrified())
			if(!justzap)
				if(shock(user, 100))
					justzap = TRUE
					addtimer(VARSET_CALLBACK(src, justzap, FALSE) , 10)
					return
			else
				return
		else if(user.hallucinating() && ishuman(user) && prob(1) && !operating)
			var/mob/living/carbon/human/H = user
			if(H.gloves)
				var/obj/item/clothing/gloves/G = H.gloves
				if(G.siemens_coefficient)//not insulated
					new /datum/hallucination/shock(H)
					return
	else
		if(aiControlDisabled == AI_WIRE_DISABLED)
			return
	if (cyclelinkedairlock)
		if (!shuttledocked && !emergency && !cyclelinkedairlock.shuttledocked && !cyclelinkedairlock.emergency && allowed(user))
			if(cyclelinkedairlock.operating)
				cyclelinkedairlock.delayed_close_requested = TRUE
			else
				addtimer(CALLBACK(cyclelinkedairlock, PROC_REF(close)), 2)
	if(locked && allowed(user) && aac)
		aac.request_from_door(src)
		return
	..()

/obj/machinery/door/airlock/proc/isElectrified()
	if(secondsElectrified != MACHINE_NOT_ELECTRIFIED)
		return TRUE
	return FALSE

/obj/machinery/door/airlock/proc/canAIControl(mob/user)
	return ((aiControlDisabled != AI_WIRE_DISABLED) && !isAllPowerCut() && check_ship_ai_access(user))

/obj/machinery/door/airlock/proc/canAIHack()
	return ((aiControlDisabled==AI_WIRE_DISABLED) && (!hackProof) && (!isAllPowerCut()));

/obj/machinery/door/airlock/hasPower()
	return ((!secondsMainPowerLost || !secondsBackupPowerLost) && !(machine_stat & NOPOWER))

/obj/machinery/door/airlock/requiresID()
	return !(wires.is_cut(WIRE_IDSCAN) || aiDisabledIdScanner)

/obj/machinery/door/airlock/proc/isAllPowerCut()
	if((wires.is_cut(WIRE_POWER1) || wires.is_cut(WIRE_POWER2)) && (wires.is_cut(WIRE_BACKUP1) || wires.is_cut(WIRE_BACKUP2)))
		return TRUE

/obj/machinery/door/airlock/proc/regainMainPower()
	if(secondsMainPowerLost > 0)
		secondsMainPowerLost = 0
	update_appearance()

/obj/machinery/door/airlock/proc/handlePowerRestore()
	var/cont = TRUE
	while (cont)
		sleep(10)
		if(QDELETED(src))
			return
		cont = FALSE
		if(secondsMainPowerLost>0)
			if(!wires.is_cut(WIRE_POWER1) && !wires.is_cut(WIRE_POWER2))
				secondsMainPowerLost -= 1
				updateDialog()
			cont = TRUE
		if(secondsBackupPowerLost>0)
			if(!wires.is_cut(WIRE_BACKUP1) && !wires.is_cut(WIRE_BACKUP2))
				secondsBackupPowerLost -= 1
				updateDialog()
			cont = TRUE
	spawnPowerRestoreRunning = FALSE
	updateDialog()
	update_appearance()

/obj/machinery/door/airlock/proc/loseMainPower()
	if(secondsMainPowerLost <= 0)
		secondsMainPowerLost = 60
		if(secondsBackupPowerLost < 10)
			secondsBackupPowerLost = 10
	if(!spawnPowerRestoreRunning)
		spawnPowerRestoreRunning = TRUE
	INVOKE_ASYNC(src, PROC_REF(handlePowerRestore))
	update_appearance()

/obj/machinery/door/airlock/proc/loseBackupPower()
	if(secondsBackupPowerLost < 60)
		secondsBackupPowerLost = 60
	if(!spawnPowerRestoreRunning)
		spawnPowerRestoreRunning = TRUE
	INVOKE_ASYNC(src, PROC_REF(handlePowerRestore))
	update_appearance()

/obj/machinery/door/airlock/proc/regainBackupPower()
	if(secondsBackupPowerLost > 0)
		secondsBackupPowerLost = 0
	update_appearance()

// shock user with probability prb (if all connections & power are working)
// returns TRUE if shocked, FALSE otherwise
// The preceding comment was borrowed from the grille's shock script
/obj/machinery/door/airlock/proc/shock(mob/living/user, prb)
	if(!istype(user) || !hasPower())		// unpowered, no shock
		return FALSE
	if(shockCooldown > world.time)
		return FALSE	//Already shocked someone recently?
	if(!prob(prb))
		return FALSE //you lucked out, no shock for you
	do_sparks(5, TRUE, src)
	var/check_range = TRUE
	if(electrocute_mob(user, get_area(src), src, 1, check_range))
		shockCooldown = world.time + 10
		return TRUE
	else
		return FALSE

/obj/machinery/door/airlock/update_icon(updates=ALL, state=0, override=FALSE)
	if(operating && !override)
		return
	if(!state)
		state = density ? AIRLOCK_CLOSED : AIRLOCK_OPEN
	airlock_state = state

	. = ..()

	if(hasPower() && unres_sides)
		set_light(2, 1)
	else
		set_light(0)

/obj/machinery/door/airlock/update_icon_state()
	. = ..()
	switch(airlock_state)
		if(AIRLOCK_OPEN, AIRLOCK_CLOSED)
			icon_state = ""
		if(AIRLOCK_DENY, AIRLOCK_OPENING, AIRLOCK_CLOSING, AIRLOCK_EMAG)
			icon_state = "nonexistenticonstate" //MADNESS

/obj/machinery/door/airlock/update_overlays()
	. = ..()

	var/mutable_appearance/frame_overlay
	var/mutable_appearance/filling_overlay
	var/mutable_appearance/lights_overlay
	var/mutable_appearance/panel_overlay
	var/mutable_appearance/weld_overlay
	var/mutable_appearance/damag_overlay
	var/mutable_appearance/sparks_overlay
	var/mutable_appearance/note_overlay
	var/mutable_appearance/seal_overlay
	var/notetype = note_type()
	var/mutable_appearance/hatch_overlay

	switch(airlock_state)
		if(AIRLOCK_CLOSED)
			frame_overlay = get_airlock_overlay("closed", icon)
			if(airlock_material)
				filling_overlay = get_airlock_overlay("[airlock_material]_closed", overlays_file)
			else
				filling_overlay = get_airlock_overlay("fill_closed", icon)
			if(panel_open)
				if(security_level)
					panel_overlay = get_airlock_overlay("panel_closed_protected", overlays_file)
				else
					panel_overlay = get_airlock_overlay("panel_closed", overlays_file)
			if(welded)
				weld_overlay = get_airlock_overlay("welded", overlays_file)
			if(seal)
				seal_overlay = get_airlock_overlay("sealed", overlays_file)
			if(atom_integrity < integrity_failure * max_integrity)
				damag_overlay = get_airlock_overlay("sparks_broken", overlays_file)
			else if(atom_integrity < (0.75 * max_integrity))
				damag_overlay = get_airlock_overlay("sparks_damaged", overlays_file)
			if(lights && hasPower())
				if(locked)
					lights_overlay = get_airlock_overlay("lights_bolts", overlays_file)
				else if(emergency)
					lights_overlay = get_airlock_overlay("lights_emergency", overlays_file)
			if(note)
				note_overlay = get_airlock_overlay(notetype, note_overlay_file)
			if(has_hatch)
				if(hatchstate)
					hatch_overlay = get_airlock_overlay("hatch_open", icon)
				else
					hatch_overlay = get_airlock_overlay("hatch_closed", icon)

		if(AIRLOCK_DENY)
			if(!hasPower())
				return
			frame_overlay = get_airlock_overlay("closed", icon)
			if(airlock_material)
				filling_overlay = get_airlock_overlay("[airlock_material]_closed", overlays_file)
			else
				filling_overlay = get_airlock_overlay("fill_closed", icon)
			if(panel_open)
				if(security_level)
					panel_overlay = get_airlock_overlay("panel_closed_protected", overlays_file)
				else
					panel_overlay = get_airlock_overlay("panel_closed", overlays_file)
			if(atom_integrity < integrity_failure * max_integrity)
				damag_overlay = get_airlock_overlay("sparks_broken", overlays_file)
			else if(atom_integrity < (0.75 * max_integrity))
				damag_overlay = get_airlock_overlay("sparks_damaged", overlays_file)
			if(welded)
				weld_overlay = get_airlock_overlay("welded", overlays_file)
			if(seal)
				seal_overlay = get_airlock_overlay("sealed", overlays_file)
			lights_overlay = get_airlock_overlay("lights_denied", overlays_file)
			if(note)
				note_overlay = get_airlock_overlay(notetype, note_overlay_file)
			if(has_hatch)
				if(hatchstate)
					hatch_overlay = get_airlock_overlay("hatch_open", icon)
				else
					hatch_overlay = get_airlock_overlay("hatch_closed", icon)

		if(AIRLOCK_EMAG)
			frame_overlay = get_airlock_overlay("closed", icon)
			sparks_overlay = get_airlock_overlay("sparks", overlays_file)
			if(airlock_material)
				filling_overlay = get_airlock_overlay("[airlock_material]_closed", overlays_file)
			else
				filling_overlay = get_airlock_overlay("fill_closed", icon)
			if(panel_open)
				if(security_level)
					panel_overlay = get_airlock_overlay("panel_closed_protected", overlays_file)
				else
					panel_overlay = get_airlock_overlay("panel_closed", overlays_file)
			if(atom_integrity < integrity_failure * max_integrity)
				damag_overlay = get_airlock_overlay("sparks_broken", overlays_file)
			else if(atom_integrity < (0.75 * max_integrity))
				damag_overlay = get_airlock_overlay("sparks_damaged", overlays_file)
			if(welded)
				weld_overlay = get_airlock_overlay("welded", overlays_file)
			if(seal)
				seal_overlay = get_airlock_overlay("sealed", overlays_file)
			if(note)
				note_overlay = get_airlock_overlay(notetype, note_overlay_file)

		if(AIRLOCK_CLOSING)
			frame_overlay = get_airlock_overlay("closing", icon)
			if(airlock_material)
				filling_overlay = get_airlock_overlay("[airlock_material]_closing", overlays_file)
			else
				filling_overlay = get_airlock_overlay("fill_closing", icon)
			if(lights && hasPower())
				lights_overlay = get_airlock_overlay("lights_closing", overlays_file)
			if(panel_open)
				if(security_level)
					panel_overlay = get_airlock_overlay("panel_closing_protected", overlays_file)
				else
					panel_overlay = get_airlock_overlay("panel_closing", overlays_file)
			if(note)
				note_overlay = get_airlock_overlay("[notetype]_closing", note_overlay_file)
			if(has_hatch)
				hatch_overlay = get_airlock_overlay("hatch_closing", icon)

		if(AIRLOCK_OPEN)
			frame_overlay = get_airlock_overlay("open", icon)
			if(airlock_material)
				filling_overlay = get_airlock_overlay("[airlock_material]_open", overlays_file)
			else
				filling_overlay = get_airlock_overlay("fill_open", icon)
			if(panel_open)
				if(security_level)
					panel_overlay = get_airlock_overlay("panel_open_protected", overlays_file)
				else
					panel_overlay = get_airlock_overlay("panel_open", overlays_file)
			if(atom_integrity < (0.75 * max_integrity))
				damag_overlay = get_airlock_overlay("sparks_open", overlays_file)
			if(note)
				note_overlay = get_airlock_overlay("[notetype]_open", note_overlay_file)

		if(AIRLOCK_OPENING)
			frame_overlay = get_airlock_overlay("opening", icon)
			if(airlock_material)
				filling_overlay = get_airlock_overlay("[airlock_material]_opening", overlays_file)
			else
				filling_overlay = get_airlock_overlay("fill_opening", icon)
			if(lights && hasPower())
				lights_overlay = get_airlock_overlay("lights_opening", overlays_file)
			if(panel_open)
				if(security_level)
					panel_overlay = get_airlock_overlay("panel_opening_protected", overlays_file)
				else
					panel_overlay = get_airlock_overlay("panel_opening", overlays_file)
			if(note)
				note_overlay = get_airlock_overlay("[notetype]_opening", note_overlay_file)
			if(has_hatch)
				hatch_overlay = get_airlock_overlay("hatch_opening", icon)

	. += frame_overlay
	. += filling_overlay
	. += lights_overlay
	. += panel_overlay
	. += weld_overlay
	. += sparks_overlay
	. += damag_overlay
	. += note_overlay
	. += seal_overlay
	. += hatch_overlay

	if(hasPower() && unres_sides)
		if(unres_sides & NORTH)
			var/image/I = image(icon='icons/obj/doors/airlocks/station/overlays.dmi', icon_state="unres_n")
			I.pixel_y = 32
			. += I
		if(unres_sides & SOUTH)
			var/image/I = image(icon='icons/obj/doors/airlocks/station/overlays.dmi', icon_state="unres_s")
			I.pixel_y = -32
			. += I
		if(unres_sides & EAST)
			var/image/I = image(icon='icons/obj/doors/airlocks/station/overlays.dmi', icon_state="unres_e")
			I.pixel_x = 32
			. += I
		if(unres_sides & WEST)
			var/image/I = image(icon='icons/obj/doors/airlocks/station/overlays.dmi', icon_state="unres_w")
			I.pixel_x = -32
			. += I
	else
		set_light(0)

/proc/get_airlock_overlay(icon_state, icon_file)
	var/obj/machinery/door/airlock/A
	pass(A)	//suppress unused warning
	var/list/airlock_overlays = A.airlock_overlays
	var/iconkey = "[icon_state][icon_file]"
	if((!(. = airlock_overlays[iconkey])))
		. = airlock_overlays[iconkey] = mutable_appearance(icon_file, icon_state)

/obj/machinery/door/airlock/do_animate(animation)
	switch(animation)
		if("opening")
			update_icon(ALL, AIRLOCK_OPENING)
		if("closing")
			update_icon(ALL, AIRLOCK_CLOSING)
		if("deny")
			if(!machine_stat)
				update_icon(ALL, AIRLOCK_DENY)
				playsound(src, doorDeni, 50, FALSE, 3, mono_adj = TRUE)
				sleep(6)
				update_icon(ALL, AIRLOCK_CLOSED)

/obj/machinery/door/airlock/examine(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		. += span_warning("Its access panel is smoking slightly.")
	if(note)
		if(!in_range(user, src))
			. += "There's a [note.name] pinned to the front. You can't read it from here."
		else
			. += "There's a [note.name] pinned to the front..."
			. += note.examine(user)
	if(seal)
		. += "It's been braced with a pneumatic seal."
	if(panel_open)
		switch(security_level)
			if(AIRLOCK_SECURITY_NONE)
				. += "Its wires are exposed!"
			if(AIRLOCK_SECURITY_METAL)
				. += "Its wires are hidden behind a welded metal cover."
			if(AIRLOCK_SECURITY_PLASTEEL_I_S)
				. += "There is some shredded plasteel inside."
			if(AIRLOCK_SECURITY_PLASTEEL_I)
				. += "Its wires are behind an inner layer of plasteel."
			if(AIRLOCK_SECURITY_PLASTEEL_O_S)
				. += "There is some shredded plasteel inside."
			if(AIRLOCK_SECURITY_PLASTEEL_O)
				. += "There is a welded plasteel cover hiding its wires."
			if(AIRLOCK_SECURITY_PLASTEEL)
				. += "There is a protective grille over its panel."
	else if(security_level)
		if(security_level == AIRLOCK_SECURITY_METAL)
			. += "It looks a bit stronger."
		else
			. += "It looks very robust."

	if(issilicon(user) && !(machine_stat & BROKEN))
		. += span_notice("Shift-click [src] to [ density ? "open" : "close"] it.")
		. += span_notice("Ctrl-click [src] to [ locked ? "raise" : "drop"] its bolts.")
		. += span_notice("Alt-click [src] to [ secondsElectrified ? "un-electrify" : "permanently electrify"] it.")
		. += span_notice("Ctrl-Shift-click [src] to [ emergency ? "disable" : "enable"] emergency access.")

/obj/machinery/door/airlock/attack_ai(mob/user)
	if(!canAIControl(user))
		if(canAIHack())
			hack(user)
			return
		else
			to_chat(user, span_warning("Airlock AI control has been blocked with a firewall. Unable to hack."))
	if(obj_flags & EMAGGED)
		to_chat(user, span_warning("Unable to interface: Airlock is unresponsive."))
		return
	if(detonated)
		to_chat(user, span_warning("Unable to interface. Airlock control panel damaged."))
		return

	ui_interact(user)

/obj/machinery/door/airlock/proc/hack(mob/user)
	set waitfor = 0
	if(!aiHacking)
		aiHacking = TRUE
		to_chat(user, span_warning("Airlock AI control has been blocked. Beginning fault-detection."))
		sleep(50)
		if(canAIControl(user))
			to_chat(user, span_notice("Alert cancelled. Airlock control has been restored without our assistance."))
			aiHacking = FALSE
			return
		else if(!canAIHack())
			to_chat(user, span_warning("Connection lost! Unable to hack airlock."))
			aiHacking = FALSE
			return
		to_chat(user, span_notice("Fault confirmed: airlock control wire disabled or cut."))
		sleep(20)
		to_chat(user, span_notice("Attempting to hack into airlock. This may take some time."))
		sleep(200)
		if(canAIControl(user))
			to_chat(user, span_notice("Alert cancelled. Airlock control has been restored without our assistance."))
			aiHacking = FALSE
			return
		else if(!canAIHack())
			to_chat(user, span_warning("Connection lost! Unable to hack airlock."))
			aiHacking = FALSE
			return
		to_chat(user, span_notice("Upload access confirmed. Loading control program into airlock software."))
		sleep(170)
		if(canAIControl(user))
			to_chat(user, span_notice("Alert cancelled. Airlock control has been restored without our assistance."))
			aiHacking = FALSE
			return
		else if(!canAIHack())
			to_chat(user, span_warning("Connection lost! Unable to hack airlock."))
			aiHacking = FALSE
			return
		to_chat(user, span_notice("Transfer complete. Forcing airlock to execute program."))
		sleep(50)
		//disable blocked control
		aiControlDisabled = AI_WIRE_HACKED
		to_chat(user, span_notice("Receiving control information from airlock."))
		sleep(10)
		//bring up airlock dialog
		aiHacking = FALSE
		if(user)
			attack_ai(user)

/obj/machinery/door/airlock/attack_animal(mob/user)
	. = ..()
	if(isElectrified())
		shock(user, 100)

/obj/machinery/door/airlock/attack_paw(mob/user)
	return attack_hand(user)

/obj/machinery/door/airlock/attack_hand(mob/user)
	if(user.a_intent == INTENT_GRAB && note) //WS edit - Grabbing notes off doors
		user.visible_message(span_notice("[user] grabs [note] from [src]."), span_notice("You remove [note] from [src]."))
		user.put_in_hands(note)
		note = null
		update_appearance() //WS end
		return TRUE
	if(locked && allowed(user) && aac)
		aac.request_from_door(src)
		. = TRUE
	else
		. = ..()
	if(.)
		return
	if(!(issilicon(user) || isAdminGhostAI(user)))
		if(isElectrified())
			if(shock(user, 100))
				return

	if(ishuman(user) && prob(40) && density)
		var/mob/living/carbon/human/H = user
		if((HAS_TRAIT(H, TRAIT_DUMB)) && Adjacent(user))
			playsound(src, 'sound/effects/bang.ogg', 25, TRUE)
			if(!istype(H.head, /obj/item/clothing/head/helmet))
				H.visible_message(span_danger("[user] headbutts the airlock."), \
									span_userdanger("You headbutt the airlock!"))
				H.Paralyze(100)
				H.apply_damage(10, BRUTE, BODY_ZONE_HEAD)
			else
				visible_message(span_danger("[user] headbutts the airlock. Good thing [user.p_theyre()] wearing a helmet."))

/obj/machinery/door/airlock/attempt_wire_interaction(mob/user)
	if(security_level)
		to_chat(user, span_warning("Wires are protected!"))
		return WIRE_INTERACTION_FAIL
	return ..()

/obj/machinery/door/airlock/proc/electrified_loop()
	while (secondsElectrified > MACHINE_NOT_ELECTRIFIED)
		sleep(10)
		if(QDELETED(src))
			return

		secondsElectrified--
		updateDialog()
	// This is to protect against changing to permanent, mid loop.
	if(secondsElectrified == MACHINE_NOT_ELECTRIFIED)
		set_electrified(MACHINE_NOT_ELECTRIFIED)
	else
		set_electrified(MACHINE_ELECTRIFIED_PERMANENT)
	updateDialog()

/obj/machinery/door/airlock/Topic(href, href_list, nowindow = 0)
	// If you add an if(..()) check you must first remove the var/nowindow parameter.
	// Otherwise it will runtime with this kind of error: null.Topic()
	if(!nowindow)
		..()
	if(!usr.canUseTopic(src) && !isAdminGhostAI(usr))
		return
	add_fingerprint(usr)

	if((in_range(src, usr) && isturf(loc)) && panel_open)
		usr.set_machine(src)

	add_fingerprint(usr)
	if(!nowindow)
		updateUsrDialog()
	else
		updateDialog()


/obj/machinery/door/airlock/attackby(obj/item/C, mob/user, params)
	if(!issilicon(user) && !isAdminGhostAI(user))
		if(isElectrified())
			if(shock(user, 75))
				return
	add_fingerprint(user)

	if(panel_open)
		switch(security_level)
			if(AIRLOCK_SECURITY_NONE)
				if(istype(C, /obj/item/stack/sheet/metal))
					var/obj/item/stack/sheet/metal/S = C
					if(S.get_amount() < 2)
						to_chat(user, span_warning("You need at least 2 metal sheets to reinforce [src]."))
						return
					to_chat(user, span_notice("You start reinforcing [src]."))
					if(do_after(user, 20, src))
						if(!panel_open || !S.use(2))
							return
						user.visible_message(span_notice("[user] reinforces \the [src] with metal."),
											span_notice("You reinforce \the [src] with metal."))
						security_level = AIRLOCK_SECURITY_METAL
						update_appearance()
					return
				else if(istype(C, /obj/item/stack/sheet/plasteel))
					var/obj/item/stack/sheet/plasteel/S = C
					if(S.get_amount() < 2)
						to_chat(user, span_warning("You need at least 2 plasteel sheets to reinforce [src]."))
						return
					to_chat(user, span_notice("You start reinforcing [src]."))
					if(do_after(user, 20, src))
						if(!panel_open || !S.use(2))
							return
						user.visible_message(span_notice("[user] reinforces \the [src] with plasteel."),
											span_notice("You reinforce \the [src] with plasteel."))
						security_level = AIRLOCK_SECURITY_PLASTEEL
						modify_max_integrity(max_integrity * AIRLOCK_INTEGRITY_MULTIPLIER)
						damage_deflection = AIRLOCK_DAMAGE_DEFLECTION_R
						update_appearance()
					return
			if(AIRLOCK_SECURITY_METAL)
				if(C.tool_behaviour == TOOL_WELDER)
					if(!C.tool_start_check(user, src, amount=2))
						return
					to_chat(user, span_notice("You begin cutting the panel's shielding..."))
					if(C.use_tool(src, user, 40, volume=50, amount = 2))
						if(!panel_open)
							return
						user.visible_message(span_notice("[user] cuts through \the [src]'s shielding."),
										span_notice("You cut through \the [src]'s shielding."),
										span_hear("You hear welding."))
						security_level = AIRLOCK_SECURITY_NONE
						spawn_atom_to_turf(/obj/item/stack/sheet/metal, user.loc, 2)
						update_appearance()
					return
			if(AIRLOCK_SECURITY_PLASTEEL_I_S)
				if(C.tool_behaviour == TOOL_CROWBAR)
					var/obj/item/crowbar/W = C
					to_chat(user, span_notice("You start removing the inner layer of shielding..."))
					if(W.use_tool(src, user, 40, volume=100))
						if(!panel_open)
							return
						if(security_level != AIRLOCK_SECURITY_PLASTEEL_I_S)
							return
						user.visible_message(span_notice("[user] remove \the [src]'s shielding."),
											span_notice("You remove \the [src]'s inner shielding."))
						security_level = AIRLOCK_SECURITY_NONE
						modify_max_integrity(max_integrity / AIRLOCK_INTEGRITY_MULTIPLIER)
						damage_deflection = AIRLOCK_DAMAGE_DEFLECTION_N
						spawn_atom_to_turf(/obj/item/stack/sheet/plasteel, user.loc, 1)
						update_appearance()
					return
			if(AIRLOCK_SECURITY_PLASTEEL_I)
				if(C.tool_behaviour == TOOL_WELDER)
					if(!C.tool_start_check(user, src, amount=2))
						return
					to_chat(user, span_notice("You begin cutting the inner layer of shielding..."))
					if(C.use_tool(src, user, 40, volume=50, amount=2))
						if(!panel_open)
							return
						user.visible_message(span_notice("[user] cuts through \the [src]'s shielding."),
										span_notice("You cut through \the [src]'s shielding."),
										span_hear("You hear welding."))
						security_level = AIRLOCK_SECURITY_PLASTEEL_I_S
					return
			if(AIRLOCK_SECURITY_PLASTEEL_O_S)
				if(C.tool_behaviour == TOOL_CROWBAR)
					to_chat(user, span_notice("You start removing outer layer of shielding..."))
					if(C.use_tool(src, user, 40, volume=100))
						if(!panel_open)
							return
						if(security_level != AIRLOCK_SECURITY_PLASTEEL_O_S)
							return
						user.visible_message(span_notice("[user] remove \the [src]'s shielding."),
											span_notice("You remove \the [src]'s shielding."))
						security_level = AIRLOCK_SECURITY_PLASTEEL_I
						spawn_atom_to_turf(/obj/item/stack/sheet/plasteel, user.loc, 1)
					return
			if(AIRLOCK_SECURITY_PLASTEEL_O)
				if(C.tool_behaviour == TOOL_WELDER)
					if(!C.tool_start_check(user, src, amount=2))
						return
					to_chat(user, span_notice("You begin cutting the outer layer of shielding..."))
					if(C.use_tool(src, user, 40, volume=50, amount=2))
						if(!panel_open)
							return
						user.visible_message(span_notice("[user] cuts through \the [src]'s shielding."),
										span_notice("You cut through \the [src]'s shielding."),
										span_hear("You hear welding."))
						security_level = AIRLOCK_SECURITY_PLASTEEL_O_S
					return
			if(AIRLOCK_SECURITY_PLASTEEL)
				if(C.tool_behaviour == TOOL_WIRECUTTER)
					if(hasPower() && shock(user, 60)) // Protective grille of wiring is electrified
						return
					to_chat(user, span_notice("You start cutting through the outer grille."))
					if(C.use_tool(src, user, 10, volume=100))
						if(!panel_open)
							return
						user.visible_message(span_notice("[user] cut through \the [src]'s outer grille."),
											span_notice("You cut through \the [src]'s outer grille."))
						security_level = AIRLOCK_SECURITY_PLASTEEL_O
					return
	if(C.tool_behaviour == TOOL_SCREWDRIVER)
		if(panel_open && detonated)
			to_chat(user, span_warning("[src] has no maintenance panel!"))
			return
		panel_open = !panel_open
		to_chat(user, span_notice("You [panel_open ? "open":"close"] the maintenance panel of the airlock."))
		C.play_tool_sound(src)
		update_appearance()
	else if((C.tool_behaviour == TOOL_WIRECUTTER) && note)
		user.visible_message(span_notice("[user] cuts down [note] from [src]."), span_notice("You remove [note] from [src]."))
		C.play_tool_sound(src)
		note.forceMove(get_turf(user))
		note = null
		update_appearance()
	else if(is_wire_tool(C) && panel_open)
		attempt_wire_interaction(user)
		return
	else if(istype(C, /obj/item/pai_cable))
		var/obj/item/pai_cable/cable = C
		cable.plugin(src, user)
	else if(istype(C, /obj/item/airlock_painter))
		change_paintjob(C, user)
	else if(istype(C, /obj/item/door_seal)) //adding the seal
		var/obj/item/door_seal/airlockseal = C
		if(!density)
			to_chat(user, span_warning("[src] must be closed before you can seal it!"))
			return
		if(seal)
			to_chat(user, span_warning("[src] has already been sealed!"))
			return
		user.visible_message(span_notice("[user] begins sealing [src]."), span_notice("You begin sealing [src]."))
		playsound(src, 'sound/items/jaws_pry.ogg', 30, TRUE)
		if(!do_after(user, airlockseal.seal_time, target = src))
			return
		if(!density)
			to_chat(user, span_warning("[src] must be closed before you can seal it!"))
			return
		if(seal)
			to_chat(user, span_warning("[src] has already been sealed!"))
			return
		if(!user.transferItemToLoc(airlockseal, src))
			to_chat(user, span_warning("For some reason, you can't attach [airlockseal]!"))
			return
		playsound(src, 'sound/machines/airlockforced.ogg', 30, TRUE)
		user.visible_message(span_notice("[user] finishes sealing [src]."), span_notice("You finish sealing [src]."))
		seal = airlockseal
		modify_max_integrity(max_integrity * AIRLOCK_SEAL_MULTIPLIER)
		update_appearance()

	else if(istype(C, /obj/item/paper) || istype(C, /obj/item/photo))
		if(note)
			to_chat(user, span_warning("There's already something pinned to this airlock! Use wirecutters to remove it."))
			return
		if(!user.transferItemToLoc(C, src))
			to_chat(user, span_warning("For some reason, you can't attach [C]!"))
			return
		user.visible_message(span_notice("[user] pins [C] to [src]."), span_notice("You pin [C] to [src]."))
		note = C
		update_appearance()
	else
		return ..()


/obj/machinery/door/airlock/try_to_weld(obj/item/weldingtool/W, mob/user)
	if(!operating && density)
		if(seal)
			to_chat(user, span_warning("[src] is blocked by a seal!"))
			return
		if(user.a_intent != INTENT_HELP)
			if(!W.tool_start_check(user, src, amount=0))
				return
			user.visible_message(span_notice("[user] begins [welded ? "unwelding":"welding"] the airlock."), \
							span_notice("You begin [welded ? "unwelding":"welding"] the airlock..."), \
							span_hear("You hear welding."))
			if(W.use_tool(src, user, 40, volume=50, extra_checks = CALLBACK(src, PROC_REF(weld_checks), W, user)))
				welded = !welded
				user.visible_message(span_notice("[user] [welded? "welds shut":"unwelds"] [src]."), \
									span_notice("You [welded ? "weld the airlock shut":"unweld the airlock"]."))
				update_appearance()
		else
			if(atom_integrity < max_integrity)
				if(!W.tool_start_check(user, src, amount=0))
					return
				user.visible_message(span_notice("[user] begins welding the airlock."), \
								span_notice("You begin repairing the airlock..."), \
								span_hear("You hear welding."))
				if(W.use_tool(src, user, 40, volume=50, extra_checks = CALLBACK(src, PROC_REF(weld_checks), W, user)))
					atom_integrity = max_integrity
					set_machine_stat(machine_stat & ~BROKEN)
					user.visible_message(span_notice("[user] finishes welding [src]."), \
										span_notice("You finish repairing the airlock."))
					update_appearance()
			else
				to_chat(user, span_notice("The airlock doesn't need repairing."))

/obj/machinery/door/airlock/proc/weld_checks(obj/item/weldingtool/W, mob/user)
	return !operating && density

/**
 * Used when attempting to remove a seal from an airlock
 *
 * Called when attacking an airlock with an empty hand, returns TRUE (there was a seal and we removed it, or failed to remove it)
 * or FALSE (there was no seal)
 * Arguments:
 * * user - Whoever is attempting to remove the seal
 */
/obj/machinery/door/airlock/try_remove_seal(mob/living/user)
	if(!seal)
		return FALSE
	var/obj/item/door_seal/airlockseal = seal
	if(!ishuman(user))
		to_chat(user, span_warning("You don't have the dexterity to remove the seal!"))
		return TRUE
	user.visible_message(span_notice("[user] begins removing the seal from [src]."), span_notice("You begin removing [src]'s pneumatic seal."))
	playsound(src, 'sound/machines/airlockforced.ogg', 30, TRUE)
	if(!do_after(user, airlockseal.unseal_time, target = src))
		return TRUE
	if(!seal)
		return TRUE
	playsound(src, 'sound/items/jaws_pry.ogg', 30, TRUE)
	airlockseal.forceMove(get_turf(user))
	user.visible_message(span_notice("[user] finishes removing the seal from [src]."), span_notice("You finish removing [src]'s pneumatic seal."))
	seal = null
	modify_max_integrity(max_integrity / AIRLOCK_SEAL_MULTIPLIER)
	update_appearance()
	return TRUE


/obj/machinery/door/airlock/try_to_crowbar(obj/item/I, mob/living/user, forced = FALSE)
	if(I)
		var/beingcrowbarred = (I.tool_behaviour == TOOL_CROWBAR)
		if(!security_level && (beingcrowbarred && panel_open && ((obj_flags & EMAGGED) || (density && welded && !operating && !hasPower() && !locked))))
			user.visible_message(
				span_notice("[user] removes the electronics from the airlock assembly."),
				span_notice("You start to remove electronics from the airlock assembly...")
			)
			if(I.use_tool(src, user, 40, volume=100))
				deconstruct(TRUE, user)
				return
	if(seal)
		to_chat(user, span_warning("Remove the seal first!"))
		return
	if(locked)
		to_chat(user, span_warning("The airlock's bolts prevent it from being forced!"))
		return
	if(welded)
		to_chat(user, span_warning("It's welded, it won't budge!"))
		return
	if(hasPower())
		if(forced)
			if(isElectrified())
				shock(user,100)//it's like sticking a forck in a power socket
				return

			if(!density)//already open
				return

			if(!prying_so_hard)
				var/time_to_open = 50
				playsound(src, pry_sound, 100, TRUE, mono_adj = TRUE) //is it aliens or just the CE being a dick?
				prying_so_hard = TRUE
				if(do_after(user, time_to_open, src))
					open(2)
					if(density && !open(2))
						to_chat(user, span_warning("Despite your attempts, [src] refuses to open."))
				prying_so_hard = FALSE
				return
		to_chat(user, span_warning("The airlock's motors resist your efforts to force it!"))
		return

	if(!operating)
		if(istype(I, /obj/item/melee/axe/fire)) //being fireaxe'd
			var/obj/item/melee/axe/fire/axe = I
			if(axe && !HAS_TRAIT(axe, TRAIT_WIELDED))
				to_chat(user, span_warning("You need to be wielding \the [axe] to do that!"))
				return
		INVOKE_ASYNC(src, (density ? PROC_REF(open) : PROC_REF(close)), 2)

/obj/machinery/door/airlock/deconstruct_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return FALSE
	if(!I.tool_start_check(user, src, amount=0))
		return FALSE
	var/decon_time = 5 SECONDS
	if(welded)
		decon_time += 5 SECONDS
	if(locked)
		decon_time += 5 SECONDS
	if(seal)
		decon_time += 15 SECONDS
	if (I.use_tool(src, user, decon_time, volume=100))
		to_chat(user, span_warning("You cut open the [src]."))
		deconstruct(FALSE, user)
		return TRUE

/obj/machinery/door/airlock/open(forced=0)
	if(operating || welded || locked || seal || !wires)
		return FALSE
	if(!forced)
		if(!hasPower() || wires.is_cut(WIRE_OPEN))
			return FALSE
	if(forced < 2)
		if(obj_flags & EMAGGED)
			return FALSE
		use_power(50)
		play_fov_effect(src, 6, "note")
		playsound(src, doorOpen, 30, FALSE, mono_adj = TRUE)
		if(closeOther != null && istype(closeOther, /obj/machinery/door/airlock/) && !closeOther.density)
			closeOther.close()
	else
		playsound(src, pry_open_sound, 30, TRUE, mono_adj = TRUE)

	if(autoclose)
		autoclose_in(fast_close ? clamp(close_speed/10, 10, 300) : close_speed)

	if(!density)
		return TRUE
	operating = TRUE
	update_icon(ALL, AIRLOCK_OPENING, TRUE)
	sleep(1)
	set_opacity(0)
	update_freelook_sight()
	sleep(4)
	density = FALSE
	flags_1 &= ~PREVENT_CLICK_UNDER_1
	air_update_turf(1)
	sleep(1)
	layer = OPEN_DOOR_LAYER
	update_icon(ALL, AIRLOCK_OPEN, TRUE)
	operating = FALSE
	if(delayed_close_requested)
		delayed_close_requested = FALSE
		addtimer(CALLBACK(src, PROC_REF(close)), 1)
	return TRUE


/obj/machinery/door/airlock/close(forced=0)
	if(operating || welded || locked || seal)
		return
	if(density)
		return TRUE
	if(!forced)
		if(!hasPower() || wires.is_cut(WIRE_BOLTS))
			return
	if(safe)
		for(var/atom/movable/M in get_turf(src))
			if(M.density && !(M.flags_1 & ON_BORDER_1) && M != src) //something is blocking the door
				autoclose_in(60)
				return

	if(forced < 2)
		if(obj_flags & EMAGGED)
			return
		use_power(50)
		play_fov_effect(src, 6, "note")
		playsound(src, doorClose, 30, FALSE, mono_adj = TRUE)
	else
		playsound(src, pry_close_sound, 30, TRUE, mono_adj = TRUE)

	var/obj/structure/window/killthis = (locate(/obj/structure/window) in get_turf(src))
	if(killthis)
		SSexplosions.medobj += killthis

	operating = TRUE
	update_icon(ALL, AIRLOCK_CLOSING, 1)
	layer = CLOSED_DOOR_LAYER
	if(air_tight)
		density = TRUE
		flags_1 |= PREVENT_CLICK_UNDER_1
		air_update_turf(1)
	sleep(1)
	if(!air_tight)
		density = TRUE
		flags_1 |= PREVENT_CLICK_UNDER_1
		air_update_turf(1)
	sleep(4)
	if(!safe)
		crush()
	if(visible && !glass)
		set_opacity(1)
	update_freelook_sight()
	sleep(1)
	update_icon(ALL, AIRLOCK_CLOSED, 1)
	operating = FALSE
	delayed_close_requested = FALSE
	if(safe)
		CheckForMobs()
	return TRUE

/obj/machinery/door/airlock/proc/prison_open()
	if(obj_flags & EMAGGED)
		return
	locked = FALSE
	open()
	locked = TRUE
	return

// gets called when a player uses an airlock painter on this airlock
/obj/machinery/door/airlock/proc/change_paintjob(obj/item/airlock_painter/painter, mob/user)
	if((!in_range(src, user) && loc != user) || !painter.can_use(user)) // user should be adjacent to the airlock, and the painter should have a toner cartridge that isn't empty
		return

	// reads from the airlock painter's `available paintjob` list. lets the player choose a paint option, or cancel painting
	var/current_paintjob = input(user, "Please select a paintjob for this airlock.") as null|anything in sortList(painter.available_paint_jobs)
	if(!current_paintjob) // if the user clicked cancel on the popup, return
		return

	var/airlock_type = painter.available_paint_jobs["[current_paintjob]"] // get the airlock type path associated with the airlock name the user just chose
	var/obj/machinery/door/airlock/airlock = new airlock_type // we need to create an new instance of the airlock and assembly to read vars from them
	var/obj/structure/door_assembly/assembly = new airlock.assemblytype

	if(airlock_material == "glass" && assembly.noglass) // prevents painting glass airlocks with a paint job that doesn't have a glass version, such as the freezer
		to_chat(user, span_warning("This paint job can only be applied to non-glass airlocks."))
	else
		// applies the user-chosen airlock's icon, overlays and assemblytype to the src airlock
		painter.use_paint(user)
		icon = airlock.icon
		overlays_file = airlock.overlays_file
		assemblytype = airlock.assemblytype
		update_appearance()

	// these are just hanging around but are never placed, we need to delete them
	qdel(airlock)
	qdel(assembly)

/obj/machinery/door/airlock/CanAStarPass(obj/item/card/id/ID)
//Airlock is passable if it is open (!density), bot has access, and is not bolted shut or powered off)
	return !density || (check_access(ID) && !locked && hasPower())

/obj/machinery/door/airlock/emag_act(mob/user)
	if(!operating && density && hasPower() && !(obj_flags & EMAGGED))
		operating = TRUE
		update_icon(ALL, AIRLOCK_EMAG, 1)
		sleep(6)
		if(QDELETED(src))
			return
		operating = FALSE
		if(!open())
			update_icon(ALL, AIRLOCK_CLOSED, 1)
		obj_flags |= EMAGGED
		lights = FALSE
		locked = TRUE
		loseMainPower()
		loseBackupPower()

/obj/machinery/door/airlock/attack_alien(mob/living/carbon/alien/humanoid/user)
	if(isElectrified())
		add_fingerprint(user)
		shock(user, 100) //Mmm, fried xeno!
		return
	if(!density) //Already open
		return ..()
	if(locked || welded || seal) //Extremely generic, as aliens only understand the basics of how airlocks work.
		if(user.a_intent == INTENT_HARM)
			return ..()
		to_chat(user, span_warning("[src] refuses to budge!"))
		return
	add_fingerprint(user)
	user.visible_message(span_warning("[user] begins prying open [src]."),\
						span_noticealien("You begin digging your claws into [src] with all your might!"),\
						span_warning("You hear groaning metal..."))
	var/time_to_open = 5 //half a second
	if(hasPower())
		time_to_open = 5 SECONDS //Powered airlocks take longer to open, and are loud.
		playsound(src, 'sound/machines/creaking.ogg', 100, TRUE, mono_adj = TRUE)


	if(do_after(user, time_to_open, src))
		if(density && !open(2)) //The airlock is still closed, but something prevented it opening. (Another player noticed and bolted/welded the airlock in time!)
			to_chat(user, span_warning("Despite your efforts, [src] managed to resist your attempts to open it!"))

/obj/machinery/door/airlock/hostile_lockdown(mob/origin)
	// Must be powered and have working AI wire.
	if(canAIControl(src) && !machine_stat)
		locked = FALSE //For airlocks that were bolted open.
		safe = FALSE //DOOR CRUSH
		close()
		bolt() //Bolt it!
		set_electrified(MACHINE_ELECTRIFIED_PERMANENT)  //Shock it!
		if(origin)
			LAZYADD(shockedby, "\[[time_stamp()]\] [key_name(origin)]")


/obj/machinery/door/airlock/disable_lockdown()
	// Must be powered and have working AI wire.
	if(canAIControl(src) && !machine_stat)
		unbolt()
		set_electrified(MACHINE_NOT_ELECTRIFIED)
		open()
		safe = TRUE


/obj/machinery/door/airlock/proc/on_break()
	SIGNAL_HANDLER

	if(!panel_open)
		panel_open = TRUE
	wires.cut_all()

/obj/machinery/door/airlock/proc/set_electrified(seconds, mob/user)
	secondsElectrified = seconds
	diag_hud_set_electrified()
	if(secondsElectrified > MACHINE_NOT_ELECTRIFIED)
		INVOKE_ASYNC(src, PROC_REF(electrified_loop))

	if(user)
		var/message
		switch(secondsElectrified)
			if(MACHINE_ELECTRIFIED_PERMANENT)
				message = "permanently shocked"
			if(MACHINE_NOT_ELECTRIFIED)
				message = "unshocked"
			else
				message = "temp shocked for [secondsElectrified] seconds"
		LAZYADD(shockedby, text("\[[time_stamp()]\] [key_name(user)] - ([uppertext(message)])"))
		log_combat(user, src, message)
		add_hiddenprint(user)

/obj/machinery/door/airlock/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(atom_integrity < (0.75 * max_integrity))
		update_appearance()


/obj/machinery/door/airlock/deconstruct(disassembled = TRUE, mob/user)
	if(!(flags_1 & NODECONSTRUCT_1))
		var/obj/structure/door_assembly/A
		if(assemblytype)
			A = new assemblytype(loc)
		else
			A = new /obj/structure/door_assembly(loc)
			//If you come across a null assemblytype, it will produce the default assembly instead of disintegrating.
		A.heat_proof_finished = heat_proof //tracks whether there's rglass in
		A.set_anchored(TRUE)
		A.glass = glass
		A.state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
		A.created_name = name
		A.previous_assembly = previous_airlock
		A.update_name()
		A.update_appearance()
		A.dir = dir

		if(!disassembled)
			if(A)
				A.atom_integrity = A.max_integrity * 0.5
		else if(obj_flags & EMAGGED)
			if(user)
				to_chat(user, span_warning("You discard the damaged electronics."))
		else
			if(user)
				to_chat(user, span_notice("You remove the airlock electronics."))

			var/obj/item/electronics/airlock/ae
			if(!electronics)
				ae = new/obj/item/electronics/airlock(loc)
				gen_access()
				if(req_one_access.len)
					ae.one_access = 1
					ae.accesses = req_one_access
				else
					ae.accesses = req_access
			else
				ae = electronics
				electronics = null
				ae.forceMove(drop_location())
	qdel(src)

/obj/machinery/door/airlock/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_DECONSTRUCT)
			if(resistance_flags & INDESTRUCTIBLE)
				return FALSE
			if(seal)
				to_chat(user, span_notice("[src]'s seal needs to be removed first."))
				return FALSE
			if(security_level != AIRLOCK_SECURITY_NONE)
				to_chat(user, span_notice("[src]'s reinforcement needs to be removed first."))
				return FALSE
			return list("mode" = RCD_DECONSTRUCT, "delay" = 50, "cost" = 32)
	return FALSE

/obj/machinery/door/airlock/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_DECONSTRUCT)
			if(resistance_flags & INDESTRUCTIBLE)
				return FALSE
			to_chat(user, span_notice("You deconstruct the airlock."))
			qdel(src)
			return TRUE
	return FALSE

/obj/machinery/door/airlock/proc/note_type() //Returns a string representing the type of note pinned to this airlock
	if(!note)
		return
	else if(istype(note, /obj/item/paper))
		return "note"
	else if(istype(note, /obj/item/photo))
		return "photo"

/obj/machinery/door/airlock/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AiAirlock", name)
		ui.open()
	return TRUE

/obj/machinery/door/airlock/ui_data()
	var/list/data = list()

	var/list/power = list()
	power["main"] = secondsMainPowerLost ? 0 : 2 // boolean
	power["main_timeleft"] = secondsMainPowerLost
	power["backup"] = secondsBackupPowerLost ? 0 : 2 // boolean
	power["backup_timeleft"] = secondsBackupPowerLost
	data["power"] = power

	data["shock"] = secondsElectrified == MACHINE_NOT_ELECTRIFIED ? 2 : 0
	data["shock_timeleft"] = secondsElectrified
	data["id_scanner"] = !aiDisabledIdScanner
	data["emergency"] = emergency // access
	data["locked"] = locked // bolted
	data["lights"] = lights // bolt lights
	data["safe"] = safe // safeties
	data["operation speed"] = fast_close // safe speed
	data["welded"] = welded // welded
	data["opened"] = !density // opened

	var/list/wire = list()
	wire["main_1"] = !wires.is_cut(WIRE_POWER1)
	wire["main_2"] = !wires.is_cut(WIRE_POWER2)
	wire["backup_1"] = !wires.is_cut(WIRE_BACKUP1)
	wire["backup_2"] = !wires.is_cut(WIRE_BACKUP2)
	wire["shock"] = !wires.is_cut(WIRE_SHOCK)
	wire["id_scanner"] = !wires.is_cut(WIRE_IDSCAN)
	wire["bolts"] = !wires.is_cut(WIRE_BOLTS)
	wire["lights"] = !wires.is_cut(WIRE_LIGHT)
	wire["safe"] = !wires.is_cut(WIRE_SAFETY)
	wire["timing"] = !wires.is_cut(WIRE_TIMING)

	data["wires"] = wire
	return data

/obj/machinery/door/airlock/ui_act(action, params)
	. = ..()
	if(.)
		return

	if(!user_allowed(usr))
		to_chat(usr, span_danger("Access denied."))
		return
	switch(action)
		if("disrupt-main")
			if(!secondsMainPowerLost)
				loseMainPower()
				update_appearance()
			else
				to_chat(usr, span_warning("Main power is already offline."))
			. = TRUE
		if("disrupt-backup")
			if(!secondsBackupPowerLost)
				loseBackupPower()
				update_appearance()
			else
				to_chat(usr, span_warning("Backup power is already offline."))
			. = TRUE
		if("shock-restore")
			shock_restore(usr)
			. = TRUE
		if("shock-temp")
			shock_temp(usr)
			. = TRUE
		if("shock-perm")
			shock_perm(usr)
			. = TRUE
		if("idscan-toggle")
			aiDisabledIdScanner = !aiDisabledIdScanner
			. = TRUE
		if("emergency-toggle")
			toggle_emergency(usr)
			. = TRUE
		if("bolt-toggle")
			toggle_bolt(usr)
			. = TRUE
		if("light-toggle")
			lights = !lights
			update_appearance()
			. = TRUE
		if("safe-toggle")
			safe = !safe
			. = TRUE
		if("speed-toggle")
			fast_close = !fast_close
			. = TRUE
		if("open-close")
			user_toggle_open(usr)
			. = TRUE

/obj/machinery/door/airlock/proc/user_allowed(mob/user)
	return (issilicon(user) && canAIControl(user)) || isAdminGhostAI(user)

/obj/machinery/door/airlock/proc/shock_restore(mob/user)
	if(!user_allowed(user))
		return
	if(wires.is_cut(WIRE_SHOCK))
		to_chat(user, span_warning("Can't un-electrify the airlock - The electrification wire is cut."))
	else if(isElectrified())
		set_electrified(MACHINE_NOT_ELECTRIFIED, user)

/obj/machinery/door/airlock/proc/shock_temp(mob/user)
	if(!user_allowed(user))
		return
	if(wires.is_cut(WIRE_SHOCK))
		to_chat(user, span_warning("The electrification wire has been cut."))
	else
		set_electrified(MACHINE_DEFAULT_ELECTRIFY_TIME, user)

/obj/machinery/door/airlock/proc/shock_perm(mob/user)
	if(!user_allowed(user))
		return
	if(wires.is_cut(WIRE_SHOCK))
		to_chat(user, span_warning("The electrification wire has been cut."))
	else
		set_electrified(MACHINE_ELECTRIFIED_PERMANENT, user)

/obj/machinery/door/airlock/proc/toggle_bolt(mob/user)
	if(!user_allowed(user))
		return
	if(wires.is_cut(WIRE_BOLTS))
		to_chat(user, span_warning("The door bolt drop wire is cut - you can't toggle the door bolts."))
		return
	if(locked)
		if(!hasPower())
			to_chat(user, span_warning("The door has no power - you can't raise the door bolts."))
		else
			unbolt()
			log_combat(user, src, "unbolted")
	else
		bolt()
		log_combat(user, src, "bolted")

/obj/machinery/door/airlock/proc/toggle_emergency(mob/user)
	if(!user_allowed(user))
		return
	emergency = !emergency
	update_appearance()

/obj/machinery/door/airlock/proc/user_toggle_open(mob/user)
	if(!user_allowed(user))
		return
	if(welded)
		to_chat(user, span_warning("The airlock has been welded shut!"))
	else if(locked)
		to_chat(user, span_warning("The door bolts are down!"))
	else if(!density)
		close()
	else
		open()

#undef AIRLOCK_CLOSED
#undef AIRLOCK_CLOSING
#undef AIRLOCK_OPEN
#undef AIRLOCK_OPENING
#undef AIRLOCK_DENY
#undef AIRLOCK_EMAG

#undef AIRLOCK_SECURITY_NONE
#undef AIRLOCK_SECURITY_METAL
#undef AIRLOCK_SECURITY_PLASTEEL_I_S
#undef AIRLOCK_SECURITY_PLASTEEL_I
#undef AIRLOCK_SECURITY_PLASTEEL_O_S
#undef AIRLOCK_SECURITY_PLASTEEL_O
#undef AIRLOCK_SECURITY_PLASTEEL

#undef AIRLOCK_INTEGRITY_N
#undef AIRLOCK_INTEGRITY_MULTIPLIER
#undef AIRLOCK_SEAL_MULTIPLIER
#undef AIRLOCK_DAMAGE_DEFLECTION_N
#undef AIRLOCK_DAMAGE_DEFLECTION_R
