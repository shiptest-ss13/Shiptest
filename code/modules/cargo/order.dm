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
	var/reason
	var/datum/supply_pack/pack
	var/datum/bank_account/paying_account
	var/datum/overmap/outpost/ordering_outpost

	var/atom/landing_zone
	var/list/datum/supply_pack/pack/supply_packs

/datum/supply_order/New(datum/supply_pack/pack, orderer, orderer_rank, orderer_ckey, reason, paying_account, ordering_outpost)
	src.pack = pack
	src.orderer = orderer
	src.orderer_rank = orderer_rank
	src.orderer_ckey = orderer_ckey
	src.reason = reason
	src.paying_account = paying_account
	src.ordering_outpost = ordering_outpost
	if(src.ordering_outpost)
		id = src.ordering_outpost.market.ordernum++
	if(pack)
		SSblackbox.record_feedback("nested tally", "crate_ordered", 1, list(pack.name, "amount"))
		SSblackbox.record_feedback("nested tally", "crate_ordered", pack.cost, list(pack.name, "cost"))

/datum/supply_order/proc/generateRequisition(turf/T)
	var/obj/item/paper/requisition_paper = new(T)

	requisition_paper.name = "requisition form - #[id] ([pack.name])"
	var/requisition_text = "<h2>[station_name()] Supply Requisition</h2>"
	requisition_text += "<hr/>"
	requisition_text += "Order #[id]<br/>"
	requisition_text += "Time of Order: [station_time_timestamp()]<br/>"
	requisition_text += "Item: [pack.name]<br/>"
	requisition_text += "Requested by: [orderer]<br/>"
	if(paying_account)
		requisition_text += "Paid by: [paying_account.account_holder]<br/>"
	requisition_text += "Rank: [orderer_rank]<br/>"
	requisition_text += "Comment: [reason]<br/>"

	requisition_paper.add_raw_text(requisition_text)
	requisition_paper.update_appearance()
	return requisition_paper

/datum/supply_order/proc/generateManifest(obj/structure/closet/crate/container, owner, packname) //generates-the-manifests.
	var/obj/item/paper/manifest/manifest_paper = new(container, id, 0)

	manifest_paper.name = "shipping manifest - [packname?"#[id] ([pack.name])":"(Grouped Item Crate)"]"

	var/manifest_text = "<h2>[ordering_outpost.name] Shipping Manifest</h2>"
	manifest_text += "<hr/>"
	if(owner && !(owner == "Unknown"))
		manifest_text += "Direct purchase from [owner]<br/>"
		manifest_paper.name += " - Purchased by [owner]"
	manifest_text += "Order[packname?"":"s"]: [id]<br/>"
	manifest_text += "Destination: [ordering_outpost.name]<br/>"
	if(packname)
		manifest_text += "Item: [packname]<br/>"
	manifest_text += "Contents: <br/>"
	manifest_text += "<ul>"
	var/container_contents = list() // Associative list with the format (item_name = nº of occurrences, ...)
	for(var/atom/movable/AM in container.contents - manifest_paper)
		container_contents[AM.name]++
	for(var/item in container_contents)
		manifest_text += "<li> [container_contents[item]] [item][container_contents[item] == 1 ? "" : "s"]</li>"
	manifest_text += "</ul>"
	manifest_text += "<h4>Stamp below to confirm receipt of goods:</h4>"

	manifest_paper.add_raw_text(manifest_text)
	manifest_paper.update_appearance()
	manifest_paper.forceMove(container)
	container.manifest = manifest_paper
	container.update_appearance()

	return manifest_paper

/datum/supply_order/proc/generate(atom/location)
	var/account_holder
	if(paying_account)
		account_holder = paying_account.account_holder
	else
		account_holder = "Unknown"
	var/obj/structure/closet/crate/order_crate = pack.generate(location, paying_account)
	generateManifest(order_crate, account_holder, pack)
	return order_crate

/datum/supply_order/proc/generate_combo(miscbox, misc_own, misc_contents)
	for (var/I in misc_contents)
		new I(miscbox)
	generateManifest(miscbox, misc_own, "")
	return
