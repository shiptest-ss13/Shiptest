/obj/machinery/computer/bank_machine
	name = "bank machine"
	desc = "A machine used to deposit and withdraw funds."
	icon_screen = "vault"
	icon_keyboard = "security_key"
	idle_power_usage = IDLE_DRAW_LOW

	var/siphoning = FALSE
	var/next_warning = 0
	var/obj/item/radio/radio
	var/datum/weakref/ship_account_ref
	var/radio_channel = RADIO_CHANNEL_COMMON
	var/minimum_time_between_warnings = 400
	var/syphoning_credits = 0

/obj/machinery/computer/bank_machine/Initialize()
	. = ..()
	radio = new(src)
	radio.subspace_transmission = TRUE
	radio.canhear_range = 0
	radio.recalculateChannels()

/obj/machinery/computer/bank_machine/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	ship_account_ref = WEAKREF(port.current_ship.ship_account)

/obj/machinery/computer/bank_machine/Destroy()
	QDEL_NULL(radio)
	. = ..()

/obj/machinery/computer/bank_machine/attackby(obj/item/I, mob/user)
	var/value = I.get_item_credit_value()
	if(value)
		var/datum/bank_account/ship_account = ship_account_ref.resolve()
		if(ship_account)
			ship_account.adjust_money(value, CREDIT_LOG_DEPOSIT)
			to_chat(user, "<span class='notice'>You deposit [I]. The [ship_account.account_holder] Budget is now [ship_account.account_balance] cr.</span>")
		qdel(I)
		return
	return ..()

/obj/machinery/computer/bank_machine/process()
	..()
	if(siphoning)
		if (machine_stat & (BROKEN|NOPOWER))
			say("Insufficient power. Halting siphon.")
			end_syphon()
		var/datum/bank_account/ship_account = ship_account_ref.resolve()
		if(!ship_account?.has_money(200))
			say("Ship budget depleted. Halting siphon.")
			end_syphon()
			return

		playsound(src, 'sound/items/poster_being_created.ogg', 100, TRUE)
		syphoning_credits += 200
		ship_account.adjust_money(-200, "siphon")
		if(next_warning < world.time && prob(15))
			var/area/A = get_area(loc)
			var/message = "Unauthorized credit withdrawal underway in [initial(A.name)]!!"
			radio.talk_into(src, message, radio_channel)
			next_warning = world.time + minimum_time_between_warnings

/obj/machinery/computer/bank_machine/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BankMachine", name)
		ui.open()

/obj/machinery/computer/bank_machine/ui_data(mob/user)
	var/list/data = list()
	var/datum/bank_account/ship_account = ship_account_ref.resolve()
	if(ship_account)
		data["current_balance"] = ship_account.account_balance
	else
		data["current_balance"] = 0
	data["siphoning"] = siphoning
	data["ship_name"] = ship_account.account_holder

	return data

/obj/machinery/computer/bank_machine/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("siphon")
			say("Siphon of ship credits has begun!")
			siphoning = TRUE
			. = TRUE
		if("halt")
			say("Ship credit withdrawal halted.")
			end_syphon()
			. = TRUE

/obj/machinery/computer/bank_machine/proc/end_syphon()
	siphoning = FALSE
	new /obj/item/spacecash/bundle(drop_location(), syphoning_credits) //get the loot
	syphoning_credits = 0
