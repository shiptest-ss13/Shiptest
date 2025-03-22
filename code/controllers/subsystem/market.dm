SUBSYSTEM_DEF(cargo)
	name = "Cargo"
	flags = SS_BACKGROUND
	init_order = INIT_ORDER_DEFAULT
	var/list/cargo_landing_zones = list()
	var/list/datum/cargo_market/markets = list()
	var/list/queued_purchases = list()

/datum/controller/subsystem/cargo/fire(resumed)
	while(length(queued_purchases))
		var/datum/supply_order/purchase = queued_purchases[1]
		if(istype(purchase.landing_zone, /obj/hangar_crate_spawner))
			var/obj/hangar_crate_spawner/crate_spawner = purchase.landing_zone
			crate_spawner.handle_order(purchase)
		else
			purchase.generate(get_turf(purchase.landing_zone))
		queued_purchases.Cut(1,2)
	//randomize_cargo()

/*
/datum/controller/subsystem/cargo/proc/randomize_cargo()
	for(var/datum/cargo_market/market in markets)
		var/datum/supply_pack/pack = pick(market.supply_packs)
		pack.cost = round(pack.cost * rand(90, 110) * 0.01)
*/

/datum/controller/subsystem/cargo/proc/queue_item(datum/supply_order/purchase)
	queued_purchases += purchase
	return TRUE
