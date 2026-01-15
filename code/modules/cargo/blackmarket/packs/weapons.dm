/datum/blackmarket_item/weapon
	category = "Weapons"

/datum/blackmarket_item/weapon/bear_trap
	name = "Bear Trap"
	desc = "A pressure activated solid steel bear trap. Good for both bears, and the most dangerous game."
	item = /obj/item/restraints/legcuffs/beartrap

	cost_min = 100
	cost_max = 300
	stock_min = 3
	stock_max = 7
	availability_prob = 40

/datum/blackmarket_item/weapon/switchblade
	name = "Switchblade"
	desc = "Extra shrap switchblades for intimidation AND style. Bandages not included if you cut yourself."
	item = /obj/item/melee/knife/switchblade

	cost_min = 250
	cost_max = 500
	stock_max = 3
	availability_prob = 50

/datum/blackmarket_item/weapon/fireaxe
	name = "Fire Axe"
	desc = "An incredibly sharp axe of reputable make, used by various engineers to settle arguments while hammered. Sold to us by a very friendly man in a suit."
	item = /obj/item/melee/axe/fire

	cost_min = 750
	cost_max = 1250
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/weapon/boarding_axe
	name = "Boarding Axe"
	desc = "Boughta stash of these demolition axes offa pretty lady comin from Lanchester. Cute tattoos. Handed em over for some food anna ride to Trifuge. Poor soul. Things hack through metal as easy as flesh, though."
	item = /obj/item/melee/boarding_axe

	cost_min = 1000
	cost_max = 1750
	stock_max = 2
	availability_prob = 40

/datum/blackmarket_item/weapon/sledgehammer
	name = "Breaching Sledgehammer"
	desc = "A Clique outfit had to ditch a lot of equipment to evade a Gezenan assault. This little piece breaks legs and walls like no other. You want in?"
	item = /obj/item/melee/sledgehammer/gorlex

	cost_min = 2000
	cost_max = 3000
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/weapon/blastinghammer
	name = "Blasting Hammer"
	desc = "Have you ever thought: \"Man, my 20 pound sledgehammer isn't crushing skulls well enough.\" No? Well, our friends in the Ramzi Clique have solved this issue anyways and made it everyone else's problem. This baby loads 12g blanks as propollent to really make that swing a home run. Just don't put a live shell in, yeah?"
	item = /obj/item/storage/backpack/duffelbag/syndie

	cost_min = 4000
	cost_max = 6000
	stock = 1
	availability_prob = 15
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/blastinghammer/spawn_item(loc)
	var/obj/item/storage/backpack/duffelbag/syndie/B = ..()
	new /obj/item/gun/ballistic/shotgun/blasting_hammer(B)
	new /obj/item/storage/box/ammo/a12g_blank(B)
	return B
/datum/blackmarket_item/weapon/spikeshield
	name = "Spiked Ballistic Shield"
	desc = "Be the ancient warrior you always wanted to be. Block bullets and impale your enemies."
	item = /obj/item/shield/riot/spike

	cost_min = 1000
	cost_max = 1500
	stock_max = 2
	availability_prob = 50

/datum/blackmarket_item/weapon/powerfist
	name = "Powerfist"
	desc = "Lookin to give a fisting someone'll remember? This electrically assisted powerfist'll slam em in the face hard enough they won't ever forget. Unless they black out an' forget it."
	item = /obj/item/melee/powerfist
	cost_min = 1000
	cost_max = 3000
	stock_max = 2
	availability_prob = 50

/datum/blackmarket_item/weapon/cutlass
	name = "Gezenan Boarding Cutlass"
	desc = "A mass produced fighting blade fresh from the belt of some poor sailor. It's got some mean weight to it."
	item = /obj/item/storage/belt/sabre/pgf

	cost_min = 1000
	cost_max = 1750
	stock = 1
	availability_prob = 25

/datum/blackmarket_item/weapon/sabre
	name = "SUNS Dueling Sabre"
	desc = "A mastercrafted sabre formerly wielded by a SUNS academic. It's very sharp, we had to spend hours stitching our fingers back on after getting it."
	item = /obj/item/storage/belt/sabre/suns

	cost_min = 1250
	cost_max = 2000
	stock = 1
	availability_prob = 25

/datum/blackmarket_item/weapon/mag_cleaver
	name = "Magnetic Cleaver"
	desc = "A prototype modification to the standard crusher, featuring an energy blade rather than the standard alloy cutting edge allowing for much more devasting detonations. The guy who sold this to us disappeared the next week, but that's probably a coincidence."
	item = /obj/item/kinetic_crusher/syndie_crusher

	cost_min = 1500
	cost_max = 2500
	stock = 2
	availability_prob = 15
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/disposable_gun_disk
	name = "Disposable Gun Design Disk"
	desc = "An autolathe compatible fabrication disk for printing disposable guns chambered in .22 LR. Improper disposal or recycling of these guns is an enviromental felony misdemeanor in Solarian space. Luckily, we aren't in Solarian space, so litter all you want."
	item = /obj/item/disk/design_disk/disposable_gun

	cost_min = 1000
	cost_max = 2000
	stock = 1
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/chlorine_gas
	name = "Chlorine Gas Canister"
	desc = "Ever get poolwater in your eyes? It's like that, except a million times worse."
	item = /obj/machinery/portable_atmospherics/canister/chlorine

	cost_min = 1000
	cost_max = 2000
	stock_max = 3
	availability_prob = 30

/// for guns that should spawn in guncases
/datum/blackmarket_item/weapon/guncase
	name = "Guncase"
	desc = "You shouldn't be seeing this. If you want to waste your money, go ahead and buy it. No refunds."
	item = /obj/item/gun // should be a subtype of gun
	var/gun_unloaded = TRUE
	var/mag_type // should be automatically set by spawn_item(), set this if you want to override it or if the gun uses speedloaders.
	var/mag_number = 2
	var/magazine_unloaded = FALSE
	cost = 10000
	availability_prob = 0

/datum/blackmarket_item/weapon/guncase/spawn_item(loc)
	var/obj/item/storage/guncase/case = new /obj/item/storage/guncase(loc)
	new item(case,gun_unloaded)
	if(mag_number > 0)
		if(!mag_type)
			var/obj/item/gun/case_gun = item
			if(case_gun.default_ammo_type && !(case_gun.internal_cell || case_gun.internal_magazine))
				mag_type = case_gun.default_ammo_type
			else
				mag_number = 0
		for(var/i in 1 to mag_number)
			new mag_type(case,magazine_unloaded)
	return case

/datum/blackmarket_item/weapon/guncase/himehabu
	name = "Himehabu Pistol"
	desc = "Great things come in small packages. The Himehabu is perfect for all your espionage needs. Chambered in .22lr."
	item = /obj/item/gun/ballistic/automatic/pistol/himehabu
	pair_item = list(/datum/blackmarket_item/ammo/himehabu_mag)

	cost_min = 100
	cost_max = 600
	stock_max = 6
	availability_prob = 50

/datum/blackmarket_item/weapon/guncase/derringer
	name = "Derringer"
	desc = "A concealable handgun small enough to hide nearly anywhere. Uses .38 revolver rounds."
	item = /obj/item/gun/ballistic/derringer
	gun_unloaded = FALSE
	mag_number = 0

	cost_min = 100
	cost_max = 300
	stock_max = 6
	availability_prob = 50

/datum/blackmarket_item/weapon/guncase/syndi_derringer
	name = ".357 Derringer"
	desc = "A concealable hangun with a tasteful red and black paintjob, which makes it slightly more noticable. Chambered in .357, so you actually have a chance at killing something."
	item = /obj/item/gun/ballistic/derringer/traitor
	pair_item = list(/datum/blackmarket_item/ammo/a357_box)
	gun_unloaded = FALSE
	mag_number = 0

	cost_min = 300
	cost_max = 800
	stock = 2
	availability_prob = 30

/datum/blackmarket_item/weapon/guncase/e10
	name = "E-10 Laser Pistol"
	desc = "Sharplite letting you down? Try these classic Eoehoma Firearms E-10 Laser Pistols."
	item = /obj/item/gun/energy/laser/e10

	cost_min = 500
	cost_max = 1000
	stock_max = 5
	availability_prob = 20

/datum/blackmarket_item/weapon/guncase/e11
	name = "E-11 Energy Gun"
	desc = "Look. I'll be straight with you. These guns are awful. But, they are cheap if you're that desperate."
	item = /obj/item/gun/energy/e_gun/e11

	cost_min = 200
	cost_max = 400
	stock = 5
	availability_prob = 60

/datum/blackmarket_item/weapon/guncase/e40
	name = "E-40 Hybrid Assault Rifle"
	desc = "A dual mode hybrid assault rifle made by the now defunct Eoehoma Firearms. Capable of firing both bullets AND lasers, for the discerning dealer in death. Chambered in Eoehoma .299 Caseless."
	item = /obj/item/gun/ballistic/automatic/assault/e40
	pair_item = list(/datum/blackmarket_item/ammo/e40_mag)

	cost_min = 7000
	cost_max = 10000
	stock_max = 2
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/guncase/e50
	name = "E-50 Energy Emitter"
	desc = "An Eoehoma Firearms E-50 Emitter cannon. For when you want a send a message. A really big message."
	item = /obj/item/gun/energy/laser/e50
	pair_item = list(/datum/blackmarket_item/ammo/huge_weapon_cell)

	cost_min = 4000
	cost_max = 7000
	stock_max = 2
	availability_prob = 20
	spawn_weighting = FALSE

/*
/datum/blackmarket_item/weapon/guncase/e50_underbarrel
	name = "Underbarrel Energy Cannon"
	desc = "The normal E-50 too big to handle for you? This underbarrel conversion cuts it down to a managable size with only a <i>minor</i> chance of painfully burning your hands."
	item = /obj/item/attachment/gun/energy/e50
	mag_type = /obj/item/stock_parts/cell/gun

	cost_min = 4000
	cost_max = 5000
	stock_max = 2
	availability_prob = 20
	spawn_weighting = FALSE
*/

/datum/blackmarket_item/weapon/guncase/e60
	name = "E-60 Disabler"
	desc = "Looking for a live capture? This Eoehoma Firearms E-60 disabler will get your man."
	item = /obj/item/gun/energy/disabler/e60

	cost_min = 500
	cost_max = 750
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/weapon/guncase/cm23
	name = "CM-23 pistol"
	desc = "The service pistol of the Confederated League. Chambered in 10x22mm and fresh off a crashed clipper. We made sure to scratch the ID off this time."

	item = /obj/item/gun/ballistic/automatic/pistol/cm23
	pair_item = list(/datum/blackmarket_item/ammo/cm23_mag)
	cost_min = 500
	cost_max = 1500
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/weapon/guncase/cm70
	name = "CM-70 Machine Pistol"
	desc = "One slick piece from the Confederated League. Chambered in 9x18mm. That officer wasn't happy to lose this but you should be safe."

	item = /obj/item/gun/ballistic/automatic/pistol/cm70
	pair_item = list(/datum/blackmarket_item/ammo/cm70_mag)
	cost_min = 900
	cost_max = 2100
	stock_max = 2
	availability_prob = 50

/datum/blackmarket_item/weapon/guncase/cm5
	name = "CM-5 SMG"
	desc = "Now isn't this a good find. A whole League sub-machinegun, chambered in 9x18mm. We're pretty sure no one is gonna notice the pallet of these missing."

	item = /obj/item/gun/ballistic/automatic/smg/cm5
	pair_item = list(/datum/blackmarket_item/ammo/cm5_mag)
	cost_min = 1750
	cost_max = 3500
	stock_max = 2
	availability_prob = 30

/datum/blackmarket_item/weapon/guncase/vga5
	name = "VG-A5 Beam Gun"
	desc = "So you've seen those quad burst Etherbor Volleyguns? Well this thing has a quintuple burst! That means five!"
	item = /obj/item/gun/energy/kalix/pgf/nock

	cost_min = 3500
	cost_max = 5000
	stock = 2
	availability_prob = 20

/datum/blackmarket_item/weapon/guncase/bg_16
	name = "BG-16 Beam Gun"
	desc = "Not satisfied by Etherbor's civilian offerings? Try this military grade one we found!"
	item = /obj/item/gun/energy/kalix/pgf

	cost_min = 2500
	cost_max = 5000
	stock = 2
	availability_prob = 20

/datum/blackmarket_item/weapon/guncase/larker
	name = "Model 13 \"Larker\""
	desc = "Gotta deal for you broski. We got this mod of those shoddy Sporter Rifles an' you can buy one, or two, orreven three if yer int' that."
	item = /obj/item/storage/guncase/m13

	cost_min = 500
	cost_max = 1200
	stock_min = 3
	stock_max = 5
	availability_prob = 40

/datum/blackmarket_item/weapon/guncase/sawn_illestren
	name = "Sawn off Illestren Rifle"
	desc = "We had to saw down the barrels on these to fit them in the smuggling compartment. They don't aim too good, but it still packs a good punch."
	item = /obj/item/gun/ballistic/rifle/illestren/sawn

	cost_min = 600
	cost_max = 1000
	stock_min = 2
	stock_max = 5
	availability_prob = 60

/datum/blackmarket_item/weapon/guncase/model_h
	name = "Model H"
	desc = "A Model H slug pistol. The H stands for Hurt. Chambered in ferromagnetic slugs."
	item = /obj/item/gun/ballistic/automatic/powered/gauss/modelh
	pair_item = list(/datum/blackmarket_item/ammo/model_h_mag, /datum/blackmarket_item/ammo/gauss_cell)

	cost_min = 2000
	cost_max = 3500
	stock = 2
	availability_prob = 100

/datum/blackmarket_item/weapon/guncase/model_h/spawn_item(loc)
	var/model_h = pick(list(/obj/item/gun/ballistic/automatic/powered/gauss/modelh/suns,
				/obj/item/gun/ballistic/automatic/powered/gauss/modelh))
	item = model_h
	return ..()

/datum/blackmarket_item/weapon/guncase/sgg
	name = "SSG-669C Rotary Sniper Rifle"
	desc = "I could tell you it's full name, but we'd be here all day. It's a sniper rifle. It shoots people from far away. Chambered in 8x58mm caseless."
	item = /obj/item/gun/ballistic/rifle/solgov
	mag_type = /obj/item/ammo_box/a858
	pair_item = list(/datum/blackmarket_item/ammo/a858_box)

	cost_min = 3000
	cost_max = 6000
	stock = 1
	availability_prob = 20

/datum/blackmarket_item/weapon/guncase/pistole_c
	name = "Pistole C"
	desc = "Pistole Compact? Pistole Caseless? Pistole Cheese? Fuck if I know. All I know is these little numbers pack a nasty sting. Chambered in 5.56 caseless."
	item = /obj/item/gun/ballistic/automatic/pistol/solgov/old
	pair_item = list(/datum/blackmarket_item/ammo/pistole_c_mag)

	cost_min = 900
	cost_max = 1600
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/weapon/guncase/cycler
	name = "Cycler Shotgun"
	desc = "Perpetuate the cycle of violence with this dual feed shotgun! Has two built in 4 shell magazine tubes that can be swapped at the press of a button!"
	item = /obj/item/gun/ballistic/shotgun/automatic/negotiator
	gun_unloaded = FALSE
	mag_number = 0

	cost_min = 2500
	cost_max = 4000
	stock = 2
	availability_prob = 25

/datum/blackmarket_item/weapon/guncase/syringe_gun
	name = "Dart Pistol"
	desc = "A compact dart pistol, for clandestine poisoining from a distance."
	item = /obj/item/gun/syringe/syndicate

	cost_min = 750
	cost_max = 1500
	stock = 2
	availability_prob = 30

/datum/blackmarket_item/weapon/guncase/mauler
	name = "Mauler Machine Pistol"
	desc = "This gun's got teeth! Twelve 9mm teeth to be exact. Hardly a full smile, and you'll be losing the rest pretty quick with this thing's rate of fire."
	item = /obj/item/gun/ballistic/automatic/pistol/mauler
	pair_item = list(/datum/blackmarket_item/ammo/mauler_mag)

	cost_min = 500
	cost_max = 1500
	stock_max = 3
	availability_prob = 50

/datum/blackmarket_item/weapon/guncase/mauler/semi
	name = "Mauler Semi-Automatic"
	desc = "Enjoy the Mauler, but want to actually hit the broadside of a Vela? This semi-automatic conversion of the Mauler still features a better than average rate of fire and improved handling.."
	item = /obj/item/gun/ballistic/automatic/pistol/mauler/regular

	cost_min = 500
	cost_max = 1000
	stock_max = 3
	availability_prob = 50

/datum/blackmarket_item/weapon/guncase/spitter
	name = "Spitter Submachine Gun"
	desc = "The aptly named Spitter won't be hitting anything outside of spitting distance. Anything in that range on the otherhand? Let's just say the bereaved will be wanting a closed casket funeral. Chambered in 9x18mm."
	item = /obj/item/gun/ballistic/automatic/pistol/spitter
	pair_item = list(/datum/blackmarket_item/ammo/spitter_mag)

	cost_min = 1500
	cost_max = 2250
	stock_min = 1
	stock_max = 2
	availability_prob = 30

/datum/blackmarket_item/weapon/guncase/pounder
	name = "Pounder Submachine Gun"
	desc = "There's a certain quality to quantity. With a massive 50 round capacity, this .22lr submachine is capable of laying down an jawdropping amount of fire."
	item = /obj/item/gun/ballistic/automatic/smg/pounder
	pair_item = list(/datum/blackmarket_item/ammo/pounder_mag)

	cost_min = 1250
	cost_max = 2000
	stock = 1
	availability_prob = 35

/datum/blackmarket_item/weapon/guncase/cottonmouth
	name = "MP-84m Cottonmouth Machinepistol"
	desc = "Ramzi suppliers been rechambering a buncha Rattlesnakes into 10x22mm. Ol' nine ain't cutting it anymore. Kicks a liiiiiiittle bit worse aaaand it's just a two burst, but it'll suit ya well."
	item = /obj/item/gun/ballistic/automatic/pistol/rattlesnake/cottonmouth
	pair_item = list(/datum/blackmarket_item/ammo/cottonmouth)

	cost_min = 1500
	cost_max = 2250
	stock_min = 1
	stock_max = 2
	availability_prob = 30

/datum/blackmarket_item/weapon/guncase/f3
	name = "F3 Marksman Rifle"
	desc = "Let's bring it back old school. These vintage marksman rifles were the predecessor to the F4, but that doesn't make them any less deadly. After all, 3 is closer to number 1! Chambered in .308."
	item = /obj/item/gun/ballistic/automatic/marksman/f4/indie
	pair_item = list(/datum/blackmarket_item/ammo/f4_magazine)

	cost_min = 3100
	cost_max = 3900
	stock_max = 2
	availability_prob = 20
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/guncase/wasp
	name = "Wasp Laser SMG"
	desc = "Float like a butterfly, sting like a... well, a Wasp. A couple of our old E-40s finally gave the ghost, but we made lemonade and converted the laser modules into compact SMGs."
	item = /obj/item/gun/energy/laser/wasp

	cost_min = 1500
	cost_max = 2500
	stock_max = 2
	availability_prob = 25

/datum/blackmarket_item/weapon/guncase/polymer
	name = "Polymer Survivor Rifle"
	desc = "A slapdash rifle held together by spite, dreams and a good helping of duct tape. Chambered in 7.62x40mm CLIP."
	item = /obj/item/gun/ballistic/rifle/polymer
	mag_type = /obj/item/ammo_box/a762_stripper
	pair_item = list(/datum/blackmarket_item/ammo/a762_box)

	cost_min = 600
	cost_max = 1250
	stock_min = 2
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/weapon/guncase/skm_carbine
	name = "SKM-24v Carbine"
	desc = "Technically this is just a sawn down SKM-24 assault rifle, but what's CLIP going to do? Sue us? Chambered in 4.6x30mm."
	item = /obj/item/gun/ballistic/automatic/smg/skm_carbine
	pair_item = list(/datum/blackmarket_item/ammo/carbine_mag)

	cost_min = 2000
	cost_max = 3500
	stock_max = 2
	availability_prob = 20

/datum/blackmarket_item/weapon/guncase/skm_lmg
	name = "SKM-24u Light Machinegun"
	desc = "Your regular rifles not have enough oomph for you? This SKM-24 was converted with help from a 'liberated' CM-40 parts shipment into a light machinegun, ready to blow away whatever you point it at. Increased firerate makes it buck like a mule, so keep that bipod on the ground. Drums sold separately!"
	item = /obj/item/gun/ballistic/automatic/hmg/skm_lmg

	cost_min = 5000
	cost_max = 7000
	stock_max = 2
	availability_prob = 15
	spawn_weighting = FALSE

/// mecha equipment

/datum/blackmarket_item/weapon/mecha_syringe_gun
	name = "Mounted Syringe Gun"
	desc = "We ripped this off an old Cybersun exosuit. It's a real advanced piece of equipment. Exosuit not included."
	item = /obj/item/mecha_parts/mecha_equipment/medical/syringe_gun

	cost_min = 5000
	cost_max = 7000
	stock = 1
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/weapon/mecha_hades
	name = "Mounted FNX-99 Carbine"
	desc = "This so called \"Phoenix\" carbine is sure to burn brightly above the competition! Exosuit not included."
	item = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/carbine
	pair_item = list(/datum/blackmarket_item/ammo/mecha_hades_ammo)

	cost_min = 2000
	cost_max = 3000
	stock_max = 2
	availability_prob = 25

