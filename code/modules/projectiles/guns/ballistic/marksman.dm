
/obj/item/gun/ballistic/automatic/marksman
	burst_size = 1
	zoomable = TRUE //this var as true without setting anything else produces a 2x zoom
	wield_slowdown = 2
	wield_delay = 1 SECONDS

// SNIPER //

/obj/item/gun/ballistic/automatic/sniper_rifle
	name = "sniper rifle"
	desc = "An anti-material rifle chambered in .50 BMG with a scope mounted on it. Its prodigious bulk requires both hands to use."
	icon_state = "sniper"
	item_state = "sniper"
	fire_sound = 'sound/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	load_sound = 'sound/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/weapons/gun/sniper/rack.ogg'
	suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	weapon_weight = WEAPON_HEAVY
	mag_type = /obj/item/ammo_box/magazine/sniper_rounds
	w_class = WEIGHT_CLASS_NORMAL
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

/obj/item/gun/ballistic/automatic/sniper_rifle/syndicate
	name = "syndicate sniper rifle"
	desc = "A heavily-modified .50 BMG anti-material rifle utilized by Syndicate agents. Requires both hands to fire."
	can_suppress = TRUE
	can_unsuppress = TRUE

EMPTY_GUN_HELPER(automatic/sniper_rifle/syndicate)


/obj/item/gun/ballistic/automatic/ebr //fuck this gun, its getting wiped soon enough
	name = "\improper M514 EBR"
	desc = "A reliable, high-powered battle rifle often found in the hands of Syndicate personnel and remnants, chambered in .308. Effective against personnel and armor alike."
	icon = 'icons/obj/guns/48x32guns.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	icon_state = "ebr"
	item_state = "ebr"
	zoomable = TRUE
	show_magazine_on_sprite = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/ebr
	fire_sound = 'sound/weapons/gun/rifle/shot_alt2.ogg'
	manufacturer = MANUFACTURER_SCARBOROUGH

	wield_slowdown = 2
	spread = -4

EMPTY_GUN_HELPER(automatic/ebr)

/obj/item/gun/ballistic/automatic/gal
	name = "\improper CM-GAL-S"
	desc = "The standard issue DMR of CLIP. Dates back to the Xenofauna War, this particular model is in a carbine configuration, and, as such, is shorter than the standard model. Chambered in .308."
	icon = 'icons/obj/guns/48x32guns.dmi'
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

/obj/item/gun/ballistic/automatic/gal/inteq
	name = "\improper SsG-04"
	desc = "A marksman rifle purchased from CLIP and modified to suit IRMG's needs. Chambered in .308."
	icon_state = "gal-inteq"
	item_state = "gal-inteq"
