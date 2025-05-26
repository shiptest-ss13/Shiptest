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
		/obj/item/stock_parts/cell/gun = 3,
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

	var/voucher_items = list(
		"NT-E-Rifle" = /obj/item/gun/energy/e_gun,
		"E-TAR SMG" = /obj/item/gun/energy/e_gun/smg,
		"E-SG 500" = /obj/item/gun/energy/e_gun/iot)

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

/obj/machinery/vending/security/attackby(obj/item/I, mob/user, params) //WS edit: THERE IS NO GOD. THERE IS ONLY GUNS. REPENT. //shiptest: i should remove this comment, but its funny
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

/obj/machinery/vending/security/wall
	name = "\improper SecTech Lite"
	desc = "A wall mounted security equipment vendor."
	icon_state = "wallsec"
	icon_deny = "wallsec-deny"
	light_mask = "wallsec-light-mask"
	refill_canister = /obj/item/vending_refill/wallsec
	density = FALSE
	tiltable = FALSE
	products = list(
		/obj/item/restraints/handcuffs = 5,
		/obj/item/restraints/handcuffs/cable/zipties = 10,
		/obj/item/stock_parts/cell/gun = 3,
		)
	contraband = list()
	premium = list()

/obj/item/vending_refill/wallsec
	icon_state = "refill_sec"

/obj/machinery/vending/security/marine
	name = "\improper marine vendor"
	desc = "A marine equipment vendor."
	product_ads = "Please insert your marine voucher in the bottom slot."
	icon_state = "marine"
	icon_deny = "marine-deny"
	light_mask = "marine-mask"
	req_access = list(ACCESS_SYNDICATE)
	products = list(
		/obj/item/screwdriver = 5,
		/obj/item/restraints/handcuffs = 10,
		/obj/item/assembly/flash/handheld = 10,
		/obj/item/flashlight/seclite = 10,

		/obj/item/storage/box/lethalshot = 6,
		/obj/item/stock_parts/cell/gun = 5,
		/obj/item/ammo_box/magazine/spitter_9mm = 5,

		/obj/item/grenade/c4 = 5,
		/obj/item/grenade/frag = 5,
		)
	contraband = list()
	premium = list()
	voucher_items = list(
		"Tactical Energy Gun" = /obj/item/gun/energy/e_gun/hades,
		"Combat Shotgun" = /obj/item/gun/ballistic/shotgun/automatic/m11)

/obj/machinery/vending/security/marine/syndicate
	icon_state = "syndicate-marine"
	icon_deny = "syndicate-marine-deny"
	light_mask = "syndicate-marine-mask"
	icon_vend = "syndicate-marine-vend"
	req_access = list(ACCESS_SYNDICATE)
	products = list(
		/obj/item/restraints/handcuffs = 3,
		/obj/item/assembly/flash/handheld = 2,
		/obj/item/flashlight/seclite = 2,
		/obj/item/ammo_box/magazine/m10mm_ringneck = 3,
		/obj/item/ammo_box/magazine/m45_cobra = 3,
		/obj/item/ammo_box/magazine/sniper_rounds = 3,
		/obj/item/ammo_box/magazine/m556_42_hydra = 2,
		/obj/item/ammo_box/magazine/m12g_bulldog/drum = 3,
		/obj/item/ammo_box/magazine/m556_42_hydra/small = 5,
		/obj/item/grenade/c4 = 1,
		/obj/item/grenade/frag = 1,
		)
	voucher_items = list(
		"M-90gl Carbine" = /obj/item/gun/ballistic/automatic/assault/hydra,
		"sniper rifle" = /obj/item/gun/ballistic/automatic/marksman/taipan,
		"C-20r SMG" = /obj/item/gun/ballistic/automatic/smg/cobra,
		"Bulldog Shotgun" = /obj/item/gun/ballistic/shotgun/automatic/bulldog)

/obj/machinery/vending/security/marine/nanotrasen
	icon_state = "nt-marine"
	icon_deny = "nt-marine-deny"
	light_mask = "nt-marine-mask"
	icon_vend = "nt-marine-vend"
	req_access = list(ACCESS_SECURITY)
	products = list(
		/obj/item/restraints/handcuffs = 10,
		/obj/item/assembly/flash/handheld = 10,
		/obj/item/flashlight/seclite = 10,

		/obj/item/screwdriver = 5,
		/obj/item/stock_parts/cell/gun = 10,
		/obj/item/stock_parts/cell/gun/upgraded = 5,

		/obj/item/grenade/c4 = 5,
		/obj/item/grenade/frag = 5,
		/obj/item/grenade/flashbang = 5,
		/obj/item/grenade/barrier = 10,
		)

	voucher_items = list(
		"SL AL-655 Energy Rifle" = /obj/item/gun/energy/e_gun/hades,
		"NT-E-Rifle" = /obj/item/gun/energy/e_gun,
		"E-TAR SMG" = /obj/item/gun/energy/e_gun/smg,
		"E-SG 500" = /obj/item/gun/energy/e_gun/iot)
/obj/item/gun_voucher
	name = "security weapon voucher"
	desc = "A token used to redeem guns from the SecTech vendor."
	icon = 'icons/obj/vending.dmi'
	icon_state = "sec-voucher"
	w_class = WEIGHT_CLASS_TINY //WS end

/obj/item/gun_voucher/syndicate
	name = "syndicate weapon voucher"
	desc = "A token used to redeem equipment from your nearest marine vendor."
	icon_state = "syndie-voucher"

/obj/item/gun_voucher/nanotrasen
	name = "nanotrasen weapon voucher"
	desc = "A token used to redeem equipment from your nearest marine vendor."
	icon_state = "nanotrasen-voucher"
