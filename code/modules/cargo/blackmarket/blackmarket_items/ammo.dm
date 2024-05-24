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
	pair_item = /datum/blackmarket_item/weapon/himehabu_box

	price_min = 100
	price_max = 200
	stock_min = 3
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/weapon/himehabu_box
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
	stock_min = 2
	stock_max = 4
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

/datum/blackmarket_item/weapon/pistole_c_mag
	name = "5.56 Caseless Magazine"
	desc = "A 12 round magazine for the Pistole Cheese."
	item = /obj/item/ammo_box/magazine/pistol556mm

	price_min = 250
	price_max = 750
	stock_max = 2
	availability_prob = 0

/datum/blackmarket_item/ammo/proto_gauss_mag
	name = "Prototype Gauss Rifle Magazine"
	desc = "A 25 round ferromagnetic pellet magazine for the prototype gauss rifle. Keep pellets away from children under the age of 5."
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

/datum/blackmarket_item/ammo/scout_stripper
	name = ".300 Magnum Stripper Clip"
	desc = "A 5 round .300 Magnum stripper clips for use with the HP Scout. Suited for hunting the most dangerous game."
	item = /obj/item/ammo_box/a300

	price_min = 500
	price_max = 1000
	stock_min = 4
	stock_max = 6
	availability_prob = 0
