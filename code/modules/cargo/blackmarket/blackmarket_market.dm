/datum/blackmarket_market
	/// Name for the market.
	var/name = "huh?"

	/// Available shipping methods and prices, just leave the shipping method out that you don't want to have.
	var/list/shipping



	// Automatic vars, do not touch these.
	/// Items available from this market, populated by SSblackmarket on initialization.
	var/list/available_items = list()
	/// Item categories available from this market, only items which are in these categories can be gotten from this market.
	var/list/categories	= list()

/datum/blackmarket_market/New()
	. = ..()

// sort of works - todo: have it collect all the paired items that need to be cycled in a list to be done at the end to avoid unninteded behavior
/datum/blackmarket_market/proc/cycle_stock()
	for(var/category in available_items)
		for(var/item in available_items[category])
			if(istype(item, /datum/blackmarket_item))
				var/datum/blackmarket_item/b_item = item
				b_item.cycle()
				for(var/paired_item in b_item.pair_item)
					var/datum/blackmarket_item/item_to_set = get_item_in_market(paired_item)
					item_to_set.available = TRUE


// *** this is returning Null for some reason
// returns the blackmarket_item datum currently in the availible items list. Null if not in the list
/datum/blackmarket_market/proc/get_item_in_market(datum/blackmarket_item/item)
	var/search_item = _list_find(available_items[item.category],item)
	return search_item

/// Adds item to the available items and add it's category if it is not in categories yet.
/datum/blackmarket_market/proc/add_item(datum/blackmarket_item/item, paired)
	if(ispath(item))
		item = new item()

	if(!(item.category in categories))
		categories += item.category
		available_items[item.category] = list()

	available_items[item.category] += item

	for(var/paired_item in item.pair_item)
		add_item(paired_item, TRUE)

	if(!prob(initial(item.availability_prob)) && !paired)
		item.available = FALSE
		item.weight--
	else
		item.available = TRUE
		item.weight++

	return TRUE

/// Handles buying the item, this is mainly for future use and moving the code away from the uplink.
/datum/blackmarket_market/proc/purchase(item, category, method, obj/item/blackmarket_uplink/uplink, user)
	if(!istype(uplink) || !(method in shipping))
		return FALSE

	for(var/datum/blackmarket_item/I in available_items[category])
		if(I.type != item)
			continue
		var/price = I.price + shipping[method]
		// I can't get the price of the item and shipping in a clean way to the UI, so I have to do this.
		if(uplink.money < price)
			to_chat(user, "<span class='warning'>You don't have enough credits in [uplink] for [I] with [method] shipping.</span>")
			return FALSE

		if(I.buy(uplink, user, method))
			uplink.money -= price
			return TRUE
		return FALSE

/datum/blackmarket_market/blackmarket
	name = "Black Market"
	shipping = list(SHIPPING_METHOD_LTSRBT	=50,
					SHIPPING_METHOD_LAUNCH	=10,
					SHIPPING_METHOD_DEAD_DROP = 10)
