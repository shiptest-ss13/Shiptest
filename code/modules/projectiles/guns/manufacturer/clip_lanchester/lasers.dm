/obj/item/gun/energy/kalix/clip
	name = "ECM-6 Rubus"
	desc = "A modernized copy of the ECM-1, CLIP's first service weapon. Features a number of improvements to bring the aging design back into the modern age."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm6"
	item_state = "cm6"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	wield_delay = 0.7 SECONDS
	wield_slowdown = LASER_SMG_SLOWDOWN

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 26,
			"y" = 12,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 20,
			"y" = 15,
		)
	)

	default_ammo_type = /obj/item/stock_parts/cell/gun/kalix
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/kalix, /obj/item/ammo_casing/energy/disabler/hitscan)

	manufacturer = MANUFACTURER_MINUTEMAN_LASER

/obj/item/gun/energy/kalix/clip/old
	name = "ECM-1"
	desc = "This is either a flawless replica, or a genuine example of the colonial-era laser weaponry issued to Free Zohil forces in CLIP's founding years. Over a hundred years old, and especially difficult to source replacement parts for, but still deadly. Kept around for ceremonial use in the CLIP Minutemen, and, rarely, for influential members of all divisions."

	default_ammo_type = /obj/item/stock_parts/cell/gun
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun,
		/obj/item/stock_parts/cell/gun/upgraded,
		/obj/item/stock_parts/cell/gun/empty,
		/obj/item/stock_parts/cell/gun/upgraded/empty,
	)
	icon_state = "cm1"
	item_state = "cm1"

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 24,
			"y" = 13,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 20,
			"y" = 15,
		)
	)

	ammo_type = list(/obj/item/ammo_casing/energy/kalix)

/obj/item/gun/energy/laser/e50/clip
	name = "ECM-50 Pyracanth"
	desc = "An extensive modification of the Eoehoma E-50 Emitter by Clover Photonics, customized for CLIP-BARD to fight Xenofauna. Sacrifices some of the E-50's raw power for vastly improved energy efficiency."

	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "ecm50"
	item_state = "ecm50"

	manufacturer = MANUFACTURER_MINUTEMAN_LASER

	ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/e50/clip)

/obj/item/ammo_casing/energy/laser/eoehoma/e50/clip
	projectile_type = /obj/projectile/beam/emitter/hitscan/clip
	fire_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	e_cost = 6250
	delay = 0.6 SECONDS

/obj/projectile/beam/emitter/hitscan/clip
	damage = 35

/obj/projectile/beam/hitscan/kalix/faveleira
	damage = 30
	armour_penetration = 10

	pass_flags = PASSTABLE | PASSGRILLE //does not go through glass


/obj/item/gun/energy/clover
	name = "ECM-7 \"Nettle\""
	desc = "A light, compact energy pistol designed to fire in 3 round bursts. Its light weight and logistical ease have made it the preferred sidearm in many CLIP divisions. Uses Eoehoma Mini Cells"

	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "ecm7"
	item_state = "clover_generic"

	manufacturer = MANUFACTURER_MINUTEMAN_LASER

	wield_delay = 0.7 SECONDS
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	burst_size = 3
	burst_delay = 0.2 SECONDS
	fire_delay = 0.5 SECONDS
	spread = 4
	spread_unwielded = 7

	default_ammo_type = /obj/item/stock_parts/cell/gun/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/mini,
		/obj/item/stock_parts/cell/gun/mini/empty,
	)

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	default_firemode = FIREMODE_SEMIAUTO

	ammo_type = list(/obj/item/ammo_casing/energy/laser/clover, /obj/item/ammo_casing/energy/disabler/clover)

	muzzleflash_iconstate = "muzzle_flash_pulse"

/obj/item/gun/energy/clover/indie
	name = "PL-7 \"Nettle\""
	desc = "A light, compact energy pistol designed to fire in 3 round bursts. A simple pistol favored by law enforcement and league citizens alike for its simple design and rate of fire. Uses Eoehoma Mini Cells"

	icon_state = "pl7"
	item_state = "clover_generic_civ"

	spread = 6
	spread_unwielded = 8

	gun_firemodes = list(FIREMODE_SEMIAUTO)

/obj/item/gun/energy/clover/auto
	name = "EPL-7 \"Stinging Nettle\""
	desc = "An extremely rare, prototyped version of the ECM-7, designed with a electropulse gas recycling chamber to allow it to fire in full auto at an extreme speed. The serial numbers have been scratched off. Uses Eoehoma Mini Cells"

	icon_state = "stinging_nettle"

	spread = 9
	spread_unwielded = 10

	fire_delay = 0.12 SECONDS

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

	ammo_type = list(/obj/item/ammo_casing/energy/laser/clover/auto)

/obj/item/gun/energy/clover/thistle
	name = "ECM-9 \"Thistle\""
	desc = "A midweight energy-based handgun, designed in part to effectively penetrate most body armor. Popular among CLIP-GOLD field agents and military policemen. Uses Eoehoma Mini Cells."

	icon_state = "ecm9"
	item_state = "clover_generic"

	wield_slowdown = LASER_PISTOL_SLOWDOWN

	spread = 2
	spread_unwielded = 9

	ammo_type = list(/obj/item/ammo_casing/energy/laser/clover/magnum, /obj/item/ammo_casing/energy/disabler/clover/magnum)
	gun_firemodes = list(FIREMODE_SEMIAUTO)

/obj/item/gun/energy/clover/thistle/indie
	name = "PL-9 \"Thistle\""
	desc = "A midweight, armor-piercing energy handgun, it trades stopping power for armor penetration. Often found in the hands of mercenaries and captains who prefer a more economic firearm. Uses Eoehoma Mini Cells"
	icon_state = "pl9"
	item_state = "clover_generic_civ"

	spread = 3
	spread_unwielded = 10

/obj/item/gun/energy/clover/shillelagh
	name = "ECM-12 \"Shillelagh\""
	desc = "A pulsed energy SMG that fires relatively high-power bolts for improved performance, at the cost of overall magazine capacity. Uses Eoehoma Cells"

	icon_state = "ecm12"
	item_state = "ecm12"

	default_ammo_type = /obj/item/stock_parts/cell/gun
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun,
		/obj/item/stock_parts/cell/gun/empty,
		/obj/item/stock_parts/cell/gun/upgraded,
		/obj/item/stock_parts/cell/gun/upgraded/empty,
	)

	ammo_type = list(/obj/item/ammo_casing/energy/laser/clover/smg, /obj/item/ammo_casing/energy/disabler/clover/smg)


	modifystate = FALSE
	weapon_weight = WEAPON_MEDIUM

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	fire_delay = 0.16 SECONDS
	wield_slowdown = LASER_SMG_SLOWDOWN

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)

/obj/item/gun/energy/clover/shillelagh/indie
	name = "PL-12 \"Shillelagh\""
	desc = "A pulsed energy SMG, restricted to a burst fire mode. A simple, light, and economical automatic for the discerning captain looking for self-defense firearms. Uses Eoehoma Cells"

	icon_state = "pl12"
	item_state = "pl12"

	burst_size = 3
	burst_delay = 0.16 SECONDS
	fire_delay = 0.4 SECONDS

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)

/obj/item/gun/energy/clover/faveleira
	name = "ECM-25 \"Faveleira\""
	desc = "Clover Photonic's latest product, the ECM-25 can switch between a diffuse scattershot mode, with all five lenses firing independently. Or in a 'concentrated' mode to release a hypervelocity bolt of plasma. Uses Eoehoma Cells"

	icon_state = "ecm25"
	item_state = "ecm25"

	default_ammo_type = /obj/item/stock_parts/cell/gun
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun,
		/obj/item/stock_parts/cell/gun/empty,
		/obj/item/stock_parts/cell/gun/upgraded,
		/obj/item/stock_parts/cell/gun/upgraded/empty,
	)
	weapon_weight = WEAPON_MEDIUM

	wield_delay = 0.9 SECONDS
	wield_slowdown = LASER_RIFLE_SLOWDOWN

	fire_delay = 0.3 SECONDS
	spread = 1
	spread_unwielded = 20

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	ammo_type = list(/obj/item/ammo_casing/energy/laser/clover/shotgun, /obj/item/ammo_casing/energy/laser/clover/beam)

/obj/item/ammo_casing/energy/laser/clover/beam
	projectile_type = /obj/projectile/beam/hitscan/kalix/faveleira
	fire_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	e_cost = 1000
	delay = 1 SECONDS
	select_name = "focused"

/obj/item/gun/energy/clover/faveleira/indie
	name = "PL-24 \"Faveleira\""
	desc = "An older model of the ECM-25. The PL-24 lacks the concentrated fire feature, but still makes for a dependable energy-based scattergun. Uses Eoehoma Cells"

	icon_state = "pl25"
	item_state = "pl25"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/clover/shotgun)
