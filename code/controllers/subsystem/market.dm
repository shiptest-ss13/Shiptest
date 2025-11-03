SUBSYSTEM_DEF(cargo)
	name = "Cargo"
	flags = SS_BACKGROUND
	init_order = INIT_ORDER_DEFAULT

	var/list/datum/cargo_market/markets = list()

	/// List of landmarks for deliveries
	var/list/cargo_landing_zones = list()

	/// Currently queued purchases.
	var/list/queued_purchases = list()

/datum/controller/subsystem/cargo/Initialize(timeofday)
	. = ..()

/datum/controller/subsystem/cargo/fire(resumed)
	while(length(queued_purchases))
		var/datum/supply_order/purchase = queued_purchases[1]
		queued_purchases.Cut(1,2)

		purchase.market.deliver_purchase(purchase)

		if(MC_TICK_CHECK)
			break

/datum/controller/subsystem/cargo/proc/queue_item(datum/supply_order/purchase)
	queued_purchases += purchase
	return TRUE
