
////////////////////////
//Turret Control Panel//
////////////////////////

/obj/machinery/turretid
	name = "turret control panel"
	desc = "Used to control a room's automated defenses."
	icon = 'icons/obj/machines/turret_control.dmi'
	icon_state = "control_standby"
	base_icon_state = "control"
	density = FALSE
	req_access = list(ACCESS_AI_UPLOAD)
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// Variable dictating if linked turrets are active and will shoot targets
	var/enabled = TRUE
	/// Variable dictating if linked turrets will shoot lethal projectiles
	var/lethal = FALSE
	/// Variable dictating if the panel is locked, preventing changes to turret settings
	var/locked = TRUE
	/// AI is unable to use this machine if set to TRUE
	var/ailock = FALSE
	/// Variable dictating if linked turrets will shoot cyborgs
	var/shoot_cyborgs = FALSE
	/// List of all linked turrets
	var/list/datum/weakref/turret_refs = list()
	///id for connecting to additional turrets
	var/id = ""

/obj/machinery/turretid/Initialize(mapload, ndir = 0, built = 0)
	. = ..()
	if(built)
		setDir(ndir)
		locked = FALSE
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -24 : 24)
		pixel_y = (dir & 3)? (dir ==1 ? -24 : 24) : 0
	power_change() //Checks power and initial settings

/obj/machinery/turretid/Destroy()
	turret_refs.Cut()
	return ..()

/obj/machinery/turretid/Initialize(mapload) //map-placed turrets autolink turrets
	. = ..()
	if(!mapload)
		return

/obj/machinery/turretid/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	id = "[text_ref(port)][id]"
	RegisterSignal(port, COMSIG_SHIP_DONE_CONNECTING, PROC_REF(late_connect_to_shuttle))

/obj/machinery/turretid/disconnect_from_shuttle(obj/docking_port/mobile/port)
	turret_refs.Cut()

/obj/machinery/turretid/proc/late_connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	SIGNAL_HANDLER

	for(var/datum/weakref/ship_gun in port.turret_list)
		var/obj/machinery/porta_turret/turret_gun = ship_gun.resolve()
		//skip if it doesn't exist or if the id doesn't match
		if(turret_gun?.id != id)
			continue

		turret_refs |= ship_gun

	UnregisterSignal(port, COMSIG_SHIP_DONE_CONNECTING)

/obj/machinery/turretid/examine(mob/user)
	. += ..()
	if(issilicon(user) && !(machine_stat & BROKEN))
		. += {"<span class='notice'>Ctrl-click [src] to [ enabled ? "disable" : "enable"] turrets.</span>
					<span class='notice'>Alt-click [src] to set turrets to [ lethal ? "stun" : "kill"].</span>"}

/obj/machinery/turretid/attackby(obj/item/I, mob/user, params)
	if(machine_stat & BROKEN)
		return

	if(I.tool_behaviour == TOOL_MULTITOOL)
		if(!multitool_check_buffer(user, I))
			return
		var/obj/item/multitool/M = I
		if(M.buffer && istype(M.buffer, /obj/machinery/porta_turret))
			turret_refs |= WEAKREF(M.buffer)
			to_chat(user, "<span class='notice'>You link \the [M.buffer] with \the [src].</span>")
			return

	if (issilicon(user))
		return attack_hand(user)

	// trying to unlock the interface
	if (in_range(src, user))
		if (allowed(usr))
			if(obj_flags & EMAGGED)
				to_chat(user, "<span class='warning'>The turret control is unresponsive!</span>")
				return

			locked = !locked
			to_chat(user, "<span class='notice'>You [ locked ? "lock" : "unlock"] the panel.</span>")
		else
			to_chat(user, "<span class='alert'>Access denied.</span>")

/obj/machinery/turretid/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	to_chat(user, "<span class='notice'>You short out the turret controls' access analysis module.</span>")
	obj_flags |= EMAGGED
	locked = FALSE

/obj/machinery/turretid/attack_ai(mob/user)
	if(!ailock || isAdminGhostAI(user))
		return attack_hand(user)
	else
		to_chat(user, "<span class='warning'>There seems to be a firewall preventing you from accessing this device!</span>")

/obj/machinery/turretid/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TurretControl", name)
		ui.open()

/obj/machinery/turretid/ui_data(mob/user)
	var/list/data = list()
	data["locked"] = locked
	data["siliconUser"] = user.has_unlimited_silicon_privilege && check_ship_ai_access(user)
	data["enabled"] = enabled
	data["lethal"] = lethal
	data["shootCyborgs"] = shoot_cyborgs
	return data

/obj/machinery/turretid/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("lock")
			if(!usr.has_unlimited_silicon_privilege)
				return
			if((obj_flags & EMAGGED) || (machine_stat & BROKEN))
				to_chat(usr, "<span class='warning'>The turret control is unresponsive!</span>")
				return
			locked = !locked
			return TRUE
		if("power")
			toggle_on(usr)
			return TRUE
		if("mode")
			toggle_lethal(usr)
			return TRUE
		if("shoot_silicons")
			shoot_silicons(usr)
			return TRUE

/obj/machinery/turretid/proc/toggle_lethal(mob/user)
	lethal = !lethal
	add_hiddenprint(user)
	log_combat(user, src, "[lethal ? "enabled" : "disabled"] lethals on")
	updateTurrets()

/obj/machinery/turretid/proc/toggle_on(mob/user)
	enabled = !enabled
	add_hiddenprint(user)
	log_combat(user, src, "[enabled ? "enabled" : "disabled"]")
	updateTurrets()

/obj/machinery/turretid/proc/shoot_silicons(mob/user)
	shoot_cyborgs = !shoot_cyborgs
	add_hiddenprint(user)
	log_combat(user, src, "[shoot_cyborgs ? "Shooting Borgs" : "Not Shooting Borgs"]")
	updateTurrets()

/obj/machinery/turretid/proc/updateTurrets()
	for(var/datum/weakref/turret_ref in turret_refs)
		var/obj/machinery/porta_turret/turret = turret_ref.resolve()
		if(!turret)
			turret_refs -= turret_ref
			continue
		turret.setState(enabled, lethal, shoot_cyborgs)
	update_appearance()

/obj/machinery/turretid/update_icon_state()
	if(machine_stat & NOPOWER)
		icon_state = "[base_icon_state]_off"
		return ..()
	if (enabled)
		icon_state = "[base_icon_state]_[lethal ? "kill" : "stun"]"
		return ..()
	icon_state = "[base_icon_state]_standby"
	return ..()

/obj/machinery/turretid/lethal
	lethal = TRUE

/obj/machinery/turretid/ship
	req_ship_access = TRUE

/obj/item/wallframe/turret_control
	name = "turret control frame"
	desc = "Used for building turret control panels."
	icon = 'icons/obj/machines/turret_control.dmi'
	icon_state = "control_off"
	result_path = /obj/machinery/turretid
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)
	inverse_pixel_shift = TRUE
