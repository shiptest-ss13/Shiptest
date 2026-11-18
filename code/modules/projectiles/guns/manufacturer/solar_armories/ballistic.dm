#define SOLAR_ATTACHMENTS list(/obj/item/attachment/laser_sight,/obj/item/attachment/rail_light,/obj/item/attachment/bayonet,/obj/item/attachment/energy_bayonet,/obj/item/attachment/scope,/obj/item/attachment/gun)
#define SOLAR_ATTACH_SLOTS list(ATTACHMENT_SLOT_MUZZLE = 1, ATTACHMENT_SLOT_SCOPE = 1, ATTACHMENT_SLOT_RAIL = 1)

///SOLAR ARMORIES
//fuck you im not typing the full name out
//solarwaffledesuckenmydickengeschutzenweaponmanufacturinglocation

//
// MODERN SOLARIAN CONFEDERATION GUNS //
//

// HASENMATT - GAUSS PISTOL //
/obj/item/gun/ballistic/automatic/powered/gauss/modelh
	name = "Model 'Hasenmatt' Gauss Pistol"
	desc = "A standard-issue pistol exported from the Solarian Confederation. While rather small for a gauss gun it carries formidable stopping power thanks to its oversized ferromagnetic slugs. A popular choice for self-defense and police forces."

	icon_state = "model-h"
	item_state = "model-h"
	fire_sound = 'sound/weapons/gun/gauss/modelh.ogg'
	load_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'

	default_ammo_type = /obj/item/ammo_box/magazine/modelh
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/modelh)

	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	w_class = WEIGHT_CLASS_SMALL
	fire_delay = 0.4 SECONDS //pistol, but heavy caliber.
	show_magazine_on_sprite = FALSE
	manufacturer = MANUFACTURER_SOLARARMORIES
	recoil = 1
	recoil_unwielded = 4
	spread = 6
	spread_unwielded = 6
	fire_select_icon_state_prefix = "slug_"

	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
	)

	autowiki_hidden = FALSE

/obj/item/gun/ballistic/automatic/powered/gauss/modelh/no_mag
	default_ammo_type = FALSE

// EIGER - CASELESS PISTOL //
/obj/item/gun/ballistic/automatic/pistol/solgov
	name = "Model 'Eiger' Caseless Pistol"
	desc = "A Solarian handgun dating back to the Terran Confederacy. While no longer a primary service pistol, it still sees occasional use and is popular among civilians. Chambered in 5.56mm caseless."
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'
	icon_state = "model-e"
	item_state = "model-e"

	weapon_weight = WEAPON_LIGHT
	default_ammo_type = /obj/item/ammo_box/magazine/pistol556mm
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/pistol556mm)
	fire_sound = 'sound/weapons/gun/pistol/pistolec.ogg'
	manufacturer = MANUFACTURER_SOLARARMORIES
	load_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'

	fire_select_icon_state_prefix = "caseless_"

// CLARIS - GAUSS RIFLE //
/obj/item/gun/ballistic/automatic/powered/gauss/claris
	name = "Model 'Claris' Ferromagnetic Line Rifle"
	desc = "An antiquated Solarian gauss rifle. While long since shifted out of military service, the Claris still sees popularity among civilians as a hunting and self defense weapon. Chambered in ferromagnetic pellets."
	default_ammo_type = /obj/item/ammo_box/magazine/internal/claris
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/internal/claris)
	icon_state = "claris"
	item_state = "claris"
	fire_sound = 'sound/weapons/gun/gauss/claris.ogg'
	load_sound = 'sound/weapons/gun/gauss/sniper_reload.ogg'
	fire_delay = 0.36 SECONDS
	internal_magazine = TRUE
	show_magazine_on_sprite = FALSE
	manufacturer = MANUFACTURER_SOLARARMORIES
	fire_select_icon_state_prefix = "pellet_"

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	valid_attachments = SOLAR_ATTACHMENTS
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
	)

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	doesnt_keep_bullet = TRUE
	casing_ejector = TRUE

	autowiki_hidden = FALSE

// LUCERNE - GAUSS CARBINE //
/obj/item/gun/ballistic/automatic/powered/gauss/lucerne
	name = "Model 'Lucerne' Gauss Carbine"
	desc = "A modern Solarian military carbine, boasting a sizeable magazine capacity and rapid rate of fire. Uses magazines loaded with ferromagnetic lances."
	default_ammo_type = /obj/item/ammo_box/magazine/lucerne
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/lucerne)
	icon_state = "model-l"
	item_state = "model-l"
	fire_sound = 'sound/weapons/gun/gauss/gar.ogg'
	fire_sound_volume = 35
	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	burst_size = 1

	fire_delay = 0.2 SECONDS

	actions_types = list()
	manufacturer = MANUFACTURER_SOLARARMORIES

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	valid_attachments = SOLAR_ATTACHMENTS
	slot_available = SOLAR_ATTACH_SLOTS

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	wield_delay = 0.7 SECONDS
	fire_select_icon_state_prefix = "lance_"

	autowiki_hidden = FALSE

// JURA - CASELESS SNIPER //
/obj/item/gun/ballistic/rifle/modelj
	name = "Model 'Jura' Marksman Rifle"
	desc = "A bolt-action sniper rifle used by Solarian troops. Beloved for its unique rotary design and stellar accuracy. Chambered in 8x58mm Caseless."
	default_ammo_type = /obj/item/ammo_box/magazine/internal/boltaction/solgov
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/internal/boltaction/solgov)
	icon_state = "model-j"
	item_state = "model-j"
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'

	fire_sound = 'sound/weapons/gun/rifle/ssg669c.ogg'
	can_be_sawn_off = FALSE

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	manufacturer = MANUFACTURER_SOLARARMORIES
	spread = -5
	spread_unwielded = 20
	recoil = 1
	recoil_unwielded = 8
	wield_slowdown = SNIPER_SLOWDOWN
	wield_delay = 1.3 SECONDS

// ATELIER - HIGH POWERED RAILGUN //
/obj/item/gun/ballistic/automatic/powered/gauss/rail_cannon
	name = "Model 'Atelier' Railgun"
	desc = "A high powered Solarian railgun, designed for punching heavy armor, cover, and just about anything else. The heavy-duty electromagnets require time to calibrate before each shot, but the power behind each ferromagnetic rod is well worth the wait."

	default_ammo_type = /obj/item/ammo_box/magazine/internal/rail
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/internal/rail)

	gun_firemodes = list(FIREMODE_AIMED)
	default_firemode = FIREMODE_AIMED

	icon_state = "railgun"
	item_state = "railgun"

	manufacturer = MANUFACTURER_SOLARARMORIES
	spread = -5
	spread_unwielded = 10
	weapon_weight = WEAPON_HEAVY
	recoil = 1
	recoil_unwielded = 8
	wield_slowdown = SNIPER_SLOWDOWN
	wield_delay = 1.3 SECONDS
	doesnt_keep_bullet = TRUE
	aiming_time = 25
	aiming_time_fire_threshold = 10

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	fire_sound = 'sound/weapons/gun/general/tank_cannon.ogg'
	fire_sound_volume = 40

	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	show_magazine_on_sprite = FALSE

	refused_attachments = list(/obj/item/attachment/silencer)

	autowiki_hidden = FALSE

// BIELERSEE - GAUSS SCATTERGUN //

/obj/item/gun/ballistic/automatic/powered/gauss/bielersee
	name = "Model 'Bielersee' Magnetic Scattergun"
	desc = "A gauss scattergun of Solarian make for close-quarters engagements. Fires tight clusters of ferromagnetic flechettes."
	icon_state = "model-b"
	item_state = "model-b"
	manufacturer = MANUFACTURER_SOLARARMORIES
	default_ammo_type = /obj/item/ammo_box/magazine/internal/bielersee
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/internal/bielersee)
	unique_attachments = list(/obj/item/attachment/foldable_stock/bielersee)
	default_attachments = list(/obj/item/attachment/foldable_stock/bielersee)
	slot_offsets = list(
		ATTACHMENT_SLOT_STOCK = list(
			"x" = 6,
			"y" = 18,
		)
	)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_SCOPE = 1,
		ATTACHMENT_SLOT_STOCK = 1,
	)
	internal_magazine = TRUE
	w_class = WEIGHT_CLASS_NORMAL

	fire_delay = 0.5 SECONDS

// RUTLI - GAUSS SMG //

/obj/item/gun/ballistic/automatic/powered/gauss/rutli
	name = "Model 'Rutli' Submachine Gun"
	desc = "A lightweight Solarian gauss SMG. Features a large internal magazine and fast charging electronics allowing it to fire much faster than other gauss weaponry. Chambered in ferromagnetic pellets."
	icon_state = "model-r"
	item_state = "model-r"
	internal_magazine = TRUE
	manufacturer = MANUFACTURER_SOLARARMORIES
	default_ammo_type = /obj/item/ammo_box/magazine/internal/rutli
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/internal/rutli)
	fire_sound = 'sound/weapons/gun/cybersun/gauss.ogg'
	fire_sound_volume = 35
	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'

	fire_delay = 0.14 SECONDS
	burst_delay = 0.09
	burst_size = 4
	gun_firemodes = list(FIREMODE_BURST, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

// PANZERFAUST - ROCKET LAUNCHER //
/obj/item/gun/ballistic/rocketlauncher/solgov
	name = "Model 'Panzerfaust' RPG"
	desc = "The standard recoiless rifle of the Solarian Confederation. The design, while unorthodox, has remained nearly unchanged since its inception."

	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'

	//recoiless rifles use shells
	cartridge_wording = "shell"

	icon_state = "panzerfaust"
	item_state = "panzerfaust"
	manufacturer = MANUFACTURER_SOLARARMORIES
	mag_display_ammo = TRUE // rocket overlay

	autowiki_hidden = TRUE // aspawn only

//
// OLD TERRAN CONFEDERATION GUNS //
//

// OLD EIGER - CASELESS PISTOL //
/obj/item/gun/ballistic/automatic/pistol/solgov/old
	name = "Model E"
	desc = "An antique handgun manufactured in the Terran Confederacy. The design is nearly identical to the modern 'Eiger' pistols aside from the color of the furnishing. How this got all the way out here is hard to say. Chambered in 5.56mm caseless."
	icon_state = "model-e-old"
	item_state = "model-e-old"

// SWISS CHEESE - SURVIVAL RIFLE //
/obj/item/gun/ballistic/automatic/assault/swiss_cheese
	name = "\improper Swiss Cheese"
	desc = "An ancient longarm, once mass produced by the Terran Confederation. While most have broken down, a few well preserved models can still be found in the hands of dedicated collectors. Known for their excellent burst fire and integrated DMA unit, keeping it useful in times of logistical trouble. Chambered in 4.73x33mm caseless, and uses sharpened iron rods for the DMA."
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'
	fire_sound = 'sound/weapons/gun/rifle/swiss.ogg'
	fire_sound_volume = 35
	icon_state = "swiss"
	item_state = "swiss"
	show_magazine_on_sprite = TRUE
	burst_size = 3
	burst_delay = 0.04 SECONDS
	fire_delay = 0.25 SECONDS
	weapon_weight = WEAPON_MEDIUM
	gun_firenames = list(FIREMODE_SEMIAUTO = "matter semi-auto", FIREMODE_BURST = "matter burst fire", FIREMODE_FULLAUTO = "matter full auto")
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_FULLAUTO)

	fire_select_icon_state_prefix = "swisschesse_"

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	default_ammo_type = /obj/item/ammo_box/magazine/swiss
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/swiss,
	)
	default_attachments = list(/obj/item/attachment/gun/ballistic/swiss_cheese_dma)
	unique_attachments = list(/obj/item/attachment/gun/ballistic/swiss_cheese_dma)
	manufacturer = MANUFACTURER_SOLARARMORIES
	spread = 2
	spread_unwielded = 15

/obj/item/gun/ballistic/automatic/assault/swiss_cheese/examine(mob/examiner)
	. = ..()
	. += span_notice("You could <b>right click</b> a metal rod on it to sharpen it for use in the DMA.")

/obj/item/gun/ballistic/automatic/assault/attackby_secondary(obj/item/thingy, mob/user, params)
	if(istype(thingy, /obj/item/stack/rods))
		to_chat(user, span_notice("You begin sharpening a rod on [src]..."))
		var/obj/item/stack/rods/its_a_cylinder = thingy
		if(do_after(user, 1 SECONDS))
			if(!its_a_cylinder.use(1))
				to_chat(user, span_warning("The rod you were sharpening isn't there anymore! What the hell?"))
				return ..()
			to_chat(user, span_notice("You sharpen the rod."))
			playsound(src, 'sound/items/crowbar.ogg', 25, TRUE)
			var/obj/item/not_anymore = new /obj/item/ammo_casing/caseless/dma_rod
			user.put_in_hands(not_anymore)
			src.attackby_secondary(not_anymore, user, params) // load if we can
	else
		return ..()
