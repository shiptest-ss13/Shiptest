// DISPOSABLE GUN VENDING MACHINE //
/obj/machinery/vending/disposable_guns
	name = "\improper Guns-4-U"
	desc = "A vending machine enthusiastically selling cheap disposable guns. While this would be illegal most places, the Frontier is not most places."
	icon_state = "disposagun"
	products = list(
		/obj/item/gun/ballistic/automatic/pistol/disposable = 50,
		/obj/item/storage/box/disposable_gun_gacha = 50)
	refill_canister = /obj/item/vending_refill/disposable_guns
	product_ads = "Affordable self defense!;Great for bounty hunters!;You know you want one!;Better safe than sorry!"
	default_price = 100
	restock_hourly = TRUE
	light_mask = "disposagun-light-mask"

/obj/machinery/vending/disposable_guns/update_overlays()
	. = ..()
	if(powered() && !(machine_stat & BROKEN))
		SSvis_overlays.add_vis_overlay(src, icon, "disposagun-screen", layer, plane, dir)

// shoots 22 everywhere if broken
/obj/machinery/vending/disposable_guns/atom_break(damage_flag)
	. = ..()
	if(!.)
		return
	var/obj/item/grenade/lol = new /obj/item/grenade/frag/zippy_nuke(loc)
	lol.prime()

/obj/item/vending_refill/disposable_guns
	machine_name = "Disposable Guns"
	icon_state = "mining-refill"
