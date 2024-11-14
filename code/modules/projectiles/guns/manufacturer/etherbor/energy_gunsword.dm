/obj/item/gun/energy/kalix
	name = "Etherbor BG-12"
	desc = "Etherbor Industries's current civilian energy weapon model. The BG-12 energy beam gun is identical to the military model, minus the removal of the full auto mode. Otherwise, it's no different from older hunting beams from Kalixcis's history."
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
	wield_slowdown = 0.35

	default_ammo_type = /obj/item/stock_parts/cell/gun/kalix
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/kalix, /obj/item/ammo_casing/energy/disabler/hitscan)

	load_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'

	manufacturer = MANUFACTURER_PGF

/obj/item/ammo_casing/energy/kalix
	projectile_type = /obj/projectile/beam/hitscan/kalix
	fire_sound = 'sound/weapons/gun/energy/kalixsmg.ogg'
	e_cost = 666 //30 shots per cell
	delay = 1

/obj/projectile/beam/hitscan/kalix
	name = "concentrated energy"
	tracer_type = /obj/effect/projectile/tracer/kalix
	muzzle_type = /obj/effect/projectile/muzzle/kalix
	impact_type = /obj/effect/projectile/impact/kalix
	hitscan_light_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	muzzle_flash_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	impact_light_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	range = 10
	damage_constant = 0.8
	damage = 25
	armour_penetration = -10

/obj/item/gun/energy/kalix/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/kalix/pgf
	name = "Etherbor BG-16"
	desc = "The BG-16 is the military-grade beam gun designed and manufactured by Etherbor Industries as the standard-issue close-range weapon of the PGF."
	icon_state = "pgfgun"
	item_state = "pgfgun"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	default_ammo_type = /obj/item/stock_parts/cell/gun/pgf
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/pgf,
		/obj/item/stock_parts/cell/gun/kalix,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/kalix/pgf , /obj/item/ammo_casing/energy/disabler/hitscan)

/obj/projectile/beam/hitscan/kalix/pgf
	name = "concentrated energy"
	tracer_type = /obj/effect/projectile/tracer/pgf
	muzzle_type = /obj/effect/projectile/muzzle/pgf
	impact_type = /obj/effect/projectile/impact/pgf
	hitscan_light_color_override = LIGHT_COLOR_ELECTRIC_GREEN
	muzzle_flash_color_override = LIGHT_COLOR_ELECTRIC_GREEN
	impact_light_color_override = LIGHT_COLOR_ELECTRIC_GREEN

/obj/item/ammo_casing/energy/kalix/pgf
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf
	fire_sound = 'sound/weapons/gun/energy/kalixsmg.ogg'
	e_cost = 666 //30 shots per cell
	delay = 1

/obj/item/gun/energy/kalix/pistol //blue
	name = "Etherbor SG-8"
	desc = "Etherbor's current and sidearm offering. While marketed for the military, it's also available for civillians as an upgrade over older and obsolete beam pistols."
	icon_state = "kalixpistol"
	item_state = "kalixpistol"
	w_class = WEIGHT_CLASS_NORMAL
	modifystate = FALSE

	wield_delay = 0.2 SECONDS
	wield_slowdown = 0.15

	spread = 2
	spread_unwielded = 5

	default_ammo_type = /obj/item/stock_parts/cell/gun/kalix
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/kalix,
		/obj/item/stock_parts/cell/gun/pgf,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/kalix/pistol)


	load_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'

/obj/item/ammo_casing/energy/kalix/pistol
	fire_sound = 'sound/weapons/gun/energy/kalixpistol.ogg'
	e_cost = 1250 //10 shots per cell
	delay = 0

/obj/item/gun/energy/kalix/pistol/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/kalix/pgf/heavy
	name = "Etherbor HBG-7"
	desc = "The HBG-7 is the standard-issue rifle weapon of the PGF. It comes with a special DMR mode that has greater armor piercing for dealing with armored targets."
	icon_state = "pgfheavy"
	item_state = "pgfheavy"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	modifystate = FALSE

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	fire_delay = 0.2 SECONDS

	wield_delay = 0.7 SECONDS
	wield_slowdown = 0.6

	spread = 0
	spread_unwielded = 20

	ammo_type = list(/obj/item/ammo_casing/energy/pgf/assault, /obj/item/ammo_casing/energy/pgf/sniper)

/obj/item/ammo_casing/energy/pgf/assault
	select_name  = "AR"
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf/assault
	fire_sound = 'sound/weapons/gun/energy/kalixrifle.ogg'
	e_cost = 1000 //20 shots per cell
	delay = 1

/obj/projectile/beam/hitscan/kalix/pgf/assault
	tracer_type = /obj/effect/projectile/tracer/pgf/rifle
	muzzle_type = /obj/effect/projectile/muzzle/pgf/rifle
	impact_type = /obj/effect/projectile/impact/pgf/rifle
	damage = 25 //bar
	armour_penetration = 20
	range = 12
	damage_constant = 0.9

/obj/item/ammo_casing/energy/pgf/sniper
	select_name  = "DMR"
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf/sniper
	fire_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	e_cost = 2000 //20 shots per cell
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
	name = "Etherbor HBG-7L"
	desc = "HBG-7 with a longer barrel and scope. Intended to get the best use out of the DMR mode, it suffers from longer wield times and slowdown, but it's longer barrel makes it ideal for accuracy."
	icon_state = "pgfheavy_sniper"
	item_state = "pgfheavy_sniper"

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	spread = -5
	spread_unwielded = 40

	wield_slowdown = 1
	wield_delay = 1.3 SECONDS
