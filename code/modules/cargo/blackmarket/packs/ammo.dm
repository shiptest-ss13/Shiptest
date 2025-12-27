/datum/blackmarket_item/ammo
	category = "Ammunition"

/datum/blackmarket_item/ammo/shotgun_dart
	name = "Shotgun Dart"
	desc = "These handy darts can be filled up with any chemical and be shot with a shotgun! \
	Prank your friends by shooting them with laughter! \
	Not recommended for comercial use."
	item = /obj/item/ammo_casing/shotgun/dart

	cost_min = 10
	cost_max = 50
	stock_min = 10
	stock_max = 60
	availability_prob = 40

/datum/blackmarket_item/ammo/himehabu_mag
	name = "Himehabu Magazines"
	desc = "Compact 10 round .22 LR magazines for use in the Himehabu pistol."
	item = /obj/item/ammo_box/magazine/m22lr_himehabu

	cost_min = 100
	cost_max = 200
	stock_min = 6
	stock_max = 10
	availability_prob = 0

/datum/blackmarket_item/ammo/a357_box
	name = ".357 Ammo Box"
	desc = "A 50 round ammo box of .357."
	item = /obj/item/storage/box/ammo/a357

	cost_min = 175
	cost_max = 400
	stock_min = 3
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/ammo/a762_box
	name = "7.62x40mm CLIP Ammo Box"
	desc = "A 60 round ammo box of 7.62x40mm CLIP."
	item = /datum/supply_pack/ammo/a762_ammo_box

	cost_min = 250
	cost_max = 600
	stock_min = 3
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/ammo/a858_box
	name = "8x58mm Caseless Ammo Box"
	desc = "A 20 round ammo box of 8x58 caseless."
	item = /obj/item/storage/box/ammo/a858

	cost_min = 150
	cost_max = 300
	stock_min = 3
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/ammo/e40_mag
	name = "Eoehoma .299 Caseless Magazine"
	desc = "A 30 round magazine for the E-40 Hybrid Rifle."
	item = /obj/item/ammo_box/magazine/e40

	cost_min = 400
	cost_max = 800
	stock = 6
	availability_prob = 0

/datum/blackmarket_item/ammo/cm23_mag
	name = "CM-23 Magazines"
	desc = "10 round 10x22mm magazines for use in the CM-23 pistol."
	item = /obj/item/ammo_box/magazine/cm23

	cost_min = 100
	cost_max = 300
	stock_min = 6
	stock_max = 10
	availability_prob = 0

/datum/blackmarket_item/ammo/cm70_mag
	name = "CM-70 Magazines"
	desc = "18 round 9x18mm magazines for use in the CM-70 pistol."
	item = /obj/item/ammo_box/magazine/m9mm_cm70

	cost_min = 200
	cost_max = 450
	stock_min = 4
	stock_max = 8
	availability_prob = 0

/datum/blackmarket_item/ammo/cm5_mag
	name = "CM-5 Magazines"
	desc = "30 round 9x18mm magazines for use in the CM-5 SMG."
	item = /obj/item/ammo_box/magazine/cm5_9mm

	cost_min = 200
	cost_max = 500
	stock_min = 2
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/ammo/model_h_mag
	name = "Model H Magazine"
	desc = "A 10 round magazine for Model H slug pistol."
	item = /obj/item/ammo_box/magazine/modelh

	cost_min = 285
	cost_max = 485
	stock_max = 4
	availability_prob = 0

/datum/blackmarket_item/ammo/pistole_c_mag
	name = "5.56 Caseless Magazine"
	desc = "A 12 round magazine for the Pistole Cheese."
	item = /obj/item/ammo_box/magazine/pistol556mm

	cost_min = 75
	cost_max = 250
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/ammo/proto_gauss_mag
	name = "Prototype Gauss Rifle Magazine"
	desc = "A 25 round ferromagnetic pellet magazine for the prototype gauss rifle. Choking hazard, keep pellets away from children under the age of 5."
	item = /obj/item/ammo_box/magazine/gauss

	cost_min = 225
	cost_max = 500
	stock_min = 3
	stock_max = 5
	availability_prob = 0

/datum/blackmarket_item/ammo/carbine_mag
	name = "SKM-24v Magazine"
	desc = "A 30 round magazine of 4.6x30mm for the SKM-24v. A hermit classic."
	item = /obj/item/ammo_box/magazine/skm_46_30

	cost_min = 200
	cost_max = 500
	stock_min = 3
	stock_max = 5
	availability_prob = 40

/datum/blackmarket_item/ammo/skm_extended
	name = "Extended SKM Magazine"
	desc = "An extended 40 round 7.62x40mm CLIP magazine for the SKM family of assault rifles. Extra curves mean extra ammo."
	item = /obj/item/ammo_box/magazine/skm_762_40/extended

	cost_min = 900
	cost_max = 2500
	stock_max = 4
	availability_prob = 40

/datum/blackmarket_item/ammo/skm_drum
	name = "SKM Drum Magazine"
	desc = "Do you have too much ammo on your hands? Do you have someone you really hate? \
	Do you want them to be absolutely suppressed for the next 15 seconds? \
	This 75 round 7.62x40mm CLIP drum magazine is perfect for you! (SKM not included.)"
	item = /obj/item/ammo_box/magazine/skm_762_40/drum

	cost_min = 1500
	cost_max = 3500
	stock = 2
	availability_prob = 20

/datum/blackmarket_item/ammo/military_etherbor_cell
	name = "military-grade Etherbor cell"
	desc = "A military-grade Etherbor weapon cell. A surefire upgrade to the ones on the civilian market. Lime flavor!"
	item = /obj/item/stock_parts/cell/gun/pgf

	cost_min = 800
	cost_max = 1200
	stock_min = 2
	stock_max = 4
	availability_prob = 40

/datum/blackmarket_item/ammo/gauss_cell
	name = "SolCon Weapon Cell"
	desc = "A Solarian weapon cell, for powering their gauss weaponry."
	item = /obj/item/stock_parts/cell/gun/solgov

	cost_min = 400
	cost_max = 600
	stock_min = 2
	stock_max = 4
	availability_prob = 0

/datum/blackmarket_item/ammo/damaged_cell
	name = "Discount Advanced Eoehoma Power Cells"
	desc = "These cells got a little banged up during a raid by GOLD authorities, but they still should be safe to use. They probably won't explode. In theory."
	item = /obj/item/stock_parts/cell/gun/upgraded

	cost_min = 200
	cost_max = 800
	stock_min = 5
	stock_max = 10
	availability_prob = 80

/datum/blackmarket_item/ammo/damaged_cell/spawn_item(loc)
	var/obj/item/stock_parts/cell/damaged_cell = ..()
	damaged_cell.name = "dented upgraded weapon power cell"
	damaged_cell.desc = "A rechargeable electrochemical power cell. This one doesn't appear to be in the greatest condition."
	if(prob(35))
		damaged_cell.rigged = TRUE
		damaged_cell.show_rigged = FALSE

	return damaged_cell

/datum/blackmarket_item/ammo/advanced_weapon_cell
	name = "Upgraded Eoehoma Power Cells"
	desc = "These upgraded weapon powercells come with twice the capacity of the standard cells, and quality checked to make sure they won't explode!"
	item = /obj/item/stock_parts/cell/gun/upgraded

	cost_min = 1000
	cost_max = 1750
	stock_min = 2
	stock_max = 4
	availability_prob = 25

/datum/blackmarket_item/ammo/huge_weapon_cell
	name = "Extra Large Weapon Power Cells"
	desc = "We're way past double A now. These extra-large power cells (in both charge and size!) are purpose built for the most heavy duty energy weapons."
	item = /obj/item/stock_parts/cell/gun/large

	cost_min = 2500
	cost_max = 4000
	stock = 2
	availability_prob = 20
	spawn_weighting = FALSE

/datum/blackmarket_item/ammo/mecha_hades_ammo
	name = "FNX-99 Incediary Ammo"
	desc = "A box of 24 incendiary shells for the FNX-99 mounted carbine."
	item = /obj/item/mecha_ammo/incendiary

	cost_min = 250
	cost_max = 350
	stock_min = 3
	stock_max = 5
	availability_prob = 0

/datum/blackmarket_item/ammo/mauler_mag
	name = "Mauler Magazine"
	desc = "A 12 round 9x18mm magazine for the Mauler machine pistol."
	item = /obj/item/ammo_box/magazine/m9mm_mauler/extended

	cost_min = 150
	cost_max = 300
	stock_min = 3
	stock_max = 5
	availability_prob = 0

/datum/blackmarket_item/ammo/spitter_mag
	name = "Spitter Magazine"
	desc = "A 30 round 9x18mm magazine for the Spitter submachine gun."
	item = /obj/item/ammo_box/magazine/spitter_9mm

	cost_min = 150
	cost_max = 350
	stock_min = 2
	stock_max = 5
	availability_prob = 0

/datum/blackmarket_item/ammo/pounder_mag
	name = "Pounder Pan Magazine"
	desc = "A 50 round pan magazine for the Pounder submachine gun. Heavy enough to double as an emergency melee weapon to beat off your enemies in a pinch."
	item = /obj/item/ammo_box/magazine/c22lr_pounder_pan

	cost_min = 150
	cost_max = 350
	stock = 2
	availability_prob = 0

/datum/blackmarket_item/ammo/cottonmouth
	name = "Cottonmouth Magazine"
	desc = "A 14 round magazine for the modified Cottonmouth machine pistol."
	item = /obj/item/ammo_box/magazine/m10mm_cottonmouth

	cost_min = 100
	cost_max = 300
	stock = 4
	availability_prob = 0

/datum/blackmarket_item/ammo/f4_magazine
	name = "F4 Magazine"
	desc = "10 round .308 magazine for use in the F4 rifle and it's predecessor, the F3."
	item = /obj/item/ammo_box/magazine/f4_308

	cost_min = 300
	cost_max = 500
	stock_min = 2
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/ammo/a4570hp
	name = ".45-70 Hollow Point Ammo Box"
	desc = "Put the hollow in hollow point by blowing a crater in some random sod with this devastating .45-70 cartridge."
	item = /obj/item/storage/box/ammo/a4570_hp

	cost_min = 500
	cost_max = 1000
	stock_min = 3
	stock_max = 5
	availability_prob = 20

/datum/blackmarket_item/ammo/a4570explo
	name = "Single .45-70 Explosive Round"
	desc = "If you need to fuck someone, hard, we got just the thing. Only one round, though, hope you got good aim."
	item = /obj/item/ammo_casing/a4570/explosive

	cost_min = 400
	cost_max = 800 //still an exorbitantly high cost for one round that you might not even hit
	stock_min = 2
	stock_max = 10
	availability_prob = 10

/datum/blackmarket_item/ammo/c38hotshot
	name = ".38 Hearth Ammo Box"
	desc = "We got our ship cook to marinade some .38 in some hearthflame we pocketed off some hunters. It'll cook your targets to a nice well done."
	item = /obj/item/storage/box/ammo/c38_hotshot

	cost_min = 200
	cost_max = 350
	stock_min = 3
	stock_max = 8
	availability_prob = 50

/datum/blackmarket_item/ammo/c38iceblox
	name = ".38 Chilled Ammo Box"
	desc = "One of our runners accidentally spilled some .38 into a fucking pristine wine of ice shipment. It'll freeze your targets faster than our runner froze solid outside for making a mess."
	item = /obj/item/storage/box/ammo/c38_iceblox

	cost_min = 200
	cost_max = 350
	stock_min = 3
	stock_max = 8
	availability_prob = 50

/datum/blackmarket_item/ammo/a8x50match
	name = "8x50mm Match Box"
	desc = "We found this dead guy with a recording of him going \"Watch this!\", and richoetting something before crumbling over. This is the ammo he had!"
	item = /obj/item/storage/box/ammo/a8_50r/match

	cost_min = 300
	cost_max = 500
	stock_min = 1
	stock_max = 4
	availability_prob = 30

/datum/blackmarket_item/ammo/c22rub
	name = ".22lr Rubbers"
	desc = "A 100 round box of .22 rubbershot from some godsforsaken frontier world. We're pretty sure the use-case is making someone think that they just pissed off a beehive"
	item = /obj/item/storage/box/ammo/c22lr/rubber

	cost_min = 150
	cost_max = 400
	stock_min = 1
	stock_max = 4
	availability_prob = 40

/datum/blackmarket_item/ammo/a8x58trac
	name = "8x58mm Tracker"
	desc = "We hot glued a GPS onto the inside of this 8x58mm shell! For the low low cost of. Whatever the cost is. You can have it!"
	item = /obj/item/ammo_casing/caseless/a858/trac
	cost_min = 50
	cost_max = 500
	stock_min = 4
	stock_max = 8
