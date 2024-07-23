/obj/item/gun/energy/kalix/clip
	name = "CM-1"
	desc = "CLIP's first standard-issue weapon, a near-copy of colonial-era weapons left behind by Free Zohil forces in CLIP's founding years. Outdated and difficult to source replacement parts for, but nevertheless still very common among BARD personel and for ceremonal use."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm1"
	item_state = "cm1"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	cell_type = /obj/item/stock_parts/cell/gun
	ammo_type = list(/obj/item/ammo_casing/energy/kalix, /obj/item/ammo_casing/energy/disabler/hitscan)

	manufacturer = MANUFACTURER_MINUTEMAN_LASER

/obj/item/gun/energy/laser/e50/clip
	name = "ECM-50"
	desc = "An extensive modification of the Eoehoma E-50 Emitter, generally only used by CLIP-BARD. Sacrifices some of the E-50's raw power for vastly improved energy efficiency, without giving up the E-50's incendiary side-effects."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm50"
	item_state = "cm50"
	shaded_charge = TRUE
	charge_sections = 4

	ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/e50/clip)

/obj/item/ammo_casing/energy/laser/eoehoma/e50/clip
	projectile_type = /obj/projectile/beam/emitter/hitscan/clip
	fire_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	e_cost = 6250
	delay = 0.6 SECONDS

/obj/projectile/beam/emitter/hitscan/clip
	damage = 35
