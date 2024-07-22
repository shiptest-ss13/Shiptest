GLOBAL_LIST_EMPTY(cargo_landing_zones)

/datum/cargo_market
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
	for(var/pack in subtypesof(/datum/supply_pack))
		var/datum/supply_pack/P = new pack()
		if(!P.contains)
			continue
		supply_packs += P
