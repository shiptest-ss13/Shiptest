SUBSYSTEM_DEF(cargo)
	name = "Cargo"
	flags = SS_BACKGROUND
	init_order = INIT_ORDER_DEFAULT
	var/list/datum/cargo_market/markets = list()
	var/list/queued_purchases = list()

/datum/controller/subsystem/cargo/fire(resumed)
	while(length(queued_purchases))
		var/datum/cargo_order/purchase = queued_purchases[1]
		queued_purchases.Cut(1,2)
	randomize_cargo()

/datum/controller/subsystem/cargo/proc/randomize_cargo()
	for(var/datum/cargo_market/market in markets)
		var/datum/supply_pack/pack = pick(market.supply_packs)
		pack.cost = round(pack.cost * rand(90, 110) * 0.01)

/datum/controller/subsystem/cargo/proc/queue_item(datum/cargo_order/purchase)
	queued_purchases += purchase
	return TRUE
