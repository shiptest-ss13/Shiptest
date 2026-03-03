/obj/item/paper/manifest
	var/order_cost = 0
	var/order_id = 0

/obj/item/paper/manifest/New(atom/A, id, cost)
	..()
	order_id = id
	order_cost = cost

/datum/supply_order
	var/id
	var/orderer
	var/orderer_rank
	var/orderer_ckey
	var/list/datum/supply_pack/supply_packs

	var/datum/bank_account/paying_account
	var/datum/cargo_market/market

	/// Shipping method used to buy this item.
	var/method = SHIPPING_METHOD_HANGER
	var/atom/landing_zone

/datum/supply_order/New(list/supply_packs = list(), orderer, orderer_rank, orderer_ckey, paying_account, datum/cargo_market/market, atom/landing_zone)
	src.supply_packs = supply_packs
	src.orderer = orderer
	src.orderer_rank = orderer_rank
	src.orderer_ckey = orderer_ckey
	src.paying_account = paying_account
	src.market = market
	src.landing_zone = landing_zone
	if(src.market)
		id = src.market.ordernum++
	for(var/datum/supply_pack/pack in src.supply_packs)
		SSblackbox.record_feedback("nested tally", "crate_ordered", 1, list(pack.name, "amount"))
		SSblackbox.record_feedback("nested tally", "crate_ordered", pack.cost, list(pack.name, "cost"))

/datum/supply_order/proc/generateRequisition(turf/T)
	var/obj/item/paper/requisition_paper = new(T)

	requisition_paper.name = "requisition form - #[id]"
	var/requisition_text = "<h2>[station_name()] Supply Requisition</h2>"
	requisition_text += "<hr/>"
	requisition_text += "Order #[id]<br/>"
	requisition_text += "Time of Order: [station_time_timestamp()]<br/>"
	requisition_text += "Items:<br/>"
	for(var/datum/supply_pack/pack in supply_packs)
		requisition_text += "<li>[pack.name]</li>"
	requisition_text += "Requested by: [orderer]<br/>"
	if(paying_account)
		requisition_text += "Paid by: [paying_account.account_holder]<br/>"
	requisition_text += "Rank: [orderer_rank]<br/>"

	requisition_paper.add_raw_text(requisition_text)
	requisition_paper.update_appearance()
	return requisition_paper

/datum/supply_order/proc/generateManifest(obj/structure/closet/crate/container, owner) //generates-the-manifests.
	var/manifest_text = "<h2>[market.name] Shipping Manifest</h2>"
	manifest_text += "<hr/>"
	if(owner && !(owner == "Unknown"))
		manifest_text += "Direct purchase from [owner]<br/>"
	manifest_text += "Destination: [market.name]<br/>"
	manifest_text += "Contents: <br/>"
	manifest_text += "<ul>"
	var/container_contents = list() // Associative list with the format (item_name = nº of occurrences, ...)
	for(var/atom/movable/AM in container.contents)
		container_contents[AM.name]++
	for(var/item in container_contents)
		manifest_text += "<li> [container_contents[item]] [item][container_contents[item] == 1 ? "" : "s"]</li>"
	manifest_text += "</ul>"
	manifest_text += "<h4>Stamp below to confirm receipt of goods:</h4>"

	container.manifest_id = id
	container.AddComponent(/datum/component/writing, raw_text = manifest_text)
	container.update_appearance()

/datum/supply_order/proc/generate(atom/location)
	var/account_holder
	var/datum/supply_pack/initial_pack = supply_packs[1]

	var/obj/structure/closet/crate/order_crate
	if(paying_account)
		account_holder = paying_account.account_holder
		order_crate = new /obj/structure/closet/crate/secure/owned(location, paying_account)
		order_crate.name = "crate - Purchased by [account_holder]"
	else
		account_holder = "Unknown"
		order_crate = new initial_pack.crate_type(location)

	for(var/datum/supply_pack/filling_pack in supply_packs)
		filling_pack.fill(order_crate)
	generateManifest(order_crate, account_holder)
	return order_crate
