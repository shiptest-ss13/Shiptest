/datum/blackmarket_item
	/// Name for the item entry used in the uplink.
	var/name
	/// Description for the item entry used in the uplink.
	var/desc
	/// The category this item belongs to, should be already declared in the market that this item is accessible in.
	var/category
	/// "/datum/blackmarket_market"s that this item should be in, used by SSblackmarket on init.
	var/list/markets = list(/datum/blackmarket_market/blackmarket)

	/// Price for the item, if not set creates a price according to the *_min and *_max vars.
	var/price
	/// How many of this type of item is available, if not set creates a price according to the *_min and *_max vars.
	var/stock

	/// Path to or the item itself what this entry is for, this should be set even if you override spawn_item to spawn your item.
	var/item

	/// Minimum price for the item if generated randomly.
	var/price_min	= 0
	/// Maximum price for the item if generated randomly.
	var/price_max	= 0
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
	/// If this item is affected by avalibility weight. Mainly for items that shouldnt be able to spawn on their own normally (Eg. Certain ammo)
	var/consider_weight = FALSE
	/// if this item has already been cycled. Mainly for paired items so they dont get cycled twice.
	var/set = FALSE
	// Should there be an unlimited stock of an item
	var/unlimited = FALSE
	/// Should another item spawn alongside this one in the catalogue?
	var/list/pair_item = null


/datum/blackmarket_item/New()
	if(isnull(price))
		randomize_price()
	if(isnull(stock))
		randomize_stock()

/// Used for spawning the wanted item, override if you need to do something special with the item.
/datum/blackmarket_item/proc/spawn_item(loc)
	return new item(loc)

/datum/blackmarket_item/proc/randomize_price()
	price = rand(price_min, price_max)

/datum/blackmarket_item/proc/randomize_stock()
	stock = rand(stock_min, stock_max)

/datum/blackmarket_item/proc/cycle(price = TRUE, availibility = TRUE, force_appear = FALSE, stock = TRUE)
	if(price)
		randomize_price()
	if(stock)
		randomize_stock()
	if(availibility)
		if(prob(max(availability_prob + (weight * 10))))
			available = TRUE
		else
			available = FALSE
	if(force_appear)
		available = TRUE



/// Buys the item and makes SSblackmarket handle it.
/datum/blackmarket_item/proc/buy(obj/item/blackmarket_uplink/uplink, mob/buyer, shipping_method)
	// Sanity
	if(!istype(uplink) || !istype(buyer))
		return FALSE

	// This shouldn't be able to happen unless there was some manipulation or admin fuckery.
	if(!item || stock <= 0 && !unlimited)
		return FALSE

	// Alright, the item has been purchased.
	var/datum/blackmarket_purchase/purchase = new(src, uplink, shipping_method)

	// SSblackmarket takes care of the shipping.
	if(SSblackmarket.queue_item(purchase))
		stock--
		log_game("[key_name(buyer)] has succesfully purchased [name] using [shipping_method] for shipping.")
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
