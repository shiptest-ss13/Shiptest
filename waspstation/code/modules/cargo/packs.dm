/datum/supply_pack/security/armory/riot_shotgun_single
	name = "Riot Shotgun Single-Pack"
	desc = "When you simply just want Butch to step aside. Requires Armory level access to open."
	cost = 2500
	small_item = TRUE
	contains = list(/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/storage/belt/bandolier)
	dangerous = TRUE

/datum/supply_pack/security/armory/riot_shotgun
	name = "Riot Shotguns Crate"
	desc = "For when the greytide gets out of hand. Contains 3 pump shotguns and shotgun ammo bandoliers to go with. Requires Armory level access to open."
	cost = 6000
	contains = list(/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/storage/belt/bandolier,
					/obj/item/storage/belt/bandolier,
					/obj/item/storage/belt/bandolier)
	crate_name = "shotguns crate"
	dangerous = TRUE

/datum/supply_pack/costumes_toys/foamforce/vintage_foamforce
	name = "Emmet's Vintage Heater Crate"
	desc = "Whatchu gonna do when the seccies roll through, throw shoes at 'em? But remember, you ain't got this from me. And remember this, Emmet is the place for guns too! I've always got high quality merchandise, and I've been proudly serving the Los Santos community for over 30 years!"
	hidden = TRUE
	cost = 7000
	contains = list(/obj/item/gun/ballistic/automatic/pistol/m1911)
	crate_name = "portable scrubber crate"
	dangerous = TRUE

/datum/supply_pack/costumes_toys/foamforce/vintage_foamforce_ammo
	name = "Emmet's Vintage Heater Parts Crate"
	desc = "Don't be forgetting spare parts for your heating unit as well! 'Worked great and fixed the problem with my heater not working, 10/10' - from Gorlex Naval Forces Midshipman Cherilyn C. Glover."
	hidden = TRUE
	cost = 1500
	small_item = TRUE
	contains = list(/obj/item/ammo_box/magazine/m45)
	crate_name = "monkey cube crate"
	dangerous = TRUE

/datum/supply_pack/emergency/specialops
	name = "Special Ops Supplies"
	desc = "(*!&@#A TRIED AND TRUE SUPPLEMENTARY BUNDLE. CONTAINS A BOX OF FIVE EMP GRENADES, THREE SMOKEBOMBS, AN INCENDIARY GRENADE, AND A \"SLEEPY PEN\" FULL OF CHEAP POISONS!#@*$"
	hidden = TRUE
	cost = 4000
	contains = list(/obj/item/storage/box/emps,
					/obj/item/grenade/smokebomb,
					/obj/item/grenade/smokebomb,
					/obj/item/grenade/smokebomb,
					/obj/item/pen/sleepy,
					/obj/item/grenade/chem_grenade/incendiary)
	crate_name = "firefighting crate"
	crate_type = /obj/structure/closet/crate/internals
	dangerous = TRUE

/datum/supply_pack/security/armory/cool_wt550_ammo
	name = "WT-550 Auto Rifle Exotic Ammo Crate"
	desc = "Contains one magazine of armor-piercing and one magazine of incendiary ammunition for the WT-550 Auto Rifle. Each magazine is designed to facilitate rapid tactical reloads. Requires Armory access to open. Sadly, our manufacturer discontinued the uranium-tipped bullets."
	contraband = TRUE
	cost = 2500
	contains = list(/obj/item/ammo_box/magazine/wt550m9/wtap,
					/obj/item/ammo_box/magazine/wt550m9/wtic)
	dangerous = TRUE

/obj/item/stock_parts/cell/inducer_supply
	maxcharge = 5000
	charge = 5000
/datum/supply_pack/engineering/inducers
	name = "NT-67 Electromagnetic Power Inducers Crate"
	desc = "No rechargers? No problem, with the NT-67 EPI, you can recharge any standard cell-based equipment anytime, anywhere. Contains two Inducers."
	cost = 2000
	contains = list(/obj/item/inducer {cell_type = /obj/item/stock_parts/cell/inducer_supply; opened = 0}, /obj/item/inducer {cell_type = /obj/item/stock_parts/cell/inducer_supply; opened = 0})
	crate_name = "inducer crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/emergency/recharge
	name = "Uplink Rechargement Crate"
	desc = "^#!$&EVERYBODY WANTS MORE FANCY SOUVENIRS. OUR TELE-CRYSTAL REFINERY IS WILLING TO FULFILL A RUSH ORDER, BUT AT A BIT OF A PREMIUM. MAYBE BE A BIT MORE STINGY IN THE FUTURE!$*&@#@"
	hidden = TRUE
	cost = 15700
	contains = list(/obj/item/stack/telecrystal)
	crate_name = "wizard costume crate"
	crate_type = /obj/structure/closet/crate/wooden
	dangerous = TRUE

/datum/supply_pack/costumes_toys/wardrobe/evil
	name = "Waffle Corporation Fashion Crate"
	desc = "~*$#?THE PEAK IN TRAITOROUS FASHION IS HERE! IN COMING THE MOST LUXURY GARB FROM THE Chambre Syndicale de la Haute Couture FASHION SCHOOL, BROUGHT TO YOU BY THE WAFFLE CORPORATION. GUARANTEED TO STUN THE WARDEN WITH YOUR ABSOLUTELY PULCHRITUDINOUS LOOKS - AND YOUR 10MM PISTOL!^@`*,"
	cost = 8500
	hidden = TRUE
	contains = list(/obj/item/storage/fancy/cigarettes/cigpack_syndicate,
					/obj/item/clothing/under/syndicate/bloodred,
					/obj/item/ammo_box/magazine/m10mm,
					/obj/item/storage/belt/military/army,
					/obj/item/clothing/head/hooded/human_head,
					/obj/item/clothing/shoes/combat/sneakboots,
					/obj/item/storage/box/syndie_kit/sleepytime,
					/obj/item/clothing/mask/muzzle,
					/obj/item/clothing/under/syndicate/soviet,
					/obj/item/clothing/suit/armor/vest/infiltrator,
					/obj/item/clothing/under/syndicate/sniper,
					/obj/item/storage/box/syndie_kit/cutouts,
					/obj/item/clothing/suit/hooded/bloated_human,
					/obj/item/storage/belt/military,
					/obj/item/clothing/suit/straight_jacket,
					/obj/item/clothing/gloves/color/latex/nitrile/infiltrator,
					/obj/item/clothing/head/helmet/infiltrator,
					/obj/item/clothing/shoes/magboots/syndie,
					/obj/item/pen/edagger,
					/obj/item/gun/ballistic/derringer,
					/obj/item/reagent_containers/syringe/mulligan)
	crate_name = "surplus fashion crate"

/datum/supply_pack/costumes_toys/wardrobe/evil/fill(obj/structure/closet/crate/C)
	for(var/i in 1 to 10)
		var/item = pick(contains)
		new item(C)

/datum/supply_pack/engine/am_jar
	name = "Antimatter Containment Jar Crate"
	desc = "Two Antimatter containment jars stuffed into a single crate."
	cost = 2000
	contains = list(/obj/item/am_containment,
					/obj/item/am_containment)
	crate_name = "antimatter jar crate"
	dangerous = TRUE
/datum/supply_pack/engine/am_core
	name = "Antimatter Control Crate"
	desc = "The brains of the Antimatter engine, this device is sure to teach the station's powergrid the true meaning of real power."
	cost = 5000
	contains = list(/obj/machinery/power/am_control_unit)
	crate_name = "antimatter control crate"
	dangerous = TRUE
/datum/supply_pack/engine/am_shielding
	name = "Antimatter Shielding Crate"
	desc = "Contains ten Antimatter shields, somehow crammed into a crate."
	cost = 2000
	contains = list(/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container) //10 shields: 3x3 containment and a core
	crate_name = "antimatter shielding crate"
	dangerous = TRUE
