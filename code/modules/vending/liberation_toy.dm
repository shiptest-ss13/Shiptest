/obj/machinery/vending/toyliberationstation
	name = "\improper Syndicate Donksoft Toy Vendor"
	desc = "An ages 8 and up approved vendor that dispenses toys. If you were to find the right wires, you can unlock the adult mode setting!"
	icon_state = "syndi"
	product_slogans = "Get your cool toys today!;Quality toy weapons for cheap prices!"
	product_ads = "Feel tough with your toys!;Express your inner child today!;Toy weapons don't kill people, but boredom does!;Who needs responsibilities when you have toy weapons?;Make your next foam fight FUN!"
	vend_reply = "Come back for more!"
	circuit = /obj/item/circuitboard/machine/vending/syndicatedonksofttoyvendor
	products = list(/obj/item/gun/ballistic/automatic/toy = 10,
					/obj/item/gun/ballistic/automatic/toy/pistol = 10,
					/obj/item/gun/ballistic/shotgun/toy = 10,
					/obj/item/toy/sword = 10,
					/obj/item/storage/box/ammo/foam_darts = 20,
					/obj/item/toy/foamblade = 10,
					/obj/item/toy/balloon/syndicate = 10,
					/obj/item/clothing/suit/syndicatefake = 5,
					/obj/item/clothing/head/syndicatefake = 5) //OPS IN DORMS oh wait it's just an assistant
	contraband = list(
		/obj/item/gun/ballistic/shotgun/toy/crossbow = 10,   //Congrats, you unlocked the +18 setting!
		/obj/item/storage/box/ammo/foam_darts/riot = 20,
		/obj/item/toy/katana = 10,
		/obj/item/dualsaber/toy = 5,
		/obj/item/toy/cards/deck/syndicate = 10) //Gambling and it hurts, making it a +18 item
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/donksoft
	default_price = 150
	extra_price = 300
	light_mask = "donksoft-light-mask"
