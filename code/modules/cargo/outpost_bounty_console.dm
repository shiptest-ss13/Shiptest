
GLOBAL_LIST_INIT(outpost_exports, gen_outpost_exports())

#warn remove, use /datum/export code
/proc/gen_outpost_exports()
	var/ret_list = list()

	for(var/o_b in subtypesof(/datum/export))
		ret_list += new o_b()
	return ret_list

#warn remove /obj/machinery/computer/bounty, /obj/machinery/bounty_board, /datum/bounty, /datum/computer_file/program/bounty_board, associated circuits,
#warn also need to remove the old /datum/export values
#warn remove old /obj/machinery/selling_pad, /obj/item/circuitboard/machine/selling_pad, etc.

/obj/machinery/outpost_selling_pad
	name = "bounty redemption pad"
	icon = 'icons/obj/telescience.dmi'
	icon_state = "lpad-idle-o"

/obj/machinery/outpost_selling_pad/proc/get_other_atoms()
	. = list()
	for(var/atom/movable/AM in get_turf(src))
		if(AM == src)
			continue
		. += AM

/obj/machinery/computer/outpost_export_console
	name = "outpost bounty console"
	#warn fix
	desc = " blah blah blah "

	var/obj/machinery/outpost_selling_pad/linked_pad



/*
	name = "hydrogen pump"
	desc = "Lets you use merits to buy hydrogen."
	icon = 'icons/obj/atmos.dmi'
	icon_state = "hydrogen_pump"

	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	active_power_usage = 1000

	density = TRUE
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 30)
	layer = OBJ_LAYER
	showpipe = TRUE
	pipe_flags = PIPING_ONE_PER_TURF | PIPING_DEFAULT_LAYER_ONLY
	var/not_processing_bug = TRUE//remove when fixed
	var/merit
*/




#warn probably most similar to the traitor uplink, except there are no "buy" buttons
/obj/machinery/computer/outpost_export_console/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OutpostExport", name)
		ui.open()

/obj/machinery/computer/outpost_export_console/ui_data(mob/user)
	var/list/data = list()

	data["redeemExports"] = list()

	for(var/datum/export/cached_exp as anything in cached_valid_exports)
		var/list/atom/atoms_list = cached_valid_exports[cached_exp]

		var/list/cached_exp_data = list()
		cached_exp_data["type"] = cached_exp.type
		cached_exp_data["name"] = cached_exp.unit_name
		cached_exp_data["desc"] = cached_exp.desc
		cached_exp_data["value"] = cached_exp.calc_total_payout(atoms_list)

		cached_exp_data["exportAtoms"] = list()
		for(var/atom/exp_atom as anything in atoms_list)
			cached_exp_data["exportAtoms"] += exp_atom.name

		data["redeemExports"] += list(cached_exp_data) // gotta wrap it in a list because byond sucks

/obj/machinery/computer/outpost_export_console/ui_static_data(mob/user)
	var/list/data = list()

	data["allExports"] = list()
	for(var/datum/export/exp as anything in GLOB.exports_list)
		var/list/exp_data = list()

		exp_data["type"] = exp.type
		exp_data["name"] = exp.unit_name
		exp_data["value"] = exp.get_payout_text()
		exp_data["desc"] = exp.desc
		exp_data["exportAtoms"] = list()

		data["allExports"] += list(exp_data) // need to wrap with an extra list because byond sucks

/obj/machinery/computer/outpost_export_console/ui_act(action, params)
	. = ..()
	if(.)
		return

	#warn we need a redeem button per-export and an "eject" button (for all export items, maybe, but easier if it's just one)
	#warn all other behavior should be handled locally by the tgui instance
	switch(action)
		if("redeem")
			var/datum/export/redeemed_exp = locate(text2path(params["redeem_type"])) in cached_valid_exports
			if(redeemed_exp == null || len(cached_valid_exports[redeemed_exp]) == 0)
				#warn there was an error
			else
				redeem_export(redeemed_exp)
			return TRUE

/obj/machinery/computer/outpost_export_console/proc/redeem_export(datum/export/exp)
	if(!(exp in cached_valid_exports))
		#warn fuck
		return FALSE
	var/total_payout = 0
	for(var/atom/exp_atom as anything in cached_valid_exports[exp])
		if(!exp.applies_to(exp_atom))
			#warn fuck
			return FALSE
		total_payout += exp.sell_object(exp_atom, dry_run = FALSE, apply_elastic = TRUE)

		cached_valid_exports[exp] -= exp_atom
		qdel(exp_atom)

	cached_valid_exports -= exp

	#warn create cash or whatever. it should also make a sound
	return TRUE







/*
/obj/machinery/computer/hydrogen_exchange/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HydrogenExchange", name)
		ui.open()

/obj/machinery/computer/hydrogen_exchange/ui_data(mob/user)
	var/next_merit_rate
	if(GLOB.total_merits_exchanged)
		next_merit_rate = round((GLOB.total_merits_exchanged ** MERIT_EXPONENT) / GLOB.total_merits_exchanged * CREDITS_TO_MERITS, 0.01)
	else
		next_merit_rate = CREDITS_TO_MERITS
	var/list/data = list()
	data["credits"] = credits
	data["merits"] = merits
	data["next_merit_rate"] = next_merit_rate
	data["credits_to_merits"] = CREDITS_TO_MERITS
	data["credit_tax"] = (1 - meritmultiplier()) * 100
	return data

/obj/machinery/computer/hydrogen_exchange/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("convert_to_credits")
			convert_to_credits()
			. = TRUE
		if("convert_to_merits")
			convert_to_merits()
			. = TRUE
		if("dispense")
			dispense_funds()
			. = TRUE
*/

/*
//Pad & Pad Terminal
/obj/machinery/selling_pad
	name = "cargo hold pad"
	icon = 'icons/obj/telescience.dmi'
	icon_state = "lpad-idle-o"
	circuit = /obj/item/circuitboard/machine/selling_pad

/obj/machinery/selling_pad/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if(!multitool_check_buffer(user, I))
		return
	to_chat(user, "<span class='notice'>You register [src] in [I]s buffer.</span>")
	I.buffer = src
	return TRUE

/obj/machinery/computer/selling_pad_control
	name = "cargo hold control terminal"
	circuit = /obj/item/circuitboard/computer/selling_pad_control
	icon_screen = "bounty"
	var/status_report = "Ready for delivery."
	var/datum/weakref/pad
	var/warmup_time = 100
	var/sending = FALSE
	var/datum/bank_account/sell_account
	var/datum/export_report/total_report
	var/sending_timer

/obj/machinery/computer/selling_pad_control/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/selling_pad_control/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	sell_account = port.current_ship?.ship_account

/obj/machinery/computer/selling_pad_control/attackby(obj/item/I, mob/user)
	var/value = I.get_item_credit_value()
	if(value)
		sell_account.adjust_money(value, "selling_pad")
		to_chat(user, "<span class='notice'>You deposit [I]. The Vessel Budget is now [sell_account.account_balance] cr.</span>")
		qdel(I)
		return TRUE
	return ..()

/obj/machinery/computer/selling_pad_control/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I.buffer, /obj/machinery/selling_pad))
		to_chat(user, "<span class='notice'>You link [src] with [I.buffer] in [I] buffer.</span>")
		pad = WEAKREF(I.buffer)
		return TRUE

/obj/machinery/computer/selling_pad_control/proc/try_connect()
	if(!pad)
		var/obj/machinery/selling_pad/sell_pad = locate() in range(4,src)
		pad = WEAKREF(sell_pad)
	if(!sell_account)
		var/area/ship/current_area = get_area(src)
		if(!istype(current_area))
			return
		sell_account = current_area.mobile_port?.current_ship.ship_account

/obj/machinery/computer/selling_pad_control/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		if(!pad || !sell_account)
			try_connect()
		ui = new(user, src, "CargoHoldTerminal", name)
		ui.open()

/obj/machinery/computer/selling_pad_control/ui_data(mob/user)
	var/list/data = list()
	data["points"] = sell_account.account_balance
	data["pad"] = pad?.resolve() ? TRUE : FALSE
	data["sending"] = sending
	data["status_report"] = status_report
	return data

/obj/machinery/computer/selling_pad_control/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(!pad.resolve())
		return

	switch(action)
		if("recalc")
			recalc()
			. = TRUE
		if("send")
			start_sending()
			. = TRUE
		if("stop")
			stop_sending()
			. = TRUE

/obj/machinery/computer/selling_pad_control/proc/recalc()
	if(sending)
		return
	var/obj/machinery/selling_pad/sell_pad = pad.resolve()
	if(!sell_pad)
		return

	status_report = "Predicted value: "
	var/value = 0
	var/datum/export_report/ex = new
	for(var/atom/movable/AM in get_turf(sell_pad))
		if(AM == sell_pad)
			continue
		export_item_and_contents(AM, apply_elastic = FALSE, dry_run = TRUE, external_report = ex)

	for(var/datum/export/E in ex.total_amount)
		status_report += E.total_printout(ex,notes = FALSE)
		status_report += " "
		value += ex.total_value[E]

	if(!value)
		status_report += "0"

/obj/machinery/computer/selling_pad_control/proc/send()
	if(!sending)
		return

	var/obj/machinery/selling_pad/sell_pad = pad.resolve()
	if(!sell_pad)
		return

	var/datum/export_report/ex = new

	for(var/atom/movable/AM in get_turf(sell_pad))
		if(AM == sell_pad)
			continue
		export_item_and_contents(AM, apply_elastic = FALSE, delete_unsold = FALSE, external_report = ex)

	status_report = "Sold: "
	var/value = 0
	for(var/datum/export/E in ex.total_amount)
		var/export_text = E.total_printout(ex,notes = FALSE) //Don't want nanotrasen messages, makes no sense here.
		if(!export_text)
			continue

		status_report += export_text
		status_report += " "
		value += ex.total_value[E]

	if(!total_report)
		total_report = ex
	else
		total_report.exported_atoms += ex.exported_atoms
		for(var/datum/export/E in ex.total_amount)
			total_report.total_amount[E] += ex.total_amount[E]
			total_report.total_value[E] += ex.total_value[E]

	sell_account.adjust_money(value, "selling_pad")

	if(!value)
		status_report += "Nothing"

	sell_pad.visible_message("<span class='notice'>[sell_pad] activates!</span>")
	flick("lpad-beam", pad)
	sell_pad.icon_state = "lpad-idle-o"
	sending = FALSE

/obj/machinery/computer/selling_pad_control/proc/start_sending()
	if(sending)
		return
	var/obj/machinery/selling_pad/sell_pad = pad.resolve()
	if(!sell_pad)
		return
	sending = TRUE
	status_report = "Sending..."
	sell_pad.visible_message("<span class='notice'>[sell_pad] starts charging up.</span>")
	sell_pad.icon_state = "lpad-idle"
	sending_timer = addtimer(CALLBACK(src, PROC_REF(send)),warmup_time, TIMER_STOPPABLE)

/obj/machinery/computer/selling_pad_control/proc/stop_sending()
	if(!sending)
		return
	var/obj/machinery/selling_pad/sell_pad = pad.resolve()
	if(!sell_pad)
		return
	sending = FALSE
	status_report = "Ready for delivery."
	sell_pad.icon_state = "lpad-idle-o"
	deltimer(sending_timer)
*/




