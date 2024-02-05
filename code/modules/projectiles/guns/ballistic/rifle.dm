/obj/item/gun/ballistic/rifle
	name = "Bolt Rifle"
	desc = "Some kind of bolt-action rifle. You get the feeling you shouldn't have this."
	icon_state = "hunting"
	item_state = "hunting"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction
	bolt_wording = "bolt"
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = FALSE
	internal_magazine = TRUE
	fire_sound = 'sound/weapons/gun/rifle/mosin.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	rack_sound = 'sound/weapons/gun/rifle/bolt_out.ogg'
	bolt_drop_sound = 'sound/weapons/gun/rifle/bolt_in.ogg'
	tac_reloads = FALSE
	weapon_weight = WEAPON_MEDIUM
	pickup_sound =  'sound/items/handling/rifle_pickup.ogg'

	spread = -1
	spread_unwielded = 12
	recoil = -3
	recoil_unwielded = 4
	wield_slowdown = 1
	wield_delay = 1.2 SECONDS

/obj/item/gun/ballistic/rifle/update_overlays()
	. = ..()
	. += "[icon_state]_bolt[bolt_locked ? "_locked" : ""]"

/obj/item/gun/ballistic/rifle/rack(mob/user = null)
	if (bolt_locked == FALSE)
		to_chat(user, "<span class='notice'>You open the bolt of \the [src].</span>")
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
		process_chamber(FALSE, FALSE, FALSE)
		bolt_locked = TRUE
		update_appearance()
		return
	drop_bolt(user)

/obj/item/gun/ballistic/rifle/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/rifle/attackby(obj/item/A, mob/user, params)
	if (!bolt_locked)
		to_chat(user, "<span class='notice'>The bolt is closed!</span>")
		return
	return ..()

/obj/item/gun/ballistic/rifle/examine(mob/user)
	. = ..()
	. += "The bolt is [bolt_locked ? "open" : "closed"]."

/obj/item/gun/ballistic/rifle/boltaction
	name = "\improper Illestren Hunting Rifle"
	desc = "One of Hunter's Pride most successful firearms. The bolt-action is popular among colonists, pirates, snipers, and countless more. Chambered in 7.62x54."
	sawn_desc = "An extremely sawn-off Illestren, generally known as an \"obrez\". There was probably a reason it wasn't made this short to begin with."
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	icon = 'icons/obj/guns/48x32guns.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "hunting"
	item_state = "hunting"
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction
	can_bayonet = TRUE
	knife_x_offset = 27
	knife_y_offset = 13
	can_be_sawn_off = TRUE
	manufacturer = MANUFACTURER_HUNTERSPRIDE

/obj/item/gun/ballistic/rifle/boltaction/sawoff(mob/user)
	. = ..()
	if(.)
		spread = 36
		can_bayonet = FALSE
		item_state = "hunting_sawn"

/obj/item/gun/ballistic/rifle/boltaction/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

/obj/item/gun/ballistic/rifle/boltaction/solgov
	name = "SSG-669C"
	desc = "A bolt-action sniper rifle used by Solarian troops. Beloved for its rotary design and accuracy. Chambered in 8x58mm Caseless."
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/solgov
	icon_state = "ssg669c"
	item_state = "ssg669c"
	fire_sound = 'sound/weapons/gun/rifle/ssg669c.ogg'
	can_be_sawn_off = FALSE

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	manufacturer = MANUFACTURER_SOLARARMORIES
	spread = -5
	spread_unwielded = 20
	recoil = 0
	recoil_unwielded = 4
	wield_slowdown = 1
	wield_delay = 1.3 SECONDS

/obj/item/gun/ballistic/rifle/boltaction/roumain
	name = "standard-issue 'Smile' rifle"
	desc = "A bolt-action rifle usually given to mercenary hunters of the Saint-Roumain Militia. Chambered in .300 Magnum."
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/smile
	icon_state = "roma"
	item_state = "roma"
	can_be_sawn_off = FALSE

	manufacturer = MANUFACTURER_HUNTERSPRIDE

/obj/item/gun/ballistic/rifle/boltaction/polymer
	name = "polymer survivor rifle"
	desc = "A bolt-action rifle made of scrap, desperation, and luck. Likely to shatter at any moment. Chambered in .300 Blackout."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "crackhead_rifle"
	item_state = "crackhead_rifle"
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/polymer
	can_be_sawn_off = FALSE
	manufacturer = MANUFACTURER_NONE
