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
	var/value = 0
	if(istype(I, /obj/item/stack/spacecash))
		var/obj/item/stack/spacecash/C = I
		value = C.value * C.amount
	else if(istype(I, /obj/item/holochip))
		var/obj/item/holochip/H = I
		value = H.credits
	if(value)
		sell_account.adjust_money(value)
		to_chat(user, "<span class='notice'>You deposit [I]. The Vessel Budget is now [sell_account.account_balance] cr.</span>")
		qdel(I)
		return
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
	data["pad"] = pad.resolve() ? TRUE : FALSE
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

	sell_account.adjust_money(value)

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
	sending_timer = addtimer(CALLBACK(src,.proc/send),warmup_time, TIMER_STOPPABLE)

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
