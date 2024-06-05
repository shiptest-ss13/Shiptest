//Pad & Pad Terminal
/obj/machinery/piratepad
	name = "cargo hold pad"
	icon = 'icons/obj/machines/telepad.dmi'
	icon_state = "lpad-idle-off"
	///This is the icon_state that this telepad uses when it's not in use.
	var/idle_state = "lpad-idle-off"
	///This is the icon_state that this telepad uses when it's warming up for goods teleportation.
	var/warmup_state = "lpad-idle"
	///This is the icon_state to flick when the goods are being sent off by the telepad.
	var/sending_state = "lpad-beam"
	///This is the cargo hold ID used by the piratepad_control. Match these two to link them together.
	var/cargo_hold_id

/obj/machinery/piratepad/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I))
		I.set_buffer(src)
		balloon_alert(user, "saved to multitool buffer")
		return TRUE

/obj/machinery/piratepad/screwdriver_act_secondary(mob/living/user, obj/item/screwdriver/screw)
	. = ..()
	if(!.)
		return default_deconstruction_screwdriver(user, "lpad-idle-open", "lpad-idle-off", screw)

/obj/machinery/piratepad/crowbar_act_secondary(mob/living/user, obj/item/tool)
	. = ..()
	default_deconstruction_crowbar(tool)
	return TRUE

/obj/machinery/computer/piratepad_control
	name = "cargo hold control terminal"
	///Message to display on the TGUI window.
	var/status_report = "Ready for delivery."
	///Reference to the specific pad that the control computer is linked up to.
	var/datum/weakref/pad_ref
	///How long does it take to warmup the pad to teleport?
	var/warmup_time = 100
	///Is the teleport pad/computer sending something right now? TRUE/FALSE
	var/sending = FALSE
	///For the purposes of space pirates, how many points does the control pad have collected.
	var/points = 0
	///Reference to the export report totaling all sent objects and mobs.
	var/datum/export_report/total_report
	///Callback holding the sending timer for sending the goods after a delay.
	var/sending_timer
	///This is the cargo hold ID used by the piratepad machine. Match these two to link them together.
	var/cargo_hold_id
	///Interface name for the ui_interact call for different subtypes.
	var/interface_type = "CargoHoldTerminal"
	///Typecache of things that shouldn't be sold and shouldn't have their contents sold.
	var/static/list/nosell_typecache

/obj/machinery/computer/piratepad_control/Initialize(mapload)
	..()
	if(isnull(nosell_typecache))
		nosell_typecache = typecacheof(/mob/living/silicon/robot)
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/piratepad_control/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I) && istype(I.buffer,/obj/machinery/piratepad))
		to_chat(user, span_notice("You link [src] with [I.buffer] in [I] buffer."))
		pad_ref = WEAKREF(I.buffer)
		return TRUE

/obj/machinery/computer/piratepad_control/post_machine_initialize()
	. = ..()
	if(cargo_hold_id)
		for(var/obj/machinery/piratepad/P as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/piratepad))
			if(P.cargo_hold_id == cargo_hold_id)
				pad_ref = WEAKREF(P)
				return
	else
		var/obj/machinery/piratepad/pad = locate() in range(4, src)
		pad_ref = WEAKREF(pad)

/obj/machinery/computer/piratepad_control/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, interface_type, name)
		ui.open()

/obj/machinery/computer/piratepad_control/ui_data(mob/user)
	var/list/data = list()
	data["points"] = points
	data["pad"] = pad_ref?.resolve() ? TRUE : FALSE
	data["sending"] = sending
	data["status_report"] = status_report
	return data

/obj/machinery/computer/piratepad_control/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(!pad_ref?.resolve())
		return

	switch(action)
		if("recalc")
			recalc()
			. = TRUE
		if("send")
			start_sending()
			//We ensure that the holding facility is loaded in time in case we're selling mobs.
			//This isn't the prettiest place to put it, but 'start_sending()' is also used by civilian bounty computers
			//And we don't need them to also load the holding facility.
			SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_NINJA_HOLDING_FACILITY)
			. = TRUE
		if("stop")
			stop_sending()
			. = TRUE

/// Calculates the predicted value of the items on the pirate pad
/obj/machinery/computer/piratepad_control/proc/recalc()
	if(sending)
		return

	status_report = "Predicted value: "
	var/value = 0

	var/obj/machinery/piratepad/pad = pad_ref?.resolve()
	var/datum/export_report/report = pirate_export_loop(pad)

	for(var/datum/export/exported_datum in report.total_amount)
		status_report += exported_datum.total_printout(report,notes = FALSE)
		status_report += " "
		value += report.total_value[exported_datum]

	if(!value)
		status_report += "0"

/// Deletes and sells the item
/obj/machinery/computer/piratepad_control/proc/send()
	if(!sending)
		return

	var/obj/machinery/piratepad/pad = pad_ref?.resolve()
	var/datum/export_report/report = pirate_export_loop(pad, dry_run = FALSE)

	status_report = "Sold: "
	var/value = 0
	for(var/datum/export/exported_datum in report.total_amount)
		var/export_text = exported_datum.total_printout(report,notes = FALSE) //Don't want nanotrasen messages, makes no sense here.
		if(!export_text)
			continue

		status_report += export_text
		status_report += " "
		value += report.total_value[exported_datum]

	if(!total_report)
		total_report = report
	else
		total_report.exported_atoms += report.exported_atoms
		for(var/datum/export/exported_datum in report.total_amount)
			total_report.total_amount[exported_datum] += report.total_amount[exported_datum]
			total_report.total_value[exported_datum] += report.total_value[exported_datum]
		playsound(loc, 'sound/machines/wewewew.ogg', 70, TRUE)

	points += value

	if(!value)
		status_report += "Nothing"

	pad.visible_message(span_notice("[pad] activates!"))
	flick(pad.sending_state,pad)
	pad.icon_state = pad.idle_state
	sending = FALSE

///The loop that calculates the value of stuff on a pirate pad, or plain sell them if dry_run is FALSE.
/obj/machinery/computer/piratepad_control/proc/pirate_export_loop(obj/machinery/piratepad/pad, dry_run = TRUE)
	var/datum/export_report/report = new
	for(var/atom/movable/item_on_pad as anything in get_turf(pad))
		if(item_on_pad == pad)
			continue
		var/list/hidden_mobs = list()
		var/skip_movable = FALSE
		var/list/item_contents = item_on_pad.get_all_contents()
		for(var/atom/movable/thing in reverse_range(item_contents))
			///Don't destroy/sell stuff like the captain's laser gun, or borgs.
			if(thing.resistance_flags & INDESTRUCTIBLE || is_type_in_typecache(thing, nosell_typecache))
				skip_movable = TRUE
				break
			if(isliving(thing))
				hidden_mobs += thing
		if(skip_movable)
			continue
		for(var/mob/living/hidden as anything in hidden_mobs)
			///Sell mobs, but leave their contents intact.
			export_single_item(hidden, apply_elastic = FALSE, dry_run = dry_run, external_report = report)
		///there are still licing mobs inside that item. Stop, don't sell it ffs.
		if(locate(/mob/living) in item_on_pad.get_all_contents())
			continue
		export_item_and_contents(item_on_pad, apply_elastic = FALSE, dry_run = dry_run, delete_unsold = FALSE, external_report = report, ignore_typecache = nosell_typecache)
	return report

/// Prepares to sell the items on the pad
/obj/machinery/computer/piratepad_control/proc/start_sending()
	var/obj/machinery/piratepad/pad = pad_ref?.resolve()
	if(!pad)
		status_report = "No pad detected. Build or link a pad."
		pad.audible_message(span_notice("[pad] beeps."))
		return
	if(pad?.panel_open)
		status_report = "Please screwdrive pad closed to send. "
		pad.audible_message(span_notice("[pad] beeps."))
		return
	if(sending)
		return
	sending = TRUE
	status_report = "Sending... "
	pad.visible_message(span_notice("[pad] starts charging up."))
	pad.icon_state = pad.warmup_state
	sending_timer = addtimer(CALLBACK(src, PROC_REF(send)),warmup_time, TIMER_STOPPABLE)

/// Finishes the sending state of the pad
/obj/machinery/computer/piratepad_control/proc/stop_sending(custom_report)
	if(!sending)
		return
	sending = FALSE
	status_report = "Ready for delivery."
	if(custom_report)
		status_report = custom_report
	var/obj/machinery/piratepad/pad = pad_ref?.resolve()
	pad.icon_state = pad.idle_state
	deltimer(sending_timer)

/// Attempts to find the thing on station
/datum/export/pirate/proc/find_loot()
	return

/datum/export/pirate/ransom
	cost = 3000
	unit_name = "hostage"
	export_types = list(/mob/living/carbon/human)

/datum/export/pirate/ransom/find_loot()
	var/list/head_minds = SSjob.get_living_heads()
	var/list/head_mobs = list()
	for(var/datum/mind/M as anything in head_minds)
		head_mobs += M.current
	if(head_mobs.len)
		return pick(head_mobs)

/datum/export/pirate/ransom/get_cost(atom/movable/exported_item)
	var/mob/living/carbon/human/ransomee = exported_item
	if(ransomee.stat != CONSCIOUS || !ransomee.mind || HAS_TRAIT(ransomee.mind, TRAIT_HAS_BEEN_KIDNAPPED)) //mint condition only
		return 0
	else if(FACTION_PIRATE in ransomee.faction) //can't ransom your fellow pirates to CentCom!
		return 0
	else if(HAS_TRAIT(ransomee, TRAIT_HIGH_VALUE_RANSOM))
		return 3000
	else
		return 1000

/datum/export/pirate/ransom/sell_object(mob/living/carbon/human/sold_item, datum/export_report/report, dry_run = TRUE, apply_elastic = TRUE)
	. = ..()
	if(. == EXPORT_NOT_SOLD || dry_run)
		return
	var/turf/picked_turf = pick(GLOB.holdingfacility)
	sold_item.forceMove(picked_turf)
	var/mob_cost = get_cost(sold_item)
	sold_item.process_capture(mob_cost, mob_cost * 1.2)
	do_sparks(8, FALSE, sold_item)
	playsound(picked_turf, 'sound/weapons/emitter2.ogg', 25, TRUE)
	sold_item.flash_act()
	sold_item.adjust_confusion(10 SECONDS)
	sold_item.adjust_dizzy(10 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(send_back_to_station), sold_item), COME_BACK_FROM_CAPTURE_TIME)
	to_chat(sold_item, span_hypnophrase("A million voices echo in your head... <i>\"Yaarrr, thanks for the booty, landlubber. \
		You will be ransomed back to your station, so it's only a matter of time before we ship you back...</i>"))

	return EXPORT_SOLD_DONT_DELETE

