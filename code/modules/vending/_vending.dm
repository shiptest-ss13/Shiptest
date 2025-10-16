/*
 * Vending machine types - Can be found under /code/modules/vending/
 */

/*

/obj/machinery/vending/[vendors name here]   // --vending machine template   :)
	name = ""
	desc = ""
	icon = ''
	icon_state = ""
	products = list()
	contraband = list()
	premium = list()

IF YOU MODIFY THE PRODUCTS LIST OF A MACHINE, MAKE SURE TO UPDATE ITS RESUPPLY CANISTER CHARGES in vending_items.dm
*/

#define MAX_VENDING_INPUT_AMOUNT 30
/**
	* # vending record datum
	*
	* A datum that represents a product that is vendable
	*/
/datum/data/vending_product
	name = "generic"
	///Typepath of the product that is created when this record "sells"
	var/product_path = null
	///How many of this product we currently have
	var/amount = 0
	///How many we can store at maximum
	var/max_amount = 0
	///Does the item have a custom price override
	var/custom_price
	///Does the item have a custom premium price override
	var/custom_premium_price

/**
	* # vending machines
	*
	* Captalism in the year 2525, everything in a vending machine, even love
	*/
/obj/machinery/vending
	name = "\improper Vendomat"
	desc = "A generic vending machine."
	icon = 'icons/obj/vending.dmi'
	icon_state = "generic"
	layer = BELOW_OBJ_LAYER
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_MINIMAL
	verb_say = "beeps"
	verb_ask = "beeps"
	verb_exclaim = "beeps"
	max_integrity = 300
	integrity_failure = 0.33
	armor = list("melee" = 20, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 70)
	circuit = /obj/item/circuitboard/machine/vendor
	light_power = 0.5
	light_range = MINIMUM_USEFUL_LIGHT_RANGE
	clicksound = 'sound/machines/pda_button1.ogg'

	/// Is the machine active (No sales pitches if off)!
	var/active = 1
	///Are we ready to vend?? Is it time??
	var/vend_ready = TRUE
	///Next world time to send a purchase message
	var/purchase_message_cooldown
	///The ref of the last mob to shop with us
	var/last_shopper
	var/tilted = FALSE
	var/tiltable = TRUE
	var/squish_damage = 75
	var/forcecrit = 0
	var/num_shards = 7
	var/list/pinned_mobs = list()

	/**
	* List of products this machine sells
	*
	*	form should be list(/type/path = amount, /type/path2 = amount2)
	*/
	var/list/products	= list()

	/**
	* List of products this machine sells when you hack it
	*
	*	form should be list(/type/path = amount, /type/path2 = amount2)
	*/
	var/list/contraband	= list()

	/**
	* List of premium products this machine sells
	*
	*	form should be list(/type/path, /type/path2) as there is only ever one in stock
	*/
	var/list/premium 	= list()

	///String of slogans separated by semicolons, optional
	var/product_slogans = ""
	///String of small ad messages in the vending screen - random chance
	var/product_ads = ""

	var/list/product_records = list()
	var/list/hidden_records = list()
	var/list/coin_records = list()
	var/list/slogan_list = list()
	///Small ad messages in the vending screen - random chance of popping up whenever you open it
	var/list/small_ads = list()
	///Message sent post vend (Thank you for shopping!)
	var/vend_reply
	///Last world tick we sent a vent reply
	var/last_reply = 0
	///Last world tick we sent a slogan message out
	var/last_slogan = 0
	///How many ticks until we can send another
	var/slogan_delay = 6000
	///Icon when vending an item to the user
	var/icon_vend
	///Icon to flash when user is denied a vend
	var/icon_deny
	///World ticks the machine is electified for
	var/seconds_electrified = MACHINE_NOT_ELECTRIFIED
	///When this is TRUE, we fire items at customers! We're broken!
	var/shoot_inventory = 0
	///How likely this is to happen (prob 100) per second
	var/shoot_inventory_chance = 1
	//Stop spouting those godawful pitches!
	var/shut_up = 0
	///can we access the hidden inventory?
	var/extended_inventory = 0
	///Are we checking the users ID
	var/scan_id = 1
	///Coins that we accept?
	var/obj/item/coin/coin
	///Bills we accept?
	var/obj/item/spacecash/bundle/bill
	///Does this machine accept mining points?
	var/mining_point_vendor = FALSE
	///Default price of items if not overridden
	var/default_price = 15
	///Default price of premium items if not overridden
	var/extra_price = 30
	///Whether our age check is currently functional
	var/age_restrictions = TRUE

	///A variable to change on a per instance basis on the map that allows the instance to remove cost and ID requirements
	var/all_items_free = TRUE

	///ID's that can load this vending machine wtih refills
	var/list/canload_access_list


	var/list/vending_machine_input = list()
	///Display header on the input view
	var/input_display_header = "Custom Vendor"

	//The type of refill canisters used by this machine.
	var/obj/item/vending_refill/refill_canister = null

	/// how many items have been inserted in a vendor
	var/loaded_items = 0

	///Name of lighting mask for the vending machine
	var/light_mask

	/// used for narcing on underages
	var/obj/item/radio/Radio

	/// restocks venders every hour if this is true
	var/restock_hourly = FALSE

/**
	* Initialize the vending machine
	*
	* Builds the vending machine inventory, sets up slogans and other such misc work
	*/
/obj/machinery/vending/Initialize(mapload)
	var/build_inv = FALSE
	if(!refill_canister)
		circuit = null
		build_inv = TRUE
	. = ..()
	wires = new /datum/wires/vending(src)
	if(build_inv) //non-constructable vending machine
		build_inventory(products, product_records)
		build_inventory(contraband, hidden_records)
		build_inventory(premium, coin_records)

	if(restock_hourly)
		addtimer(CALLBACK(src, PROC_REF(refill_inventory_full)), 60 MINUTES, TIMER_STOPPABLE|TIMER_LOOP|TIMER_DELETE_ME)

	slogan_list = splittext(product_slogans, ";")
	// So not all machines speak at the exact same time.
	// The first time this machine says something will be at slogantime + this random value,
	// so if slogantime is 10 minutes, it will say it at somewhere between 10 and 20 minutes after the machine is crated.
	last_slogan = world.time + rand(0, slogan_delay)
	power_change()

	Radio = new /obj/item/radio(src)
	Radio.listening = 0
	if(istype(get_area(src.loc), /area/outpost) || istype(get_area(src.loc), /area/ruin))
		all_items_free = FALSE

/obj/machinery/vending/Destroy()
	QDEL_NULL(wires)
	QDEL_NULL(coin)
	QDEL_NULL(bill)
	QDEL_NULL(Radio)
	return ..()

/obj/machinery/vending/can_speak()
	return !shut_up

/obj/machinery/vending/RefreshParts()		 //Better would be to make constructable child
	if(!component_parts)
		return

	product_records = list()
	hidden_records = list()
	coin_records = list()
	build_inventory(products, product_records, start_empty = TRUE)
	build_inventory(contraband, hidden_records, start_empty = TRUE)
	build_inventory(premium, coin_records, start_empty = TRUE)
	for(var/obj/item/vending_refill/VR in component_parts)
		restock(VR)

/obj/machinery/vending/deconstruct(disassembled = TRUE)
	if(!refill_canister) //the non constructable vendors drop metal instead of a machine frame.
		if(!(flags_1 & NODECONSTRUCT_1))
			new /obj/item/stack/sheet/metal(loc, 3)
		qdel(src)
	else
		..()

/obj/machinery/vending/update_appearance(updates=ALL)
	. = ..()
	if(machine_stat & BROKEN)
		set_light(0)
		return
	set_light(powered() ? MINIMUM_USEFUL_LIGHT_RANGE : 0)

/obj/machinery/vending/update_icon_state()
	if(machine_stat & BROKEN)
		icon_state = "[initial(icon_state)]-broken"
		return ..()
	icon_state = "[initial(icon_state)][powered() ? null : "-off"]"
	return ..()

/obj/machinery/vending/update_overlays()
	. = ..()
	if(!light_mask)
		return

	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(!(machine_stat & BROKEN) && powered())
		SSvis_overlays.add_vis_overlay(src, icon, light_mask, EMISSIVE_LAYER, EMISSIVE_PLANE)

/obj/machinery/vending/atom_break(damage_flag)
	. = ..()
	if(!.)
		return

	var/dump_amount = 0
	var/found_anything = TRUE
	while (found_anything)
		found_anything = FALSE
		for(var/record in shuffle(product_records))
			var/datum/data/vending_product/R = record
			if(R.amount <= 0) //Try to use a record that actually has something to dump.
				continue
			var/dump_path = R.product_path
			if(!dump_path)
				continue
			R.amount--
			// busting open a vendor will destroy some of the contents
			if(found_anything && prob(80))
				continue

			var/obj/O = new dump_path(loc)
			step(O, pick(GLOB.alldirs))
			found_anything = TRUE
			dump_amount++
			if (dump_amount >= 16)
				return

/**
	* Build the inventory of the vending machine from it's product and record lists
	*
	* This builds up a full set of /datum/data/vending_products from the product list of the vending machine type
	* Arguments:
	* * productlist - the list of products that need to be converted
	* * recordlist - the list containing /datum/data/vending_product datums
	* * startempty - should we set vending_product record amount from the product list (so it's prefilled at roundstart)
	*/
/obj/machinery/vending/proc/build_inventory(list/productlist, list/recordlist, start_empty = FALSE)
	for(var/typepath in productlist)
		var/amount = productlist[typepath]
		if(isnull(amount))
			amount = 0

		var/atom/temp = typepath
		var/datum/data/vending_product/R = new /datum/data/vending_product()
		R.name = initial(temp.name)
		if(istype(temp, /obj/item/stack)) //Include stack amount
			var/obj/item/stack/S = temp
			R.name += " ([S.amount])"
		R.product_path = typepath
		if(!start_empty)
			R.amount = amount
		R.max_amount = amount
		R.custom_price = initial(temp.custom_price)
		R.custom_premium_price = initial(temp.custom_premium_price)
		recordlist += R
/**
	* Refill a vending machine from a refill canister
	*
	* This takes the products from the refill canister and then fills the products,contraband and premium product categories
	*
	* Arguments:
	* * canister - the vending canister we are refilling from
	*/
/obj/machinery/vending/proc/restock(obj/item/vending_refill/canister)
	if (!canister.products)
		canister.products = products.Copy()
	if (!canister.contraband)
		canister.contraband = contraband.Copy()
	if (!canister.premium)
		canister.premium = premium.Copy()
	. = 0
	. += refill_inventory(canister.products, product_records)
	. += refill_inventory(canister.contraband, hidden_records)
	. += refill_inventory(canister.premium, coin_records)
/**
	* Refill our inventory from the passed in product list into the record list
	*
	* Arguments:
	* * productlist - list of types -> amount
	* * recordlist - existing record datums
	*/
/obj/machinery/vending/proc/refill_inventory(list/productlist, list/recordlist)
	. = 0
	for(var/R in recordlist)
		var/datum/data/vending_product/record = R
		var/diff = min(record.max_amount - record.amount, productlist[record.product_path])
		if (diff)
			productlist[record.product_path] -= diff
			record.amount += diff
			. += diff

/obj/machinery/vending/proc/refill_inventory_full()
	refill_inventory(products, product_records)
	refill_inventory(contraband, hidden_records)
	refill_inventory(premium, coin_records)

/**
	* Set up a refill canister that matches this machines products
	*
	* This is used when the machine is deconstructed, so the items aren't "lost"
	*/
/obj/machinery/vending/proc/update_canister()
	if (!component_parts)
		return

	var/obj/item/vending_refill/R = locate() in component_parts
	if (!R)
		CRASH("Constructible vending machine did not have a refill canister")

	R.products = unbuild_inventory(product_records)
	R.contraband = unbuild_inventory(hidden_records)
	R.premium = unbuild_inventory(coin_records)

/**
	* Given a record list, go through and and return a list of type -> amount
	*/
/obj/machinery/vending/proc/unbuild_inventory(list/recordlist)
	. = list()
	for(var/R in recordlist)
		var/datum/data/vending_product/record = R
		.[record.product_path] += record.amount

/obj/machinery/vending/crowbar_act(mob/living/user, obj/item/I)
	if(!component_parts)
		return FALSE
	default_deconstruction_crowbar(I)
	return TRUE

/obj/machinery/vending/wrench_act(mob/living/user, obj/item/I)
	..()
	if(panel_open)
		default_unfasten_wrench(user, I, time = 60)
		unbuckle_all_mobs(TRUE)
	return TRUE

/obj/machinery/vending/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(anchored)
		default_deconstruction_screwdriver(user, icon_state, icon_state, I)
		cut_overlays()
		if(panel_open)
			add_overlay("[initial(icon_state)]-panel")
		updateUsrDialog()
	else
		to_chat(user, span_warning("You must first secure [src]."))
	return TRUE

/obj/machinery/vending/attackby(obj/item/I, mob/user, params)
	if(panel_open && is_wire_tool(I))
		wires.interact(user)
		return

	if(refill_canister && istype(I, refill_canister))
		if (!panel_open)
			to_chat(user, span_warning("You should probably unscrew the service panel first!"))
		else if (machine_stat & (BROKEN|NOPOWER))
			to_chat(user, span_notice("[src] does not respond."))
		else
			//if the panel is open we attempt to refill the machine
			var/obj/item/vending_refill/canister = I
			if(canister.get_part_rating() == 0)
				to_chat(user, span_warning("[canister] is empty!"))
			else
				// instantiate canister if needed
				var/transferred = restock(canister)
				if(transferred)
					to_chat(user, span_notice("You loaded [transferred] items in [src]."))
				else
					to_chat(user, span_warning("There's nothing to restock!"))
			return
	if(compartmentLoadAccessCheck(user) && user.a_intent != INTENT_HARM)
		if(canLoadItem(I))
			loadingAttempt(I,user)
			updateUsrDialog() //can't put this on the proc above because we spam it below

		if(istype(I, /obj/item/storage/bag)) //trays USUALLY
			var/obj/item/storage/T = I
			var/loaded = 0
			var/denied_items = 0
			for(var/obj/item/the_item in T.contents)
				if(contents.len >= MAX_VENDING_INPUT_AMOUNT) // no more than 30 item can fit inside, legacy from snack vending although not sure why it exists
					to_chat(user, span_warning("[src]'s compartment is full."))
					break
				if(canLoadItem(the_item) && loadingAttempt(the_item,user))
					SEND_SIGNAL(T, COMSIG_TRY_STORAGE_TAKE, the_item, src, TRUE)
					loaded++
				else
					denied_items++
			if(denied_items)
				to_chat(user, span_warning("[src] refuses some items!"))
			if(loaded)
				to_chat(user, span_notice("You insert [loaded] dishes into [src]'s compartment."))
				updateUsrDialog()
	else
		. = ..()
		if(tiltable && !tilted && I.force)
			switch(rand(1, 100))
				if(1 to 5)
					freebie(user, 3)
				if(6 to 15)
					freebie(user, 2)
				if(16 to 25)
					freebie(user, 1)
				if(26 to 75)
					return // 50% chance to not do anything
				if(76 to 90)
					tilt(user)
				if(91 to 100)
					tilt(user, crit=TRUE)

/obj/machinery/vending/proc/freebie(mob/fatty, freebies)
	visible_message(span_notice("[src] yields [freebies > 1 ? "several free goodies" : "a free goody"]!"))

	for(var/i in 1 to freebies)
		playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
		for(var/datum/data/vending_product/R in shuffle(product_records))

			if(R.amount <= 0) //Try to use a record that actually has something to dump.
				continue
			var/dump_path = R.product_path
			if(!dump_path)
				continue

			R.amount--
			new dump_path(get_turf(src))
			break

/obj/machinery/vending/proc/tilt(mob/fatty, crit=FALSE)
	visible_message(span_danger("[src] tips over!"))
	tilted = TRUE
	layer = ABOVE_MOB_LAYER

	var/crit_case
	if(crit)
		crit_case = rand(1,6)

	if(forcecrit)
		crit_case = forcecrit

	if(in_range(fatty, src))
		for(var/mob/living/L in get_turf(fatty))
			var/was_alive = (L.stat != DEAD)
			var/mob/living/carbon/C = L

			SEND_SIGNAL(L, COMSIG_ON_VENDOR_CRUSH)

			if(istype(C))
				var/crit_rebate = 0 // lessen the normal damage we deal for some of the crits

				if(crit_case < 5) // the head asplode case has its own description
					C.visible_message(span_danger("[C] is crushed by [src]!"), \
						span_userdanger("You are crushed by [src]!"))

				switch(crit_case) // only carbons can have the fun crits
					if(1) // shatter their legs and bleed 'em
						crit_rebate = 60
						C.bleed(150)
						var/obj/item/bodypart/leg/left/l = C.get_bodypart(BODY_ZONE_L_LEG)
						if(l)
							l.receive_damage(brute=200)
						var/obj/item/bodypart/leg/right/r = C.get_bodypart(BODY_ZONE_R_LEG)
						if(r)
							r.receive_damage(brute=200)
						if(l || r)
							C.visible_message(span_danger("[C]'s legs shatter with a sickening crunch!"), \
								span_userdanger("Your legs shatter with a sickening crunch!"))
					if(2) // pin them beneath the machine until someone untilts it
						forceMove(get_turf(C))
						buckle_mob(C, force=TRUE)
						C.visible_message(span_danger("[C] is pinned underneath [src]!"), \
							span_userdanger("You are pinned down by [src]!"))
					if(3) // glass candy
						crit_rebate = 50
						for(var/i = 0, i < num_shards, i++)
							var/obj/item/shard/shard = new /obj/item/shard(get_turf(C))
							shard.embedding = list(embed_chance = 100, ignore_throwspeed_threshold = TRUE, impact_pain_mult=1, pain_chance=5)
							shard.updateEmbedding()
							C.hitby(shard, skipcatch = TRUE, hitpush = FALSE)
							shard.embedding = list()
							shard.updateEmbedding()
					if(4) // paralyze this binch
						// the new paraplegic gets like 4 lines of losing their legs so skip them
						visible_message(span_danger("[C]'s spinal cord is obliterated with a sickening crunch!"), ignored_mobs = list(C))
						C.gain_trauma(/datum/brain_trauma/severe/paralysis/paraplegic)
					if(5) // limb squish!
						for(var/i in C.bodyparts)
							var/obj/item/bodypart/squish_part = i
							if(IS_ORGANIC_LIMB(squish_part))
								var/type_wound = pick(list(/datum/wound/blunt/severe, /datum/wound/blunt/moderate))
								squish_part.force_wound_upwards(type_wound)
							else
								squish_part.receive_damage(brute=30)
						C.visible_message(
							span_userdanger("[C]'s body is maimed underneath the mass of [src]!"),
							span_userdanger("Your body is maimed underneath the mass of [src]!"),
							span_userdanger("You hear a sickening crunch."),
						)

				if(prob(30))
					C.apply_damage(max(0, squish_damage - crit_rebate), forced=TRUE, spread_damage=TRUE) // the 30% chance to spread the damage means you escape breaking any bones
				else
					C.take_bodypart_damage((squish_damage - crit_rebate)*0.5, wound_bonus = 5) // otherwise, deal it to 2 random limbs (or the same one) which will likely shatter something
					C.take_bodypart_damage((squish_damage - crit_rebate)*0.5, wound_bonus = 5)
				C.AddElement(/datum/element/squish, 20 SECONDS)
			else
				L.visible_message(span_danger("[L] is crushed by [src]!"), \
				span_userdanger("You are crushed by [src]!"))
				L.apply_damage(squish_damage, forced=TRUE)
				if(crit_case)
					L.apply_damage(squish_damage, forced=TRUE)

			if(was_alive && L.stat == DEAD && L.client)
				L.client.give_award(/datum/award/achievement/misc/vendor_squish, L) // good job losing a fight with an inanimate object idiot

			L.Paralyze(60)
			L.force_scream()
			playsound(L, 'sound/effects/blobattack.ogg', 40, TRUE)
			playsound(L, 'sound/effects/splat.ogg', 50, TRUE)

	var/matrix/M = matrix()
	M.Turn(pick(90, 270))
	transform = M

	if(get_turf(fatty) != get_turf(src))
		throw_at(get_turf(fatty), 1, 1, spin=FALSE)

/obj/machinery/vending/proc/untilt(mob/user)
	user.visible_message(span_notice("[user] rights [src]."), \
		span_notice("You right [src]."))

	unbuckle_all_mobs(TRUE)

	tilted = FALSE
	layer = initial(layer)

	var/matrix/M = matrix()
	M.Turn(0)
	transform = M

/obj/machinery/vending/proc/loadingAttempt(obj/item/I, mob/user)
	. = TRUE
	if(!user.transferItemToLoc(I, src))
		return FALSE
	if(vending_machine_input[format_text(I.name)])
		vending_machine_input[format_text(I.name)]++
	else
		vending_machine_input[format_text(I.name)] = 1
	to_chat(user, span_notice("You insert [I] into [src]'s input compartment."))
	loaded_items++

/obj/machinery/vending/unbuckle_mob(mob/living/buckled_mob, force=FALSE)
	if(!force)
		return
	. = ..()

/**
	* Is the passed in user allowed to load this vending machines compartments
	*
	* Arguments:
	* * user - mob that is doing the loading of the vending machine
	*/
/obj/machinery/vending/proc/compartmentLoadAccessCheck(mob/user)
	if(!canload_access_list)
		return TRUE
	else
		var/do_you_have_access = FALSE
		var/req_access_txt_holder = req_access_txt
		for(var/i in canload_access_list)
			req_access_txt = i
			if(!allowed(user) && !(obj_flags & EMAGGED) && scan_id)
				continue
			else
				do_you_have_access = TRUE
				break //you passed don't bother looping anymore
		req_access_txt = req_access_txt_holder // revert to normal (before the proc ran)
		if(do_you_have_access)
			return TRUE
		else
			to_chat(user, span_warning("[src]'s input compartment blinks red: Access denied."))
			return FALSE

/obj/machinery/vending/exchange_parts(mob/user, obj/item/storage/part_replacer/W)
	if(!istype(W))
		return FALSE
	if((flags_1 & NODECONSTRUCT_1) && !W.works_from_distance)
		return FALSE
	if(!component_parts || !refill_canister)
		return FALSE

	var/moved = 0
	if(panel_open || W.works_from_distance)
		if(W.works_from_distance)
			display_parts(user)
		for(var/I in W)
			if(istype(I, refill_canister))
				moved += restock(I)
	else
		display_parts(user)
	if(moved)
		to_chat(user, span_notice("[moved] items restocked."))
		W.play_rped_sound()
	return TRUE

/obj/machinery/vending/on_deconstruction()
	update_canister()
	. = ..()

/obj/machinery/vending/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(user, span_notice("You short out the product lock on [src]."))

/obj/machinery/vending/_try_interact(mob/user)
	if(seconds_electrified && !(machine_stat & NOPOWER))
		if(shock(user, 100))
			return

	if(tilted && !user.buckled && !isAI(user))
		to_chat(user, span_notice("You begin righting [src]."))
		if(do_after(user, 50, target=src))
			untilt(user)
		return

	return ..()

/obj/machinery/vending/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/vending),
	)

/obj/machinery/vending/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Vending")
		ui.open()

/obj/machinery/vending/ui_static_data(mob/user)
	. = list()
	.["all_items_free"] = all_items_free
	.["miningvendor"] = mining_point_vendor
	.["product_records"] = list()
	for (var/datum/data/vending_product/R in product_records)
		var/list/data = list(
			path = replacetext(replacetext("[R.product_path]", "/obj/item/", ""), "/", "-"),
			name = R.name,
			price = R.custom_price || default_price,
			max_amount = R.max_amount,
			ref = REF(R)
		)
		.["product_records"] += list(data)
	.["coin_records"] = list()
	for (var/datum/data/vending_product/R in coin_records)
		var/list/data = list(
			path = replacetext(replacetext("[R.product_path]", "/obj/item/", ""), "/", "-"),
			name = R.name,
			price = R.custom_premium_price || extra_price,
			max_amount = R.max_amount,
			ref = REF(R),
			premium = TRUE
		)
		.["coin_records"] += list(data)
	.["hidden_records"] = list()
	for (var/datum/data/vending_product/R in hidden_records)
		var/list/data = list(
			path = replacetext(replacetext("[R.product_path]", "/obj/item/", ""), "/", "-"),
			name = R.name,
			price = R.custom_premium_price || extra_price,											//WS Edit - vendor incorrect contraband price fix
			max_amount = R.max_amount,
			ref = REF(R),
			premium = TRUE
		)
		.["hidden_records"] += list(data)

/obj/machinery/vending/ui_data(mob/user)
	. = list()
	var/mob/living/carbon/human/H
	var/obj/item/card/bank/card
	if(ishuman(user))
		H = user
		card = H.get_bankcard()
		if(card)
			.["user"] = list()
			.["user"]["points"] = card.mining_points
			if(card.registered_account)
				.["user"]["name"] = card.registered_account.account_holder
				.["user"]["cash"] = card.registered_account.account_balance
	.["stock"] = list()
	for (var/datum/data/vending_product/R in product_records + coin_records + hidden_records)
		.["stock"][R.name] = R.amount
	.["extended_inventory"] = extended_inventory

/obj/machinery/vending/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("vend")
			. = TRUE
			if(!vend_ready)
				return
			if(panel_open)
				to_chat(usr, span_warning("The vending machine cannot dispense products while its service panel is open!"))
				return
			vend_ready = FALSE //One thing at a time!!
			var/datum/data/vending_product/R = locate(params["ref"])
			var/list/record_to_check = product_records + coin_records
			if(extended_inventory)
				record_to_check = product_records + coin_records + hidden_records
			if(!R || !istype(R) || !R.product_path)
				vend_ready = TRUE
				return
			var/price_to_use = default_price
			if(R.custom_price)
				price_to_use = R.custom_price
			if(R in hidden_records)
				if(!extended_inventory)
					vend_ready = TRUE
					return
			else if (!(R in record_to_check))
				vend_ready = TRUE
				message_admins("Vending machine exploit attempted by [ADMIN_LOOKUPFLW(usr)]!")
				return
			if (R.amount <= 0 && R.max_amount >= 0)
				say("Sold out of [R.name].")
				flick(icon_deny,src)
				vend_ready = TRUE
				return
			if(!all_items_free && ishuman(usr))
				var/mob/living/carbon/human/H = usr
				var/obj/item/card/bank/C = H.get_bankcard()

				if(!C)
					say("No card found.")
					flick(icon_deny,src)
					vend_ready = TRUE
					return
				else if (!C.registered_account && !mining_point_vendor)
					say("No account found.")
					flick(icon_deny,src)
					vend_ready = TRUE
					return
				if(mining_point_vendor)
					if(price_to_use > C.mining_points)
						say("You do not possess the funds to purchase [R.name].")
						flick(icon_deny,src)
						vend_ready = TRUE
						return
					C.mining_points -= price_to_use
				else
					var/datum/bank_account/account = C.registered_account
					if(coin_records.Find(R) || hidden_records.Find(R))
						price_to_use = R.custom_premium_price ? R.custom_premium_price : extra_price
					if(price_to_use && !account.has_money(price_to_use))
						say("You do not possess the funds to purchase [R.name].")
						flick(icon_deny,src)
						vend_ready = TRUE
						return
					account.adjust_money(-price_to_use, CREDIT_LOG_VENDOR_PURCHASE)
					SSblackbox.record_feedback("amount", "vending_spent", price_to_use)
					log_econ("[price_to_use] credits were inserted into [src] by [H] to buy [R].")
			if(last_shopper != REF(usr) || purchase_message_cooldown < world.time)
				say("Thank you for shopping with [src]!")
				purchase_message_cooldown = world.time + 5 SECONDS
				last_shopper = REF(usr)
			use_power(5)
			if(icon_vend) //Show the vending animation if needed
				flick(icon_vend,src)
			playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
			var/obj/item/vended_item = new R.product_path(get_turf(src))
			if(R.max_amount >= 0)
				R.amount--
			if(usr.CanReach(src) && usr.put_in_hands(vended_item))
				to_chat(usr, span_notice("You take [R.name] out of the slot."))
			else
				to_chat(usr, span_warning("[capitalize(R.name)] falls onto the floor!"))
			SSblackbox.record_feedback("nested tally", "vending_machine_usage", 1, list("[type]", "[R.product_path]"))
			vend_ready = TRUE

/obj/machinery/vending/process(seconds_per_tick)
	if(machine_stat & (BROKEN|NOPOWER))
		return PROCESS_KILL
	if(!active)
		return

	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--

	//Pitch to the people!  Really sell it!
	if(last_slogan + slogan_delay <= world.time && slogan_list.len > 0 && !shut_up && SPT_PROB(2.5, seconds_per_tick))
		var/slogan = pick(slogan_list)
		speak(slogan)
		last_slogan = world.time

	if(shoot_inventory && SPT_PROB(shoot_inventory_chance, seconds_per_tick))
		throw_item()
/**
	* Speak the given message verbally
	*
	* Checks if the machine is powered and the message exists
	*
	* Arguments:
	* * message - the message to speak
	*/
/obj/machinery/vending/proc/speak(message)
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(!message)
		return

	say(message, language=/datum/language/galactic_common)

/obj/machinery/vending/power_change()
	. = ..()
	if(powered())
		START_PROCESSING(SSmachines, src)

//Somebody cut an important wire and now we're following a new definition of "pitch."
/**
	* Throw an item from our internal inventory out in front of us
	*
	* This is called when we are hacked, it selects a random product from the records that has an amount > 0
	* This item is then created and tossed out in front of us with a visible message
	*/
/obj/machinery/vending/proc/throw_item()
	var/obj/throw_item = null
	var/mob/living/target = locate() in view(7,src)
	if(!target)
		return 0

	for(var/datum/data/vending_product/R in shuffle(product_records))
		if(R.amount <= 0) //Try to use a record that actually has something to dump.
			continue
		var/dump_path = R.product_path
		if(!dump_path)
			continue

		R.amount--
		throw_item = new dump_path(loc)
		break
	if(!throw_item)
		return 0

	pre_throw(throw_item)

	throw_item.throw_at(target, 16, 3)
	visible_message(span_danger("[src] launches [throw_item] at [target]!"))
	return 1
/**
	* A callback called before an item is tossed out
	*
	* Override this if you need to do any special case handling
	*
	* Arguments:
	* * I - obj/item being thrown
	*/
/obj/machinery/vending/proc/pre_throw(obj/item/I)
	return
/**
	* Shock the passed in user
	*
	* This checks we have power and that the passed in prob is passed, then generates some sparks
	* and calls electrocute_mob on the user
	*
	* Arguments:
	* * user - the user to shock
	* * prb - probability the shock happens
	*/
/obj/machinery/vending/proc/shock(mob/living/user, prb)
	if(!istype(user) || machine_stat & (BROKEN|NOPOWER))		// unpowered, no shock
		return FALSE
	if(!prob(prb))
		return FALSE
	do_sparks(5, TRUE, src)
	var/check_range = TRUE
	if(electrocute_mob(user, get_area(src), src, 0.7, check_range))
		return TRUE
	else
		return FALSE
/**
	* Are we able to load the item passed in
	*
	* Arguments:
	* * I - the item being loaded
	* * user - the user doing the loading
	*/
/obj/machinery/vending/proc/canLoadItem(obj/item/I, mob/user)
	return FALSE

/obj/machinery/vending/custom
	name = "Custom Vendor"
	icon_state = "robotics"
	icon_deny = "robotics-deny"
	max_integrity = 400
	refill_canister = /obj/item/vending_refill/custom
	all_items_free = FALSE
	/// where the money is sent
	var/datum/bank_account/private_a
	/// max number of items that the custom vendor can hold
	var/max_loaded_items = 20
	/// Base64 cache of custom icons.
	var/list/base64_cache = list()

/obj/machinery/vending/custom/compartmentLoadAccessCheck(mob/user)
	. = FALSE
	var/mob/living/carbon/human/H
	var/obj/item/card/bank/C
	if(ishuman(user))
		H = user
		C = H.get_bankcard(FALSE)
		if(C?.registered_account && C.registered_account == private_a)
			return TRUE

/obj/machinery/vending/custom/canLoadItem(obj/item/I, mob/user)
	. = FALSE
	if(loaded_items >= max_loaded_items)
		say("There are too many items in stock.")
		return
	if(istype(I, /obj/item/stack))
		say("Loose items may cause problems, try use it inside wrapping paper.")
		return
	if(I.custom_price)
		return TRUE

/obj/machinery/vending/custom/ui_data(mob/user)
	. = ..()
	.["access"] = compartmentLoadAccessCheck(user)
	.["vending_machine_input"] = list()
	for (var/O in vending_machine_input)
		if(vending_machine_input[O] > 0)
			var/base64
			var/price = 0
			for(var/obj/T in contents)
				if(format_text(T.name) == O)
					price = T.custom_price
					if(!base64)
						if(base64_cache[T.type])
							base64 = base64_cache[T.type]
						else
							base64 = icon2base64(getFlatIcon(T, no_anim=TRUE))
							base64_cache[T.type] = base64
					break
			var/list/data = list(
				name = O,
				price = price,
				img = base64,
				amount = vending_machine_input[O],
				colorable = FALSE
			)
			.["vending_machine_input"] += list(data)

/obj/machinery/vending/custom/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("dispense")
			. = TRUE
			if(!vend_ready)
				return
			var/N = params["item"]
			var/obj/S
			vend_ready = FALSE
			if(ishuman(usr))
				var/mob/living/carbon/human/H = usr
				var/obj/item/card/bank/C = H.get_bankcard()

				if(!C)
					say("No card found.")
					flick(icon_deny,src)
					vend_ready = TRUE
					return
				else if (!C.registered_account)
					say("No account found.")
					flick(icon_deny,src)
					vend_ready = TRUE
					return
				var/datum/bank_account/account = C.registered_account
				for(var/obj/O in contents)
					if(format_text(O.name) == N)
						S = O
						break
				if(S)
					if(compartmentLoadAccessCheck(usr))
						vending_machine_input[N] = max(vending_machine_input[N] - 1, 0)
						S.forceMove(drop_location())
						loaded_items--
						use_power(5)
						vend_ready = TRUE
						updateUsrDialog()
						return
					if(account.has_money(S.custom_price))
						var/datum/bank_account/owner = private_a
						if(owner)
							owner.transfer_money(account, S.custom_price)
							owner.bank_card_talk("\The [S] was purchased from your vendor. [S.custom_price] credits deposited to account, balance is now [owner.account_balance].")
						else
							account.adjust_money(-S.custom_price, CREDIT_LOG_VENDOR_PURCHASE)
						SSblackbox.record_feedback("amount", "vending_spent", S.custom_price)
						log_econ("[S.custom_price] credits were spent on [src] buying a [S] by [owner.account_holder], owned by [private_a.account_holder].")
						vending_machine_input[N] = max(vending_machine_input[N] - 1, 0)
						S.forceMove(drop_location())
						loaded_items--
						use_power(5)
						if(last_shopper != REF(usr) || purchase_message_cooldown < world.time)
							say("Thank you for buying local and purchasing [S]!")
							purchase_message_cooldown = world.time + 5 SECONDS
							last_shopper = REF(usr)
						vend_ready = TRUE
						updateUsrDialog()
						return
					else
						say("You do not possess the funds to purchase this.")
			vend_ready = TRUE

/obj/machinery/vending/custom/attackby(obj/item/I, mob/user, params)
	if(!private_a)
		var/mob/living/carbon/human/H
		var/obj/item/card/bank/C
		if(ishuman(user))
			H = user
			C = H.get_bankcard(TRUE)
			if(C?.registered_account)
				private_a = C.registered_account
				say("\The [src] has been linked to [C].")

	if(compartmentLoadAccessCheck(user))
		if(istype(I, /obj/item/pen))
			name = stripped_input(user,"Set name","Name", name, 20)
			desc = stripped_input(user,"Set description","Description", desc, 60)
			slogan_list += stripped_input(user,"Set slogan","Slogan","Epic", 60)
			last_slogan = world.time + rand(0, slogan_delay)
			return

		if(canLoadItem(I))
			loadingAttempt(I,user)
			updateUsrDialog()
			return

	if(panel_open && is_wire_tool(I))
		wires.interact(user)
		return

	return ..()

/obj/machinery/vending/custom/crowbar_act(mob/living/user, obj/item/I)
	return FALSE

/obj/machinery/vending/custom/Destroy()
	unbuckle_all_mobs(TRUE)
	var/turf/T = get_turf(src)
	if(T)
		for(var/obj/item/I in contents)
			I.forceMove(T)
		explosion(T, -1, 0, 3)
	return ..()

/obj/machinery/vending/custom/unbreakable
	name = "Indestructible Vendor"
	resistance_flags = INDESTRUCTIBLE

/obj/item/vending_refill/custom
	machine_name = "Custom Vendor"
	icon_state = "refill_custom"
	custom_premium_price = 100
	custom_materials = list(/datum/material/iron = 5000, /datum/material/glass = 2000) // WS Edit - Item Materials

/obj/item/price_tagger
	name = "price tagger"
	desc = "This tool is used to set a price for items used in custom vendors."
	icon = 'icons/obj/device.dmi'
	icon_state = "pricetagger"
	custom_premium_price = 25
	///the price of the item
	var/price = 1
	custom_materials = list(/datum/material/iron = 1500, /datum/material/glass = 500) // WS Edit - Item Materials

/obj/item/price_tagger/attack_self(mob/user)
	price = max(1, round(input(user,"set price","price") as num|null, 1))
	to_chat(user, span_notice(" The [src] will now give things a [price] cr tag."))

/obj/item/price_tagger/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(isitem(target))
		var/obj/item/I = target
		I.custom_price = price
		to_chat(user, span_notice("You set the price of [I] to [price] cr."))
