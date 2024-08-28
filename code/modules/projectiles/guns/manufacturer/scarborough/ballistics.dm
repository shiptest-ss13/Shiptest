//########### PISTOLS ###########//
/obj/item/gun/ballistic/automatic/pistol/syndicate
	name = "PC-76 \"Ringneck\""
	desc = "A compact handgun used by most Syndicate-affiliated groups. Small enough to conceal in most pockets, making it popular for covert elements and simply as a compact defensive weapon. Chambered in 10mm."
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "ringneck"
	item_state = "sa_generic"

	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/m10mm

	fire_sound = 'sound/weapons/gun/pistol/shot.ogg'
	dry_fire_sound = 'sound/weapons/gun/pistol/dry_fire.ogg'
	suppressed_sound = 'sound/weapons/gun/pistol/shot_suppressed.ogg'

	load_sound = 'sound/weapons/gun/pistol/mag_insert_alt.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert_alt.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release_alt.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release_alt.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'

	manufacturer = MANUFACTURER_SCARBOROUGH

	spread = 6 //becuase its compact, spread is slightly worse
	spread_unwielded = 9
	recoil_unwielded = 2

EMPTY_GUN_HELPER(automatic/pistol/syndicate)

/obj/item/ammo_box/magazine/m10mm

/obj/item/ammo_box/magazine/m10mm_ringneck
	name = "Ringneck pistol magazine (10mm)"
	desc = "An 10-round magazine for the Ringneck pistol. These rounds do moderate damage, but struggle against armor."
	icon_state = "ringneck_mag-1"
	base_icon_state = "ringneck_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m10mm_ringneck/empty
	start_empty = TRUE

/obj/item/gun/ballistic/revolver/syndicate
	name = "R-23 \"Viper\""
	desc = "An imposing revolver used by officers and certain agents of Syndicate member factions during the ICW, still favored by captains and high-ranking officers of the former Syndicate. Chambered in .357 Magnum."

	icon_state = "viper"
	item_state = "sa_generic"

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'

	semi_auto = TRUE //double action
	safety_wording = "safety"


/obj/item/gun/ballistic/automatic/pistol/APS
	name = "MP-84 \"Rattlesnake\""
	desc = "A machine pistol, once used by Syndicate infiltrators and special forces during the ICW. Still used by specialists in former Syndicate factions. Chambered in 9mm."

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'

	icon_state = "rattlesnake"
	item_state = "rattlesnake"

	mag_type = /obj/item/ammo_box/magazine/pistolm9mm

	fire_sound = 'sound/weapons/gun/pistol/shot.ogg'
	dry_fire_sound = 'sound/weapons/gun/pistol/dry_fire.ogg'
	suppressed_sound = 'sound/weapons/gun/pistol/shot_suppressed.ogg'

	load_sound = 'sound/weapons/gun/pistol/mag_insert_alt.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert_alt.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release_alt.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release_alt.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'

	burst_size = 3
	burst_delay = 0.1 SECONDS
	fire_delay = 0.4 SECONDS
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	default_firemode = FIREMODE_SEMIAUTO

/obj/item/gun/ballistic/automatic/pistol/syndicate/suns
	desc = "A small, easily concealable 10mm handgun that bears Scarborough Arms stamps. It is painted in the colors of SUNS."
	icon_state = "pistol_suns"

/obj/item/gun/ballistic/automatic/pistol/himehabu
	name = "PC-81 \"Himehabu\""
	desc = "An astonishingly compact machine pistol firing ultra-light projectiles, designed to be as small and concealable as possible while remaining a credible threat at very close range. Armor penetration is practically non-existent. Chambered in .22."

	icon_state = "himehabu"
	item_state = "sa_generic"

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'


	w_class = WEIGHT_CLASS_TINY
	mag_type = /obj/item/ammo_box/magazine/m22lr
	fire_sound = 'sound/weapons/gun/pistol/himehabu.ogg'

	load_sound = 'sound/weapons/gun/pistol/mag_insert_alt.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert_alt.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release_alt.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release_alt.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'

	recoil = -2
	recoil_unwielded = -2
	spread_unwielded = 0
	wield_slowdown = 0

//########### SMGS ###########//


/obj/item/gun/ballistic/automatic/smg/c20r
	name = "C-20r \"Cobra\""
	desc = "A bullpup submachine gun, heavily used by Syndicate strike teams during the ICW. Still sees widespread use by the descendants of the Gorlex Marauders. Chambered in .45."
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "c20r"
	item_state = "c20r"

	mag_type = /obj/item/ammo_box/magazine/smgm45
	show_magazine_on_sprite = TRUE
	show_magazine_on_sprite_ammo = TRUE
	empty_indicator = TRUE
	manufacturer = MANUFACTURER_SCARBOROUGH

EMPTY_GUN_HELPER(automatic/smg/c20r)

/obj/item/gun/ballistic/automatic/smg/c20r/Initialize()
	. = ..()
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/c20r/cobra
	name = "Cobra-20"
	desc = "An older model of submachine gun manufactured by Scarborough Arms and marketed to mercenaries, law enforcement, and independent militia. Only became popular after the end of the ICW. Chambered in .45."
	icon_state = "cobra20"
	item_state = "cobra20"

/obj/item/gun/ballistic/automatic/smg/c20r/cobra/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/smg/c20r/suns
	desc = "A bullpup .45 SMG designated 'C-20r.' Its buttstamp reads 'Scarborough Arms - Per falcis, per pravitas.' This one is painted in SUNS' colors."
	icon_state = "c20r_suns"
	item_state = "c20r_suns"

//########### MARKSMAN ###########//
/obj/item/gun/ballistic/automatic/marksman/f90
	name = "MSR-90 \"Boomslang\""
	desc = "A bullpup semi-automatic sniper rifle with a high-magnification scope. Compact and capable of rapid follow-up fire without sacrificing power. Used by Syndicate support units and infiltrators during the ICW. Chambered in 6.5mm CLIP."

	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'

	icon_state = "boomslang"
	item_state = "boomslang"

	fire_sound = 'sound/weapons/gun/sniper/cmf90.ogg'

	mag_type = /obj/item/ammo_box/magazine/f90
	bolt_type = BOLT_TYPE_CLIP

	fire_delay = 1 SECONDS

	manufacturer = MANUFACTURER_MINUTEMAN
	spread = -5
	spread_unwielded = 35
	recoil = 4
	recoil_unwielded = 10
	wield_slowdown = 1
	wield_delay = 1.3 SECONDS

	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

/obj/item/ammo_box/magazine/boomslang
	name = "\improper CM-F90 Magazine (6.5x57mm CLIP)"
	desc = "A large 5-round box magazine for the CM-F90 sniper rifles. These rounds deal amazing damage and bypass half of their protective equipment, though it isn't a high enough caliber to pierce armored vehicles."
	base_icon_state = "f90_mag"
	icon_state = "f90_mag-1"
	ammo_type = /obj/item/ammo_casing/a65clip
	caliber = "6.5CLIP"
	max_ammo = 5


/obj/item/gun/ballistic/automatic/marksman/sniper_rifle
	name = "AMR-83 \"Taipan\""
	desc = "A monstrous semi-automatic anti-materiel rifle, surprisingly short for its class. Designed to destroy mechs, light vehicles, and equipment, but more than capable of obliterating regular personnel. Chambered in .50 BMG."

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'

	icon_state = "taipan"
	item_state = "taipan"
	fire_sound = 'sound/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	load_sound = 'sound/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/weapons/gun/sniper/rack.ogg'
	suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	weapon_weight = WEAPON_HEAVY
	mag_type = /obj/item/ammo_box/magazine/sniper_rounds
	w_class = WEIGHT_CLASS_BULKY
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5
	slot_flags = ITEM_SLOT_BACK
	actions_types = list()
	show_magazine_on_sprite = TRUE
	manufacturer = MANUFACTURER_SCARBOROUGH

	spread = -5
	spread_unwielded = 40
	recoil = 5
	recoil_unwielded = 50

	wield_delay = 1.3 SECONDS

EMPTY_GUN_HELPER(automatic/marksman/sniper_rifle)


//########### RIFLES ###########//

/obj/item/gun/ballistic/automatic/smg/m90
	name = "\improper M-90gl Carbine"
	desc = "A three-round burst 5.56 toploading carbine, designated 'M-90gl'. Has an attached underbarrel grenade launcher which can be toggled on and off."
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "m90"
	item_state = "m90"

	mag_type = /obj/item/ammo_box/magazine/m556
	gun_firenames = list(FIREMODE_SEMIAUTO = "single", FIREMODE_BURST = "burst fire", FIREMODE_FULLAUTO = "full auto", FIREMODE_OTHER = "underbarrel grenade launcher")
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_OTHER)
	default_firemode = FIREMODE_SEMIAUTO
	var/obj/item/gun/ballistic/revolver/grenadelauncher/secondary
	show_magazine_on_sprite = TRUE
	empty_indicator = TRUE
	fire_sound = 'sound/weapons/gun/rifle/shot_alt.ogg'
	manufacturer = MANUFACTURER_SCARBOROUGH

	burst_size = 3
	burst_delay = 0.1 SECONDS
	fire_delay = 0.2 SECONDS
	spread = 1
	spread_unwielded = 8
	wield_slowdown = 0.4

/obj/item/gun/ballistic/automatic/smg/m90/Initialize()
	. = ..()
	secondary = new /obj/item/gun/ballistic/revolver/grenadelauncher(src)
	RegisterSignal(secondary, COMSIG_ATOM_UPDATE_ICON, PROC_REF(secondary_update_icon))
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/m90/process_other(atom/target, mob/living/user, message = TRUE, flag, params = null, zone_override = "", bonus_spread = 0)
	return secondary.pre_fire(target, user, message, params, zone_override, bonus_spread)

/obj/item/gun/ballistic/automatic/smg/m90/can_shoot()
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		return ..()
	return secondary.can_shoot()

/obj/item/gun/ballistic/automatic/smg/m90/afterattack(atom/target, mob/living/user, flag, params)
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		return ..()
	return secondary.afterattack(target, user, flag, params)

/obj/item/gun/ballistic/automatic/smg/m90/attackby(obj/item/attack_obj, mob/user, params)
	if(istype(attack_obj, secondary.magazine.ammo_type))
		secondary.unique_action()
		return secondary.attackby(attack_obj, user, params)
	return ..()


/obj/item/gun/ballistic/automatic/smg/m90/can_shoot()
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		return ..()
	return secondary.can_shoot()

/obj/item/gun/ballistic/automatic/smg/m90/on_wield(obj/item/source, mob/user)
	wielded = TRUE
	secondary.wielded = TRUE
	INVOKE_ASYNC(src, .proc.do_wield, user)

/obj/item/gun/ballistic/automatic/smg/m90/do_wield(mob/user)
	. = ..()
	secondary.wielded_fully = wielded_fully

/// triggered on unwield of two handed item
/obj/item/gun/ballistic/automatic/smg/m90/on_unwield(obj/item/source, mob/user)
	. = ..()
	secondary.wielded_fully = FALSE
	secondary.wielded = FALSE


/obj/item/gun/ballistic/automatic/smg/m90/proc/secondary_update_icon()
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

//########### MISC ###########//

/obj/item/gun/ballistic/rocketlauncher/mako
