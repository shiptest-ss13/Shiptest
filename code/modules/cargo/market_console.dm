/obj/machinery/computer/outpost_cargo
	name = "Market Console"
	icon_screen = "supply_express"
	var/atom/cargo_lz
	var/datum/cargo_market/market
	var/list/shopping_cart = list()
	/// The account to charge purchases to, defaults to the cargo budget
	var/datum/bank_account/charge_account

/obj/machinery/computer/outpost_cargo/LateInitialize()
	. = ..()
	find_landing_zone()
	find_market()

/obj/machinery/computer/outpost_cargo/proc/find_landing_zone()
	if(cargo_lz)
		return TRUE
	for(var/atom/landing_zone in GLOB.cargo_landing_zones)
		if(landing_zone.virtual_z() == src.virtual_z())
			cargo_lz = landing_zone
			return TRUE
	return FALSE

/obj/machinery/computer/outpost_cargo/proc/find_outpost()
	for(var/datum/overmap/outpost/target_outpost in SSovermap.outposts)
		var/datum/map_zone/mapzone = target_outpost.mapzone
		for(var/datum/virtual_level/z_level in mapzone.virtual_levels)
			if (src.virtual_z() == z_level.id)
				return target_outpost

/obj/machinery/computer/outpost_cargo/proc/find_market()
	var/datum/overmap/outpost/target_outpost = find_outpost()
	market = target_outpost.market

/obj/machinery/computer/outpost_cargo/proc/get_cargo_packs()
	if(!market)
		return
	return market.supply_packs

/obj/machinery/computer/outpost_cargo/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OutpostCargo", name)
		ui.open()
		if(!charge_account)
			reconnect()

/obj/machinery/computer/outpost_cargo/ui_data(mob/user)
	var/list/data = list()
	data["shopping_cart"] = list()
	if(!length(shopping_cart))
		return
	for(var/item in shopping_cart)
		if(!istype(shopping_cart[item]["pack"], /datum/supply_pack))
			continue
		var/datum/supply_pack/pack = shopping_cart[item]["pack"]
		data["shopping_cart"] += list(list(
			"ref" = REF(pack),
			"name" = pack.name,
			"count" = shopping_cart[item]["count"],
			"cost" = pack.cost,
			"base_cost" = pack.base_cost
		))
	return data

/obj/machinery/computer/outpost_cargo/ui_static_data(mob/user)
	var/list/data = list()
	data["max_order"] = CARGO_MAX_ORDER
	data["supply_packs"] = list()
	for(var/datum/supply_pack/cargo_pack in get_cargo_packs())
		if(!data["supply_packs"][cargo_pack.group])
			data["supply_packs"][cargo_pack.group] = list(
				"name" = cargo_pack.group,
				"packs" = list()
			)
		data["supply_packs"][cargo_pack.group]["packs"] += list(list(
			"ref" = REF(cargo_pack),
			"name" = cargo_pack.name,
			"group" = cargo_pack.group,
			"cost" = cargo_pack.cost,
			"base_cost" = cargo_pack.base_cost,
			"desc" = cargo_pack.desc || cargo_pack.name, // If there is a description, use it. Otherwise use the pack's name.
		))
	return data

/obj/machinery/computer/outpost_cargo/ui_act(action, params, datum/tgui/ui)
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


/obj/machinery/computer/outpost_cargo/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	reconnect(port)

/obj/machinery/computer/outpost_cargo/proc/reconnect(obj/docking_port/mobile/port)
	if(!port)
		var/area/ship/current_area = get_area(src)
		if(!istype(current_area))
			return
		port = current_area.mobile_port
	if(!port)
		return
	charge_account = port.current_ship.ship_account

/obj/machinery/computer/outpost_cargo/attackby(obj/item/the_cash, mob/living/user, params)
	var/value = the_cash.get_item_credit_value()
	if(value && charge_account)
		charge_account.adjust_money(value)
		to_chat(user, span_notice("You deposit [the_cash]. The Vessel Budget is now [charge_account.account_balance] cr."))
		qdel(the_cash)
		return TRUE
	..()

/obj/machinery/computer/outpost_cargo/proc/add_item(mob/user, ref, amount = 1)
	for(var/datum/supply_pack/pack in get_cargo_packs())
		if(REF(pack) == ref)
			if(shopping_cart[ref])
				amount += shopping_cart[ref]["count"]
			shopping_cart[ref] = list(
				"pack" = pack,
				"count" = amount,
			)
			return

/obj/machinery/computer/outpost_cargo/proc/remove_item(mob/user, ref)
	if(shopping_cart[ref])
		shopping_cart.Remove(ref)

/obj/machinery/computer/outpost_cargo/proc/modify_item(mob/user, ref, amount = 1)
	for(var/datum/supply_pack/pack in get_cargo_packs())
		if(REF(pack) == ref)
			shopping_cart[ref] = list(
				"pack" = pack,
				"count" = amount,
			)
			if(shopping_cart[ref]["count"] <= 0)
				shopping_cart.Remove(ref)
			return

/obj/machinery/computer/outpost_cargo/proc/buy_items(mob/user)
	if(!cargo_lz)
		say("No landing zone idiot!")
		return
	if(!length(shopping_cart))
		say("No items idiot!")
		return
	var/total_cost = 0
	for(var/order in shopping_cart)
		if(!istype(shopping_cart[order]["pack"], /datum/supply_pack))
			continue
		var/datum/supply_pack/pack = shopping_cart[order]["pack"]
		total_cost += pack.cost * shopping_cart[order]["count"]
	if(!charge_account?.has_money(total_cost))
		say("broke! idiot!")
		return
	say("purchase good!")
	return

/obj/machinery/computer/outpost_cargo/quick_testing/find_landing_zone()
	if(cargo_lz)
		return TRUE
	cargo_lz = src
	return TRUE

/obj/effect/landmark/cargo
	name = "cargo_lz"
	icon_state = "cargo_landmark"
	invisibility = INVISIBILITY_OBSERVER

/obj/effect/landmark/cargo/Initialize()
	. = ..()
	GLOB.cargo_landing_zones += src
