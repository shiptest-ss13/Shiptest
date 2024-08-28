
/obj/item/gun/ballistic/automatic/marksman
	burst_size = 1
	zoomable = TRUE //this var as true without setting anything else produces a 2x zoom
	wield_slowdown = 2
	wield_delay = 1 SECONDS

// SNIPER //

/obj/item/gun/ballistic/automatic/marksman/ebr //fuck this gun, its getting wiped soon enough
	name = "\improper M514 EBR"
	desc = "A reliable, high-powered battle rifle often found in the hands of Syndicate personnel and remnants, chambered in .308. Effective against personnel and armor alike."

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'

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

EMPTY_GUN_HELPER(automatic/marksman/ebr)
