#define CLIP_ATTACHMENTS list(/obj/item/attachment/silencer, /obj/item/attachment/laser_sight, /obj/item/attachment/rail_light, /obj/item/attachment/bayonet, /obj/item/attachment/ammo_counter,/obj/item/attachment/gun)
#define CLIP_ATTACHMENT_POINTS list(ATTACHMENT_SLOT_MUZZLE = 1,ATTACHMENT_SLOT_RAIL = 1,ATTACHMENT_SLOT_SCOPE=1)


//########### PISTOLS ###########//
/obj/item/gun/ballistic/automatic/pistol/cm23
	name = "\improper CM-23"
	desc = "CLIP's standard service pistol. 10 rounds of 10mm ammunition make the CM-23 deadlier than many other service pistols, but its weight and bulk have made it unpopular as a sidearm. It has largely been phased out outside of specialized units and patrols on the fringes of CLIP space. Chambered in 10mm."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm23"
	item_state = "clip_generic"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo_type = /obj/item/ammo_box/magazine/cm23
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/cm23,
	)
	fire_sound = 'sound/weapons/gun/pistol/cm23.ogg'
	rack_sound = 'sound/weapons/gun/pistol/candor_cocked.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	manufacturer = MANUFACTURER_MINUTEMAN
	load_sound = 'sound/weapons/gun/pistol/candor_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/candor_reload.ogg'
	eject_sound = 'sound/weapons/gun/pistol/candor_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/candor_unload.ogg'

	default_attachments = list(/obj/item/attachment/laser_sight)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		),
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 29,
			"y" = 20,
		)
	)

	recoil_unwielded = 3

/obj/item/gun/ballistic/automatic/pistol/cm23/no_mag
	default_ammo_type = FALSE

/obj/item/ammo_box/magazine/cm23
	name = "CM-23 pistol magazine (10x22mm)"
	desc = "An 10-round magazine magazine designed for the CM-23 pistol. These rounds do moderate damage, but struggle against armor."
	icon_state = "cm23_mag-1"
	base_icon_state = "cm23_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10x22mm"
	max_ammo = 10

/obj/item/ammo_box/magazine/cm23/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm23/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/pistol/cm70
	name = "CM-70 machine pistol"
	desc = "A compact machine pistol designed to rapidly fire 3-round bursts. Popular with officers and certain special units, the CM-70 is incredibly dangerous at close range. Chambered in 9mm."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'
	icon_state = "cm70"
	item_state = "clip_generic"
	default_ammo_type = /obj/item/ammo_box/magazine/m9mm_cm70
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m9mm_cm70,
	)
	burst_size = 3
	burst_delay = 0.1 SECONDS
	fire_delay = 0.4 SECONDS
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	default_firemode = FIREMODE_SEMIAUTO
	manufacturer = MANUFACTURER_MINUTEMAN

	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

	fire_sound = 'sound/weapons/gun/pistol/cm70.ogg'

	spread = 8
	spread_unwielded = 20

	wear_minor_threshold = 240
	wear_major_threshold = 720
	wear_maximum = 1200

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 23,
			"y" = 17,
		),
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 31,
			"y" = 21,
		)
	)

/obj/item/ammo_box/magazine/m9mm_cm70
	name = "CM-70 machine pistol magazine (9x18mm)"
	desc = "A 18-round magazine designed for the CM-70 machine pistol. These rounds do okay damage, but struggle against armor."
	icon_state = "cm70_mag_18"
	base_icon_state = "cm70_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9x18mm"
	max_ammo = 18


/obj/item/ammo_box/magazine/m9mm_cm70/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

/obj/item/ammo_box/magazine/m9mm_cm70/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/pistol/cm357
	name = "\improper CM-357"
	desc = "A powerful semi-automatic handgun designed for CLIP-BARD's megafauna removal unit, as standard handguns had proven ineffective as backup weapons. The heft and power of the weapon have made it a status symbol among the few CLIP officers able to requisition one. Chambered in .357."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm357"
	item_state = "clip_generic"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo_type = /obj/item/ammo_box/magazine/cm357
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/cm357,
	)
	fire_sound = 'sound/weapons/gun/pistol/deagle.ogg'
	rack_sound = 'sound/weapons/gun/pistol/candor_cocked.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	manufacturer = MANUFACTURER_MINUTEMAN
	load_sound = 'sound/weapons/gun/pistol/candor_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/candor_reload.ogg'
	eject_sound = 'sound/weapons/gun/pistol/candor_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/candor_unload.ogg'

	recoil_unwielded = 4
	recoil = 1

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 23,
			"y" = 16,
		)
	)

NO_MAG_GUN_HELPER(automatic/pistol/cm357)

/obj/item/ammo_box/magazine/cm357
	name = "CM-357 pistol magazine (.357)"
	desc = "A 7-round magazine designed for the CM-357 pistol. These rounds do good damage, but struggle against armor."
	icon_state = "cm23_mag-1"
	base_icon_state = "cm23_mag"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = ".357"
	max_ammo = 7
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/cm357/empty
	start_empty = TRUE

//########### SMGS ###########//
/obj/item/gun/ballistic/automatic/smg/cm5
	name = "\improper CM-5"
	desc = "CLIP's standard-issue submachine gun. Well-liked for its accuracy, stability, and ease of use compared to other submachineguns. Chambered in 9mm."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm5"
	item_state = "cm5"

	default_ammo_type = /obj/item/ammo_box/magazine/cm5_9mm
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/cm5_9mm,
	)
	bolt_type = BOLT_TYPE_CLIP
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'sound/weapons/gun/smg/cm5.ogg'
	manufacturer = MANUFACTURER_MINUTEMAN

	spread = 3
	spread_unwielded = 7

	valid_attachments = CLIP_ATTACHMENTS
	slot_available = CLIP_ATTACHMENT_POINTS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 38,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 27,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 12,
			"y" = 23,
		)
	)

	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

NO_MAG_GUN_HELPER(automatic/smg/cm5)

/obj/item/gun/ballistic/automatic/smg/cm5/rubber
	default_ammo_type = /obj/item/ammo_box/magazine/cm5_9mm/rubber

/obj/item/ammo_box/magazine/cm5_9mm
	name = "CM-5 magazine (9x18mm)"
	desc = "A 30-round magazine for the CM-5 submachine gun. These rounds do okay damage, but struggle against armor."
	icon_state = "cm5_mag-1"
	base_icon_state = "cm5_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9x18mm"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/cm5_9mm/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/cm5_9mm/rubber
	desc = "A 30-round magazine for the CM-5 submachine gun. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	caliber = "9x18mm rubber"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/gun/ballistic/automatic/smg/cm5/compact
	name = "\improper CM-5c"
	desc = "A modification of the CM-5 featuring a dramatically shortened barrel and removed stock. Designed for CLIP-GOLD covert enforcement agents to maximize portability without sacrificing firepower, though accuracy at range is abysmal at best. Chambered in 9mm."
	icon_state = "cm5c"
	item_state = "cm5c"

	w_class = WEIGHT_CLASS_NORMAL
	spread = 10
	spread_unwielded = 20

	fire_delay = 0.1 SECONDS

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 30,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 22,
			"y" = 17,
		)
	)


	recoil = 1
	recoil_unwielded = 2
	wield_delay = 0.2 SECONDS
	wield_slowdown = 0.15

	var/obj/item/storage/briefcase/current_case

NO_MAG_GUN_HELPER(automatic/smg/cm5/compact)

/obj/item/gun/ballistic/automatic/smg/cm5/compact/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(current_case)
		return
	if(!istype(attacking_item, /obj/item/storage/briefcase))
		return
	if(attacking_item.contents.len != 0)
		return
	to_chat(user, span_notice("...? You rig [src] to fire from within [attacking_item]."))
	current_case = attacking_item
	attacking_item.forceMove(src)
	icon = attacking_item.icon
	base_icon_state = attacking_item.icon_state
	item_state = attacking_item.item_state
	name = attacking_item.name
	lefthand_file = attacking_item.lefthand_file
	righthand_file = attacking_item.righthand_file
	pickup_sound = attacking_item.pickup_sound
	drop_sound = attacking_item.drop_sound
	w_class = WEIGHT_CLASS_BULKY

//how are you even supposed to hold it like this...?
	spread += 10
	spread_unwielded +=10

	cut_overlays()
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/cm5/compact/AltClick(mob/user)
	if(!current_case)
		return ..()
	user.put_in_hands(current_case)
	icon = src::icon
	base_icon_state = src::icon_state
	item_state = src::item_state
	name = src::name
	lefthand_file = src::lefthand_file
	righthand_file = src::righthand_file
	pickup_sound = src::pickup_sound
	drop_sound = src::drop_sound
	w_class = WEIGHT_CLASS_NORMAL

	spread = src::spread
	spread_unwielded = src::spread_unwielded
	to_chat(user, span_notice("You remove the [current_case] from [src]"))
	current_case = null

	cut_overlays()
	update_appearance()


//########### MARKSMAN ###########//
/obj/item/gun/ballistic/automatic/marksman/f4
	name = "CM-F4"
	desc = "CLIP's marksman rifle, used by both military and law enforcement units. Designed not long after the CM-24, the venerable F4 has adapted well to continued upgrades. Chambered in .308."

	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "f4"
	item_state = "f4"
	show_magazine_on_sprite = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	bolt_type = BOLT_TYPE_CLIP
	default_ammo_type = /obj/item/ammo_box/magazine/f4_308
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/f4_308,
	)
	fire_sound = 'sound/weapons/gun/rifle/f4.ogg'
	burst_size = 0
	actions_types = list()
	manufacturer = MANUFACTURER_MINUTEMAN

	valid_attachments = CLIP_ATTACHMENTS
	slot_available = CLIP_ATTACHMENT_POINTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 17,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 35,
			"y" = 16,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 18,
			"y" = 22,
		)
	)

	zoom_amt = 6
	zoom_out_amt = 2
	wield_slowdown = DMR_SLOWDOWN
	spread = -4
	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

/obj/item/gun/ballistic/automatic/marksman/f4/inteq
	name = "\improper SsG-04"
	desc = "An F4 rifle purchased from CLIP and modified to suit IRMG's needs. Chambered in .308."
	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'
	icon_state = "f4_inteq"
	item_state = "f4_inteq"

NO_MAG_GUN_HELPER(automatic/marksman/f4/inteq)

/obj/item/gun/ballistic/automatic/marksman/f4/indie
	name = "\improper F3"
	desc = "An old model of CLIP's F4 rifle, designed very early into the history of the League. Most have been sold off as surplus by this point and tend to suffer from internal wear due to their age. Chambered in .308."
	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/frontier_import/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/frontier_import/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/frontier_import/onmob.dmi'

	icon_state = "f4_indie"
	item_state = "f4_indie"

	wear_rate = 1.5

/obj/item/gun/ballistic/automatic/marksman/f90
	name = "CM-F90"
	desc = "A powerful sniper rifle used by vanishingly rare CLIP specialists, capable of impressive range and penetrating power. Chambered in 6.5mm CLIP."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "f90"
	item_state = "f90"

	fire_sound = 'sound/weapons/gun/sniper/cmf90.ogg'

	default_ammo_type = /obj/item/ammo_box/magazine/f90
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/f90,
	)
	bolt_type = BOLT_TYPE_CLIP

	fire_delay = 1 SECONDS

	manufacturer = MANUFACTURER_MINUTEMAN
	spread = -5
	spread_unwielded = 35
	recoil = 2
	recoil_unwielded = 10
	wield_slowdown = LIGHT_SNIPER_SLOWDOWN
	wield_delay = 1.3 SECONDS

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 16,
		),
	)

	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

/obj/item/ammo_box/magazine/f90
	name = "\improper CM-F90 Magazine (6.5x57mm CLIP)"
	desc = "A large 5-round box magazine for the CM-F90 sniper rifles. These rounds deal amazing damage and bypass half of their protective equipment, though it isn't a high enough caliber to pierce armored vehicles."
	base_icon_state = "f90_mag"
	icon_state = "f90_mag-1"
	ammo_type = /obj/item/ammo_casing/a65clip
	caliber = "6.5mm CLIP"
	max_ammo = 5

/obj/item/ammo_box/magazine/f90/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/f90/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/marksman/f90/inteq
	name = "\improper SSG-08 Saluki"
	desc = "A powerful sniper purchased from CLIP, lightly modified with superficial modifications and an IRMG paintjob by the Artificer Division. Chambered in 6.5mm."
	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'

	icon_state = "saluki"
	item_state = "saluki"

	manufacturer = MANUFACTURER_INTEQ

//########### RIFLES ###########//
/obj/item/gun/ballistic/automatic/assault/cm82
	name = "\improper CM-82"
	desc = "CLIP's standard assault rifle, a relatively new service weapon. Accurate, reliable, and easy to use, the CM-82 replaced the CM-24 as CLIP's assault rifle almost overnight, and has proven immensely popular since. Chambered in 5.56mm."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	fire_sound = 'sound/weapons/gun/rifle/cm82.ogg'
	icon_state = "cm82"
	item_state = "cm82"
	show_magazine_on_sprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	bolt_type = BOLT_TYPE_CLIP
	default_ammo_type = /obj/item/ammo_box/magazine/p16
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/p16,
	)
	spread = 2
	wield_delay = 0.5 SECONDS

	fire_delay = 0.18 SECONDS

	valid_attachments = CLIP_ATTACHMENTS
	slot_available = CLIP_ATTACHMENT_POINTS

	load_sound = 'sound/weapons/gun/rifle/cm82_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/cm82_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/cm82_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/cm82_unload.ogg'

	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 47,
			"y" = 19,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 29,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 15,
			"y" = 24,
		)
	)

/obj/item/gun/ballistic/automatic/assault/skm/cm24
	name = "\improper CM-24"
	desc = "An obsolete and very rugged assault rifle with a heavy projectile and slow action for its class. Once CLIP's standard assault rifle produced in phenomenal numbers for the First Frontiersman War, it now serves as an acceptable, if rare, battle rifle. Chambered in 7.62mm CLIP."

	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm24"
	item_state = "cm24"
	manufacturer = MANUFACTURER_NONE

	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

NO_MAG_GUN_HELPER(automatic/assault/skm/cm24)

/obj/item/gun/ballistic/automatic/hmg/cm40
	name = "\improper CM-40"
	desc = "A light machine gun used by CLIP heavy weapons teams, capable of withering suppressive fire. The weight and recoil make it nearly impossible to use without deploying the bipod against appropriate cover, such as a table, or bracing against solid cover. Chambered in 7.62x40mm CLIP."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "cm40"
	item_state = "cm40"

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
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	manufacturer = MANUFACTURER_MINUTEMAN
	default_ammo_type = /obj/item/ammo_box/magazine/cm40_762_40_box
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/cm40_762_40_box,
	)

	spread = 10
	spread_unwielded = 35

	recoil = 2 //identical to other LMGS
	recoil_unwielded = 7 //same as skm

	wield_slowdown = SAW_SLOWDOWN //not as severe as other lmgs, but worse than the normal skm
	wield_delay = 0.9 SECONDS //faster than normal lmgs, slower than stock skm

	has_bipod = TRUE

	//you get the rail slot back when the bipod is an attachment
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_SCOPE = 1
	)


	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 19,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 12,
			"y" = 25,
		)
	)

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

/obj/item/ammo_box/magazine/cm40_762_40_box/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/hmg/rottweiler
	name = "\improper KM-05 Rottweiler"
	desc = "An F4 rifle purchased from CLIP and extensively modified into a belt fed machine gun. Heavy and firing a powerful cartridge, this weapon is unwieldy without a bipod support. Uniquely, the KM-05 Rottweiler can accept F4 magazines into the magazine well."
	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'

	icon_state = "rottweiler"
	item_state = "rottweiler"

	manufacturer = MANUFACTURER_INTEQ

	show_magazine_on_sprite = TRUE
	show_magazine_on_sprite_ammo = TRUE
	mag_display_ammo = TRUE


	fire_sound = 'sound/weapons/gun/hmg/hmg.ogg'

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	fire_delay = 0.2 SECONDS //chunky machine gun

	unique_mag_sprites_for_variants = TRUE

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	bolt_type = BOLT_TYPE_CLIP
	tac_reloads = FALSE

	default_ammo_type = /obj/item/ammo_box/magazine/rottweiler_308_box
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/rottweiler_308_box,
		/obj/item/ammo_box/magazine/f4_308
	)

	spread = 12
	spread_unwielded = 35

	recoil = 3 //it's firing .308
	recoil_unwielded = 8

	has_bipod = TRUE

	deploy_recoil_bonus = -3
	deploy_spread_bonus = -10 //2 degree spread when deployed, making it VERY accurate for an lmg

	valid_attachments = CLIP_ATTACHMENTS
	unique_attachments = list(/obj/item/attachment/scope)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_SCOPE = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 49,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 19,
			"y" = 21,
		)
	)
/obj/item/gun/ballistic/automatic/hmg/rottweiler/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/ammo_box/magazine/rottweiler_308_box
	name = "Rottweiler box magazine (.308)"
	desc = "A 50 round box magazine for Rottweiler machine gun. These rounds do good damage with significant armor penetration."
	base_icon_state = "rottweiler_mag"
	icon_state = "rottweiler_mag-1"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = ".308"
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/rottweiler_308_box/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/rottweiler_308_box/empty
	start_empty = TRUE

//########### MISC ###########//

/obj/item/gun/ballistic/shotgun/cm15
	name = "\improper CM-15"
	desc = "A large automatic shotgun used by CLIP. Generally employed by law enforcement and breaching specialists, and rarely by CLIP-BARD (typically with incendiary ammunition). Chambered in 12 gauge."
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
	default_ammo_type = /obj/item/ammo_box/magazine/cm15_12g
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/cm15_12g,
	)

	empty_indicator = FALSE
	unique_mag_sprites_for_variants = FALSE

	show_magazine_on_sprite = TRUE
	semi_auto = TRUE
	internal_magazine = FALSE
	casing_ejector = TRUE
	tac_reloads = TRUE

	pickup_sound = 'sound/items/handling/rifle_pickup.ogg'
	fire_sound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	load_sound = 'sound/weapons/gun/rifle/ar_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/ar_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/ar_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/ar_unload.ogg'
	rack_sound = 'sound/weapons/gun/rifle/ar_cock.ogg'

	spread = 3
	spread_unwielded = 15
	recoil = 1
	recoil_unwielded = 4
	wield_slowdown = HEAVY_SHOTGUN_SLOWDOWN
	wield_delay = 0.65 SECONDS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 34,
			"y" = 15,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 44,
			"y" = 19,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 21,
			"y" = 25,
		)
	)

/obj/item/gun/ballistic/shotgun/cm15/no_mag
	default_ammo_type = FALSE

/obj/item/gun/ballistic/shotgun/cm15/incendiary
	default_ammo_type = /obj/item/ammo_box/magazine/cm15_12g/incendiary


