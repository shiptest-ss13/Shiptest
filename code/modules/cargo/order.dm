/obj/item/paper/fluff/jobs/cargo/manifest
	var/order_cost = 0
	var/order_id = 0

/obj/item/paper/fluff/jobs/cargo/manifest/New(atom/A, id, cost)
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

/datum/supply_order/New(datum/supply_pack/pack, orderer, orderer_rank, orderer_ckey, reason, paying_account)
	id = SSshuttle.ordernum++
	src.pack = pack
	src.orderer = orderer
	src.orderer_rank = orderer_rank
	src.orderer_ckey = orderer_ckey
	src.reason = reason
	src.paying_account = paying_account
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

/datum/supply_order/proc/generateManifest(obj/structure/closet/crate/C, owner, packname) //generates-the-manifests.
	var/obj/item/paper/fluff/jobs/cargo/manifest/manifest_paper = new(C, id, 0)

	manifest_paper.name = "shipping manifest - [packname?"#[id] ([pack.name])":"(Grouped Item Crate)"]"
	var/manifest_text = "<h2>[command_name()] Shipping Manifest</h2>"
	manifest_text += "<hr/>"
	if(owner && !(owner == "Cargo"))
		manifest_text += "Direct purchase from [owner]<br/>"
		manifest_paper.name += " - Purchased by [owner]"
	manifest_text += "Order[packname?"":"s"]: [id]<br/>"
	manifest_text += "Destination: [station_name()]<br/>"
	if(packname)
		manifest_text += "Item: [packname]<br/>"
	manifest_text += "Contents: <br/>"
	manifest_text += "<ul>"
	for(var/atom/movable/AM in C.contents - manifest_paper)
		manifest_text += "<li>[AM.name]</li>"
	manifest_text += "</ul>"
	manifest_text += "<h4>Stamp below to confirm receipt of goods:</h4>"

	manifest_paper.add_raw_text(manifest_text)
	manifest_paper.update_appearance()
	manifest_paper.forceMove(C)
	C.manifest = manifest_paper
	C.update_appearance()

	return manifest_paper

/datum/supply_order/proc/generate(atom/A)
	var/account_holder
	if(paying_account)
		account_holder = paying_account.account_holder
	else
		account_holder = "Cargo"
	var/obj/structure/closet/crate/C = pack.generate(A, paying_account)
	generateManifest(C, account_holder, pack)
	return C

/datum/supply_order/proc/generateCombo(miscbox, misc_own, misc_contents)
	for (var/I in misc_contents)
		new I(miscbox)
	generateManifest(miscbox, misc_own, "")
	return
