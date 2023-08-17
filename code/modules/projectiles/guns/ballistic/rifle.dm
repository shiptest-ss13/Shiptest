/obj/item/gun/ballistic/rifle
	name = "Bolt Rifle"
	desc = "Some kind of bolt action rifle. You get the feeling you shouldn't have this."
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

///////////////////////
// BOLT ACTION RIFLE //
///////////////////////

/obj/item/gun/ballistic/rifle/boltaction
	name = "\improper Illestren Hunting Rifle"
	desc = "A point of pride for Hunter's Pride, this rifle is one of their most popular offerings. Despite its marketing, it is very rarely used for actual hunting and more often used for putting holes in people, for which it is even more popular for. Chambered in 7.62x54."
	sawn_desc = "An extremely sawn-off Illestren, popularly known as an \"obrez\". There was probably a reason it wasn't made this short to begin with."
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
	desc = "A bolt action sniper rifle used by the solarian army, beloved for its rotary design and accuracy. Chambered in 8x58mm Caseless."
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/solgov
	icon_state = "ssg669c"
	item_state = "ssg669c"
	fire_sound = 'sound/weapons/gun/rifle/ssg669c.ogg'
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/rifle/boltaction/roumain
	name = "standard-issue 'Smile' rifle"
	desc = "A bolt action rifle usually given to mercenary hunters of the Saint-Roumain Militia. Chambered in .300 Magnum."
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/smile
	icon_state = "roma"
	item_state = "roma"
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/rifle/boltaction/enchanted
	name = "enchanted bolt action rifle"
	desc = "Careful not to lose your head."
	var/guns_left = 30
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/enchanted
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/rifle/boltaction/enchanted/arcane_barrage
	name = "arcane barrage"
	desc = "Pew Pew Pew."
	fire_sound = 'sound/weapons/emitter.ogg'
	pin = /obj/item/firing_pin/magic
	icon = 'icons/obj/guns/projectile.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "arcane_barrage"
	item_state = "arcane_barrage"
	slot_flags = null
	can_bayonet = FALSE
	item_flags = NEEDS_PERMIT | DROPDEL | ABSTRACT | NOBLUDGEON
	flags_1 = NONE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/enchanted/arcane_barrage

/obj/item/gun/ballistic/rifle/boltaction/enchanted/dropped()
	. = ..()
	guns_left = 0

/obj/item/gun/ballistic/rifle/boltaction/enchanted/proc/discard_gun(mob/living/user)
	user.throw_item(pick(oview(7,get_turf(user))))

/obj/item/gun/ballistic/rifle/boltaction/enchanted/arcane_barrage/discard_gun(mob/living/user)
	qdel(src)

/obj/item/gun/ballistic/rifle/boltaction/enchanted/attack_self()
	return

/obj/item/gun/ballistic/rifle/boltaction/enchanted/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	. = ..()
	if(!.)
		return
	if(guns_left)
		var/obj/item/gun/ballistic/rifle/boltaction/enchanted/gun = new type
		gun.guns_left = guns_left - 1
		discard_gun(user)
		user.swap_hand()
		user.put_in_hands(gun)
	else
		user.dropItemToGround(src, TRUE)

/obj/item/gun/ballistic/rifle/boltaction/polymer
	name = "polymer survivor rifle"
	desc = "Chambered in .300 Blackout, and manufactured with cheap tools, this rifle has seen its share of part replacements, repairs, and bubba-hack-jobs to keep it serviceable."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "crackhead_rifle"
	item_state = "crackhead_rifle"
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/polymer
	can_be_sawn_off = FALSE
