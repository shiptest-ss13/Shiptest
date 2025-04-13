/datum/supply_pack/blackmarket
	stock = null
	markets = list(/datum/cargo_market/black/default)

/// Buys the item and makes SSblackmarket handle it.
/datum/supply_pack/blackmarket/proc/buy(obj/item/blackmarket_uplink/uplink, mob/buyer, shipping_method)
	// Sanity
	if(!istype(uplink) || !istype(buyer))
		return FALSE

	// This shouldn't be able to happen unless there was some manipulation or admin fuckery.
	if(!item || stock <= 0)
		return FALSE

	// Alright, the item has been purchased.
	var/datum/supply_order/blackmarket/purchase = new(src, uplink, shipping_method)

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
/datum/supply_order/blackmarket
	/// The entry being purchased.
	var/datum/supply_pack/blackmarket/entry
	/// Instance of the item being sent.
	var/item
	/// The uplink where this purchase was done from.
	var/obj/item/blackmarket_uplink/uplink


/datum/supply_order/blackmarket/New(_entry, _uplink, _method)
	entry = _entry
	if(!ispath(entry.item))
		item = entry.item
	uplink = _uplink
	method = _method
