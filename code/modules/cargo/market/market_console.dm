/obj/machinery/computer/market
	name = "market console"
	icon_screen = "request"
	var/atom/cargo_lz
	var/datum/cargo_market/market
	var/list/shopping_cart = list()
	/// The account to charge purchases to.
	var/datum/bank_account/charge_account
	var/datum/faction/current_faction

/obj/machinery/computer/market/LateInitialize()
	. = ..()
	find_landing_zone()
	find_market()

/obj/machinery/computer/market/proc/find_landing_zone()
	if(cargo_lz)
		return TRUE
	for(var/atom/landing_zone in SScargo.cargo_landing_zones)
		if(landing_zone.virtual_z() == src.virtual_z())
			cargo_lz = landing_zone
			return TRUE
	return FALSE

/obj/machinery/computer/market/proc/find_outpost()
	for(var/datum/overmap/outpost/target_outpost in SSovermap.outposts)
		var/datum/map_zone/mapzone = target_outpost.mapzone
		for(var/datum/virtual_level/z_level in mapzone.virtual_levels)
			if (src.virtual_z() == z_level.id)
				return target_outpost

/obj/machinery/computer/market/proc/find_market()
	var/datum/overmap/outpost/target_outpost = find_outpost()
	if(target_outpost)
		market = target_outpost.market

/obj/machinery/computer/market/proc/get_cargo_packs()
	if(!market)
		return
	return market.supply_packs

/obj/machinery/computer/market/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MarketConsole", name)
		ui.open()
		if(!charge_account)
			reconnect()

/obj/machinery/computer/market/ui_data(mob/user)
	var/list/data = list()

	data["shopping_cart"] = list()
	for(var/item in shopping_cart)
		if(!istype(shopping_cart[item]["pack"], /datum/supply_pack))
			continue
		var/datum/supply_pack/current_pack = shopping_cart[item]["pack"]
		var/same_faction = current_pack.faction ? current_pack.faction.allowed_faction(current_faction) : FALSE
		var/discountedcost = (same_faction && current_pack.faction_discount) ? current_pack.cost - (current_pack.cost * (current_pack.faction_discount * 0.01)) : null
		data["shopping_cart"] += list(list(
			"ref" = REF(current_pack),
			"name" = current_pack.name,
			"count" = shopping_cart[item]["count"],
			"cost" = discountedcost ? discountedcost : current_pack.cost,
		))

	if(charge_account)
		data["account_holder"] = charge_account.account_holder
		data["account_balance"] = charge_account.account_balance
	else
		data["account_holder"] = "Unknown User"
		data["account_balance"] = 0

	return data

/obj/machinery/computer/market/ui_static_data(mob/user)
	var/list/data = list()
	data["max_order"] = CARGO_MAX_ORDER
	data["supply_packs"] = list()
	for(var/datum/supply_pack/current_pack in get_cargo_packs())
		if(!data["supply_packs"][current_pack.category])
			data["supply_packs"][current_pack.category] = list(
				"name" = current_pack.category,
				"packs" = list()
			)
		if((!current_pack.available))
			continue
		var/same_faction = current_pack.faction ? current_pack.faction.allowed_faction(current_faction) : FALSE
		var/discountedcost = (same_faction && current_pack.faction_discount) ? current_pack.cost - (current_pack.cost * (current_pack.faction_discount * 0.01)) : null
		if(current_pack.faction_locked && !same_faction)
			continue
		// If there is a description, use it. Otherwise use the pack's name.
		var/desc = (current_pack.desc || current_pack.name) + (discountedcost ? "\n-[current_pack.faction_discount]% off due to your faction affiliation.\nWas [current_pack.cost]" : "") + (current_pack.faction_locked ? "\nYou are able to purchase this item due to your faction affiliation." : "")
		data["supply_packs"][current_pack.category]["packs"] += list(list(
			"ref" = REF(current_pack),
			"name" = current_pack.name,
			"category" = current_pack.category,
			"cost" = current_pack.cost,
			"discountedcost" = discountedcost ? discountedcost : null,
			"discountpercent" = current_pack.faction_discount,
			"stock" = current_pack.stock == INFINITY ? "INF" : current_pack.stock,
			"faction_locked" = current_pack.faction_locked, //this will only show if you are same faction, so no issue
			"desc" = desc,
			"no_bundle" = current_pack.no_bundle
		))
	return data

/obj/machinery/computer/market/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	switch(action)
		if("add")
			return add_item(ui.user, params["ref"])
		if("remove")
			return remove_item(ui.user, params["ref"])
		if("modify")
			return modify_item(ui.user, params["ref"], params["amount"])
		if("buy")
			return buy_items(ui.user)
		if("clear")
			shopping_cart = list()

/obj/machinery/computer/market/proc/reconnect(obj/docking_port/mobile/port)
	return

/obj/machinery/computer/market/proc/add_item(mob/user, ref, amount = 1)
	for(var/datum/supply_pack/pack in get_cargo_packs())
		if(REF(pack) == ref)
			if(shopping_cart[ref])
				amount += shopping_cart[ref]["count"]
			shopping_cart[ref] = list(
				"pack" = pack,
				"count" = amount,
			)
			return

/obj/machinery/computer/market/proc/remove_item(mob/user, ref)
	if(shopping_cart[ref])
		shopping_cart.Remove(ref)

/obj/machinery/computer/market/proc/modify_item(mob/user, ref, amount = 1)
	for(var/datum/supply_pack/pack in get_cargo_packs())
		if(REF(pack) == ref)
			shopping_cart[ref] = list(
				"pack" = pack,
				"count" = amount,
			)
			if(shopping_cart[ref]["count"] <= 0)
				shopping_cart.Remove(ref)
			return

/obj/machinery/computer/market/proc/buy_items(mob/user)
	if(!cargo_lz)
		say("No landing zone detected!")
		return
	if(!length(shopping_cart))
		say("Shopping cart is empty!")
		return

	var/total_cost = 0
	var/unprocessed_packs = list()
	for(var/order in shopping_cart)
		if(!istype(shopping_cart[order]["pack"], /datum/supply_pack))
			continue
		var/datum/supply_pack/pack = shopping_cart[order]["pack"]
		total_cost += pack.cost * shopping_cart[order]["count"]
		for(var/i in 1 to shopping_cart[order]["count"])
			unprocessed_packs += list(pack)

	if(!charge_account.adjust_money(-total_cost, CREDIT_LOG_CARGO))
		say("Insufficent funds!")
		return

	playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)
	say("Order incoming!")

	market.make_order(usr, unprocessed_packs, cargo_lz)
	shopping_cart = list()

	return

/*
/obj/machinery/computer/market/quick_testing/find_landing_zone()
	if(cargo_lz)
		return TRUE
	cargo_lz = src
	return TRUE
*/

/obj/machinery/computer/market/ship
	name = "ship market console"
	/// The ship we reside on for ease of access
	var/datum/overmap/ship/controlled/current_ship

/obj/machinery/computer/market/ship/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	current_ship = port.current_ship
	reconnect(port)

/obj/machinery/computer/market/ship/reconnect(obj/docking_port/mobile/port)
	if(current_ship)
		current_faction = current_ship.source_template.faction
		charge_account = current_ship.ship_account

/obj/machinery/computer/market/ship/attackby(obj/item/the_cash, mob/living/user, params)
	var/value = the_cash.get_item_credit_value()
	if(value && charge_account)
		charge_account.adjust_money(value)
		to_chat(user, span_notice("You deposit [the_cash]. The Vessel Budget is now [charge_account.account_balance] cr."))
		qdel(the_cash)
		return TRUE
	..()

/obj/machinery/computer/market/ship/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	switch(action)
		if("withdraw")
			var/val = text2num(params["value"])
			// no giving yourself money
			if(!charge_account || !val || val <= 0)
				return
			if(charge_account.adjust_money(-val))
				var/obj/item/holochip/cash_chip = new /obj/item/holochip(drop_location(), val)
				if(ishuman(usr))
					var/mob/living/carbon/human/user = usr
					user.put_in_hands(cash_chip)
				playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)
				src.visible_message(span_notice("[src] dispenses a holochip."))
			return TRUE
