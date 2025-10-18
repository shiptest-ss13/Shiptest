/obj/machinery/vending/donksofttoyvendor
	name = "\improper Donksoft Toy Vendor"
	desc = "Ages 8 and up approved vendor that dispenses toys."
	icon_state = "nt-donk"
	product_slogans = "Get your cool toys today!;Quality toy weapons for cheap prices!"
	product_ads = "Feel tough with your toys!;Express your inner child today!;Toy weapons don't kill people, but bordeom does!;Who needs responsibilities when you have toy weapons?;Make your next foam fight FUN!"
	vend_reply = "Come back for more!"
	light_mask = "donksoft-light-mask"
	circuit = /obj/item/circuitboard/machine/vending/donksofttoyvendor
	products = list(
		/obj/item/gun/ballistic/automatic/toy = 10,
		/obj/item/gun/ballistic/automatic/toy/pistol = 10,
		/obj/item/gun/ballistic/shotgun/toy = 10,
		/obj/item/toy/sword = 10,
		/obj/item/storage/box/ammo/foam_darts = 20,
		/obj/item/toy/foamblade = 10,
		/obj/item/toy/balloon/syndicate = 10,
		/obj/item/gun/ballistic/shotgun/toy/crossbow = 10,
		/obj/item/toy/katana = 10,
		/obj/item/melee/duelenergy/saber/toy = 5)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/donksoft
	default_price = 100
	extra_price = 300

/obj/item/vending_refill/donksoft
	machine_name = "Donksoft Toy Vendor"
	icon_state = "refill_donksoft"
