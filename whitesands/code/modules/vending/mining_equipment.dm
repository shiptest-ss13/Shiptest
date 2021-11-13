/* Mining Points Equipment Vendor */
/obj/machinery/vending/mining_equipment
	name = "frontier equipment vendor"
	desc = "An equipment vendor for miners, prospectors, and all manner of far reach scroungers. Ore Redemption Points can be spent here to purchase rough-and-tumble goods. Sold by EXOCON."
	icon = 'whitesands/icons/obj/machines/vending.dmi'
	icon_state = "mining"
	icon_deny = "mining-deny"
	max_integrity = 500 // A bit more durable than your average snack vendor
	integrity_failure = 0.15
	armor = list("melee" = 25, "bullet" = 10, "laser" = 5, "energy" = 5, "bomb" = 5, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 70)
	tiltable = FALSE
	shoot_inventory_chance = 0
	circuit = /obj/item/circuitboard/machine/vending/mining_equipment
	refill_canister = /obj/item/vending_refill/mining_equipment
	payment_department = ACCOUNT_CAR
	vend_ready = "Good luck, you're going to need it."
	mining_point_vendor = TRUE
	default_price = 100
	extra_price = 200
	// Mining products are handled differently, because I am too lazy to convert this list stolen from the old vendor.
	products = list( //if you add something to this, please, for the love of god, sort it by price/type. use tabs and not spaces.
		/obj/item/stack/marker_beacon/thirty = 6,
		/obj/item/reagent_containers/food/drinks/bottle/whiskey = 3,
		/obj/item/storage/box/gum/bubblegum = 5,
		/obj/item/clothing/mask/cigarette/cigar/havana = 3,
		/obj/item/soap/nanotrasen = 1,
		/obj/item/hivelordstabilizer = 6,
		/obj/item/fulton_core = 1,
		/obj/item/survivalcapsule = 3,
		/obj/item/storage/belt/mining = 3,
		/obj/item/card/mining_point_card = 5,
		/obj/item/reagent_containers/hypospray/medipen/survival = 6,
		/obj/item/storage/firstaid/brute = 3,
		/obj/item/storage/box/minertracker = 5,
		/obj/item/wormhole_jaunter = 3,
		/obj/item/kinetic_crusher = 1,
		/obj/item/gun/energy/kinetic_accelerator = 3,
		/obj/item/pinpointer/deepcore = 5,		// WS edit - Deepcore
		/obj/item/pinpointer/deepcore/advanced = 2,		// WS edit - Deepcore
		/obj/item/deepcorecapsule = 3,		// WS edit - Deepcore
		/obj/item/resonator = 3,
		/obj/item/extraction_pack = 3,
		/obj/item/lazarus_injector = 1,
		/obj/item/pickaxe/silver = 3,
		/obj/item/storage/backpack/duffelbag/mining_conscript = 3,
		/obj/item/tank/jetpack/suit = 3,
		/obj/item/stack/spacecash/c1000 = 5,
		/obj/item/clothing/suit/space/hardsuit/mining = 3,
		/obj/item/resonator/upgraded = 1,
		/obj/item/clothing/shoes/bhop = 3,
		/obj/item/survivalcapsule/luxury = 3,
		/mob/living/simple_animal/hostile/mining_drone = 3,
		/obj/item/mine_bot_upgrade = 3,
		/obj/item/mine_bot_upgrade/health = 3,
		/obj/item/borg/upgrade/modkit/cooldown/minebot = 3,
		/obj/item/slimepotion/slime/sentience/mining = 1,
		/obj/item/borg/upgrade/modkit/minebot_passthrough = 3,
		/obj/item/borg/upgrade/modkit/tracer = 3,
		/obj/item/borg/upgrade/modkit/tracer/adjustable = 3,
		/obj/item/borg/upgrade/modkit/chassis_mod = 3,
		/obj/item/borg/upgrade/modkit/range = 3,
		/obj/item/borg/upgrade/modkit/damage = 3,
		/obj/item/borg/upgrade/modkit/cooldown = 3,
		/obj/item/borg/upgrade/modkit/aoe/mobs = 2
	)
	premium = list(
		/obj/item/reagent_containers/food/drinks/bottle/absinthe/premium = 3,
		/obj/item/laser_pointer = 1,
		/obj/item/pickaxe/diamond = 1,
		/obj/item/clothing/mask/facehugger/toy = 1,
		/obj/item/clothing/glasses/meson/gar = 2,
		/obj/item/survivalcapsule/luxuryelite = 1,
	)

/obj/machinery/vending/mining_equipment/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/mining_voucher))
		RedeemVoucher(I, user)
		return
	return ..()

/obj/machinery/vending/mining_equipment/proc/RedeemVoucher(obj/item/mining_voucher/voucher, mob/redeemer)
	var/items = list("Survival Capsule and Explorer's Webbing", "Resonator Kit", "Minebot Kit", "Extraction and Rescue Kit", "Crusher Kit", "Mining Conscription Kit")

	var/selection = input(redeemer, "Pick your equipment", "Mining Voucher Redemption") as null|anything in sortList(items)
	if(!selection || !Adjacent(redeemer) || QDELETED(voucher) || voucher.loc != redeemer)
		return
	var/drop_location = drop_location()
	switch(selection)
		if("Survival Capsule and Explorer's Webbing")
			new /obj/item/storage/belt/mining/vendor(drop_location)
		if("Resonator Kit")
			new /obj/item/extinguisher/mini(drop_location)
			new /obj/item/resonator(drop_location)
		if("Minebot Kit")
			new /mob/living/simple_animal/hostile/mining_drone(drop_location)
			new /obj/item/weldingtool/hugetank(drop_location)
			new /obj/item/clothing/head/welding(drop_location)
			new /obj/item/borg/upgrade/modkit/minebot_passthrough(drop_location)
		if("Extraction and Rescue Kit")
			new /obj/item/extraction_pack(drop_location)
			new /obj/item/fulton_core(drop_location)
			new /obj/item/stack/marker_beacon/thirty(drop_location)
		if("Crusher Kit")
			new /obj/item/extinguisher/mini(drop_location)
			new /obj/item/kinetic_crusher(drop_location)
		if("Mining Conscription Kit")
			new /obj/item/storage/backpack/duffelbag/mining_conscript(drop_location)

	SSblackbox.record_feedback("tally", "mining_voucher_redeemed", 1, selection)
	qdel(voucher)

/obj/item/circuitboard/machine/vending/mining_equipment
	name = "mining equipment vendor (Machine Board)"
	build_path = /obj/machinery/vending/mining_equipment
	req_components = list(
		/obj/item/stack/sheet/rglass = 1,
		/obj/item/vending_refill/mining_equipment = 1)

/obj/item/vending_refill/mining_equipment
	machine_name = "mining equipment vendor"
	icon = 'whitesands/icons/obj/machines/vending.dmi'
	icon_state = "mining-refill"

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
				to_chat(usr, "<span class='warning'>The vending machine cannot dispense products while its service panel is open!</span>")
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
			if(onstation && ishuman(usr))
				var/mob/living/carbon/human/H = usr
				var/obj/item/card/id/C = H.get_idcard(TRUE)

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
				else if(age_restrictions && R.age_restricted && (!C.registered_age || C.registered_age < AGE_MINOR))
					say("You are not of legal age to purchase [R.name].")
					if(!(usr in GLOB.narcd_underages))
						Radio.set_frequency(FREQ_SECURITY)
						Radio.talk_into(src, "SECURITY ALERT: Underaged crewmember [H] recorded attempting to purchase [R.name] in [get_area(src)]. Please watch for substance abuse.", FREQ_SECURITY)
						GLOB.narcd_underages += H
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
					if(account.account_job && account.account_job.paycheck_department == payment_department)
						price_to_use = 0
					if(coin_records.Find(R) || hidden_records.Find(R))
						price_to_use = R.custom_premium_price ? R.custom_premium_price : extra_price
					if(price_to_use && !account.adjust_money(-price_to_use))
						say("You do not possess the funds to purchase [R.name].")
						flick(icon_deny,src)
						vend_ready = TRUE
						return
					var/datum/bank_account/D = SSeconomy.get_dep_account(payment_department)
					if(D)
						D.adjust_money(price_to_use)
						SSblackbox.record_feedback("amount", "vending_spent", price_to_use)
						log_econ("[price_to_use] credits were inserted into [src] by [D.account_holder] to buy [R].")
			if(last_shopper != usr || purchase_message_cooldown < world.time)
				say("Good luck, you're going to need it.")
				purchase_message_cooldown = world.time + 5 SECONDS
				last_shopper = usr
			use_power(5)
			if(icon_vend) //Show the vending animation if needed
				flick(icon_vend,src)
			playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
			new R.product_path(get_turf(src))
			if(R.max_amount >= 0)
				R.amount--
			SSblackbox.record_feedback("nested tally", "vending_machine_usage", 1, list("[type]", "[R.product_path]"))
			vend_ready = TRUE
