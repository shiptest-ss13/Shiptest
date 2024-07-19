//########### PISTOLS ###########//
/obj/item/gun/ballistic/automatic/pistol/cm23
	name = "\improper CM-23"
	desc = "The 10 round service pistol of CLIP. It has become less common in service as time has passed on, but still sees action in specialized units or the frontier patrols. Chambered in 10mm."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm23"
	item_state = "clip_generic"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/cm23
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/pistol/cm23.ogg'
	rack_sound = 'sound/weapons/gun/pistol/candor_cocked.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	manufacturer = MANUFACTURER_MINUTEMAN
	load_sound = 'sound/weapons/gun/pistol/candor_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/candor_reload.ogg'
	eject_sound = 'sound/weapons/gun/pistol/candor_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/candor_unload.ogg'
	recoil_unwielded = 3

/obj/item/ammo_box/magazine/cm23
	name = "CM-23 pistol magazine (10mm)"
	desc = "An 10-round magazine magazine designed for the CM-70 pistol. These rounds do moderate damage, but struggle against armor."
	icon_state = "cm23_mag-1"
	base_icon_state = "cm23_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 10

/obj/item/ammo_box/magazine/cm23/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/gun/ballistic/automatic/pistol/cm70
	name = "CM-70 machine pistol"
	desc = "A burst-fire machine pistol. Chambered in 9mm."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm70"
	item_state = "clip_generic"
	mag_type = /obj/item/ammo_box/magazine/m9mm_cm70
	can_suppress = FALSE
	burst_size = 3
	burst_delay = 0.1 SECONDS
	fire_delay = 0.4 SECONDS
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	default_firemode = FIREMODE_SEMIAUTO
	manufacturer = MANUFACTURER_MINUTEMAN

	fire_sound = 'sound/weapons/gun/pistol/cm70.ogg'

	spread = 8
	spread_unwielded = 20

/obj/item/ammo_box/magazine/m9mm_cm70
	name = "CM-70 machine pistol magazine (9mm)"
	desc = "A 18-round magazine designed for the CM-70 machine pistol. These rounds do okay damage, but struggle against armor."
	icon_state = "cm70_mag_18"
	base_icon_state = "cm70_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 18

/obj/item/ammo_box/magazine/m9mm_cm70/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

//########### SMGS ###########//
/obj/item/gun/ballistic/automatic/smg/cm5
	name = "\improper CM-5"
	desc = "The standard issue SMG of CLIP. One of the few firearm designs that were left mostly intact from the designs found on the UNSV Lichtenstein. Chambered in 9mm."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm5"
	item_state = "cm5"

	mag_type = /obj/item/ammo_box/magazine/smgm9mm
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'sound/weapons/gun/smg/smg_heavy.ogg'
	manufacturer = MANUFACTURER_MINUTEMAN

	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

EMPTY_GUN_HELPER(automatic/smg/cm5)

/obj/item/gun/ballistic/automatic/smg/cm5/compact
	name = "\improper CM-5c"
	desc = "The compact conversion of the CM-5. While not exactly restricted, it is looked down upon due to CLIP's doctrine on medium-longrange combat, however it excels at close range and is very lightweight. You feel like this gun is mildly unfinished. Chambered in 9mm."
	w_class = WEIGHT_CLASS_NORMAL
	spread = 25
	spread_unwielded = 40

	fire_delay = 0.08 SECONDS

	recoil = 1
	recoil_unwielded = 2
	wield_delay = 0.2 SECONDS
	wield_slowdown = 0.15

//########### MARKSMAN ###########//
/obj/item/gun/ballistic/automatic/marksman/gal
	name = "CM-F4"
	desc = "The standard issue DMR of CLIP. Dates back to the Xenofauna War, this particular model is in a carbine configuration, and, as such, is shorter than the standard model. Chambered in .308."

	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	icon_state = "gal"
	item_state = "gal"
	show_magazine_on_sprite = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/gal
	fire_sound = 'sound/weapons/gun/rifle/gal.ogg'
	burst_size = 0
	actions_types = list()
	manufacturer = MANUFACTURER_MINUTEMAN

	wield_slowdown = 2
	spread = -4
	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

/obj/item/gun/ballistic/automatic/marksman/gal/inteq
	name = "\improper SsG-04"
	desc = "A marksman rifle purchased from CLIP and modified to suit IRMG's needs. Chambered in .308."
	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'
	icon_state = "gal-inteq"
	item_state = "gal-inteq"

/obj/item/gun/ballistic/automatic/marksman/f90
	name = "CM-F90"
	desc = "CLIP's standard issue sniper rifle. It is semi auto and uses a very high caliber bullet which generates enough force to pierce a lot of armor, but the force is an issue when firing rapidly semi auto. The magzine is only 5 rounds as well, so don't use all of them too eagerly. Chambered in 6.5 CLIP."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "f90"
	item_state = "f90"

	fire_sound = 'sound/weapons/gun/sniper/cmf90.ogg'

	mag_type = /obj/item/ammo_box/magazine/f90

	fire_delay = 1 SECONDS

	manufacturer = MANUFACTURER_MINUTEMAN
	spread = -5
	spread_unwielded = 35
	recoil = 4
	recoil_unwielded = 10
	wield_slowdown = 1
	wield_delay = 1.3 SECONDS

/obj/item/ammo_box/magazine/f90
	name = "\improper CM-F90 Magazine (6.5 CLIP)"
	desc = "A large 5-round box magazine for the CM-F90 sniper rifles. These rounds deal amazing damage, knocking targets on their feet, very rarely delimbing them, and bypass half protective equipment, though it isn't a high enough caliber to pierce armored vehicles."
	base_icon_state = "f90_mag"
	icon_state = "f90_mag-1"
	ammo_type = /obj/item/ammo_casing/a65clip
	caliber = "6.5CLIP"
	max_ammo = 5

/obj/item/ammo_box/magazine/f90/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_casing/a65clip
	name = "6.5 CLIP bullet casing"
	desc = "A 6.5 CLIP bullet casing."
	icon_state = "big-brass"
	caliber = "6.5CLIP"
	projectile_type = /obj/projectile/bullet/a65clip

/obj/projectile/bullet/a65clip
	name = "6.5 CLIP bullet"
	speed = 0.3
	stamina = 10
	damage = 40
	armour_penetration = 50

	icon_state = "redtrac"
	light_system = MOVABLE_LIGHT
	light_color = COLOR_SOFT_RED
	light_range = 2

//########### RIFLES ###########//
/obj/item/gun/ballistic/automatic/assault/cm82
	name = "\improper CM-82"
	desc = "An assault rifle pattern from Sol, existing before the Night of Fire. A favorite of professional mercenaries and well-heeled pirates. Chambered in 5.56mm."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	fire_sound = 'sound/weapons/gun/rifle/m16.ogg'
	icon_state = "cm82"
	item_state = "cm82"
	show_magazine_on_sprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/p16
	spread = 2
	wield_delay = 0.5 SECONDS

	fire_delay = 0.18 SECONDS

	rack_sound = 'sound/weapons/gun/rifle/m16_cocked.ogg'
	load_sound = 'sound/weapons/gun/rifle/m16_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/m16_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/m16_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/m16_unload.ogg'

/obj/item/gun/ballistic/automatic/hmg/cm40
	name = "\improper CM-40"
	desc = "CLIP's standard issue LMG, for heavy duty cover fire. Its weight, bulk, and robust fire rate make it difficult to handle without using the bipod in a prone position or against appropriate cover such as a table. Chambered in 7.62x40mm CLIP."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm40"
	item_state = "cm40"

	fire_delay = 0

	fire_sound = 'sound/weapons/gun/hmg/cm40.ogg'
	rack_sound = 'sound/weapons/gun/hmg/cm40_cocked.ogg'

	rack_sound_vary = FALSE

	load_sound_vary = FALSE
	eject_sound_vary = FALSE

	load_sound = 'sound/weapons/gun/hmg/cm40_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/hmg/cm40_reload.ogg'
	eject_sound = 'sound/weapons/gun/hmg/cm40_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/hmg/cm40_unload.ogg'

	fire_delay = 0.1 SECONDS

	show_magazine_on_sprite = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	manufacturer = MANUFACTURER_MINUTEMAN
	mag_type = /obj/item/ammo_box/magazine/cm40_762_40_box

	spread = 10
	spread_unwielded = 35

	recoil = 2 //identical to other LMGS
	recoil_unwielded = 7 //same as skm

	wield_slowdown = 1 //not as severe as other lmgs, but worse than the normal skm
	wield_delay = 0.9 SECONDS //faster than normal lmgs, slower than stock skm

	has_bipod = TRUE

	deploy_recoil_bonus = -2
	deploy_spread_bonus = -6

/obj/item/gun/ballistic/automatic/hmg/cm40/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.1 SECONDS)
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/ammo_box/magazine/cm40_762_40_box
	name = "CM-40 box magazine (7.62x40mm CLIP)"
	desc = "An 80 round box magazine for CM-40 light machine gun. These rounds do good damage with good armor penetration."
	base_icon_state = "cm40_mag"
	icon_state = "cm40_mag-1"
	ammo_type = /obj/item/ammo_casing/a762_40
	max_ammo = 80
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/cm40_762_40_box/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

//########### MISC ###########//

/obj/item/gun/ballistic/shotgun/cm15
	name = "\improper CM-15"
	desc = "A standard-issue shotgun of CLIP, most often used by boarding crews. Only compatible with specialized 8-round magazines."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm15"
	item_state = "cm15"

	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

	manufacturer = MANUFACTURER_MINUTEMAN

	weapon_weight = WEAPON_MEDIUM
	can_suppress = FALSE
	mag_type = /obj/item/ammo_box/magazine/cm15_mag

	empty_indicator = FALSE
	unique_mag_sprites_for_variants = FALSE

	semi_auto = TRUE
	internal_magazine = FALSE
	casing_ejector = TRUE
	tac_reloads = TRUE
	pickup_sound =  'sound/items/handling/rifle_pickup.ogg'

	load_sound = 'sound/weapons/gun/rifle/ar_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/ar_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/ar_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/ar_unload.ogg'

	rack_sound = 'sound/weapons/gun/rifle/ar_cock.ogg'

	spread = 4
	spread_unwielded = 16
	recoil = 1
	recoil_unwielded = 4
	wield_slowdown = 0.6
	wield_delay = 0.65 SECONDS

