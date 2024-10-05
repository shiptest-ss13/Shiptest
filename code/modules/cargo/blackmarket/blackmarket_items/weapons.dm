/datum/blackmarket_item/weapon
	category = "Weapons"

/datum/blackmarket_item/weapon/bear_trap
	name = "Bear Trap"
	desc = "Get the janitor back at his own game with this affordable prank kit."
	item = /obj/item/restraints/legcuffs/beartrap

	price_min = 150
	price_max = 400
	stock_min = 3
	stock_max = 7
	availability_prob = 40

/datum/blackmarket_item/weapon/bone_spear
	name = "Bone Spear"
	desc = "Authentic tribal spear, made from real bones! A steal at any price, especially if you're a caveman."
	item = /obj/item/melee/spear/bone

	price_min = 200
	price_max = 300
	stock_max = 3
	availability_prob = 60

/datum/blackmarket_item/weapon/switchblade
	name = "Switchblade"
	desc = "Extra shrap switchblades for intimidation AND style. Bandages not included if you cut yourself."
	item = /obj/item/melee/knife/switchblade

	price_min = 500
	price_max = 700
	stock_max = 3
	availability_prob = 50

/datum/blackmarket_item/weapon/powerfist
	name = "Powerfist"
	desc = "Need a bit more... omph in your right hook? This gas operated powerfist will put you in the heavyweight."
	item = /obj/item/melee/powerfist
	price_min = 1500
	price_max = 4000
	stock_max = 2
	availability_prob = 50

/datum/blackmarket_item/weapon/sabre
	name = "SUNS Dueling Sabre"
	desc = "A mastercrafted sabre formerly wielded by a SUNS academic. It's very sharp, we had to spend hours stitching our fingers back on after getting it."
	item = /obj/item/storage/belt/sabre/suns

	price_min = 1500
	price_max = 3500
	stock = 1
	availability_prob = 25

/datum/blackmarket_item/weapon/mag_cleaver
	name = "Magnetic Cleaver"
	desc = "A prototype modification to the standard crusher, featuring an energy blade rather than the standard alloy cutting edge allowing for much more devasting detonations. The guy who sold this to us disappeared the next week, but that's probably a coincidence."
	item = /obj/item/kinetic_crusher/syndie_crusher

	price_min = 1750
	price_max = 3000
	stock = 2
	availability_prob = 15
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/derringer
	name = "Derringer"
	desc = "A concealable handgun small enough to hide nearly anywhere. Uses .38 revolver rounds."
	item = /obj/item/gun/ballistic/derringer

	price_min = 100
	price_max = 300
	stock_max = 6
	availability_prob = 50

/datum/blackmarket_item/weapon/syndi_derringer
	name = ".357 Derringer"
	desc = "A concealable hangun with a tasteful red and black paintjob, which makes it slightly more noticable. Chambered in .357, so you actually have a chance at killing something."
	item = /obj/item/gun/ballistic/derringer/traitor
	pair_item = list(/datum/blackmarket_item/ammo/a357_box)

	price_min = 300
	price_max = 800
	stock = 2
	availability_prob = 30

/datum/blackmarket_item/weapon/disposable_gun_disk
	name = "Disposable Gun Design Disk"
	desc = "An autolathe compatible fabrication disk for printing disposable guns chambered in .22 LR. Improper disposal or recycling of these guns is an enviromental felony misdemeanor in Solarian space. Luckily, we aren't in Solarian space, so litter all you want."
	item = /obj/item/disk/design_disk/disposable_gun

	price_min = 1500
	price_max = 2500
	stock = 1
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/himehabu
	name = "Himehabu Pistol"
	desc = "Great things come in small packages. The Himehabu is perfect for all your espionage needs. Chambered in .22lr."
	item = /obj/item/gun/ballistic/automatic/pistol/himehabu
	pair_item = list(/datum/blackmarket_item/ammo/himehabu_mag, /datum/blackmarket_item/ammo/himehabu_box)

	price_min = 100
	price_max = 600
	stock_max = 6
	availability_prob = 50

/datum/blackmarket_item/weapon/e10
	name = "E-10 Laser Pistol"
	desc = "Sharplite letting you down? Try these classic Eoehoma Firearms E-10 Laser Pistols."
	item = /obj/item/gun/energy/laser/e10

	price_min = 500
	price_max = 1000
	stock_max = 5
	availability_prob = 20

/datum/blackmarket_item/weapon/e11
	name = "E-11 Energy Gun"
	desc = "Look. I'll be straight with you. These guns are awful. But, they are cheap if you're that desperate."
	item = /obj/item/gun/energy/e_gun/e11

	price_min = 250
	price_max = 750
	stock = 5
	availability_prob = 60

/datum/blackmarket_item/weapon/e40
	name = "E-40 Hybrid Assault Rifle"
	desc = "A dual mode hybrid assault rifle made by the now defunct Eoehoma Firearms. Capable of firing both bullets AND lasers, for the discerning dealer in death. Chambered in Eoehoma .299 Caseless."
	item = /obj/item/gun/ballistic/automatic/assault/e40
	pair_item = list(/datum/blackmarket_item/ammo/e40_mag, /datum/blackmarket_item/ammo/c299)

	price_min = 7000
	price_max = 10000
	stock_max = 2
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/e50
	name = "E-50 Energy Emitter"
	desc = "An Eoehoma Firearms E-50 Emitter cannon. For when you want a send a message. A really big message."
	item = /obj/item/gun/energy/laser/e50
	pair_item = (/datum/blackmarket_item/ammo/huge_weapon_cell)

	price_min = 4000
	price_max = 7000
	stock_max = 2
	availability_prob = 20
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/e60
	name = "E-60 Disabler"
	desc = "Looking for a live capture? This Eoehoma Firearms E-60 disabler will get your man."
	item = /obj/item/gun/energy/disabler/e60

	price_min = 500
	price_max = 750
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/weapon/saber_smg
	name = "Saber 9mm SMG"
	desc = "A prototype 9mm submachine gun. Most of these never got past the RND phase and into distribution. But we happen know a guy."
	item = /obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq/proto
	pair_item = list(/datum/blackmarket_item/ammo/saber_mag)

	price_min = 2250
	price_max = 3750
	stock_max = 2
	availability_prob = 25

/datum/blackmarket_item/weapon/bg_16
	name = "BG-16 Beam Gun"
	desc = "Not satisfied by Etherbor's civilian offerings? Try this military grade one we found!"
	item = /obj/item/gun/energy/kalix/pgf

	price_min = 2500
	price_max = 5000
	stock = 2
	availability_prob = 20

/datum/blackmarket_item/weapon/sawn_illestren
	name = "Sawn off Illestren Rifle"
	desc = "We had to saw down the barrels on these to fit them in the smuggling compartment. They don't aim too good, but it still packs a good punch."
	item = /obj/item/gun/ballistic/rifle/illestren/sawn

	price_min = 600
	price_max = 1000
	stock_min = 2
	stock_max = 5
	availability_prob = 60

/datum/blackmarket_item/weapon/combat_shotgun
	name = "Combat Shotgun"
	desc = "Are your arms tired from pumping Hunter's Pride shotguns? This semi-automatic combat shotgun will make killing a breeze."
	item = /obj/item/gun/ballistic/shotgun/automatic/combat

	price_min = 1750
	price_max = 3500
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/weapon/mecha_weapon_bay
	name = "Concealed Weapons Bay"
	desc = "Ripley with a laser cannon? Odysseus with a missile rack? Sky's the limit with this omni-compatible weapons bay! (Missiles and lasers not included)"
	item = /obj/item/mecha_parts/concealed_weapon_bay

	price_min = 1000
	price_max = 2000
	stock_max = 3
	availability_prob = 20
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/mecha_syringe_gun
	name = "Mounted Syringe Gun"
	desc = "We ripped this off an old Nanotrasen exosuit. It's a real advanced piece of equipment. Exosuit not included."
	item = /obj/item/mecha_parts/mecha_equipment/medical/syringe_gun

	price_min = 5000
	price_max = 7000
	stock = 1
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/mecha_hades
	name = "Mounted FNX-99 Carbine"
	desc = "This so called \"Phoenix\" carbine is sure to burn brightly above the competition! Exosuit not included."
	item = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/carbine
	pair_item = list(/datum/blackmarket_item/ammo/mecha_hades_ammo)

	price_min = 2000
	price_max = 3000
	stock_max = 2
	availability_prob = 25

/datum/blackmarket_item/weapon/model_h
	name = "Model H"
	desc = "A Model H slug pistol. The H stands for Hurt. Chambered in ferromagnetic slugs."
	item = /obj/item/gun/ballistic/automatic/powered/gauss/modelh
	pair_item = list(/datum/blackmarket_item/ammo/model_h_mag)

	price_min = 2000
	price_max = 3500
	stock = 2
	availability_prob = 35

/datum/blackmarket_item/weapon/model_h/spawn_item(loc)
	var/model_h = pick(list(/obj/item/gun/ballistic/automatic/powered/gauss/modelh/suns,
				/obj/item/gun/ballistic/automatic/powered/gauss/modelh))
	return new model_h(loc)

/datum/blackmarket_item/weapon/sgg
	name = "SSG-669C Rotary Sniper Rifle"
	desc = "I could tell you it's full name, but we'd be here all day. It's a sniper rifle. It shoots people from far away. Chambered in 8x58mm caseless."
	item = /obj/item/gun/ballistic/rifle/solgov
	pair_item = list(/datum/blackmarket_item/ammo/sgg_stripper)

	price_min = 3000
	price_max = 6000
	stock = 1
	availability_prob = 20

/datum/blackmarket_item/weapon/pistole_c
	name = "Pistole C"
	desc = "Pistole Compact? Pistole Caseless? Pistole Cheese? Fuck if I know. All I know is these little numbers pack a nasty sting. Chambered in 5.56 caseless."
	item = /obj/item/gun/ballistic/automatic/pistol/solgov/old
	pair_item = list(/datum/blackmarket_item/ammo/pistole_c_mag)

	price_min = 900
	price_max = 1250
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/weapon/proto_gauss
	name = "Prototype Gauss Rifle"
	desc = "A prototype gauss rifle made by Nanotrasen. Perfect for making swiss cheese out of people. Chambered in ferromagnetic pellets."
	item = /obj/item/gun/ballistic/automatic/powered/gauss
	pair_item = list(/datum/blackmarket_item/ammo/proto_gauss_mag)

	price_min = 2500
	price_max = 4000
	stock = 2
	availability_prob = 25

/datum/blackmarket_item/weapon/syringe_gun
	name = "Dart Pistol"
	desc = "A compact dart pistol, for clandestine poisoining from a distance."
	item = /obj/item/gun/syringe/syndicate

	price_min = 750
	price_max = 1500
	stock = 2
	availability_prob = 30

/datum/blackmarket_item/weapon/mauler
	name = "Mauler Machine Pistol"
	desc = "This gun's got teeth! Twelve 9mm teeth to be exact. Hardly a full smile, and you'll be losing the rest pretty quick with this thing's rate of fire."
	item = /obj/item/gun/ballistic/automatic/pistol/mauler
	pair_item = list(/datum/blackmarket_item/ammo/mauler_mag)

	price_min = 1000
	price_max = 2000
	stock_max = 3
	availability_prob = 50

/datum/blackmarket_item/weapon/spitter
	name = "Spitter Submachine Gun"
	desc = "The aptly named Spitter won't be hitting anything outside of spitting distance. Anything in that range on the otherhand? Let's just say the bereaved will be wanting a closed casket funeral. Chambered in 9mm."
	item = /obj/item/gun/ballistic/automatic/pistol/spitter
	pair_item = list(/datum/blackmarket_item/ammo/spitter_mag)

	price_min = 1500
	price_max = 2250
	stock_min = 1
	stock_max = 2
	availability_prob = 30

/datum/blackmarket_item/weapon/pounder
	name = "Pounder Submachine Gun"
	desc = "There's a certain quality to quantity. With a massive 50 round capacity, this .22lr submachine is capable of laying down an jawdropping amount of fire."
	item = /obj/item/gun/ballistic/automatic/smg/pounder
	pair_item = list(/datum/blackmarket_item/ammo/pounder_mag,/datum/blackmarket_item/ammo/himehabu_box)

	price_min = 1500
	price_max = 2000
	stock = 1
	availability_prob = 35

/datum/blackmarket_item/weapon/polymer
	name = "Polymer Survivor Rifle"
	desc = "A slapdash rifle held together by spite, dreams and a good helping of duct tape. Chambered in 7.62x40mm CLIP."
	item = /obj/item/gun/ballistic/rifle/polymer
	pair_item = list(/datum/blackmarket_item/ammo/polymer_clip)

	price_min = 600
	price_max = 1250
	stock_min = 2
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/weapon/skm_carbine
	name = "SKM-24v Carbine"
	desc = "Technically this is just a sawn down SKM-24 assault rifle, but what's CLIP going to do? Sue us? Chambered in 4.6x30mm."
	item = /obj/item/gun/ballistic/automatic/smg/skm_carbine
	pair_item = list(/datum/blackmarket_item/ammo/carbine_mag)

	price_min = 3000
	price_max = 4500
	stock_max = 2
	availability_prob = 20

/datum/blackmarket_item/weapon/fireaxe
	name = "Fire Axe"
	desc = "An incredibly sharp axe of dubious make used by various engineers throughout the years to settle arguments while hammered. Sold to us by a very friendly man in a suit."
	item = /obj/item/melee/axe/fire

	price_min = 2500
	price_max = 3500
	stock = 2
	availability_prob = 40

/datum/blackmarket_item/weapon/oneshot
	name = "Hammer Launcher"
	desc = "A one-shot solution to a myriad amount of problems, ranging from Exosuits to obnoxious neighbors. Contains one ready-to-fire 84mm HEDP rocket. "
	item = /obj/item/gun/ballistic/rocketlauncher/oneshot

	price_min = 3000
	price_max = 4500
	stock_min = 1
	stock_max = 5
	availability_prob = 25
