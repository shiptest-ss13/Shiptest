/datum/blackmarket_item/ammo
	category = "Ammunition"

/datum/blackmarket_item/ammo/shotgun_dart
	name = "Shotgun Dart"
	desc = "These handy darts can be filled up with any chemical and be shot with a shotgun! \
	Prank your friends by shooting them with laughter! \
	Not recommended for comercial use."
	item = /obj/item/ammo_casing/shotgun/dart

	price_min = 10
	price_max = 50
	stock_min = 10
	stock_max = 60
	availability_prob = 40

/datum/blackmarket_item/ammo/himehabu_mag
	name = "Himehabu Magazines"
	desc = "Compact 10 round .22lr magazines for use in the Himehabu pistol."
	item = /obj/item/ammo_box/magazine/m22lr

	price_min = 100
	price_max = 200
	stock_min = 6
	stock_max = 10
	availability_prob = 0

/datum/blackmarket_item/ammo/himehabu_box
	name = ".22lr Ammo Box"
	desc = "A 75 round ammo box of .22lr. Trust me, you'll need every shot."
	item = /obj/item/ammo_box/c22lr_box

	price_min = 100
	price_max = 300
	stock_min = 3
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/ammo/e40_mag
	name = "Eoehoma .299 Caseless Magazine"
	desc = "A 30 round magazine for the E-40 Hybrid Rifle. A magazine of BULLETS, not lasers if that wasn't clear."
	item = /obj/item/ammo_box/magazine/e40

	price_min = 750
	price_max = 1250
	stock_min = 3
	stock_max = 5
	availability_prob = 0

/datum/blackmarket_item/ammo/saber_mag
	name = "Saber 9mm SMG Magazines"
	desc = "Magazines for use in the Saber 9mm SMG. No, they don't work as swords."
	item = /obj/item/ammo_box/magazine/smgm9mm

	price_min = 500
	price_max = 1000
	stock_min = 2
	stock_max = 4
	availability_prob = 0

/datum/blackmarket_item/ammo/model_h_mag
	name = "Model H Magazine"
	desc = "A 10 round magazine for Model H slug pistol. Ferromagnetic slugs, not animal slugs. We're not monsters."
	item = /obj/item/ammo_box/magazine/modelh

	price_min = 500
	price_max = 1000
	stock_max = 4
	availability_prob = 0

/datum/blackmarket_item/ammo/sgg_stripper
	name = "8x58mm Stripper Clip"
	desc = "A five round 8x58mm stripper clip for use with the SGG-669C. Also doubles as a paperweight, because of course it does. Fucking Solarians."
	item = /obj/item/ammo_box/a858

	price_min = 500
	price_max = 1000
	stock_min = 4
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/ammo/pistole_c_mag
	name = "5.56 Caseless Magazine"
	desc = "A 12 round magazine for the Pistole Cheese."
	item = /obj/item/ammo_box/magazine/pistol556mm

	price_min = 250
	price_max = 750
	stock = 2
	availability_prob = 0

/datum/blackmarket_item/ammo/proto_gauss_mag
	name = "Prototype Gauss Rifle Magazine"
	desc = "A 25 round ferromagnetic pellet magazine for the prototype gauss rifle. Choking hazard, keep pellets away from children under the age of 5."
	item = /obj/item/ammo_box/magazine/gauss

	price_min = 500
	price_max = 800
	stock_min = 2
	stock_max = 4
	availability_prob = 0

/datum/blackmarket_item/ammo/tec_mag
	name = "TEC-9 AP Magazine"
	desc = "A 20 round magazine of AP ammo for the TEC-9 machine pistol. For those extra tough targets."
	item = /obj/item/ammo_box/magazine/tec9

	price_min = 500
	price_max = 1000
	stock_min = 2
	stock_max = 4
	availability_prob = 0

/datum/blackmarket_item/ammo/blackout
	name = ".300 Blackout Stripper Clip"
	desc = "A 5 round clip of .300 Blackout. It'll be lights out soon enough for anyone hit with these."
	item = /obj/item/ammo_box/aac_300blk_stripper

	price_min = 500
	price_max = 750
	stock_min = 4
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/ammo/carbine_mag
	name = "SKM-24v Magazine"
	desc = "A 30 round magazine of 4.6x30mm for the SKM-24v. A hermit classic."
	item = /obj/item/ammo_box/magazine/skm_545_39

	price_min = 500
	price_max = 1000
	stock_min = 2
	stock_max = 4
	availability_prob = 40

/datum/blackmarket_item/ammo/skm_extended
	name = "Extended SKM Magazine"
	desc = "An extended 40 round 7.62x40mm CLIP magazine for the SKM family of assault rifles. Extra curves mean extra ammo."
	item = /obj/item/ammo_box/magazine/skm_762_40/extended

	price_min = 1000
	price_max = 3000
	stock_max = 4
	availability_prob = 40

/datum/blackmarket_item/ammo/skm_drum
	name = "SKM Drum Magazine"
	desc = "Do you have too much ammo on your hands? Do you have someone you really hate? \
	Do you want them to be absolutely suppressed for the next 15 seconds? \
	 This 75 round 7.62x40mm CLIP drum magazine is perfect for you! (SKM not included.)"
	item = /obj/item/ammo_box/magazine/skm_762_40/drum

	price_min = 1750
	price_max = 3500
	stock = 2
	availability_prob = 20

/datum/blackmarket_item/ammo/damaged_cell
	name = "Discount Weapon Power Cells"
	desc = "These cells got a little banged up during a raid by GOLD authorities, but they still should be safe to use. Probably."
	item = /obj/item/stock_parts/cell/gun

	price_min = 100
	price_max = 500
	stock_min = 5
	stock_max = 10
	availability_prob = 80

/datum/blackmarket_item/ammo/damaged_cell/spawn_item(loc)
	if(prob(35))
		var/obj/item/stock_parts/cell/damaged_cell = ..()
		damaged_cell.rigged = TRUE
		return new damaged_cell(loc)

	return ..()

/datum/blackmarket_item/ammo/mecha_hades_ammo
	name = "FNX-99 Incediary Ammo"
	desc = "A box of 24 incendiary shells for the FNX-99 mounted carbine."
	item = /obj/item/mecha_ammo/incendiary

	price_min = 250
	price_max = 350
	stock_min = 3
	stock_max = 5
	availability_prob = 0

