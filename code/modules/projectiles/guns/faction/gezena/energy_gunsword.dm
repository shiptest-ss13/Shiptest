/obj/item/gun/energy/kalix //blue //todo: fix up belt_mirror.dmi, it's incomprehensible
	name = "Etherbor BG-12"
	desc = "Brought to you by Etherbor Industries, proudly based within the PGF, is the BG-12 energy beam gun! The BG-12 is Etherbor's current newest civilian energy weapon model."
	icon_state = "kalixgun"
	item_state = "kalixgun"
	icon = 'icons/obj/guns/faction/gezena/energy.dmi'
	lefthand_file = 'icons/obj/guns/faction/gezena/lefthand.dmi'
	righthand_file = 'icons/obj/guns/faction/gezena/righthand.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi'
	w_class = WEIGHT_CLASS_BULKY

	cell_type = /obj/item/stock_parts/cell/gun/pgf
	ammo_type = list(/obj/item/ammo_casing/energy/kalix)

	load_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'

	manufacturer = MANUFACTURER_PGF

/obj/projectile/beam/hitscan/kalix
	name = "concentrated energy"
	tracer_type = /obj/effect/projectile/tracer/kalix
	muzzle_type = /obj/effect/projectile/muzzle/kalix
	impact_type = /obj/effect/projectile/impact/kalix
	hitscan_light_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	muzzle_flash_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	impact_light_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	range = 10

/obj/item/ammo_casing/energy/kalix
	projectile_type = /obj/projectile/beam/hitscan/kalix
	fire_sound = 'sound/weapons/gun/energy/laserpistol.ogg'
	e_cost = 850

/obj/item/gun/energy/kalix/pgf
	name = "Etherbor BG-16"
	desc = "An advanced variant of the BG-12, the BG-16 is the military-grade beam gun designed and manufactured by Etherbor Industries as the standard-issue weapon of the PGF."
	icon_state = "pgfgun"
	item_state = "pgfgun"

	cell_type = /obj/item/stock_parts/cell/gun/pgf
	ammo_type = list(/obj/item/ammo_casing/energy/pgf)

/obj/projectile/beam/hitscan/pgf
	name = "concentrated energy"
	tracer_type = /obj/effect/projectile/tracer/pgf
	muzzle_type = /obj/effect/projectile/muzzle/pgf
	impact_type = /obj/effect/projectile/impact/pgf
	hitscan_light_color_override = LIGHT_COLOR_ELECTRIC_GREEN
	muzzle_flash_color_override = LIGHT_COLOR_ELECTRIC_GREEN
	impact_light_color_override = LIGHT_COLOR_ELECTRIC_GREEN
	damage_constant = 0.9
	damage = 25
	range = 6

/obj/item/ammo_casing/energy/pgf
	projectile_type = /obj/projectile/beam/hitscan/pgf
	fire_sound = 'sound/weapons/gun/energy/laserpistol.ogg'
	e_cost = 1000

/obj/item/gun/energy/kalix/pgf/heavy
	name = "Etherbor HBG-7"
	desc = "For when a BG-16 doesn’t cut it, the far bulkier HBG-7, provided by your friends at Etherbor Industries, has the stopping power and fire rate to bring down any target where a smaller caliber weapon just wouldn't cut it."
	icon_state = "pgfheavy"
	item_state = "pgfheavy"
	icon = 'icons/obj/guns/faction/gezena/48x32.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/back.dmi'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK

	wield_delay = 0.7 SECONDS
	wield_slowdown = 0.6
	spread_unwielded = 20

	ammo_type = list(/obj/item/ammo_casing/energy/pgf/heavy)

/obj/projectile/beam/hitscan/pgf/heavy
	damage = 35
	range = 12

/obj/item/ammo_casing/energy/pgf/heavy
	projectile_type = /obj/projectile/beam/hitscan/pgf/heavy
	fire_sound = 'sound/weapons/gun/energy/lasersniper.ogg'
	e_cost = 2000
