/obj/item/gun/ballistic/automatic/smg
	bad_type = /obj/item/gun/ballistic/automatic/smg
	show_magazine_on_sprite = TRUE

	burst_size = 2
	actions_types = list()
	fire_delay = 0.1 SECONDS

	spread = 6
	spread_unwielded = 10
	wield_slowdown = SMG_SLOWDOWN
	aimed_wield_slowdown = SMG_AIM_SLOWDOWN
	zoom_amt = SMG_ZOOM
	recoil_unwielded = 4
	w_class = WEIGHT_CLASS_BULKY

	light_range = 1

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	wield_delay = 0.5 SECONDS

	load_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/smg_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/smg_unload.ogg'

	gunslinger_recoil_bonus = 2
	gunslinger_spread_bonus = 16
	wear_minor_threshold = 240
	wear_major_threshold = 720
	wear_maximum = 1200


/obj/item/gun/ballistic/automatic/smg/skm_carbine
	name = "\improper SKM-24v"
	desc = "The SKM-24v was a carbine modification of the SKM-24 during the Frontiersmen War. This, however, is just a shoddy imitation of that carbine, effectively an SKM-24 with a sawed down barrel and a folding wire stock. Can be fired with the stock folded, though accuracy suffers. Chambered in 4.6x30mm."

	icon_state = "skm_carbine"
	item_state = "skm_carbine"
	icon = 'icons/obj/guns/manufacturer/hermits/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hermits/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hermits/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hermits/onmob.dmi'
	fire_sound = 'sound/weapons/gun/rifle/skm_smg.ogg'

	rack_sound = 'sound/weapons/gun/rifle/skm_cocked.ogg'
	load_sound = 'sound/weapons/gun/rifle/skm_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/skm_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/skm_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/skm_unload.ogg'

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo_type = /obj/item/ammo_box/magazine/skm_46_30
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/skm_46_30,
	)

	recoil = 2
	recoil_unwielded = 6

	spread = 8
	spread_unwielded = 14

	wield_delay = 0.6 SECONDS
	wield_slowdown = SMG_SLOWDOWN

	wear_rate = 1.6

	unique_attachments = list(
		/obj/item/attachment/foldable_stock
		)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_STOCK = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 26,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		),
		ATTACHMENT_SLOT_STOCK = list(
			"x" = 11,
			"y" = 20,
		)
	)

	default_attachments = list(/obj/item/attachment/foldable_stock)

/obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq
	name = "\improper SKM-44v Mongrel"
	desc = "An SKM-44, further modified into a sub-machine gun by Inteq artificers with a new magazine well, collapsing stock, and shortened barrel. Faced with a surplus of SKM-44s and a shortage of other firearms, IRMG has made the most of their available materiel with conversions such as this. Chambered in 10x22mm."
	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'
	icon_state = "skm_inteqsmg"
	item_state = "skm_inteqsmg"

	default_ammo_type = /obj/item/ammo_box/magazine/smgm10mm
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/smgm10mm,
	)
	manufacturer = MANUFACTURER_INTEQ

	fire_sound = 'sound/weapons/gun/smg/vector_fire.ogg'

	load_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/smg_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/smg_unload.ogg'

	spread = 7
	spread_unwielded = 10

	recoil = 0
	recoil_unwielded = 4

	wield_delay = 0.4 SECONDS

	unique_attachments = list(
		/obj/item/attachment/foldable_stock/inteq
	)
	default_attachments = list(/obj/item/attachment/foldable_stock/inteq)

NO_MAG_GUN_HELPER(automatic/smg/skm_carbine/inteq)

//TODO: REMOVE
/obj/item/gun/ballistic/automatic/smg/skm_carbine/saber
	name = "\improper Nanotrasen Saber SMG"
	desc = "A prototype full-auto 9x18mm submachine gun, designated 'SABR'. Has a threaded barrel for suppressors and a folding stock."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "saber"
	item_state = "gun"

	default_ammo_type = /obj/item/ammo_box/magazine/m9mm_expedition
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m9mm_expedition,
	)

	fire_sound = 'sound/weapons/gun/smg/vector_fire.ogg'

	load_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/smg_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/smg_unload.ogg'

	spread = 7
	spread_unwielded = 10

	recoil = 0
	recoil_unwielded = 4

	wield_delay = 0.4 SECONDS

	unique_attachments = list(
		/obj/item/attachment/foldable_stock
	)
	default_attachments = list(/obj/item/attachment/foldable_stock)
	bolt_type = BOLT_TYPE_LOCKING
	show_magazine_on_sprite = TRUE
	manufacturer = MANUFACTURER_NANOTRASEN_OLD
