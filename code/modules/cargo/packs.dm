/datum/supply_pack
	var/name = "Crate"
	var/category = "Unsorted"
	var/desc = ""

	var/crate_name = "crate"
	var/crate_type = /obj/structure/closet/crate
	var/no_bundle = FALSE
	/// "/datum/blackmarket_market"s that this item should be in, used by SSblackmarket on init.
	var/list/markets = list(/datum/cargo_market/outpost)

	/// cost for the item, if not set creates a cost according to the *_min and *_max vars.
	var/cost = 700
	/// How many of this type of item is available, if not set creates a cost according to the *_min and *_max vars.
	var/stock = INFINITY

	//TODO: Deprecate contains in favor of item
	var/list/contains = null

	/*
	/// Path to or the item itself what this entry is for, this should be set even if you override spawn_item to spawn your item.
	var/item
	/// Should another item spawn alongside this one in the catalogue?
	var/list/pair_item = null
	*/

	/// The inital cost or the cost it will trend towards.
	var/base_cost
	/// Minimum cost for the item if generated randomly.
	var/cost_min	= 0
	/// Maximum cost for the item if generated randomly.
	var/cost_max	= 0

	/// If the pack is allowed to restock when requested
	var/restocks
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
	var/spawn_weighting = TRUE

	//FACTION
	var/datum/faction/faction
	//what's the discount for buyers in our faction.
	var/faction_discount = 15
	//are we locked to one faction and its subgroups
	var/faction_locked = FALSE

	var/admin_spawned = FALSE


/datum/supply_pack/New()
	. = ..()
	if(isnull(cost))
		randomize_cost()
	if(isnull(stock))
		randomize_stock()
	if(isnull(spawn_weighting))
		if(availability_prob == 0 || availability_prob == 100)
			spawn_weighting = FALSE
		else
			spawn_weighting = TRUE
	base_cost = cost

/datum/supply_pack/proc/randomize_cost()
	cost = rand(cost_min, cost_max)

/datum/supply_pack/proc/randomize_stock()
	stock = rand(stock_min, stock_max)

/datum/supply_pack/proc/cycle(cost = TRUE, availibility = TRUE, stock = FALSE, force_appear = FALSE)
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

/datum/supply_pack/proc/generate(atom/A, datum/bank_account/paying_account)
	var/obj/structure/closet/crate/C
	if(paying_account)
		C = new /obj/structure/closet/crate/secure/owned(A, paying_account)
		C.name = "[crate_name] - Purchased by [paying_account.account_holder]"
	else
		C = new crate_type(A)
		C.name = crate_name

	fill(C)
	return C

/datum/supply_pack/proc/fill(obj/structure/closet/crate/C)
	if (admin_spawned)
		for(var/item in contains)
			var/atom/A = new item(C)
			A.flags_1 |= ADMIN_SPAWNED_1
	else
		for(var/item in contains)
			new item(C)
