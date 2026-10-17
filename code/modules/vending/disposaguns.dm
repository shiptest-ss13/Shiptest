/obj/machinery/vending/disposable_guns
	name = "\improper Guns-4-U"
	desc = "A vending machine enthusiastically selling cheap disposable guns. While illegal most places, Installation Trifuge is not most places."
	products = list(
		/obj/item/gun/ballistic/automatic/pistol/disposable = 50,
		/obj/item/storage/box/disposable_gun_gacha = 50)
	refill_canister = /obj/item/vending_refill/disposable_guns
	product_ads = "Affordable self defense!;Great for bounty hunters!;You know you want one!;Better safe than sorry!"
	default_price = 150
	light_mask = "generic-light-mask"

/obj/item/vending_refill/disposable_guns
	machine_name = "Disposable Guns"
	icon_state = "refill_sec"

// TODO make this misfire everywhere when broken
