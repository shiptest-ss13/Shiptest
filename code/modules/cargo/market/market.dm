GLOBAL_LIST_EMPTY(cargo_landing_zones)

/datum/cargo_market
	var/name = "huh?"

	var/limited_stock = FALSE
	var/stock_refresh = FALSE

	var/cost_varies = FALSE

	var/supply_blocked = FALSE
	/// Order number given to next cargo order
	var/ordernum = 1
	/// List of singleton supply pack instances
	var/list/datum/supply_pack/supply_packs = list()

/datum/cargo_market/New()
	SScargo.markets += src

	ordernum = rand(1, 9000)
	generate_supply_packs()

// Hopefully this can be used for custom markets for events and stuff.
/datum/cargo_market/proc/generate_supply_packs()
	for(var/datum/supply_pack/current_pack as anything in subtypesof(/datum/supply_pack))
		current_pack = new current_pack()
		if(current_pack.faction)
			current_pack.faction = SSfactions.factions[current_pack.faction]
		if(!current_pack.contains)
			continue
		supply_packs += current_pack

/datum/cargo_market/proc/make_order(mob/user, list/unprocessed_packs, atom/landing_zone)
	while(unprocessed_packs.len > 0)
		var/datum/supply_pack/initial_pack = unprocessed_packs[1]
		if(initial_pack.no_bundle)
			send_order(user, list(initial_pack), landing_zone)
			unprocessed_packs -= initial_pack
			continue

		var/list/combo_packs = list()
		var/combo_category = initial_pack.category
		for(var/datum/supply_pack/current_pack in unprocessed_packs)
			if(current_pack.category != combo_category || current_pack.no_bundle)
				continue
			combo_packs += current_pack
			unprocessed_packs -= current_pack

		if(combo_packs.len == 1) // No items could be bundled with the initial pack, make a single order
			send_order(user, list(initial_pack), landing_zone)
			unprocessed_packs -= initial_pack
			continue

		send_order(user, combo_packs, landing_zone)
		unprocessed_packs -= combo_packs

/datum/cargo_market/proc/send_order(mob/user, list/packs, atom/landing_zone)
	var/name = "*None Provided*"
	var/rank = "*None Provided*"
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		name = H.get_authentification_name()
		rank = H.get_assignment(hand_first = TRUE)
	else if(issilicon(user))
		name = user.real_name
		rank = "Silicon"
	//Including the ship bank account means you cant open the crate lol
	//var/datum/supply_order/SO = new(packs, name, rank, user.ckey, charge_account, market = current_market)
	var/datum/supply_order/order = new(packs, name, rank, user.ckey, market = src, landing_zone = landing_zone)
	SScargo.queue_item(order)
	return TRUE

/datum/cargo_market/outpost
	name = "outpost market"

/datum/cargo_market/black
	name = "Black Market"

	/// Available shipping methods and costs, just leave the shipping method out that you don't want to have.
	var/list/shipping = list(
		SHIPPING_METHOD_LTSRBT	= 100,
		SHIPPING_METHOD_LAUNCH	= 10,
		SHIPPING_METHOD_DEAD_DROP = 20
	)

	// Automatic vars, do not touch these.
	/// Items available from this market, populated by SSblackmarket on initialization.
	var/list/available_items = list()
	/// Item categories available from this market, only items which are in these categories can be gotten from this market.
	var/list/categories	= list()

/datum/cargo_market/black/New()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(cycle_stock)), 60 MINUTES, TIMER_STOPPABLE|TIMER_LOOP|TIMER_DELETE_ME)

/datum/cargo_market/black/proc/cycle_stock()
	var/list/pair_items_to_handle = list()

	for(var/category in available_items)
		for(var/item in available_items[category])
			if(istype(item, /datum/supply_pack/blackmarket))
				var/datum/supply_pack/blackmarket/b_item = item
				b_item.cycle()
				if(b_item.available == TRUE)
					for(var/paired_item in b_item.pair_item)
						var/datum/supply_pack/blackmarket/item_to_set = get_item_in_market(paired_item)
						if(!(item_to_set in pair_items_to_handle) && !isnull(item_to_set))
							pair_items_to_handle += item_to_set

	for(var/item in pair_items_to_handle)
		var/datum/supply_pack/blackmarket/b_item = item
		b_item.cycle(TRUE,FALSE,FALSE,TRUE)

// returns the blackmarket_item datum currently in the availible items list. Null if not in the list
/datum/cargo_market/black/proc/get_item_in_market(datum/supply_pack/blackmarket/item)
	for(var/item_to_find in available_items[item.category])
		if(istype(item_to_find,item))
			return item_to_find
	return null

/// Adds item to the available items and add it's category if it is not in categories yet.
/datum/cargo_market/black/proc/add_item(datum/supply_pack/blackmarket/item, paired)
	if(ispath(item))
		item = new item()

	if(!(item.category in categories))
		categories += item.category
		available_items[item.category] = list()

	available_items[item.category] += item

	if(prob(initial(item.availability_prob)) || paired)
		item.available = TRUE
	else
		item.available = FALSE

	return TRUE

/// Handles buying the item, this is mainly for future use and moving the code away from the uplink.
/datum/cargo_market/black/proc/purchase(item, category, method, obj/item/blackmarket_uplink/uplink, user)
	if(!istype(uplink) || !(method in shipping))
		return FALSE

	for(var/datum/supply_pack/blackmarket/I in available_items[category])
		if(I.type != item)
			continue
		var/cost = I.cost + shipping[method]
		// I can't get the cost of the item and shipping in a clean way to the UI, so I have to do this.
		if(uplink.money < cost)
			to_chat(user, span_warning("You don't have enough credits in [uplink] for [I] with [method] shipping."))
			return FALSE

		if(I.buy(uplink, user, method))
			uplink.money -= cost
			return TRUE
		return FALSE

/datum/cargo_market/black/default
