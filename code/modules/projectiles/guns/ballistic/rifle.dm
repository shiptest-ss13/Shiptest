/obj/item/gun/ballistic/rifle
	name = "Bolt Rifle"
	desc = "Some kind of bolt-action rifle. You get the feeling you shouldn't have this."
	icon = 'icons/obj/guns/48x32guns.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "hunting"
	item_state = "hunting"
	default_ammo_type = /obj/item/ammo_box/magazine/internal/boltaction
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/boltaction,
	)
	bolt_wording = "bolt"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
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

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	spread = -1
	spread_unwielded = 48
	recoil = -3
	recoil_unwielded = 4
	wield_slowdown = 1
	wield_delay = 1.2 SECONDS

/obj/item/gun/ballistic/rifle/update_overlays()
	. = ..()
	. += "[icon_state]_bolt[bolt_locked ? "_locked" : ""]"

/obj/item/gun/ballistic/rifle/rack(mob/living/user)
	if (bolt_locked == FALSE)
		to_chat(user, "<span class='notice'>You open the bolt of \the [src].</span>")
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
		process_chamber(FALSE, FALSE, FALSE, shooter = user)
		bolt_locked = TRUE
		update_appearance()
		if (magazine && !magazine?.ammo_count() && empty_autoeject && !internal_magazine)
			eject_magazine(display_message = FALSE)
			update_appearance()
		return
	drop_bolt(user)

/obj/item/gun/ballistic/rifle/eject_magazine(mob/user, display_message = TRUE, obj/item/ammo_box/magazine/tac_load = null)
	if (!bolt_locked && empty_autoeject)
		to_chat(user, "<span class='notice'>The bolt is closed!</span>")
		return
	return ..()

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

/obj/item/gun/ballistic/rifle/illestren
	name = "\improper HP Illestren"
	desc = "A sturdy and conventional bolt-action rifle. One of Hunter's Pride's most successful firearms, the Illestren is popular among colonists, pirates, snipers, and countless others. Chambered in 8x50mmR."
	icon_state = "illestren"
	item_state = "illestren"
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'

	sawn_desc = "An Illestren rifle sawn down to a ridiculously small size. There was probably a reason it wasn't made this short to begin with, but it still packs a punch."
	eject_sound = 'sound/weapons/gun/rifle/vickland_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/vickland_unload.ogg'

	internal_magazine = FALSE
	default_ammo_type = /obj/item/ammo_box/magazine/illestren_a850r
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/illestren_a850r,
	)
	empty_autoeject = TRUE
	eject_sound_vary = FALSE
	can_be_sawn_off = TRUE
	manufacturer = MANUFACTURER_HUNTERSPRIDE

/obj/item/gun/ballistic/rifle/illestren/empty //i had to name it empty instead of no_mag because else it wouldnt work with guncases. sorry!
	default_ammo_type = FALSE

/obj/item/gun/ballistic/rifle/illestren/sawoff(forced = FALSE)
	. = ..()
	if(.)
		spread = 24
		spread_unwielded = 30
		item_state = "illestren_sawn"
		mob_overlay_state = item_state
		weapon_weight = WEAPON_MEDIUM //you can fire it onehanded, makes it worse than worse than useless onehanded, but you can

/obj/item/gun/ballistic/rifle/illestren/blow_up(mob/user)
	. = FALSE
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = TRUE

/obj/item/gun/ballistic/rifle/illestren/factory
	desc = "A sturdy and conventional bolt-action rifle. One of Hunter's Pride's most successful firearms, this example has been kept in excellent shape and may as well be fresh out of the workshop. Chambered in 8x50mmR."
	icon_state = "illestren_factory"
	item_state = "illestren_factory"

/obj/item/gun/ballistic/rifle/illestren/sawoff(forced = FALSE)
	. = ..()
	if(.)
		item_state = "illestren_factory_sawn"
		mob_overlay_state = item_state

/obj/item/gun/ballistic/rifle/illestren/sawn
	desc = "An Illestren rifle sawn down to a ridiculously small size. There was probably a reason it wasn't made this short to begin with, but it still packs a punch."
	sawn_off = TRUE

/obj/item/gun/ballistic/rifle/solgov
	name = "SSG-669C"
	desc = "A bolt-action sniper rifle used by Solarian troops. Beloved for its rotary design and accuracy. Chambered in 8x58mm Caseless."
	default_ammo_type = /obj/item/ammo_box/magazine/internal/boltaction/solgov
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/boltaction/solgov,
	)
	icon_state = "ssg669c"
	item_state = "ssg669c"
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
	recoil = 0
	recoil_unwielded = 4
	wield_slowdown = 1
	wield_delay = 1.3 SECONDS

/obj/item/gun/ballistic/rifle/scout
	name = "HP Scout"
	desc = "A powerful bolt-action rifle usually given to mercenary hunters of the Saint-Roumain Militia, equally suited for taking down big game or two-legged game. Chambered in .300 Magnum."
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'
	icon_state = "scout"
	item_state = "scout"

	default_ammo_type = /obj/item/ammo_box/magazine/internal/boltaction/smile
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/boltaction/smile,
	)
	fire_sound = 'sound/weapons/gun/rifle/scout.ogg'

	rack_sound = 'sound/weapons/gun/rifle/scout_bolt_out.ogg'
	bolt_drop_sound = 'sound/weapons/gun/rifle/scout_bolt_in.ogg'

	can_be_sawn_off = FALSE

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	manufacturer = MANUFACTURER_HUNTERSPRIDE

/obj/item/gun/ballistic/rifle/polymer
	name = "polymer survivor rifle"
	desc = "A bolt-action rifle made of scrap, desperation, and luck. Likely to shatter at any moment. Chambered in 7.62x40mm."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "crackhead_rifle"
	item_state = "crackhead_rifle"
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	default_ammo_type = /obj/item/ammo_box/magazine/internal/boltaction/polymer
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/boltaction/polymer,
	)
	can_be_sawn_off = FALSE
	manufacturer = MANUFACTURER_NONE
