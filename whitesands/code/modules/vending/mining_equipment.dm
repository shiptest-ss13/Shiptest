/* Mining Points Equipment Vendor */
/obj/machinery/vending/mining_equipment
	name = "mining equipment vendor"
	desc = "An equipment vendor for miners, points collected at an ore redemption machine can be spent here."
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
		/obj/item/borg/upgrade/modkit/chassis_mod/orange = 1
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
