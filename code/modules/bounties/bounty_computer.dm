///Percentage of a civilian bounty the civilian will make.
#define CIV_BOUNTY_SPLIT 30

/obj/machinery/computer/bounty
	name = "\improper Outpost bounty console"
	desc = "Used to check and claim bounties offered by the outpost"
	icon_screen = "bounty"
	icon_keyboard = "id_key"
	circuit = /obj/item/circuitboard/computer/bounty
	light_color = COLOR_BRIGHT_ORANGE
	///Message to display on the TGUI window.
	var/status_report = "Ready for delivery."
	///Reference to the specific pad that the control computer is linked up to.
	var/datum/weakref/pad_ref
	///How long does it take to warmup the pad to teleport?
	var/warmup_time = warmup_time = 3 SECONDS
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
	///Typecast of an inserted, scanned ID card inside the console, as bounties are held within the ID card.
	var/obj/item/card/id/inserted_scan_id

/obj/machinery/computer/bounty/Initialize(mapload)
	..()
	if(isnull(nosell_typecache))
		nosell_typecache = typecacheof(/mob/living/silicon/robot)
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/bounty/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I) && istype(I.buffer,/obj/machinery/piratepad))
		to_chat(user, span_notice("You link [src] with [I.buffer] in [I] buffer."))
		pad_ref = WEAKREF(I.buffer)
		return TRUE

/obj/machinery/computer/bounty/post_machine_initialize()
	. = ..()
	if(cargo_hold_id)
		for(var/obj/machinery/piratepad/P as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/piratepad))
			if(P.cargo_hold_id == cargo_hold_id)
				pad_ref = WEAKREF(P)
				return
	else
		var/obj/machinery/piratepad/pad = locate() in range(4, src)
		pad_ref = WEAKREF(pad)

/obj/machinery/computer/bounty/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, interface_type, name)
		ui.open()

/obj/machinery/computer/bounty/ui_data(mob/user)
	var/list/data = list()
	data["points"] = points
	data["pad"] = pad_ref?.resolve() ? TRUE : FALSE
	data["sending"] = sending
	data["status_report"] = status_report
	return data

/obj/machinery/computer/bounty/ui_act(action, params)
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
/obj/machinery/computer/bounty/proc/recalc()
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
/obj/machinery/computer/bounty/proc/send()
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
/obj/machinery/computer/bounty/proc/pirate_export_loop(obj/machinery/piratepad/pad, dry_run = TRUE)
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
/obj/machinery/computer/bounty/proc/start_sending()
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
/obj/machinery/computer/bounty/proc/stop_sending(custom_report)
	if(!sending)
		return
	sending = FALSE
	status_report = "Ready for delivery."
	if(custom_report)
		status_report = custom_report
	var/obj/machinery/piratepad/pad = pad_ref?.resolve()
	pad.icon_state = pad.idle_state
	deltimer(sending_timer)

/obj/machinery/computer/bounty/attackby(obj/item/I, mob/living/user, params)
	if(isidcard(I))
		if(id_insert(user, I, inserted_scan_id))
			inserted_scan_id = I
			return TRUE
	return ..()

/obj/machinery/computer/bounty/multitool_act(mob/living/user, obj/item/multitool/I)
	if(istype(I) && istype(I.buffer,/obj/machinery/piratepad/civilian))
		to_chat(user, span_notice("You link [src] with [I.buffer] in [I] buffer."))
		pad_ref = WEAKREF(I.buffer)
		return TRUE

/obj/machinery/computer/bounty/post_machine_initialize()
	. = ..()
	if(cargo_hold_id)
		for(var/obj/machinery/piratepad/civilian/C as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/piratepad/civilian))
			if(C.cargo_hold_id == cargo_hold_id)
				pad_ref = WEAKREF(C)
				return
	else
		var/obj/machinery/piratepad/civilian/pad = locate() in range(4,src)
		pad_ref = WEAKREF(pad)

/obj/machinery/computer/bounty/recalc()
	if(sending)
		return FALSE
	if(!inserted_scan_id)
		status_report = "Please insert your ID first."
		playsound(loc, 'sound/machines/synth_no.ogg', 30 , TRUE)
		return FALSE
	if(!inserted_scan_id.registered_account.civilian_bounty)
		status_report = "Please accept a new civilian bounty first."
		playsound(loc, 'sound/machines/synth_no.ogg', 30 , TRUE)
		return FALSE
	status_report = "Civilian Bounty: "
	var/obj/machinery/piratepad/civilian/pad = pad_ref?.resolve()
	for(var/atom/movable/AM in get_turf(pad))
		if(AM == pad)
			continue
		if(inserted_scan_id.registered_account.civilian_bounty.applies_to(AM))
			status_report += "Target Applicable."
			playsound(loc, 'sound/machines/synth_yes.ogg', 30 , TRUE)
			return
	status_report += "Not Applicable."
	playsound(loc, 'sound/machines/synth_no.ogg', 30 , TRUE)

/**
 * This fully rewrites base behavior in order to only check for bounty objects, and nothing else.
 */
/obj/machinery/computer/bounty/send()
	playsound(loc, 'sound/machines/wewewew.ogg', 70, TRUE)
	if(!sending)
		return
	if(!inserted_scan_id)
		stop_sending()
		return FALSE
	if(!inserted_scan_id.registered_account.civilian_bounty)
		stop_sending()
		return FALSE
	var/datum/bounty/curr_bounty = inserted_scan_id.registered_account.civilian_bounty
	var/active_stack = 0
	var/obj/machinery/piratepad/civilian/pad = pad_ref?.resolve()
	for(var/atom/movable/AM in get_turf(pad))
		if(AM == pad)
			continue
		if(curr_bounty.applies_to(AM))
			active_stack ++
			curr_bounty.ship(AM)
			qdel(AM)
	if(active_stack >= 1)
		status_report += "Bounty Target Found x[active_stack]. "
	else
		status_report = "No applicable targets found. Aborting."
		stop_sending()
	if(curr_bounty.can_claim())
		//Pay for the bounty with the ID's department funds.
		status_report += "Bounty completed! Please give your bounty cube to cargo for your automated payout shortly."
		inserted_scan_id.registered_account.reset_bounty()
		SSeconomy.civ_bounty_tracker++

		var/obj/item/bounty_cube/reward = new /obj/item/bounty_cube(drop_location())
		reward.set_up(curr_bounty, inserted_scan_id)

	pad.visible_message(span_notice("[pad] activates!"))
	flick(pad.sending_state,pad)
	pad.icon_state = pad.idle_state
	playsound(loc, 'sound/machines/synth_yes.ogg', 30 , TRUE)
	sending = FALSE

///Here is where cargo bounties are added to the player's bank accounts, then adjusted and scaled into a civilian bounty.
/obj/machinery/computer/bounty/proc/add_bounties(cooldown_reduction = 0)
	if(!inserted_scan_id || !inserted_scan_id.registered_account)
		return
	var/datum/bank_account/pot_acc = inserted_scan_id.registered_account
	if((pot_acc.civilian_bounty || pot_acc.bounties) && !COOLDOWN_FINISHED(pot_acc, bounty_timer))
		var/curr_time = round((COOLDOWN_TIMELEFT(pot_acc, bounty_timer)) / (1 MINUTES), 0.01)
		say("Internal ID network spools coiling, try again in [curr_time] minutes!")
		return FALSE
	if(!pot_acc.account_job)
		say("Requesting ID card has no job assignment registered!")
		return FALSE
	var/list/datum/bounty/crumbs = list(random_bounty(pot_acc.account_job.bounty_types), // We want to offer 2 bounties from their appropriate job catagories
										random_bounty(pot_acc.account_job.bounty_types), // and 1 guarenteed assistant bounty if the other 2 suck.
										random_bounty(CIV_JOB_BASIC))
	COOLDOWN_START(pot_acc, bounty_timer, (5 MINUTES) - cooldown_reduction)
	pot_acc.bounties = crumbs

/obj/machinery/computer/bounty/proc/pick_bounty(choice)
	if(!inserted_scan_id || !inserted_scan_id.registered_account || !inserted_scan_id.registered_account.bounties || !inserted_scan_id.registered_account.bounties[choice])
		playsound(loc, 'sound/machines/synth_no.ogg', 40 , TRUE)
		return
	inserted_scan_id.registered_account.civilian_bounty = inserted_scan_id.registered_account.bounties[choice]
	inserted_scan_id.registered_account.bounties = null
	return inserted_scan_id.registered_account.civilian_bounty

/obj/machinery/computer/bounty/click_alt(mob/user)
	id_eject(user, inserted_scan_id)
	return CLICK_ACTION_SUCCESS

/obj/machinery/computer/bounty/ui_data(mob/user)
	var/list/data = list()
	data["points"] = points
	data["pad"] = pad_ref?.resolve() ? TRUE : FALSE
	data["sending"] = sending
	data["status_report"] = status_report
	data["id_inserted"] = inserted_scan_id
	if(inserted_scan_id?.registered_account)
		if(inserted_scan_id.registered_account.civilian_bounty)
			data["id_bounty_info"] = inserted_scan_id.registered_account.civilian_bounty.description
			data["id_bounty_num"] = inserted_scan_id.registered_account.bounty_num()
			data["id_bounty_value"] = (inserted_scan_id.registered_account.civilian_bounty.reward) * (CIV_BOUNTY_SPLIT/100)
		if(inserted_scan_id.registered_account.bounties)
			data["picking"] = TRUE
			data["id_bounty_names"] = list(inserted_scan_id.registered_account.bounties[1].name,
											inserted_scan_id.registered_account.bounties[2].name,
											inserted_scan_id.registered_account.bounties[3].name)
			data["id_bounty_infos"] = list(inserted_scan_id.registered_account.bounties[1].description,
											inserted_scan_id.registered_account.bounties[2].description,
											inserted_scan_id.registered_account.bounties[3].description)
			data["id_bounty_values"] = list(inserted_scan_id.registered_account.bounties[1].reward * (CIV_BOUNTY_SPLIT/100),
											inserted_scan_id.registered_account.bounties[2].reward * (CIV_BOUNTY_SPLIT/100),
											inserted_scan_id.registered_account.bounties[3].reward * (CIV_BOUNTY_SPLIT/100))
		else
			data["picking"] = FALSE

	return data

/obj/machinery/computer/bounty/ui_act(action, params)
	. = ..()
	if(.)
		return
	var/obj/machinery/piratepad/civilian/pad = pad_ref?.resolve()
	if(!pad)
		return
	if(!usr.can_perform_action(src) || (machine_stat & (NOPOWER|BROKEN)))
		return
	switch(action)
		if("recalc")
			recalc()
		if("send")
			start_sending()
		if("stop")
			stop_sending()
		if("pick")
			pick_bounty(params["value"])
		if("bounty")
			add_bounties(pad.get_cooldown_reduction())
		if("eject")
			id_eject(usr, inserted_scan_id)
			inserted_scan_id = null
	. = TRUE

///Self explanitory, holds the ID card in the console for bounty payout and manipulation.
/obj/machinery/computer/bounty/proc/id_insert(mob/user, obj/item/inserting_item, obj/item/target)
	var/obj/item/card/id/card_to_insert = inserting_item
	var/holder_item = FALSE

	if(!isidcard(card_to_insert))
		card_to_insert = inserting_item.RemoveID()
		holder_item = TRUE

	if(!card_to_insert || !user.transferItemToLoc(card_to_insert, src))
		return FALSE

	if(target)
		if(holder_item && inserting_item.InsertID(target))
			playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
		else
			id_eject(user, target)

	user.visible_message(span_notice("[user] inserts \the [card_to_insert] into \the [src]."),
						span_notice("You insert \the [card_to_insert] into \the [src]."))
	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
	ui_interact(user)
	return TRUE

///Removes A stored ID card.
/obj/machinery/computer/bounty/proc/id_eject(mob/user, obj/target)
	if(!target)
		to_chat(user, span_warning("That slot is empty!"))
		return FALSE
	else
		target.forceMove(drop_location())
		if(!issilicon(user) && Adjacent(user))
			user.put_in_hands(target)
		user.visible_message(span_notice("[user] gets \the [target] from \the [src]."), \
							span_notice("You get \the [target] from \the [src]."))
		playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
		inserted_scan_id = null
		return TRUE

#undef CIV_BOUNTY_SPLIT
