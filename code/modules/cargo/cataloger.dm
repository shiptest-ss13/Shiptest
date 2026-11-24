/obj/item/catalog_handheld
	name = "Outpost Catalog Handheld"
	desc = "A small portable catalogue for viewing outpost stock. Can print out supply punchcards that can be read by supply consoles."
	icon = 'icons/obj/item/survey_handheld.dmi'
	base_icon_state = "survey"
	icon_state = "survey"
	var/datum/overmap/ship/controlled/current_ship
	var/datum/faction/current_faction
	var/datum/overmap/outpost/parent_outpost

	var/list/categories_data
	var/list/all_packs_data
	var/message

/obj/item/catalog_handheld/Initialize()
	. = ..()
	parent_outpost = pick(SSovermap.outposts)

/obj/item/catalog_handheld/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HandheldCatalog", name)
		ui.open()

/obj/item/catalog_handheld/ui_static_data(mob/user)
	generate_pack_data()

	var/list/static_data = list()
	static_data["categories"] = categories_data
	static_data["all_packs"] = all_packs_data
	return static_data

/obj/item/catalog_handheld/ui_data(mob/user)
	var/list/data = list()

	data["shipFaction"] = (current_ship ? current_ship.source_template.faction.name : null)
	message = "The Handheld Catalog is for browsing purposes only. No actual purchases will be placed."
	data["message"] = message

	return data

/obj/item/catalog_handheld/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	switch(action)
		if("purchase")
			var/list/purchasing = params["cart"]
			var/total_cost = text2num(params["total"])

			playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)
			say("Printing order!")

			var/list/unprocessed_packs = list()
			for(var/list/pack_ref as anything in purchasing)
				var/pack = locate(pack_ref) in parent_outpost.market.supply_packs
				var/amount = purchasing[pack_ref]
				for(var/i = 0; i < amount; i++)
					unprocessed_packs += pack
			generate_punchcard(unprocessed_packs,total_cost,usr)


/obj/item/catalog_handheld/proc/generate_punchcard(purchasing, total_cost, mob/user)
	var/obj/item/order_punchcard/new_card = new(src, purchasing, total_cost)
	usr.put_in_hand(new_card, forced = TRUE)

/obj/item/catalog_handheld/proc/generate_pack_data()
	categories_data = list()
	all_packs_data = list()

	if(!istype(parent_outpost))
		return

	for(var/datum/supply_pack/current_pack as anything in parent_outpost.market.supply_packs)
		if((!current_pack.available))
			continue
		var/same_faction = current_pack.faction ? current_pack.faction.allowed_faction(current_faction) : FALSE
		var/discountedcost = (same_faction && current_pack.faction_discount) ? current_pack.cost - (current_pack.cost * (current_pack.faction_discount * 0.01)) : null
		if(current_pack.faction_locked && !same_faction)
			continue

		if(!categories_data[current_pack.category])
			categories_data[current_pack.category] = list(
				"name" = current_pack.category,
				"packs" = list()
			)
		categories_data[current_pack.category]["packs"] += list(REF(current_pack))
		all_packs_data[REF(current_pack)] = list(
			"name" = current_pack.name,
			"cost" = current_pack.cost,
			"discountedcost" = discountedcost ? discountedcost : null,
			"discountpercent" = current_pack.faction_discount,
			"faction_locked" = current_pack.faction_locked, //this will only show if you are same faction, so no issue
			"ref" = REF(current_pack),

			// If there is a description, use it. Otherwise use the pack's name.
			"desc" = (current_pack.desc || current_pack.name) \
				+ (current_pack.faction_locked ? "\nYou are able to purchase this item due to your faction affiliation." : "") \
				+ (discountedcost ? "\n[-current_pack.faction_discount]% [current_pack.faction_discount > 0 ? "off" : "upcharge"] due to your faction affiliation.\nWas [current_pack.cost]" : ""),
			"no_bundle" = current_pack.no_bundle
		)

/obj/item/order_punchcard
	name = "Order Punchcard"
	desc = "A piece of paper with carfully organized holes through it. Can be inserted into a cargo console to quickly fill in order data."
	gender = NEUTER
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "punchcard"
	var/list/purchases
	var/total_cost = null

/obj/item/order_punchcard/Initialize(mapload, purchasing, totaled_cost)
	. = ..()
	if(purchasing)
		purchases = purchasing
	if(totaled_cost)
		total_cost = totaled_cost

/obj/item/order_punchcard/examine_more(mob/user)
	. = ..()
	var/list_of_orders = "The order includes:"
	var/list/unique_orders = uniqueList(purchases)

	for(var/orders in unique_orders)
		var/datum/supply_pack/pack = orders
		var/purchase_count = count_by_type(purchases, pack)
		list_of_orders += " [pack.name] x [purchase_count]"
	if(total_cost)
		list_of_orders += "; For an estimated total of [total_cost] cr."
	. += span_notice(list_of_orders)




