/datum/blackmarket_item/weapon
	category = "Weapons"

/datum/blackmarket_item/weapon/bear_trap
	name = "Bear Trap"
	desc = "Get the janitor back at his own game with this affordable prank kit."
	item = /obj/item/restraints/legcuffs/beartrap

	price_min = 300
	price_max = 550
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/weapon/shotgun_dart
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

/datum/blackmarket_item/weapon/bone_spear
	name = "Bone Spear"
	desc = "Authentic tribal spear, made from real bones! A steal at any price, especially if you're a caveman."
	item = /obj/item/spear/bonespear

	price_min = 200
	price_max = 300
	stock_max = 3
	availability_prob = 60

/datum/blackmarket_item/weapon/switchblade
	name = "Switchblade"
	desc = "Extra shrap switchblades for intimidation AND style. Bandages not included if you cut yourself."
	item = /obj/item/switchblade

	price_min = 500
	price_max = 700
	stock_max = 3
	availability_prob = 50

/datum/blackmarket_item/weapon/sabre
	name = "SUNS Dueling Sabre"
	desc = "A mastercrafted sabre formerly wielded by a SUNS academic. It's very sharp, we had to spend hours stitching our fingers back on after getting it."
	item = /obj/item/storage/belt/sabre/suns

	price_min = 1500
	price_max = 3500
	stock = 1
	availability_prob = 20

/datum/blackmarket_item/weapon/emp_grenade
	name = "EMP Grenade"
	desc = "Use this grenade for SHOCKING results!"
	item = /obj/item/grenade/empgrenade

	price_min = 100
	price_max = 400
	stock_max = 2
	availability_prob = 50

/datum/blackmarket_item/weapon/derringer
	name = "Derringer"
	desc = "A concealable handgun small enough to hide nearly anywhere. Uses .38 revolver rounds."
	item = /obj/item/gun/ballistic/derringer
	price_min = 100
	price_max = 500
	stock_max = 6
	availability_prob = 50

/datum/blackmarket_item/weapon/derringer
	name = "Golden Derringer"
	desc = "A rare custom-made concealable weapon designed to fire illegal .357 rounds."
	item = /obj/item/gun/ballistic/derringer/gold
	price_min = 1000
	price_max = 3000
	stock_max = 1
	availability_prob = 10

/datum/blackmarket_item/weapon/himehabu
	name = "Himehabu Pistol"
	desc = "Great things come in small packages. The Himehabu is perfect for all your espionage needs. Chambered in .22lr."
	item = /obj/item/gun/ballistic/automatic/pistol/himehabu
	pair_item = /datum/blackmarket_item/weapon/himehabu_mag

	price_min = 100
	price_max = 600
	stock_max = 6
	availability_prob = 40

/datum/blackmarket_item/weapon/himehabu_mag
	name = "Himehabu Magazines"
	desc = "Compact .22lr magazines for use in the Himehabu pistol."
	item = /obj/item/ammo_box/magazine/m22lr

	price_min = 100
	price_max = 200
	stock_max = 6
	availability_prob = 0

/datum/blackmarket_item/weapon/e10
	name = "E-10 Laser Pistol"
	desc = "Sharplite letting you down? Try these classic Eoehoma Firearms E-10 Laser Pistols."
	item = /obj/item/gun/energy/laser/e10

	price_min = 500
	price_max = 1250
	stock_max = 5
	availability_prob = 20

/datum/blackmarket_item/weapon/e11
	name = "E-11 Energy Gun"
	desc = "Look. I'll be straight with you. These guns are awful. But, they are cheap if you're that desperate."
	item = /obj/item/gun/energy/e_gun/e11

	price_min = 250
	price_max = 750
	stock = 5
	availability_prob = 40

/datum/blackmarket_item/weapon/e40
	name = "E-40 Hybrid Assault Rifle"
	desc = "A dual mode hybrid assault rifle made by the now defunct Eoehoma Firearms. Capable of firing both bullets AND lasers, for the discerning dealer in death. Chambered in Eoehoma .299 Caseless."
	item = /obj/item/gun/ballistic/automatic/assault/e40
	pair_item = /datum/blackmarket_item/weapon/e40_mag

	price_min = 7000
	price_max = 13000
	stock = 1
	availability_prob = 20

/datum/blackmarket_item/weapon/e40_mag
	name = "Eoehoma .299 Caseless Magazine"
	desc = "30 round magazines for the E-40 Hybrid Rifle."
	item = /obj/item/ammo_box/magazine/e40

	price_min = 750
	price_max = 1250
	stock_max = 3
	availability_prob = 0

/datum/blackmarket_item/weapon/e50
	name = "E-50 Energy Emitter"
	desc = "An Eoehoma Firearms E-50 Emitter cannon. For when you want a send a message. A really big message."
	item = /obj/item/gun/energy/laser/e50

	price_min = 4000
	price_max = 7000
	stock_max = 2
	availability_prob = 20

/datum/blackmarket_item/weapon/corrupt_gun_cell
	name = "Damaged Weapon Cell"
	desc = "These got a bit dinged up in their crate after a close shave with GOLD inspectors. The cells are probably still safe to use though."
	item = /obj/item/stock_parts/cell/gun/corrupt

	price_min = 250
	price_max = 500
	stock_min = 4
	stock_max = 10
	availability_prob = 40

/datum/blackmarket_item/weapon/saber_smg
	name = "Saber 9mm SMG"
	desc = "A prototype 9mm submachine gun. Most of these never got past the RND phase into distribution. But we happen know a guy."
	item = /obj/item/gun/ballistic/automatic/smg/proto
	pair_item = /datum/blackmarket_item/weapon/saber_mag

	price_min = 2500
	price_max = 4200
	stock_max = 2
	availability_prob = 20

/datum/blackmarket_item/weapon/saber_mag
	name = "Saber 9mm SMG Magazines"
	desc = "Magazines for use in the Saber 9mm SMG. No, they don't work as swords."
	item = /obj/item/ammo_box/magazine/smgm9mm

	price_min = 500
	price_max = 1000
	stock_max = 2
	availability_prob = 0

/datum/blackmarket_item/weapon/bg_16
	name = "BG-16 Beam Gun"
	desc = "Not satisfied by Etherbor's civilian offerings? Try this military grade one we found!"
	item = /obj/item/gun/energy/kalix/pgf

	price_min = 2500
	price_max = 5000
	stock = 1
	availability_prob = 20

/datum/blackmarket_item/weapon/bioterror_foam
	name = "Bioterror Foam Sprayer"
	desc = "Banned in at least 17 jurisdictions for being 'cruel', 'inhumane', and 'causing indiscriminate lifelong generational health complications'. Though if you actually cared about those things, you wouldn't be shopping here in the first place."
	item = /obj/item/reagent_containers/spray/chemsprayer/bioterror

	price_min = 3000
	price_max = 6000
	stock = 1
	availability_prob = 20

/datum/blackmarket_item/weapon/sawn_illestren
	name = "Sawn off Illestren Rifle"
	desc = "We had to saw down the barrels on these to fit them in the smuggling compartment. They don't aim too good, but it still packs a good punch."
	item = /obj/item/gun/ballistic/rifle/illestren/sawoff

	price_min = 600
	price_max = 1250
	stock_min = 2
	stock_max = 5
	availability_prob = 50




