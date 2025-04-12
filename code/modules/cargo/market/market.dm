GLOBAL_LIST_EMPTY(cargo_landing_zones)

/datum/cargo_market
	var/name = "huh?"

	var/limited_stock = FALSE
	var/stock_refresh = FALSE

	var/price_varies = FALSE

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
		var/combo_group = initial_pack.group
		for(var/datum/supply_pack/current_pack in unprocessed_packs)
			if(current_pack.group != combo_group || current_pack.no_bundle)
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
	name = "blackmarket"
