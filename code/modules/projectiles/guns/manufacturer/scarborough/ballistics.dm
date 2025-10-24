#define SCARBOROUGH_ATTACHMENTS list(/obj/item/attachment/silencer, /obj/item/attachment/laser_sight, /obj/item/attachment/rail_light, /obj/item/attachment/bayonet, /obj/item/attachment/energy_bayonet, /obj/item/attachment/gun, /obj/item/attachment/ammo_counter)
#define SCARBOROUGH_ATTACH_SLOTS list(ATTACHMENT_SLOT_MUZZLE = 1, ATTACHMENT_SLOT_SCOPE = 1, ATTACHMENT_SLOT_RAIL = 1)

//########### PISTOLS ###########//
/obj/item/gun/ballistic/automatic/pistol/ringneck
	name = "PC-76 \"Ringneck\""
	desc = "A compact handgun used by most Syndicate-affiliated groups. Small enough to conceal in most pockets, making it popular for covert elements and simply as a compact defensive weapon. Chambered in 10x22mm."
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "ringneck"
	item_state = "sa_generic"

	w_class = WEIGHT_CLASS_SMALL
	default_ammo_type = /obj/item/ammo_box/magazine/m10mm_ringneck
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m10mm_ringneck,
	)

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
	show_magazine_on_sprite = TRUE

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 27,
			"y" = 23,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 25,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 21,
			"y" = 19,
		)
	)


	spread = 6 //becuase its compact, spread is slightly worse
	spread_unwielded = 9
	recoil_unwielded = 2

NO_MAG_GUN_HELPER(automatic/pistol/ringneck)

/obj/item/gun/ballistic/automatic/pistol/ringneck/indie
	name = "Ringneck-76"
	desc = "A service handgun popular among law enforcement, mercenaries, and independent spacers with discerning tastes. Chambered in 10x22mm."

	icon_state = "ringneck76"
	item_state = "sa_indie"

	w_class = WEIGHT_CLASS_NORMAL

	spread = 5 //this one is normal sized, thus in theory its better, in theory at least
	spread_unwielded = 7
	recoil_unwielded = 3

NO_MAG_GUN_HELPER(automatic/pistol/ringneck/indie)


/obj/item/ammo_box/magazine/m10mm_ringneck
	name = "Ringneck pistol magazine (10x22mm)"
	desc = "An 8-round magazine for the Ringneck pistol. These rounds do moderate damage, but struggle against armor."
	icon_state = "ringneck_mag-1"
	base_icon_state = "ringneck_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10x22mm"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m10mm_ringneck/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/pistol/asp
	name = "BC-81 \"Asp\""
	desc = "An armor-piercing combat handgun once used by Syndicate strike teams, now primarily used by descendants of the Gorlex Marauders. Chambered in 5.7mm."

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "asp"
	item_state = "sa_generic"

	default_ammo_type = /obj/item/ammo_box/magazine/m57_39_asp
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m57_39_asp,
	)

	fire_sound = 'sound/weapons/gun/pistol/asp.ogg'

	load_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'

	manufacturer = MANUFACTURER_SCARBOROUGH
	show_magazine_on_sprite = TRUE

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	unique_attachments = list(/obj/item/attachment/scope)
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 32,
			"y" = 23,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 15,
			"y" = 26,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 23,
			"y" = 19,
		)
	)

NO_MAG_GUN_HELPER(automatic/pistol/asp)

/obj/item/ammo_box/magazine/m57_39_asp
	name = "Asp magazine (5.7x39mm)"
	desc = "A 12-round, double-stack magazine for the Asp pistol. These rounds do okay damage with average performance against armor."
	icon_state = "asp_mag-12"
	base_icon_state = "asp_mag"
	ammo_type = /obj/item/ammo_casing/c57x39mm
	caliber = "5.7x39mm"
	max_ammo = 12

/obj/item/ammo_box/magazine/m57_39_asp/update_icon_state()
	. = ..()
	if(ammo_count() == 12)
		icon_state = "[base_icon_state]-12"
	else if(ammo_count() >= 10)
		icon_state = "[base_icon_state]-10"
	else if(ammo_count() >= 5)
		icon_state = "[base_icon_state]-5"
	else if(ammo_count() >= 1)
		icon_state = "[base_icon_state]-1"
	else
		icon_state = "[base_icon_state]-0"

/obj/item/ammo_box/magazine/m57_39_asp/empty
	start_empty = TRUE

/obj/item/gun/ballistic/revolver/viper
	name = "R-23 \"Viper\""
	desc = "An imposing revolver used by officers and certain agents of Syndicate member factions during the ICW, still favored by captains and high-ranking officers of the former Syndicate. Chambered in .357 Magnum."

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'

	icon_state = "viper"
	item_state = "sa_generic"

	fire_sound = 'sound/weapons/gun/revolver/viper.ogg'
	rack_sound = 'sound/weapons/gun/revolver/viper_prime.ogg'
	load_sound = 'sound/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/weapons/gun/revolver/empty.ogg'

	dry_fire_sound = 'sound/weapons/gun/revolver/dry_fire.ogg'

	fire_delay = 0.35 SECONDS

	spread = 3
	spread_unwielded = 8
	recoil = 1
	recoil_unwielded = 2

	semi_auto = TRUE //double action
	safety_wording = "safety"

/obj/item/gun/ballistic/revolver/viper/no_mag
	spawn_no_ammo = TRUE

/obj/item/gun/ballistic/revolver/viper/indie
	name = "Viper-23"
	desc = "A powerful bull-barrel revolver. Very popular among mercenaries and the occasional well-to-do spacer or pirate for its flashy appearance and powerful cartridge. Chambered in .357 Magnum."

	icon_state = "viper23"
	item_state = "viper23"
	spread = 5
	spread_unwielded = 10

/obj/item/gun/ballistic/revolver/viper/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/ammo_hud/revolver)

/obj/item/gun/ballistic/revolver/viper/indie/no_mag
	spawn_no_ammo = TRUE

/obj/item/gun/ballistic/automatic/pistol/rattlesnake
	name = "MP-84 \"Rattlesnake\""
	desc = "A machine pistol, once used by Syndicate infiltrators and special forces during the ICW. Still used by specialists in former Syndicate factions. Chambered in 9x18mm."

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'

	icon_state = "rattlesnake"
	item_state = "rattlesnake"

	default_ammo_type = /obj/item/ammo_box/magazine/m9mm_rattlesnake
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m9mm_rattlesnake,
	)

	fire_sound = 'sound/weapons/gun/pistol/rattlesnake.ogg'
	dry_fire_sound = 'sound/weapons/gun/pistol/dry_fire.ogg'
	suppressed_sound = 'sound/weapons/gun/pistol/shot_suppressed.ogg'

	load_sound = 'sound/weapons/gun/pistol/mag_insert_alt.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert_alt.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release_alt.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release_alt.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'

	show_magazine_on_sprite = TRUE

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	unique_attachments = list(/obj/item/attachment/scope)
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 40,
			"y" = 26,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 14,
			"y" = 29,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 22,
			"y" = 21,
		)
	)

	burst_size = 3
	burst_delay = 0.1 SECONDS
	fire_delay = 0.4 SECONDS
	wear_minor_threshold = 240
	wear_major_threshold = 720
	wear_maximum = 1200
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	default_firemode = FIREMODE_SEMIAUTO

NO_MAG_GUN_HELPER(automatic/pistol/rattlesnake)

/obj/item/gun/ballistic/automatic/pistol/rattlesnake/inteq
	name = "MP-84m Kingsnake"
	desc = "A machine pistol obtained from Syndicate stockpiles and lightly modified to Inteq standards. Generally issued only to specialists. Chambered in 9x18mm."

	icon_state = "rattlesnake_inteq"
	item_state = "rattlesnake_inteq"

NO_MAG_GUN_HELPER(automatic/pistol/rattlesnake/inteq)

/obj/item/gun/ballistic/automatic/pistol/rattlesnake/cottonmouth
	name = "MP-84m Cottonmouth"
	desc = "A machine pistol obtained from Marauder stockpiles and heavily modified by elements of the Ramzi Clique to accept a larger calibre, with a few largely-ignored drawbacks of 2-round burst and magazine capacity. Chambered in 10x22mm."

	icon_state = "cottonmouth"
	item_state = "cottonmouth"

	fire_sound = 'sound/weapons/gun/pistol/asp.ogg'

	default_ammo_type = /obj/item/ammo_box/magazine/m10mm_cottonmouth
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m10mm_cottonmouth,
	)

	wear_rate = 1.5

	recoil = 0.5
	recoil_unwielded = 3
	burst_size = 2
	burst_delay = 0.1 SECONDS
	fire_delay = 0.4 SECONDS

/obj/item/ammo_box/magazine/m9mm_rattlesnake
	name = "Rattlesnake magazine (9x18mm)"
	desc = "A long, 18-round double-stack magazine designed for the Rattlesnake machine pistol. These rounds do okay damage, but struggle against armor."
	icon_state = "rattlesnake_mag_18"
	base_icon_state = "rattlesnake_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9x18mm"
	max_ammo = 18
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m9mm_rattlesnake/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

/obj/item/ammo_box/magazine/m9mm_rattlesnake/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m10mm_cottonmouth
	name = "Cottonmouth magazine (10x22mm)"
	desc = "A long, 14-round double-stack magazine designed for the Cottonmouth modified machine pistol. These rounds do moderate damage, but struggle against armor."
	icon_state = "rattlesnake_mag_18"
	base_icon_state = "rattlesnake_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10x22mm"
	max_ammo = 14
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m10mm_cottonmouth/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

/obj/item/ammo_box/magazine/m10mm_cottonmouth/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/pistol/himehabu
	name = "PC-81 \"Himehabu\""
	desc = "An astonishingly compact machine pistol firing ultra-light projectiles, designed to be as small and concealable as possible while remaining a credible threat at very close range. Armor penetration is practically non-existent. Chambered in .22."

	icon_state = "himehabu"
	item_state = "sa_generic"

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'


	w_class = WEIGHT_CLASS_SMALL
	default_ammo_type = /obj/item/ammo_box/magazine/m22lr_himehabu
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m22lr_himehabu,
	)
	fire_sound = 'sound/weapons/gun/pistol/himehabu.ogg'

	load_sound = 'sound/weapons/gun/pistol/mag_insert_alt.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert_alt.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release_alt.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release_alt.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'

	show_magazine_on_sprite = TRUE

	valid_attachments = list(
		/obj/item/attachment/silencer,
	)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_SCOPE = 1,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 28,
			"y" = 22,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 12,
			"y" = 25,
		)
	)

	recoil = -2
	recoil_unwielded = -2
	spread_unwielded = 0
	wield_slowdown = 0

NO_MAG_GUN_HELPER(automatic/pistol/himehabu)

/obj/item/ammo_box/magazine/m22lr_himehabu
	name = "pistol magazine (.22 LR)"
	desc = "A single-stack handgun magazine designed to chamber .22 LR. It's rather tiny, all things considered."
	icon_state = "himehabu_mag-10"
	base_icon_state = "himehabu_mag"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = "22lr"
	max_ammo = 10
	w_class = WEIGHT_CLASS_SMALL
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/m22lr_himehabu/empty
	start_empty = TRUE

//########### SMGS ###########//


/obj/item/gun/ballistic/automatic/smg/cobra
	name = "C-20r \"Cobra\""
	desc = "A bullpup submachine gun with an integrated suppressor, heavily used by Syndicate strike teams during the ICW. Still sees widespread use by the descendants of the Gorlex Marauders. Chambered in .45."
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "cobra"
	item_state = "cobra"

	default_ammo_type = /obj/item/ammo_box/magazine/m45_cobra
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m45_cobra,
	)

	fire_sound = 'sound/weapons/gun/smg/cobra.ogg'

	load_sound = 'sound/weapons/gun/smg/cm5_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/cm5_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/cm5_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/cm5_unload.ogg'

	show_magazine_on_sprite = TRUE
	show_magazine_on_sprite_ammo = TRUE
	show_ammo_capacity_on_magazine_sprite = TRUE
	manufacturer = MANUFACTURER_SCARBOROUGH

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	default_attachments = list(/obj/item/attachment/silencer/cobra)
	unique_attachments = list(/obj/item/attachment/silencer/cobra)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 27,
			"y" = 23,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 28,
			"y" = 16,
		)
	)

NO_MAG_GUN_HELPER(automatic/smg/cobra)

/obj/item/gun/ballistic/automatic/smg/cobra/indie
	name = "Cobra-20"
	desc = "An older model of submachine gun manufactured by Scarborough Arms and marketed to mercenaries, law enforcement, and independent militia. Only became popular after the end of the ICW. Chambered in .45."
	icon_state = "cobra20"
	item_state = "cobra20"
	burst_size = 3
	burst_delay = 1.75

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	gun_firenames = list(FIREMODE_SEMIAUTO = "single", FIREMODE_BURST = "burst")
	default_firemode = FIREMODE_BURST
	default_attachments = null
	valid_attachments = SCARBOROUGH_ATTACHMENTS
	unique_attachments = null


NO_MAG_GUN_HELPER(automatic/smg/cobra/indie)


/obj/item/ammo_box/magazine/m45_cobra

/obj/item/ammo_box/magazine/m45_cobra
	name = "Cobra magazine (.45)"
	desc = "A 24-round magazine for the Cobra submachine gun. These rounds do moderate damage, but struggle against armor."
	icon_state = "cobra_mag-24"
	base_icon_state = "cobra_mag"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 24

/obj/item/ammo_box/magazine/m45_cobra/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/m45_cobra/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/smg/sidewinder
	name = "CDW-81 \"Sidewinder\""
	desc = "An armor-piercing, compact personal defense weapon, introduced late into the Inter-Corporate War as an improvement over the C-20r when fighting armored personnel. Issued only in small numbers, and used today by specialists of former Syndicate factions. Chambered in 5.7mm."
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "sidewinder"
	item_state = "sidewinder"

	default_ammo_type = /obj/item/ammo_box/magazine/m57_39_sidewinder
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m57_39_sidewinder,
	)

	fire_sound = 'sound/weapons/gun/smg/sidewinder.ogg'

	load_sound = 'sound/weapons/gun/smg/sidewinder_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/sidewinder_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/sidewinder_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/sidewinder_unload.ogg'

	rack_sound = 'sound/weapons/gun/smg/sidewinder_cocked.ogg'

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL

	show_magazine_on_sprite = TRUE
	show_magazine_on_sprite_ammo = TRUE
	show_ammo_capacity_on_magazine_sprite = TRUE
	manufacturer = MANUFACTURER_SCARBOROUGH

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	unique_attachments = list(
		/obj/item/attachment/foldable_stock/sidewinder
	)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_STOCK = 1,
		ATTACHMENT_SLOT_SCOPE = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 44,
			"y" = 18,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 35,
			"y" = 17,
		),
		ATTACHMENT_SLOT_STOCK = list(
			"x" = 17,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 21,
			"y" = 24,
		)
	)

	spread = 7
	spread_unwielded = 10

	recoil = 0
	recoil_unwielded = 4

	default_attachments = list(/obj/item/attachment/foldable_stock/sidewinder)


NO_MAG_GUN_HELPER(automatic/smg/sidewinder)

/obj/item/ammo_box/magazine/m57_39_sidewinder
	name = "Sidewinder magazine (5.7x39mm)"
	desc = "A 30-round magazine for the Sidewinder personal defense weapon. These rounds do okay damage with average performance against armor."
	icon_state = "sidewinder_mag-1"
	base_icon_state = "sidewinder_mag"
	ammo_type = /obj/item/ammo_casing/c57x39mm
	caliber = "5.7x39mm"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m57_39_sidewinder/empty
	start_empty = TRUE

//########### MARKSMAN ###########//
/obj/item/gun/ballistic/automatic/marksman/boomslang
	name = "MSR-90 \"Boomslang\""
	desc = "A bullpup semi-automatic sniper rifle with a high-magnification scope. Compact and capable of rapid follow-up fire without sacrificing power. Used by Syndicate support units and infiltrators during the ICW. Chambered in 6.5mm CLIP."

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'

	icon_state = "boomslang"
	item_state = "boomslang"

	fire_sound = 'sound/weapons/gun/sniper/cmf90.ogg'

	default_ammo_type = /obj/item/ammo_box/magazine/boomslang
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/boomslang,
	)
	w_class = WEIGHT_CLASS_BULKY

	fire_delay = 1 SECONDS

	show_magazine_on_sprite = TRUE
	unique_mag_sprites_for_variants = TRUE
	show_ammo_capacity_on_magazine_sprite = TRUE
	manufacturer = MANUFACTURER_SCARBOROUGH
	spread = -5
	spread_unwielded = 35
	recoil = 2
	recoil_unwielded = 10
	wield_slowdown = LIGHT_SNIPER_SLOWDOWN
	wield_delay = 1.3 SECONDS

	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 19,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 28,
			"y" = 10,
		)
	)

NO_MAG_GUN_HELPER(automatic/marksman/boomslang)

/obj/item/gun/ballistic/automatic/marksman/boomslang/indie
	name = "Boomslang-90"
	desc = "A modern semi-automatic hunting rifle. Its relative portability and fast follow-up potential compared to other weapons in its class have made it very popular with well-to-do hunters and the occasional law enforcement agency or mercenary. Chambered in 6.5mm CLIP."

	icon_state = "boomslang90"
	item_state = "boomslang90"

	zoom_amt = 6
	zoom_out_amt = 2

NO_MAG_GUN_HELPER(automatic/marksman/boomslang/indie)

/obj/item/ammo_box/magazine/boomslang
	name = "\improper Boomslang Magazine (6.5mm CLIP)"
	desc = "A large 10-round box magazine for Boomslang sniper rifles. These rounds deal amazing damage and can pierce protective equipment, excluding armored vehicles."
	base_icon_state = "boomslang"
	icon_state = "boomslang-10"
	ammo_type = /obj/item/ammo_casing/a65clip
	caliber = "6.5mm CLIP"
	max_ammo = 10
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/boomslang/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/boomslang/short
	name = "\improper Boomslang Magazine (6.5mm CLIP)"
	desc = "A 5-round box magazine for Boomslang sniper rifles. These rounds deal amazing damage and can pierce protective equipment, excluding armored vehicles."
	base_icon_state = "boomslang_short"
	icon_state = "boomslang_short-5"
	ammo_type = /obj/item/ammo_casing/a65clip
	caliber = "6.5mm CLIP"
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/boomslang/short/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/marksman/taipan
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
	default_ammo_type = /obj/item/ammo_box/magazine/sniper_rounds
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/sniper_rounds,
	)
	w_class = WEIGHT_CLASS_BULKY
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5
	actions_types = list()
	show_magazine_on_sprite = TRUE
	manufacturer = MANUFACTURER_SCARBOROUGH
	wield_slowdown = AMR_SLOWDOWN

	show_ammo_capacity_on_magazine_sprite = TRUE

	spread = -5
	spread_unwielded = 40
	recoil = 5
	recoil_unwielded = 50

	wield_delay = 1.3 SECONDS

	valid_attachments = list()
	slot_available = list()

NO_MAG_GUN_HELPER(automatic/marksman/taipan)


//########### RIFLES ###########//
/obj/item/gun/ballistic/automatic/assault/hydra
	name = "SMR-80 \"Hydra\""
	desc = "Scarborough Arms' premier modular assault rifle platform. This is the basic configuration, optimized for light weight and handiness. A very well-regarded, if expensive and rare, assault rifle. Chambered in 5.56mm CLIP."

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "hydra"
	item_state = "hydra"

	default_ammo_type = /obj/item/ammo_box/magazine/m556_42_hydra
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m556_42_hydra,
	)
	gun_firenames = list(FIREMODE_SEMIAUTO = "single", FIREMODE_BURST = "burst fire", FIREMODE_FULLAUTO = "full auto")
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	//gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_OTHER)
	default_firemode = FIREMODE_SEMIAUTO
	show_magazine_on_sprite = FALSE //we do this to avoid making the same  of every sprite, see below

	load_sound = 'sound/weapons/gun/rifle/m16_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/m16_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/m16_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/m16_unload.ogg'

	fire_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	manufacturer = MANUFACTURER_SCARBOROUGH

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	burst_size = 2
	burst_delay = 0.1 SECONDS
	fire_delay = 0.18 SECONDS
	spread = 1
	spread_unwielded = 8
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 42,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 21,
			"y" = 24,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 30,
			"y" = 15,
		)
	)

NO_MAG_GUN_HELPER(automatic/assault/hydra)

//we hard code "hydra", why? because if not, i would need to duplicate the extended/short magazine sprites like 3 fucking times for every variant with a different icon state. this eases the spriting burden
/obj/item/gun/ballistic/automatic/assault/hydra/update_overlays()
	. = ..()
	if (magazine)
		. += "hydra_mag_[magazine.base_icon_state]"
		var/capacity_number = 0
		switch(get_ammo() / magazine.max_ammo)
			if(0.2 to 0.39)
				capacity_number = 20
			if(0.4 to 0.59)
				capacity_number = 40
			if(0.6 to 0.79)
				capacity_number = 60
			if(0.8 to 0.99)
				capacity_number = 80
			if(1.0 to 2.0) //to catch the chambered round
				capacity_number = 100
		if (capacity_number)
			. += "hydra_mag_[magazine.base_icon_state]_[capacity_number]"


/obj/item/gun/ballistic/automatic/assault/hydra/lmg
	name = "SAW-80 \"Hydra\""
	desc = "Scarborough Arms' premier modular assault rifle platform. This example is configured as a support weapon, with heavier components for sustained firing and a large muzzle brake. Chambered in 5.56mm CLIP."

	icon_state = "hydra_lmg"
	item_state = "hydra_lmg"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

	burst_delay = 0.08 SECONDS
	fire_delay = 0.08 SECONDS
	spread = 7
	spread_unwielded = 25
	recoil = 2
	recoil_unwielded = 4
	wield_slowdown = SAW_SLOWDOWN
	wield_delay = 0.9 SECONDS //ditto

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 19,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 21,
			"y" = 24,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 30,
			"y" = 15,
		)
	)

/obj/item/gun/ballistic/automatic/assault/hydra/lmg/extended
	default_ammo_type = /obj/item/ammo_box/magazine/m556_42_hydra/extended


/obj/item/gun/ballistic/automatic/assault/hydra/lmg/casket_mag
	default_ammo_type = /obj/item/ammo_box/magazine/m556_42_hydra/casket

/obj/item/gun/ballistic/automatic/assault/hydra/dmr
	name = "SBR-80 \"Hydra\""
	desc = "Scarborough Arms' premier modular assault rifle platform. This example is configured as a marksman rifle, with an extended barrel and medium-zoom scope. Its lightweight cartridge is compensated for with a 2-round burst action, though it is unable to fit large extended magazines. Chambered in 5.56mm CLIP."

	icon_state = "hydra_dmr"
	item_state = "hydra_dmr"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	default_firemode = FIREMODE_SEMIAUTO

	spread = 0
	spread_unwielded = 12
	wield_slowdown = DMR_SLOWDOWN //dmrrrr
	wield_delay = 0.85 SECONDS //above
	zoomable = TRUE
	zoom_amt = 6
	zoom_out_amt = 2
	default_ammo_type = /obj/item/ammo_box/magazine/m556_42_hydra/small
	blacklisted_ammo_types = list(
		/obj/item/ammo_box/magazine/m556_42_hydra/extended,
		/obj/item/ammo_box/magazine/m556_42_hydra/casket,
	)

NO_MAG_GUN_HELPER(automatic/assault/hydra/dmr)

/obj/item/gun/ballistic/automatic/assault/hydra/underbarrel_gl
	name = "SMR-80 \"Hydra\""
	desc = "Scarborough Arms' premier modular assault rifle platform. This is the basic configuration, optimized for light weight and handiness. A very well-regarded, if expensive and rare, assault rifle. This one has an underslung grenade launcher attached. Chambered in 5.56x42mm CLIP."

	default_attachments = list(/obj/item/attachment/gun/ballistic/launcher)

/obj/item/ammo_box/magazine/m556_42_hydra
	name = "Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A simple, 30-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon_state = "hydra_mag-30"
	base_icon_state = "hydra_mag"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = "5.56x42mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/m556_42_hydra/update_icon_state()
	. = ..()
	if(multiple_sprites == AMMO_BOX_FULL_EMPTY)
		return
	icon_state = "[base_icon_state]-[ammo_count() == 1 ? 1 : round(ammo_count(),5)]"

/obj/item/ammo_box/magazine/m556_42_hydra/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m556_42_hydra/small
	name = "Short Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A short, 20-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles; intended for the DMR variant. These rounds do moderate damage with good armor penetration."
	icon_state = "hydra_small_mag-20"
	base_icon_state = "hydra_small_mag"
	max_ammo = 20

/obj/item/ammo_box/magazine/m556_42_hydra/small/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m556_42_hydra/extended
	name = "extended Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A bulkier, 60-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon_state = "hydra_extended_mag-1"
	base_icon_state = "hydra_extended_mag"
	max_ammo = 60
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m556_42_hydra/extended/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m556_42_hydra/casket
	name = "casket Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A very long and bulky 100-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon_state = "hydra_casket_mag-1"
	base_icon_state = "hydra_casket_mag"
	max_ammo = 100
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	w_class = WEIGHT_CLASS_NORMAL

//########### MISC ###########//
// Bulldog shotgun //

/obj/item/gun/ballistic/shotgun/automatic/bulldog
	name = "SG-60r \"Bulldog\""
	desc = "A bullpup combat shotgun usually seen with a characteristic drum magazine. Wildly popular among Syndicate strike teams during the ICW, although it proved less useful against military-grade equipment. Still popular among former Syndicate factions, especially the Ramzi Clique pirates. Chambered in 12g."
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "bulldog"
	item_state = "bulldog"

	weapon_weight = WEAPON_MEDIUM
	default_ammo_type = /obj/item/ammo_box/magazine/m12g_bulldog
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m12g_bulldog,
	)
	fire_delay = 0.4 SECONDS // this NEEDS the old delay.
	fire_sound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	show_magazine_on_sprite = TRUE
//	empty_indicator = TRUE
	empty_alarm = TRUE
	unique_mag_sprites_for_variants = TRUE
	show_ammo_capacity_on_magazine_sprite = TRUE
	internal_magazine = FALSE
	casing_ejector = TRUE
	tac_reloads = TRUE
	pickup_sound =  'sound/items/handling/rifle_pickup.ogg'
	manufacturer = MANUFACTURER_SCARBOROUGH

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

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	unique_attachments = list(/obj/item/attachment/scope)
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 44,
			"y" = 19,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 25,
			"y" = 24,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 30,
			"y" = 18,
		)
	)

/obj/item/gun/ballistic/shotgun/automatic/bulldog/drum
	default_ammo_type = /obj/item/ammo_box/magazine/m12g_bulldog/drum

NO_MAG_GUN_HELPER(shotgun/automatic/bulldog)

/obj/item/ammo_box/magazine/m12g_bulldog
	name = "shotgun box magazine (12g buckshot)"
	desc = "A single-stack, 8-round box magazine for the Bulldog shotgun and it's derivatives."
	icon_state = "bulldog_mag-1"
	base_icon_state = "bulldog_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "12ga"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m12g_bulldog/slug
	name = "shotgun box magazine (12g Slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/m12g_bulldog/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m12g_bulldog/drum
	name = "shotgun drum magazine (12g buckshot)"
	desc = "A bulky 12-round drum designed for the Bulldog shotgun and it's derivatives."
	icon_state = "bulldog_drum-1"
	base_icon_state = "bulldog_drum"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "12ga"
	max_ammo = 12
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m12g_bulldog/drum/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m12g_bulldog/drum/stun
	name = "shotgun drum magazine (12g taser slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/magazine/m12g_bulldog/drum/slug
	name = "shotgun drum magazine (12g slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/m12g_bulldog/drum/dragon
	name = "shotgun drum magazine (12g dragon's breath)"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/ammo_box/magazine/m12g_bulldog/drum/bioterror
	name = "shotgun drum magazine (12g bioterror)"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/bioterror

/obj/item/ammo_box/magazine/m12g_bulldog/drum/meteor
	name = "shotgun drum magazine (12g meteor slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun/meteorslug

/obj/item/gun/ballistic/rocketlauncher/mako
	name = "RR-86 \"Mako\""
	desc = "A large, four-tube rocket launcher, the Mako fires (relatively) small rockets filled with incendiary compound, designed to cause fires and deny enemy movement. Capable of causing significant damage to exosuits on impact, as well."

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'

	icon_state = "mako"
	item_state = "mako"
	default_ammo_type = /obj/item/ammo_box/magazine/internal/mako
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/mako,
	)
	fire_sound = 'sound/weapons/gun/general/rocket_launch.ogg'
	load_sound = 'sound/weapons/gun/general/rocket_load.ogg'
	w_class = WEIGHT_CLASS_BULKY
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO
	burst_size = 1
	fire_delay = 0.4 SECONDS
	casing_ejector = FALSE
	weapon_weight = WEAPON_HEAVY
	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	cartridge_wording = "rocket"
	empty_indicator = TRUE
	tac_reloads = FALSE
	manufacturer = MANUFACTURER_SCARBOROUGH


/obj/item/ammo_box/magazine/internal/mako
	name = "mako internal magazine"
	ammo_type = /obj/item/ammo_casing/caseless/rocket/a70mm
	caliber = "70mm"
	max_ammo = 4

/obj/item/ammo_casing/caseless/rocket/a70mm
	name = "\improper M-KO-9HE"
	desc = "A 70mm High Explosive rocket. Fire at mech and pray."
	icon_state = "srm-8"
	caliber = "70mm"
	projectile_type = /obj/projectile/bullet/a84mm_he
	auto_rotate = FALSE

/obj/item/ammo_casing/caseless/rocket/a70mm/hedp
	name = "\improper M-KO-9HEDP"
	desc = "A 70mm High Explosive Dual Purpose rocket. Pointy end toward armor."
	caliber = "70mm"
	icon_state = "84mm-hedp"
	projectile_type = /obj/projectile/bullet/a84mm

#undef SCARBOROUGH_ATTACHMENTS
#undef SCARBOROUGH_ATTACH_SLOTS
