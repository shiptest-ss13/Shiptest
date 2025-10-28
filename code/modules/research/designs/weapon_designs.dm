/////////////////////////////////////////
/////////////////Weapons/////////////////
/////////////////////////////////////////

/datum/design/c38/sec
	id = "sec_38"
	build_type = PROTOLATHE
	category = list("Ammo")

/datum/design/c38_trac
	name = "Speed Loader (.38 TRAC)"
	desc = "Designed to quickly reload revolvers. TRAC bullets embed a tracking implant within the target's body."
	id = "c38_trac"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 20000, /datum/material/silver = 5000, /datum/material/gold = 1000)
	build_path = /obj/item/ammo_box/c38/trac
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/c38_hotshot
	name = "Speed Loader (.38 Hearth)"
	desc = "Designed to quickly reload revolvers. Hot Shot bullets contain an incendiary payload."
	id = "c38_hotshot"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 20000, /datum/material/plasma = 5000)
	build_path = /obj/item/ammo_box/c38/hotshot
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/c38_iceblox
	name = "Speed Loader (.38 Chilled)"
	desc = "Designed to quickly reload revolvers. Iceblox bullets contain a cryogenic payload."
	id = "c38_iceblox"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 20000, /datum/material/plasma = 5000)
	build_path = /obj/item/ammo_box/c38/iceblox
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/rubbershot/sec
	id = "sec_rshot"
	build_type = PROTOLATHE
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/beanbag_slug/sec
	id = "sec_beanbag_slug"
	build_type = PROTOLATHE
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/shotgun_slug/sec
	id = "sec_slug"
	build_type = PROTOLATHE
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/shotgun_dart/sec
	id = "sec_dart"
	build_type = PROTOLATHE
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/incendiary_slug/sec
	id = "sec_Islug"
	build_type = PROTOLATHE
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/stunrevolver
	name = "Tesla Canon"
	desc = "A high-tech cannon that fires internal, reusable bolt cartridges in a revolving cylinder. The cartridges can be recharged using conventional rechargers"
	id = "stunrevolver"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 10000, /datum/material/silver = 10000)
	build_path = /obj/item/gun/energy/tesla_cannon
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_SCIENCE//this weapon is an active threat to the user, I think we can safely refile it under "experimental"

/datum/design/tele_shield
	name = "Telescopic Riot Shield"
	desc = "An advanced riot shield made of lightweight materials that collapses for easy storage."
	id = "tele_shield"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 4000, /datum/material/glass = 4000, /datum/material/silver = 300, /datum/material/titanium = 200)
	build_path = /obj/item/shield/riot/tele
	category = list("Weapons")

/datum/design/beamrifle
	name = "Beam Marksman Rifle"
	desc = "A powerful long ranged anti-material rifle that fires charged particle beams to obliterate targets."
	id = "beamrifle"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 5000, /datum/material/diamond = 5000, /datum/material/uranium = 8000, /datum/material/silver = 4500, /datum/material/gold = 5000)
	build_path = /obj/item/gun/energy/beam_rifle
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/decloner
	name = "Decloner"
	desc = "Your opponent will bubble into a messy pile of goop."
	id = "decloner"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 5000,/datum/material/uranium = 10000)
	reagents_list = list(/datum/reagent/toxin/mutagen = 40)
	build_path = /obj/item/gun/energy/decloner
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_MEDICAL

/datum/design/rapidsyringe
	name = "Rapid Syringe Gun"
	desc = "A gun that fires many syringes."
	id = "rapidsyringe"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 1000)
	build_path = /obj/item/gun/syringe/rapidsyringe
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL		//uwu

/datum/design/temp_gun
	name = "Temperature Gun"
	desc = "A gun that shoots temperature bullet energythings to change temperature."//Change it if you want
	id = "temp_gun"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 500, /datum/material/silver = 3000)
	build_path = /obj/item/gun/energy/temperature
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/flora_gun
	name = "Floral Somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells. Harmless to other organic life."
	id = "flora_gun"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/glass = 500)
	reagents_list = list(/datum/reagent/uranium/radium = 20)
	build_path = /obj/item/gun/energy/floragun
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/large_grenade
	name = "Large Grenade"
	desc = "A grenade that affects a larger area and use larger containers."
	id = "large_Grenade"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3000)
	build_path = /obj/item/grenade/chem_grenade/large
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/pyro_grenade
	name = "Pyro Grenade"
	desc = "An advanced grenade that is able to self ignite its mixture."
	id = "pyro_Grenade"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/plasma = 500)
	build_path = /obj/item/grenade/chem_grenade/pyro
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/cryo_grenade
	name = "Cryo Grenade"
	desc = "An advanced grenade that rapidly cools its contents upon detonation."
	id = "cryo_Grenade"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/silver = 500)
	build_path = /obj/item/grenade/chem_grenade/cryo
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/adv_grenade
	name = "Advanced Release Grenade"
	desc = "An advanced grenade that can be detonated several times, best used with a repeating igniter."
	id = "adv_Grenade"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 500)
	build_path = /obj/item/grenade/chem_grenade/adv_release
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/xray
	name = "X-ray Laser Gun"
	desc = "Not quite as menacing as it sounds"
	id = "xray_laser"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 5000, /datum/material/uranium = 4000, /datum/material/iron = 5000, /datum/material/titanium = 2000, /datum/material/bluespace = 2000)
	build_path = /obj/item/gun/energy/xray
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/ioncarbine
	name = "Ion Carbine"
	desc = "How to dismantle a cyborg : The gun."
	id = "ioncarbine"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 6000, /datum/material/iron = 8000, /datum/material/uranium = 2000)
	build_path = /obj/item/gun/energy/ionrifle/carbine
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/wormhole_projector
	name = "Bluespace Wormhole Projector"
	desc = "A projector that emits high density quantum-coupled bluespace beams."
	id = "wormholeprojector"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 2000, /datum/material/iron = 5000, /datum/material/diamond = 2000, /datum/material/bluespace = 3000, /datum/material/uranium = 1000)
	build_path = /obj/item/gun/energy/wormhole_projector
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

//WT550 Mags

/datum/design/mag_oldsmg
	name = "WT-550 Auto Gun Magazine (4.6x30mm)"
	desc = "A 20 round magazine for the out of date security WT-550 Auto Rifle"
	id = "mag_oldsmg"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/wt550m9
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/mag_oldsmg/ap_mag
	name = "WT-550 Auto Gun Armour Piercing Magazine (4.6x30mm AP)"
	desc = "A 20 round armour piercing magazine for the out of date security WT-550 Auto Rifle"
	id = "mag_oldsmg_ap"
	materials = list(/datum/material/iron = 6000, /datum/material/silver = 600)
	build_path = /obj/item/ammo_box/magazine/wt550m9/ap
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/commanderammo
	name = "Commander magazine (9x18mm)"
	desc = "A single stack magazine chambered in 9x18mm for Commander sidearms."
	id = "commanderammo"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/magazine/co9mm
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/ringneckammo
	name = "Ringneck magazine (10x22mm)"
	desc = "A single stack Ringneck magazine, designed to chamber 10x22mm and fit into Scarborough Arm's Ringneck series of sidearms."
	id = "ringneckammo"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/magazine/m10mm_ringneck
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/candorammo
	name = "Candor magazine (.45)"
	desc = "A single stack Candor magazine, faithfully designed to chamber .45 and fit into the popular Candor sidearms."
	id = "candorammo"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/magazine/m45
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/m9cammo
	name = "M9C magazine (5.56mm HITP caseless)"
	desc = "A double stack M9C magazine, designed to chamber 5.56mm HITP caseless and fit into SolGov's M9C sidearms."
	id = "m9cammo"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 18000)
	build_path = /obj/item/ammo_box/magazine/pistol556mm
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/buckshot_shell
	name = "Buckshot Shell"
	id = "buckshot_shell"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/shotgun/buckshot
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/c38
	name = "Ammo Box (.38 Special)"
	id = "c38"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000)
	build_path = /obj/item/storage/box/ammo/c38
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/c9mm
	name = "Ammo Box (9x18mm)"
	id = "c9mm"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000)
	build_path = /obj/item/storage/box/ammo/c9mm
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/c10mm
	name = "Ammo Box (10x22mm)"
	id = "c10mm"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000)
	build_path = /obj/item/storage/box/ammo/c10mm
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/c45
	name = "Ammo Box (.45)"
	id = "c45"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000)
	build_path = /obj/item/storage/box/ammo/c45
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/c556mmHITP
	name = "Ammo Box (5.56mm HITP caseless)"
	id = "c556mmHITP"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000)
	build_path = /obj/item/storage/box/ammo/c556mm
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/rubbershot9mm
	name = "Rubbershot 9mm ammo box"
	desc = "A box full of less-than-lethal 9mm ammunition."
	id = "rubbershot9mm"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/storage/box/ammo/c9mm_rubber
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/rubbershot10mm
	name = "Rubbershot 10x22mm ammo box"
	desc = "A box full of less-than-lethal 10x22mm ammunition."
	id = "rubbershot10mm"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/storage/box/ammo/c10mm_rubber
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/rubbershot45
	name = "Rubbershot .45 ammo box"
	desc = "A box full of less-than-lethal .45 ammunition."
	id = "rubbershot45"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/storage/box/ammo/c45_rubber
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/rubbershot556mmHITP
	name = "Rubbershot 5.56mm HITP caseless ammo box"
	desc = "A box full of less-than-lethal 5.56mm HITP ammunition."
	id = "rubbershot556mmHITP"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/storage/box/ammo/c556mm_rubber
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/ap9mm
	name = "AP 9x18mm ammo box"
	desc = "A box full of armor piercing 9mm ammunition."
	id = "ap9mm"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000, /datum/material/uranium = 1000)
	build_path = /obj/item/storage/box/ammo/c9mm_ap
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/ap10mm
	name = "AP 10x22mm ammo box"
	desc = "A box full of armor piercing 10x22mm ammunition."
	id = "ap10mm"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000, /datum/material/uranium = 1000)
	build_path = /obj/item/storage/box/ammo/c10mm_ap
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/ap45
	name = "AP .45 ammo box"
	desc = "A box full of armor piercing .45 ammunition."
	id = "ap45"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000, /datum/material/uranium = 1000)
	build_path = /obj/item/storage/box/ammo/c45_ap
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/ap556mmHITP
	name = "AP 5.56mm HITP caseless ammo box"
	desc = "A box full of armor piercing 5.56mm HITP caseless ammunition."
	id = "ap556mmHITP"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000, /datum/material/uranium = 1000)
	build_path = /obj/item/storage/box/ammo/c556mm_ap
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/hp9mm
	name = "HP 9x18mm ammo box"
	desc = "A box full of hollow point 9x18mm ammunition."
	id = "hp9mm"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000, /datum/material/silver = 1000)
	build_path = /obj/item/storage/box/ammo/c9mm_hp
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/hp10mm
	name = "HP 10x22mm ammo box"
	desc = "A box full of hollow point 10x22mm ammunition."
	id = "hp10mm"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000, /datum/material/silver = 1000)
	build_path = /obj/item/storage/box/ammo/c10mm_hp
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/hp45
	name = "HP .45 ammo box"
	desc = "A box full of hollow point .45 ammunition."
	id = "hp45"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000, /datum/material/silver = 1000)
	build_path = /obj/item/storage/box/ammo/c45_hp
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/hp556mmHITP
	name = "HP 5.56mm HITP caseless ammo box"
	desc = "A box full of hollow point 5.56mm HITP caseless ammunition."
	id = "hp556mmHITP"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 17000, /datum/material/silver = 1000)
	build_path = /obj/item/storage/box/ammo/c556mm_hp
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/rubbershot
	name = "Rubber Shot"
	id = "rubber_shot"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 2000)
	build_path = /obj/item/ammo_casing/shotgun/rubbershot
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/shotgun_slug
	name = "Shotgun Slug"
	id = "shotgun_slug"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/shotgun
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/shotgun_dart
	name = "Shotgun Dart"
	id = "shotgun_dart"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_casing/shotgun/dart
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/incendiary_slug
	name = "Incendiary Slug"
	id = "incendiary_slug"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/plasma = 2000)
	build_path = /obj/item/ammo_casing/shotgun/incendiary
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/stunshell
	name = "Stun Shell"
	desc = "A stunning shell for a shotgun."
	id = "stunshell"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2767587)
	build_path = /obj/item/ammo_casing/shotgun/stunslug
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/techshell
	name = "Unloaded Technological Shotshell"
	desc = "A high-tech shotgun shell which can be loaded with materials to produce unique effects."
	id = "techshotshell"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 200)
	build_path = /obj/item/ammo_casing/shotgun/techshell
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/suppressor
	name = "Suppressor"
	desc = "A reverse-engineered suppressor that fits on most small arms with threaded barrels."
	id = "suppressor"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/silver = 500)
	build_path = /obj/item/attachment/silencer
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/gravitygun
	name = "One-point Gravitational Manipulator"
	desc = "A multi-mode device that blasts one-point bluespace-gravitational bolts that locally distort gravity. Requires a gravitational anomaly core to function."
	id = "gravitygun"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 8000, /datum/material/uranium = 8000, /datum/material/glass = 12000, /datum/material/iron = 12000, /datum/material/diamond = 3000, /datum/material/bluespace = 3000)
	build_path = /obj/item/gun/energy/gravity_gun
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/largecrossbow
	name = "Energy Crossbow"
	desc = "A reverse-engineered energy crossbow favored by syndicate infiltration teams and carp hunters."
	id = "largecrossbow"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 1500, /datum/material/uranium = 1500, /datum/material/silver = 1500)
	build_path = /obj/item/gun/energy/kinetic_accelerator/crossbow/large
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/stun_boomerang
	name = "OZtek Boomerang"
	desc = "Uses reverse flow gravitodynamics to flip its personal gravity back to the thrower mid-flight. Also functions similar to a stun baton."
	id = "stun_boomerang"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 4000, /datum/material/silver = 10000, /datum/material/gold = 2000)
	build_path = /obj/item/melee/baton/boomerang
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/gun_cell
	name = "Weapon Power Cell"
	desc = "A power cell for weapons holds 10 MJ of energy."
	id = "gun_cell"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 70)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/gun/empty
	category = list("Misc","Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SECURITY

/datum/design/gun_cell_upgraded
	name = "Upgraded Weapon Power Cell"
	desc = "A upgraded power cell for weapons holds 20 MJ of energy."
	id = "gun_cell_upgraded"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/gold = 150, /datum/material/silver = 150, /datum/material/glass = 80)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/gun/upgraded/empty
	category = list("Misc","Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SECURITY

/datum/design/gun_cell_large
	name = "Large Weapon Power Cell"
	desc = "A huge weapon power cell, holding 50 MJ of energy."
	id = "gun_cell_large"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/gold = 200, /datum/material/glass = 400, /datum/material/diamond = 160, /datum/material/titanium = 300, /datum/material/bluespace = 100)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/gun/large/empty
	category = list("Misc","Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SECURITY

/datum/design/colt_1911_magazine
	name = "Colt 1911 Magazine"
	id = "ammo_1911"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/m45
	category = list("Imported")

/datum/design/disposable_gun
	name = "Disposable Gun"
	id = "disposable"
	build_type = AUTOLATHE
	materials = list(/datum/material/plastic = 4000)
	build_path = /obj/item/gun/ballistic/automatic/pistol/disposable
	category = list("Imported")

//SRM Ballistics
/datum/design/doublebarrel
	name = "Double Barrel Shotgun"
	desc = "A shotgun of the double barreled variety."
	id = "doublebarrel"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 1000, /datum/material/silver = 4000)
	build_path = /obj/item/gun/ballistic/shotgun/doublebarrel
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/Candor
	name = "Candor Pistol"
	desc = "A classic pistol."
	id = "candor"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 8000, /datum/material/silver = 3000, /datum/material/titanium = 2000)
	build_path = /obj/item/gun/ballistic/automatic/pistol/candor/factory/no_mag
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/derringer
	name = ".38 Derringer"
	desc = "An easily concealable gun that uses .38 rounds."
	id = "derringer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 8500, /datum/material/glass = 1500, /datum/material/titanium = 2000)
	build_path = /obj/item/gun/ballistic/derringer
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/winchestermk2
	name = "Flaming Arrow Lever-action Rifle"
	desc = "A Flaming Arrow, sturdy and lever action."
	id = "winchmk2"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 3000, /datum/material/silver = 4000, /datum/material/gold = 500)
	build_path = /obj/item/gun/ballistic/shotgun/flamingarrow
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/pepperbox
	name = "Pepperbox Handgun"
	desc = "A very old and outdated type of gun."
	id = "pepperbox"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 7000, /datum/material/glass = 1000)
	build_path = /obj/item/gun/ballistic/revolver/firebrand
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/montagne
	name = "Montagne Revolver"
	desc = "The revolver of choice of Hunger Montagnes all over. Uses .38."
	id = "montagne"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 90000, /datum/material/glass = 1500, /datum/material/silver = 1500)
	build_path = /obj/item/gun/ballistic/revolver/montagne
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/stripper762
	name = "8x50mmR Stripperclip"
	desc = "A stripperclip of 8x50mmR."
	id = "stripper762"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_box/magazine/illestren_a850r
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/speedload357
	name = ".357 revolver speedloader"
	desc = "A speedloader of .357 ammo for use in revolvers."
	id = "speedload357"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000)
	build_path = /obj/item/ammo_box/a357
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/illestren
	name = "Illestren Rifle"
	desc = "The pride of Hunter's Pride. Uses 8x50mmR."
	id = "illestren"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 85000, /datum/material/glass = 1500, /datum/material/silver = 1500)
	build_path = /obj/item/gun/ballistic/rifle/illestren/factory
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_BALLISTICS

/datum/design/c9mmautolathe
	name = "Ammo Box (9mm)"
	id = "c9mmautolathe"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 17000)
	build_path = /obj/item/storage/box/ammo/c9mm
	category = list("Imported")
