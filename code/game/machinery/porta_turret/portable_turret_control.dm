
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
	/// Flags to apply to all linked turrets
	var/turret_flags = TURRET_FLAG_DEFAULT
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
	power_change()

/obj/machinery/turretid/Destroy()
	turret_refs.Cut()
	return ..()

/obj/machinery/turretid/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	id = "[text_ref(port)][id]"
	RegisterSignal(port, COMSIG_SHIP_DONE_CONNECTING, PROC_REF(late_connect_to_shuttle))

/obj/machinery/turretid/proc/late_connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	SIGNAL_HANDLER

	for(var/datum/weakref/ship_gun as anything in port.turret_list)
		var/obj/machinery/porta_turret/turret_gun = ship_gun.resolve()
		//skip if it doesn't exist or if the id doesn't match
		if(turret_gun?.id != id)
			continue

		turret_refs += ship_gun

	update_turrets()
	UnregisterSignal(port, COMSIG_SHIP_DONE_CONNECTING)

/obj/machinery/turretid/examine(mob/user)
	. += ..()
	if((machine_stat & (BROKEN|MAINT)))
		return

	. += span_notice("<b>Alt-click</b> [src] to [locked ? "unlock" : "lock"] it.")
	. += span_notice("<b>Ctrl-click</b> [src] to [enabled ? "disable" : "enable"] turrets.")
	. += span_notice("<b>Ctrl-shift-click</b> [src] to set turrets to [lethal ? "stun" : "kill"] mode.")

/obj/machinery/turretid/attackby(obj/item/I, mob/user, params)
	if(machine_stat & BROKEN)
		return

	switch(I.tool_behaviour)
		if(TOOL_MULTITOOL)
			if(locked)
				to_chat(user, span_warning("The controls are locked."))
				return
			if(!multitool_check_buffer(user, I))
				return

			var/obj/item/multitool/tool_to_use = I
			tool_to_use.buffer = src
			to_chat(user, span_notice("You store [src] in the buffer."))
			return

		if(TOOL_WRENCH)
			if(can_dismantle(user))
				to_chat(user, span_notice("You start dismantling \the [src]..."))
				if(I.use_tool(src, user, 40, volume=75, extra_checks=CALLBACK(src, PROC_REF(can_dismantle), user, TRUE)))
					user.visible_message(
						span_notice("[user] dismantles \the [src]."), //Generally speaking, \the is unncessary, but I am not sure if most codebases use \improper in their item names.
						span_notice("You dismantle \the [src].")
					)
					var/obj/item/wallframe/turret_control/frame = new /obj/item/wallframe/turret_control()
					try_put_in_hand(frame, user)
					playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
					qdel(src)
			return

	if(issilicon(user))
		return attack_hand(user)

	if(istype(I, /obj/item/card/id))
		toggle_lock(user)

	else //If it's not any of those, smack it.
		return ..()

///This proc checks to see if the turret controls can be dismantled and is also called on during use_tool().
/obj/machinery/turretid/proc/can_dismantle(mob/user, silent = FALSE)
	if(locked)
		if(!silent) //It will silently fail on callback as we don't need to announce this again.
			to_chat(user, span_warning("[src] has to be unlocked to be dismantled."))
		return FALSE
	return TRUE

/obj/machinery/turretid/AltClick(mob/user)
	. = ..()
	toggle_lock(user)

/obj/machinery/turretid/CtrlClick(mob/user)
	. = ..()
	toggle_on(user)

/obj/machinery/turretid/CtrlShiftClick(mob/user)
	. = ..()
	toggle_lethal(user)

/obj/machinery/turretid/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	to_chat(user, span_notice("You short out the turret controls' access analysis module."))
	obj_flags |= EMAGGED
	locked = FALSE

/obj/machinery/turretid/attack_ai(mob/user)
	if(!ailock || isAdminGhostAI(user))
		return attack_hand(user)
	else
		to_chat(user, span_warning("There seems to be a firewall preventing you from accessing this device!"))

/obj/machinery/turretid/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TurretControl", name)
		ui.open()

/obj/machinery/turretid/ui_data(mob/user)
	return list(
		"locked" = locked,
		"enabled" = enabled,
		"lethal" = lethal,
		"siliconUser" = user.has_unlimited_silicon_privilege && check_ship_ai_access(user),
		"dangerous_only" = turret_flags & TURRET_FLAG_SHOOT_DANGEROUS_ONLY,
		"retaliate" = turret_flags & TURRET_FLAG_SHOOT_RETALIATE,
		"shoot_fauna" = turret_flags & TURRET_FLAG_SHOOT_FAUNA,
		"shoot_humans" = turret_flags & TURRET_FLAG_SHOOT_HUMANS,
		"shoot_silicons" = turret_flags & TURRET_FLAG_SHOOT_SILICONS,
		"only_nonfaction" = turret_flags & TURRET_FLAG_SHOOT_NONFACTION,
		"only_specificfaction" = turret_flags & TURRET_FLAG_SHOOT_SPECIFIC_FACTION,
	)

/obj/machinery/turretid/ui_act(action, list/params)
	. = ..()
	if(. || locked)
		return

	switch(action)
		if("lock")
			if(!usr.has_unlimited_silicon_privilege)
				return
			toggle_lock(usr)
			return TRUE
		if("power")
			toggle_on(usr)
		if("mode")
			toggle_lethal(usr)
		if("toggle_dangerous")
			turret_flags ^= TURRET_FLAG_SHOOT_DANGEROUS_ONLY
		if("toggle_retaliate")
			turret_flags ^= TURRET_FLAG_SHOOT_RETALIATE


		if("toggle_fauna")
			turret_flags ^= TURRET_FLAG_SHOOT_FAUNA
		if("toggle_humans")
			turret_flags ^= TURRET_FLAG_SHOOT_HUMANS
		if("toggle_silicons")
			turret_flags ^= TURRET_FLAG_SHOOT_SILICONS
		if("toggle_nonfaction")
			turret_flags ^= TURRET_FLAG_SHOOT_NONFACTION
		if("toggle_specificfaction")
			turret_flags ^= TURRET_FLAG_SHOOT_SPECIFIC_FACTION

		else
			return

	update_turrets()

/obj/machinery/turretid/proc/toggle_lock(mob/user)
	if(!user.canUseTopic(src, !issilicon(user)))
		return
	if(!allowed(user))
		to_chat(user, span_alert("Access denied."))
		return
	if(obj_flags & EMAGGED || (machine_stat & (BROKEN|MAINT)))
		to_chat(user, span_warning("The turret control is unresponsive!"))
		return

	to_chat(user, span_notice("You [locked ? "unlock" : "lock"] the turret control."))
	locked = !locked
	update_appearance()

/obj/machinery/turretid/proc/toggle_lethal(mob/user)
	if(!user.canUseTopic(src, !issilicon(user)))
		return
	if(obj_flags & EMAGGED || (machine_stat & (BROKEN|MAINT)))
		to_chat(user, span_warning("The turret control is unresponsive!"))
		return

	lethal = !lethal
	add_hiddenprint(user)
	log_combat(user, src, "[lethal ? "enabled" : "disabled"] lethals on")

/obj/machinery/turretid/proc/toggle_on(mob/user)
	if(!user.canUseTopic(src, !issilicon(user)))
		return
	if(obj_flags & EMAGGED || (machine_stat & (BROKEN|MAINT)))
		to_chat(user, span_warning("The turret control is unresponsive!"))
		return

	enabled = !enabled
	add_hiddenprint(user)
	log_combat(user, src, "[enabled ? "enabled" : "disabled"]")

/obj/machinery/turretid/proc/update_turrets()
	for(var/datum/weakref/turret_ref in turret_refs)
		var/obj/machinery/porta_turret/turret = turret_ref.resolve()
		if(!turret)
			turret_refs -= turret_ref
			continue
		turret.set_state(enabled, lethal, turret_flags)
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
	turret_flags = TURRET_FLAG_HOSTILE

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
	inverse = FALSE //So that it attaches to where you are facing.
