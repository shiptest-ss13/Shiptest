/datum/blackmarket_item
	/// Name for the item entry used in the uplink.
	var/name
	/// Description for the item entry used in the uplink.
	var/desc
	/// The category this item belongs to, should be already declared in the market that this item is accessible in.
	var/category
	/// "/datum/blackmarket_market"s that this item should be in, used by SSblackmarket on init.
	var/list/markets = list(/datum/blackmarket_market/blackmarket)

	/// Cost for the item, if not set creates a cost according to the *_min and *_max vars.
	var/cost
	/// How many of this type of item is available, if not set creates a cost according to the *_min and *_max vars.
	var/stock

	/// Path to or the item itself what this entry is for, this should be set even if you override spawn_item to spawn your item.
	var/item

	/// Minimum cost for the item if generated randomly.
	var/cost_min	= 0
	/// Maximum cost for the item if generated randomly.
	var/cost_max	= 0
	/// Minimum amount that there should be of this item in the market if generated randomly. This defaults to 1 as most items will have it as 1.
	var/stock_min	= 1
	/// Maximum amount that there should be of this item in the market if generated randomly.
	var/stock_max	= 0
	/// Whether the item is visible and purchasable on the market
	var/available = TRUE
	/// Probability for this item to be available. Used by SSblackmarket on init.
	var/availability_prob = 0
	/// If this item should be more or less likely to spawn than usual. Positive is more likely, negative is less
	var/weight = 0
	/// If this item is affected by avalibility weight. For items that shouldnt appear on their own (paired items), should always appear, or items paticularly rare or powerful that we dont want showing up too often
	var/spawn_weighting
	/// Should another item spawn alongside this one in the catalogue?
	var/list/pair_item = null


/datum/blackmarket_item/New()
	if(isnull(cost))
		randomize_price()
	if(isnull(stock))
		randomize_stock()
	if(isnull(spawn_weighting))
		if(availability_prob == 0 || availability_prob == 100)
			spawn_weighting = FALSE
		else
			spawn_weighting = TRUE

/// Used for spawning the wanted item, override if you need to do something special with the item.
/datum/blackmarket_item/proc/spawn_item(loc)
	return new item(loc)

/datum/blackmarket_item/proc/randomize_price()
	cost = rand(cost_min, cost_max)

/datum/blackmarket_item/proc/randomize_stock()
	stock = rand(stock_min, stock_max)

/datum/blackmarket_item/proc/cycle(cost = TRUE, availibility = TRUE, stock = TRUE, force_appear = FALSE)
	if(cost)
		randomize_price()
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
/datum/blackmarket_item/proc/buy(obj/item/blackmarket_uplink/uplink, mob/buyer, shipping_method)
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
	var/datum/blackmarket_item/entry
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
