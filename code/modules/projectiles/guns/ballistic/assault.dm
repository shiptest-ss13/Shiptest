/obj/item/gun/ballistic/automatic/assault
	bad_type = /obj/item/gun/ballistic/automatic/assault

	show_magazine_on_sprite = TRUE
	w_class = WEIGHT_CLASS_BULKY

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO
	wield_delay = 0.8 SECONDS
	wield_slowdown = RIFLE_SLOWDOWN
	aimed_wield_slowdown = RIFLE_AIM_SLOWDOWN

	zoom_amt = RIFLE_ZOOM

	fire_delay = 0.2 SECONDS

	load_sound = 'sound/weapons/gun/rifle/ar_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/ar_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/ar_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/ar_unload.ogg'

	rack_sound = 'sound/weapons/gun/rifle/ar_cock.ogg'
	spread_unwielded = 20

	gunslinger_recoil_bonus = 2
	gunslinger_spread_bonus = 16

	light_range = 2
	wear_minor_threshold = 200
	wear_major_threshold = 600
	wear_maximum = 1200

/obj/item/gun/ballistic/automatic/assault/fa2
	name = "\improper FA2"
	desc = "An obsolete model of assault rifle once used by CLIP. Legendary for its durability and low cost, surplus rifles are commonplace on the Frontier, and the design has been widely copied. Chambered in 7.62x40mm CLIP."
	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/frontier_import/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/frontier_import/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/frontier_import/onmob.dmi'

	fire_sound = 'sound/weapons/gun/rifle/skm.ogg'

	rack_sound = 'sound/weapons/gun/rifle/skm_cocked.ogg'
	load_sound = 'sound/weapons/gun/rifle/skm_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/skm_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/skm_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/skm_unload.ogg'

	icon_state = "fa2"
	item_state = "fa2"
	show_magazine_on_sprite = TRUE
	unique_mag_sprites_for_variants = TRUE
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	manufacturer = MANUFACTURER_IMPORT
	default_ammo_type = /obj/item/ammo_box/magazine/fa2_762_40
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/fa2_762_40,
	)

	unique_reskin = list(\
		"fa2" = "fa2",
		"Polymer" = "fa2_polymer",
		"Bright" = "fa2_bright",
		)
	unique_reskin_flags = UNIQUE_RESKIN_CHANGES_INHAND

	//truly a doohickey for every occasion
	unique_attachments = list (
		/obj/item/attachment/energy_bayonet,
	)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_SCOPE = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 18,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 33,
			"y" = 15,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 22,
		)
	)

	spread = 1
	wield_delay = 0.7 SECONDS

	fire_delay = 0.2 SECONDS

/obj/item/gun/ballistic/automatic/assault/fa2/no_mag
	default_ammo_type = FALSE

/obj/item/gun/ballistic/automatic/assault/fa2/pirate
	autowiki_hidden = TRUE //not obtainable: referenced nowhere in code or maps
	name = "\improper Chopper"
	desc = "An FA2 in a state of shockingly poor repair: Several parts are missing and the 'grip' is improvised from scrap wood. It's a miracle it still works at all. Chambered in 7.62x40mm CLIP."

	icon_state = "chopper"
	item_state = "chopper"
	manufacturer = MANUFACTURER_NONE
	wear_rate = 2

/obj/item/gun/ballistic/automatic/assault/fa2/inteq
	name = "\improper KS-24 Ridgeback"
	desc = "An obsolete model of assault rifle once used by CLIP. Most of these were seized from Frontiersmen armories or purchased in CLIP, then modified to IRMG standards. Chambered in 7.62x40mm CLIP."

	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'

	icon_state = "ridgeback"
	item_state = "ridgeback"
	manufacturer = MANUFACTURER_INTEQ

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

/obj/item/gun/ballistic/automatic/assault/needle
	name = "\improper FL-R Needle"
	desc = "A rifle of Reh'himl origin, recently manufactured by the Lixsur'sha Worskhop. Firing a barrage of four flechettes, It has excellent hit probability and accuracy at longer distances. While excellent in design, the Needle has been criticized for its lack of modularity and expensive maintenance."
	icon = 'icons/obj/guns/manufacturer/lixsurworkshop/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/lixsurworkshop/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/lixsurworkshop/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/lixsurworkshop/onmob.dmi'
	icon_state = "needle"
	item_state = "needle"
	spread = 4
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	default_ammo_type = /obj/item/ammo_box/magazine/needle
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/needle,
	)
	wear_rate = 1.5 //not as bad as the literal garbage rifle but its got more than usual
	fire_sound = 'sound/weapons/gun/rifle/skm_smg.ogg'
	suppressed_sound = 'sound/weapons/gun/pistol/shot_suppressed.ogg'

	load_sound = 'sound/weapons/gun/smg/cm5_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/cm5_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/cm5_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/cm5_unload.ogg'

	manufacturer = MANUFACTURER_WORKSHOP
	slot_available = list(ATTACHMENT_SLOT_MUZZLE = 1)
	default_attachments = list(/obj/item/attachment/silencer/cobra) //they'll all be integrally suppressed. They're not getting much attachment freedom
	unique_attachments = list(/obj/item/attachment/silencer/cobra)

NO_MAG_GUN_HELPER(automatic/assault/needle)

/obj/item/ammo_box/magazine/needle
	name = "Needle autorifle magazine (5.8x42mm)"
	desc = "A 40 round helical magazine for the FL-R Needle."
	icon_state = "needlemag-1"
	base_icon_state = "needlemag"
	ammo_type = /obj/item/ammo_casing/needle
	caliber = "needle"
	max_ammo = 40
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/needle/empty
	start_empty = TRUE
