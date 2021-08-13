/obj/machinery/vending/security
	name = "\improper SecTech"
	desc = "A security equipment vendor."
	product_ads = "Crack capitalist skulls!;Beat some heads in!;Don't forget - harm is good!;Your weapons are right here.;Handcuffs!;Freeze, scumbag!;Don't tase me bro!;Tase them, bro.;Why not have a donut?"
	icon_state = "sec"
	icon_deny = "sec-deny"
	light_mask = "sec-light-mask"
	req_access = list(ACCESS_SECURITY)
	products = list(
		/obj/item/restraints/handcuffs = 8,
		/obj/item/restraints/handcuffs/cable/zipties = 10,
		/obj/item/grenade/flashbang = 4,
		/obj/item/assembly/flash/handheld = 5,
		/obj/item/reagent_containers/food/snacks/donut = 12,
		/obj/item/storage/box/evidence = 6,
		/obj/item/flashlight/seclite = 4,
		/obj/item/restraints/legcuffs/bola/energy = 7,
		/obj/item/ammo_box/c9mm/rubbershot = 3)
	contraband = list(
		/obj/item/clothing/glasses/sunglasses = 2,
		/obj/item/storage/fancy/donut_box = 2)
	premium = list(
		/obj/item/storage/belt/security/webbing = 5,
		/obj/item/coin/antagtoken = 1,
		/obj/item/clothing/head/helmet/blueshirt = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt = 1,
		/obj/item/clothing/gloves/tackler = 5,
		/obj/item/grenade/stingbang = 1)
	refill_canister = /obj/item/vending_refill/security
	default_price = 650
	extra_price = 700
	payment_department = ACCOUNT_SEC

/obj/machinery/vending/security/pre_throw(obj/item/I)
	if(istype(I, /obj/item/grenade))
		var/obj/item/grenade/G = I
		G.preprime()
	else if(istype(I, /obj/item/flashlight))
		var/obj/item/flashlight/F = I
		F.on = TRUE
		F.update_brightness()

/obj/item/vending_refill/security
	icon_state = "refill_sec"

/obj/machinery/vending/security/attackby(obj/item/I, mob/user, params) //WS edit: THERE IS NO GOD. THERE IS ONLY GUNS. REPENT.
	if(istype(I, /obj/item/gun_voucher))
		RedeemVoucher(I, user)
		return
	return..()

/obj/machinery/vending/security/proc/RedeemVoucher(obj/item/gun_voucher/voucher, mob/redeemer)
	var/items = list("E-TAR SMG", "Vector SMG", "E-SG 255", "Hybrid Taser")

	var/selection = input(redeemer, "Select your equipment", "Mining Voucher Redemption") as null|anything in sortList(items)
	if(!selection || !Adjacent(redeemer) || QDELETED(voucher) || voucher.loc != redeemer)
		return
	var/drop_location = drop_location()
	switch(selection)
		if("E-TAR SMG")
			new /obj/item/gun/energy/e_gun/smg(drop_location)
		if("Vector SMG")
			new /obj/item/gun/ballistic/automatic/vector(drop_location)
		if("E-SG 255")
			new /obj/item/gun/energy/laser/iot(drop_location)
		if("Hybrid Taser")
			new /obj/item/gun/energy/e_gun/advtaser(drop_location)

	SSblackbox.record_feedback("tally", "gun_voucher_redeemed", 1, selection)
	qdel(voucher)

/obj/item/gun_voucher
	name = "security weapon voucher"
	desc = "A token used to redeem guns from the SecTech vendor."
	icon = 'icons/obj/mining.dmi'
	icon_state = "mining_voucher"
	w_class = WEIGHT_CLASS_TINY //WS end
