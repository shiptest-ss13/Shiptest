/datum/supply_pack/blackmarket
	markets = list(/datum/cargo_market/black)

/datum/supply_pack/blackmarket/New()
	if(isnull(cost))
		randomize_cost()
	if(isnull(stock))
		randomize_stock()
	if(isnull(spawn_weighting))
		if(availability_prob == 0 || availability_prob == 100)
			spawn_weighting = FALSE
		else
			spawn_weighting = TRUE

/// Used for spawning the wanted item, override if you need to do something special with the item.
/datum/supply_pack/blackmarket/proc/spawn_item(loc)
	return new item(loc)

/datum/supply_pack/blackmarket/proc/randomize_cost()
	cost = rand(cost_min, cost_max)

/datum/supply_pack/blackmarket/proc/randomize_stock()
	stock = rand(stock_min, stock_max)

/datum/supply_pack/blackmarket/proc/cycle(cost = TRUE, availibility = TRUE, stock = FALSE, force_appear = FALSE)
	if(cost)
		randomize_cost()
	if(stock)
		randomize_stock()
	if(availibility)
		if(spawn_weighting ? prob(max(0, (availability_prob + (weight * 10)))) : prob(availability_prob))
			available = TRUE
			weight--
		else
			available = FALSE
			weight++
	if(force_appear)
		available = TRUE

/// Buys the item and makes SSblackmarket handle it.
/datum/supply_pack/blackmarket/proc/buy(obj/item/blackmarket_uplink/uplink, mob/buyer, shipping_method)
	// Sanity
	if(!istype(uplink) || !istype(buyer))
		return FALSE

	// This shouldn't be able to happen unless there was some manipulation or admin fuckery.
	if(!item || stock <= 0)
		return FALSE

	// Alright, the item has been purchased.
	var/datum/blackmarket_purchase/purchase = new(src, uplink, shipping_method)

	// SSblackmarket takes care of the shipping.
	if(SSblackmarket.queue_item(purchase))
		if(stock != INFINITY)
			stock--
		log_game("[key_name(buyer)] has succesfully purchased [name] using [shipping_method] for shipping.")
		SSblackbox.record_feedback("nested tally", "blackmarket_ordered", 1, list(name, "amount"))
		SSblackbox.record_feedback("nested tally", "blackmarket_ordered", cost, list(name, "cost"))
		return TRUE
	return FALSE

// This exists because it is easier to keep track of all the vars this way.
/datum/blackmarket_purchase
	/// The entry being purchased.
	var/datum/supply_pack/blackmarket/entry
	/// Instance of the item being sent.
	var/item
	/// The uplink where this purchase was done from.
	var/obj/item/blackmarket_uplink/uplink
	/// Shipping method used to buy this item.
	var/method

/datum/blackmarket_purchase/New(_entry, _uplink, _method)
	entry = _entry
	if(!ispath(entry.item))
		item = entry.item
	uplink = _uplink
	method = _method
