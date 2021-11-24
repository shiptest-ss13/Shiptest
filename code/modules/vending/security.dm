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
		/obj/item/assembly/flash/handheld = 5,
		/obj/item/storage/box/evidence = 6,
		/obj/item/flashlight/seclite = 4,
		/obj/item/ammo_box/c9mm/rubbershot = 3,
		/obj/item/ammo_box/c9mm = 1,
		/obj/item/stock_parts/cell/gun = 3)
	contraband = list(
		/obj/item/clothing/glasses/sunglasses = 2)
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

	var/voucher_items = list(
		"NT-E-Rifle" = /obj/item/gun/energy/e_gun,
		"E-TAR SMG" = /obj/item/gun/energy/e_gun/smg,
		"Vector SMG" = /obj/item/gun/ballistic/automatic/vector,
		"E-SG 500" = /obj/item/gun/energy/e_gun/iot,)

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
	var/selection = show_radial_menu(redeemer, src, voucher_items, require_near = TRUE, tooltips = TRUE)
	if(!selection || !Adjacent(redeemer) || QDELETED(voucher) || voucher.loc != redeemer)
		return
	if(voucher_items[selection])
		var/drop_location = drop_location()
		var/obj/selected_item = voucher_items[selection]
		new selected_item(drop_location)

	SSblackbox.record_feedback("tally", "gun_voucher_redeemed", 1, selection)
	qdel(voucher)


/obj/machinery/vending/security/marine
	name = "\improper marine vendor"
	desc = "A marine equipment vendor."
	product_ads = "Please insert your marine voucher in the bottom slot."
	icon_state = "syndicate-marine"
	icon_deny = "syndicate-marine-deny"
	light_mask = "syndicate-marine-mask"
	icon_vend = "syndicate-marine-vend"
	req_access = list(ACCESS_SYNDICATE)
	products = list(
		/obj/item/restraints/handcuffs = 3,
		/obj/item/assembly/flash/handheld = 2,
		/obj/item/flashlight/seclite = 2,
		/obj/item/ammo_box/magazine/m10mm = 3,
		/obj/item/ammo_box/magazine/smgm45 = 3,
		/obj/item/ammo_box/magazine/sniper_rounds = 3,
		/obj/item/ammo_box/magazine/m556 = 2,
		/obj/item/ammo_box/magazine/m12g = 3,
		/obj/item/ammo_box/magazine/ebr = 5,
		/obj/item/grenade/c4 = 1,
		/obj/item/grenade/frag = 1,
		/obj/item/melee/transforming/energy/sword/saber/red = 1,
		)
	contraband = list()
	premium = list()
	voucher_items = list(
		"M-90gl Carbine" = /obj/item/gun/ballistic/automatic/m90/unrestricted,
		"sniper rifle" = /obj/item/gun/ballistic/automatic/sniper_rifle,
		"C-20r SMG" = /obj/item/gun/ballistic/automatic/c20r/unrestricted,
		"Bulldog Shotgun" = /obj/item/gun/ballistic/shotgun/bulldog/unrestricted)

/obj/machinery/vending/security/marine/solgov
	icon_state = "solgov-marine"
	icon_deny = "solgov-marine-deny"
	light_mask = "solgov-marine-mask"
	icon_vend = "solgov-marine-vend"
	req_access = list(ACCESS_SECURITY)
	products = list(
		/obj/item/restraints/handcuffs = 10,
		/obj/item/assembly/flash/handheld = 10,
		/obj/item/flashlight/seclite = 10,
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/ammo_box/magazine/rifle47x33mm = 5,
		/obj/item/ammo_box/magazine/pistol556mm = 10,
		/obj/item/stock_parts/cell/gun = 10,
		/obj/item/screwdriver/nuke = 5,
		/obj/item/grenade/c4 = 5,
		/obj/item/grenade/frag = 5,
		/obj/item/grenade/flashbang = 5,
		/obj/item/grenade/barrier = 10,
		/obj/item/melee/transforming/energy/sword/saber/red = 1,
		)
	voucher_items = list(
		"Tactical Energy Gun" = /obj/item/gun/energy/e_gun/stun,
		"SGV \"Solar\" Assault Rifle" = /obj/item/gun/ballistic/automatic/solar,
		"TGV \"Edison\" Energy Rifle" = /obj/item/gun/energy/laser/terra)

/obj/item/gun_voucher
	name = "security weapon voucher"
	desc = "A token used to redeem guns from the SecTech vendor."
	icon = 'icons/obj/vending.dmi'
	icon_state = "sec-voucher"
	w_class = WEIGHT_CLASS_TINY //WS end

/obj/item/gun_voucher/solgov
	name = "solgov weapon voucher"
	desc = "A token used to redeem equipment from your nearest marine vendor."
	icon_state = "solgov-voucher"

/obj/item/gun_voucher/syndicate
	name = "syndicate weapon voucher"
	desc = "A token used to redeem equipment from your nearest marine vendor."
	icon_state = "syndie-voucher"
