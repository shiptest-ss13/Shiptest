SUBSYSTEM_DEF(cargo)
	name = "Cargo"
	flags = SS_BACKGROUND
	init_order = INIT_ORDER_DEFAULT

	/// Descriptions for each shipping methods.
	var/shipping_method_descriptions = list(
		SHIPPING_METHOD_LAUNCH="Launches the item at your coordinates from across deep space. Cheap, but you might not recieve your item at all. We recommend being stationary in space, away from any large structures, for best results.",
		SHIPPING_METHOD_DEAD_DROP="Our couriers will fire your item via orbital drop pod at the nearest safe abandoned structure for discreet pick up. Reliable, but you'll have to find your package yourself. We accept no responsibility for lost packages if you try to do this in empty space or the outpost.",
		SHIPPING_METHOD_LTSRBT="Long-To-Short-Range-Bluespace-Transceiver, a machine that prepares items at a remote storage location and then teleports them to the location of the LTRSBT. Secure, quick and reliable, though it ain't cheap to do."
	)

	var/list/datum/cargo_market/markets = list()

	/// List of landmarks for deliveries
	var/list/cargo_landing_zones = list()
	/// List of existing ltsrbts.
	var/list/obj/machinery/ltsrbt/telepads = list()

	/// Currently queued purchases.
	var/list/queued_purchases = list()

/datum/controller/subsystem/cargo/Initialize(timeofday)
	for(var/market in subtypesof(/datum/blackmarket_market))
		markets += new market

	for(var/datum/cargo_market/market in markets)
		market.cycle_stock()
	. = ..()

/datum/controller/subsystem/cargo/fire(resumed)
	while(length(queued_purchases))
		var/datum/supply_order/purchase = queued_purchases[1]
		queued_purchases.Cut(1,2)

		purchase.market.deliver_purchase(purchase)

		if(MC_TICK_CHECK)
			break

/*
/datum/controller/subsystem/cargo/proc/randomize_cargo()
	for(var/datum/cargo_market/market in markets)
		var/datum/supply_pack/pack = pick(market.supply_packs)
		pack.cost = round(pack.cost * rand(90, 110) * 0.01)
*/

/datum/controller/subsystem/cargo/proc/queue_item(datum/supply_order/purchase)
	queued_purchases += purchase
	return TRUE
