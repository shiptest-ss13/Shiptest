/obj/item/gun/energy/kalix
	name = "\improper Etherbor BG-12"
	desc = "The BG-12 is Etherbor Industries's current civilian beam gun model. The BG-12 energy beam gun is practically identical to the military model barring the removal of the full auto mode. Otherwise, it's no different from older hunting beams from Kalixcis's history."
	icon_state = "kalixgun"
	item_state = "kalixgun"
	icon = 'icons/obj/guns/manufacturer/etherbor/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/etherbor/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/etherbor/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/etherbor/onmob.dmi'
	w_class = WEIGHT_CLASS_BULKY

	modifystate = TRUE

	fire_delay = 0.16 SECONDS

	wield_delay = 0.7 SECONDS
	wield_slowdown = LASER_SMG_SLOWDOWN

	spread = 3
	spread_unwielded = 10

	default_ammo_type = /obj/item/stock_parts/cell/gun/kalix
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/kalix, /obj/item/ammo_casing/energy/disabler/hitscan)

	load_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'

	manufacturer = MANUFACTURER_PGF

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 26,
			"y" = 13,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 20,
			"y" = 15,
		)
	)

/obj/item/ammo_casing/energy/kalix
	projectile_type = /obj/projectile/beam/hitscan/kalix
	fire_sound = 'sound/weapons/gun/energy/kalixsmg.ogg'
	e_cost = 500 //25 shots per cell
	delay = 1

/obj/projectile/beam/hitscan/kalix
	name = "concentrated energy beam"
	tracer_type = /obj/effect/projectile/tracer/kalix
	muzzle_type = /obj/effect/projectile/muzzle/kalix
	impact_type = /obj/effect/projectile/impact/kalix
	hitscan_light_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	muzzle_flash_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	impact_light_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	range = 12
	damage_constant = 0.8
	damage = 25
	armour_penetration = -10

/obj/item/gun/energy/kalix/empty_cell
	spawn_no_ammo = TRUE
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)

/obj/projectile/beam/hitscan/kalix/nock
	name = "concentrated energy beam"
	damage_constant = 0.8
	damage = 15
	armour_penetration = -20

/obj/item/ammo_casing/energy/kalix/nock
	projectile_type = /obj/projectile/beam/hitscan/kalix/nock
	fire_sound = 'sound/weapons/gun/energy/kalixsmg.ogg'
	e_cost = 312 //10 bursts per cell
	select_name = "kill"

/obj/item/ammo_casing/energy/disabler/hitscan/kalix/nock
	projectile_type = /obj/projectile/beam/hitscan/disabler
	fire_sound = 'sound/weapons/taser2.ogg'
	e_cost = 312 //10 bursts per cell
	select_name = "disable"

/obj/item/gun/energy/kalix/nock
	name = "\improper Etherbor VG-F3"
	desc = "The Etherbor Industries VG-F3 is a further refinement of the antiquated beam volleygun concept. The first of its kind to find commercial success in the modern day, the VG-F3 has found a comfortable niche with law enforcement and home defense markets galaxy-wide."
	icon_state = "kalixnock"
	item_state = "kalixnock"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE

	modifystate = TRUE

	gun_firemodes = list(FIREMODE_BURST)
	default_firemode = FIREMODE_BURST

	randomspread = TRUE
	burst_size = 4
	burst_delay = 0.1 SECONDS
	fire_delay = 0.7 SECONDS

	wield_delay = 0.7 SECONDS
	wield_slowdown = LASER_SMG_SLOWDOWN

	spread = 10
	spread_unwielded = 15

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_MUZZLE = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 25,
			"y" = 13,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 17,
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
	ammo_type = list(/obj/item/ammo_casing/energy/kalix/nock, /obj/item/ammo_casing/energy/disabler/hitscan/kalix/nock)

/obj/item/gun/energy/kalix/nock/empty_cell
	spawn_no_ammo = TRUE
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)

/obj/projectile/beam/hitscan/kalix/pgf/nock
	name = "concentrated energy beam"
	damage_constant = 0.8
	damage = 15
	armour_penetration = -20

/obj/item/ammo_casing/energy/kalix/pgf/nock
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf/nock
	fire_sound = 'sound/weapons/gun/energy/kalixrifle.ogg'
	e_cost = 250 //16 bursts per cell
	select_name = "kill"

/obj/item/ammo_casing/energy/disabler/hitscan/kalix/pgf/nock
	projectile_type = /obj/projectile/beam/hitscan/disabler
	fire_sound = 'sound/weapons/taser2.ogg'
	e_cost = 250 //16 bursts per cell
	select_name = "disable"

/obj/item/gun/energy/kalix/pgf/nock
	name = "\improper Etherbor VG-A5"
	desc = "Piggybacking off the success of the VG-F3, the Etherbor Industries VG-A5 Beam Volleygun was designed specifically for contract sale to the PGF armed forces. With the addition of a stronger capacitor and a forward grip, the VG-A5 has found itself popular among marine raiders for its ability to take control of tight spaces."
	icon_state = "pgfnock"
	item_state = "pgfnock"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE

	modifystate = TRUE

	gun_firemodes = list(FIREMODE_BURST)
	default_firemode = FIREMODE_BURST

	randomspread = TRUE
	burst_size = 5
	burst_delay = 0.1 SECONDS
	fire_delay = 0.7 SECONDS

	wield_delay = 0.5 SECONDS
	wield_slowdown = LASER_SMG_SLOWDOWN

	spread = 10
	spread_unwielded = 15

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_MUZZLE = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 25,
			"y" = 13,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 17,
			"y" = 15,
		)
	)

	default_ammo_type = /obj/item/stock_parts/cell/gun/pgf
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/kalix/pgf/nock, /obj/item/ammo_casing/energy/disabler/hitscan/kalix/pgf/nock)

/obj/item/gun/energy/kalix/pgf/nock/empty_cell
	spawn_no_ammo = TRUE
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)

/obj/item/gun/energy/kalix/pgf
	name = "\improper Etherbor BG-16"
	desc = "Designed as the PGF armed forces primary close-combat weapon, the Etherbor BG-16 trades stability and power at range for an impressive shot capacity."
	icon_state = "pgfgun"
	item_state = "pgfgun"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	wield_delay = 0.7 SECONDS
	wield_slowdown = LASER_SMG_SLOWDOWN

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 26,
			"y" = 13,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 20,
			"y" = 15,
		)
	)

	default_ammo_type = /obj/item/stock_parts/cell/gun/pgf
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/kalix/pgf , /obj/item/ammo_casing/energy/disabler/hitscan)

/obj/item/gun/energy/kalix/pgf/empty_cell
	spawn_no_ammo = TRUE
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)

/obj/projectile/beam/hitscan/kalix/pgf
	name = "concentrated energy beam"
	tracer_type = /obj/effect/projectile/tracer/pgf
	muzzle_type = /obj/effect/projectile/muzzle/pgf
	impact_type = /obj/effect/projectile/impact/pgf
	hitscan_light_color_override = LIGHT_COLOR_ELECTRIC_GREEN
	muzzle_flash_color_override = LIGHT_COLOR_ELECTRIC_GREEN
	impact_light_color_override = LIGHT_COLOR_ELECTRIC_GREEN

/obj/item/ammo_casing/energy/kalix/pgf
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf
	fire_sound = 'sound/weapons/gun/energy/kalixsmg.ogg'
	e_cost = 500 //40 shots per cell
	delay = 1

/obj/item/gun/energy/kalix/pistol //blue
	name = "\improper Etherbor SG-8"
	desc = "Handy and remarkably accurate, the SG-8 is Etherbor's current sidearm offering. While marketed for the military, it's also available for civillians as an upgrade over older and more obsolete beam pistols."
	icon_state = "kalixpistol"
	item_state = "kalixpistol"
	w_class = WEIGHT_CLASS_NORMAL
	modifystate = FALSE

	wield_delay = 0.2 SECONDS
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	spread = 2
	spread_unwielded = 5

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 22,
			"y" = 14,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 15,
			"y" = 17,
		)
	)

	default_ammo_type = /obj/item/stock_parts/cell/gun/kalix
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/kalix/pistol)


	load_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'

/obj/projectile/beam/hitscan/kalix/pistol
	name = "concentrated energy beam"
	damage_constant = 0.7
	damage = 25
	armour_penetration = -10

/obj/item/ammo_casing/energy/kalix/pistol
	projectile_type = /obj/projectile/beam/hitscan/kalix/pistol
	fire_sound = 'sound/weapons/gun/energy/kalixpistol.ogg'
	e_cost = 1000 //12 shots per cell
	delay = 0

/obj/item/gun/energy/kalix/pistol/empty_cell
	spawn_no_ammo = TRUE
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)

/obj/item/gun/energy/kalix/pgf/pdw
	name = "\improper Etherbor SGR-9"
	desc = "Favored by vehicle crews, artillerymen, logistics personnel and more, the compact frame of the Etherbor SGR-9 is ideal for rear echelon troops who may still expect to see some action."
	icon_state = "pgfpdw"
	item_state = "pgfpdw"
	w_class = WEIGHT_CLASS_NORMAL
	modifystate = TRUE

	gun_firemodes = list(FIREMODE_BURST, FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_BURST

	wield_delay = 0.2 SECONDS
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	burst_size = 2
	burst_delay = 0.1 SECONDS
	fire_delay = 0.5 SECONDS

	spread = 9
	spread_unwielded = 10

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_STOCK = 1,
	)

	unique_attachments = list(
		/obj/item/attachment/foldable_stock/pgfpdw
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 27,
			"y" = 14,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 26,
			"y" = 15,
		)
	)
	default_attachments = list(/obj/item/attachment/foldable_stock/pgfpdw)

	default_ammo_type = /obj/item/stock_parts/cell/gun/pgf
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/kalix/pgf/pdw,/obj/item/ammo_casing/energy/disabler/hitscan/kalix/pgf/pdw)


	load_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'

/obj/projectile/beam/hitscan/kalix/pgf/pdw
	name = "concentrated energy beam"
	damage_constant = 0.9
	damage = 20
	armour_penetration = 10

/obj/item/ammo_casing/energy/kalix/pgf/pdw
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf/pdw
	fire_sound = 'sound/weapons/gun/energy/kalixpistol.ogg'
	e_cost = 765 //26 shots per cell
	select_name = "kill"

/obj/item/ammo_casing/energy/disabler/hitscan/kalix/pgf/pdw
	projectile_type = /obj/projectile/beam/hitscan/disabler
	fire_sound = 'sound/weapons/taser2.ogg'
	e_cost = 765 //26 shots per cell
	select_name = "disable"

/obj/item/gun/energy/kalix/pgf/pdw/empty_cell
	spawn_no_ammo = TRUE
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)

/obj/item/gun/energy/kalix/pgf/medium
	name = "\improper Etherbor BGC-10"
	desc = "Etherbor's answer to the PGF armed forces's request for a carbine style weapon; the BGC-10 offers greater accuracy and power than the BG-16, while being less cumbersome than the DMR mode equipped HBG series rifles."
	icon_state = "pgfmedium"
	item_state = "pgfmedium"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	modifystate = TRUE

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	fire_delay = 0.2 SECONDS

	wield_delay = 0.7 SECONDS
	wield_slowdown = LASER_RIFLE_SLOWDOWN

	spread = 0.5
	spread_unwielded = 15

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 31,
			"y" = 13,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 24,
			"y" = 15,
		)
	)

	ammo_type = list(/obj/item/ammo_casing/energy/pgf/assault, /obj/item/ammo_casing/energy/disabler/hitscan/heavy)

/obj/item/gun/energy/kalix/pgf/medium/empty_cell
	spawn_no_ammo = TRUE
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)

/obj/item/gun/energy/kalix/pgf/heavy
	name = "\improper Etherbor HBG-7"
	desc = "The HBG-7 is the standard-issue rifle weapon of the PGF armed forces. It comes equipped with a special DMR mode that has greater armor piercing for dealing with armored targets."
	icon_state = "pgfheavy"
	item_state = "pgfheavy"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	modifystate = FALSE

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	fire_delay = 0.2 SECONDS

	wield_delay = 0.7 SECONDS
	wield_slowdown = HEAVY_LASER_RIFLE_SLOWDOWN

	spread = 0
	spread_unwielded = 20

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 32,
			"y" = 13,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 26,
			"y" = 15,
		)
	)

	ammo_type = list(/obj/item/ammo_casing/energy/pgf/assault, /obj/item/ammo_casing/energy/pgf/sniper)

/obj/item/gun/energy/kalix/pgf/heavy/empty_cell
	spawn_no_ammo = TRUE
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)

/obj/item/ammo_casing/energy/pgf/assault
	select_name  = "AR"
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf/assault
	fire_sound = 'sound/weapons/gun/energy/kalixrifle.ogg'
	e_cost = 666 //30 shots per cell
	delay = 1

/obj/projectile/beam/hitscan/kalix/pgf/assault
	tracer_type = /obj/effect/projectile/tracer/pgf/rifle
	muzzle_type = /obj/effect/projectile/muzzle/pgf/rifle
	impact_type = /obj/effect/projectile/impact/pgf/rifle
	damage = 25 //bar
	armour_penetration = 20
	range = 14
	damage_constant = 0.9

/obj/item/ammo_casing/energy/pgf/sniper
	select_name  = "DMR"
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf/sniper
	fire_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	e_cost = 2000 //10 shots per cell
	delay = 6

/obj/projectile/beam/hitscan/kalix/pgf/sniper
	tracer_type = /obj/effect/projectile/tracer/laser/emitter
	muzzle_type = /obj/effect/projectile/muzzle/laser/emitter
	impact_type = /obj/effect/projectile/impact/laser/emitter

	damage = 35
	armour_penetration = 40
	range = 20
	damage_constant = 1

/obj/item/gun/energy/kalix/pgf/heavy/sniper
	name = "\improper Etherbor HBG-7L"
	desc = "HBG-7 with a longer barrel and scope. Intended to get the best use out of the DMR mode, it suffers from longer wield times and greater slowdown, but it's longer barrel makes it ideal for precision shooting."
	icon_state = "pgfheavy_sniper"
	item_state = "pgfheavy_sniper"

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	spread = -5
	spread_unwielded = 40

	wield_slowdown = LASER_SNIPER_SLOWDOWN
	wield_delay = 1.3 SECONDS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 36,
			"y" = 13,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 26,
			"y" = 15,
		)
	)

/obj/item/gun/energy/kalix/pgf/heavy/sniper/empty_cell
	spawn_no_ammo = TRUE
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix/empty,
		/obj/item/stock_parts/cell/gun/pgf/empty,
	)
