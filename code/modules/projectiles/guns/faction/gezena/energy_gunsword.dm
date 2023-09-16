/obj/item/gun/energy/kalix //blue
	name = "PH KALIX GUN"
	desc = "PH PGF DESC"
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
	e_cost = 850

/obj/item/gun/energy/kalix/pgf
	name = "PH PGF GUN"
	desc = "PH PGF DESC"
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
	range = 7

/obj/item/ammo_casing/energy/pgf
	projectile_type = /obj/projectile/beam/hitscan/pgf
	e_cost = 1000

/obj/item/gun/energy/kalix/pgf/heavy //todo: make it actually use wielded component, or some other solution for twohanding, as it really sucks right now
	name = "PH PGF HEAVY NAME"
	desc = "PH PGF HEAVY DESC"
	icon_state = "pgfheavy"
	item_state = "pgfheavy"
	icon = 'icons/obj/guns/faction/gezena/48x32.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/back.dmi'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK

/obj/projectile/beam/hitscan/pgf/heavy
	damage = 30
	range = 12

/obj/item/ammo_casing/energy/pgf/heavy
	projectile_type = /obj/projectile/beam/hitscan/pgf/heavy
	e_cost = 2000
