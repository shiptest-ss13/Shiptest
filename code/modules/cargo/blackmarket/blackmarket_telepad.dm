/obj/item/circuitboard/machine/ltsrbt
	name = "LTSRBT (Machine Board)"
	icon_state = "bluespacearray"
	build_path = /obj/machinery/ltsrbt
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/scanning_module = 2)

/obj/machinery/ltsrbt
	name = "Long-To-Short-Range-Bluespace-Transciever"
	desc = "The LTSRBT is a compact teleportation machine for recieving and sending items across extreme distances and through reasonable interference.\nUsing teleportation frequencies stolen from Makosso-Warra it is near undetectable.\nEssential for any illegal market operations or off-the-book frontier settlements.\n"
	circuit = /obj/item/circuitboard/machine/ltsrbt
	icon = 'icons/obj/machines/ltsrbt.dmi'
	icon_state = "ltsrbt"
	base_icon_state = "ltsrbt"
	density = TRUE

	idle_power_usage = IDLE_DRAW_LOW
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND

	/// Divider for power_usage_per_teleport.
	var/power_efficiency = 1
	/// Power used per teleported which gets divided by power_efficiency.
	var/power_usage_per_teleport = 10000
	/// The time it takes for the machine to recharge before being able to send or recieve items.
	var/recharge_time = 0
	/// Current recharge progress.
	var/recharge_cooldown = 0
	/// Base recharge time which is used to get recharge_time.
	var/base_recharge_time = 20
	/// Current /datum/blackmarket_purchase being recieved.
	var/recieving
	/// Current /datum/blackmarket_purchase being sent to the target uplink.
	var/transmitting
	/// Queue for purchases that the machine should recieve and send.
	var/list/datum/blackmarket_purchase/queue = list()

	/// The name of the market item that we've set on the UI
	var/current_name = ""
	/// The desc of the market item that we've set on the UI
	var/current_desc = ""
	/// The price of the market item that we've set on the UI
	var/current_price = 100

	/// The name of this LTSRBT on the black market
	var/seller_id = ""
	/// You can't change the ID once it's set. If you sell too many fraudulent goods, people won't trust your ID.
	var/id_locked = FALSE

/obj/machinery/ltsrbt/Destroy()
	// Bye bye orders.
	if(SSblackmarket.telepads.len)
		for(var/datum/blackmarket_purchase/P in queue)
			SSblackmarket.queue_item(P)
	if(recieving)
		SSblackmarket.queue_item(recieving)
	queue = null
	recieving = null
	transmitting = null
	return ..()

/obj/machinery/ltsrbt/examine(mob/user)
	. = ..()
	. += span_notice("You can load a crate into \the [name] by dragging it onto the machine while the trunk is open.")

/obj/machinery/ltsrbt/RefreshParts()
	recharge_time = base_recharge_time
	// On tier 4 recharge_time should be 2 and by default it is 8 as scanning modules should be tier 1.
	for(var/obj/item/stock_parts/scanning_module/scan in component_parts)
		recharge_time -= scan.rating
	recharge_cooldown = recharge_time

	power_efficiency = 0
	for(var/obj/item/stock_parts/micro_laser/laser in component_parts)
		power_efficiency += laser.rating
	// Shouldn't happen but you never know.
	if(!power_efficiency)
		power_efficiency = 1

/// Stores the LTSRBT Data in the uplink for linking
/obj/machinery/ltsrbt/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/blackmarket_uplink))
		var/obj/item/blackmarket_uplink/uplink = O
		uplink.target = src
		to_chat(user, span_notice("[src] linked to [O]."))
		return TRUE

	if(state_open)
		if(locate(/mob/living) in O.get_all_contents())
			say("Living being detected, cannot sell!")
			playsound(src, 'sound/machines/buzz-sigh.ogg', 40, FALSE)
			return TRUE
		if(!user.transferItemToLoc(O, src))
			balloon_alert(user, "stuck to your hands!")
			return TRUE
		balloon_alert(user, "item loaded")
		close_machine(O)
		return TRUE
	else if(user.a_intent != INTENT_HARM)
		balloon_alert(user, "open the machine!")
		return TRUE

	if(machine_stat & NOPOWER)
		return

	return ..()

/obj/machinery/ltsrbt/proc/load_crate(obj/structure/closet/crate/our_crate, mob/user)
	if(!state_open)
		to_chat(user, span_warning("The [name]'s trunk is closed! Open it up first!"))
		return
	else
		close_machine(our_crate)

/// Adds /datum/blackmarket_purchase to queue unless the machine is free, then it sets the purchase to be instantly recieved
/obj/machinery/ltsrbt/proc/add_to_queue(datum/blackmarket_purchase/purchase)
	if(!recharge_cooldown && !recieving && !transmitting)
		recieving = purchase
		return
	queue += purchase

/obj/machinery/ltsrbt/process(seconds_per_tick)
	if(machine_stat & NOPOWER)
		return

	if(recharge_cooldown > 0)
		recharge_cooldown -= seconds_per_tick
		return

	var/turf/T = get_turf(src)
	if(recieving)
		var/datum/blackmarket_purchase/P = recieving
		var/atom/movable/M = P.get_item()
		M.forceMove(T)

		use_power(power_usage_per_teleport / power_efficiency)
		var/datum/effect_system/spark_spread/sparks = new
		sparks.set_up(5, 1, get_turf(src))
		sparks.attach(P.item)
		sparks.start()

		recieving = null
		transmitting = P

		recharge_cooldown = recharge_time
		return
	else if(transmitting)
		var/datum/blackmarket_purchase/P = transmitting
		if(!P.item)
			QDEL_NULL(transmitting)
		if(!(P.item in T.contents))
			QDEL_NULL(transmitting)
			return
		do_teleport(P.item, get_turf(P.uplink))
		use_power(power_usage_per_teleport / power_efficiency)
		QDEL_NULL(transmitting)

		recharge_cooldown = recharge_time
		return

	if(queue.len)
		recieving = pick_n_take(queue)

/obj/machinery/ltsrbt/update_overlays()
	. = ..()
	if(!state_open)
		. += "[base_icon_state]_closed"
	else
		var/mutable_appearance/overlay = mutable_appearance(icon, "[base_icon_state]_open")
		overlay.pixel_w -= 2
		overlay.pixel_z -= 1
		. += overlay

/obj/machinery/ltsrbt/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!state_open)
		open_machine(density_to_set = TRUE)
	else
		close_machine()

/obj/machinery/ltsrbt/open_machine(drop = TRUE, density_to_set = FALSE)
	. = ..()
	playsound(src, 'sound/machines/oven/oven_open.ogg', 75, TRUE)

/obj/machinery/ltsrbt/close_machine(atom/movable/target, density_to_set = TRUE)
	. = ..()
	playsound(src, 'sound/machines/oven/oven_close.ogg', 75, TRUE)

/obj/machinery/ltsrbt/can_be_occupant(atom/movable/atom)
	return isitem(atom) && !atom.anchored

/obj/machinery/ltsrbt/Exited(atom/movable/gone)
	if(gone == occupant)
		current_price = initial(current_price)
		current_name = ""
		current_desc = ""
		update_appearance(UPDATE_ICON_STATE)
	return ..()

/obj/machinery/ltsrbt/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "LTSRBT", name)
		ui.open()

/obj/machinery/ltsrbt/ui_state()
	return GLOB.default_state

#define LTSRBT_MIN_PRICE 1
#define LTSRBT_MAX_PRICE 50000

/obj/machinery/ltsrbt/ui_static_data(mob/user)
	var/list/data = list()
	//data["loaded_icon"] = icon2base64(getFlatIcon(occupant, no_anim=TRUE))
	data["min_price"] = LTSRBT_MIN_PRICE
	data["max_price"] = LTSRBT_MAX_PRICE
	return data

/obj/machinery/ltsrbt/ui_data(mob/user)
	var/list/data = list()
	data["name"] = current_name
	data["price"] = current_price
	data["desc"] = current_desc
	data["seller_id"] = seller_id
	data["id_locked"] = id_locked
	return data

/obj/machinery/ltsrbt/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	switch(action)
		if("change_id")
			if(id_locked)
				return
			var/value = params["value"]
			seller_id = trim(value, MAX_NAME_LEN)
			return TRUE
		if("set_id")
			id_locked = TRUE
			return TRUE
		if("change_name")
			var/value = params["value"]
			current_name = trim(value, MAX_NAME_LEN)
			return TRUE
		if("change_desc")
			var/value = params["value"]
			current_desc = trim(value, MAX_MESSAGE_LEN)
			return TRUE
		if("change_price")
			var/new_cost = text2num(params["value"])
			if(!isnull(new_cost))
				current_price = clamp(new_cost, LTSRBT_MIN_PRICE, LTSRBT_MAX_PRICE)
			else
				current_price = LTSRBT_MIN_PRICE
			return TRUE
		if("place_on_market")
			place_on_market(usr)
			return TRUE

#undef LTSRBT_MIN_PRICE
#undef LTSRBT_MAX_PRICE

#define LTSRBT_MAX_MARKET_ITEMS 40
/obj/machinery/ltsrbt/proc/place_on_market(mob/user)
	if(QDELETED(occupant))
		return
	if(!seller_id || !id_locked)
		say("You need a confirmed seller ID first bucko. What kinda rodeo you think we're running here?")
	if(locate(/mob/living) in occupant.get_all_contents())
		say("Living being detected, cannot sell!")
		playsound(src, 'sound/machines/buzz-sigh.ogg', 40, FALSE)
		return
	var/datum/bank_account/account
	var/datum/blackmarket_market/our_market = SSblackmarket.markets[/datum/blackmarket_market/blackmarket]
	if(!isAdminGhostAI(user))
		if(!isliving(user))
			return
		if(length(our_market.available_items[/datum/blackmarket_item/local_good]) >= LTSRBT_MAX_MARKET_ITEMS)
			say("Local market saturated, buy some goods first!")
			playsound(src, 'sound/machines/buzz-sigh.ogg', 40, FALSE)
			return
		var/mob/living/living_user = user
		var/obj/item/card/bank/card = living_user.get_bankcard()
		if(!(card?.registered_account))
			say("No bank account to charge market fees detected!")
			playsound(src, 'sound/machines/buzz-sigh.ogg', 40, FALSE)
			return
		if(!card.registered_account.adjust_money(MARKET_PLACEMENT_FEE, "Market: Placement Fee"))
			say("Insufficient credits!")
			playsound(src, 'sound/machines/buzz-sigh.ogg', 40, FALSE)
			return
		account = card.registered_account

	var/obj/item/item = occupant //occupant, name, price and desc will be null'd once it exits the machine so we need this.
	var/name_to_use = current_name || item.name
	var/desc_to_use = current_desc
	if(account)
		desc_to_use += "[current_desc ? " - " : ""]Seller: [seller_id]"
	var/price_to_use = current_price
	item.moveToNullspace()
	//Something happened and the item was deleted or relocated as soon as it was moved to nullspace.
	if(QDELETED(item) || item.loc != null)
		say("Runtime at market_placement.dm, line 153: item gone!") //metajoke
		return

	var/datum/blackmarket_item/local_good/new_item = new(item, account, our_market.local_good_id ) // move ID to here
	new_item.name = name_to_use
	new_item.desc = desc_to_use
	new_item.cost = price_to_use

	our_market.add_item(new_item)
	our_market.local_good_id++
	say("Item placed on the market!")
	playsound(src, 'sound/effects/cashregister.ogg', 40, FALSE)

#undef LTSRBT_MAX_MARKET_ITEMS

/datum/crafting_recipe/blackmarket_telepad
	name = "Black Market LTRSBT Board"
	result = /obj/item/circuitboard/machine/ltsrbt
	time = 30
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_MULTITOOL)
	reqs = list(
		/obj/item/stack/ore/bluespace_crystal = 2,
		/obj/item/stack/tape/industrial = 5,
		/obj/item/card/bank = 1,
		/obj/item/computer_hardware/network_card = 1,
		/obj/item/circuitboard = 1
	)
	category = CAT_MISC
